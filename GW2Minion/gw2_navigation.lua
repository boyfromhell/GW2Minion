-- Extends minionlib's ml_navigation.lua by adding the game specific navigation handler

-- Handles the Navigation along the current Path. Is not supposed to be called manually.
function ml_navigation.Navigate(event, ticks )	
	
	if ((ticks - (ml_navigation.lastupdate or 0)) > 100) then 
		ml_navigation.lastupdate = ticks
				
		if ( ml_navigation.CanRun() ) then				
			local ppos = Player.pos
			
			-- Normal Navigation Mode
			if ( ml_navigation.pathsettings.navigationmode == 1 ) then
				
				if ( table.valid(ml_navigation.path) and table.size(ml_navigation.path) > ml_navigation.pathindex ) then					
					local nextnode = ml_navigation.path[ ml_navigation.pathindex ]
					
					-- Ensure Position: Takes a second to make sure the player is really stopped at the wanted position (used for precise OMC bunnyhopping)
					if ( table.valid (ml_navigation.ensureposition) and ml_navigation:EnsurePosition() ) then						
						return
					end
					
-- OffMeshConnection Navigation
					if (nextnode.type == "OMC_END") then
						if ( nextnode.id == nil ) then ml_error("[Navigation] - No OffMeshConnection ID received!") return end
						local omc = ml_mesh_mgr.offmeshconnections[nextnode.id]
						if( not omc ) then ml_error("[Navigation] - No OffMeshConnection Data found for ID: "..tostring(nextnode.id)) return end
							
						-- A general check, for the case that the player never reaches either OMC END
						if ( not ml_navigation.omc_id or ml_navigation.omc_id ~= nextnode.id ) then	-- Update the currently tracked omc_id and variables
							ml_navigation.omc_id = nextnode.id
							ml_navigation.omc_traveltimer = ticks
							ml_navigation.omc_traveldist = math.distance3d(ppos,nextnode)
						else	-- We are still pursuing the same omc, check if we are getting closer over time
							local timepassed = ticks - ml_navigation.omc_traveltimer
							if ( timepassed < 3000) then 
								local dist = math.distance3d(ppos,nextnode)
								if ( timepassed > 2000 and ml_navigation.omc_traveldist > dist) then
									ml_navigation.omc_traveldist = dist
									ml_navigation.omc_traveltimer = ticks
								end
							else
								d("[Navigation] - Not getting closer to OMC END node. We are most likely stuck.")
								ml_navigation.StopMovement()
								return
							end								
						end
							
						-- Max Timer Check in case something unexpected happened
						if ( ml_navigation.omc_starttimer ~= 0 and ticks - ml_navigation.omc_starttimer > 10000 ) then
							d("[Navigation] - Could not read OMC END in ~10 seconds, something went wrong..")
							ml_navigation.StopMovement()
							return
						end
								
						-- OMC Handling by Type
						if ( omc.type == 1 ) then
							-- OMC JUMP										
							local movementstate = Player:GetMovementState()	
							
							if ( movementstate == GW2.MOVEMENTSTATE.Jumping) then
								if ( not ml_navigation.omc_startheight ) then ml_navigation.omc_startheight = ppos.z end
								-- Additionally check if we are "above" the target point already, in that case, stop moving forward
								local nodedist = ml_navigation:GetRaycast_Player_Node_Distance(ppos,nextnode)
								if ( nodedist < ml_navigation.OMCREACHEDDISTANCE) then
									d("[Navigation] - We are above the OMC_END Node, stopping movement. ("..tostring(math.round(nodedist,2)).." < "..tostring(ml_navigation.OMCREACHEDDISTANCE)..")")
									Player:Stop()
									if ( omc.precise == nil or omc.precise == true  ) then
										ml_navigation:SetEnsurePosition(nextnode)
									end									
								else									
									Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
									Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)
								end
								
							elseif ( movementstate == GW2.MOVEMENTSTATE.Falling and ml_navigation.omc_startheight) then
								-- If Playerheight is lower than 4*omcreached dist AND Playerheight is lower than 4* our Startposition -> we fell below the OMC START & END Point
								if (( ppos.z > (nextnode.z + 4*ml_navigation.OMCREACHEDDISTANCE)) and ( ppos.z > ( ml_navigation.omc_startheight + 4*ml_navigation.OMCREACHEDDISTANCE))) then
									if ( ml_navigation.omcteleportallowed and math.distance3d(ppos,nextnode) < ml_navigation.OMCREACHEDDISTANCE*10) then
										ml_navigation:SetEnsurePosition(nextnode) 
									else
										d("[Navigation] - We felt below the OMC start & END height, missed our goal...")
										ml_navigation.StopMovement()
									end
								else
									-- Additionally check if we are "above" the target point already, in that case, stop moving forward
									local nodedist = ml_navigation:GetRaycast_Player_Node_Distance(ppos,nextnode)
									if ( nodedist < ml_navigation.OMCREACHEDDISTANCE) then
										d("[Navigation] - We are above the OMC END Node, stopping movement. ("..tostring(math.round(nodedist,2)).." < "..tostring(ml_navigation.OMCREACHEDDISTANCE)..")")
										Player:Stop()
										if ( omc.precise == nil or omc.precise == true  ) then
											ml_navigation:SetEnsurePosition(nextnode)											
										end									
									else									
										Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
										Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)
									end
								end
								
							else	 
								-- We are still before our Jump
								if ( not ml_navigation.omc_startheight ) then
									if ( Player:CanMove() and ml_navigation.omc_starttimer == 0 ) then
										ml_navigation.omc_starttimer = ticks
										Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
										Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)
									elseif ( Player:IsMoving() and ticks - ml_navigation.omc_starttimer > 100 ) then
										Player:Jump()
									end
									
								else
									-- We are after the Jump and landed already
									local nodedist = ml_navigation:GetRaycast_Player_Node_Distance(ppos,nextnode)
									if ( nodedist < ml_navigation.OMCREACHEDDISTANCE) then
										d("[Navigation] - We reached the OMC END Node. ("..tostring(math.round(nodedist,2)).." < "..tostring(ml_navigation.OMCREACHEDDISTANCE)..")")
										if ( omc.precise == nil or omc.precise == true ) then
											ml_navigation:SetEnsurePosition(nextnode)
										end
										ml_navigation.pathindex = ml_navigation.pathindex + 1
									else									
										Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
										Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)
									end
								end
							end								
									
						elseif ( omc.type == 2 ) then
							ml_navigation:NavigateToNode(ppos,nextnode,1000)
										
						elseif ( omc.type == 3 ) then
						-- OMC Teleport
							HackManager:Teleport(nextnode.x,nextnode.y,nextnode.z)
							ml_navigation.pathindex = ml_navigation.pathindex + 1
							
						elseif ( omc.type == 4 ) then
						-- OMC Interact
							Player:Interact()
							ml_navigation.lastupdate = ml_navigation.lastupdate + 1000
							ml_navigation.pathindex = ml_navigation.pathindex + 1
						
						elseif ( omc.type == 5 ) then
						-- OMC Portal
							ml_navigation:NavigateToNode(ppos,nextnode,2000)
						
						elseif ( omc.type == 6 ) then
						-- OMC Lift
							ml_navigation:NavigateToNode(ppos,nextnode,1500)						
																
						end						
						
					elseif (string.contains(nextnode.type,"CUBE")) then
