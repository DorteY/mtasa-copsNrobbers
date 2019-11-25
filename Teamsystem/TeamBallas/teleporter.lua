--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local function goInBallas_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		fadeElementInterior(player,1212.1,-27.7,1001,180,3,27,true)
	end
end
local function goOutBallas_Func(player)
	if(getElementInterior(player)==3 and getElementDimension(player)==27)then
		fadeElementInterior(player,2248.6,-1402.2,24,180,0,0,true)
	end
end

--Marker
local goInBallas=createCmarker(2248.6,-1401,24,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,false,goInBallas_Func)
local goOutBallas=createCmarker(1212.1,-26,1001,3,27,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,false,goOutBallas_Func)