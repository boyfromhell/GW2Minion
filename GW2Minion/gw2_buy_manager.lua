gw2_buy_manager = {}
gw2_buy_manager.availableOnMap = {
	lastMap = 0,
	salvage = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true,},
	gathering = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true,},
}
gw2_buy_manager.LevelRestrictions = {
	[1] = 0,
	[2] = 10, -- lvl10
	[3] = 20, -- lvl20
	[4] = 30, -- lvl30
	[5] = 45, -- lvl45
	[6] = 60, -- lvl60
}
gw2_buy_manager.tools = {
	foraging = {
		[1] = 23029,
		[2] = 22992, -- lvl10
		[3] = 23004, -- lvl20
		[4] = 23005, -- lvl30
		[5] = 23008, -- lvl45
		[6] = 22997, -- lvl60
	},
	logging = {
		[1] = 23030,
		[2] = 22994,
		[3] = 23002,
		[4] = 23006,
		[5] = 23009,
		[6] = 23000,
	},
	mining = {
		[1] = 23031,
		[2] = 22995,
		[3] = 23003,
		[4] = 23007,
		[5] = 23010,
		[6] = 23001,
	},
	salvage = {
		[1] = 23038, -- Crude Salvage Kit (rarity 1)
		[2] = 23040, -- Basic Salvage Kit (rarity 1)
		[3] = 23041, -- Fine (rarity 2)
		[4] = 23042, -- Journeyman (rarity 3)
		[5] = 23043,  -- Master (rarity 4)
	},
}

-- Gui stuff here.
gw2_buy_manager.mainWindow = {
	name = GetString("buymanager"),
	open = false,
	visible = true,
}

function gw2_buy_manager.ModuleInit()
	if (Settings.gw2_buy_manager.active == nil) then
		Settings.gw2_buy_manager.active = false
	end
	gw2_buy_manager.active = Settings.gw2_buy_manager.active

	if (Settings.gw2_buy_manager.crudeKit == nil) then
		Settings.gw2_buy_manager.crudeKit = 0
	end
	gw2_buy_manager.crudeKit = Settings.gw2_buy_manager.crudeKit

	if (Settings.gw2_buy_manager.basicKit == nil) then
		Settings.gw2_buy_manager.basicKit = 0
	end
	gw2_buy_manager.basicKit = Settings.gw2_buy_manager.basicKit

	if (Settings.gw2_buy_manager.fineKit == nil) then
		Settings.gw2_buy_manager.fineKit = 0
	end
	gw2_buy_manager.fineKit = Settings.gw2_buy_manager.fineKit

	if (Settings.gw2_buy_manager.journeymanKit == nil) then
		Settings.gw2_buy_manager.journeymanKit = 0
	end
	gw2_buy_manager.journeymanKit = Settings.gw2_buy_manager.journeymanKit

	if (Settings.gw2_buy_manager.masterKit == nil) then
		Settings.gw2_buy_manager.masterKit = 0
	end
	gw2_buy_manager.masterKit = Settings.gw2_buy_manager.masterKit

	if (Settings.gw2_buy_manager.toolStack == nil) then
		Settings.gw2_buy_manager.toolStack = 0
	end
	gw2_buy_manager.toolStack = Settings.gw2_buy_manager.toolStack

	if (Settings.gw2_buy_manager.toolList == nil) then
		Settings.gw2_buy_manager.toolList = {
			nameList = {"None", "Copper", "Iron", "Steel", "Darksteel", "Mithrill", "Orichalcum",},
			idList = {["None"] = 1, ["Copper"] = 2, ["Iron"] = 3, ["Steel"] = 4, ["Darksteel"] = 5, ["Mithrill"] = 6, ["Orichalcum"] = 7,},
			currID = 1,
		}
	end
	gw2_buy_manager.toolList = Settings.gw2_buy_manager.toolList

	-- init button in minionmainbutton
	ml_gui.ui_mgr:AddMember({ id = "GW2MINION##BUYMGR", name = "Buy MGR", onClick = function() gw2_buy_manager.mainWindow.open = gw2_buy_manager.mainWindow.open ~= true end, tooltip = "Click to open \"Buy Manager\" window."},"GW2MINION##MENU_HEADER")

end

