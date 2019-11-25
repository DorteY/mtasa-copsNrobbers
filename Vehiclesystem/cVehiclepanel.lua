--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("open:uservehpanel",true)
addEventHandler("open:uservehpanel",root,function(tbl)
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-440/2,400,440,settings.general.servername.." - Vehpanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Button[2]=dgsCreateButton(260,10,125,35,"spawn vehicle",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[3]=dgsCreateButton(260,55,125,35,"despawn vehicle",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[4]=dgsCreateButton(260,100,125,45,"sell vehicle\n75% refund\n(without tunings)",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Gridlist[1]=dgsCreateGridList(10,10,240,395,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local id=dgsGridListAddColumn(CoD.Gridlist[1],"ID",0.15)
			local veh=dgsGridListAddColumn(CoD.Gridlist[1],"vehicle",0.6)
			local slot=dgsGridListAddColumn(CoD.Gridlist[1],"slot",0.1)
			
			CoD.Image[1]=dgsCreateImage(265,250,115,85,":"..settings.general.scriptname.."/files/IMAGES/LogoWhite.png",false,CoD.Window[1])
			
			if(#tbl>=1)then
				for _,v in pairs(tbl)do 
					local row=dgsGridListAddRow(CoD.Gridlist[1])
					dgsGridListSetItemText(CoD.Gridlist[1],row,id,v[1],false,false)
					dgsGridListSetItemText(CoD.Gridlist[1],row,veh,v[2],false,false)
					dgsGridListSetItemText(CoD.Gridlist[1],row,slot,v[3],false,false)
				end
			end
			
			dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[4],
				function(btn,state)
					if btn=="left" and state=="down" then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),3)
							if(clicked~="")then
								triggerServerEvent("sell:vehicle",lp,getPlayerName(lp),clicked)
								dgsCloseWindow(CoD.Window[1])
								setWindowData("remove","cursor_clicked",false)
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[3],
				function(btn,state)
					if btn=="left" and state=="down" then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),3)
							if(clicked~="")then
								triggerServerEvent("despawn:vehicle",lp,getPlayerName(lp),clicked)
							end
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if btn=="left" and state=="down" then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),3)
							if(clicked~="")then
								triggerServerEvent("spawn:vehicle",lp,getPlayerName(lp),clicked)
							end
						end
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[1],
				function(btn,state)
					if btn=="left" and state=="up" then
						dgsCloseWindow(CoD.Window[1])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
		end
	end
end)