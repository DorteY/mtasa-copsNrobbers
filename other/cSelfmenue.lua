--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local function deleteAllUIItems()
	if(isElement(CoD.Button[10]))then
		CoD.Button[10]:destroy()
	end
	if(isElement(CoD.Combo[1]))then
		CoD.Combo[1]:destroy()
	end
	if(isElement(CoD.Label[10]))then
		CoD.Label[10]:destroy()
	end
	if(isElement(CoD.Button[11]))then
		CoD.Button[11]:destroy()
	end
	if(isElement(CoD.Combo[2]))then
		CoD.Combo[2]:destroy()
	end
	if(isElement(CoD.Label[11]))then
		CoD.Label[11]:destroy()
	end
	
	if(isElement(CoD.Button[20]))then
		CoD.Button[20]:destroy()
	end
	if(isElement(CoD.Label[20]))then
		CoD.Label[20]:destroy()
	end
	if(isElement(CoD.Label[2.0]))then
		CoD.Label[2.0]:destroy()
	end
	if(isElement(CoD.Edit[20]))then
		CoD.Edit[20]:destroy()
	end
	if(isElement(CoD.Button[21]))then
		CoD.Button[21]:destroy()
	end
	if(isElement(CoD.Label[2.1]))then
		CoD.Label[2.1]:destroy()
	end
	if(isElement(CoD.Label[21]))then
		CoD.Label[21]:destroy()
	end
	if(isElement(CoD.Edit[21]))then
		CoD.Edit[21]:destroy()
	end
	if(isElement(CoD.Button[22]))then
		CoD.Button[22]:destroy()
	end
	if(isElement(CoD.Label[22]))then
		CoD.Label[22]:destroy()
	end
	
	if(isElement(CoD.Button[80]))then
		CoD.Button[80]:destroy()
	end
	if(isElement(CoD.Label[80]))then
		CoD.Label[80]:destroy()
	end
	if(isElement(CoD.Edit[80]))then
		CoD.Edit[80]:destroy()
	end
end

