--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("open:staat_weaponshop_gui",true)
addEventHandler("open:staat_weaponshop_gui",root,function()
	if(not lp:isInVehicle())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-480/2,GLOBALscreenY/2-420/2,480,420,"weapon store",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(454,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			dgsCreateImage(10,10,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/3.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[2]=dgsCreateButton(80,10,140,60,"Nitestick\nlevel needed: "..settings.teams.weaponprice.stickLVL.."\n$"..settings.teams.weaponprice.stick,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(10,80,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/22.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[3]=dgsCreateButton(80,80,140,60,"Colt45\nlevel needed: "..settings.teams.weaponprice.coltLVL.."\n$"..settings.teams.weaponprice.colt45,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(10,150,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/24.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[4]=dgsCreateButton(80,150,140,60,"Deagle\nlevel needed: "..settings.teams.weaponprice.deagleLVL.."\n$"..settings.teams.weaponprice.deagle,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(10,220,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/29.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[5]=dgsCreateButton(80,220,140,60,"MP5\nlevel needed: "..settings.teams.weaponprice.mp5LVL.."\n$"..settings.teams.weaponprice.mp5,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			dgsCreateImage(260,10,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/31.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[6]=dgsCreateButton(330,10,140,60,"M4\nlevel needed: "..settings.teams.weaponprice.m4LVL.."\n$"..settings.teams.weaponprice.m4,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(260,80,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/33.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[7]=dgsCreateButton(330,80,140,60,"Rifle\nlevel needed: "..settings.teams.weaponprice.rifleLVL.."\n$"..settings.teams.weaponprice.rifle,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(260,150,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/34.png",false,CoD.Window[1],tocolor(255,255,255,255))
			CoD.Button[8]=dgsCreateButton(330,150,140,60,"Sniper\nlevel needed: "..settings.teams.weaponprice.sniperLVL.."\n$"..settings.teams.weaponprice.sniper,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			CoD.Button[12]=dgsCreateButton(10,290,460,40,"Armor\n$"..settings.teams.weaponprice.armor,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[13]=dgsCreateButton(10,340,460,40,"change team skin",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",CoD.Button[13],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("change:teamskin",lp,getElementData(lp,"team"))
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[12],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"armor")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[8],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"sniper")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[7],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"rifle")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[6],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"m4")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[5],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"mp5")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[4],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"deagle")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[3],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"colt45")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"nitestick")
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

addEvent("open:gang_weaponshop_gui",true)
addEventHandler("open:gang_weaponshop_gui",root,function()
	if(not lp:isInVehicle())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			CoD.Window[2]=dgsCreateWindow(GLOBALscreenX/2-480/2,GLOBALscreenY/2-420/2,480,420,"weapon store",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[2],false)
			dgsWindowSetMovable(CoD.Window[2],false)
			CoD.Button[40]=dgsCreateButton(454,-25,26,25,"×",false,CoD.Window[2],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			dgsCreateImage(10,10,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/3.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[41]=dgsCreateButton(80,10,140,60,"Nitestick\nlevel needed: "..settings.teams.weaponprice.stickLVL.."\n$"..settings.teams.weaponprice.stick,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(10,80,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/22.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[42]=dgsCreateButton(80,80,140,60,"Colt45\nlevel needed: "..settings.teams.weaponprice.coltLVL.."\n$"..settings.teams.weaponprice.colt45,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(10,150,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/24.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[43]=dgsCreateButton(80,150,140,60,"Deagle\nlevel needed: "..settings.teams.weaponprice.deagleLVL.."\n$"..settings.teams.weaponprice.deagle,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(10,220,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/29.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[44]=dgsCreateButton(80,220,140,60,"MP5\nlevel needed: "..settings.teams.weaponprice.mp5LVL.."\n$"..settings.teams.weaponprice.mp5,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			dgsCreateImage(260,10,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/31.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[45]=dgsCreateButton(330,10,140,60,"M4\nlevel needed: "..settings.teams.weaponprice.m4LVL.."\n$"..settings.teams.weaponprice.m4,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(260,80,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/33.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[46]=dgsCreateButton(330,80,140,60,"Rifle\nlevel needed: "..settings.teams.weaponprice.rifleLVL.."\n$"..settings.teams.weaponprice.rifle,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			dgsCreateImage(260,150,60,60,":"..settings.general.scriptname.."/files/IMAGES/Hud/Weapons/34.png",false,CoD.Window[2],tocolor(255,255,255,255))
			CoD.Button[47]=dgsCreateButton(330,150,140,60,"Sniper\nlevel needed: "..settings.teams.weaponprice.sniperLVL.."\n$"..settings.teams.weaponprice.sniper,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			CoD.Button[51]=dgsCreateButton(10,290,460,40,"Armor\n$"..settings.teams.weaponprice.armor,false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[52]=dgsCreateButton(10,340,460,40,"change team skin",false,CoD.Window[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",CoD.Button[52],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("change:teamskin",lp,getElementData(lp,"team"))
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[51],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"armor")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[47],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"sniper")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[46],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"rifle")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[45],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"m4")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[44],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"mp5")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[43],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"deagle")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[42],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"colt45")
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[41],
				function(btn,state)
					if(btn=="left" and state=="up")then
						triggerServerEvent("buy:staat_gang:weapons",lp,lp,"nitestick")
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[40],
				function(btn,state)
					if(btn=="left" and state=="up")then
						dgsCloseWindow(CoD.Window[2])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
			
		end
	end
end)