-- Cube Navigation	
					
						-- Check if we left our path
						if ( not ml_navigation:IsStillOnPath(ppos,ml_navigation.pathsettings.pathdeviationdistance) ) then return end
				
						-- Check if the next node is reached:
						local dist3D = math.distance3d(nextnode,ppos)
						if ( dist3D < ml_navigation.pathsettings.navpointreacheddistance*1.5) then
							-- We reached the node
							d("[Navigation] - Cube Node reached. ("..tostring(math.round(dist3D,2)).." < "..tostring(ml_navigation.pathsettings.navpointreacheddistance*1.5)..")")
							ml_navigation.pathindex = ml_navigation.pathindex + 1							
						else						
							-- We have not yet reached our node
							local dist2D = math.distance2d(nextnode,ppos)
							if ( dist2D < ml_navigation.pathsettings.navpointreacheddistance*1.5 ) then
								-- We are on the correct horizontal position, but our goal is now either above or below us
								-- compensate for the fact that the char is always swimming on the surface between 0 - 50 @height
								local pHeight = ppos.z
								if ( nextnode.z < 50 ) then pHeight = nextnode.z end -- if the node is in shallow water (<50) , fix the playerheight at this pos. Else it gets super wonky at this point.
								local distH = math.abs(math.abs(pHeight) - math.abs(nextnode.z))
								
								if ( distH > ml_navigation.pathsettings.navpointreacheddistance ) then							
									-- Move Up / Down only until we reached the node
									Player:StopHorizontalMovement()
									if ( pHeight > nextnode.z ) then	-- minus is "up" in gw2
										Player:SetMovement(GW2.MOVEMENTTYPE.SwimUp)
									else							
										Player:SetMovement(GW2.MOVEMENTTYPE.SwimDown)
									end
									
								else
									-- We have a good "height" position already, let's move a bit more towards the node on the horizontal plane
									Player:StopVerticalMovement()
									Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)						
									Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
								end	
								
							else
								Player:StopVerticalMovement()
								Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)						
								Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
							end
						end
