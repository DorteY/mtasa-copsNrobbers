--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local admindutymarker={}
local admindutyskin=260
local admindutyarray={skinTable={}}

aduty={}

function aDuty_Func(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLVL"))>=1)then
			if(not admindutyarray.skinTable[player])then
				local x,y,z=getElementPosition(player)
				local rx,ry,rz=getElementRotation(player)
				admindutyarray.skinTable[player]=getElementModel(player)
				setElementModel(player,admindutyskin)
				admindutymarker[player]=createMarker(x,y,z,"arrow",0.3,200,0,0,160)
				attachElements(admindutymarker[player],player,0,0,1.3)
				setElementDoubleSided(admindutymarker[player],true)
				
				removeEventHandler("onPlayerQuit",player,function()aduty:deconstructor()end)
				removeEventHandler("onPlayerWasted",player,function()aduty:deconstructor()end)
				removeEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
				addEventHandler("onPlayerQuit",player,function()aduty:deconstructor()end)
				addEventHandler("onPlayerWasted",player,function()aduty:deconstructor()end)
				addEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
				setElementData(player,"duty:admin",true)
				outputLog("[ADUTY]: Staff "..getPlayerName(player).." has entered ADuty mode!","Adminsystem")
			else
				admindutymarker[player]:destroy()
				setElementModel(player,admindutyarray.skinTable[player])
				admindutyarray.skinTable[player]=nil
				
				removeEventHandler("onPlayerQuit",player,function()aduty:deconstructor()end)
				removeEventHandler("onPlayerWasted",player,function()aduty:deconstructor()end)
				removeEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
				setElementData(player,"duty:admin",false)
				outputLog("[ADUTY]: Staff "..getPlayerName(player).." has left the ADuty mode!","Adminsystem")
			end
		else
			notificationShow(player,"error","You are not a Trial-Supporter!")
		end
	end
end
addCommandHandler("aduty",aDuty_Func)


function aduty:deconstructor()
	if(admindutyarray.skinTable[source])then
		admindutyarray.skinTable[source]=nil
	end
	if(isElement(admindutymarker[source]))then
		admindutymarker[source]:destroy()
	end
end