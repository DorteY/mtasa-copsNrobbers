--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

bindKey("f4","down",function()
	if(isLoggedin())then
		if(tonumber(getElementData(lp,"AdminLVL"))>=1)then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-700/2,GLOBALscreenY/2-500/2,700,500,settings.general.servername.." - Adminpanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(CoD.Window[1],false)
				dgsWindowSetMovable(CoD.Window[1],false)
				CoD.Button[1]=dgsCreateButton(674,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				
				CoD.Gridlist[1]=dgsCreateGridList(10,10,200,390,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				playerGridlist=dgsGridListAddColumn(CoD.Gridlist[1]," Online players",0.9)
				
				CoD.Label[1]=dgsCreateLabel(220,15,160,200,"Player datas:",false,CoD.Window[1])
				CoD.Label[2]=dgsCreateLabel(220,35,160,200,"Armor:",false,CoD.Window[1])
				CoD.Label[3]=dgsCreateLabel(220,50,160,200,"Health:",false,CoD.Window[1])
				CoD.Label[4]=dgsCreateLabel(220,65,160,200,"Team:",false,CoD.Window[1])
				CoD.Label[6]=dgsCreateLabel(220,95,160,200,"Playingtime:",false,CoD.Window[1])
				CoD.Label[7]=dgsCreateLabel(220,110,160,200,"Premiumtime:",false,CoD.Window[1])
				
				
				CoD.Button[2]=dgsCreateButton(450,10,115,30,"kick player",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[3]=dgsCreateButton(450,90,115,30,"ban player",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[4]=dgsCreateButton(450,50,115,30,"tempban player",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[5]=dgsCreateButton(575,10,115,30,"mute player",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[6]=dgsCreateButton(575,50,115,30,"unmute player",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[10]=dgsCreateButton(450,170,115,30,"set adminlvl",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[11]=dgsCreateButton(575,170,115,30,"set premiumlvl",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				CoD.Edit[1]=dgsCreateEdit(450,355,240,35,"Kick/Ban/Mute reason",false,CoD.Window[1])
				dgsCreateLabel(450,400,100,20,"ban-time in hours (example: 1=1hour)\nmute-time in minutes (example: 1=1minute)",false,CoD.Window[1])
				CoD.Edit[2]=dgsCreateEdit(450,430,240,35,"Ban/Mute time",false,CoD.Window[1])
				CoD.Edit[3]=dgsCreateEdit(450,280,240,35,"Admin/Premiumlevel",false,CoD.Window[1])
				
				CoD.Button[16]=dgsCreateButton(10,430,130,35,"de/activate global-chat",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
				
				addEventHandler("onDgsMouseClick",CoD.Button[16],
					function(btn,state)
						if(btn=="left" and state=="down")then
							triggerServerEvent("executeAdminServerCMD",lp,"chatsys","global")
						end
					end,
				false)
				
				for _,v in ipairs(getElementsByType("player"))do
					local row=dgsGridListAddRow(CoD.Gridlist[1])
					dgsGridListSetItemText(CoD.Gridlist[1],row,playerGridlist,getPlayerName(v),false,false)
				end
				
				
				addEventHandler("onDgsMouseClick",CoD.Gridlist[1],--onDgsMouseDoubleClick
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								local playername=getPlayerFromName(clicked)
								if(clicked~="")then
									if(isLoggedin(playername))then
										local team=getElementData(playername,"team")or "n/a"
										dgsSetText(CoD.Label[1],"Player datas from: "..clicked)
										dgsSetText(CoD.Label[2],"Armor: "..getPedArmor(playername).." %")
										dgsSetText(CoD.Label[3],"Health: "..getElementHealth(playername).." %")
										dgsSetText(CoD.Label[4],"Team: "..team.."")
										playingtime=tonumber(getElementData(playername,"Playingtime"))
										spielzeit=math.floor(playingtime/60)..":"..(playingtime-math.floor(playingtime/60)*60)
										dgsSetText(CoD.Label[6],"Playingtime: "..spielzeit)
										premiumtime=tonumber(getElementData(playername,"PremiumLVL"))
										premiumtime1=math.floor(premiumtime/60)..":"..(premiumtime-math.floor(premiumtime/60)*60)
										dgsSetText(CoD.Label[7],"Premiumtime: "..premiumtime1.."")
									end
								end
							end
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",CoD.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(CoD.Edit[1])
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								if(reason~="")then
									triggerServerEvent("executeAdminServerCMD",lp,"rkick",clicked.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",CoD.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(CoD.Edit[1])
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								if(reason~="")then
									triggerServerEvent("executeAdminServerCMD",lp,"rban",clicked.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",CoD.Button[4],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(CoD.Edit[1])
							local time=dgsGetText(CoD.Edit[2])
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								if(tonumber(time)>=1 and(reason~=""))then
									triggerServerEvent("executeAdminServerCMD",lp,"tban",clicked.." "..time.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",CoD.Button[5],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local reason=dgsGetText(CoD.Edit[1])
							local time=dgsGetText(CoD.Edit[2])
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								if(reason~="")then
									triggerServerEvent("executeAdminServerCMD",lp,"rmute",clicked.." "..time.." "..reason)
								else
									notificationShow("error","Enter a reason!")
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",CoD.Button[6],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								triggerServerEvent("executeAdminServerCMD",lp,"runmute",clicked)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",CoD.Button[10],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(CoD.Edit[3])or 0
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								triggerServerEvent("executeAdminServerCMD",lp,"setadminlvl",clicked.." "..amount)
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",CoD.Button[11],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(CoD.Edit[3])or 0
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								triggerServerEvent("executeAdminServerCMD",lp,"setpremiumlvl",clicked.." "..amount)
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
				
			end
		end
	end
end)

addCommandHandler("dev",function()
	if(tonumber(getElementData(lp,"AdminLVL"))>=5)then
		local boolean=not getDevelopmentMode()
		setDevelopmentMode(boolean)
	end
end)