gw2_common_cne = {}


-- Handle Death by waiting for rezz & respawn at nearest Waypoint
c_Dead = inheritsFrom( ml_cause )
e_Dead = inheritsFrom( ml_effect )
c_Dead.lastHealth = nil
c_Dead.deadTmr = 0
function c_Dead:evaluate()
	if ( Player.healthstate == GW2.HEALTHSTATE.Defeated ) then
		return true
	end
	c_Dead.deadTmr = 0
	return false
end
function e_Dead:execute()
	ml_log("e_Dead")
	-- check for partymember who can raise us
	local party = ml_global_information.Player_Party
	local found = false
	if ( TableSize(party) > 1 ) then
		local idx,pmember = next(party)
		while (idx and pmember) do
			if ( pmember.id ~= 0 ) then
				local char = CharacterList:Get(pmember.id)
				if ( char ) then
					local cPos = char.pos
					if ( cPos and Distance2D ( ml_global_information.Player_Position.x, ml_global_information.Player_Position.y, cPos.x, cPos.y) < 4000 and char.dead == false) then
						found = true
						break
					end
				end
			end
			idx,pmember=next(party,idx)
		end
	end
	-- Check for nearby Players who can rezz us
	if ( found == false ) then
		if ( TableSize(CharacterList("nearest,alive,friendly,player,maxdistance=1200"))>0 ) then
			found = true
		end
	end

	if ( ( not found and TimeSince(c_Dead.deadTmr) > 5000) or TimeSince(c_Dead.deadTmr) > 30000 ) then -- wait a bit longer for other ppl to rezz us if they are around

		if ( c_Dead.deadTmr == 0 or c_Dead.lastHealth == nil or c_Dead.lastHealth < ml_global_information.Player_Health.current ) then
			c_Dead.lastHealth = ml_global_information.Player_Health.current
			c_Dead.deadTmr = ml_global_information.Now
				if (c_Dead.lastHealth ~= 0) then
				c_Dead.deadTmr = ml_global_information.Now + 10000
			end
			ml_log( "Dead: We are beeing revived...waiting a bit longer " )

		elseif ( c_Dead.deadTmr ~= 0 and c_Dead.lastHealth ~= nil ) then
			c_Dead.lastHealth = nil
			c_Dead.deadTmr = 0
			d( "Dead: RESPAWN AT NEAREST WAYPOINT " )
			d( Player:RespawnAtClosestWaypoint() )
			ml_global_information.Stop()
			ml_global_information.Reset() -- clear queues here ?
		end
	end
end


-- Handle Downed state, heal and attack nearby aggro targets
c_Downed = inheritsFrom( ml_cause )
e_Downed = inheritsFrom( ml_effect )
e_DownedEmpty = inheritsFrom( ml_effect )
function c_Downed:evaluate()
	return Player.healthstate == GW2.HEALTHSTATE.Downed
end
function e_DownedEmpty:execute()
-- simple placeholder for other tasks so they are not doing anything while we are down
end
function e_Downed:execute()
	ml_log("e_Downed")

	Player:StopMovement()

	local target = gw2_common_functions.GetBestAggroTarget(true)

	if ( ValidTable( target ) ) then
		local currentTarget = Player:GetTarget()
		if ( not currentTarget or currentTarget.id ~= target.id ) then
			Player:SetTarget(target.id)
		end
		gw2_skill_manager:Use( target.id )
		return ml_log(true)
	else
		-- Heal
		if ( Player.castinfo.duration == 0 ) then
			Player:CastSpell( GW2.SKILLBARSLOT.Slot_4 )
			ml_global_information.Wait(500)
		end
	end

end


c_RezzPartyMember = inheritsFrom( ml_cause )
e_RezzPartyMember = inheritsFrom( ml_effect )
e_RezzPartyMember.targetID = nil
function c_RezzPartyMember:evaluate()
	local party = ml_global_information.Player_Party
	if (ValidTable(party)) then
		for _,pMember in pairs(party) do
			local target = CharacterList:Get(pMember.id)
			if (ValidTable(target) and target.onmesh and (target.downed == true or target.dead == true) and ml_global_information.Player_Health.percent > 35 and target.pathdistance < 4000) then
				e_RezzPartyMember.targetID = target.id
				return true
			end
		end
	end
	e_RezzPartyMember.targetID = nil
	return false
