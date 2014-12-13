-- Persistent Data
local multiRefObjects = {

} -- multiRefObjects
local obj1 = {
	["name"] = "Queensdale";
	["tasks"] = {
		[1] = {
			["customVars"] = {
			};
			["type"] = "MoveTo Position";
			["minlvl"] = 0;
			["maxlvl"] = "80";
			["id"] = 1;
			["enabled"] = "1";
			["partysize"] = 0;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_ShaemoorWaypoint";
			["complete"] = true;
			["maxduration"] = 0;
			["priority"] = 1;
			["cooldown"] = 0;
			["mappos"] = "-16512/17324/-1371";
		};
		[2] = {
			["customVars"] = {
			};
			["type"] = "MoveTo Position";
			["minlvl"] = 0;
			["maxlvl"] = 80;
			["id"] = 2;
			["enabled"] = "1";
			["partysize"] = 0;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_TrainersTerrace";
			["complete"] = true;
			["maxduration"] = 0;
			["priority"] = 2;
			["cooldown"] = 0;
			["mappos"] = "-18959/14484/-839";
		};
		[3] = {
			["customVars"] = {
			};
			["type"] = "MoveTo Position";
			["minlvl"] = 0;
			["maxlvl"] = 80;
			["id"] = 3;
			["enabled"] = "1";
			["partysize"] = 0;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Fields";
			["complete"] = true;
			["maxduration"] = 0;
			["priority"] = 3;
			["cooldown"] = 0;
			["mappos"] = "-25394/14145/-866";
		};
		[4] = {
			["customVars"] = {
			};
			["type"] = "MoveTo Position";
			["minlvl"] = 0;
			["maxlvl"] = 80;
			["id"] = 4;
			["enabled"] = "1";
			["partysize"] = 0;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_JebsWheatfield";
			["complete"] = true;
			["maxduration"] = 0;
			["priority"] = 4;
			["cooldown"] = 0;
			["mappos"] = "-29539/15816/-846";
		};
		[5] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "215";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "147874";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "44322";
					["type"] = "Field";
				};
				["TM_TASK_KillEnemies"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "20";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "10";
					["type"] = "Numeric";
				};
			};
			["radius"] = "3500";
			["minlvl"] = 0;
			["maxlvl"] = "80";
			["id"] = 5;
			["type"] = "HeartQuest";
			["enabled"] = "1";
			["partysize"] = 0;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help Diah Tend Her Farm";
			["complete"] = true;
			["maxduration"] = "600";
			["priority"] = 5;
			["cooldown"] = 0;
			["mappos"] = "-28904/14536/-864";
		};
		[6] = {
			["enabled"] = "1";
			["radius"] = "4000";
			["minlvl"] = "1";
			["maxlvl"] = "80";
			["id"] = 6;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "216";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "216402";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_KillEnemies"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "301506,44214";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "15";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "20";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help Fisher Travis maintain the river";
			["type"] = "HeartQuest";
			["maxduration"] = "600";
			["priority"] = 6;
			["cooldown"] = "300";
			["mappos"] = "-28362/22339/-237";
		};
		[7] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "218";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "180293,216436";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "178571,301489";
					["type"] = "Field";
				};
				["TM_TASK_KillEnemies"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "20";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "20";
					["type"] = "Numeric";
				};
			};
			["radius"] = "8000";
			["minlvl"] = "2";
			["id"] = 7;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help Foreman Flannum...";
			["type"] = "HeartQuest";
			["maxduration"] = "800";
			["priority"] = 7;
			["cooldown"] = "300";
			["mappos"] = "-26035/23685/-772";
		};
		[8] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "2";
			["maxlvl"] = "80";
			["id"] = 8;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Near Foreman ";
			["type"] = "Vista";
			["maxduration"] = "600";
			["priority"] = 8;
			["cooldown"] = 0;
			["mappos"] = "-31813/28433/-1305";
		};
		[9] = {
			["customVars"] = {
			};
			["radius"] = "0";
			["minlvl"] = "0";
			["id"] = 9;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Orchard Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 9;
			["cooldown"] = "0";
			["mappos"] = "-37242/19280/-583";
		};
		[10] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = 0;
			["id"] = 10;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Edas Orchard";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 10;
			["cooldown"] = 0;
			["mappos"] = "-38007/21689/-578";
		};
		[11] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "219";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "216438";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_KillEnemies"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "25";
					["type"] = "Numeric";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "44300,44168,44255";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "25";
					["type"] = "Numeric";
				};
			};
			["radius"] = 0;
			["minlvl"] = "3";
			["id"] = 11;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Assist Farmer Eda";
			["type"] = "HeartQuest";
			["maxduration"] = "600";
			["priority"] = 11;
			["cooldown"] = "300";
			["mappos"] = "-37827/24200/-551";
		};
		[12] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = 0;
			["maxlvl"] = "80";
			["id"] = 12;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Orchard Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 12;
			["cooldown"] = 0;
			["mappos"] = "-37282/19264/-583";
		};
		[13] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = 0;
			["maxlvl"] = 80;
			["id"] = 13;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Mepis Moa Ranch";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 13;
			["cooldown"] = 0;
			["mappos"] = "-37709/13990/-1067";
		};
		[14] = {
			["enabled"] = "1";
			["radius"] = "8500";
			["minlvl"] = "5";
			["maxlvl"] = 80;
			["id"] = 14;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "220";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "240811,216400";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_KillEnemies"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "25";
					["type"] = "Numeric";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "43462,301454,43469,301460,43475";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "22";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help Cassie";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 14;
			["cooldown"] = "300";
			["mappos"] = "-38501/11006/-1057";
		};
		[15] = {
			["enabled"] = "1";
			["radius"] = "5";
			["minlvl"] = "0";
			["maxlvl"] = 80;
			["id"] = 15;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Bandithaunt Caverns";
			["type"] = "Vista";
			["maxduration"] = "0";
			["priority"] = 15;
			["cooldown"] = "0";
			["mappos"] = "-29497/2477/-937";
		};
		[16] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "5";
			["maxlvl"] = 80;
			["id"] = 16;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Dalins Pumping Station";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 16;
			["cooldown"] = 0;
			["mappos"] = "-23141/5929/-2887";
		};
		[17] = {
			["enabled"] = "1";
			["radius"] = "5";
			["minlvl"] = "0";
			["maxlvl"] = 80;
			["id"] = 17;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Shaemoor Fields";
			["type"] = "Vista";
			["maxduration"] = 0;
			["priority"] = 17;
			["cooldown"] = 0;
			["mappos"] = "-20536/7733/-2685";
		};
		[18] = {
			["enabled"] = "1";
			["radius"] = "6";
			["minlvl"] = 0;
			["maxlvl"] = 80;
			["id"] = 18;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Crossing Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 18;
			["cooldown"] = 0;
			["mappos"] = "-19948/-4909/-482";
		};
		[19] = {
			["customVars"] = {
				["TM_TASK_SPType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "240811";
					["type"] = "Field";
				};
				["TM_TASK_conversationOrder"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "43469,301457";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135270912";
					["type"] = "Field";
				};
				["TM_TASK_usableItemIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
			};
			["superClass"] = nil --[[functions with upvalue not supported]];
			["class"] = nil --[[functions with upvalue not supported]];
			["complete"] = false;
			["mapid"] = 15;
			["priority"] = 19;
			["mappos"] = "-29312/-3945/-1338";
			["isa"] = nil --[[functions with upvalue not supported]];
			["radius"] = "0";
			["minlvl"] = "0";
			["maxlvl"] = 80;
			["Create"] = nil --[[functions with upvalue not supported]];
			["maxduration"] = "0";
			["minduration"] = 0;
			["name"] = "SP_Bandit Loot";
			["id"] = 69;
			["partysize"] = 0;
			["enabled"] = "1";
			["cooldown"] = 0;
			["type"] = "Skillpoint";
		};
		[20] = {
			["enabled"] = "1";
			["radius"] = "6";
			["minlvl"] = 0;
			["maxlvl"] = 80;
			["id"] = 19;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Altar Brook Crossing";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 20;
			["cooldown"] = 0;
			["mappos"] = "-17485/-5824/-343";
		};
		[21] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "6";
			["maxlvl"] = 80;
			["id"] = 20;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Bar Curtis Range";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 21;
			["cooldown"] = 0;
			["mappos"] = "-28822/-9854/-227";
		};
		[22] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "6";
			["maxlvl"] = 80;
			["id"] = 21;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Vale Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 22;
			["cooldown"] = 0;
			["mappos"] = "-34066/-9221/-825";
		};
		[23] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "7";
			["maxlvl"] = "80";
			["id"] = 22;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_usesTeleport"] = {
					["value"] = "0";
					["type"] = "CheckBox";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Altars Windings";
			["type"] = "Vista";
			["maxduration"] = "0";
			["priority"] = 23;
			["cooldown"] = "0";
			["mappos"] = "-36801/-11906/-1937";
		};
		[24] = {
			["customVars"] = {
				["TM_TASK_SPType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "26991";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135270400";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_usableItemIDs"] = {
					["value"] = "22375";
					["type"] = "Field";
				};
				["TM_TASK_waitingTime"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_conversationOrder"] = {
					["value"] = "22";
					["type"] = "Field";
				};
			};
			["radius"] = 0;
			["minlvl"] = "9";
			["id"] = 23;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "SP_Take a Glob";
			["type"] = "Skillpoint";
			["maxduration"] = 0;
			["priority"] = 24;
			["cooldown"] = 0;
			["mappos"] = "-40836/-4774/-2802";
		};
		[25] = {
			["customVars"] = {
				["TM_TASK_usesTeleport"] = {
					["value"] = "1";
					["type"] = "CheckBox";
				};
			};
			["radius"] = 0;
			["minlvl"] = 0;
			["id"] = 24;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_ClayentFalls";
			["type"] = "Vista";
			["maxduration"] = 0;
			["priority"] = 25;
			["cooldown"] = 0;
			["mappos"] = "-31749/-20307/-440";
		};
		[26] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = "8";
			["id"] = 25;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = false;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Claypool Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 26;
			["cooldown"] = 0;
			["mappos"] = "-22420/-15851/-1379";
		};
		[27] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "212";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "0";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Pickup&Use";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = 0;
					["type"] = "Numeric";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "57164";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "8204";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = 0;
					["type"] = "Numeric";
				};
			};
			["radius"] = "1500";
			["minlvl"] = "7";
			["id"] = 66;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Train with the militia";
			["type"] = "HeartQuest";
			["maxduration"] = "1200";
			["priority"] = 27;
			["cooldown"] = 0;
			["mappos"] = "-21867/-16362/-1395";
		};
		[28] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "211";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "232674,43494,232693,33554976";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "0";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
			};
			["radius"] = "5500";
			["minlvl"] = "9";
			["id"] = 26;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help the Seraph";
			["type"] = "HeartQuest";
			["maxduration"] = 0;
			["priority"] = 28;
			["cooldown"] = 0;
			["mappos"] = "-8936/-16770/-652";
		};
		[29] = {
			["customVars"] = {
			};
			["radius"] = "0";
			["minlvl"] = "9";
			["id"] = 27;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_HeartWoodPass Camp Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 29;
			["cooldown"] = 0;
			["mappos"] = "-4232/-18246/-1367";
		};
		[30] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = "9";
			["id"] = 28;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_The Heartwoods";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 30;
			["cooldown"] = 0;
			["mappos"] = "-3563/-9504/-128";
		};
		[31] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = "9";
			["id"] = 29;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Phinney Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 31;
			["cooldown"] = 0;
			["mappos"] = "3263/-11854/-1145";
		};
		[32] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "214";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "232891,147778";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "223760";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "34";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
			};
			["radius"] = 0;
			["minlvl"] = "7";
			["id"] = 34;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help Lexi Price";
			["type"] = "HeartQuest";
			["maxduration"] = "900";
			["priority"] = 32;
			["cooldown"] = 0;
			["mappos"] = "-13298/-2185/-107";
		};
		[33] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = "7";
			["id"] = 36;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Scaver Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 33;
			["cooldown"] = 0;
			["mappos"] = "-6500/2892/-121";
		};
		[34] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = "7";
			["id"] = 35;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Scaver Plateau";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 34;
			["cooldown"] = 0;
			["mappos"] = "-8421/-1548/-391";
		};
		[35] = {
			["customVars"] = {
			};
			["radius"] = 0;
			["minlvl"] = "6";
			["id"] = 37;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Garrison Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 35;
			["cooldown"] = 0;
			["mappos"] = "-7707/12199/-1125";
		};
		[36] = {
			["customVars"] = {
				["TM_TASK_usesTeleport"] = {
					["value"] = "0";
					["type"] = "CheckBox";
				};
			};
			["radius"] = 0;
			["minlvl"] = "7";
			["id"] = 38;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Garrison";
			["type"] = "Vista";
			["maxduration"] = 0;
			["priority"] = 36;
			["cooldown"] = 0;
			["mappos"] = "-6546/11131/-1744";
		};
		[37] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "213";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "216400";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "168821248";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "43494,232674";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "45";
					["type"] = "Numeric";
				};
			};
			["radius"] = "8000";
			["minlvl"] = "6";
			["id"] = 39;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Scaver Plateau";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 37;
			["cooldown"] = 0;
			["mappos"] = "-4188/6022/-1242";
		};
		[38] = {
			["customVars"] = {
				["TM_TASK_SPType"] = {
					["value"] = "Commune";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "243782";
					["type"] = "Field";
				};
				["TM_TASK_conversationOrder"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135270912";
					["type"] = "Field";
				};
				["TM_TASK_usableItemIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
			};
			["radius"] = "0";
			["minlvl"] = "6";
			["id"] = 40;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "SP_Scaver Plateau";
			["type"] = "Skillpoint";
			["maxduration"] = "0";
			["priority"] = 38;
			["cooldown"] = 0;
			["mappos"] = "-5636/6384/-1272";
		};
		[39] = {
			["customVars"] = {
				["TM_TASK_SPType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "45413";
					["type"] = "Field";
				};
				["TM_TASK_conversationOrder"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "45413";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_usableItemIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
			};
			["radius"] = 0;
			["minlvl"] = 0;
			["id"] = 41;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "SP_Chhk the Windmill King";
			["type"] = "Skillpoint";
			["maxduration"] = 0;
			["priority"] = 39;
			["cooldown"] = 0;
			["mappos"] = "1358/6887/-2325";
		};
		[40] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "226";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "148119,232891,43338,";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "43620,43615,43621,43339,337264";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "202375680,135266816";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "55";
					["type"] = "Numeric";
				};
			};
			["radius"] = "12000";
			["minlvl"] = "8";
			["id"] = 42;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Assist Laborer Cardy";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 40;
			["cooldown"] = 0;
			["mappos"] = "8686/16348/-122";
		};
		[41] = {
			["customVars"] = {
			};
			["radius"] = "8";
			["minlvl"] = "0";
			["id"] = 43;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Ojons Lumbermill";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 41;
			["cooldown"] = 0;
			["mappos"] = "7193/16671/-38";
		};
		[42] = {
			["enabled"] = "1";
			["radius"] = "12000";
			["minlvl"] = "9";
			["maxlvl"] = "80";
			["id"] = 44;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "227";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "228174,44717";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "44412,43272";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "202379776";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Assist Hunter Block";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 42;
			["cooldown"] = 0;
			["mappos"] = "17637/18649/-965";
		};
		[43] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "9";
			["maxlvl"] = 80;
			["id"] = 45;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Queens Forest";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 43;
			["cooldown"] = 0;
			["mappos"] = "21269/18218/-1488";
		};
		[44] = {
			["customVars"] = {
				["TM_TASK_maxKills"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
			};
			["superClass"] = nil --[[functions with upvalue not supported]];
			["class"] = nil --[[functions with upvalue not supported]];
			["complete"] = false;
			["mapid"] = 15;
			["priority"] = 44;
			["mappos"] = "29765/20041/-9";
			["isa"] = nil --[[functions with upvalue not supported]];
			["radius"] = "2500";
			["minlvl"] = "9";
			["maxlvl"] = 80;
			["Create"] = nil --[[functions with upvalue not supported]];
			["maxduration"] = "300";
			["minduration"] = 0;
			["name"] = "HQ_Grind_AssitFisherman Will";
			["id"] = 68;
			["partysize"] = 0;
			["enabled"] = "1";
			["cooldown"] = 0;
			["type"] = "Grind";
		};
		[45] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "228";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "283692";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
			};
			["superClass"] = nil --[[functions with upvalue not supported]];
			["class"] = nil --[[functions with upvalue not supported]];
			["complete"] = true;
			["mapid"] = 15;
			["priority"] = 45;
			["mappos"] = "30130/20713/-10";
			["isa"] = nil --[[functions with upvalue not supported]];
			["radius"] = "8000";
			["minlvl"] = "9";
			["maxlvl"] = 80;
			["Create"] = nil --[[functions with upvalue not supported]];
			["maxduration"] = "1000";
			["minduration"] = 0;
			["name"] = "HQ_Assist Fisherman Will";
			["id"] = 67;
			["partysize"] = 0;
			["enabled"] = "1";
			["cooldown"] = 0;
			["type"] = "HeartQuest";
		};
		[46] = {
			["enabled"] = "1";
			["radius"] = "6000";
			["minlvl"] = "12";
			["maxlvl"] = "80";
			["id"] = 46;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "222";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "197341,206768";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "202375680,135266304";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help the citizens of Beetletun";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 46;
			["cooldown"] = 0;
			["mappos"] = "34395/21453/-557";
		};
		[47] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 47;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Beetletun Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 47;
			["cooldown"] = 0;
			["mappos"] = "37242/21398/-840";
		};
		[48] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 48;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_SPType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "267540";
					["type"] = "Field";
				};
				["TM_TASK_conversationOrder"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "267540";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_usableItemIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "SP_Carnie Jeb";
			["type"] = "Skillpoint";
			["maxduration"] = 0;
			["priority"] = 48;
			["cooldown"] = 0;
			["mappos"] = "40021/22966/-1084";
		};
		[49] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 49;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_usesTeleport"] = {
					["value"] = "0";
					["type"] = "CheckBox";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Shire of Beetletun";
			["type"] = "Vista";
			["maxduration"] = 0;
			["priority"] = 49;
			["cooldown"] = 0;
			["mappos"] = "37853/18823/-904";
		};
		[50] = {
			["enabled"] = "1";
			["radius"] = "15000";
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 50;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "221";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "44575";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "43494,232674,43492";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Protect Beetletun farmers";
			["type"] = "HeartQuest";
			["maxduration"] = "1500";
			["priority"] = 50;
			["cooldown"] = 0;
			["mappos"] = "37618/-5845/-2887";
		};
		[51] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 51;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_BeetletunFarms";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 51;
			["cooldown"] = 0;
			["mappos"] = "28882/10112/-1166";
		};
		[52] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 52;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_QueensForest";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 52;
			["cooldown"] = 0;
			["mappos"] = "14880/8493/-1522";
		};
		[53] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "10";
			["maxlvl"] = 80;
			["id"] = 53;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_usesTeleport"] = {
					["value"] = "0";
					["type"] = "CheckBox";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Krytan Freeholds";
			["type"] = "Vista";
			["maxduration"] = 0;
			["priority"] = 53;
			["cooldown"] = 0;
			["mappos"] = "15059/5934/-2036";
		};
		[54] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "11";
			["maxlvl"] = 80;
			["id"] = 54;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Krytan Freeholds";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 54;
			["cooldown"] = 0;
			["mappos"] = "17611/5566/-1436";
		};
		[55] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "11";
			["maxlvl"] = 80;
			["id"] = 55;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Krytan Freeholds";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 55;
			["cooldown"] = 0;
			["mappos"] = "18610/1223/-1432";
		};
		[56] = {
			["enabled"] = "1";
			["radius"] = "6000";
			["minlvl"] = "11";
			["maxlvl"] = "80";
			["id"] = 56;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "225";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "246268";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "44150,43494,232674";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135266816";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "35";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Keep the monastery";
			["type"] = "HeartQuest";
			["maxduration"] = 0;
			["priority"] = 56;
			["cooldown"] = 0;
			["mappos"] = "18075/-32/-1426";
		};
		[57] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 57;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_KrytanFreeholds";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 57;
			["cooldown"] = 0;
			["mappos"] = "26540/1311/-1708";
		};
		[58] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "12";
			["maxlvl"] = 80;
			["id"] = 58;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Tunwatch Redoubt Waypoint";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 58;
			["cooldown"] = 0;
			["mappos"] = "30629/4010/-1171";
		};
		[59] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "13";
			["maxlvl"] = 80;
			["id"] = 59;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Salmas Heath";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 59;
			["cooldown"] = 0;
			["mappos"] = "39667/-5355/-3057";
		};
		[60] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "13";
			["maxlvl"] = 80;
			["id"] = 60;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Orlaf Escarpments";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 60;
			["cooldown"] = 0;
			["mappos"] = "29861/-7230/-3625";
		};
		[61] = {
			["enabled"] = "1";
			["radius"] = "0";
			["minlvl"] = "14";
			["maxlvl"] = 80;
			["id"] = 61;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_SPType"] = {
					["value"] = "Commune";
					["type"] = "ComboBox";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "243782";
					["type"] = "Field";
				};
				["TM_TASK_conversationOrder"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "135270912";
					["type"] = "Field";
				};
				["TM_TASK_usableItemIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "SP_Tamini Place of Power";
			["type"] = "Skillpoint";
			["maxduration"] = "500";
			["priority"] = 61;
			["cooldown"] = 0;
			["mappos"] = "35157/-20316/-2289";
		};
		[62] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "14";
			["maxlvl"] = 80;
			["id"] = 62;
			["partysize"] = 0;
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "223";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "43494,232674,43492";
					["type"] = "Field";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "0";
					["type"] = "Numeric";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "45";
					["type"] = "Numeric";
				};
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Taminn Foothills";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 62;
			["cooldown"] = 0;
			["mappos"] = "33263/-20301/-2238";
		};
		[63] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "13";
			["maxlvl"] = 80;
			["id"] = 63;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Taminn Footholds";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 63;
			["cooldown"] = 0;
			["mappos"] = "27561/-23441/-2281";
		};
		[64] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "13";
			["maxlvl"] = 80;
			["id"] = 64;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_Godslost Swamp";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 64;
			["cooldown"] = 0;
			["mappos"] = "13095/-24613/-270";
		};
		[65] = {
			["customVars"] = {
			};
			["radius"] = "0";
			["minlvl"] = "14";
			["id"] = 30;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Godslost Swamp";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 65;
			["cooldown"] = 0;
			["mappos"] = "11108/-12840/18";
		};
		[66] = {
			["customVars"] = {
				["TM_TASK_usesTeleport"] = {
					["value"] = "0";
					["type"] = "CheckBox";
				};
			};
			["radius"] = "0";
			["minlvl"] = "14";
			["id"] = 31;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "Vista_Godslost Swamp";
			["type"] = "Vista";
			["maxduration"] = "0";
			["priority"] = 66;
			["cooldown"] = 0;
			["mappos"] = "11518/-11686/-1198";
		};
		[67] = {
			["customVars"] = {
				["TM_TASK_subRegion"] = {
					["value"] = "224";
					["type"] = "Field";
				};
				["TM_TASK_interactContentIDs"] = {
					["value"] = "43455";
					["type"] = "Field";
				};
				["TM_TASK_pickupTargetIDs"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_pickupSkillID"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_interactContentID2s"] = {
					["value"] = "";
					["type"] = "Field";
				};
				["TM_TASK_maxInteracts"] = {
					["value"] = "30";
					["type"] = "Numeric";
				};
				["TM_TASK_HQType"] = {
					["value"] = "Interact&Kill";
					["type"] = "ComboBox";
				};
				["TM_TASK_enemyContentIDs"] = {
					["value"] = "544,193445,43942,43954";
					["type"] = "Field";
				};
				["TM_TASK_maxKills"] = {
					["value"] = "50";
					["type"] = "Numeric";
				};
			};
			["radius"] = "8000";
			["minlvl"] = "14";
			["id"] = 32;
			["maxlvl"] = "80";
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "HQ_Help historian Garrod";
			["type"] = "HeartQuest";
			["maxduration"] = "1000";
			["priority"] = 67;
			["cooldown"] = 0;
			["mappos"] = "13712/-8581/-71";
		};
		[68] = {
			["customVars"] = {
			};
			["radius"] = "0";
			["minlvl"] = "14";
			["id"] = 33;
			["maxlvl"] = 80;
			["partysize"] = 0;
			["enabled"] = "1";
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "POI_Godslost Swamp2";
			["type"] = "MoveTo Position";
			["maxduration"] = "0";
			["priority"] = 68;
			["cooldown"] = 0;
			["mappos"] = "17557/-10779/-44";
		};
		[69] = {
			["enabled"] = "1";
			["radius"] = 0;
			["minlvl"] = "14";
			["maxlvl"] = 80;
			["id"] = 65;
			["partysize"] = 0;
			["customVars"] = {
			};
			["complete"] = true;
			["mapid"] = 15;
			["minduration"] = 0;
			["name"] = "WP_godslostSwamp";
			["type"] = "MoveTo Position";
			["maxduration"] = 0;
			["priority"] = 69;
			["cooldown"] = 0;
			["mappos"] = "20626/-10645/-76";
		};
	};
	["idcounter"] = 69;
	["version"] = 1;
}
return obj1