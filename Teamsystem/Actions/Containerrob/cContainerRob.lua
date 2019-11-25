--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("show:containerrobtimer",true)
addEventHandler("show:containerrobtimer",root,function(time)
	if(isTimer(cATMrobTimer))then
		killTimer(cATMrobTimer)
	end
	timer=time
	
	addEventHandler("onClientRender",root,drawContainerrobTimer)
	cATMrobTimer=setTimer(function()
		timer=timer-1
		if(timer==0)then
			removeEventHandler("onClientRender",root,drawContainerrobTimer)
			if(isTimer(cATMrobTimer))then killTimer(cATMrobTimer)end
		end
	end,1000,timer)
end)

function drawContainerrobTimer()
	if(not lp:isDead())then
		if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
			dxDrawRectangle(1625*Gsx,595*Gsy,280*Gsx,120*Gsy,settings.general.guimaincolor,false)
			dxDrawRectangle(1645*Gsx,630*Gsy,240*Gsx,2*Gsy,tocolor(255,255,255,255),false)
			dxDrawText("Container-rob timer",3325*Gsx,600*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
			dxDrawText(timer.." seconds...",3325*Gsx,645*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
		end
	end
end