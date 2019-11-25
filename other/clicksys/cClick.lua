--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

setCursorAlpha(0)
addEventHandler("onClientRender",root,function()
	if(isCursorShowing()and isConsoleActive()==false and isMainMenuActive()==false)then
		local sX,sY,wX,wY,wZ=getCursorPosition()
		dxDrawImage((sX*GLOBALscreenX),(sY*GLOBALscreenY),32,32,":"..settings.general.scriptname.."/files/IMAGES/Cursor/Cursor.png",0,0,0,tocolor(255,255,255),true)
	end
end)
addEventHandler("onClientResourceStop",resourceRoot,function()
	setCursorAlpha(255)
end)


addEventHandler("onClientRender",root,function()
	if(isCursorShowing()and getElementData(lp,"ElementClicked")==false and isLoggedin(lp))then
		local x,y,z=getElementPosition(lp)
		local cX,cY,cwX,cwY,cwZ=getCursorPosition()
		local pX,pY,pZ=getCameraMatrix(lp)
		local textLeft,textMiddle,textRight,show=".",".",".",false
		local hit,hX,hY,hZ,hitElement,nX,nY,nZ,material,lightning,piece,worldModelID,worldModelPos,worldModelRot,worldLODModelID=processLineOfSight(pX,pY,pZ,cwX,cwY,cwZ,true,true,true,true,true,false,false,false,nil,true,true)
		
		if((not hX or not hY or not hZ)or getDistanceBetweenPoints3D(x,y,z,hX,hY,hZ)<15)then
			if(hit and(hitElement and isElement(hitElement))or tonumber(worldModelID)~=nil)then
				
				local modelID=0
				local eType=""
				if(hitElement)then
					modelID=getElementModel(hitElement)
					eType=getElementType(hitElement)
				else
					modelID=worldModelID
					eType="object"
					hitElement=nil
				end
				if(eType=="object")then
					if(modelID==2942 or modelID==3903)then--ATM
						textLeft="to rob the ATM"
						textMiddle=false
						textRight=false
						show=true
					elseif(hitElement and modelID==1829 or modelID==2332)then--bank tresor
						local state=getElementData(hitElement,"state")
						textLeft=false
						show=true
						if(state=="closed")then
							textLeft="to open"
						elseif(state=="open")then
							textLeft="Empty vault"
						else
							show=false
						end
						textMiddle=false
						textRight=false
					end
				end
				if(show==true)then
					if(textLeft)then
						dxDrawImage((GLOBALscreenX*cX)-50,(GLOBALscreenY*cY)-6,32,32,":"..settings.general.scriptname.."/files/IMAGES/Cursor/Left_Click.png")
						dxDrawText(textLeft,((GLOBALscreenX*cX)-100)+1,((GLOBALscreenY*cY)+25)+1,((GLOBALscreenX*cX)+34)+1,((GLOBALscreenY*cY)+66)+1,tocolor(0,0,0),1,dxFONT2,"center","top")
						dxDrawText(textLeft,(GLOBALscreenX*cX)-100,(GLOBALscreenY*cY)+25,(GLOBALscreenX*cX)+34,(GLOBALscreenY*cY)+66,tocolor(50,50,50),1,dxFONT2,"center","top")
					end
					if(textRight)then
						dxDrawImage((GLOBALscreenX*cX)+50,(GLOBALscreenY*cY)-6,32,32,":"..settings.general.scriptname.."/files/IMAGES/Cursor/Right_Click.png")
						dxDrawText(textRight,((GLOBALscreenX*cX)+34)+1,((GLOBALscreenY*cY)+25)+1,((GLOBALscreenX*cX)+100)+1,((GLOBALscreenY*cY)+66)+1,tocolor(0,0,0),1,dxFONT2,"center","top")
						dxDrawText(textRight,(GLOBALscreenX*cX)+34,(GLOBALscreenY*cY)+25,(GLOBALscreenX*cX)+100,(GLOBALscreenY*cY)+66,tocolor(50,50,50),1,dxFONT2,"center","top")--"default-bold"
					end	
				end
				
			end
		end
	end
end)