--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local facID="Police"

policeVehiclesTable={
	{597,1558.9,-1710.6,5.7,0,0,0,"LSPD  1"},
	{597,1563.1,-1710.6,5.7,0,0,0,"LSPD  2"},
	{597,1566.5,-1710.6,5.7,0,0,0,"LSPD  3"},
	{597,1570.3,-1710.6,5.7,0,0,0,"LSPD  4"},
	{597,1574.4,-1710.6,5.7,0,0,0,"LSPD  5"},
	{597,1578.5,-1710.6,5.7,0,0,0,"LSPD  6"},
	{597,1583.4,-1710.6,5.7,0,0,0,"LSPD  7"},
	{597,1587.4,-1710.6,5.7,0,0,0,"LSPD  8"},
	{597,1591.4,-1710.6,5.7,0,0,0,"LSPD  9"},
	{597,1595.4,-1710.6,5.7,0,0,0,"LSPD 10"},
	{427,1538.9,-1645.3,6.0,0,0,180,"LSPD 11"},
	{427,1534.6,-1645.3,6.0,0,0,180,"LSPD 12"},
	{427,1530.6,-1645.3,6.0,0,0,180,"LSPD 13"},
	{427,1526.6,-1645.3,6.0,0,0,180,"LSPD 14"},
	{601,1545.5,-1651,5.6,0,0,90,"LSPD 20"},
	{601,1545.5,-1655.1,5.6,0,0,90,"LSPD 21"},
	{601,1545.5,-1659.1,5.6,0,0,90,"LSPD 22"},
	{598,1601.8,-1704.0,5.7,0,0,90,"LSPD 23"},
	{598,1601.8,-1700.0,5.7,0,0,90,"LSPD 24"},
	{598,1601.8,-1696.0,5.7,0,0,90,"LSPD 25"},
	{598,1601.8,-1692.0,5.7,0,0,90,"LSPD 26"},
	{598,1601.8,-1688.0,5.7,0,0,90,"LSPD 27"},
	{598,1601.8,-1684.0,5.7,0,0,90,"LSPD 28"},
	
	--//LS - Helicopter
	{497,1562.3,-1647.9,28.5,0,0,90,""},
	{497,1562.3,-1660.0,28.5,0,0,90,""},
	{497,1562.3,-1691.2,28.5,0,0,90,""},
	{497,1562.3,-1703.3,28.5,0,0,90,""},
}

