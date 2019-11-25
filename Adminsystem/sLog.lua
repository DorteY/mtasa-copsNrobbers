--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("get:logs",true)
addEventHandler("get:logs",root,function(logs)
	if(fileExists("LOGS/"..logs..".log"))then
		local file=fileOpen("LOGS/"..logs..".log")
		local text=fileRead(file,99999999999)
		
		triggerClientEvent(client,"set:logs:text",client,text)
		fileClose(file)
	else
		triggerClientEvent(client,"set:logs:text",client,"No logs were found.")
	end
end)

addEvent("delete:logs",true)
addEventHandler("delete:logs",root,function(player)
	if(tonumber(syncGetElementData(player,"AdminLVL"))>=5)then
		if(fileExists("LOGS/Adminsystem.log"))then
			fileDelete("LOGS/Adminsystem.log")
		end
		if(fileExists("LOGS/Chatsys.log"))then
			fileDelete("LOGS/Chatsys.log")
		end
		if(fileExists("LOGS/Damage_Kills_Deaths.log"))then
			fileDelete("LOGS/Damage_Kills_Deaths.log")
		end
		if(fileExists("LOGS/Teamsys.log"))then
			fileDelete("LOGS/Teamsys.log")
		end
		if(fileExists("LOGS/Login_Logout.log"))then
			fileDelete("LOGS/Login_Logout.log")
		end
		if(fileExists("LOGS/Moneysys.log"))then
			fileDelete("LOGS/Moneysys.log")
		end
	end
end)