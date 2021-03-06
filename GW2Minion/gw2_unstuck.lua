gw2_unstuck = {}
gw2_unstuck.stuckCount = 0
gw2_unstuck.stuckTimer = 0
gw2_unstuck.stuckPosition = nil
gw2_unstuck.antiStuckPos = nil
gw2_unstuck.lastPos = nil
gw2_unstuck.lastOnMeshTime = 0
gw2_unstuck.lastResult = false
gw2_unstuck.jumpCount = 0
gw2_unstuck.stuckthreshold = 45
gw2_unstuck.respawntimer = 0
gw2_unstuck.logoutTmr = 0
gw2_unstuck.useWaypointTmr = 0
gw2_unstuck.moveDirSet = {[GW2.MOVEMENTTYPE.Forward] = false, [GW2.MOVEMENTTYPE.Backward] = false, [GW2.MOVEMENTTYPE.Left] = false, [GW2.MOVEMENTTYPE.Right] = false,}
gw2_unstuck.slowConditions = "721,722,727,791,872" --Cripple, Chill, Immobilize, Fear, Stun. -- Needs more! (all debufs that slow you down.)
gw2_unstuck.AvoidanceAreas = {}
gw2_unstuck.Obstacles = {}

function gw2_unstuck.HandleStuck(mode)
-- MainThrottle
	if ( TimeSince(gw2_unstuck.stuckTimer) < 250 ) then
		return gw2_unstuck.lastResult
	end
	-- Update MainThrottle
	gw2_unstuck.stuckTimer = ml_global_information.Now

	-- Botmode Cannot be: Assist
	if (gBotMode == GetString("assistMode")) then
		gw2_unstuck.Reset()
		gw2_unstuck.lastResult = false
		return gw2_unstuck.lastResult
	end

	-- Player must be alive
	if ( not ml_global_information.Player_Alive ) then
		gw2_unstuck.Reset()
		gw2_unstuck.lastResult = false
		return gw2_unstuck.lastResult
	end

	-- Valid lastposition
	if 	(gw2_unstuck.lastPos == nil) or (gw2_unstuck.lastPos and type(gw2_unstuck.lastPos) ~= "table") then
		gw2_unstuck.lastPos = ml_global_information.Player_Position
		gw2_unstuck.lastResult = false
		return gw2_unstuck.lastResult
	end

	-- Dont handle stuck when we are jumping / falling
	if ( not ml_global_information.Player_CanMove ) then
		return gw2_unstuck.lastResult
	end

	-- Dont handle stuck when we cannot move because of some debuff
	if ( gw2_common_functions.HasBuffs(Player, gw2_unstuck.slowConditions) ) then
		gw2_unstuck.lastOnMeshTime = ml_global_information.Now
		gw2_unstuck.useWaypointTmr = ml_global_information.Now
		return gw2_unstuck.lastResult
	end

	-- PLAYER NOT ON MESH
	if ( not ml_global_information.Player_OnMesh ) then

		-- Check if a mesh is loaded
		local meshstate = NavigationManager:GetNavMeshState()
		if ( meshstate == GLOBAL.MESHSTATE.MESHEMPTY or meshstate == GLOBAL.MESHSTATE.MESHBUILDING ) then
			gw2_unstuck.lastResult = false
			return gw2_unstuck.lastResult
		end

		-- Throttle to compensate for situations where the player shortly leaves the mesh (jumping/getting kicked outside etc.)
		if ( TimeSince(gw2_unstuck.lastOnMeshTime) > 2000) then
			ml_log("Player not on Navmesh!")

			if ( mode == nil or mode == "combat") then
				-- if the bot is started not on the mesh try to walk back onto the mesh
				local p = NavigationManager:GetClosestPointOnMesh({ x=ml_global_information.Player_Position.x, y=ml_global_information.Player_Position.y, z=ml_global_information.Player_Position.z })
				--d(tostring(gw2_unstuck.lastOnMeshTime).." "..tostring(TimeSince(gw2_unstuck.lastOnMeshTime)).." "..tostring(p.distance))
				if ( (gw2_unstuck.lastOnMeshTime == 0 or TimeSince(gw2_unstuck.lastOnMeshTime) < 20000) and ValidTable(p) and p.distance > 0 and p.distance < 1000) then
					ml_log("Move blindly to nearby mesh")
					Player:SetFacingExact(p.x,p.y,p.z)
					Player:SetMovement(GW2.MOVEMENTTYPE.Forward)
					gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Forward] = true
					gw2_unstuck.HandleStuck_MovedDistanceCheck(mode)
					gw2_unstuck.HandleStuck_ControlManualMovement()
					gw2_unstuck.useWaypointTmr = ml_global_information.Now

				else
					-- we are not on or nearby the mesh
					-- Another timer to prevent hickups when the p above fails
					if ( TimeSince(gw2_unstuck.useWaypointTmr) > 15000 ) then
						gw2_unstuck.useWaypointTmr = ml_global_information.Now
						gw2_unstuck.HandleStuck_UseWaypoint()
					end

				end
				gw2_unstuck.lastResult = true
				return gw2_unstuck.lastResult

			elseif ( mode == "follow" ) then

				gw2_unstuck.HandleStuck_MovedDistanceCheck()
				gw2_unstuck.HandleStuck_ControlManualMovement()

			end
		end
	else

		-- PLAYER IS ON THE MESH
		-- If an AntistuckPos was set, go there
		if ( gw2_unstuck.antiStuckPos ~= nil and type(gw2_unstuck.antiStuckPos) == "table") then
			if ( ValidTable(NavigationManager:GetPath(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,gw2_unstuck.antiStuckPos.x,gw2_unstuck.antiStuckPos.y,gw2_unstuck.antiStuckPos.z))) then
				newnodecount = Player:MoveTo(gw2_unstuck.antiStuckPos.x,gw2_unstuck.antiStuckPos.y,gw2_unstuck.antiStuckPos.z,20,false,false,false)
				if ( newnodecount <= 0 ) then
					ml_error("Unstuck.lua: Cant move to antiStuckPos")
					gw2_unstuck.antiStuckPos = nil
				else
					gw2_unstuck.lastResult = true
				end
			end
		end


		gw2_unstuck.HandleStuck_MovedDistanceCheck(mode)
		gw2_unstuck.HandleStuck_ControlManualMovement()


		-- Update time when the player was on the mesh the last time
		gw2_unstuck.lastOnMeshTime = ml_global_information.Now
		gw2_unstuck.useWaypointTmr = ml_global_information.Now
	end


	gw2_unstuck.lastPos = ml_global_information.Player_Position

	return gw2_unstuck.lastResult
