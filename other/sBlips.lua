--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local blipTable={
	--,x,y,z,id,size,range
{1531.6,-1672,6.2,30,2,450},--LSPD
{2492.7,-1646.5,13.5,62,2,450},--LS Grove
{2248.6,-1402.2,24,59,2,450},--LS Ballas
{1382.2,-1088.8,28.3,52,2,450},--GTAV Bankrob
--//PayNsprays
{-1904.3,285.5,41.4,63,2,450},--SF Wangcars
{1976.6,2162.4,9.6,63,2,450},--LV City
{-99.8,1118.4,18.3,63,2,450},--Fort Carson
{2061.2,-1831.6,13.5,63,2,450},--LS Idle Wood
{720.2,-455.8,16.3,63,2,450},--Dillimore
{1024.9,-1023.7,32.1,63,2,450},--LS Tempel
{487.3,-1741.6,11.1,63,2,450},--LS Beach
--//Burgershots
{1199.2,-918.4,43.1,10,2,450},--LS Temple
{1872.5,2071.9,11.1,10,2,450},--LV Redsants
--//Carhouses
{2131.7,-1151.1,24.1,55,2,450},--Coutt and schutz
{546.5,-1276.9,17.2,55,2,450},--Grotti
--//Cartunings
{2645,-2045.8,12.6,27,2,450},
{1041.8,-1013,32.1,27,2,450},
{2386.5,1051.7,9.9,27,2,450},
{-2725.2,217.6,4.5,27,2,450},
{-1935.8,246.9,34.5,27,2,450},
--//Actions
{161.9,-25.7,0.5,51,2,450},--Drugtruck
{1896.2,979.3,9.8,51,2,450},--Moneytruck
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Element={}
	for i,v in pairs(blipTable)do
		Element[i]=createBlip(v[1],v[2],v[3],v[4],v[5],255,255,255,255,0,v[6],root)
	end
end)