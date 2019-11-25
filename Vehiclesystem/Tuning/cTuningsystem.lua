--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("open:tuningpanel",true)
addEventHandler("open:tuningpanel",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			Tuningsystem.kameraPos=1
			
			setWindowData("add","cursor_clicked",true)
			if(not isElement(CoD.Music[1]))then
				CoD.Music[1]=playSound(":"..settings.general.scriptname.."/files/SOUNDS/Tuningshop.mp3",true)
				setSoundVolume(CoD.Music[1],syncClientGetElementData("Soundvolume"))
			end
			CoD.Window[1]=dgsCreateWindow(5,5,600,410,settings.general.servername.." - Tuningsystem    (Moveable)",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],true)
			dgsBlur(CoD.Window[1],true)
			CoD.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Image[1]=dgsCreateImage(460,280,115,85,":"..settings.general.scriptname.."/files/IMAGES/LogoWhite.png",false,CoD.Window[1])
			
			CoD.Gridlist[1]=dgsCreateGridList(10,10,180,365,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			CoD.Gridlist[2]=dgsCreateGridList(200,10,235,365,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local category=dgsGridListAddColumn(CoD.Gridlist[1]," category",0.9)
			local id=dgsGridListAddColumn(CoD.Gridlist[2]," ID",0.25)
			local part=dgsGridListAddColumn(CoD.Gridlist[2]," part",0.49)
			local price=dgsGridListAddColumn(CoD.Gridlist[2]," price",0.3)
			
			for _,v in pairs(Tuningsystem["Categorys"])do
				local row=dgsGridListAddRow(CoD.Gridlist[1])
				dgsGridListSetItemText(CoD.Gridlist[1],row,category,v,false,false)
			end
			
			CoD.Button[2]=dgsCreateButton(460,10,115,35,"install tuningpart",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[3]=dgsCreateButton(460,60,115,35,"uninstall tuningpart",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Label[1]=dgsCreateLabel(470,200,100,20,"Press <- or ->\nto move the camera",false,CoD.Window[1],_,_,_,_,_,_,"center",_)
			
			dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
			dgsGridListSetSortEnabled(CoD.Gridlist[2],false)
			
			bindKey("arrow_r","down",bindRightTuningsys_Func)
			bindKey("arrow_l","down",bindLeftTuningsys_Func)
			setCameraTuningsys_Func()
			
			local veh=getPedOccupiedVehicle(lp)
			
			addEventHandler("onDgsMouseClick",CoD.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
							if(clicked~="")then
								if(clicked=="color")then
									dgsCloseWindow(CoD.Window[1])
									CoD.Window[2]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-375/2,300,375,settings.general.servername.." - Tuning Colorpicker",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
									CoD.CPicker[1]=dgsCreateColorPicker("HSVRing",5,25,285,265,false,CoD.Window[2])
									dgsWindowSetSizable(CoD.Window[2],false)
									dgsWindowSetMovable(CoD.Window[2],false)
									
									local CPr,CPg,CPb=dgsColorPickerGetColor(CoD.CPicker[1],"RGB")
									setVehicleColor(getPedOccupiedVehicle(lp),CPr,CPg,CPb,CPr,CPg,CPb)
									CoD.Label[2]=dgsCreateLabel(100,5,100,20,"R: "..CPr.." G: "..CPg.." B: "..CPb.."",false,CoD.Window[2],_,_,_,_,_,_,"center",_)
									
									CoD.Button[4]=dgsCreateButton(274,-25,26,25,"×",false,CoD.Window[2],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
									CoD.Button[5]=dgsCreateButton(5,310,290,35,"change color (0$)",false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									
									
									addEventHandler("onDgsRender",root,
										function()
											if(isElement(CoD.CPicker[1])and isElement(CoD.Label[2])and isElement(CoD.Window[2]))then
												local CPr,CPg,CPb=dgsColorPickerGetColor(CoD.CPicker[1],"RGB")
												setVehicleColor(getPedOccupiedVehicle(lp),CPr,CPg,CPb,CPr,CPg,CPb)
												setVehicleHeadLightColor(getPedOccupiedVehicle(lp),CPr,CPg,CPb)
												dgsSetText(CoD.Label[2],"R: "..CPr.." G: "..CPg.." B: "..CPb.."")
											end
										end
									)
									
									
									addEventHandler("onDgsMouseClick",CoD.Button[4],
										function(btn,state)
											if(btn=="left" and state=="down")then
												dgsCloseWindow(CoD.Window[2])
												setElementData(lp,"ElementClicked",false)
												triggerEvent("open:tuningpanel",lp)
												triggerServerEvent("load:vehicletunings",lp,getPedOccupiedVehicle(lp))
											end
										end,
									false)
									addEventHandler("onDgsMouseClick",CoD.Button[5],
										function(btn,state)
											if(btn=="left" and state=="down")then
												local CPr,CPg,CPb=dgsColorPickerGetColor(CoD.CPicker[1],"RGB")
												triggerServerEvent("set:vehiclecolor",lp,CPr,CPg,CPb)
											end
										end,
									false)
								else
									dgsGridListClear(CoD.Gridlist[2])
									local model=getElementModel(getPedOccupiedVehicle(lp))
									for _,v in pairs(Tuningsystem["Tuningparts"][clicked])do
										if(isTuningteilAvailable(model,v))then
											local row=dgsGridListAddRow(CoD.Gridlist[2])
											dgsGridListSetItemText(CoD.Gridlist[2],row,id,v,false,false)
											dgsGridListSetItemText(CoD.Gridlist[2],row,part,Tuningsystem["Tuningnames"][v],false,false)
											dgsGridListSetItemText(CoD.Gridlist[2],row,price,Tuningsystem["Tuningpreise"][v],false,false)
										end
									end
								end
							end
						else
							dgsGridListClear(CoD.Gridlist[2])
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Gridlist[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[2])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[2],dgsGridListGetSelectedItem(CoD.Gridlist[2]),1)
							if(clicked~="")then
								triggerServerEvent("load:vehicletunings",lp,getPedOccupiedVehicle(lp))
								triggerServerEvent("addremoveshow:tuningpart",lp,"normal","show",_,clicked)
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[2],dgsGridListGetSelectedItem(CoD.Gridlist[2]),1)
							if(clicked~="")then
								triggerServerEvent("addremoveshow:tuningpart",lp,"normal","remove",_,clicked)
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[2],dgsGridListGetSelectedItem(CoD.Gridlist[2]),1)
							if(clicked~="")then
								if(clicked=="speedo")then
									local price=dgsGridListGetItemText(CoD.Gridlist[2],dgsGridListGetSelectedItem(CoD.Gridlist[2]),3)
									if(price~="")then
										triggerServerEvent("addremoveshow:tuningpart",lp,"special","add",price,clicked)
									end
								else
									local price=dgsGridListGetItemText(CoD.Gridlist[2],dgsGridListGetSelectedItem(CoD.Gridlist[2]),3)
									if(price~="")then
										triggerServerEvent("addremoveshow:tuningpart",lp,"normal","add",price,clicked)
									end
								end
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[1],
				function(btn,state)
					if(btn=="left" and state=="down")then
						dgsCloseWindow(CoD.Window[1])
						setWindowData("remove","cursor_clicked",true)
						CoD.Music[1]:destroy()
					end
				end,
			false)
			
		end
	end
end)


function isTuningteilAvailable(model,id)
	local state=false
	for _,v in pairs(Tuningsystem["AvailableTunings"][model])do
		if(v==tonumber(id))then
			state=true
			break
		end
	end
	return state
end

function setCameraTuningsys_Func()
	local tbl=Tuningsystem["Kamera"][Tuningsystem.kameraPos]
	setCameraMatrix(tbl[1],tbl[2],tbl[3],tbl[4],tbl[5],tbl[6])
end

function bindRightTuningsys_Func()
	if(Tuningsystem.kameraPos<#Tuningsystem["Kamera"])then
		Tuningsystem.kameraPos=Tuningsystem.kameraPos+1
		setCameraTuningsys_Func()
	end
end

function bindLeftTuningsys_Func()
	if(Tuningsystem.kameraPos>1)then
		Tuningsystem.kameraPos=Tuningsystem.kameraPos-1
		setCameraTuningsys_Func()
	end
end