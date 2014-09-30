gw2minion = {}
gw2minion.MainWindow = { Name="MainMenu", x=50, y=50, width=220, height=350, ChildWindows = {} }
gw2minion.CinemaWindow = { Name="CinemaMenu", x=100, y=100 , width=250, height=150 }
gw2minion.CharacterWindow = { Name="CharacterMenu", x=100, y=100 , width=250, height=150 }
gw2minion.DebugWindow = { Name="DebugInfo", x=100, y=100 , width=200, height=250 }

function gw2minion.ModuleInit()
	--Init MainMenu Window
	mw = WindowManager:NewWindow(gw2minion.MainWindow.Name,gw2minion.MainWindow.x,gw2minion.MainWindow.y,gw2minion.MainWindow.width,gw2minion.MainWindow.height)
	if ( mw ) then
		mw:NewComboBox(GetString("botMode"),"gBotMode",GetString("botStatus"),"")
		mw:UnFold(GetString("botStatus") )
		
		local b = mw:NewButton(GetString("startBot"),"gw2minion.evBotstartStop")
		b:SetToggleState(false)
		b:SetSize(25,30)
		RegisterEventHandler("gw2minion.evBotstartStop", gw2minion.ToggleBot)
		RegisterEventHandler("GW2MINION.toggle", gw2minion.ToggleBot)
		
		local bd = mw:NewButton("D","gw2minion.evToggleDebugWindow")
		bd:Dock(0)
		bd:SetSize(15,15)
		bd:SetPos(100,0)
		RegisterEventHandler("gw2minion.evToggleDebugWindow", gw2minion.ShowDebug)
		
	end	
	-- Setup default bot modes
	gw2minion.UpdateBotModes()
	-- Setup GuestServerList
	gw2minion.UpdateGuestServers()
	
	Settings.GW2Minion.gPulseTime = Settings.GW2Minion.gPulseTime or "150"
	Settings.GW2Minion.gBotMode = Settings.GW2Minion.gBotMode or GetString("grindMode")
	Settings.GW2Minion.gBotRunning = Settings.GW2Minion.gBotRunning or "0"	
	Settings.GW2Minion.gGuestServer = Settings.GW2Minion.gGuestServer or "None"
	Settings.GW2Minion.dDisableRender = Settings.GW2Minion.dDisableRender or "0"
		
	if ( RenderManager ) then RenderManager:ToggleRendering(tonumber(dDisableRender)) end
	
    gBotMode = Settings.GW2Minion.gBotMode
	gBotRunning	= Settings.GW2Minion.gBotRunning
	gPulseTime = Settings.GW2Minion.gPulseTime

	
	-- CinemaWindow		
	local cw = WindowManager:NewWindow(gw2minion.CinemaWindow.Name,gw2minion.CinemaWindow.x,gw2minion.CinemaWindow.y,gw2minion.CinemaWindow.width,gw2minion.CinemaWindow.height)
	
	-- CharacterWindow	
	local caw = WindowManager:NewWindow(gw2minion.CharacterWindow.Name,gw2minion.CharacterWindow.x,gw2minion.CharacterWindow.y,gw2minion.CharacterWindow.width,gw2minion.CharacterWindow.height)
	
	-- DebugWindow
	local dw = WindowManager:NewWindow(gw2minion.DebugWindow.Name,gw2minion.DebugWindow.x,gw2minion.DebugWindow.y,gw2minion.DebugWindow.width,gw2minion.DebugWindow.height)
		dw:Hide()
	gw2minion.MainWindow.ChildWindows[gw2minion.DebugWindow.Name] = gw2minion.DebugWindow.Name
	
	-- Setup marker manager callbacks and vars
	if ( ml_marker_mgr ) then
		ml_marker_mgr.GetPosition = 	function () return ml_global_information.Player_Position end
		ml_marker_mgr.GetLevel = 		function () return ml_global_information.Player_Level end
		ml_marker_mgr.DrawMarker =		ml_global_information.DrawMarker
		ml_marker_mgr.parentWindow = gw2minion.MainWindow.Name
		ml_marker_mgr.markerPath = ml_global_information.Path.. [[\Navigation\]]		
	end
	
	-- setup meshmanager
	if ( ml_mesh_mgr ) then
		ml_mesh_mgr.parentWindow.Name = gw2minion.MainWindow.Name
		ml_mesh_mgr.GetMapID = function () return ml_global_information.CurrentMapID end
		ml_mesh_mgr.GetMapName = function () return ml_global_information.CurrentMapName end
		ml_mesh_mgr.GetPlayerPos = function () return ml_global_information.Player_Position end
		ml_mesh_mgr.averagegameunitsize = 50
		
		-- Set worldnavigation data
		ml_mesh_mgr.navData = persistence.load(ml_global_information.Path..[[\LuaMods\GW2Minion\]].."worldnav_data.lua")
		if ( not ValidTable(ml_mesh_mgr.navData)) then 
			ml_mesh_mgr.navData = {} 
		else
			ml_mesh_mgr.SetupNavNodes()
		end
		
		-- Set default meshes SetDefaultMesh(mapid, filename)
		ml_mesh_mgr.SetDefaultMesh(15,"Queensdale")
		ml_mesh_mgr.SetDefaultMesh(17,"Harathi Hinterlands")
			
		ml_mesh_mgr.SetDefaultMesh(19,"PlainsOfAshford")
		ml_mesh_mgr.SetDefaultMesh(20,"BlazzeridgeSteppes")
		ml_mesh_mgr.SetDefaultMesh(21,"Fields of Ruin")
		ml_mesh_mgr.SetDefaultMesh(22,"FireHeartRise")		
		ml_mesh_mgr.SetDefaultMesh(23,"Kessex Hills")		
		ml_mesh_mgr.SetDefaultMesh(24,"Gendarran Fields")
		ml_mesh_mgr.SetDefaultMesh(25,"IronMarches")
		ml_mesh_mgr.SetDefaultMesh(26,"Dredgehaunt Cliffs")
		ml_mesh_mgr.SetDefaultMesh(27,"LonarsPass")
		ml_mesh_mgr.SetDefaultMesh(28,"Wayfarer Foothills")		
		ml_mesh_mgr.SetDefaultMesh(29,"TimberlineFalls")
		ml_mesh_mgr.SetDefaultMesh(30,"FrostGorge Sound")
		ml_mesh_mgr.SetDefaultMesh(31,"Snowden Drifts")		
		ml_mesh_mgr.SetDefaultMesh(32,"DiessaPlateau")
		ml_mesh_mgr.SetDefaultMesh(34,"Caledon Forest")
		ml_mesh_mgr.SetDefaultMesh(35,"MetricaProvince")
		ml_mesh_mgr.SetDefaultMesh(39,"MountMaelstrom")
		
		ml_mesh_mgr.SetDefaultMesh(50,"Lions Arch")		
		ml_mesh_mgr.SetDefaultMesh(51,"Straits of Devastation")
		ml_mesh_mgr.SetDefaultMesh(53,"Sparkfly Fen")
		ml_mesh_mgr.SetDefaultMesh(54,"Brisban Wildlands")
		
		ml_mesh_mgr.SetDefaultMesh(62,"CursedShore")
		ml_mesh_mgr.SetDefaultMesh(65,"Malchors Leap")
		ml_mesh_mgr.SetDefaultMesh(73,"BloodtideCoast")
		
		ml_mesh_mgr.SetDefaultMesh(91,"The Grove")
		ml_mesh_mgr.SetDefaultMesh(139,"Rata Sum")
		ml_mesh_mgr.SetDefaultMesh(218,"Black Citadel")
		ml_mesh_mgr.SetDefaultMesh(326,"Hoelbrak")
		ml_mesh_mgr.SetDefaultMesh(350,"Heart of the Mists")
		ml_mesh_mgr.SetDefaultMesh(968,"EdgeOfTheMist")
		
		-- Setup the marker types we wanna use
		   --[[ local mapMarker = ml_marker:Create("MapMarker")
			mapMarker:SetType(GetString("mapMarker"))
			mapMarker:SetMinLevel(1)
			mapMarker:SetMaxLevel(50)
			mapMarker:AddField("int", "Target MapID", 0)			
			ml_marker_mgr.AddMarkerTemplate(mapMarker)			
			
			local vendorMarker = ml_marker:Create("vendorTemplate")
			vendorMarker:SetType(GetString("vendorMarker"))
			vendorMarker:SetMinLevel(1)
			vendorMarker:SetMaxLevel(50)
			ml_marker_mgr.AddMarkerTemplate(vendorMarker)--]]
			
			
			-- refresh the manager with the new templates
			ml_marker_mgr.RefreshMarkerTypes()
			ml_marker_mgr.RefreshMarkerNames()
				
		ml_mesh_mgr.InitMarkers() -- Update the Markers-group in the mesher UI
	end
	
	-- Setup blacklists
	if ( ml_blacklist_mgr ) then
		ml_blacklist_mgr.parentWindow = gw2minion.MainWindow.Name
		ml_blacklist_mgr.path = GetStartupPath() .. [[\LuaMods\GW2Minion\blacklist.info]]
		ml_blacklist_mgr.ReadBlacklistFile(ml_blacklist_mgr.path)
		if not ml_blacklist.BlacklistExists(GetString("monsters")) then
			ml_blacklist.CreateBlacklist(GetString("monsters"))
		end		
		if not ml_blacklist.BlacklistExists(GetString("vendors")) then
			ml_blacklist.CreateBlacklist(GetString("vendors"))
		end
		
	end
	
	gw2minion.SwitchMode(gBotMode)
	if ( gBotRunning == "1" ) then
		gw2minion.ToggleBot()
	end				