end
function e_RezzPartyMember:execute()
	ml_log("e_RezzPartyMember")
	if ( e_RezzPartyMember.targetID ) then
		local target = CharacterList:Get(e_RezzPartyMember.targetID)
		if (ValidTable(target)) then
			if (not target.isInInteractRange) then
				-- MoveIntoInteractRange
				local tPos = target.pos
				if ( tPos ) then
					local newTask = gw2_task_moveto.Create()
					newTask.targetPos = tPos
					newTask.targetID = target.id
					newTask.targetType = "character"
					newTask.name = "MoveTo Revive PartyMember"
					ml_task_hub:CurrentTask():AddSubTask(newTask)
					ml_log("MoveToDownedPartyMember..")
					return ml_log(true)
				end
			else -- Grab that thing
				if ( ml_global_information.Player_IsMoving == true ) then Player:StopMovement() end
				gw2_common_functions.NecroLeaveDeathshroud()
				local t = Player:GetTarget()
				if ( not t or t.id ~= target.id ) then
					Player:SetTarget(target.id)
				else
					ml_log("Rezzing PartyMember..")
					Player:Interact(target.id)
					ml_global_information.Wait(1000)
					return ml_log(true)
				end
			end
		end
	end
end
-- used for example in task_grind Overwatch when running a subtask moveto which brings the player to the target that should be rezzed
c_RezzOverWatchCheck = inheritsFrom( ml_cause )
e_RezzOverWatchCheck = inheritsFrom( ml_effect )
function c_RezzOverWatchCheck:evaluate()
	if ( ml_task_hub:CurrentTask() ~= nil and ( ml_task_hub:CurrentTask().name == "MoveTo Revive NPC" or ml_task_hub:CurrentTask().name == "MoveTo Revive Downed Player" or ml_task_hub:CurrentTask().name == "MoveTo Revive PartyMember") and ml_task_hub:CurrentTask().targetPos ~= nil and ml_task_hub:CurrentTask().targetID ~= nil ) then

		local dist = Distance3D(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,ml_task_hub:CurrentTask().targetPos.x,ml_task_hub:CurrentTask().targetPos.y,ml_task_hub:CurrentTask().targetPos.z)
		if ( dist < 5000 ) then
			local character = CharacterList:Get(ml_task_hub:CurrentTask().targetID)
			if ( character ~= nil and character.alive) then
				return true
			end
		end

	end
	return false
end
function e_RezzOverWatchCheck:execute()
	-- the subtask moveto should be automatically be deleted once we are here, so we do nothing..
	ml_log("e_RezzOverWatchCheck")
end

c_reviveDownedPlayersInCombat = inheritsFrom( ml_cause )
e_reviveDownedPlayersInCombat = inheritsFrom( ml_effect )
e_reviveDownedPlayersInCombat.targetID = nil
function c_reviveDownedPlayersInCombat:evaluate()
	if ( gRevivePlayers == "1" and ml_global_information.Player_Health.percent > 50 ) then
		local targetList = CharacterList("shortestpath,selectable,interactable,downed,friendly,player,onmesh,maxdistance=2000")
		if (ValidTable(targetList)) then
			for _,target in pairs(targetList) do
				if (ValidTable(target)) then
					e_reviveDownedPlayersInCombat.targetID = target.id
					return true
				end
			end
		end
	end
	e_reviveDownedPlayersInCombat.targetID = nil
	return false
end
function e_reviveDownedPlayersInCombat:execute()
	ml_log("e_reviveDownedPlayersInCombat")
	if (e_reviveDownedPlayersInCombat.targetID) then
		local target = CharacterList:Get(e_reviveDownedPlayersInCombat.targetID)
		if (ValidTable(target)) then
			if (not target.isInInteractRange) then
				-- MoveIntoInteractRange
				local tPos = target.pos
				if ( tPos ) then
					local newTask = gw2_task_moveto.Create()
					newTask.targetPos = tPos
					newTask.targetID = target.id
					newTask.targetType = "character"
					newTask.name = "MoveTo Revive Downed Player" -- giving it a special name so the overwatch knows when to kick in
					ml_task_hub:CurrentTask():AddSubTask(newTask)
					ml_log("MoveToDownedPartyMember..")
					return ml_log(true)
				end
			else -- Grab that thing
				if ( ml_global_information.Player_IsMoving ) then Player:StopMovement() end
				gw2_common_functions.NecroLeaveDeathshroud()
				local t = Player:GetTarget()
				if (not t or t.id ~= target.id) then
					Player:SetTarget(target.id)
				else
					ml_log("Reviving..")
					Player:Interact(target.id)
					ml_global_information.Wait(1000)
					return true
				end
			end
		end
	end
	return ml_log(false)
