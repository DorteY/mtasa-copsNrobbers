--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local startDrugtruckMarker=createMarker(161.9,-25.7,0.5,"cylinder",1.2,200,0,0,120)

local deliverDrugtruckMarker=createMarker(-1096,-1621,75,"cylinder",6,200,0,0,120)
local deliverDrugtruckBlip=createBlip(-1096,-1621,75,19,2,255,0,0,255,0,99999.0,root)
setElementVisibleTo(deliverDrugtruckMarker,root,false)
setElementVisibleTo(deliverDrugtruckBlip,root,false)

local drogentruck=false
local drogentruckRobber=nil
local drogentruckFraktion=nil
local drogentruckTimer=nil
local drogentruckTimerAction=nil

function openDrugtruckUI_Func(player)
	if(player and getElementType(player)=="player")then
		if(player:getDimension()==0 and player:getInterior()==0)then
			if(isLoggedin(player))then
				if(getPedOccupiedVehicle(player)~=true)then
					if(isEvil(player))then
						triggerClientEvent(player,"open:drugtruckpanel",root)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You are not a gang-member!",8000)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",startDrugtruckMarker,openDrugtruckUI_Func)

addEvent("start:weedtruck",true)
addEventHandler("start:weedtruck",root,function(player)
	if(isEvil(player))then
		if(not drogentruck)then
			loadDrogenTruck(player)
		end
	end
end)


function loadDrogenTruck(player)
	createNewsShow("Red","Breaking News","A Weedtruck was started!",10000)
	sendMSGForTeam("[ACTION]: A Weedtruck was started!","Police",200,0,0)
	sendDiscordMessage(7,"A Weedtruck was started!")
	drogentruck=createVehicle(578,162.8,-22.1,2.3,0,0,270,"DT")
	drogentruck:setColor(0,0,0,0,0,0)
	drogentruck:setHealth(2500)
	setElementData(drogentruck,"actionvehicle",true)
	
	drogentruckBLIP=createBlipAttachedTo(drogentruck,50,2,255,255,255,_,1000)
	
	DRUGSBOX=createObject(2934,0,0,0)
	attachElements(DRUGSBOX,drogentruck,0,-1.5,1.2)
	setElementCollisionsEnabled(DRUGSBOX,false)
	DRUGSBOX:setDoubleSided(true)
	addEventHandler("onVehicleExplode",drogentruck,vehicleDestroyedDrogenTruck)
	drogentruckFraktion=getElementData(player,"Faction")
	
	givePlayerWantedLevel(player,4)
	
	weedtruckNPCcar=createVehicle(405,-1100,-1632,76.1,0,0,90,"...")
	weedtruckNPCcar:setFrozen(true)
	weedtruckNPCped=createPed(28,-1097.9,-1630.6,76.4,-90)
	weedtruckNPCped:setFrozen(true)
	setElementData(weedtruckNPCped,"dontdamagePED",true)
	
	setElementVisibleTo(deliverDrugtruckMarker,root,true)
	setElementVisibleTo(deliverDrugtruckBlip,root,true)
	
	drogentruckTimer=setTimer(
		function()
			if(isElement(drogentruck))then
				drogentruck:destroy()
			end
			if(isElement(DRUGSBOX))then
				DRUGSBOX:destroy()
			end
			if(isElement(drogentruckBLIP))then
				drogentruckBLIP:destroy()
			end
			if(isElement(weedtruckNPCcar))then
				weedtruckNPCcar:destroy()
			end
			if(isElement(weedtruckNPCped))then
				weedtruckNPCped:destroy()
			end
			createNewsShow("Red","Breaking News","The Weedtruck was destroyed because of the time!",10000)
			sendMSGForTeam("[ACTION]: The Weedtruck was destroyed because of the time!","Police",0,200,0)
			sendDiscordMessage(7,"The Weedtruck was destroyed because of the time!")
			setElementData(drogentruck,"actionvehicle",false)
			setTimer(function()drogentruck=false end,60*60*1000,1)
			setElementVisibleTo(deliverDrugtruckMarker,root,false)
			setElementVisibleTo(deliverDrugtruckBlip,root,false)
		end,
	timeTillDrogentruckDisappears,1)
end

function vehicleDestroyedDrogenTruck()
	createNewsShow("Red","Breaking News","The Weedtruck was destroyed!",10000)
	sendMSGForTeam("[ACTION]: The Weedtruck was destroyed!","Police",0,200,0)
	sendDiscordMessage(7,"The Weedtruck was destroyed!")
	setElementData(drogentruck,"actionvehicle",false)
	setTimer(function()drogentruck=false end,60*60*1000,1)
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	if(isElement(weedtruckNPCcar))then
		weedtruckNPCcar:destroy()
	end
	if(isElement(weedtruckNPCped))then
		weedtruckNPCped:destroy()
	end
	if isTimer(drogentruckTimer)then
		killTimer(drogentruckTimer)
		drogentruckTimer=nil
	end
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverDrugtruckBlip,root,false)
	drogentruckFraktion=nil
end

function drogentruckSuccessfull(player)
	createNewsShow("Red","Breaking News","The Weedtruck was canceled!",10000)
	sendMSGForTeam("[ACTION]: The Weedtruck was canceled!","Police",0,200,0)
	sendDiscordMessage(7,"The Weedtruck was canceled!")
	setElementData(drogentruck,"actionvehicle",false)
	if(isElement(drogentruck))then
		drogentruck:destroy()
	end
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	if(isElement(weedtruckNPCcar))then
		weedtruckNPCcar:destroy()
	end
	if(isElement(weedtruckNPCped))then
		weedtruckNPCped:destroy()
	end
	setTimer(function()drogentruck=false end,60*60*1000,1)
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverDrugtruckBlip,root,false)
	if isTimer(drogentruckTimer)then
		killTimer(drogentruckTimer)
		drogentruckTimer=nil
	end
	local randomdrogentruckDRUGS=math.random(500,1000)
	syncSetElementData(player,"Weed",syncGetElementData(player,"Weed")+randomdrogentruckDRUGS)
	givePlayerEXP(player,30)
	outputChatBox("You get "..randomdrogentruckDRUGS.."x Weed",player,255,255,255)
end

addEventHandler("onMarkerHit",deliverDrugtruckMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEvil(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==drogentruck)then
					if(getElementHealth(veh)>=250)then
						drogentruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)