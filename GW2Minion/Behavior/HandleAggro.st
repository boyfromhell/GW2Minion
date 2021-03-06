local tbl = 
{
	class = "BehaviorTree",
	nodes = 
	{
		
		{
			class = "Sequence",
			nodes = 
			{
				
				{
					class = "Action",
					nodes = 
					{
					},
					variables = 
					{
						finishcode = "",
						info = "Find Aggro Target and Set the aggro context.combat_targetid",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
						runcode = "local target = gw2_common_functions.GetBestAggroTarget()\nif (ValidTable(target) and not ml_blacklist.CheckBlacklistEntry(GetString(\"monsters\"),target.contentID)) then\n\tlocal pdist = target.pathdistance\n\tif ( pdist > 0 ) then\n\t\tcontext.combat_targetid = target.id\n\t\tself:success()\n\t\treturn\n\tend\nend\nself:fail()\n",
						startcode = "",
						xposoffset = 0,
					},
				},
				
				{
					class = "PrioritySelector",
					nodes = 
					{
						
						{
							class = "Action",
							nodes = 
							{
							},
							variables = 
							{
								finishcode = "",
								info = "Aggro CombatOverWatch - updates context.combat_target ",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
								runcode = "if ( context.combat_targetid ) then\n\tlocal target = CharacterList:Get(context.combat_targetid) or GadgetList:Get(context.combat_targetid)\n\tif (table.valid(target) and not ml_blacklist.CheckBlacklistEntry(GetString(\"monsters\"),target.contentID) and target.isAggro and target.attackable and target.alive and target.onmesh) then\n\t\tcontext.combat_target = target\n\t\tcontext.combat_targetid = target.id\n\n\t\t-- switch aggro target if a better one was found\n\t\tlocal bettertarget = gw2_common_functions.GetBestAggroTarget()\n\t\tif (bettertarget.id ~= target.id and table.valid(bettertarget) and not ml_blacklist.CheckBlacklistEntry(GetString(\"monsters\"),bettertarget.contentID)) then\n\t\t\tlocal pdist = target.pathdistance\n\t\t\tif ( pdist > 0 ) then\n\t\t\t\tcontext.combat_target = bettertarget\n\t\t\t\tcontext.combat_targetid = bettertarget.id\n\t\t\tend\n\t\tend\n\t\t\n\telse\n\t\td(\"[HandleAggro] - Aggro Target is dead or gone\")\n\t\tcontext.combat_targetid = nil\n\t\tcontext.combat_target = nil\n\tend\nend\nself:fail()",
								startcode = "",
								xposoffset = 0,
							},
						},
						
						{
							class = "Sequence",
							nodes = 
							{
								
								{
									class = "Action",
									nodes = 
									{
									},
									variables = 
									{
										finishcode = "",
										info = "Moving closer is needed ?",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
										runcode = "if ( context.combat_targetid and context.combat_target) then\n\tif (context.combat_target.distance > 2500 ) then \n\t\tcontext.moveto_position = context.combat_target.pos\n\t\tcontext.moveto_targetid = context.combat_target.id\n\t\tcontext.moveto_targettype = \"character\"\n\t\tself:success()\n\t\treturn\n\tend\nend\nself:fail()",
										startcode = "",
										xposoffset = 0,
									},
								},
								
								{
									class = "BehaviorTree",
									nodes = 
									{
									},
									variables = 
									{
										filename = "MoveTo.st",
										finishcode = "",
										info = "Move to Position. \nRequired input argument: context.moveto_position\nOptional arguments:\ncontext.moveto_targetid - ID of the character / gadget we want to move to.\ncontext.moveto_targettype - \"character\" or \"gadget\" or \"event\"\n",
										menucode = "",
										monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Filename: '..self.variables.filename) GUI:Text('Filepath: '..self.filepath)\n",
										randomMovement = true,
										runcode = "-- Setting the custom subtree settings in the context, which gets passed down to childnodes\ncontext.moveto_stoppingdistance = self.variables.stoppingdistance\ncontext.moveto_randomMovement = self.variables.randomMovement\ncontext.moveto_smoothturns = self.variables.smoothturns\ncontext.moveto_usewaypoints = self.variables.usewaypoints\ncontext.moveto_follownavsystem = false",
										smoothturns = true,
										startcode = "",
										stoppingdistance = 2000,
										subtreeuicode = "if ( self.variables.stoppingdistance == nil ) then self.variables.stoppingdistance = 25 end\nself.variables.stoppingdistance = GUI:InputInt(\"Stopping Distance\", self.variables.stoppingdistance, 1, GUI.InputTextFlags_CharsDecimal)\n\nif ( self.variables.randomMovement == nil ) then self.variables.randomMovement = true end\nself.variables.randomMovement = GUI:Checkbox( \"RandomMovement\", self.variables.randomMovement )\n\nif ( self.variables.smoothturns == nil ) then self.variables.smoothturns = true end\nself.variables.smoothturns = GUI:Checkbox( \"Smooth Turns\", self.variables.smoothturns )\n\nif ( self.variables.usewaypoints == nil ) then self.variables.usewaypoints = false end\nself.variables.usewaypoints = GUI:Checkbox( \"Use Waypoints\", self.variables.usewaypoints )\nif ( GUI:IsItemHovered() ) then GUI:SetTooltip( \"When enabled, MoveTo will use waypoints if they are closer to the targetposition.\" ) end",
										usewaypoints = false,
										xposoffset = 0,
									},
								},
							},
							variables = 
							{
								info = "Move into closer Range if needed",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
								xposoffset = 0,
							},
						},
						
						{
							class = "Action",
							nodes = 
							{
							},
							variables = 
							{
								finishcode = "",
								info = "Attack Aggro Target",
								monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
								runcode = "if ( context.combat_targetid ) then\n\tgw2_skill_manager:Use(context.combat_targetid)\n\tself:running()\n\treturn\nend\nself:fail()",
								startcode = "",
								xposoffset = 0,
							},
						},
					},
					variables = 
					{
						expanded = true,
						info = "",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.runningTask or 'None'))",
						xposoffset = 0,
					},
				},
			},
			variables = 
			{
				expanded = true,
				filename = "HandleAggro",
				info = "",
				monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
				xposoffset = 0,
			},
		},
	},
	variables = 
	{
		expanded = true,
		filename = "HandleAggro.st",
		finishcode = "",
		info = "Handle Aggro",
		menucode = "",
		monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Filename: '..self.variables.filename) GUI:Text('Filepath: '..self.filepath)",
		runcode = "",
		startcode = "",
		subtreeuicode = "",
		xposoffset = 0,
	},
}



return tbl