end

------------
c_reviveNPC = inheritsFrom( ml_cause )
e_reviveNPC = inheritsFrom( ml_effect )
function c_reviveNPC:evaluate()
	if (gRevive == "1" and TableSize(CharacterList("nearest,selectable,interactable,dead,friendly,npc,onmesh,maxdistance=2000,exclude="..ml_blacklist.GetExcludeString(GetString("monsters")))) > 0)then
		return true
	end
	return false
end
function e_reviveNPC:execute()
	ml_log("ReviveNPC ")

	-- fight nearby enemies first
	if ( ml_global_information.Player_Health.percent < 80 ) then
		local TargetList = CharacterList("aggro,onmesh,lowesthealth,los,attackable,alive,noCritter,exclude_contentid="..ml_blacklist.GetExcludeString(GetString("monsters")))
		if ( TargetList ) then
			local id,entry = next(TargetList)
			if (id and entry ) then
				ml_log(" Killing nearby targets first..")
				gw2_skill_manager:Use(entry.id) -- we should create a combat task here ...
				return ml_log(true)
			end
		end
	end

	if ( Player.castinfo.duration ~= 0 ) then
		ml_log("Reviving NPC...")
		ml_global_information.Wait(1000)
		return ml_log(true)
	end

	local CList = CharacterList("shortestpath,selectable,interactable,dead,friendly,npc,onmesh,maxdistance=2500,exclude="..ml_blacklist.GetExcludeString(GetString("monsters")))
	if ( TableSize(CList) > 0 ) then
		local id,target = next(CList)
		if ( id and target ) then

			if ( not target.isInInteractRange ) then

				Player:StopMovement()
				local newTask = gw2_task_moveto.Create()
				newTask.name = "MoveTo Revive NPC" -- giving it a special name so the overwatch knows when to kick in
				newTask.targetPos = target.pos
				ml_task_hub:CurrentTask():AddSubTask(newTask)
				return ml_log(true)

			else
				gw2_common_functions.NecroLeaveDeathshroud()
				if ( Player.castinfo.duration == 0 ) then
					ml_log("Starting to Revive NPC...")
					Player:Interact(target)
				end
				ml_global_information.Wait(1000)
				return ml_log(true)
			end

		end
	end
	return ml_log(false)
end


-- Range limited to Attackrange
c_AttackBestNearbyCharacterTarget = inheritsFrom( ml_cause )
e_AttackBestNearbyCharacterTarget = inheritsFrom( ml_effect )
c_AttackBestNearbyCharacterTarget.target = nil
function c_AttackBestNearbyCharacterTarget:evaluate()
	c_AttackBestNearbyCharacterTarget.target = gw2_common_functions.GetBestCharacterTargetForAssist()
	if ( c_AttackBestNearbyCharacterTarget.target ~= nil ) then
		return true
	end
	c_AttackBestNearbyCharacterTarget.target = nil
	return false
end
function e_AttackBestNearbyCharacterTarget:execute()
	ml_log( "AttackBestCharacterTarget" )
	gw2_skill_manager:Use( c_AttackBestNearbyCharacterTarget.target.id )
	c_AttackBestNearbyCharacterTarget.target = nil
end

--
c_FightAggro = inheritsFrom( ml_cause )
e_FightAggro = inheritsFrom( ml_effect )
c_FightAggro.target = nil
function c_FightAggro:evaluate()
	local target = gw2_common_functions.GetBestAggroTarget()
	if ( target ) then
		c_FightAggro.target = target
		return c_FightAggro.target ~= nil
	end

	c_FightAggro.target = nil
	return false
end
function e_FightAggro:execute()
	ml_log("e_FightAggro ")

	if (c_FightAggro.target ~= nil) then
		Player:StopMovement()
		local newTask = gw2_task_combat.Create()
		newTask.targetID = c_FightAggro.target.id
		ml_task_hub:Add(newTask.Create(), IMMEDIATE_GOAL, TP_IMMEDIATE)
		c_FightAggro.target = nil
	else
		ml_log("e_FightAggro found no target")
	end
	return ml_log(false)
