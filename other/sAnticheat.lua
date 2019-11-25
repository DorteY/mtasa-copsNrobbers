--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local allowedDataTable={
	["isChatBoxInputActive"]=true,
	--
	["open:selectteamGUI"]=true,
	["ElementClicked"]=true,
	["FPSLIMIT"]=true,
	["Hitglocke"]=true,
	["Nametag"]=true,
	["lobby"]=true,
	["radio:channel"]=true,
	--//Bankrob
	["bankAim"]=true,
	
	--//Test
	["superman:takingOff"]=true,
	["superman:flying"]=true,
}

addEventHandler("onElementDataChange",root,function(nameValue,oldValue,newValue)
	if(client~=nil and getElementType(client)=="player")and not(allowedDataTable[nameValue])then
		sendDiscordMessage(6,"The player "..getPlayerName(client).." has tried "..nameValue .." to change from "..oldValue.." to "..newValue .."!")
		setElementData(source,nameValue,oldValue)
		outputDebugString("Value: "..nameValue)
		kickPlayer(client,"Anticheat","Cheating is not allowed! (There is an error? Then report it!)")
	end
end)


addCommandHandler("hrun",function(player)
	outputLog("The player "..getPlayerName(player).." has used the command /hrun!","Anticheat")
	sendDiscordMessage(6,"The player "..getPlayerName(player).." has used the command /hrun!")
end)
addCommandHandler("crun",function(player)
	outputLog("The player "..getPlayerName(player).." has used the command /crun!","Anticheat")
	sendDiscordMessage(6,"The player "..getPlayerName(player).." has used the command /crun!")
end)
addCommandHandler("srun",function(player)
	outputLog("The player "..getPlayerName(player).." has used the command /srun!","Anticheat")
	sendDiscordMessage(6,"The player "..getPlayerName(player).." has used the command /srun!")
end)

addEventHandler("onPlayerCommand",root,function(cmd)
	if(not isLoggedin(source))then
		cancelEvent()
	end
end)