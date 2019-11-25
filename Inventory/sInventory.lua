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
				end
				triggerClientEvent(client,"refresh:inventory",client)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"warning","Wait 2 minutes after the last damage-\nbefore you can eat/use items",8000)
	end
end)