-- Gui draw function.
function gw2_buy_manager.mainWindow.Draw(event,ticks)
	if (gw2_buy_manager.mainWindow.open) then 
		-- set size on first use only.
		GUI:SetNextWindowSize(250,400,GUI.SetCond_FirstUseEver)
		-- update visible and open variables.
		gw2_buy_manager.mainWindow.visible, gw2_buy_manager.mainWindow.open = GUI:Begin(gw2_buy_manager.mainWindow.name, gw2_buy_manager.mainWindow.open, GUI.WindowFlags_AlwaysAutoResize+GUI.WindowFlags_NoCollapse)
		if (gw2_buy_manager.mainWindow.visible) then
			-- Status field.
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			GUI:Spacing()
			GUI:BeginGroup()
			gw2_buy_manager.active = GUI:Checkbox(GetString("active"), gw2_buy_manager.active)
			Settings.gw2_buy_manager.active = gw2_buy_manager.active
			GUI:EndGroup()
			if (GUI:IsItemHovered() and gw2_buy_manager.toolTip) then
				GUI:SetTooltip("Turn Buying on or off.")
			end
			-----------------------------------------------------------------------------------------------------------------------------------
			GUI:Separator()
			-----------------------------------------------------------------------------------------------------------------------------------
			-- Salvage Kit group here.
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing) -- open the tree *BUG* conditions not working as expected.
			if (GUI:TreeNode(GetString("salvagekits"))) then -- create the tree, only pop inside if.
				-- Crude Kits.
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("buyCrude")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				gw2_buy_manager.crudeKit = GUI:SliderInt("##mbuym-crudekit", gw2_buy_manager.crudeKit, 0, 25)
				Settings.gw2_buy_manager.crudeKit = gw2_buy_manager.crudeKit
				GUI:PopItemWidth()
				-- Basic Kits.
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("buyBasic")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				gw2_buy_manager.basicKit = GUI:SliderInt("##mbuym-basickit", gw2_buy_manager.basicKit, 0, 25)
				Settings.gw2_buy_manager.basicKit = gw2_buy_manager.basicKit
				GUI:PopItemWidth()
				-- Fine Kits.
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("buyFine")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				gw2_buy_manager.fineKit = GUI:SliderInt("##mbuym-finekit", gw2_buy_manager.fineKit, 0, 25)
				Settings.gw2_buy_manager.fineKit = gw2_buy_manager.fineKit
				GUI:PopItemWidth()
				-- Journeyman Kits.
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("buyJourneyman")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				gw2_buy_manager.journeymanKit = GUI:SliderInt("##mbuym-journeymankit", gw2_buy_manager.journeymanKit, 0, 25)
				Settings.gw2_buy_manager.journeymanKit = gw2_buy_manager.journeymanKit
				GUI:PopItemWidth()
				-- Master Kits.
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("buyMaster")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				gw2_buy_manager.masterKit = GUI:SliderInt("##mbuym-masterkit", gw2_buy_manager.masterKit, 0, 25)
				Settings.gw2_buy_manager.masterKit = gw2_buy_manager.masterKit
				GUI:PopItemWidth()
				
				GUI:TreePop()
			end
			-----------------------------------------------------------------------------------------------------------------------------------
			GUI:Separator()
			-----------------------------------------------------------------------------------------------------------------------------------
			-- Gathering Tool group here.
			-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			GUI:SetNextTreeNodeOpened(true, GUI.SetCond_Appearing) -- open the tree *BUG* conditions not working as expected.
			if (GUI:TreeNode(GetString("gatheringtools"))) then -- create the tree, only pop inside if.
				-- Tool Type
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("toolType")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				local changed = false
				gw2_buy_manager.toolList.currID, changed = GUI:Combo("##mbuym-tooltobuy",gw2_buy_manager.toolList.currID,gw2_buy_manager.toolList.nameList)
				if (changed) then
					Settings.gw2_buy_manager.toolList = gw2_buy_manager.toolList
				end
				GUI:PopItemWidth()
				-- Tool Type
				GUI:AlignFirstTextHeightToWidgets()
				GUI:Text(GetString("toolStack")..":")
				GUI:SameLine(140)
				GUI:PushItemWidth(150)
				gw2_buy_manager.toolStack = GUI:SliderInt("##mbuym-toolstack", gw2_buy_manager.toolStack, 0, 25)
				Settings.gw2_buy_manager.toolStack = gw2_buy_manager.toolStack
				GUI:PopItemWidth()
				
				GUI:TreePop()
			end
		end
		GUI:End()
	end
end

-- Working stuff here.
function gw2_buy_manager.vendorSellsCheck()
	local vendorSalvageItems = VendorItemList("itemtype="..GW2.ITEMTYPE.SalvageTool)
	local vendorGatheringItems = VendorItemList("itemtype="..GW2.ITEMTYPE.Gathering)
	if (table.valid(vendorSalvageItems) and table.valid(vendorGatheringItems)) then
		if (gw2_buy_manager.availableOnMap.lastMap ~= ml_global_information.CurrentMapID) then
			gw2_buy_manager.availableOnMap.lastMap = ml_global_information.CurrentMapID
			gw2_buy_manager.setMapAvailablity(vendorSalvageItems,vendorGatheringItems)
		end
		return true
	end
	return false
