--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local alphac=0
local unrender=false

function drawSavezone_Func()
	if(alphac<1 and unrender==false)then
		alphac=alphac+0.01
	elseif(alphac>0 and unrender==true)then
		alphac=alphac-0.01
	elseif(alphac==0 and unrender==true)then
		removeEventHandler("onClientRender",root,drawSavezone_Func)
		unrender=false
	end
	if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
		dxDrawRectangle(1625*Gsx,315*Gsy,280*Gsx,120*Gsy,tocolor(200,0,0,140*alphac),false)
		dxDrawRectangle(1645*Gsx,350*Gsy,240*Gsx,2*Gsy,tocolor(255,255,255,255*alphac),false)
		dxDrawText("No-Dm-Zone:",3325*Gsx,320*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255*alphac),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
		dxDrawText("Deathmatch not allowed!",3325*Gsx,365*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255*alphac),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
	end
end
addEvent("draw:savezone",true)
addEventHandler("draw:savezone",root,function()
	if(unrender==true and alphac~=0)then
		unrender=false
	else
		unrender=false
		removeEventHandler("onClientRender",root,drawSavezone_Func)
		addEventHandler("onClientRender",root,drawSavezone_Func)
	end
end)
addEvent("undraw:savezone",true)
addEventHandler("undraw:savezone",root,function()
	unrender=true
end)



local savezoneTable={ 
	[1]={x=1398.9,y=-1862.5,width=161,height=120,r=0,g=200,b=0,a=120}--LS Bahnhof
}
local colCuboidsTable={}

addEventHandler("onClientResourceStart",resourceRoot,function()
	for i=1,#savezoneTable do
		createRadarArea(savezoneTable[i].x,savezoneTable[i].y,savezoneTable[i].width,savezoneTable[i].height,savezoneTable[i].r,savezoneTable[i].g,savezoneTable[i].b,savezoneTable[i].a,lp)
		colCuboidsTable[i]=createColCuboid(savezoneTable[i].x,savezoneTable[i].y,-50,savezoneTable[i].width,savezoneTable[i].height,7500)
		setElementID(colCuboidsTable[i],"greenzoneColshape")
		addEventHandler("onClientColShapeHit",colCuboidsTable[i],startGreenZone)
		addEventHandler("onClientColShapeLeave",colCuboidsTable[i],stopGreenZone)
	end
end)


function startGreenZone(hitElement,dim)
	if(hitElement==lp and dim)then
		triggerEvent("draw:savezone",lp)
		syncClientSetElementData("Savezone",1)
		toggleControl("fire",false)
		toggleControl("next_weapon",false)
		toggleControl("previous_weapon",false)
		toggleControl("aim_weapon",false)
		toggleControl("vehicle_fire",false)
		setPedDoingGangDriveby(hitElement,false)
		setPedWeaponSlot(hitElement,0)
	end
end

function stopGreenZone(leaveElement,dim)
	if(leaveElement==lp and dim)then
		triggerEvent("undraw:savezone",lp)
		syncClientSetElementData("Savezone",0)
		toggleControl("fire",true)
		toggleControl("next_weapon",true)
		toggleControl("previous_weapon",true)
		toggleControl("aim_weapon",true)
		toggleControl("vehicle_fire",true)
	end
end

addEventHandler("onClientPlayerSpawn",lp,function()
	for i=1,#colCuboidsTable do
		if(isElementWithinColShape(source,colCuboidsTable[i]))then
			startGreenZone(source,true)
		end
	end
end)


addEventHandler("onClientPlayerVehicleExit",lp,function()
	setPedWeaponSlot(lp,0)
end)