--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local respawntime=25000
addEventHandler("onVehicleExplode",root,function()
	local rdm=math.random(1,3)
	local x,y,z=getElementPosition(source)
	if(isElement(source))then
		if(x)and(y)and(z)then
			triggerClientEvent(root,"playSound3D",root,"Explosions",x,y,z,false,nil,300,rdm,".mp3")
		end
		if(syncGetElementData(source,"owner")and syncGetElementData(source,"slot"))then
			source:setDimension(65535)
		elseif(getElementData(source,"actionvehicle")==false and not syncGetElementData(source,"owner"))then
			source:destroy()
		else
			toggleVehicleRespawn(source,true)
			setVehicleRespawnDelay(source,respawntime)
		end
	end
end)


addEventHandler("onVehicleDamage",root,function(loss)
	if(isElement(source))then
		if(not source:getOccupant(0))then
			if(source:getHealth(loss)>1000)then
				source:setHealth(1000)
			else
				source:setHealth(source:getHealth()+loss)
			end
		end
	end
end)


function ejectPlayerFromVehicle_Func(player,cmd,target)
	if(isLoggedin(player))then
		if(not target)then
			triggerClientEvent(player,"draw:infobox",root,"error","Enter a target player!",7500)
		else
			if(getPedOccupiedVehicle(player)~=false)then
				local target=findPlayerByName(target)
				if(target)then
					local playerVEH=getPedOccupiedVehicle(player)
					local targetVEH=getPedOccupiedVehicle(target)
					if(target~=player)then
						if(targetVEH==playerVEH)then
							if(player:getOccupiedVehicleSeat()==0)then
								removePedFromVehicle(target)
							else
								triggerClientEvent(player,"draw:infobox",root,"error","You are not the driver to eject a player!",8000)
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","That player isn't in your vehicle!",8000)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You can't eject yourself!",8000)
					end
				end
			end
		end
	end
end
addCommandHandler("eject",ejectPlayerFromVehicle_Func)
addCommandHandler("removepedfromvehicle",ejectPlayerFromVehicle_Func)
addCommandHandler("rempedfromveh",ejectPlayerFromVehicle_Func)











function openVehpanel(player)
	local tbl={}
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","VEHICLES","owner",getPlayerName(player)),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["vehid"]),v["slot"]})
		end
		triggerClientEvent(player,"open:uservehpanel",player,tbl)
	else
		triggerClientEvent(player,"draw:infobox",root,"error","You do have not a Vehicle!",5000)
	end
end