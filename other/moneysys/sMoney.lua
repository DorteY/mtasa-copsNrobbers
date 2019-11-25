--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function payMoney_Func(player,cmd,target,money)
	if(source==client)then
		if(target)then
			if(money)then
				if(tonumber(money)>=1)then
					local target=findPlayerByName(target)
					if(isElement(target)and isLoggedin(target))then
						if(not(isPedDead(target)))then
							local tx,ty,tz=getElementPosition(target)
							local px,py,pz=getElementPosition(player)
							if(getDistanceBetweenPoints3D(tx,ty,tz,px,py,pz)<=5)then
								if(getPlayerSelfMoney(player,"money")>=tonumber(money))then
									givePlayerSelfMoney(target,"money",money)
									takePlayerSelfMoney(player,"money",money)
									outputLog(getPlayerName(player).." has "..getPlayerName(target).." $"..money.." given!","Moneysys")
								else
									triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",6000)
								end
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","The target player is dead!",6000)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","The player does not exist or is not loggedin!",6000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Enter an amount greater than 1",6000)
				end
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Enter a player!",6000)
		end
	end
end
addCommandHandler("pay",payMoney_Func)
addCommandHandler("geldgeben",payMoney_Func)