-- CUBE Navigation END					
					else
-- Normal Ground Navigation							
						ml_navigation:NavigateToNode(ppos,nextnode)
-- Normal Ground Navigation END

					end
				else
					d("[Navigation] - Path end reached.")
					ml_navigation.StopMovement()
				end
				
			elseif (ml_navigation.pathsettings.navigationmode == 2 ) then
				d("Addd  other navmodes...?")
					
			end
		end
	end
end
RegisterEventHandler("Gameloop.Draw", ml_navigation.Navigate)
	
-- Used by multiple places in the Navigate() function, so I'll put it here again...no redudant code...
function ml_navigation:NavigateToNode(ppos, nextnode, stillonpaththreshold)
	-- Check if we left our path
	if ( stillonpaththreshold ) then
		if ( not ml_navigation:IsStillOnPath(ppos,stillonpaththreshold) ) then return end	
	else
		if ( not ml_navigation:IsStillOnPath(ppos,ml_navigation.pathsettings.pathdeviationdistance) ) then return end	
	end
					
	-- Check if the next node is reached
	local nodedist = ml_navigation:GetRaycast_Player_Node_Distance(ppos,nextnode)
	if ( nodedist < ml_navigation.pathsettings.navpointreacheddistance ) then
		d("[Navigation] - Node reached. ("..tostring(math.round(nodedist,2)).." < "..tostring(ml_navigation.pathsettings.navpointreacheddistance)..")")
							
		-- We arrived at an OMC Node
		if ( string.contains(nextnode.type,"OMC")) then
			ml_navigation:ResetOMCHandler()
			if ( nextnode.id == nil ) then ml_error("[Navigation] - No OffMeshConnection ID received!") return end
			local omc = ml_mesh_mgr.offmeshconnections[nextnode.id]
			if( not omc ) then ml_error("[Navigation] - No OffMeshConnection Data found for ID: "..tostring(nextnode.id)) return end
			if ( omc.precise == nil or omc.precise == true ) then	
				ml_navigation:SetEnsurePosition(nextnode) 
			end			
		end
		ml_navigation.pathindex = ml_navigation.pathindex + 1
	else						
		-- We have not yet reached our node
		local anglediff = math.angle({x = ppos.hx, y = ppos.hy,  z = 0}, {x = nextnode.x-ppos.x, y = nextnode.y-ppos.y, z = 0})															
		if ( ml_navigation.pathsettings.smoothturns and anglediff < 75 and nodedist > 2*ml_navigation.pathsettings.navpointreacheddistance ) then
			Player:SetFacing(nextnode.x,nextnode.y,nextnode.z)
		else
			Player:SetFacingExact(nextnode.x,nextnode.y,nextnode.z,true)
		end							
		Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
	end
end


-- Calculates the Point-Line-Distance between the PlayerPosition and the last and the next PathNode. If it is larger than the treshold, it returns false, we left our path.
function ml_navigation:IsStillOnPath(ppos,deviationthreshold)	
	if ( ml_navigation.pathindex > 0 ) then
		local movstate = Player:GetMovementState() 
		if ( not (movstate == GW2.MOVEMENTSTATE.Jumping or movestate == GW2.MOVEMENTSTATE.Falling) and math.distancepointline(ml_navigation.path[ml_navigation.pathindex-1],ml_navigation.path[ml_navigation.pathindex],ppos) > deviationthreshold) then			
			d("[Navigation] - Player not on Path anymore. - Distance to Path: "..tostring(math.distancepointline(ml_navigation.path[ml_navigation.pathindex-1],ml_navigation.path[ml_navigation.pathindex],ppos)).." > "..tostring(deviationthreshold))
			ml_navigation.StopMovement()
			return false
		end
	end
	return true
