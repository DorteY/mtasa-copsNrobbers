--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function transferMoney(money,typ)
	local money=tonumber(money)
	if(money)then
		if(tonumber(money)>=1)then
			if(typ=="pay:inATM")then
				if getPlayerSelfMoney(client,"money")>=tonumber(money)then
					givePlayerSelfMoney(client,"bankmoney",money)
					takePlayerSelfMoney(client,"money",money)
					triggerClientEvent(client,"draw:infobox",root,"money","You have paid in $"..money,8000)
					outputLog("The player "..getPlayerName(client).." has paid in $"..money,"Moneysys")
				end
			elseif(typ=="pay:outATM")then
				if getPlayerSelfMoney(client,"bankmoney")>=tonumber(money)then
					givePlayerSelfMoney(client,"money",money)
					takePlayerSelfMoney(client,"bankmoney",money)
					triggerClientEvent(client,"draw:infobox",root,"money","You have paid out $"..money,8000)
					outputLog("The player "..getPlayerName(client).." has paid out $"..money,"Moneysys")
				end
			end
			triggerClientEvent(client,"refresh:atm",client)
		else
			notificationShow(client,"error","Bitte gebe eine größere Zahl als 0 ein!")
		end
	end
end
addEvent("transfer:money",true)
addEventHandler("transfer:money",root,transferMoney)