--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local function goInGrove_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		fadeElementInterior(player,2496,-1693.7,1014.7,180,3,26,true)
	end
end
local function goOutGrove_Func(player)
	if(getElementInterior(player)==3 and getElementDimension(player)==26)then
		--fadeElementInterior(player,2498.5,-1643.5,13.8,180,0,0,true)
		fadeElementInterior(player,2498.6,-1644.5,13.8,180,0,0,true)
	end
end

--Marker
local goInGrove=createCmarker(2498.5,-1642.3,13.8,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,false,goInGrove_Func)
local goOutGrove=createCmarker(2496,-1692.4,1014.7,3,26,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,false,goOutGrove_Func)