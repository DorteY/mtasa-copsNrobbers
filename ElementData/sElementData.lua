--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

elementData={}
local syncDataToClient={
--//Inventory
["Weed"]=true,
["Burger"]=true,
["Crowbar"]=true,

--//Userdata
["Bankmoney"]=true,
["Jailtime"]=true,
["Mutedtime"]=true,
["EXPBallas"]=true,
["EXPGrove"]=true,
["EXPPolice"]=true,
["Introtask"]=true,

--//Usersettings
["Hitglocke"]=true,
["Soundvolume"]=true,
["FPSLIMIT"]=true,
["Radar"]=true,
["Nametag"]=true,
["Autologin"]=true,
["Hitglock"]=true,
}

local syncDataNotToClient={

--//Userdata
["WeekPlayingtime"]=true,
["Vehicleslots"]=true,
["UID"]=true,
["SpawnX"]=true,
["SpawnY"]=true,
["SpawnZ"]=true,
["SpawnROT"]=true,
["Savezone"]=true,
}


function syncSetElementData(player,dataString,value)
	if(player and dataString and value~=nil)then	
		if(not elementData[player])then
			elementData[player]={}
		end
		elementData[player][dataString]=value
		if(dataString=="Money")then
			local value=math.floor(value)
			triggerClientEvent(player,"sync:money",player,value)
			setElementData(player,dataString,value,true)
			elementData[player][dataString]=value
		elseif(syncDataToClient[dataString])then
			triggerClientEvent(player,"trigger:clientData",player,dataString,value)
		elseif(not syncDataNotToClient[dataString] and isElement(player))then
			setElementData(player,dataString,value)
		end
	else
		return nil
	end
end

function syncGetElementData(player,dataString)
	if(player and dataString)then
		if(not elementData[player])then
			elementData[player]={}
		end
		if(elementData[player][dataString])then
			return elementData[player][dataString]
		elseif(not elementData[player][dataString] and dataString~="AdminLVL" and dataString~="Loggedin" and not syncDataNotToClient[dataString])then
			elementData[player][dataString]=getElementData(player,dataString)
			return elementData[player][dataString]
		else
			return nil
		end
	else
		return nil
	end
end

function freeElementData()
	if(elementData)then
		if(getElementType(source)~="player")then
			if(elementData[source])then
				elementData[source]=nil
			end
		end
	end
end
addEventHandler("onElementDestroy",root,freeElementData)

addEvent("change:clientData",true)
addEventHandler("change:clientData",root,function(dataString,value)
	elementData[client][dataString]=value
end)



function findPlayerByName(player)
	local pl=getPlayerFromName(player)
	if(isElement(pl))then
		return pl
	else
		for _,v in pairs(getElementsByType("player"))do
			if(string.find(string.gsub(string.lower(getPlayerName(getPlayerName(v))),"#%x%x%x%x%x%x",""),string.lower(playerPart)))then
				return v
			end
		end
	end
end