--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo) & Lars-Marcel      ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("gta5BankTimeFix", true)
addEventHandler("gta5BankTimeFix", root, function(bool)
	if (bool) then
		setTime(8, 0)
	else
		setTime(getRealTime().hour, getRealTime().minute)
	end
end)

local alarmSounds = {}
addEvent("bankAlarm", true)
addEventHandler("bankAlarm", root, function(bool)
	for i = 1, 3 do
		if isElement(alarmSounds[i])then
			destroyElement(alarmSounds[i])
		end
	end
	
	if (bool) then
		alarmSounds[1] = playSound3D(":"..settings.general.scriptname.."/files/SOUNDS/GTAVBank/Alarm.mp3", 1381.2, -1085.5, 27.4, true) -- draussen
		setSoundMaxDistance(alarmSounds[1], 75)
		
		alarmSounds[2] = playSound3D(":"..settings.general.scriptname.."/files/SOUNDS/GTAVBank/Alarm.mp3", 858.1, 1688.8, 10535.9, true) -- oben
		setElementInterior(alarmSounds[2], 20)
		setElementDimension(alarmSounds[2], 66)
		setSoundMaxDistance(alarmSounds[2], 50)
		
		alarmSounds[3] = playSound3D(":"..settings.general.scriptname.."/files/SOUNDS/GTAVBank/Alarm.mp3", 868.9, 1701.9, 10530.8, true) -- tresor
		setElementInterior(alarmSounds[2], 20)
		setElementDimension(alarmSounds[2], 66)
		setSoundMaxDistance(alarmSounds[2], 50)
		
		setTimer(function()
			for i=1,3 do
				if isElement(alarmSounds[i])then
					destroyElement(alarmSounds[i])
				end
			end
		end, 1000*60*15, 1)
	end
end)


addEventHandler("onClientPlayerWeaponFire", root, function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if (source == localPlayer) then
		if (getElementDimension(source) == 66 and getElementInterior(source) == 20) then
			if (getSlotFromWeapon(weapon) >= 1 and getSlotFromWeapon(weapon) <= 8) then
				triggerServerEvent("playerShootInBank", localPlayer)
			end
		end
	end
end)


local bankPed = false
for i, ped in ipairs(getElementsByType("ped", root, false)) do
	if (getElementData(ped, "bankPed") == true) then
		bankPed = ped
		break
	end
end
addEventHandler("onClientRender", root, function()
	if (getElementDimension(localPlayer) == 66 and getElementInterior(localPlayer) == 20) then
		if (bankPed and isElement(bankPed)) then
			if (tonumber(getElementData(bankPed, "angst")) > 0 and not isPedDead(bankPed)) then
				local mx, my, mz = getElementPosition(localPlayer)
				local x, y, z = getElementPosition(bankPed)
				if (getDistanceBetweenPoints3D(mx, my, mz, x, y, z)	<= 12) then			
					local sx, sy = getScreenFromWorldPosition(x, y, z + 1, 1000, true)
					if (sx and sy) then
						dxDrawRectangle(sx-85, sy, 170, 25, tocolor(211, 211, 211, 175))
						dxDrawRectangle(sx-85, sy, 170, 2, tocolor(0, 0, 0, 255))
						dxDrawRectangle(sx-85, sy, 2, 25, tocolor(0, 0, 0, 255))
						dxDrawRectangle(sx-85, sy+23, 170, 2, tocolor(0, 0, 0, 255))
						dxDrawRectangle(sx+83, sy, 2, 25, tocolor(0, 0, 0, 255))
						
						local angst = tonumber(getElementData(bankPed, "angst"))
						if (angst > 100) then angst = 100 end
						local color =  tocolor((angst * 2.55 ), (100 - angst) * 2.55 / 2, 0, 255)
						
						dxDrawRectangle(sx-83, sy+2, (166/100)*angst, 21, color)
						
						dxDrawText("fear: "..angst.." %", sx-85, sy, sx+85, sy+25,  tocolor(0, 0, 0, 255), 1.1, 'default-bold', 'center', 'center')
						
					end
				end
			end
			setElementData(localPlayer, "bankAim", isPedAiming(localPlayer))
		else
			for i, ped in ipairs(getElementsByType("ped", root, false)) do
				if (getElementData(ped, "bankPed") == true) then
					bankPed = ped
					break
				end
			end
		end
	end
end)


addEventHandler("onClientPedDamage", root, function(attacker, weapon)
	
	local attacksPed = false
	if (getElementData(source, "tunnelPed") == true) then
		if (weapon ~= 9) then
			cancelEvent()
		end
		
		
	elseif (getElementData(source, "bankPed")) then
		if getElementData(lp,"team")=="Police" then
			cancelEvent()
		end
		
	end
end)
