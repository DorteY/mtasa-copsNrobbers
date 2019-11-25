--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("buy:vehicle",true)
addEventHandler("buy:vehicle",root,function(vehid,price,spawnx,spawny,spawnz,rotx,roty,rotz)
	local freeslot=0
	local owner=getPlayerName(client)
	
	for i=1,tonumber(syncGetElementData(client,"Vehicleslots"))do
		if(not(Vehicles[owner..i]))then
			freeslot=i
			break
		end
	end
	
	if(getPlayerSelfMoney(client,"money")>=price)then
		if(not(freeslot==0))then
			Vehicles[owner..freeslot]=createVehicle(vehid,spawnx,spawny,spawnz,rotx,roty,rotz,owner)
			
			syncSetElementData(Vehicles[owner..freeslot],"owner",owner)
			syncSetElementData(Vehicles[owner..freeslot],"slot",freeslot)
			
			setVehicleLocked(Vehicles[owner..freeslot],true)
			setVehicleColor(Vehicles[owner..freeslot],0,0,0,0,0,0)
			setElementDimension(Vehicles[owner..freeslot],0)
			
			warpPedIntoVehicle(client,Vehicles[owner..freeslot])
			
			MySQL.handler:exec("INSERT INTO VEHICLES (owner,vehid,SpawnX,Spawny,Spawnz,speedo,veharmor,slot,Health) VALUES ('"..owner.."','"..vehid.."','"..spawnx.."','"..spawny.."','"..spawnz.."','1','0','"..freeslot.."','1000')")
			
			setPlayerAchievement(client,2)
			takePlayerSelfMoney(client,"money",price)
			triggerClientEvent(client,"draw:infobox",root,"success","Your have buyed succesfully a car!",7500)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You do have not enough money! ($"..price..")",7500)
	end
end)

--//Create Privat Vehicles
function loadVehicles(owner)
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","VEHICLES","owner",owner),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(not(isElement(Vehicles[v["owner"]..v["slot"]])))then
				Vehicles[v["owner"]..v["slot"]]=createVehicle(v["vehid"],v["SpawnX"],v["SpawnY"],v["SpawnZ"],0,0,0,v["owner"])
				
				syncSetElementData(Vehicles[v["owner"]..v["slot"]],"owner",v["owner"])
				syncSetElementData(Vehicles[v["owner"]..v["slot"]],"slot",v["slot"])
				syncSetElementData(Vehicles[v["owner"]..v["slot"]],"speedo",v["speedo"])
				syncSetElementData(Vehicles[v["owner"]..v["slot"]],"veharmor",v["veharmor"])
				
				Vehicles[v["owner"]..v["slot"]]:setHealth(v["Health"])
				setVehicleLocked(Vehicles[v["owner"]..v["slot"]],true)
				setElementDimension(Vehicles[v["owner"]..v["slot"]],65535)
				
				loadVehicleTunings(Vehicles[v["owner"]..v["slot"]])
				giveVehicleSpecialUpgrade(Vehicles[v["owner"]..v["slot"]])
			end
		end
	end
end
addEventHandler("onPlayerQuit",root,function()
	for _,v in pairs(getElementsByType("vehicle"))do
		if(syncGetElementData(v,"owner")and syncGetElementData(v,"slot")and syncGetElementData(v,"owner")==getPlayerName(source))then
			v:destroy()
		end
	end
end)






--//Functions
function lockVehicle(player)
	if(player:getDimension()==0 and player:getInterior()==0)then
		for _,v in pairs(getElementsByType("vehicle"))do
			if(syncGetElementData(v,"owner")==getPlayerName(player)or syncGetElementData(v,"owner")==getElementData(player,"team"))then
				if(getElementDimension(v)==getElementDimension(player))then
					local x,y,z=getElementPosition(v)
					if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=3.2)then
						if(isVehicleLocked(v)==false)then
							setVehicleLocked(v,true)
							triggerClientEvent(player,"draw:infobox",root,"info","Vehicle was locked!",7500)
						else
							setVehicleLocked(v,false)
							triggerClientEvent(player,"draw:infobox",root,"info","Vehicle was unlocked!",7500)
						end
					end
				end
			end
		end
	end
end

addEvent("sell:vehicle",true)
addEventHandler("sell:vehicle",root,function(owner,slot)
	local veh=Vehicles[owner..slot]
	if(owner and slot)then
		if(owner==getPlayerName(client))then
			if(veh)then
				local id=getElementModel(veh)
				local price=carPrices[id]
				
				veh:destroy()
				MySQL.handler:exec("DELETE FROM ?? WHERE ??=? and ??=?","VEHICLES","owner",owner,"slot",slot)
				givePlayerSelfMoney(client,"money",price/100*75)
				
				triggerClientEvent(client,"draw:infobox",root,"success","You have succesfully selled your vehicle!",8500)
			end
		end
	end
end)

addEvent("spawn:vehicle",true)
addEventHandler("spawn:vehicle",root,function(owner,slot)
	local veh=Vehicles[owner..slot]
	if(client:getDimension()==0 and client:getInterior()==0)then
		if(owner and slot)then
			if(owner==getPlayerName(client))then
				if(veh)then
					if(veh:getDimension()==65535)then
						if(isPedInVehicle(client)~=true)then
							local x,y,z=getElementPosition(client)
							local rx,ry,rz=getElementRotation(client)
							local health=MySQL:getVdata(owner,slot,"Health")
							veh:spawn(x,y+5,z+1,0,0,rz)
							veh:setLocked(true)
							veh:setDimension(0)
							veh:setHealth(health)
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","This vehicle is already spawned!",8000)
					end
				end
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You can't spawn a vehicle in a interior!",8000)
	end
end)
addEvent("despawn:vehicle",true)
addEventHandler("despawn:vehicle",root,function(owner,slot)
	local veh=Vehicles[owner..slot]
	if(owner and slot)then
		if(owner==getPlayerName(client))then
			if(veh)then
				if(getVehicleOccupant(veh)==false)then
					if(veh:getDimension()==0)then
						if(isPedInVehicle(client)~=true)then
							local health=MySQL:getVdata(owner,slot,"Health")
							veh:setDimension(65535)
							veh:setHealth(health)
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","This vehicle is not spawned!",8000)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","This vehicle is not empty!",8000)
				end
			end
		end
	end
end)


--//save vehicle data
addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		local owner=syncGetElementData(veh,"owner")
		local slot=tonumber(syncGetElementData(veh,"slot"))
		local health=getElementHealth(veh)
		if(owner and slot)then
			MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","VEHICLES","Health",health,"owner",owner,"slot",slot)
		end
	end
end)





carPrices={
[496]=15000,
[445]=23000,
[410]=7500,
[549]=9800,
[585]=20000,
[550]=26800,

[402]=105000,
[411]=250000,
[415]=195000,
[451]=320000,
[480]=210000,
[541]=235000,
[560]=97000,
[429]=115000,
}