bindKey("f2","down",function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			dgsSetInputMode("no_binds")
			dgsSetInputMode("no_binds_when_editing")
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-460/2,600,460,settings.general.servername.." - Selfpanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Gridlist[1]=dgsCreateGridList(10,10,200,415,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local gridlist=dgsGridListAddColumn(CoD.Gridlist[1],"Settings",0.9)
			local grid1=dgsGridListAddRow(CoD.Gridlist[1],"Radar/Hitsound")
			local grid2=dgsGridListAddRow(CoD.Gridlist[1],"other")
			local grid8=dgsGridListAddRow(CoD.Gridlist[1],"Bonuscode")
			
			
			dgsGridListSetItemText(CoD.Gridlist[1],grid1,gridlist,"Radar/Hitsound")
			dgsGridListSetItemText(CoD.Gridlist[1],grid2,gridlist,"other")
			dgsGridListSetItemText(CoD.Gridlist[1],grid8,gridlist,"Bonuscode")
			
			dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
			
			addEventHandler("onDgsMouseClick",CoD.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
							if(item==grid1)then
								deleteAllUIItems()
							
								CoD.Combo[1]=dgsCreateComboBox(275,45,260,35,"select a radar",false,CoD.Window[1],20,tocolor(0,0,0,255),_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255))
								dgsComboBoxAddItem(CoD.Combo[1],"GTA:SA")
								dgsComboBoxAddItem(CoD.Combo[1],"GTA:IV")
								dgsComboBoxAddItem(CoD.Combo[1],"GTA:V")
								dgsComboBoxAddItem(CoD.Combo[1],"Gangwar")
								
								CoD.Combo[2]=dgsCreateComboBox(275,160,260,35,"select a hitglock",false,CoD.Window[1],20,tocolor(0,0,0,255),_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255))
								dgsComboBoxAddItem(CoD.Combo[2],"deactivate")
								dgsComboBoxAddItem(CoD.Combo[2],"hitglock 1")
								dgsComboBoxAddItem(CoD.Combo[2],"hitglock 2")
								dgsComboBoxAddItem(CoD.Combo[2],"hitglock 3")
								
								
								CoD.Label[10]=dgsCreateLabel(280,25,160,20,"Radar: n/a",false,CoD.Window[1])
								CoD.Button[10]=dgsCreateButton(275,90,260,40,"set radar",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								CoD.Label[11]=dgsCreateLabel(280,140,160,20,"Hitglock: n/a",false,CoD.Window[1])
								CoD.Button[11]=dgsCreateButton(275,205,260,40,"set hitglock",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								if(tonumber(syncClientGetElementData("Radar"))==1)then
									dgsSetText(CoD.Label[10],"Radar: GTA:SA")
								elseif(tonumber(syncClientGetElementData("Radar"))==2)then
									dgsSetText(CoD.Label[10],"Radar: GTA:IV")
								elseif(tonumber(syncClientGetElementData("Radar"))==3)then
									dgsSetText(CoD.Label[10],"Radar: GTA:V")
								elseif(tonumber(syncClientGetElementData("Radar"))==4)then
									dgsSetText(CoD.Label[10],"Radar: Gangwar")
								end
								
								if(tonumber(syncClientGetElementData("Hitglock"))==1)then
									dgsSetText(CoD.Label[11],"Hitglock: deactivated")
								elseif(tonumber(syncClientGetElementData("Hitglock"))==2)then
									dgsSetText(CoD.Label[11],"Hitglock: 1")
								elseif(tonumber(syncClientGetElementData("Hitglock"))==3)then
									dgsSetText(CoD.Label[11],"Hitglock: 2")
								elseif(tonumber(syncClientGetElementData("Hitglock"))==4)then
									dgsSetText(CoD.Label[11],"Hitglock: 3")
								end
								
								addEventHandler("onDgsMouseClick",CoD.Button[10],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsComboBoxGetSelectedItem(CoD.Combo[1])
											if(tonumber(amount)>=1 and tonumber(amount)<=4)then
												triggerServerEvent("set:settings",lp,"Radar",tonumber(amount))
											end
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",CoD.Button[11],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsComboBoxGetSelectedItem(CoD.Combo[2])
											if(tonumber(amount)>=1 and tonumber(amount)<=4)then
												triggerServerEvent("set:settings",lp,"Hitglock",tonumber(amount))
											end
										end
									end,
								false)
								
							elseif(item==grid2)then
								deleteAllUIItems()
								
								CoD.Edit[20]=dgsCreateEdit(275,45,260,35,"",false,CoD.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								CoD.Edit[21]=dgsCreateEdit(275,175,260,35,"",false,CoD.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								
								CoD.Label[2.0]=dgsCreateLabel(250,10,160,20,"loudness (Explosions,Infobox,UI(GUI))",false,CoD.Window[1])
								CoD.Label[20]=dgsCreateLabel(280,25,160,20,"loudness: "..tonumber(syncClientGetElementData("Soundvolume")).."%",false,CoD.Window[1])
								CoD.Label[2.1]=dgsCreateLabel(280,140,160,20,"With over 70 fps you can't move when you aim.",false,CoD.Window[1])
								CoD.Label[21]=dgsCreateLabel(280,155,160,20,"FPS: "..tonumber(syncClientGetElementData("FPSLIMIT")).." (max.30-100)",false,CoD.Window[1])
								CoD.Button[20]=dgsCreateButton(275,85,260,35,"set loudness",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								CoD.Button[21]=dgsCreateButton(275,215,260,35,"set fps",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								CoD.Label[22]=dgsCreateLabel(280,290,160,20,"Autologin: ",false,CoD.Window[1])
								CoD.Button[22]=dgsCreateButton(275,310,260,35,"de/activate",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								
								if(tonumber(syncClientGetElementData("Autologin"))==1)then
									dgsSetText(CoD.Label[22],"Autologin: activated")
								elseif(tonumber(syncClientGetElementData("Autologin"))==0)then
									dgsSetText(CoD.Label[22],"Autologin: deactivated")
								end
								
								addEventHandler("onDgsMouseClick",CoD.Button[20],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsGetText(CoD.Edit[20])
											if(tonumber(amount)>=0 and tonumber(amount)<=100)then
												triggerServerEvent("set:settings",lp,"Sound",tonumber(amount))
											end
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",CoD.Button[21],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=dgsGetText(CoD.Edit[21])
											if(tonumber(amount)>=30 and tonumber(amount)<=100)then
												setFPSLimit(tonumber(amount))
												triggerServerEvent("set:settings",lp,"FPSLIMIT",tonumber(amount))
											end
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",CoD.Button[22],
									function(btn,state)
										if(btn=="left" and state=="down")then
											if(tonumber(syncClientGetElementData("Autologin"))==0)then
												dgsSetText(CoD.Label[22],"Autologin: activated")
												triggerServerEvent("set:settings",lp,"Autologin",1)
											elseif(tonumber(syncClientGetElementData("Autologin"))==1)then
												dgsSetText(CoD.Label[22],"Autologin: deactivated")
												triggerServerEvent("set:settings",lp,"Autologin",0)
											end
										end
									end,
								false)
								
							elseif(item==grid8)then
								deleteAllUIItems()
								
								CoD.Edit[80]=dgsCreateEdit(275,45,260,35,"",false,CoD.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								
								CoD.Label[80]=dgsCreateLabel(280,25,160,20,"Bonuscode (Normal):",false,CoD.Window[1])
								CoD.Button[80]=dgsCreateButton(275,90,260,35,"use bonuscode",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								
								addEventHandler("onDgsMouseClick",CoD.Button[80],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local code=dgsGetText(CoD.Edit[80])
											triggerServerEvent("use:bonuscode",lp,"Normal",code)
										end
									end,
								false)
								
							end
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
end)

addEvent("refresh:selfmenu",true)
addEventHandler("refresh:selfmenu",root,function(typ)
	if(typ=="Radar")then
		if(tonumber(syncClientGetElementData("Radar"))==1)then
			dgsSetText(CoD.Label[10],"Radar: GTA:SA")
		elseif(tonumber(syncClientGetElementData("Radar"))==2)then
			dgsSetText(CoD.Label[10],"Radar: GTA:IV")
		elseif(tonumber(syncClientGetElementData("Radar"))==3)then
			dgsSetText(CoD.Label[10],"Radar: GTA:V")
		elseif(tonumber(syncClientGetElementData("Radar"))==4)then
			dgsSetText(CoD.Label[10],"Radar: Gangwar")
		end
	elseif(typ=="Hitglock")then
		if(tonumber(syncClientGetElementData("Hitglock"))==1)then
			dgsSetText(CoD.Label[11],"Hitglock: deactivated")
		elseif(tonumber(syncClientGetElementData("Hitglock"))==2)then
			dgsSetText(CoD.Label[11],"Hitglock: 1")
		elseif(tonumber(syncClientGetElementData("Hitglock"))==3)then
			dgsSetText(CoD.Label[11],"Hitglock: 2")
		elseif(tonumber(syncClientGetElementData("Hitglock"))==4)then
			dgsSetText(CoD.Label[11],"Hitglock: 3")
		end
	elseif(typ=="Sound")then
		dgsSetText(CoD.Label[20],"loudness: "..tonumber(syncClientGetElementData("Soundvolume")).."%")
	elseif(typ=="FPSLIMIT")then
		dgsSetText(CoD.Label[21],"FPS: "..tonumber(syncClientGetElementData("FPSLIMIT")).." (max.30-100)")
	elseif(typ=="Autologin")then
		if(tonumber(syncClientGetElementData("Autologin"))==1)then
			dgsSetText(CoD.Label[22],"Autologin: activated")
		else
			dgsSetText(CoD.Label[22],"Autologin: deactivated")
		end
	end
end)