end

-- Checks the moved distance and performs different actions in order to handle stuck situations
gw2_unstuck.stuckPositionCount = 0
gw2_unstuck.lastGadgetID = nil
function gw2_unstuck.HandleStuck_MovedDistanceCheck(mode)

	local distmoved = 0
	-- calculate the moved distance depending on where we were stuck before or not
	if ( gw2_unstuck.stuckPosition ~= nil ) then
		distmoved = Distance2D ( ml_global_information.Player_Position.x, ml_global_information.Player_Position.y, gw2_unstuck.stuckPosition.x,  gw2_unstuck.stuckPosition.y)
		gw2_unstuck.stuckPositionCount = gw2_unstuck.stuckPositionCount + 1
	else
		distmoved = Distance2D ( ml_global_information.Player_Position.x, ml_global_information.Player_Position.y, gw2_unstuck.lastPos.x,  gw2_unstuck.lastPos.y)
		gw2_unstuck.stuckPositionCount = 0
	end
	if ( ml_global_information.ShowDebug ) then dbDistMoved = distmoved end


	if ( not ml_global_information.Player_IsMoving ) then
		if ( gw2_unstuck.stuckCount > 20 ) then
			d("HandleStuck_MovedDistanceCheck: Player not moving & stuckCount > 20")

		else
			--d("HandleStuck_MovedDistanceCheck: Player not moving")
		end
		gw2_unstuck.lastResult = false
		return
	end

	local StuckThreshOld = gw2_unstuck.stuckthreshold
	if ( mode == "combat" ) then StuckThreshOld = gw2_unstuck.stuckthreshold - 25 end

	if ( distmoved < StuckThreshOld ) then

		gw2_unstuck.stuckCount = gw2_unstuck.stuckCount + 1

		-- save this stuckposition
		if ( gw2_unstuck.stuckPosition == nil ) then
			gw2_unstuck.stuckPosition = ml_global_information.Player_Position
		end

		local stuckCountTreshold = 1
		if ( mode == "combat" ) then stuckCountTreshold = 3 end

		-- 	Try Jumping
		if ( gw2_unstuck.stuckCount > stuckCountTreshold ) then
			d("We are stuck.."..tostring(distmoved).. " < "..tostring(StuckThreshOld))
			if ( gw2_unstuck.stuckCount < 12) then

				-- check for doors n stuff
				if ( gw2_unstuck.stuckCount >=5 ) then
					local TList = ( GadgetList("nearest,selectable,alive,onmesh,maxdistance=250"))
					if (ValidTable(TList)) then
						local id, target  = next( TList )
						if ( id and target ) then
							if(gw2_unstuck.lastGadgetID == target.id) then
								d("Seems like we cant destroy this gadget")
								gw2_unstuck.stuckthreshold = 170
								table.insert(gw2_unstuck.AvoidanceAreas, { x=target.pos.x, y=target.pos.y, z=target.pos.z, r=(target.radius or 50) })

								d("Adding AvoidanceArea ...")
								NavigationManager:SetAvoidanceAreas(gw2_unstuck.AvoidanceAreas)
							else
								if(target.interactable and target.isInInteractRange and gw2_unstuck.stuckCount == 5) then
									d("Path-Blocking Object found, trying to interact with it...")
									return ml_log(Player:Interact(target.id))
								end

								if(gw2_unstuck.lastGadgetID ~= target.id) then
									gw2_unstuck.lastGadgetID = target.id
									if(target.attackable) then
										d("Path-Blocking Object found, trying to destroy it...")
										Player:StopMovement()
										-- Create new Subtask Combat
										local newTask = gw2_task_combat.Create()
										newTask.targetID = target.id
										newTask.targetType = "gadget"
										ml_task_hub:Add(newTask.Create(), IMMEDIATE_GOAL, TP_IMMEDIATE)
										return ml_log(Player:SetTarget(target.id))
									end
								end
							end
						end
					end
				end

				if ( gw2_unstuck.jumpCount <= 2 ) then
					gw2_unstuck.stuckthreshold = 65
					gw2_unstuck.jumpCount = gw2_unstuck.jumpCount + 1
					Player:Jump()

				elseif( gw2_unstuck.jumpCount <= 5 ) then
					d("Jump forward-sideways")
					gw2_unstuck.stuckthreshold = 125
					local dir = math.random(2,3)
					Player:SetMovement(dir)
					gw2_unstuck.moveDirSet[dir] = true
					gw2_unstuck.jumpCount = gw2_unstuck.jumpCount + 1
					Player:Jump()

				elseif( gw2_unstuck.jumpCount <= 7 ) then
					d("Jump forward-sideways")
					gw2_unstuck.stuckthreshold = 125
					local dir = math.random(4,5)
					gw2_unstuck.jumpCount = gw2_unstuck.jumpCount + 1
					Player:Evade(dir)

				else
					d("Jumping didnt help, setting avoidance area and walking somewhere else a bit")
					gw2_unstuck.stuckthreshold = 170
					table.insert(gw2_unstuck.AvoidanceAreas, { x=ml_global_information.Player_Position.x, y=ml_global_information.Player_Position.y, z=ml_global_information.Player_Position.z, r=50 })
					if ( gw2_unstuck.stuckPosition ~= nil ) then
						table.insert(gw2_unstuck.AvoidanceAreas, { x=gw2_unstuck.stuckPosition.x, y=gw2_unstuck.stuckPosition.y, z=gw2_unstuck.stuckPosition.z, r=50 })
					end
					d("Adding AvoidanceArea ...")
					NavigationManager:SetAvoidanceAreas(gw2_unstuck.AvoidanceAreas)
					Player:StopMovement()
					Player:SetMovement(GW2.MOVEMENTTYPE.Backward)
					gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Backward] = true
					ml_global_information.Wait( 2000 )
					Player:Jump()
				end

			elseif ( gw2_unstuck.stuckCount < 20) then
				d("stuckCount > 10 !! Get a random point and try to walk there")
				local p = NavigationManager:GetRandomPointOnCircle(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,50,650)
					if ( p) then
					if ( Distance3D(p.x,p.y,p.z,ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z) > 200) then
						d("New antistuck-randomposition set")
						gw2_unstuck.antiStuckPos = p
					end
				end
			elseif ( gw2_unstuck.stuckCount < 25 ) then
			
				-- Check if an obstacle at this pos exists already 
				for _,o in pairs(gw2_unstuck.Obstacles) do 
					if ( Distance3D(o.x,o.y,o.z,ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z) < 50 ) then
						d("Obstacle exists already at that position")
						return
					end
				end
				
				table.insert(gw2_unstuck.Obstacles, { x=ml_global_information.Player_Position.x, y=ml_global_information.Player_Position.y, z=ml_global_information.Player_Position.z, r=120, t=ml_global_information.Now })
				d("Adding new Obstacle for navigating around the stuck")
				NavigationManager:AddNavObstacle(gw2_unstuck.Obstacles)
				Player:StopMovement()
				Player:SetMovement(GW2.MOVEMENTTYPE.Backward)
				gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Backward] = true
				ml_global_information.Wait( 2000 )
				Player:Jump()

			else
				d("We are really really stuck this time...")
				gw2_unstuck.HandleStuck_UseWaypoint()
			end
		end

	else
		--if ( ml_global_information.Player_OnMesh ) then
			gw2_unstuck.Reset()
			gw2_unstuck.lastResult = false

		--end
	end

