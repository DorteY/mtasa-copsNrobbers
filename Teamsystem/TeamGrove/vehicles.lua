--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local facID="Grove"

groveVehiclesTable={
	{487,2529.8,-1677.9,19.9,0,0,90,""},
	{487,2517.6,-1694.2,18.6,0,0,50,""},
	{492,2493.0,-1684.7,13.2,0,356,270,"GS 1"},
	{567,2471.0,-1678.0,13.2,0,356,218,"GS 2"},
	{567,2460.8,-1664.7,13.2,0,356,270,"GS 3"},
	{482,2475.5,-1694.1,13.6,0,0,0,"GS 4"},
	{482,2475.5,-1701.0,13.6,0,0,0,"GS 5"},
	{482,2471.5,-1701.0,13.6,0,0,0,"GS 6"},
	{492,2510.0,-1686.3,13.3,0,0,41,"GS 7"},
	{492,2510.4,-1666.8,13.2,0,356,10,"GS 8"},
	{482,2485.7,-1653.2,13.5,0,356,90,"GS 9"},
}

function createGroveVehiles_Func()
	for _,v in ipairs(groveVehiclesTable)do
		groveVEH=createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8])
		groveVEH:setColor(settings.general.teamColors[facID][1],settings.general.teamColors[facID][2],settings.general.teamColors[facID][3],settings.general.teamColors[facID][1],settings.general.teamColors[facID][2],settings.general.teamColors[facID][3])
		groveVEH:setFrozen(true)
		
		syncSetElementData(groveVEH,"owner","Grove")
		syncSetElementData(groveVEH,"grovecar",true)
		
		toggleVehicleRespawn(groveVEH,true)
		setVehicleIdleRespawnDelay(groveVEH,settings.vehiclesys.respawntime*60*1000)
	end
end
addEventHandler("onResourceStart",resourceRoot,createGroveVehiles_Func)