end


--: add this cne to move to a random position on the mesh most likely in levelrange of the player
c_movetorandom = inheritsFrom(ml_cause)
e_movetorandom = inheritsFrom(ml_effect)
c_movetorandom.randompoint = nil
c_movetorandom.randompointreached = false
c_movetorandom.randomdistance = math.random(750,5000)
c_movetorandom.throttleTmr = 0
function c_movetorandom:evaluate()

	-- This needs to be throttled else the bot nearly freezes when this is spammed and not mesh was loaded / no point found
	if( TimeSince(c_movetorandom.throttleTmr) > 2500 ) then

		c_movetorandom.throttleTmr = ml_global_information.Now

		if (c_movetorandom.randompoint == nil) then

			-- Walk to Random Point in our levelrange
			if ( TableSize(gw2_datamanager.levelmap) > 0 ) then
				local pos = gw2_datamanager.GetRandomPositionInLevelRange( ml_global_information.Player_Level )
				if (TableSize(pos) > 0 ) then
					-- make sure the position can be reached
					if ( ValidTable(NavigationManager:GetPath(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,pos.x,pos.y,pos.z))) then
						d("c_movetorandom.randompoint path found")
						c_movetorandom.randompoint = pos
						c_movetorandom.randompointreached = false
						c_movetorandom.randomdistance = math.random(750,5000)
					else
						d("c_movetorandom.randompoint no path found")
					end
				end
			end
		end

		-- 2nd attempt to find a random point
		if (c_movetorandom.randompoint == nil) then

			local pos = Player:GetRandomPoint(5000) -- 5000 beeing mindistance to player
			if ( pos and pos ~= 0) then
				if ( ValidTable(NavigationManager:GetPath(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,pos.x,pos.y,pos.z))) then
					c_movetorandom.randompoint = pos
					c_movetorandom.randompointreached = false
					c_movetorandom.randomdistance = math.random(750,5000)
				end
			end
		end
	end


	if (c_movetorandom.randompoint and not c_movetorandom.randompointreached) then
		return true
	end

	c_movetorandom.randompoint = nil
    return false
end
e_movetorandom.counter = 0
function e_movetorandom:execute()
	ml_log("MoveToRandomPoint ")
	if (c_movetorandom.randompoint) then

		local rpos = c_movetorandom.randompoint

		if ValidTable(rpos) then
			local dist = Distance3D(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,rpos.x,rpos.y,rpos.z)

			if  (dist < c_movetorandom.randomdistance) then
				c_movetorandom.randompointreached = true
				c_movetorandom.randompoint = nil
				return ml_log(true)
			else
				ml_log(", distance " .. math.floor(dist) .. " -> ")
				if ( not gw2_unstuck.HandleStuck() ) then
					local result = tostring(Player:MoveTo(rpos.x,rpos.y,rpos.z,250,false,false,false))
					if (tonumber(result) >= 0) then
						e_movetorandom.counter = 0
						return ml_log(true)
					else
						e_movetorandom.counter = e_movetorandom.counter + 1
						if ( e_movetorandom.counter > 15 ) then
							c_movetorandom.randompoint = nil
						end

					end
				end
			end
		end
	end

	return ml_log(false)
end

-- Looting chests and normal lootable enemies
c_Looting = inheritsFrom( ml_cause )
e_Looting = inheritsFrom( ml_effect )
c_Looting.lastAoE = 0
c_Looting.lastTargetID = nil
c_Looting.lootAttempts = 0
c_Looting.contentID = "17698;198260;232192;232193;232194;262863;236384;41638;297323"
function c_Looting:evaluate()
	local lootTarget = (GadgetList("onmesh,interactable,selectable,nearest,maxdistance=3000,contentID="..c_Looting.contentID) or CharacterList("nearest,lootable,onmesh,maxdistance=3000"))
	return (ValidTable(lootTarget) and Inventory.freeSlotCount > 0)