end

-- Tries to stop the player from moving offside the mesh in case of "manual" antistuck movement
function gw2_unstuck.HandleStuck_ControlManualMovement()
	if ( ml_global_information.Player_MovementDirections.backward or ml_global_information.Player_MovementDirections.left or ml_global_information.Player_MovementDirections.right ) then
		if ( ml_global_information.Player_MovementDirections.backward and not Player:CanMoveDirection(0,75) ) then Player:UnSetMovement(1) end
		if ( ml_global_information.Player_MovementDirections.left and not ml_global_information.Player_MovementDirections.backward and not ml_global_information.Player_MovementDirections.forward and not Player:CanMoveDirection(6,75) ) then Player:UnSetMovement(2) end
		if ( ml_global_information.Player_MovementDirections.right and not ml_global_information.Player_MovementDirections.backward and not ml_global_information.Player_MovementDirections.forward and not Player:CanMoveDirection(7,75) ) then Player:UnSetMovement(3) end
		if ( ml_global_information.Player_MovementDirections.left and ml_global_information.Player_MovementDirections.backward and not Player:CanMoveDirection(1,75) ) then Player:UnSetMovement(2) end
		if ( ml_global_information.Player_MovementDirections.right and ml_global_information.Player_MovementDirections.backward and not Player:CanMoveDirection(2,75) ) then Player:UnSetMovement(3) end
		if ( ml_global_information.Player_MovementDirections.left and ml_global_information.Player_MovementDirections.forward and not Player:CanMoveDirection(4,75) ) then Player:UnSetMovement(2) end
		if ( ml_global_information.Player_MovementDirections.right and ml_global_information.Player_MovementDirections.forward and not Player:CanMoveDirection(5,75) ) then Player:UnSetMovement(3) end
	end
