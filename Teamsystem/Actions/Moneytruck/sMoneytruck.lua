--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local startMoneytruckMarker=createMarker(1896.2,979.3,9.8,"cylinder",1.2,200,0,0,120)

local deliverMoneytruckMarker=createMarker(1577.2,-1627.9,12,"cylinder",6,200,0,0,120)
local deliverMoneytruckBlip=createBlip(1577.2,-1627.9,12,19,2,255,0,0,255,0,99999.0,root)
setElementVisibleTo(deliverMoneytruckMarker,root,false)
setElementVisibleTo(deliverMoneytruckBlip,root,false)

local drogentruck=false
local drogentruckRobber=nil
local drogentruckFraktion=nil
local moneytruckTimer=nil
local drogentruckTimerAction=nil

function openDrugtruckUI_Func(player)
	if(player and getElementType(player)=="player")then
		if(player:getDimension()==0 and player:getInterior()==0)then
			if(isLoggedin(player))then
				if(getPedOccupiedVehicle(player)~=true)then
					if(isState(player))then
						triggerClientEvent(player,"open:moneytruckpanel",root)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You are not a police-member!",8000)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",startMoneytruckMarker,openDrugtruckUI_Func)

addEvent("start:moneytruck",true)
addEventHandler("start:moneytruck",root,function(player)
	if(isState(player))then
		if(not moneytruck)then
			loadMoneyTruck(player)
		end
	end
end)


function loadMoneyTruck(player)
	createNewsShow("Red","Breaking News","A Moneytruck was started!",10000)
	sendMSGForTeam("[ACTION]: A Moneytruck was started!","Police",200,0,0)
	sendDiscordMessage(7,"A Moneytruck was started!")
	moneytruck=createVehicle(428,1903.7,973.3,10.9,0,0,180,"MT")
	moneytruck:setColor(0,0,0,0,0,0)
	moneytruck:setHealth(2500)
	setElementData(moneytruck,"actionvehicle",true)
	
	moneytruckBLIP=createBlipAttachedTo(moneytruck,50,2,255,255,255,_,1000)
	
	addEventHandler("onVehicleExplode",moneytruck,vehicleDestroyedMoneytruck)
	drogentruckFraktion=getElementData(player,"Faction")
	
	setElementVisibleTo(deliverMoneytruckMarker,root,true)
	setElementVisibleTo(deliverMoneytruckBlip,root,true)
	
	moneytruckTimer=setTimer(
		function()
			if(isElement(moneytruck))then
				moneytruck:destroy()
			end
			if(isElement(moneytruckBLIP))then
				moneytruckBLIP:destroy()
			end
			createNewsShow("Red","Breaking News","The Moneytruck was destroyed because of the time!",10000)
			sendMSGForTeam("[ACTION]: The Moneytruck was destroyed because of the time!","Police",0,200,0)
			sendDiscordMessage(7,"The Moneytruck was destroyed because of the time!")
			setElementData(moneytruck,"actionvehicle",false)
			setTimer(function()moneytruck=false end,60*60*1000,1)
			setElementVisibleTo(deliverMoneytruckMarker,root,false)
			setElementVisibleTo(deliverMoneytruckBlip,root,false)
		end,
	timeTillDrogentruckDisappears,1)
end

function vehicleDestroyedMoneytruck()
	createNewsShow("Red","Breaking News","The Moneytruck was destroyed!",10000)
	sendMSGForTeam("[ACTION]: The Moneytruck was destroyed!","Police",0,200,0)
	sendDiscordMessage(7,"The Moneytruck was destroyed!")
	setElementData(moneytruck,"actionvehicle",false)
	setTimer(function()moneytruck=false end,60*60*1000,1)
	if(isElement(moneytruckBLIP))then
		moneytruckBLIP:destroy()
	end
	if isTimer(moneytruckTimer)then
		killTimer(moneytruckTimer)
		moneytruckTimer=nil
	end
	setElementVisibleTo(deliverMoneytruckMarker,root,false)
	setElementVisibleTo(deliverMoneytruckBlip,root,false)
	drogentruckFraktion=nil
end

function SuccessfullMoneytruck(player)
	createNewsShow("Red","Breaking News","The Moneytruck was canceled!",10000)
	sendMSGForTeam("[ACTION]: The Moneytruck was canceled!","Police",0,200,0)
	sendDiscordMessage(7,"The Moneytruck was canceled!")
	setElementData(moneytruck,"actionvehicle",false)
	if(isElement(moneytruck))then
		moneytruck:destroy()
	end
	if(isElement(moneytruckBLIP))then
		moneytruckBLIP:destroy()
	end
	setTimer(function()moneytruck=false end,60*60*1000,1)
	setElementVisibleTo(deliverMoneytruckMarker,root,false)
	setElementVisibleTo(deliverMoneytruckBlip,root,false)
	if isTimer(moneytruckTimer)then
		killTimer(moneytruckTimer)
		moneytruckTimer=nil
	end
	local rdm=math.random(5000,14000)
	
	local x,y,z=getElementPosition(player)
	local col=createColSphere(x,y,z,40)
	local players=getElementsWithinColShape(col,"player")
	for i=1,#players do
		if isState(players[i])then
			syncSetElementData(players[i],"Money",syncGetElementData(players[i],"Money")+rdm)
			outputChatBox("You get "..rdm.."x Money",players[i],255,255,255)
			givePlayerEXP(players[i],32)
		end
	end
end

addEventHandler("onMarkerHit",deliverMoneytruckMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isState(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==moneytruck)then
					if(getElementHealth(veh)>=250)then
						SuccessfullMoneytruck(player) 
					end
				end
			end
		end
	end
end)