--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function isPolice(player)
	if(getElementData(player,"team")=="Police")then
		return true
	else
		return false
	end
end
function isGrove(player)
	if(getElementData(player,"team")=="Grove")then
		return true
	else
		return false
	end
end
function isBallas(player)
	if(getElementData(player,"team")=="Ballas")then
		return true
	else
		return false
	end
end

function isState(player)
	if(isPolice(player))then
		return true
	else
		return false
	end
end
function isEvil(player)
	if(isGrove(player)or isBallas(player))then
		return true
	else
		return false
	end
end

function sendMSGForTeam(text,team,r,g,b)
	if(not r and not g and not b)then
		r,g,b=255,255,255
	end
	for _,v in ipairs(getElementsByType("player"))do
		if(syncGetElementData(v,"team")==team)then
			outputChatBox(text,v,r,g,b)
		end
	end
end

function getMembersOnline(team)
	local counter=0
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,team))then
			counter=counter+1
		end
	end
	return counter
end



addEventHandler("onVehicleStartEnter",root,function(player,seat)
	if(getPedOccupiedVehicleSeat(player)==0)then
		if(syncGetElementData(source,"policecar")==true)then
			if(isPolice(player))then
				if(getElementModel(source)==getVehicleModelFromName("Enforcer")and tonumber(syncGetElementData(player,"LEVELPolice"))>=5)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("S.W.A.T.")and tonumber(syncGetElementData(player,"LEVELPolice"))>=7)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Police LV")and tonumber(syncGetElementData(player,"LEVELPolice"))>=3)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Police Maverick")and tonumber(syncGetElementData(player,"LEVELPolice"))>=2)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Police SF")and tonumber(syncGetElementData(player,"LEVELPolice"))>=0)then
					source:setFrozen(false)
				else
					cancelEvent()
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			else
				cancelEvent()
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a police member!",5000)
			end
		end
		
		if(syncGetElementData(source,"ballascar")==true)then
			if(isBallas(player))then
				if(getElementModel(source)==getVehicleModelFromName("Voodoo")and tonumber(syncGetElementData(player,"LEVELBallas"))>=1)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Burrito")and tonumber(syncGetElementData(player,"LEVELBallas"))>=2)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Maverick")and tonumber(syncGetElementData(player,"LEVELBallas"))>=3)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Majestic")and tonumber(syncGetElementData(player,"LEVELBallas"))>=0)then
					source:setFrozen(false)
				else
					cancelEvent()
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			else
				cancelEvent()
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a ballas member!",5000)
			end
		end
		
		if(syncGetElementData(source,"grovecar")==true)then
			if(isGrove(player))then
				if(getElementModel(source)==getVehicleModelFromName("Savanna")and tonumber(syncGetElementData(player,"LEVELGrove"))>=3)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Burrito")and tonumber(syncGetElementData(player,"LEVELGrove"))>=2)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Maverick")and tonumber(syncGetElementData(player,"LEVELGrove"))>=2)then
					source:setFrozen(false)
				elseif(getElementModel(source)==getVehicleModelFromName("Greenwood")and tonumber(syncGetElementData(player,"LEVELGrove"))>=0)then
					source:setFrozen(false)
				else
					cancelEvent()
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			else
				cancelEvent()
				triggerClientEvent(player,"draw:infobox",root,"error","You are not a grove member!",5000)
			end
		end
		
	end
end)