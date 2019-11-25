--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local helpmenueText={
	["Welcome"]="Welcome to this Cops 'n' Robbers Server from LakeGaming.\nyou need help? then contact a staff-member.\nyou want to see staff-members? type /staff to see all online staffs.",
	["Binds/Commands"]="Binds:\n\nF2 - opens the Selfpanel ui\nF3 - opens the Vehpanel\nF9 - opens the Achievementpanel\nI - to opens the inventory\nT - to write in the local-chat\nZ - to write in the global-chat\nY - to write in the team-chat\nB - to show the cursor\n1 - to change your deagle/taser to taser/deagle (Only Police)\n, - to un/lock your privat car\n\n\nCommands:\n\n/staff - to show all online staff-members\n/pay TARGET AMOUNT - to give an another user money\n/eject TARGET - eject a player from your vehicle",
	["Dates"]="Our Discord: "..settings.general.discordurl.."\n\nOur Website: "..settings.general.weburl.."\n\nOur CP: "..settings.general.cpurl.."",
	
	["Team-Police"]="Vehicle Level list:\n\nPolice SF: Level 0\nPolice LV(Patrol): 3\nEnforcer: Level 5\nS.W.A.T: Level 6\nPolice Maverick: Level 3",
	["Team-Grove"]="Vehicle Level list:\n\nGreenwood: Level 0\nBurrito: Level 2\nSavanna: Level 3\nMaverick: Level 3",
	["Team-Ballas"]="Vehicle Level list:\n\nMajestic: Level 0\nBurrito: Level 2\nVoodoo: Level 1\nMaverick: Level 3",
}
local standartHelpmenuTXT="Helpmenu from LakeGaming (Cops 'n' Robbers)"

local function deleteAllUIItems()
	if(isElement(CoD.Button[2]))then
		CoD.Button[2]:destroy()
	end
	if(isElement(CoD.Button[3]))then
		CoD.Button[3]:destroy()
	end
	if(isElement(CoD.Button[4]))then
		CoD.Button[4]:destroy()
	end
end

bindKey("f1","down",function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			dgsSetInputMode("no_binds")
			dgsSetInputMode("no_binds_when_editing")
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-460/2,600,460,settings.general.servername.." - Helppanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Gridlist[1]=dgsCreateGridList(10,10,200,415,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local gridlist=dgsGridListAddColumn(CoD.Gridlist[1],"category",0.9)
			local grid1=dgsGridListAddRow(CoD.Gridlist[1],"Welcome")
			local grid2=dgsGridListAddRow(CoD.Gridlist[1],"Binds/Commands")
			local grid3=dgsGridListAddRow(CoD.Gridlist[1],"Dates")
			local grid4=dgsGridListAddRow(CoD.Gridlist[1],"Team-Police")
			local grid5=dgsGridListAddRow(CoD.Gridlist[1],"Team-Grove")
			local grid6=dgsGridListAddRow(CoD.Gridlist[1],"Team-Ballas")
			
			CoD.Label[1]=dgsCreateLabel(220,15,160,200,standartHelpmenuTXT,false,CoD.Window[1])
			
			
			dgsGridListSetItemText(CoD.Gridlist[1],grid1,gridlist,"Welcome")
			dgsGridListSetItemText(CoD.Gridlist[1],grid2,gridlist,"Binds/Commands")
			dgsGridListSetItemText(CoD.Gridlist[1],grid3,gridlist,"Dates")
			dgsGridListSetItemText(CoD.Gridlist[1],grid4,gridlist,"Team-Police")
			dgsGridListSetItemText(CoD.Gridlist[1],grid5,gridlist,"Team-Grove")
			dgsGridListSetItemText(CoD.Gridlist[1],grid6,gridlist,"Team-Ballas")
			
			dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
			
			addEventHandler("onDgsMouseClick",CoD.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
							if(helpmenueText[clicked])then
								dgsSetText(CoD.Label[1],helpmenueText[clicked])
								if(item==grid3)then
									deleteAllUIItems()
									CoD.Button[2]=dgsCreateButton(490,10,100,20,"Copy Discord URL",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									addEventHandler("onDgsMouseClick",CoD.Button[2],
										function(btn,state)
											if(btn=="left" and state=="up")then
												setClipboard(settings.general.discordurl)
												notificationShow("info","Copied!")
											end
										end,
									false)

									CoD.Button[3]=dgsCreateButton(490,40,100,20,"Copy Website URL",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									addEventHandler("onDgsMouseClick",CoD.Button[3],
										function(btn,state)
											if(btn=="left" and state=="up")then
												setClipboard(settings.general.weburl)
												notificationShow("info","Copied!")
											end
										end,
									false)
									
									CoD.Button[4]=dgsCreateButton(490,70,100,20,"Copy CP URL",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									addEventHandler("onDgsMouseClick",CoD.Button[4],
										function(btn,state)
											if(btn=="left" and state=="up")then
												setClipboard(settings.general.cpurl)
												notificationShow("info","Copied!")
											end
										end,
									false)
								else
									deleteAllUIItems()
								end
							end
						else
							dgsSetText(CoD.Label[1],standartHelpmenuTXT)
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						dgsCloseWindow(CoD.Window[1])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
			
			if(tonumber(syncClientGetElementData("Introtask"))==1)then
				triggerServerEvent("give:helpmenueReward",lp)
			end
			
		end
	end
end)