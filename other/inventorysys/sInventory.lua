--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("use:item",true)
addEventHandler("use:item",root,function(item)
	if(not gotLastHit[client] or gotLastHit[client]+lastHitTimer<=getTickCount())then
		if(not client:isDead())then
			if(tonumber(syncGetElementData(client,item))>=1)then
				if(item=="Burger")then
					if(getElementHealth(client)<100)then
						client:setAnimation("food","EAT_Burger",-1,false,false,false,false)
						setElementHealth(client,getElementHealth(client)+20)
						syncSetElementData(client,item,syncGetElementData(client,item)-1)
						notificationShow(client,"info","You eating a "..item.."!")
					end
				elseif(item=="Weed")then
					if(syncGetElementData(client,item)>=4)then
						client:setAnimation("smoking","M_smkstnd_loop",-1,false,false,false,false)
						syncSetElementData(client,item,syncGetElementData(client,item)-4)
						triggerClientEvent(client,"use:weedeffect",client)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","You need this item 4x to use it!",8000)
					end
				elseif(item=="Crowbar")then
					if(syncGetElementData(client,item)>=1)then
						triggerEvent("rob:container",client,client)
					else
						triggerClientEvent(client,"draw:infobox",root,"error","You need this item 1x to use it!",8000)
					end
				end
				setPlayerAchievement(client,3)
				triggerClientEvent(client,"refresh:inventory",client)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"warning","wait 2 minutes after the last damage before you can eat/use items",8000)
	end
end)