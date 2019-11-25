--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local gunsPickup={}
local moneyPickup={}
gotLastHit={}

local weaponPickupIDS={
[24]=348,
[25]=349,
[28]=352,
[29]=353,
[30]=355,
[31]=356,
[33]=357,
}

function player_Wasted(ammo,attacker,weapon,bodypart)
	local x,y,z=getElementPosition(source)
	local money=getPlayerSelfMoney(source,"money")
	local weapon=getPedWeapon(source)
	local ammo=getPedTotalAmmo(source)
	local killEP=math.random(15,70)
	local killMONEY=math.random(50,120)
	
	if(weaponPickupIDS[weapon])then
		if(isElement(gunsPickup[source]))then gunsPickup[source]:destroy()end
		gunsPickup[source]=createPickup(x,y,z,3,weaponPickupIDS[weapon],50)
		setElementData(gunsPickup[source],"weapon",weapon)
		setElementData(gunsPickup[source],"ammo",ammo)
		
		addEventHandler("onPickupHit",gunsPickup[source],function(player)
			if(not player:isDead())then
				local waffe=getElementData(source,"weapon")
				local munition=getElementData(source,"ammo")
				giveWeapon(player,waffe,munition,true)
				source:destroy()
				triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a weapon!",8000)
			end
		end)
	end
	
	if(isElement(moneyPickup[source]))then
		moneyPickup[source]:destroy()
	end
	
	if(tonumber(money)>=1)then
		moneyPickup[source]=createPickup(x,y,z,3,1212,50)
		syncSetElementData(moneyPickup[source],"Money",math.abs(math.floor(money/50)))
		takePlayerSelfMoney(source,"money",math.abs(math.floor(money/50)))
			
		addEventHandler("onPickupHit",moneyPickup[source],function(player)
			if(not player:isDead())then
				local pickupMoney=tonumber(syncGetElementData(source,"Money"))
				givePlayerSelfMoney(player,"money",pickupMoney)
				source:destroy()
				triggerClientEvent(player,"draw:infobox",root,"money","You have picked up $"..pickupMoney,8000)
			end
		end)
	end
	
	--if(attacker)then
	if(attacker and attacker~=getPlayerName(source))then
		if(tonumber(syncGetElementData(attacker,"Introtask"))==3)then
			syncSetElementData(attacker,"Introtask",4)
			syncSetElementData(attacker,"Money",tonumber(syncGetElementData(attacker,"Money"))+1200)
		end
		syncSetElementData(attacker,"Kills",tonumber(syncGetElementData(attacker,"Kills"))+1)
		syncSetElementData(attacker,"Money",tonumber(syncGetElementData(attacker,"Money"))+killMONEY)
		givePlayerEXP(attacker,killEP)
		uLevel(attacker)
		setPlayerAchievement(attacker,1)
	end
	
	if(attacker and attacker~=source and getElementType(attacker)=="player")then
		if(isState(attacker))then
			if(tonumber(getElementData(source,"Wanteds"))>=1)then
				syncSetElementData(source,"Jailtime",tonumber(getElementData(source,"Wanteds"))*2)
				syncSetElementData(source,"Wanteds",tonumber(0))
				jailCheck_Func(source)
			end
		end
		if(tonumber(syncGetElementData(attacker,"Introtask"))==2)then
			syncSetElementData(attacker,"Introtask",3)
			syncSetElementData(attacker,"Money",tonumber(syncGetElementData(attacker,"Money"))+1200)
		end
		setPlayerAchievement(attacker,1)
	end
	
	if(isPedInVehicle(source))then
		removePedFromVehicle(source)
	end
	if(getElementData(source,"tazer")~=false)then
		setElementData(source,"tazer",false)
	end
	syncSetElementData(source,"Deaths",tonumber(syncGetElementData(source,"Deaths"))+1)
	triggerClientEvent(source,"render.hospital",source)
	setElementDimension(source,0)
	setElementInterior(source,0)
end
addEventHandler("onPlayerWasted",root,player_Wasted)


addEvent("damageCalcServer",true)
addEventHandler("damageCalcServer",root,function(attacker,weapon,bodypart,loss,player)
	if(attacker and weapon and bodypart and loss)then
		local x1,y1,z1=getElementPosition(attacker)
		local x2,y2,z2=getElementPosition(player)
		gotLastHit[player]=getTickCount()
		gotLastHit[attacker]=getTickCount()
		if(weapon==34 and bodypart==9)then
			if(getElementData(attacker,"team")==getElementData(player,"team"))then
				return false
			elseif(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
				return false
			elseif(getElementData(player,"duty:admin")==true)then
				return false
			elseif(syncGetElementData(player,"Savezone")==1)then
				return false
			end
			
			player:setHeadless(true)
			killPed(player,attacker,weapon,bodypart)
			outputLog(getPlayerName(attacker).." has "..getPlayerName(player).." given a headshot with the sniper.","Damage_Kills_Deaths")
		else
			if(getElementData(attacker,"team")==getElementData(player,"team"))then
				return false
			elseif(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
				return false
			elseif(getElementData(player,"duty:admin")==true)then
				return false
			elseif(syncGetElementData(player,"Savezone")==1)then
				return false
			end
			
			local basicDMG=globalTables["weaponDMG"][weapon]
			if(bodypart==9)then
				multiply=1.3
			else
				multiply=1.0
			end
			
			if(globalTables["weaponDMG"][weapon])then
				damagePlayer(player,basicDMG*multiply,attacker,weapon)
			else
				damagePlayer(player,loss,attacker,weapon)
			end
			outputLog(""..getPlayerName(attacker).." hit "..getPlayerName(player).." with weapon "..weapon.." on bodypart "..bodypart..", damage: "..basicDMG.."","Damage_Kills_Deaths")
			
		end
		
		if(getElementData(attacker,"ImGangwar") == true and getElementData(player,"ImGangwar") == true and getElementData(player,"ImGangwarGestorben") ~= true and tonumber(getElementData(attacker,"Fraktion")) ~= tonumber(getElementData(player,"Fraktion")))then
			triggerClientEvent(attacker,"showDMGAnzeige",attacker,getPlayerName(player),basicDMG*multiply,Koerperteile[bodypart]);
			setElementData(attacker,"TemporaerGWDamage",getElementData(attacker,"TemporaerGWDamage")+basicDMG*multiply);
			setElementData(attacker,"GangwarDamage",getElementData(attacker,"GangwarDamage")+basicDMG*multiply);
		end
		
	end
end)

addEvent("spawn:hospital",true)
addEventHandler("spawn:hospital",root,function()
	setCameraTarget(client,client)
	local pname=getPlayerName(client)
	local team=getElementData(client,"team")
	
	setElementData(client,"team",nil)
	triggerClientEvent(client,"open:teamselect",client)
	jailCheck_Func(client)
	
	gotLastHit[client]=0
	
	client:setHeadless(false)
	client:setHealth(100)
end)