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
						info = "",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
						runcode = "if(Settings.GW2Minion.revivedownedplayers) then\n\t\tself:success()\nelse\n\t\tself:fail()\nend",
						startcode = "",
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
						info = "",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState()))",
						runcode = "if(context.revivedownedplayer_id and ml_global_information.Player_Health.percent > 20) then\n\t\tcontext.revive_targetid = context.revivedownedplayer_id\n\t\tcontext.revive_position = context.revivedownedplayer_pos\n\t\tself:success()\n\t\treturn\nelseif((self.lastrevivecheck == nil or TimeSince(self.lastrevivecheck) > 15000) and ml_global_information.Player_Health.percent > 40) then\n\t\tself.lastrevivecheck = ml_global_information.Now\n\t\tlocal CList = CharacterList(\"player,friendly,interactable,nearest,downed,onmesh,maxpathdistance=2500\")\n\t\tif(table.valid(CList)) then\n\t\t\t\tlocal _,target = next(CList)\n\t\t\t\tif(table.valid(target)) then\n\t\t\t\t\t\tcontext.revivedownedplayer_id = target.id\n\t\t\t\t\t\tcontext.revivedownedplayer_pos = target.pos\n\t\t\t\t\t\tself:running()\n\t\t\t\t\t\treturn\n\t\t\t\tend\n\t\tend\nend\ncontext.revivedownedplayer_id = nil\ncontext.revivedownedplayer_pos = nil\nself:fail()",
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
						filename = "ReviveActionHandler.st",
						finishcode = "",
						info = "Revive action\ncontext.revive_position\ncontext.revive_targetid",
						menucode = "",
						monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Filename: '..self.variables.filename) GUI:Text('Filepath: '..self.filepath)",
						runcode = "",
						startcode = "",
						subtreeuicode = "",
						xposoffset = 0,
					},
				},
			},
			variables = 
			{
				expanded = true,
				info = "",
				monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Active Child: '..tostring(self.actualTask or 'None'))",
				xposoffset = 0,
			},
		},
	},
	variables = 
	{
		filename = "ReviveDownedPlayers.st",
		finishcode = "",
		info = "Revive downed players",
		menucode = "",
		monitorcode = "GUI:Text('Last State: '..tostring(self:getState())) GUI:Text('Filename: '..self.variables.filename) GUI:Text('Filepath: '..self.filepath)",
		runcode = "",
		startcode = "",
		subtreeuicode = "",
		xposoffset = 0,
	},
}



return tbl