--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function createBlaster(link)
	if(client:getDimension()==0 and client:getInterior()==0)then
		if(isElement(Ghettoblaster[client]))then
			Ghettoblaster[client]:destroy()
		end
		Ghettoblaster[client]=createObject(2226,0,0,0)
		attachElementToBone(Ghettoblaster[client],client,12,0,0,0.4,0,180,0)
		for _,v in pairs(getElementsByType("player"))do
			triggerClientEvent(v,"play:premmusic",v,client,link)
		end
	end
end
addEvent("create:premmusicbox",true)
addEventHandler("create:premmusicbox",root,createBlaster)

function deleteBlaster(player)
	if(isElement(Ghettoblaster[player]))then
		Ghettoblaster[player]:destroy()
		for _,v in pairs(getElementsByType("player"))do
			triggerClientEvent(v,"stop:premmusic",v,player)
		end
	end
end
addEvent("delete:premmusicbox",true)
addEventHandler("delete:premmusicbox",root,deleteBlaster)

addEvent("change:premmusicboxvolume",true) 
addEventHandler("change:premmusicboxvolume",root,function(amount)
	triggerClientEvent(root,"change:premmusicboxvolumeC",client,amount)
end)


addEventHandler("onPlayerQuit",root,function()
	deleteBlaster(source)
end)

addEventHandler("onPlayerWasted",root,function()
	deleteBlaster(source)
end)