end
function e_Looting:execute()
	ml_log("e_Looting: ")
	local lootTarget = (GadgetList("onmesh,interactable,selectable,shortestpath,maxdistance=4000,contentID="..c_Looting.contentID) or CharacterList("shortestpath,lootable,onmesh,maxdistance=4000"))
	if (ValidTable(lootTarget)) then
		lootTarget = select(2,next(lootTarget))
	end
	-- Check for valid lootTarget.
	if (ValidTable(lootTarget) and (lootTarget.lootable or lootTarget.interactable)) then
		-- lootTarget Close enough to AoE Loot
		if (lootTarget.isCharacter and lootTarget.distance < 900 and TimeSince(e_Looting.lastAoE) > 1050) then
			Player:AoELoot()
			e_Looting.lastAoE = Now()
		-- Player is looting, wait to be done.
		elseif (Player.castinfo.duration ~= 0) then
			ml_log(": Looting busy.")
		-- We are in range to loot
		elseif (lootTarget.isInInteractRange) then
			gw2_common_functions.NecroLeaveDeathshroud()
			ml_log(": Looting starting.")
			if ( Player:IsMoving() ) then Player:StopMovement() end
			Player:Interact(lootTarget.id)
			-- Prevent looting loops while being attacked.
			if (lootTarget.id ~= c_Looting.lastTargetID) then
				-- Set new loot ID.
				c_Looting.lastTargetID = lootTarget.id
				c_Looting.lootAttempts = 0
			else
				-- Increase loot attempt counter.
				c_Looting.lootAttempts = c_Looting.lootAttempts + 1
				-- Check if we aggro'd nearby enemie's.
				if ( c_Looting.lootAttempts > 15 ) then
					local target = gw2_common_functions.GetBestAggroTarget()
					if ( target ) then
						d("Being attacked while looting, killing target.")
						local newTask = gw2_task_combat.Create()
						newTask.targetID = target.id
						ml_task_hub:Add(newTask.Create(), IMMEDIATE_GOAL, TP_IMMEDIATE)
					end
					c_Looting.lootAttempts = 0
				end
			end
		-- Loot not in range, walk there.
		elseif (lootTarget.isInInteractRange == false) then
			ml_log(": Walking to Loot.")
			gw2_common_functions.MoveOnlyStraightForward()
			-- Moving to lootTarget position.
			local tPos = lootTarget.pos
			if ( not gw2_unstuck.HandleStuck() ) then
				Player:MoveTo(tPos.x,tPos.y,tPos.z,lootTarget.radius+10,false,false,true)
			end
		end
	end
end


c_fleeToSafety = inheritsFrom( ml_cause )
e_fleeToSafety = inheritsFrom( ml_effect )
c_fleeToSafety.safespot = nil
c_fleeToSafety.fleeing = false
c_fleeToSafety.startWaitTime = 0
function c_fleeToSafety:evaluate()
	-- Check if were alive and if already fleeing.
	if ( ml_global_information.Player_Alive and c_fleeToSafety.fleeing == true and c_fleeToSafety.safespot) then
		return true
	-- Check if were alive and low on health.
	--elseif (ml_global_information.Player_Alive and ml_global_information.Player_InCombat and ml_global_information.Player_Health.percent < 15) then
	elseif (ml_global_information.Player_Alive and ml_global_information.Player_Health.percent < 15) then
		if (c_fleeToSafety.safespot == nil) then
			local WList = WaypointList("onmesh,notcontested,samezone,mindistance=250,nearest")
			if ( ValidTable(WList) ) then
				local _,safespot = next(WList)
				if (ValidTable(safespot)) then
					c_fleeToSafety.safespot = safespot.pos
				end
			end
		end
		local nmbrEnemies = TableSize(CharacterList("aggro,alive"))
		local target = Player:GetTarget()
		local tHealth = (target == nil and 100 or target.health.percent)
		-- Check for safe-spot and enemy number or enemy health.
		if (c_fleeToSafety.safespot and (nmbrEnemies > 1 or tHealth > 40)) then
			return true
		end
	end
	c_fleeToSafety.safespot = nil
	c_fleeToSafety.startWaitTime = 0
	return false
