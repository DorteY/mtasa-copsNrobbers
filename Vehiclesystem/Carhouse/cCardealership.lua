--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local vehicleID={}
local vehiclePrice={}
local vehicleSpawnX={}
local vehicleSpawnY={}
local vehicleSpawnZ={}
local vehicleRotationX={}
local vehicleRotationY={}
local vehicleRotationZ={}


local carhouseVehsTable={
{496,2136.6,-1146.1,24.5,0,354,90,15000, 2133.9,-1146.2,24.6, 2119.6,-1155.1,24.1,0,0,0},
{445,2136.2,-1142.3,24.9,0,354,90,23000, 2133.3,-1142.3,25.1, 2119.6,-1155.1,24.1,0,0,0},
{410,2136.1,-1138.6,25.1,0,354,90,7500, 2133.5,-1138.6,25.4, 2119.6,-1155.1,24.1,0,0,0},
{549,2136.4,-1134.6,25.4,0,359,90,9800, 2133.4,-1134.6,25.7, 2119.6,-1155.1,24.1,0,0,0},
{585,2136.0,-1130.4,25.3,0,0,90,20000, 2132.7,-1130.4,25.7, 2119.6,-1155.1,24.1,0,0,0},
{550,2136.2,-1126,25.3,0,0,90,26800, 2133.1,-1126.0,25.5, 2119.6,-1155.1,24.1,0,0,0},

{402,533.5,-1291.3,17.9,341,0,0,105000, 533.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{411,537.5,-1291.3,17.9,341,0,0,250000, 537.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{415,541.5,-1291.3,17.9,341,0,0,195000, 541.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{451,545.5,-1291.3,17.9,341,0,0,320000, 545.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{480,549.5,-1291.3,17.9,341,0,0,210000, 549.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{541,553.5,-1291.3,17.9,341,0,0,235000, 553.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{560,557.5,-1291.3,17.9,341,0,0,97000, 557.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
{429,561.5,-1291.3,17.9,341,0,0,115000, 561.5,-1288.5,17.2, 563.6,-1272.3,17.5,0,0,0},
}

addEventHandler("onClientResourceStart",resourceRoot,function()
	for _,v in pairs(carhouseVehsTable)do
		carhouseVehicle=createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],"-LG-")
		carhouseVehicle:setFrozen(true)
		carhouseVehicle:setDamageProof(true)
		carhouseVehicle:setColor(255,255,255,255,255,255)
		
		carhouseMarker=createMarker(v[9],v[10],v[11]-0.3,"corona",1,255,0,0,120)
		addEventHandler("onClientMarkerHit",carhouseMarker,function(player)
			if(player==lp)then
				vehicleID[lp]=v[1]
				vehiclePrice[lp]=v[8]
				vehicleSpawnX[lp]=v[12]
				vehicleSpawnY[lp]=v[13]
				vehicleSpawnZ[lp]=v[14]
				vehicleRotationX[lp]=v[15]
				vehicleRotationY[lp]=v[16]
				vehicleRotationZ[lp]=v[17]
				triggerEvent("draw:infobox",lp,"info","Press 'J' to buy this car for $"..vehiclePrice[lp],8000)
			end
		end)
		addEventHandler("onClientMarkerLeave",carhouseMarker,function(player)
			if(player==lp)then
				vehicleID[lp]=nil
				vehiclePrice[lp]=nil
			end
		end)
	end
end)

bindKey("j","down",function()
	if(not lp:isDead())then
		if(not(isPedInVehicle(lp)))then
			if(not(vehicleID[lp]==nil)and not(vehiclePrice[lp]==nil))then
				triggerServerEvent("buy:vehicle",lp,vehicleID[lp],vehiclePrice[lp],vehicleSpawnX[lp],vehicleSpawnY[lp],vehicleSpawnZ[lp],vehicleRotationX[lp],vehicleRotationY[lp],vehicleRotationZ[lp])
			end
		end
	end
end)