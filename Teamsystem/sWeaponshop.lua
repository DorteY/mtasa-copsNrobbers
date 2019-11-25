--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

LSPDwshopPICK=createPickup(257,70.0,1003.6,3,2061,50)--LS
setElementInterior(LSPDwshopPICK,6)
setElementDimension(LSPDwshopPICK,20)
LSGROVEwshopPICK=createPickup(2499.7,-1707,1014.7,3,2061,50)--LS
setElementInterior(LSGROVEwshopPICK,3)
setElementDimension(LSGROVEwshopPICK,26)
LSBALLASwshopPICK=createPickup(1215.7,-26,1000.9,3,2061,50)--LS
setElementInterior(LSBALLASwshopPICK,3)
setElementDimension(LSBALLASwshopPICK,27)

function STAAT_Weaponshop_Func(player)
	if(isLoggedin(player))then
		if(isState(player))then
			triggerClientEvent(player,"open:staat_weaponshop_gui",root)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not a policeman!",7500)
		end
	end
end
addEventHandler("onPickupHit",LSPDwshopPICK,STAAT_Weaponshop_Func)

function GANG_Weaponshop_Func(player)
	if(isLoggedin(player))then
		if(isEvil(player))then
			triggerClientEvent(player,"open:gang_weaponshop_gui",root)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are not a gang-member!",7500)
		end
	end
end
addEventHandler("onPickupHit",LSGROVEwshopPICK,GANG_Weaponshop_Func)
addEventHandler("onPickupHit",LSBALLASwshopPICK,GANG_Weaponshop_Func)


addEvent("buy:staat_gang:weapons",true)
addEventHandler("buy:staat_gang:weapons",root,function(player,typ)
	if(player==client)then
		if(isEvil(player)or isState(player))then
		local team=getElementData(player,"team")
			if(typ=="nitestick")then
				if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.stick)then
					giveWeapon(player,3,1,true)
					player:setHealth(100)
					takePlayerSelfMoney(player,"money",settings.teams.weaponprice.stick)
					if(tonumber(syncGetElementData(player,"Introtask"))==2)then
						syncSetElementData(player,"Introtask",3)
						syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
						givePlayerEXP(player,50)
						uLevel(player)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
				end
			elseif(typ=="colt45")then
				if(tonumber(syncGetElementData(player,"LEVEL"..team..""))>=settings.teams.weaponprice.coltLVL)then
					if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.colt45)then
						giveWeapon(player,22,51,true)
						player:setHealth(100)
						takePlayerSelfMoney(player,"money",settings.teams.weaponprice.colt45)
						if(tonumber(syncGetElementData(player,"Introtask"))==2)then
							syncSetElementData(player,"Introtask",3)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
							givePlayerEXP(player,50)
							uLevel(player)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			elseif(typ=="deagle")then
				if(tonumber(syncGetElementData(player,"LEVEL"..team..""))>=settings.teams.weaponprice.deagleLVL)then
					if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.deagle)then
						giveWeapon(player,24,28,true)
						player:setHealth(100)
						takePlayerSelfMoney(player,"money",settings.teams.weaponprice.deagle)
						if(tonumber(syncGetElementData(player,"Introtask"))==2)then
							syncSetElementData(player,"Introtask",3)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
							givePlayerEXP(player,50)
							uLevel(player)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			elseif(typ=="mp5")then
				if(tonumber(syncGetElementData(player,"LEVEL"..team..""))>=settings.teams.weaponprice.mp5LVL)then
					if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.mp5)then
						giveWeapon(player,29,90,true)
						player:setHealth(100)
						takePlayerSelfMoney(player,"money",settings.teams.weaponprice.mp5)
						if(tonumber(syncGetElementData(player,"Introtask"))==2)then
							syncSetElementData(player,"Introtask",3)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
							givePlayerEXP(player,50)
							uLevel(player)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			elseif(typ=="m4")then
				if(tonumber(syncGetElementData(player,"LEVEL"..team..""))>=settings.teams.weaponprice.m4LVL)then
					if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.m4)then
						giveWeapon(player,31,90,true)
						player:setHealth(100)
						takePlayerSelfMoney(player,"money",settings.teams.weaponprice.m4)
						if(tonumber(syncGetElementData(player,"Introtask"))==2)then
							syncSetElementData(player,"Introtask",3)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
							givePlayerEXP(player,50)
							uLevel(player)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			elseif(typ=="rifle")then
				if(tonumber(syncGetElementData(player,"LEVEL"..team..""))>=settings.teams.weaponprice.rifleLVL)then
					if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.rifle)then
						giveWeapon(player,33,90,true)
						player:setHealth(100)
						takePlayerSelfMoney(player,"money",settings.teams.weaponprice.rifle)
						if(tonumber(syncGetElementData(player,"Introtask"))==2)then
							syncSetElementData(player,"Introtask",3)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
							givePlayerEXP(player,50)
							uLevel(player)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			elseif(typ=="sniper")then
				if(tonumber(syncGetElementData(player,"LEVEL"..team..""))>=settings.teams.weaponprice.sniperLVL)then
					if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.sniper)then
						giveWeapon(player,34,90,true)
						player:setHealth(100)
						takePlayerSelfMoney(player,"money",settings.teams.weaponprice.sniper)
						if(tonumber(syncGetElementData(player,"Introtask"))==2)then
							syncSetElementData(player,"Introtask",3)
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+500)
							givePlayerEXP(player,50)
							uLevel(player)
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not the required level!",5000)
				end
			elseif(typ=="armor")then
				if(getPlayerSelfMoney(player,"money")>=settings.teams.weaponprice.armor)then
					player:setArmor(100)
					player:setHealth(100)
					takePlayerSelfMoney(player,"money",settings.teams.weaponprice.armor)
				else
					triggerClientEvent(player,"draw:infobox",root,"error","You do have not enough money!",5000)
				end
			end
		end
	end
end)

addEvent("change:teamskin",true)
addEventHandler("change:teamskin",root,function(typ)
	if(typ)then
		local rdmSkin=math.random(1,#globalTables[typ]["skins"])
		local skin=globalTables[typ]["skins"][rdmSkin]
		
		setElementModel(client,skin)
	end
end)