end

-- Using a waypoint to handle stuck situations
function gw2_unstuck.HandleStuck_UseWaypoint()

	-- closest WP to partymembers ?

	if ( ml_global_information.Now - gw2_unstuck.respawntimer < 30000 ) then
		ml_error("We already used a Waypoint for unstuck within the last 30 seconds already but are stuck again !?")
		ml_error("Stopping bot...")
		gw2minion.ToggleBot()
			--ExitGW()
	else
		if ( not ml_global_information.Player_InCombat ) then
			if ( Inventory:GetInventoryMoney() < 300 ) then
				ml_log("We may not have enough money for using a waypoint anymore...")
			end
			d("Trying to teleport to nearest Waypoint for unstuck..")
			-- safetycheck
			local WList = WaypointList("nearest,onmesh,notcontested,samezone")
			if ( ValidTable(WList) ) then
				local id,wp = next(WList)
				if ( id and wp and wp.distance > 500 ) then
					if ( Player:RespawnAtClosestWaypoint() ) then
						gw2_unstuck.respawntimer = ml_global_information.Now
					end
				else
					ml_error("We are at a waypoint but need to teleport again!? Something weird is going on, stopping bot")
					d("Logging out...")
					Player:Logout()
				end
			end
			ml_global_information.Wait(3000)
			gw2_unstuck.logoutTmr = 0
		else
			if ( gw2_unstuck.logoutTmr == 0 ) then
				gw2_unstuck.logoutTmr = ml_global_information.Now
			elseif ( ml_global_information.Now - gw2_unstuck.logoutTmr > 60000 ) then --and gAutostartbot == "1" ) then
				gw2_unstuck.logoutTmr = ml_global_information.Now
				d("60 seconds in combat but we need to use a waypoint, logging out...")
				Player:Logout()
			end

			d("Seems we are still in combat, cant use waypoint..TimeLeft till logout: "..tostring(60000 - (ml_global_information.Now - gw2_unstuck.logoutTmr)))
			-- TODO: ADD SIMPLE COMBAT
			--[[if ( c_NeedValidTarget:evaluate() ) then
				e_SearchTarget:execute()
			else
				e_KillTarget:execute()
			end]]
		end
	end