end

function gw2_buy_manager.setMapAvailablity(salvageItems,gatheringItems)
	for key=1,5 do
		gw2_buy_manager.availableOnMap.salvage[key] = false
	end
	for _,item in pairs(salvageItems) do
		for key=1,5 do
			if (item.itemID == gw2_buy_manager.tools.salvage[key]) then gw2_buy_manager.availableOnMap.salvage[key] = true end
		end
	end
	
	for key=1,6 do
		gw2_buy_manager.availableOnMap.gathering[key] = false
	end
	for _,item in pairs(gatheringItems) do
		for key=1,6 do
			if (item.itemID == gw2_buy_manager.tools.foraging[key]) then gw2_buy_manager.availableOnMap.gathering[key] = true end
		end
	end
end

function gw2_buy_manager.NeedToBuySalvageKits(nearby)
	local neededKits = gw2_buy_manager.GetNeededSalvageKitList()
	for itemID,count in pairs(neededKits) do
		if (nearby == true and count > 0) then
			return true
		elseif (nearby ~= true) then
			if (itemID == gw2_buy_manager.tools.salvage[1] and count == tonumber(gw2_buy_manager.crudeKit)) or
			(itemID == gw2_buy_manager.tools.salvage[2] and count == tonumber(gw2_buy_manager.basicKit)) or
			(itemID == gw2_buy_manager.tools.salvage[3] and count == tonumber(gw2_buy_manager.fineKit)) or
			(itemID == gw2_buy_manager.tools.salvage[4] and count == tonumber(gw2_buy_manager.journeymanKit)) or
			(itemID == gw2_buy_manager.tools.salvage[5] and count == tonumber(gw2_buy_manager.masterKit)) then
				return true
			end
		end
	end
	return false
end

function gw2_buy_manager.GetNeededSalvageKitList()
	local neededKits = {}
	if (tonumber(gw2_buy_manager.crudeKit) > 0 and gw2_buy_manager.availableOnMap.salvage[1]) then neededKits[gw2_buy_manager.tools.salvage[1]] = tonumber(gw2_buy_manager.crudeKit) end
	if (tonumber(gw2_buy_manager.basicKit) > 0 and gw2_buy_manager.availableOnMap.salvage[2]) then neededKits[gw2_buy_manager.tools.salvage[2]] = tonumber(gw2_buy_manager.basicKit) end
	if (tonumber(gw2_buy_manager.fineKit) > 0 and gw2_buy_manager.availableOnMap.salvage[3]) then neededKits[gw2_buy_manager.tools.salvage[3]] = tonumber(gw2_buy_manager.fineKit) end
	if (tonumber(gw2_buy_manager.journeymanKit) > 0 and gw2_buy_manager.availableOnMap.salvage[4]) then neededKits[gw2_buy_manager.tools.salvage[4]] = tonumber(gw2_buy_manager.journeymanKit) end
	if (tonumber(gw2_buy_manager.masterKit) > 0 and gw2_buy_manager.availableOnMap.salvage[5]) then neededKits[gw2_buy_manager.tools.salvage[5]] = tonumber(gw2_buy_manager.masterKit) end
	local ownedKits = Inventory("itemtype=" .. GW2.ITEMTYPE.SalvageTool)
	for _,kit in pairs(ownedKits) do
		if (neededKits[kit.itemID]) then
			neededKits[kit.itemID] = neededKits[kit.itemID] - 1
		end
	end
	return neededKits
end

function gw2_buy_manager.NeedToBuyGatheringTools(nearby)
	local neededTools = gw2_buy_manager.GetNeededGatheringToolList()

	for itemID,count in pairs(neededTools) do
		if (nearby == true and count > 0) then
			return true
		elseif (nearby ~= true and count == tonumber(gw2_buy_manager.toolStack)) then
			return true
		end
	end
	return false
end

function gw2_buy_manager.toolListIDToKey(toolList)
	local currID = toolList.currID
	return (
		currID == 2 and 1 or
		currID == 3 and 2 or
		currID == 4 and 3 or
		currID == 5 and 4 or
		currID == 6 and 5 or
		currID == 7 and 6 or nil
	)
end

function gw2_buy_manager.checkForInfTools(tool)
	return (tool and tool.rarity == 4 and tool.stackcount == 0 and true or false)
end

