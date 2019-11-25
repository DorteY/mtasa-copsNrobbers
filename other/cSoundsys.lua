--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local soundTable={}

addEvent("playSound",true)
addEventHandler("playSound",root,function(sound,loop,volume,fileend)
	if(soundTable[sound]~=nil and isElement(soundTable[sound]))then
		stopSound(soundTable[sound])
		soundTable[sound]=nil
	end
	
	if(loop==nil)then
		loop=false
	end
	if(volume==nil)then
		volume=syncClientGetElementData("Soundvolume")
	end
	if(fileend==nil)then
		fileend=".mp3"
	end
	
	soundTable[sound]=playSound("files/SOUNDS/"..sound..""..fileend,loop)
	setSoundVolume(soundTable[sound],volume)
end)
addEvent("playSound3D",true)
addEventHandler("playSound3D",root,function(sound,x,y,z,loop,volume,distance,anotherpfad,fileend)
	if(soundTable[sound]~=nil and isElement(soundTable[sound]))then
		stopSound(soundTable[sound])
		soundTable[sound]=nil
	end
	
	if(loop==nil)then
		loop=false
	end
	if(volume==nil)then
		volume=syncClientGetElementData("Soundvolume")
	end
	if(fileend==nil)then
		fileend=".mp3"
	end
	
	if(anotherpfad)then
		soundTable[sound]=playSound3D("files/SOUNDS/"..sound.."/"..anotherpfad..""..fileend.."",x,y,z,loop)
	else
		soundTable[sound]=playSound3D("files/SOUNDS/"..sound..""..fileend.."",x,y,z,loop)
	end
	setSoundVolume(soundTable[sound],volume)
	setSoundMaxDistance(soundTable[sound],distance)
end)



--// Weaponsounds
addEventHandler("onClientPlayerWeaponFire",root,function(weapon)
    local x,y,z=getPedWeaponMuzzlePosition(source)
    local dim=getElementDimension(source)
	local int=getElementInterior(source)
	
	local weaponSoundTable={
		[22]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/COLT45.mp3",
		[24]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/DEAGLE.mp3",
		[25]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/SHOTGUN.mp3",
		[29]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/MP5.mp3",
		[30]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/AK-47.mp3",
		[31]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/M4.mp3",
		[33]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/RIFLE.mp3",
		[34]=":"..settings.general.scriptname.."/files/SOUNDS/Weapons/SNIPER.mp3",
		[51]=nil,
	}
	if(weaponSoundTable[weapon])then
		local sound=playSound3D(weaponSoundTable[weapon],x,y,z,false)
		setSoundMaxDistance(sound,24)
		setSoundVolume(sound,0.5)
		setElementDimension(sound,dim)
		setElementInterior(sound,int)
		attachElements(sound,source)
	end
end)
addEventHandler("onClientPlayerWeaponFire",root,function(weapon,ammo,ammoInClip,hitX,hitY,hitZ,hitElement)
	if(weapon==23)then
		local dim=getElementDimension(source)
		local int=getElementInterior(source)
		
		local sound=playSound3D(":"..settings.general.scriptname.."/files/SOUNDS/Tazer.mp3",hitX,hitY,hitZ,false)
		setSoundVolume(sound,100)
		setSoundMaxDistance(sound,16)
		setElementDimension(sound,dim)
		setElementInterior(sound,int)
	end
end)

local blockedTasksTable={
	"TASK_SIMPLE_IN_AIR",
	"TASK_SIMPLE_JUMP",
	"TASK_SIMPLE_LAND",
	"TASK_SIMPLE_GO_TO_POINT",
	"TASK_SIMPLE_NAMED_ANIM",
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE",
	"TASK_SIMPLE_CAR_GET_IN",
	"TASK_SIMPLE_CLIMB",
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD",
	"TASK_SIMPLE_FALL",
	"TASK_SIMPLE_GET_UP",
}
local function reloadWeapon()
	local task=getPedSimplestTask(lp)
	
	for _,v in ipairs(blockedTasksTable)do
		if(task==v)then
			return
		end
	end

	triggerServerEvent("reload:weapon",resourceRoot)
	
	local playerWeapon=getPedWeapon(lp)
	local x,y,z=getElementPosition(lp)
	local sound=playSound3D(":LakeGaming/files/SOUNDS/Weapons/Reload/"..playerWeapon..".wav",x,y,z)
	setSoundMaxDistance(sound,5)
	attachElements(sound,lp)
	setSoundVolume(sound,0.5)
end

addCommandHandler("reloadweapon",function()
	setTimer(function()
		if(getPedControlState(lp,"aim_weapon"))then
			return
		end
		if(getPedTotalAmmo(lp)-getPedAmmoInClip(lp)<=0)then
			outputChatBox("No ammo left to reload!")
			return
		end
		
		reloadWeapon()
	end,50,1)
end)
bindKey("r","down","reloadweapon")

addEventHandler("onClientPlayerWeaponFire",lp,function(weapon)
	local x,y,z=getPedBonePosition(lp,26)
	if weapon==22 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==24 then
		createExplosion(x,y,z+10,12,false,0.2,false)
	elseif weapon==25 then
		createExplosion(x,y,z+10,12,false,0.4,false)
	elseif weapon==26 then
		createExplosion(x,y,z+10,12,false,0.5,false)
	elseif weapon==27 then
		createExplosion(x,y,z+10,12,false,0.3,false)
	elseif weapon==28 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==29 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==30 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==34 then
		createExplosion(x,y,z+40,40,false,1.0,false)
	elseif weapon==31 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==33 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==22 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==28 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==32 then
		createExplosion(x,y,z+10,12,false,0.1,false)
	elseif weapon==38 then
		createExplosion(x,y,z+10,12,false,0.4,false)
	elseif weapon==35 then
		createExplosion(x,y,z+100,50,false,50,false)
	end
end)


function disableSounds()
	setAmbientSoundEnabled("gunfire",false)
end
addEventHandler("onClientResourceStart",root,disableSounds)