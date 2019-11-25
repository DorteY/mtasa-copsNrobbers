--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function setPlayerAchievement(player,id)
	local pname=getPlayerName(player)
	local achievmentCheck=MySQL:getPdata("ACHIEVMENTS","UID",playerUID[pname],"Ach"..id)
	if(achievmentCheck==0)then
		MySQL.handler:exec("UPDATE ACHIEVMENTS SET ??=? WHERE ??=?"," Ach"..id,1,"UID",playerUID[pname])
		givePlayerSelfMoney(player,"money",1700)
		triggerClientEvent(player,"show:achievment",player,id)
		triggerClientEvent(player,"playSound",root,"Achievment",false,nil,".mp3")
	end
end


addEvent("get:achievment",true)
addEventHandler("get:achievment",root,function(clicked)
	local pname=getPlayerName(client)
	local reached=MySQL:getPdata("ACHIEVMENTS","UID",playerUID[pname],"Ach"..clicked)
	triggerClientEvent(client,"set:achievment",client,reached)
end)

function openAchievmentpanel(player)
	local tbl={}
	for i,v in pairs(globalTables["Achievements"])do
		local reached=MySQL:getPdata("ACHIEVMENTS","UID",playerUID[getPlayerName(player)],"Ach"..i)
		table.insert(tbl,{v[1],reached})
	end
	triggerClientEvent(player,"open:achievmentpanel",player,tbl)
end