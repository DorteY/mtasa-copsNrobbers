--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

mymoney=0
local elementDataClient={}

addEvent("sync:money",true)
addEventHandler("sync:money",root,function(value)
	if(value)then
		mymoney=tonumber(value)
	end
end)

function syncClientGetElementData(dataString)
	return elementDataClient[dataString] or false
end

function syncClientSetElementData(dataString,value)
	elementDataClient[dataString]=value
	triggerServerEvent("change:clientData",lp,dataString,value)
end

addEvent("trigger:clientData",true)
addEventHandler("trigger:clientData",root,function(dataString,value)
	if(value)then
		elementDataClient[dataString]=value
	end
end)