function createPoliceVehiles_Func()
	for _,v in ipairs(policeVehiclesTable)do
		policeVEH=createVehicle(v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8])
		policeVEH:setColor(0,0,0,255,255,255)
		policeVEH:setFrozen(true)
		
		syncSetElementData(policeVEH,"owner","Police")
		syncSetElementData(policeVEH,"policecar",true)
		
		toggleVehicleRespawn(policeVEH,true)
		setVehicleIdleRespawnDelay(policeVEH,settings.vehiclesys.respawntime*60*1000)
		
		if(getElementModel(policeVEH)==getVehicleModelFromName("Police SF"))then
			syncSetElementData(policeVEH,"policecar",true)
			syncSetElementData(policeVEH,"texture:sapd",true)
			syncSetElementData(policeVEH,"customengine",0)
			syncSetElementData(policeVEH,"customdrivetyp","awd")
			removeVehicleSirens(policeVEH)
			addVehicleSirens(policeVEH,6,2,true,true,false,false)
			setVehicleSirens(policeVEH,1,-0.5,-0.4,1,255,0,0,255,255)
			setVehicleSirens(policeVEH,2,0.5,-0.4,1,0,0,255,255,255)
			setVehicleSirens(policeVEH,3,0,-0.4,1, 255,255,255,255,255)
			setVehicleSirens(policeVEH,4,0.6,-2.1,0.4,255,255,0,255,140)
			setVehicleSirens(policeVEH,5,0,-2.1,0.4,255,255,0,255,140)
			setVehicleSirens(policeVEH,6,-0.6,-2.1,0.4,255,255,0,255,140)
		elseif(getElementModel(policeVEH)==getVehicleModelFromName("Police LV"))then
			syncSetElementData(policeVEH,"policecar",true)
			syncSetElementData(policeVEH,"texture:patrol",true)
			syncSetElementData(policeVEH,"customengine",3)
			syncSetElementData(policeVEH,"customdrivetyp","awd")
			removeVehicleSirens(policeVEH)
			addVehicleSirens(policeVEH,6,2,true,true,false,false)
			setVehicleSirens(policeVEH,1,-0.5, -0.4, 1, 255, 0, 0, 255, 255)
			setVehicleSirens(policeVEH,2,0.5, -0.4, 1, 0, 0, 255, 255, 255)
			setVehicleSirens(policeVEH,3,0, -0.4, 1, 255, 255, 255, 255, 255)
			setVehicleSirens(policeVEH,4,0.6, -1.8, 0.5, 255, 255, 0, 255, 140)
			setVehicleSirens(policeVEH,5,0.0, -1.8, 0.5, 255, 255, 0, 255, 140)
			setVehicleSirens(policeVEH,6,-0.6, -1.8, 0.5, 255, 255, 0, 255, 140)
		elseif(getElementModel(policeVEH)==getVehicleModelFromName("Enforcer"))then
			syncSetElementData(policeVEH,"policecar",true)
			syncSetElementData(policeVEH,"texture:sapd",true)
			syncSetElementData(policeVEH,"customengine",3)
			syncSetElementData(policeVEH,"veharmor",2)
			syncSetElementData(policeVEH,"customdrivetyp","awd")
			removeVehicleSirens(policeVEH)
			addVehicleSirens(policeVEH,8, 2, true, true, false, false)
			setVehicleSirens(policeVEH,1, 1.2, 0.1, 1.3, 255, 142.8, 0, 198.9, 198.9)
			setVehicleSirens(policeVEH,2, 1.2, -1.6, 1.3, 255, 145.4, 0, 200, 200)
			setVehicleSirens(policeVEH,3, 1.2, -3.4, 1.3, 255, 145.4, 0, 200, 200)
			setVehicleSirens(policeVEH,4, -1.2, 0.1, 1.3, 255, 145.4, 0, 200, 200)
			setVehicleSirens(policeVEH,5, -1.2, -1.6, 1.3, 255, 145.4, 0, 200, 200)
			setVehicleSirens(policeVEH,6, -1.2, -3.4, 1.3, 255, 145.4, 0, 200, 200)
			setVehicleSirens(policeVEH,7, -0.4, 1.1, 1.5, 0, 0, 255, 255, 255)
			setVehicleSirens(policeVEH,8, 0.4, 1.1, 1.5, 255, 0, 0, 255, 255)
		elseif(getElementModel(policeVEH)==599)then
			syncSetElementData(policeVEH,"policecar",true)
			syncSetElementData(policeVEH,"customengine",2)
			syncSetElementData(policeVEH,"customdrivetyp","awd")
			removeVehicleSirens(policeVEH)
			addVehicleSirens(policeVEH, 6, 2, true, true, false, false)
			setVehicleSirens(policeVEH, 1, -0.6, 0, 1.2, 255, 0, 0, 255, 255)
			setVehicleSirens(policeVEH, 2, 0.6, 0, 1.2, 0, 0, 255, 255, 255)
			setVehicleSirens(policeVEH, 3, 0, 0, 1.2, 255, 255, 255, 255, 255)
			setVehicleSirens(policeVEH, 4, -0.5, -2.5, 1, 255, 120, 0, 255, 168.3)
			setVehicleSirens(policeVEH, 5, 0.0, -2.5, 1, 255, 120, 0, 255, 168.3)
			setVehicleSirens(policeVEH, 6, 0.5, -2.5, 1, 255, 120, 0, 255, 168.3)
		elseif(getElementModel(policeVEH)==601)then
			syncSetElementData(policeVEH,"policecar",true)
			syncSetElementData(policeVEH,"customengine",2)
			syncSetElementData(policeVEH,"veharmor",2)
			syncSetElementData(policeVEH,"customdrivetyp","awd")
		elseif(getElementModel(policeVEH)==497)then
			syncSetElementData(policeVEH,"policecar",true)
			syncSetElementData(policeVEH,"texture:sapd",true)
		end
		giveVehicleSpecialUpgrade(policeVEH)
	end
end
addEventHandler("onResourceStart",resourceRoot,createPoliceVehiles_Func)