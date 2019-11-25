--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local function goInIntBurgershotTemple_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		fadeElementInterior(player,363.8,-74.5,1001.5,307,10,50,true)
	end
end
local function goOutIntBurgershotTemple_Func(player)
	if(getElementInterior(player)==10 and getElementDimension(player)==50)then
		fadeElementInterior(player,1199.3,-919.8,43.1,180,0,0,true)
	end
end

local function goInIntBurgershotRedsants_Func(player)
	if(getElementInterior(player)==0 and getElementDimension(player)==0)then
		fadeElementInterior(player,363.8,-74.5,1001.5,307,10,51,true)
	end
end
local function goOutIntBurgershotRedsants_Func(player)
	if(getElementInterior(player)==10 and getElementDimension(player)==51)then
		fadeElementInterior(player,1874.1,2071.8,11.1,270,0,0,true)
	end
end

local goInIntBurgershotTemple=createCmarker(1199.2,-918.4,43.1,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,false,goInIntBurgershotTemple_Func)
local goOutIntBurgershotTemple=createCmarker(363.0,-75.1,1001.5,10,50,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,false,goOutIntBurgershotTemple_Func)

local goInIntBurgershotRedsants=createCmarker(1872.5,2071.9,11.1,0,0,":"..settings.general.scriptname.."/files/IMAGES/cMarker/In.png","Ground",0.9,false,goInIntBurgershotRedsants_Func)
local goOutIntBurgershotRedsants=createCmarker(363.0,-75.1,1001.5,10,51,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Out.png","Ground",0.9,false,goOutIntBurgershotRedsants_Func)