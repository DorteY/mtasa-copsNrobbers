--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local customPickups={}

function createCmarker(x,y,z,int,dim,image,uimage,size,vehicleallowed,func)
	local pickup={x=x,y=y,z=z,int=int,dim=dim,image=image,uimage=uimage,size=size,vehicleallowed=vehicleallowed,func=func}
	if(uimage)then
		uimage=":"..settings.general.scriptname.."/files/IMAGES/cMarker/"..uimage..".png"
	else
		uimage=":"..settings.general.scriptname.."/files/IMAGES/Transparent.png"
	end
	local colShape=createColSphere(x,y,z,size)
	if(colShape)then
		setElementID(colShape,"customPickup")
		setElementData(colShape,"customPickup.image",image)
		setElementData(colShape,"customPickup.uimage",uimage)
		setElementData(colShape,"customPickup.positions",{x,y,z})
		if(vehicleallowed==true)then
			addEventHandler("onColShapeHit",colShape,eventCustomPickupV)
		elseif(vehicleallowed==false)then
			addEventHandler("onColShapeHit",colShape,eventCustomPickup)
		end
		pickup.colshape=colShape
		customPickups[tostring(colShape)]=pickup
	end
end

function eventCustomPickup(player)
    if(getElementID(source)=="customPickup" and getElementType(player)=="player")then
		if(not gotLastHit[player] or gotLastHit[player]+lastHitMarkerTimer<=getTickCount())then
			customPickups[tostring(source)].func(player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Wait 30 seconds after the last hit/shot!",7500)
		end
    end
end
function eventCustomPickupV(player)
    if(getElementID(source)=="customPickup" and getElementType(player)=="vehicle")then
		customPickups[tostring(source)].func(player)
    end
end