end
function e_fleeToSafety:execute()
	ml_log("e_fleeToSafety")
	-- Check if we still need to flee
	c_fleeToSafety.fleeing = (ml_global_information.Player_Health.percent < 85)
	-- Clear target, no need for char to break neck looking back at targer XD
	Player:ClearTarget()
	-- Find enemies.
	local nmbrEnemies = CharacterList("aggro,alive")
	-- Enemies found, keep fleeing.
	if (ValidTable(nmbrEnemies) or (TimeSince(c_fleeToSafety.startWaitTime) > 15000 and ml_global_information.Player_Health.percent < 85)) then
		ml_log(": Walking to Safe-spot.")
		c_fleeToSafety.startWaitTime = 0
		-- Find new safespot if were near current and still under attack.
		local dist = Distance2D(Player.pos.x,Player.pos.y,c_fleeToSafety.safespot.x,c_fleeToSafety.safespot.y)
		if (dist < 250) then
			local WList = WaypointList("onmesh,notcontested,samezone,mindistance=250,nearest")
			if ( ValidTable(WList) ) then
				local _,safespot = next(WList)
				if (ValidTable(safespot)) then
					c_fleeToSafety.safespot = safespot.pos
				end
			end
		end
		if ( c_fleeToSafety.safespot and not gw2_unstuck.HandleStuck() ) then
			gw2_common_functions.MoveOnlyStraightForward()
			local pos = c_fleeToSafety.safespot.pos
			Player:MoveTo(c_fleeToSafety.safespot.x,c_fleeToSafety.safespot.y,c_fleeToSafety.safespot.z,50,false,true,true)
		end
	-- No enemies found, safe-spot found stop moving and wait to heal.
	else
		ml_log(": Found Safe-spot, waiting to heal.")
		
		if(c_fleeToSafety.startWaitTime == 0) then
			c_fleeToSafety.startWaitTime = ml_global_information.Now
		end
		
		if ( ml_global_information.Player_IsMoving ) then
			Player:StopMovement()
		end
	end
end


c_waitToHeal = inheritsFrom( ml_cause )
e_waitToHeal = inheritsFrom( ml_effect )
c_waitToHeal.hpPercent = math.random(70,85)
c_waitToHeal.startWaitTime = 0
function c_waitToHeal:evaluate()
	--d("c_waitToHeal")
	-- Check players health, if below set value wait to heal.
	local conditions = "736,720,737,722,861,721,791,727,738,742,723"
	local buffs = Player.buffs
	if(not ml_global_information.Player_InCombat and (c_waitToHeal.startWaitTime == 0 or TimeSince(c_waitToHeal.startWaitTime) < 20000)) then
		if(ml_global_information.Player_Health.percent < c_waitToHeal.hpPercent or gw2_common_functions.BufflistHasBuffs(buffs,conditions)) then
			return true
		end
	end
	
	if(ml_global_information.Player_Health.percent > c_waitToHeal.hpPercent) then
		c_waitToHeal.startWaitTime = 0
	end
	
	return false
end
function e_waitToHeal:execute()
	ml_log("WaitToHeal")
	-- Set new random HP trigger.
	c_waitToHeal.hpPercent = math.random(70,85)
	
	if(c_waitToHeal.startWaitTime == 0) then
		c_waitToHeal.startWaitTime = ml_global_information.Now
	end
	
	-- If necro check for deathshroud.
	gw2_common_functions.NecroLeaveDeathshroud()
	-- Stop Player movement.
	if ( ml_global_information.Player_IsMoving ) then Player:StopMovement() end
end

-- Finish downed enemies
c_FinishEnemy = inheritsFrom( ml_cause )
e_FinishEnemy = inheritsFrom( ml_effect )
e_FinishEnemy.tmr = 0
e_FinishEnemy.threshold = 2000
function c_FinishEnemy:evaluate()
    return ml_global_information.Player_Health.percent > 15 and TableSize(CharacterList("nearest,downed,aggro,attackable,maxdistance=1200,onmesh")) > 0
end
function e_FinishEnemy:execute()
	ml_log(" Finish Enemy ")
	local EList = CharacterList("nearest,downed,aggro,attackable,maxdistance=1200,onmesh")
	if ( EList ) then
		local id,entity = next (EList)
		if ( id and entity ) then

			if (not entity.isInInteractRange) then
				-- MoveIntoInteractRange
				local tPos = entity.pos
				if ( tPos ) then
					gw2_common_functions.MoveOnlyStraightForward()
					if ( not gw2_unstuck.HandleStuck() ) then
						local navResult = tostring(Player:MoveTo(tPos.x,tPos.y,tPos.z,50,false,false,false))
						if (tonumber(navResult) < 0) then
							d("e_FinishEnemy result: "..tonumber(navResult))
						end
					end
					if ( ml_global_information.Now - e_FinishEnemy.tmr > e_FinishEnemy.threshold ) then
						e_FinishEnemy.tmr = ml_global_information.Now
						e_FinishEnemy.threshold = math.random(1500,5000)
					end
					ml_log("MoveTo_FinishHim..")
					return true
				end
			else
				-- Grab that thing
				if ( ml_global_information.Player_IsMoving ) then Player:StopMovement() end

				local t = Player:GetTarget()
				if ( entity.selectable and (not t or t.id ~= id )) then
					Player:SetTarget( id )
				else

					-- If necro check for deathshroud.
					gw2_common_functions.NecroLeaveDeathshroud()


					if ( Player.castinfo.duration == 0 ) then
						Player:Interact( id )
						ml_log("Start Finishing Enemy..")
						ml_global_information.Wait(1000)
					else
						ml_log("Finishing Enemy....")
					end
					return ml_log(true)
				end
			end
		end
	end
	return ml_log(false)