end

-- Tries to use RayCast to determine the exact floor height from Player and Node, and uses that to calculate the correct distance.
function ml_navigation:GetRaycast_Player_Node_Distance(ppos,node)
	-- Raycast from "top to bottom" @PlayerPos and @NodePos
	local P_hit, P_hitx, P_hity, P_hitz   = RayCast(ppos.x,ppos.y,ppos.z-100,ppos.x,ppos.y,ppos.z+100,0) 
	local N_hit, N_hitx, N_hity, N_hitz = RayCast(node.x,node.y,node.z-100,node.x,node.y,node.z+100,0) 
	local dist = math.distance3d(ppos,node)
	if (P_hit and N_hit ) then 
		local raydist = math.distance3d(P_hitx, P_hity, P_hitz , N_hitx, N_hity, N_hitz)
		if (raydist < dist) then 
			return raydist
		end
	end
	return dist
end

-- Sets the position and heading which the main call will make sure that it has before continuing the movement
function ml_navigation:SetEnsurePosition(node, isstartnode)
	Player:Stop()
	ml_navigation.ensureposition = {x = node.x, y = node.y, z = node.z}										
	if ( table.size(ml_navigation.path) > ml_navigation.pathindex+1 ) then
		node = ml_navigation.path[ ml_navigation.pathindex+1 ]		
		ml_navigation.ensureheading = {x = node.x, y = node.y, z = node.z}	-- Face Next Node
	else
		ml_navigation.ensureheading = {x = node.x, y = node.y, z = node.z}	-- Fallback case
	end
	ml_navigation:EnsurePosition()
end

-- Ensures that the player is really at a specific position, stopped and facing correctly
function ml_navigation:EnsurePosition()
	if ( not ml_navigation.ensurepositionstarttime ) then ml_navigation.ensurepositionstarttime = ml_global_information.Now end
	if ( (ml_global_information.Now - ml_navigation.ensurepositionstarttime) < 750 ) then		
		if ( Player:IsMoving () ) then Player:Stop() end
		local ppos = Player.pos
		local dist = ml_navigation:GetRaycast_Player_Node_Distance(ppos,ml_navigation.ensureposition)
						
		if ( dist > 5 and ml_navigation.omcteleportallowed ) then
			HackManager:Teleport(ml_navigation.ensureposition.x,ml_navigation.ensureposition.y,ml_navigation.ensureposition.z)
		end
		if ( math.angle({x = ppos.hx, y = ppos.hy,  z = 0}, {x = ml_navigation.ensureheading.x-ppos.x, y = ml_navigation.ensureheading.y-ppos.y, z = 0}) > 5 ) then 
			Player:SetFacingExact(ml_navigation.ensureheading.x,ml_navigation.ensureheading.y,ml_navigation.ensureheading.z,true) 
		end
		return true
	else	-- We waited long enough
		ml_navigation.ensureposition = nil
		ml_navigation.ensureheading = nil
		ml_navigation.ensurepositionstarttime = nil
	end
	return false
end


-- Resets all OMC related variables
function ml_navigation:ResetOMCHandler()
	self.omc_id = nil
	self.omc_traveltimer = nil
	self.ensureposition = nil
	self.ensureheading = nil
	self.ensurepositionstarttime = nil
	self.omc_starttimer = 0
	self.omc_startheight = nil	
end
	
	
-- for replacing the original c++ navi with our lua version
function NavigationManager:MoveTo(x, y, z, crap, navigationmode, randomnodes, smoothturns)
	return ml_navigation:MoveTo(x, y, z, navigationmode, randomnodes, smoothturns)
end
function Player:StopMovement()
	ml_navigation:ResetCurrentPath()
	ml_navigation:ResetOMCHandler()
	Player:Stop()
end