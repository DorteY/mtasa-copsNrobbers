--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function tachoRender_Func()
	if(isLoggedin())then
		if(lp:isInVehicle())then
			if(not lp:isDead())then
				if(isPlayerMapVisible(lp)==false)then
					if(getElementData(lp,"InTuninggarage")~=true)then
						local veh=getPedOccupiedVehicle(lp)
						local vehspeed=getElementSpeed(veh)
						if not CDN:getReady()then
							return
						end
						
						dxDrawImage(Gsx*1650,Gsy*850,Gsx*250,Gsy*250,"files/IMAGES/Speedo/1_Speedo.png",0,0,0,tocolor(255,255,255,200),false)
						dxDrawText(getFormatGear(),3360*Gsx,Gsy*960,Gsx*100,Gsy*20,tocolor(0,0,0,255),1.4*Gsx,dxFONT4,"center",_,_,_,false,_,_)
						dxDrawImage(Gsx*1650,Gsy*850,Gsx*250,Gsy*250,"files/IMAGES/Speedo/1_Needle.png",vehspeed,0,0,tocolor(255,255,255,200),false)
						
					end
				end
			end
		else
			removeEventHandler("onClientRender",root,tachoRender_Func)
		end
	end
end

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==lp)then
		removeEventHandler("onClientRender",root,tachoRender_Func)
		addEventHandler("onClientRender",root,tachoRender_Func)
	end
end)
addEventHandler("onClientVehicleExit",root,function(player)
	if(player==lp)then
		removeEventHandler("onClientRender",root,tachoRender_Func)
	end
end)

function getFormatGear()
    local gear=getVehicleCurrentGear(getPedOccupiedVehicle(lp))
    local rear="R"
	local neutral="N"
    if(gear>0)then 
        return gear
    else
        return rear
    end
end