--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local AchievmentText=nil

function renderAchievment()
	if(isLoggedin(lp))then
		if(getElementData(lp,"ElementClicked")==false)then
			dxDrawImage(0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,":"..settings.general.scriptname.."/files/IMAGES/DeathBAR.png",0,0,0,tocolor(255,255,255,255),false)
			dxDrawText("Achievment reached\n"..AchievmentText.."\n+ $1700",0*Gsx,-9*Gsy,1920*Gsx,1080*Gsy,tocolor(0,200,0,255),1.50,"pricedown","center","center",false,false,false,false,false)
		end
	end
end

addEvent("show:achievment",true)
addEventHandler("show:achievment",root,function(id)
	if(isLoggedin(lp))then
		AchievmentText=globalTables["Achievements"][id][1]
		if(getElementData(lp,"ElementClicked")~=true)then
		addEventHandler("onClientRender",root,renderAchievment)
			if isTimer(achievTimer)then
				achievTimer:destroy()
			end
			achievTimer=setTimer(function()
				removeEventHandler("onClientRender",root,renderAchievment)
			end,10000,1)
		else
			outputChatBox("Achievment reached: "..AchievmentText.." - You get $1700",255,255,255)
		end
	end
end)


local standartAchievementTXT="No Achievement selected!"

addEvent("open:achievmentpanel",true)
addEventHandler("open:achievmentpanel",root,function(tbl)
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-400/2,600,400,settings.general.servername.." - Achievementpanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Gridlist[1]=dgsCreateGridList(10,10,200,355,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			local achievementID=dgsGridListAddColumn(CoD.Gridlist[1],"ID",0.3)
			local achievement=dgsGridListAddColumn(CoD.Gridlist[1],"Achievment",0.8)
			
			CoD.Label[1]=dgsCreateLabel(220,20,100,20,"Achievement: "..standartAchievementTXT,false,CoD.Window[1])
			CoD.Label[2]=dgsCreateLabel(220,50,100,20,"State: ??",false,CoD.Window[1])
			
			CoD.Image[1]=dgsCreateImage(360,150,107,103,":"..settings.general.scriptname.."/files/IMAGES/Achievement/NotReached.png",false,CoD.Window[1])
			
			
			if(#tbl>=1)then
				for i,v in pairs(tbl)do
					local row=dgsGridListAddRow(CoD.Gridlist[1])
					dgsGridListSetItemText(CoD.Gridlist[1],row,achievementID,i,false,false)
					dgsGridListSetItemText(CoD.Gridlist[1],row,achievement,v[1],false,false)
					--guiGridListSetItemColor(CoD.Gridlist[1],row,achievement,Color[v[2]][1],Color[v[2]][2],Color[v[2]][3])
				end
			end
			
			dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
			
			addEventHandler("onDgsMouseClick",CoD.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
							if(clicked~="")then
								triggerServerEvent("get:achievment",lp,clicked)
								dgsSetText(CoD.Label[1],"Achievement: "..globalTables["Achievements"][tonumber(clicked)][2])
							end
						else
							dgsSetText(CoD.Label[1],"Achievement: "..standartAchievementTXT)
							dgsSetText(CoD.Label[2],"State: ??")
							if(isElement(CoD.Image[1]))then
								CoD.Image[1]:destroy()
							end
							CoD.Image[1]=dgsCreateImage(360,150,107,103,":"..settings.general.scriptname.."/files/IMAGES/Achievement/NotReached.png",false,CoD.Window[1])
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

addEvent("set:achievment",true)
addEventHandler("set:achievment",root,function(reached)
	if(reached==0)then
		reached={"NotReached","not reached"}
	else
		reached={"Reached","reached"}
	end
	if(isElement(CoD.Image[1]))then
		CoD.Image[1]:destroy()
	end
	CoD.Image[1]=dgsCreateImage(360,150,107,103,":"..settings.general.scriptname.."/files/IMAGES/Achievement/"..reached[1]..".png",false,CoD.Window[1])
	dgsSetText(CoD.Label[2],"State: "..reached[2])
end)