--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEventHandler("onClientRender",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"open:selectteamGUI")==false)then
			if(getElementData(lp,"intchange")==false)then
				if(getElementData(lp,"ElementClicked")==false)then
					if(not lp:isDead())then
						if(isPlayerMapVisible(lp)==false)then
							local maxCount,maxCount1="3",3
							
							if(tonumber(syncClientGetElementData("Introtask"))>=0 and tonumber(syncClientGetElementData("Introtask"))<=maxCount1)then
								dxDrawRectangle(1625*Gsx,455*Gsy,280*Gsx,120*Gsy,settings.general.guimaincolor,false)
								dxDrawRectangle(1645*Gsx,490*Gsy,240*Gsx,2*Gsy,tocolor(255,255,255,255),false)
								dxDrawText("Task:",3325*Gsx,460*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
								
								dxDrawText(globalTables["Tasks"][syncClientGetElementData("Introtask")],3325*Gsx,505*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
								dxDrawText(tonumber(syncClientGetElementData("Introtask")).."/"..maxCount.."",3560*Gsx,550*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),0.95*Gsx,dxFONT2,"center",_,_,_,false,_,_)
							end
						end
					end
				end
			end
		end
	end
end)