end

function gw2minion.OnUpdate(event, tickcount )
	ml_global_information.Now = tickcount
	if ( TimeSince(ml_global_information.Lasttick) > tonumber(gPulseTime) ) then
		ml_global_information.Lasttick = tickcount		
		gw2minion.SwitchUIForGameState()
		
		-- Call all OnUpdate()
		ml_global_information.OnUpdate()			
		-- Mesher OnUpdate
		ml_mesh_mgr.OnUpdate( tickcount )
		-- BlackList OnUpdate		
		ml_blacklist_mgr.UpdateEntryTime()
		ml_blacklist_mgr.UpdateEntries(tickcount)
		
		if ( ml_global_information.Running ) then		
																
			if( ml_task_hub:CurrentTask() ~= nil) then
				ml_log(ml_task_hub:CurrentTask().name.." :")
			end
				
			if ( ml_task_hub.shouldRun ) then
				if (not ml_task_hub:Update() ) then
					if ( not ml_global_information.Reset() ) then
						ml_error("No task queued, please select a valid bot mode in the Settings drop-down menu")
					end
				end
			end
				
		end
		GUI_SetStatusBar(ml_GetLogString())
	end
end

function gw2minion.OnUpdateCharSelect(event, tickcount )
	ml_global_information.Now = tickcount
	if ( TimeSince(ml_global_information.Lasttick) > tonumber(gPulseTime) ) then
		ml_global_information.Lasttick = tickcount
		gw2minion.SwitchUIForGameState()
	end
