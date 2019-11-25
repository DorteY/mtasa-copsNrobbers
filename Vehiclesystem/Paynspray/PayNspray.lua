--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local PNSStationsTable={
	[1]=createColSphere(-1904.3,285.5,41.4,3),
	[2]=createColSphere(1976.6,2162.4,9.6,3),
	[3]=createColSphere(-99.8,1118.4,18.3,3),
	[4]=createColSphere(2061.2,-1831.6,13.5,3),
	[5]=createColSphere(720.2,-455.8,16.3,3),
	[6]=createColSphere(1024.9,-1023.7,32.1,3),
	[7]=createColSphere(487.3,-1741.6,11.1,3)
}

setGarageOpen(36,true)
setGarageOpen(41,true)
setGarageOpen(8,true)
setGarageOpen(47,true)
setGarageOpen(11,true)
setGarageOpen(12,true)
setGarageOpen(19,true)

syncSetElementData(PNSStationsTable[1],"gateID",19)
syncSetElementData(PNSStationsTable[2],"gateID",36)
syncSetElementData(PNSStationsTable[3],"gateID",41)
syncSetElementData(PNSStationsTable[4],"gateID",8)
syncSetElementData(PNSStationsTable[5],"gateID",47)
syncSetElementData(PNSStationsTable[6],"gateID",11)
syncSetElementData(PNSStationsTable[7],"gateID",12)


function paynSprayRepair(hitElement)
	if(hitElement and isElement(hitElement)and getElementType(hitElement)=="vehicle")then
		if(getVehicleOccupant(hitElement,0))then
			local player=getVehicleOccupant(hitElement,0)
			if(getElementDimension(hitElement)==getElementDimension(player))then
				if(syncGetElementData(hitElement,"owner")==syncGetElementData(player,"team")or syncGetElementData(hitElement,"owner")==getPlayerName(player))then
					if(getElementHealth(getPedOccupiedVehicle(player))<1000)then
						if(getPlayerSelfMoney(player,"money")>=150)then
							takePlayerSelfMoney(player,"money",150)
							local x,y,z=player:getPosition()
							if(hitElement:getVehicleType()~="Plane" and hitElement:getVehicleType()~="Helicopter" and hitElement:getVehicleType()~="Boat" and hitElement:getVehicleType()~="Train" and hitElement:getVehicleType()~="Trailer")then
								player:setFrozen(true)
								hitElement:setFrozen(true)
								if(isGarageOpen(syncGetElementData(source,"gateID"))~=false)then
									setGarageOpen(syncGetElementData(source,"gateID"),false)
								end
								setTimer(paynSprayRepair_Func,4500,1,hitElement,player,syncGetElementData(source,"gateID"))
							end
						else
							notificationShow(player,"error","You do have not enough money! ($150)")
						end
					else
						notificationShow(player,"error","Your vehicle does not need to be repaired!")
					end
				end
			end
		end
	end
end
for i=1,#PNSStationsTable do
	addEventHandler("onColShapeHit",PNSStationsTable[i],paynSprayRepair)
end


function paynSprayRepair_Func(veh,player,gateID)
	if(not isGarageOpen(gateID))then
		setGarageOpen(gateID,true)
	end
	playSoundFrontEnd(player,46)
	player:setFrozen(false)
	veh:fix()
	veh:setFrozen(false)
	if(syncGetElementData(veh,"veharmor")==1)then
		veh:setHealth(1500)
	elseif(syncGetElementData(veh,"veharmor")==2)then
		veh:setHealth(1700)
	elseif(syncGetElementData(veh,"veharmor")==3)then
		veh:setHealth(1900)
	end
	notificationShow(player,"success","Your vehicle was fixxed! ($150)")
end