function gw2_buy_manager.GetNeededGatheringToolList()
	local key = gw2_buy_manager.toolListIDToKey(gw2_buy_manager.toolList)
	local neededTools = {}
	local wantedCount = tonumber(gw2_buy_manager.toolStack)
	if (key and wantedCount > 0 and gw2_buy_manager.availableOnMap.gathering[key] and gw2_buy_manager.LevelRestrictions[key] <= ml_global_information.Player_Level) then
		local fTool = Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.ForagingTool)
		local lTool = Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.LoggingTool)
		local mTool = Inventory:GetEquippedItemBySlot(GW2.EQUIPMENTSLOT.MiningTool)
		if (gw2_buy_manager.checkForInfTools(fTool) == false) then
			neededTools[gw2_buy_manager.tools.foraging[key]] = wantedCount
		end
		if (gw2_buy_manager.checkForInfTools(lTool) == false) then
			neededTools[gw2_buy_manager.tools.logging[key]] = wantedCount
		end
		if (gw2_buy_manager.checkForInfTools(mTool) == false) then
			neededTools[gw2_buy_manager.tools.mining[key]] = wantedCount
		end
		local ownedKits = Inventory("itemtype=" .. GW2.ITEMTYPE.Gathering)
		for _,tool in pairs(ownedKits) do
			if (neededTools[tool.itemID]) then
				neededTools[tool.itemID] = neededTools[tool.itemID] - 1
			end
		end
	end
	return neededTools
end

function gw2_buy_manager.getClosestBuyMarker(nearby)
	local closestLocation = nil
	local listArg = (nearby == true and ",maxdistance=4000" or "")
	local markers = MapMarkerList("onmesh,nearest,contentID="..GW2.MAPMARKER.Merchant..listArg..",exclude_characterid="..ml_blacklist.GetExcludeString(GetString("vendorsbuy")))
	for _,merchant in pairs(markers) do
		if (closestLocation == nil or closestLocation.distance > merchant.distance) then
			if (nearby == true and merchant.pathdistance < 4000) then
				closestLocation = merchant
			elseif (nearby ~= true) then
				closestLocation = merchant
			end
		end
	end
	return closestLocation
end

function gw2_buy_manager.buyAtMerchant(vendorMarker)
	if (vendorMarker) then
		vendor = CharacterList:Get(vendorMarker.characterID)
		if (vendor and vendor.isInInteractRange and vendor.distance < 100) then
			Player:StopMovement()
			local target = Player:GetTarget()
			if (not target or target.id ~= vendor.id) then
				Player:SetTarget(vendor.id)
			else
				if (Inventory:IsVendorOpened() == false and Player:IsConversationOpen() == false) then
					ml_log(" Opening Vendor.. ")
					Player:Interact(vendor.id)
					ml_global_information.Wait(1500)
					return true
				else
					local result = gw2_common_functions.handleConversation("buy")
					if (result == false) then
						d("Vendor blacklisted, cant handle opening conversation.")
						ml_blacklist.AddBlacklistEntry(GetString("vendorsbuy"), vendor.id, vendor.name, true)
						return false
					elseif (result == nil) then
					
						ml_global_information.Wait(math.random(520,1200))
						return true
					end
				end
				if (gw2_buy_manager.vendorSellsCheck() == false) then
					d("Vendor blacklisted, does not have needed tools/kits.")
					ml_blacklist.AddBlacklistEntry(GetString("vendorsbuy"), vendor.id, vendor.name, true)
				end
				local vendorItems = VendorItemList("")
				local slowdown = math.random(0,3)
				if (table.valid(vendorItems) ) then
					if ( slowdown == 0) then
						local neededKits = gw2_buy_manager.GetNeededSalvageKitList()
						local neededTools = gw2_buy_manager.GetNeededGatheringToolList()				
						
						for _,item in pairs(vendorItems) do
							local itemID = item.itemID
							for id,count in pairs(neededKits) do								
								if (id == itemID and count > 0) then
									item:Buy()
									return true
								end
							end
							for id,count in pairs(neededTools) do							
								if (id == itemID and count > 0) then
									item:Buy()
									return true	
								end
							end
						end
						return false
					end
					
					return true
				end
			end
		else
			local pos = vendorMarker.pos
			if ( pos ) then
				local newTask = gw2_task_moveto.Create()
				newTask.targetPos = pos
				newTask.targetID = vendorMarker.characterID
				newTask.targetType = "character"
				newTask.name = "MoveTo Vendor(BUY)"
				newTask.useWaypoint = true
				ml_task_hub:CurrentTask():AddSubTask(newTask)
				return true
			end
		end
	end
	return false
end

RegisterEventHandler("Module.Initalize",gw2_buy_manager.ModuleInit)
RegisterEventHandler("Gameloop.Draw", gw2_buy_manager.mainWindow.Draw)