end

function gw2minion.OnUpdateCutscene(event, tickcount )
	ml_global_information.Now = tickcount
	if ( TimeSince(ml_global_information.Lasttick) > tonumber(gPulseTime) ) then
		ml_global_information.Lasttick = tickcount
		gw2minion.SwitchUIForGameState()
	end
end

function gw2minion.ToggleBot(arg)
	local mw = WindowManager:GetWindow(gw2minion.MainWindow.Name)
	if ( mw ) then 
		local sb = mw:GetControl(GetString("startBot"))
		if ( sb ) then
			if ( arg == "GW2MINION.toggle" ) then -- CTRL + S
				if ( sb.pressed ) then
					sb:SetToggleState(false)
				else
					sb:SetToggleState(true)
				end
			end
			if ( sb.pressed ) then
				d("Starting Bot..")
				ml_global_information.Running = true
				ml_task_hub.shouldRun = true
				Settings.GW2Minion.gBotRunning = "1"
				sb:SetText(GetString("stopBot"))
			else
				d("Stopping Bot..")
				ml_global_information.Running = false
				ml_task_hub.shouldRun = false		
				Settings.GW2Minion.gBotRunning = "0"
				ml_global_information.Stop()
				ml_global_information.Reset()				
				sb:SetText(GetString("startBot"))
			end
		end
	end
end

--switches the shown UI according to the gamestate
function gw2minion.SwitchUIForGameState(tickcount)
	local currentGameState = GetGameState()
	if ( currentGameState ~= ml_global_information.LastGameState ) then
		ml_global_information.LastGameState = currentGameState
		GUI_ToggleConsole(false)
		local wMain = WindowManager:GetWindow(gw2minion.MainWindow.Name)
		local wCine = WindowManager:GetWindow(gw2minion.CinemaWindow.Name)
		local wChar = WindowManager:GetWindow(gw2minion.CharacterWindow.Name)
		if ( wMain and wCine and wChar) then
			if ( currentGameState == 16 ) then --ingame
				wMain:Show()
				wCine:Hide()
				wChar:Hide()
			elseif( currentGameState == 14 or currentGameState == 10 ) then --cinematic
				wMain:Hide()
				for name,_ in pairs(gw2minion.MainWindow.ChildWindows) do
					local wnd = WindowManager:GetWindow(name)
					if ( wnd ) then wnd:Hide() end
				end
				wCine:Show()
				wChar:Hide()
			elseif( currentGameState == 4 ) then --charscreen
				wMain:Hide()
				for name,_ in pairs(gw2minion.MainWindow.ChildWindows) do
					local wnd = WindowManager:GetWindow(name)
					if ( wnd ) then wnd:Hide() end
				end
				wCine:Hide()
				wChar:Show()
			end
		end	
	end