end

function gw2_unstuck.Start()
	gw2_unstuck.lastPos = ml_global_information.Player_Position
	gw2_unstuck.lastOnMeshTime = ml_global_information.Now
	gw2_unstuck.stuckTimer = ml_global_information.Now
end

function gw2_unstuck.Reset()
	gw2_unstuck.lastPos = ml_global_information.Player_Position
	gw2_unstuck.stuckCount = 0
	gw2_unstuck.antiStuckPos = nil
	gw2_unstuck.stuckPosition = nil
	gw2_unstuck.jumpCount = 0
	gw2_unstuck.stuckthreshold = 45
	gw2_unstuck.respawntimer = 0
	gw2_unstuck.useWaypointTmr = ml_global_information.Now
	gw2_unstuck.lastGadgetID = nil
	if ( ml_global_information.Player_IsMoving and ml_global_information.Player_CanMove) then
		if ( ml_global_information.Player_MovementDirections.backward and gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Backward] ) then gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Backward] = false Player:UnSetMovement(GW2.MOVEMENTTYPE.Backward) end
		if ( ml_global_information.Player_MovementDirections.left and gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Left] ) then gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Left] = false Player:UnSetMovement(GW2.MOVEMENTTYPE.Left) end
		if ( ml_global_information.Player_MovementDirections.right and gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Right] ) then gw2_unstuck.moveDirSet[GW2.MOVEMENTTYPE.Right] = false Player:UnSetMovement(GW2.MOVEMENTTYPE.Right) end
	end
end


function gw2_unstuck.ModuleInit()
	d("gw2_unstuck:ModuleInit")

	-- Setup Debug fields
	local dw = WindowManager:GetWindow(gw2minion.DebugWindow.Name)
	if ( dw ) then
		dw:NewField("PathNodes","dbPNodes","Task_MoveTo")
		dw:NewField("LastPathNodes","dbPNodesLast","Task_MoveTo")
		dw:NewField("PathStoppingDist","dbPStopDist","Task_MoveTo")
		dw:NewField("TargetPos","dbTPos","Task_MoveTo")
		dw:NewField("TargetDist","dbTDist","Task_MoveTo")
		dw:NewField("TargetID","dbTID","Task_MoveTo")
		dw:NewField("StuckCount","dbStuckCount","Task_MoveTo")
		dw:NewField("StuckTmr","dbStuckTmr","Task_MoveTo")
		dw:NewField("DistMoved","dbDistMoved","Task_MoveTo")
		dw:NewField("lastOnMeshTime","dbLastOnMesh","Task_MoveTo")
		dw:NewField("StuckRandomPos","dbStuckRPos","Task_MoveTo")
		dw:NewField("JumpCount","dbJumpCount","Task_MoveTo")
	end
end

RegisterEventHandler("Module.Initalize",gw2_unstuck.ModuleInit)