--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

--//              it's not Perfect!

local ContainerRobState=true

local ContainerRobPlayerTimer={}

local ContainerRobCooldown=80
local ContainerRobTimer=math.random(2,4)

addEvent("rob:container",true)
addEventHandler("rob:container",root,function(player)
	if(isEvil(player))then
		if(getMembersOnline("Police")>=0)then
			if(getDistanceBetweenPoints3D(164.2,-1774.7,4.2,getElementPosition(player))<=2)then--LS Strand
				if(ContainerRobState~=true)then
					return false
				end
				
				ContainerRobState=false
				
				setTimer(function()
					ContainerRobState=true
				end,ContainerRobCooldown*60*1000,1)
				setPedAnimation(player,"bomber","BOM_Plant_Loop",-1,true,false,false)
				givePlayerWantedLevel(player,3)
				syncSetElementData(player,"Crowbar",syncGetElementData(player,"Crowbar")-1)
				ContainerRobPlayerTimer[player]=setTimer(function()
					local ContainerrobbedMoney=math.random(3500,7500)
					local ContainerrobbedWeed=math.random(150,500)
					setPedAnimation(player)
					givePlayerSelfMoney(player,"money",ContainerrobbedMoney)
					syncSetElementData(player,"Weed",tonumber(syncGetElementData(player,"Weed"))+ContainerrobbedWeed)
					givePlayerEXP(player,35)
					outputChatBox("You robbed the Container successfully! You get $"..ContainerrobbedMoney.." & x"..ContainerrobbedWeed.." Weed.",player,0,150,0)
				end,ContainerRobTimer*60*1000,1)
				triggerClientEvent(player,"show:containerrobtimer",player,ContainerRobTimer*60)
			end
			
		else
			notificationShow(player,"error","Not enough cops online! (5)")
		end
	else
		notificationShow(player,"error","You are not in a gang!")
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if(isTimer(ContainerRobPlayerTimer[source]))then
		killTimer(ContainerRobPlayerTimer[source])
	end
end)
addEventHandler("onPlayerQuit",root,function()
	if(isTimer(ContainerRobPlayerTimer[source]))then
		killTimer(ContainerRobPlayerTimer[source])
	end
end)