end

c_equipGatheringTools = inheritsFrom( ml_cause )
e_equipGatheringTools = inheritsFrom( ml_effect )
function c_equipGatheringTools:evaluate()
	if(ml_global_information.Player_InCombat == false ) then
		local key = gw2_buy_manager.toolListIDToKey(gw2_buy_manager.toolList) -- Get key asociated with chosen tool type. Eg: "copper" = 1
		if (key and ml_global_information.Player_Level >= gw2_buy_manager.LevelRestrictions[key]) then -- Check for valid key and if player level is high enough for the chosen tool.
			if (Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.ForagingTool) == nil and ValidTable(Inventory("itemID=" .. gw2_buy_manager.tools.foraging[key]))) or
			(Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.LoggingTool) == nil and ValidTable(Inventory("itemID=" .. gw2_buy_manager.tools.logging[key]))) or
			(Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.MiningTool) == nil and ValidTable(Inventory("itemID=" .. gw2_buy_manager.tools.mining[key]))) then
				return true -- One or more tooltypes not equiped and matching tool in inventory.
			end
		end
	end
	return false
end
function e_equipGatheringTools:execute()
	ml_log("e_equipGatheringTools")
	if(ml_global_information.Player_InCombat == false) then
		local key = gw2_buy_manager.toolListIDToKey(gw2_buy_manager.toolList) -- Get key asociated with chosen tool type. Eg: "copper" = 1
		if (key and ml_global_information.Player_Level >= gw2_buy_manager.LevelRestrictions[key]) then -- Check for valid key and if player level is high enough for the chosen tool.
			local _,fTool = next(Inventory("itemID=" .. gw2_buy_manager.tools.foraging[key])) -- Get correct tool in Inventory.
			local _,lTool = next(Inventory("itemID=" .. gw2_buy_manager.tools.logging[key]))
			local _,mTool = next(Inventory("itemID=" .. gw2_buy_manager.tools.mining[key]))
			if (Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.ForagingTool) == nil and ValidTable(fTool)) then
				d("Equipping Sickle ..")
				fTool:Equip(GW2.EQUIPMENTSLOT.ForagingTool)
				return true
			elseif (Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.LoggingTool) == nil and ValidTable(lTool)) then
				d("Equipping Axe ..")
				lTool:Equip(GW2.EQUIPMENTSLOT.LoggingTool)
				return true
			elseif (Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.MiningTool) == nil and ValidTable(mTool)) then
				d("Equipping Pick ..")
				mTool:Equip(GW2.EQUIPMENTSLOT.MiningTool)
				return true
			end
		end
	end
	return false
end


