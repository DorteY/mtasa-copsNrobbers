--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function jailCheck_Func(player)
	if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
		if(isPedInVehicle(player))then
			removePedFromVehicle(player)
		end
		local rdm=math.random(1,#globalTables["Police"]["Jailspawns"])
		local x,y,z,rot=globalTables["Police"]["Jailspawns"][rdm][1],globalTables["Police"]["Jailspawns"][rdm][2],globalTables["Police"]["Jailspawns"][rdm][3],globalTables["Police"]["Jailspawns"][rdm][4]
		setElementPosition(player,x,y,z)
		setPedRotation(player,rot)
		setElementInterior(player,6)
		setElementDimension(player,20)
		takeAllWeapons(player)
		toggleAllControls(player,true)
	end
end

TazerTimer={}
addEvent("tazer:target",true)
addEventHandler("tazer:target",root,function()
	if(isTimer(TazerTimer[client]))then
		killTimer(TazerTimer[client])
	end
	toggleAllControls(client,false,true,false)
	setPedAnimation(source,"CRACK","crckdeth2")
	TazerTimer[client]=setTimer(function(client)
		if(isElement(client))then
			setPedAnimation(client)
			toggleAllControls(client,true,true,false)
		end
	end,12000,1,client)
end)

local saveDeagleAmmoTable={}
function changeTazerToDeagle_changeDeagleToTazer(player)
	if(isState(player))then
		if(getElementData(player,"tazer")==false)then
			if(getPedWeapon(player)==24)then
				saveDeagleAmmoTable[player]=getPedTotalAmmo(player)
				takeWeapon(player,24)
				giveWeapon(player,23,999,true)
				notificationShow(player,"info","You changed your Deagle to Taser.")
				setElementData(player,"tazer",true)
			end
		else
			if(getPedWeapon(player)==23)then
				takeWeapon(player,23)
				giveWeapon(player,24,saveDeagleAmmoTable[player],true)
				notificationShow(player,"info","You changed your Taser to Deagle.")
				setElementData(player,"tazer",false)
			end
		end
	end
end

addCommandHandler("cuff",function(player,cmd,target)
	if(isState(player))then
		if(target)then
			local target=findPlayerByName(target)
			if(isElement(target))then
				local x,y,z=getElementPosition(target)
				if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(player))<=8)then
					if(target~=player)then
						if(getElementData(target,"tied")==true)then
							toggleAllControls(target,true)
							setElementData(target,"tied",false)
							triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(player).." has removed your handcuffs.",8000)
							triggerClientEvent(player,"draw:infobox",root,"info","You have "..getPlayerName(target).." removed his handcuffs.",8000)
						else
							toggleControl(target,"sprint",false)
							toggleControl(target,"walk",false)
							setElementData(target,"tied",true)
							triggerClientEvent(target,"draw:infobox",root,"info",getPlayerName(player).." has handcuffed you!",8000)
							triggerClientEvent(player,"draw:infobox",root,"info","You have given "..getPlayerName(target).." handcuffs.",8000)
						end
					end
				end
			end
		end
	end
end)


function jailplayer_Func(player)
	if(getElementType(player)=="vehicle")then
		local player=getVehicleOccupant(player,0)
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(isState(player))then
				for _,v in pairs(getElementsByType("player"))do
					if(isPedInVehicle(v))then
						if(getPedOccupiedVehicle(v)==getPedOccupiedVehicle(player))then
							if(tonumber(getElementData(v,"Wanteds"))>=1)then
								syncSetElementData(v,"Jailtime",tonumber(getElementData(v,"Wanteds"))*1)
								jailCheck_Func(v)
								setElementData(v,"Wanteds",tonumber(0))
								triggerClientEvent(player,"draw:infobox",root,"info","You have "..getPlayerName(v).." imprisoned!",8000)
							end
						end
					end
				end
			end
		end
	end
end

local LSPDjailPICK=createCmarker(1568.6,-1694.2,5.9,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Jail.png",nil,2,true,jailplayer_Func)
















setWeaponProperty(23, "pro", "damage", 1)
setWeaponProperty(23, "std", "damage", 1)
setWeaponProperty(23, "poor", "damage", 1)
setWeaponProperty(23, "pro", "maximum_clip_ammo", 1)
setWeaponProperty(23, "std", "maximum_clip_ammo", 1)
setWeaponProperty(23, "poor", "maximum_clip_ammo", 1)
setWeaponProperty(23, "pro", "weapon_range", 35/3)
setWeaponProperty(23, "std", "weapon_range", 35/3)
setWeaponProperty(23, "poor", "weapon_range", 35/3)
setWeaponProperty(23, "pro", "move_speed", 2)
setWeaponProperty(23, "std", "move_speed", 2)
setWeaponProperty(23, "poor", "move_speed", 2)