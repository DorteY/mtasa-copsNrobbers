--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

bindKey("f7","down",function()
	if(isLoggedin())then
		if(tonumber(getElementData(lp,"AdminLVL"))>=1)then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-740/2,GLOBALscreenY/2-450/2,740,450,"Logs",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
				dgsWindowSetSizable(CoD.Window[1],false)
				dgsWindowSetMovable(CoD.Window[1],false)
				CoD.Button[1]=dgsCreateButton(714,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				
				if(tonumber(getElementData(lp,"AdminLVL"))>=5)then
					CoD.Button[2]=dgsCreateButton(615,0,115,30,"clear all logs",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				end
				
				CoD.Label[1]=dgsCreateLabel(10,10,100,20,"All logs",false,CoD.Window[1])
				CoD.Gridlist[1]=dgsCreateGridList(10,30,180,385,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				logs=dgsGridListAddColumn(CoD.Gridlist[1],"Logs",0.9)
				CoD.Memo[1]=dgsCreateMemo(200,30,530,385,"",false,CoD.Window[1],_,_,_,_,tocolor(50,50,50,255))
				dgsMemoSetReadOnly(CoD.Memo[1],true)
				
				for i,_ in pairs(globalTables["logs"])do
					local row=dgsGridListAddRow(CoD.Gridlist[1])
					dgsGridListSetItemText(CoD.Gridlist[1],row,logs,globalTables["logs"][i][1],false,false)
				end
				
				dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
				
				addEventHandler("onDgsMouseDoubleClick",CoD.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("get:logs",lp,clicked)
								end
							end
						end
					end,
				false)
				if(tonumber(getElementData(lp,"AdminLVL"))>=5)then
					addEventHandler("onDgsMouseClick",CoD.Button[2],
						function(btn,state)
							if(btn=="left" and state=="up")then
								dgsCloseWindow(CoD.Window[1])
								setWindowData("remove","cursor_clicked",true)
								triggerServerEvent("delete:logs",lp,lp)
							end
						end,
					false)
				end
				
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

addEvent("set:logs:text",true)
addEventHandler("set:logs:text",root,function(text)
	dgsSetText(CoD.Memo[1],text)
end)





--[[
local wallhackTable={
["Lorenzo"]=true,
["iLimix"]=true,
}

function showPlayerSquares()
	if globalTables["wallhack"][getPlayerName(lp)] then
	local players=getElementsByType("player")
	
	for _, thePlayer in ipairs(players)do
		if thePlayer ~= getLocalPlayer() then
		
		local x,y,z = getElementPosition(thePlayer)
		local cx,cy,cz = getElementPosition(getLocalPlayer())
			if getDistanceBetweenPoints3D(x,y,z, cx,cy,cz) <= 10000 then
				sX, sY, sZ = getScreenFromWorldPosition(x,y,z)
				if(sX and sY and sZ)then
					
					color = tocolor(getPlayerNametagColor(thePlayer))
					size = 1.3
					
					dxDrawText(getPlayerName(thePlayer), sX-25, sY-40, 25, 20, color, size)
					dxDrawText(math.floor(getDistanceBetweenPoints3D(x,y,z, cx,cy,cz)).." m", sX+25, sY-20, 25, 20, color, size)
					dxDrawText("Rüstung: " ..math.floor(getPedArmor(thePlayer)), sX-20, sY+20, 25, 20, color, size)
					--dxDrawText(tostring(getElementData(thePlayer, "blood")), sX+25, sY+0, 25, 20, color, size)
					dxDrawText("Leben: "..math.floor(getElementHealth ( thePlayer )), sX-20, sY+35, 25, 20, color, size)
					
					color = tocolor(255, 255, 255)
					
					x,y,z = getPedBonePosition ( thePlayer, 8)
					x,y = getScreenFromWorldPosition( x, y, z)
					
					x2,y2,z2 = getPedBonePosition ( thePlayer, 2)
					x2,y2 = getScreenFromWorldPosition(x2, y2, z2)
					
					if x and y and x2 and y2 then  
						dxDrawLine(x,y,x2,y2, color, 1.5)
					end
					
					-----------------SHOULDERS-----------------
					
					Hx,Hy,Hz = getPedBonePosition ( thePlayer, 4)
					Hx,Hy = getScreenFromWorldPosition( Hx, Hy, Hz)
					
					Sx2,Sy2,Sz2 = getPedBonePosition ( thePlayer, 22)
					Sx2,Sy2 = getScreenFromWorldPosition(Sx2, Sy2, Sz2)
					
					Sx3,Sy3,Sz3 = getPedBonePosition ( thePlayer, 32)
					Sx3,Sy3 = getScreenFromWorldPosition(Sx3, Sy3, Sz3)
					
					if Hx and Hy and Sx2 and Sy2 then
						dxDrawLine(Hx,Hy,Sx2,Sy2, color, 1.5)
					end
					if Hx and Hy and Sx3 and Sy3 then
						dxDrawLine(Hx,Hy,Sx3,Sy3, color, 1.5)
					end
					
					-----------------UPPER ARMS-----------------
					ERx,ERy,ERz = getPedBonePosition ( thePlayer, 23)
					ERx,ERy = getScreenFromWorldPosition( ERx,ERy,ERz)
					
					ELx,ELy,ELz = getPedBonePosition ( thePlayer, 33)
					ELx,ELy = getScreenFromWorldPosition(ELx,ELy,ELz)
					
					if ERx and ERy and Sx2 and Sy2 then
						dxDrawLine(ERx,ERy,Sx2,Sy2, color, 1.5)
					end
					if ELx and ELy and Sx3 and Sy3 then
						dxDrawLine(ELx,ELy,Sx3,Sy3, color, 1.5)
					end
					
					-----------------LOWER ARMS-----------------
					HRx,HRy,HRz = getPedBonePosition ( thePlayer, 24)
					HRx,HRy = getScreenFromWorldPosition( HRx,HRy,HRz)
					
					HLx,HLy,HLz = getPedBonePosition ( thePlayer, 34)
					HLx,HLy = getScreenFromWorldPosition(HLx,HLy,HLz)
					
					if ERx and ERy and HRx and HRy then
						dxDrawLine(ERx,ERy,HRx,HRy, color, 1.5)
					end
					if ELx and ELy and HLx and HLy then
						dxDrawLine(ELx,ELy,HLx,HLy, color, 1.5)
					end
					
					-----------------UPPER LEGS-----------------
					KRx,KRy,KRz = getPedBonePosition ( thePlayer, 52)
					KRx,KRy = getScreenFromWorldPosition( KRx,KRy,KRz)
					
					KLx,KLy,KLz = getPedBonePosition ( thePlayer, 42)
					KLx,KLy = getScreenFromWorldPosition(KLx,KLy,KLz)
					
					if x2 and y2 and KRx and KRy then  
						dxDrawLine(x2,y2,KRx,KRy, color, 1.5)
					end
					if x2 and y2 and KLx and KLy then
						dxDrawLine(x2,y2,KLx,KLy, color, 1.5)
					end
					
					-----------------LOWER LEGS-----------------
					LRx,LRy,LRz = getPedBonePosition ( thePlayer, 53)
					LRx,LRy = getScreenFromWorldPosition( LRx,LRy,LRz )
					
					LLx,LLy,LLz = getPedBonePosition ( thePlayer, 43)
					LLx,LLy = getScreenFromWorldPosition(LLx,LLy,LLz)
					
					if LRx and LRy and KRx and KRy then
						dxDrawLine(LRx,LRy,KRx,KRy, color, 1.5)
					end
					if LLx and LLy and KLx and KLy then
						dxDrawLine(LLx,LLy,KLx,KLy, color, 1.5)
					end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),showPlayerSquares)]]