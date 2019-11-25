--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local function goInGTAVBankrob_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		fadeElementInterior(player,847,1683.8,10535.4,312,20,66,true)
		setTimer(function()triggerClientEvent(player,"gta5BankTimeFix",player,true)end,900,1)
	end
end
local function goOutGTAVBankrob_Func(player)
	if(getElementInterior(player)==20 and getElementDimension(player)==66)then
		fadeElementInterior(player,1381.1,-1088.8,27.4,90,0,0,true)
		setTimer(function()triggerClientEvent(player,"gta5BankTimeFix",player,true)end,900,1)
	end
end

--Marker
local goInGTAVBankrob=createCmarker(1382.2,-1088.8,28.3,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,false,goInGTAVBankrob_Func)
local goOutGTAVBankrob=createCmarker(846.1,1683,10535.4,20,66,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png",nil,0.9,false,goOutGTAVBankrob_Func)