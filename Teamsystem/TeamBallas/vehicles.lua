--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local facID="Ballas"

ballasVehiclesTable={
	{487,2248.8,-1409.4,28.5,0,0,90,""},
	{487,2246.2,-1396.9,28.5,0,0,90,""},
	{517,2239.2,-1401.7,23.8,0,0,110,"RHB 1"},
	{517,2239.2,-1397.9,23.8,0,0,110,"RHB 2"},
	{482,2245.3,-1412.8,24.1,0,0,90,"RHB 3"},
	{482,2252.6,-1412.8,24.1,0,0,90,"RHB 4"},
	{482,2259.6,-1412.8,24.1,0,0,90,"RHB 5"},
	{412,2234.2,-1455.5,23.7,0,0,90,"RHB 6"},
	{412,2242.8,-1455.5,23.7,0,0,90,"RHB 7"},
	{412,2240.3,-1447.8,23.7,0,0,90,"RHB 8"},
	{517,2249.7,-1422.4,23.9,0,0,50,"RHB 9"},
	{517,2243.5,-1422.4,23.9,0,0,50,"RHB 10"},
}

function createBallasVehiles_Func()
	for _,v in ipairs(ballasVehiclesTable)do
		ballasVEH=createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8])
		ballasVEH:setColor(settings.general.teamColors[facID][1],settings.general.teamColors[facID][2],settings.general.teamColors[facID][3],settings.general.teamColors[facID][1],settings.general.teamColors[facID][2],settings.general.teamColors[facID][3])
		ballasVEH:setFrozen(true)
		
		syncSetElementData(ballasVEH,"owner","Ballas")
		syncSetElementData(ballasVEH,"ballascar",true)
		
		toggleVehicleRespawn(ballasVEH,true)
		setVehicleIdleRespawnDelay(ballasVEH,settings.vehiclesys.respawntime*60*1000)
	end
end
addEventHandler("onResourceStart",resourceRoot,createBallasVehiles_Func)