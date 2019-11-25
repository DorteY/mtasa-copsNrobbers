--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local radioStations = {
	{name="[DE] I Love Radio", url="http://stream01.iloveradio.de/iloveradio1.mp3"},
	{name="[DE] I Love Dance", url="http://stream01.iloveradio.de/iloveradio2.mp3"},
	{name="[DE] I Love Battle", url="http://stream01.iloveradio.de/iloveradio3.mp3"},
	{name="[INT] Noise.FM", url="http://noisefm.ru:8000/play_256.m3u"},
	{name="[INT] Dubstep.FM", url="https://www.dubstep.fm/listen.m3u"}
}

local SOUND_MIN_RANGE_OUT_OF_VEHICLE = 1
local SOUND_MAX_RANGE_OUT_OF_VEHICLE = 12
local SOUND_VOLUME_OUT_OF_VEHICLE    = 0.8
--local SOUND_EFFECTS_OUT_OF_VEHICLE   = {"compressor","i3dl2reverb"}

local SOUND_MIN_RANGE_IN_VEHICLE     = 5
local SOUND_MAX_RANGE_IN_VEHICLE     = 200
local SOUND_VOLUME_IN_VEHICLE        = 1
local SOUND_EFFECTS_IN_VEHICLE       = {}
local vehSeat = 0

local curStationScrollID = 0

local datTimer = false

function handleRadioResourceStart()
	setRadioChannel(0)
end
addEventHandler("onClientResourceStart",getResourceRootElement(),handleRadioResourceStart)

function handleRadioResourceStop()
	for index, vehicle in ipairs(getElementsByType("vehicle")) do
		stopVehicleRadio(vehicle)
	end
end
addEventHandler("onClientResourceStop",getResourceRootElement(),handleRadioResourceStop)

function handleRadioVehicleEnter(veh, seat)
	vehSeat = seat
	setRadioChannel(0)
	if getVehicleType(veh) == "BMX" then return end
	local sound = getElementData(veh,"radio:sound")
	startVehicleRadio(veh)
	
	if sound then
		setSoundMinDistance(sound,SOUND_MIN_RANGE_IN_VEHICLE)
		setSoundMaxDistance(sound,SOUND_MAX_RANGE_IN_VEHICLE)
		setSoundVolume(sound,SOUND_VOLUME_IN_VEHICLE)
		--for index, effect in ipairs(SOUND_EFFECTS_OUT_OF_VEHICLE) do
		--	setSoundEffectEnabled(sound,effect,false)
		--end
		for index, effect in ipairs(SOUND_EFFECTS_IN_VEHICLE) do
			setSoundEffectEnabled(sound,effect,true)
		end
	end
	local channel = tonumber(getElementData(veh,"radio:channel")) or 0
	if radioStations[channel] then
		showRadioDisplay(tostring(radioStations[channel].name))
	else
		showRadioDisplay("Radio off")
	end
end
addEventHandler("onClientPlayerVehicleEnter",lp,handleRadioVehicleEnter)

function handleRadioVehicleExit(veh)
	vehSeat = 0
	local sound = getElementData(veh,"radio:sound")
	if sound then
		setSoundMinDistance(sound,SOUND_MIN_RANGE_OUT_OF_VEHICLE)
		setSoundMaxDistance(sound,SOUND_MAX_RANGE_OUT_OF_VEHICLE)
		setSoundVolume(sound,SOUND_VOLUME_OUT_OF_VEHICLE)
		for index, effect in ipairs(SOUND_EFFECTS_IN_VEHICLE) do
			setSoundEffectEnabled(sound,effect,false)
		end
		--for index, effect in ipairs(SOUND_EFFECTS_OUT_OF_VEHICLE) do
		--	setSoundEffectEnabled(sound,effect,true)
		--end
	end
	hideRadioDisplay()
	stopVehicleRadio(veh)
end
addEventHandler("onClientPlayerVehicleExit",lp,handleRadioVehicleExit)

