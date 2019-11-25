--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function renderHospital()
	showChat(false)
	dxDrawRectangle(740*Gsx,360*Gsy,380*Gsx,305*Gsy,tocolor(0,0,0,160),false)--Background
	dxDrawRectangle(740*Gsx,360*Gsy,380*Gsx,25*Gsy,tocolor(0,0,0,255),false)--BackgroundBAR
	dxDrawText("Hospital",1660*Gsx,361*Gsy,200*Gsx,22*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)--Header
	dxDrawText("there is still "..hospitalTime.." until you exit Hospital",1660*Gsx,420*Gsy,200*Gsx,22*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT2,"center",_,_,_,false,_,_)--Time
	dxDrawRectangle(760*Gsx,520*Gsy,340*Gsx,125*Gsy,tocolor(0,0,0,200),false)--Background Facts
	dxDrawText("Did you know already?",1660*Gsx,530*Gsy,200*Gsx,22*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT2,"center",_,_,_,false,_,_)--FactTitle
	dxDrawText(fact,1660*Gsx,580*Gsy,200*Gsx,22*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT2,"center",_,_,_,false,_,_)--Tact
	setElementData(lp,"lobby","dead")
end

addEvent("render.hospital",true)
addEventHandler("render.hospital",root,function()
	if(tonumber(getElementData(lp,"AdminLVL"))>=1 or tonumber(getElementData(lp,"PremiumLVL"))>=1)then
		hospitalTime=15
	else
		hospitalTime=35
	end
	
	setCameraMatrix(-2524.3,592.1,50.2,-2525.1,592.6,50.1)
	fact=globalTables["facts"][math.random(1,#globalTables["facts"])]
	
	setWindowData("add","blur")
	addEventHandler("onClientRender",root,renderHospital)
	setElementData(lp,"ElementClicked",true)
	
	setTimer(function()
		hospitalTime=hospitalTime-1
		if(hospitalTime==0)then
			triggerServerEvent("spawn:hospital",lp,lp)
			removeEventHandler("onClientRender",root,renderHospital)
			showChat(true)
			setElementData(lp,"ElementClicked",false)
			setWindowData("remove","blur")
		end
	end,1000,hospitalTime)
end)