end

function gw2minion.GUIVarUpdate(Event, NewVals, OldVals)
	for k,v in pairs(NewVals) do
		if ( k == "gBotMode" ) then
			ml_global_information.Stop()
			gw2minion.SwitchMode(v)
			Settings.GW2Minion[tostring(k)] = v
		end
	end
end

function ml_global_information.Reset()
    ml_task_hub:ClearQueues()
	if (gBotMode ~= nil) then
		local task = ml_global_information.BotModes[gBotMode]
		if (task ~= nil) then			
			ml_task_hub:Add(task.Create(), LONG_TERM_GOAL, TP_ASAP)
			return true
		end
    end
	return false
end

function ml_global_information.Stop()
    if (Player:IsMoving()) then
        Player:StopMovement()
    end
end

function ml_global_information.Wait( mseconds )
	ml_global_information.Lasttick = ml_global_information.Lasttick + mseconds
	
end

-- To add a task to the BotMode Dropdown
function ml_global_information.AddBotMode( botmode, task )
	if ( ml_global_information.BotModes and ml_global_information.BotModes[botmode] == nil) then
		ml_global_information.BotModes[botmode] = task
		gw2minion.UpdateBotModes()
	end
end
-- Rebuilds the BotMode Dropdown field
function gw2minion.UpdateBotModes()
    local botModes = GetString("grindMode")
    if ( ValidTable(ml_global_information.BotModes) ) then
        local i,entry = next ( ml_global_information.BotModes )
        while i and entry do
            if ( GetString("grindMode") ~= i ) then
				botModes = botModes..","..i
			end
			i,entry = next ( ml_global_information.BotModes,i)			
        end
    end
	gBotMode_listitems = botModes
end

function gw2minion.UpdateGuestServers()
	local newserverlist = "None"
	local homeserverid = GetHomeServer()
	local serverlist = {}	
	if ( homeserverid > 1000 and homeserverid < 2000 ) then
		serverlist = ml_global_information.ServersUS
	elseif ( homeserverid > 2000 and homeserverid < 3000 ) then
		serverlist = ml_global_information.ServersEU
	end	
	if ( TableSize(serverlist) > 0) then
		local i,entry = next ( serverlist)
		while i and entry do			
			newserverlist = newserverlist..","..entry.name
			i,entry = next ( serverlist,i)
		end
	end
	gGuestServer_listitems = newserverlist
	gGuestServer = Settings.GW2Minion.gGuestServer
end

function gw2minion.SwitchMode(mode)	
	ml_global_information.Reset()
	local newtask = ml_global_information.BotModes[mode]
    if (newtask ~= nil) then
		
		if (gBotRunning == "1") then
			ml_task_hub.ToggleRun()
		end
	
		-- Destroy old UI	
		if (Settings.GW2Minion["gBotMode"] ~= nil and ml_global_information.BotModes[Settings.GW2Minion["gBotMode"]] ~= nil) then
			ml_global_information.BotModes[Settings.GW2Minion["gBotMode"]]:UIDestroy()						
		end
		-- Create new UI
		newtask:UIInit()
		
		--Set marker type to the appropriate type.
		if (gBotMode == GetString("grindMode")) then
			ml_marker_mgr.SetMarkerType(GetString("grindMarker"))
		end
		
		--Setup default options.
		if (gBotMode == GetString("grindMode")) then
			
		end
		
	else
		if ( Settings.GW2Minion["gBotMode"] ~= nil and ml_global_information.BotModes[Settings.GW2Minion["gBotMode"]] ~= nil ) then
			ml_global_information.BotModes[Settings.GW2Minion["gBotMode"]]:UIDestroy()
		end
		d("No Valid BotMode selected")
	end
end

function gw2minion.ShowDebug()
	local dw = WindowManager:GetWindow(gw2minion.DebugWindow.Name)
	if ( dw ) then
		if ( dw.visible ) then
			dw:Hide()
			ml_global_information.ShowDebug = false
		else
			dw:Show()
			ml_global_information.ShowDebug = true
		end
	end
end
RegisterEventHandler("Module.Initalize",gw2minion.ModuleInit)
RegisterEventHandler("GUI.Update",gw2minion.GUIVarUpdate)
RegisterEventHandler("Gameloop.Update",gw2minion.OnUpdate)
RegisterEventHandler("Gameloop.CharSelectUpdate",gw2minion.OnUpdateCharSelect)
RegisterEventHandler("Gameloop.CutsceneUpdate",gw2minion.OnUpdateCutscene)