function handleRadioChannelSwitch(newChannel)
	if newChannel == 0 then
		return
	elseif vehSeat ~= 0 then
		cancelEvent()
		return
	end
	cancelEvent()
	local vehicle = getPedOccupiedVehicle(lp)
	if not vehicle then
		return
	end
	if getVehicleType(vehicle) == "BMX" then return end
	local channel = tonumber(getElementData(vehicle,"radio:channel")) or 0
	local increment = (newChannel == 1 and 1) or -1
	channel = channel + increment
	if channel > #radioStations then
		channel = 0
	elseif channel < 0 then
		channel = #radioStations
	end
	setElementData(vehicle,"radio:channel",channel)
end
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),handleRadioChannelSwitch)

function handleVehicleRadioChannelSwitch(key)
	if getElementType(source) == "vehicle" and key == "radio:channel" then
		startVehicleRadio(source)
		if source == getPedOccupiedVehicle(lp) then
			local channel = tonumber(getElementData(source,"radio:channel")) or 0
			if radioStations[channel] then
				showRadioDisplay(tostring(radioStations[channel].name))
			else
				showRadioDisplay("Radio off")
			end
		end
	end
end
addEventHandler("onClientElementDataChange",getRootElement(),handleVehicleRadioChannelSwitch)

function startVehicleRadio(vehicle)
	if isElement(vehicle) and getElementType(vehicle) == "vehicle" and isElementStreamedIn(vehicle) then
		stopVehicleRadio(vehicle)
		local channelID = tonumber(getElementData(vehicle,"radio:channel")) or 0
		local channel = radioStations[channelID]
		if channel then
			local url = channel.url
			if type(url) == "string" and #url > 0 then
				local x1, y1, z1 = getElementPosition ( vehicle )
				if datTimer and isTimer(datTimer) then killTimer(datTimer) end
				datTimer = setTimer(function()
					local sound = playSound3D(url,x1,y1,z1)
					if sound then
						setElementData(vehicle,"radio:sound",sound,false)
						setElementParent(sound,vehicle)
						attachElements(sound,vehicle)
						addEventHandler("onClientSoundStream",sound,handleVehicleRadioStream)
						addEventHandler("onClientElementDestroy",sound,handleRadioSoundDestroyed)
						addEventHandler("onClientElementStreamOut",sound,handleRadioSoundDestroyed)
						addEventHandler("onClientVehicleExplode",sound,handleRadioSoundDestroyed)
					end
				end, 200, 1)
			end
		end
	end
	return false
end

function stopVehicleRadio(vehicle)
	if isElement(vehicle) and getElementType(vehicle) == "vehicle" then
		local sound = getElementData(vehicle,"radio:sound")
		if datTimer and isTimer(datTimer) then killTimer(datTimer) end
		if sound then
			setElementData(vehicle,"radio:sound",false,false)
			if isElement(sound) and getElementType(sound) == "sound" and getElementParent(sound) == vehicle then
				destroyElement(sound)
				return true
			end
		end
	end
	return false
end

function handleVehicleRadioStream(success)
	local vehicle = getElementParent(source)
	if not success then
		stopVehicleRadio(vehicle)
		startVehicleRadio(vehicle)
	else
		local minDist
		local maxDist
		local volume
		local effects
		if vehicle == getPedOccupiedVehicle(lp) then
			minDist = SOUND_MIN_RANGE_IN_VEHICLE
			maxDist = SOUND_MAX_RANGE_IN_VEHICLE
			volume  = SOUND_VOLUME_IN_VEHICLE
			effects = SOUND_EFFECTS_IN_VEHICLE
		else
			minDist = SOUND_MIN_RANGE_OUT_OF_VEHICLE
			maxDist = SOUND_MAX_RANGE_OUT_OF_VEHICLE
			volume  = SOUND_VOLUME_OUT_OF_VEHICLE
			--effects = SOUND_EFFECTS_OUT_OF_VEHICLE
		end
		setSoundMinDistance(source,minDist)
		setSoundMaxDistance(source,maxDist)
		setSoundVolume(source,volume)
		
		for index,effect in ipairs(effects) do
			setSoundEffectEnabled(sound,effect,true)
		end
	end
end

function handleRadioSoundDestroyed()
	local vehicle = getElementParent(source)
	if isElement(vehicle) and getElementData(vehicle,"radio:sound") == source then
		startVehicleRadio(vehicle)
	end
end