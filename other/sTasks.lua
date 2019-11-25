--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("give:helpmenueReward",true)
addEventHandler("give:helpmenueReward",root,function()
	if(tonumber(syncGetElementData(client,"Introtask"))==1)then
		syncSetElementData(client,"Introtask",2)
		givePlayerSelfMoney(client,"money",500)
		uLevel(client)
	end
end)

addEventHandler("onPlayerWasted",root,function(ammo,attacker,weapon,bodypart)
	if(attacker and attacker~=getPlayerName(source))then
		if(tonumber(syncGetElementData(attacker,"Introtask"))==3)then
			syncSetElementData(attacker,"Introtask",4)
			givePlayerSelfMoney(client,"money",1200)
		end
	end
end)