-- Moves player towards the current vendor marker
c_MoveToVendorMarker = inheritsFrom( ml_cause )
e_MoveToVendorMarker = inheritsFrom( ml_effect )
c_MoveToVendorMarker.markerreachedfirsttime = false
c_MoveToVendorMarker.markerreached = false
function c_MoveToVendorMarker:evaluate()
	-- Get a new/next Marker if we need one ( no marker , out of level, time up )
	if (ml_task_hub:CurrentTask().currentMarker == nil or ml_task_hub:CurrentTask().currentMarker == false
		or ( ml_task_hub:CurrentTask().filterLevel and ml_task_hub:CurrentTask().currentMarker:GetMinLevel() and ml_task_hub:CurrentTask().currentMarker:GetMaxLevel() and (ml_global_information.Player_Level < ml_task_hub:CurrentTask().currentMarker:GetMinLevel() or ml_global_information.Player_Level > ml_task_hub:CurrentTask().currentMarker:GetMaxLevel()))
		or ( ml_task_hub:CurrentTask().currentMarker:GetTime() and ml_task_hub:CurrentTask().currentMarker:GetTime() ~= 0 and TimeSince(ml_task_hub:CurrentTask().markerTime) > ml_task_hub:CurrentTask().currentMarker:GetTime() * 1000 )) then
		-- TODO: ADD TIMEOUT FOR MARKER
		ml_task_hub:CurrentTask().currentMarker = ml_marker_mgr.GetNextMarker(GetString("vendorMarker"), ml_task_hub:CurrentTask().filterLevel)

		-- disable the levelfilter in case we didnt find any other marker
		if (ml_task_hub:CurrentTask().currentMarker == nil) then
			ml_task_hub:CurrentTask().filterLevel = false
			ml_task_hub:CurrentTask().currentMarker = ml_marker_mgr.GetNextMarker(GetString("vendorMarker"), ml_task_hub:CurrentTask().filterLevel)
		end

		-- we found a new marker, setup vars
		if ( ml_task_hub:CurrentTask().currentMarker ~= nil ) then
			d("New VendorMarker Marker set!")
			ml_task_hub:CurrentTask().markerTime = ml_global_information.Now -- Are BOTH needed to get updated ?
			ml_global_information.MarkerTime = ml_global_information.Now     -- This needs to be global else we cannot access the stuff in parent or subtasks
			ml_global_information.MarkerMinLevel = ml_task_hub:CurrentTask().currentMarker:GetMinLevel()
			ml_global_information.MarkerMaxLevel = ml_task_hub:CurrentTask().currentMarker:GetMaxLevel()
			c_MoveToVendorMarker.markerreached = false
			c_MoveToVendorMarker.markerreachedfirsttime = false
		end
	end

	-- We have a valid current vendorMarker
    if (ml_task_hub:CurrentTask().currentMarker ~= false and ml_task_hub:CurrentTask().currentMarker ~= nil) then

		-- Reset the Markertime until we actually reached the marker the first time and then let it count down
		if (c_MoveToVendorMarker.markerreachedfirsttime == false ) then
			ml_task_hub:CurrentTask().markerTime = ml_global_information.Now
			ml_global_information.MarkerTime = ml_global_information.Now
		end

		-- Debug info
		if ( ml_global_information.ShowDebug ) then dbCurrMarker = ml_task_hub:CurrentTask().currentMarker:GetName() or "" end

		-- We haven't reached the currentMarker or ran outside its radius
		if ( c_MoveToVendorMarker.markerreached == false) then
			return true

		else
			-- the other CnEs should pick up a vendor before we reach our marker..if we are here then it means no vendor nearby, so lets pick a next marker
			d("No Vendor nearby, Trying next VendorMarker...")
			ml_task_hub:CurrentTask().currentMarker = nil
		end
	end

    return false
end
function e_MoveToVendorMarker:execute()
	ml_log(" e_MoveToVendorMarker ")
	-- Move to our current marker
	if (ml_task_hub:CurrentTask().currentMarker ~= nil and ml_task_hub:CurrentTask().currentMarker ~= false) then

		local pos = ml_task_hub:CurrentTask().currentMarker:GetPosition()
		local dist = Distance2D(ml_global_information.Player_Position.x, ml_global_information.Player_Position.y, pos.x, pos.y)


		if  ( dist < 200) then
			-- We reached our Marker
			c_MoveToVendorMarker.markerreached = true
			c_MoveToVendorMarker.markerreachedfirsttime = true
			d("Reached current VendorMarker...")
			return ml_log(true)
		else
			-- We need to reach our Marker yet
			-- make sure the next marker is reachable & onmesh
			if ( ValidTable(NavigationManager:GetPath(ml_global_information.Player_Position.x,ml_global_information.Player_Position.y,ml_global_information.Player_Position.z,pos.x,pos.y,pos.z))) then

				local newTask = gw2_task_moveto.Create()
				newTask.name = "MoveTo VendorMarker"
				newTask.targetPos = pos
				ml_task_hub:CurrentTask():AddSubTask(newTask)
				return ml_log(true)

			else
				d("WARNING: Cannot reach next VendorMarker, trying to pick another one...")
				ml_task_hub:CurrentTask().currentMarker = nil
				-- Debug info
				if ( ml_global_information.ShowDebug ) then dbCurrMarker = "" end
			end
		end
	end
	return ml_log(false)
end