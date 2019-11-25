--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

--//              it's not Perfect!

local ATMRobState=true
local ATMRobState2=true
local ATMRobState3=true
local ATMRobState4=true
local ATMRobState5=true

local ATMRobPlayerTimer={}

local ATMRobCooldown=30
local ATMRobTimer=math.random(1,2)

addEvent("hack:atm",true)
addEventHandler("hack:atm",root,function(player)
	if(player==client)then
		if(isEvil(player))then
			if(getMembersOnline("Police")>=3)then
				if(getDistanceBetweenPoints3D(1549.7,-1671.1,13.5,getElementPosition(player))<=2)then--LSPD
					if(ATMRobState~=true)then
						return false
					end
					
					ATMRobState=false
					
					setTimer(function()
						ATMRobState=true
					end,ATMRobCooldown*60*1000,1)
					setPedAnimation(player,"bomber","BOM_Plant_Loop",-1,true,false,false)
					createNewsShow("Red","Breaking News","The ATM at the LSPD is being robbed!",10000)
					sendMSGForTeam("[ACTION]: The ATM at the LSPD is being robbed!","Police",200,0,0)
					outputLog("The ATM at the LSPD is being robbed! ("..getPlayerName(player)..")","Teamsys")
					givePlayerWantedLevel(player,3)
					ATMRobPlayerTimer[player]=setTimer(function()
						local ATMrobbedMoney=math.random(5000,10000)
						setPedAnimation(player)
						givePlayerSelfMoney(player,"money",ATMrobbedMoney)
						givePlayerEXP(player,25)
						outputChatBox("You robbed the ATM successfully! You get $"..ATMrobbedMoney,player,0,150,0)
						sendMSGForTeam("[ACTION]: The ATM at the LSPD was successfully robbed!","Police",0,200,0)
					end,ATMRobTimer*60*1000,1)
					triggerClientEvent(player,"show:atmrobtimer",player,ATMRobTimer*60)
				elseif(getDistanceBetweenPoints3D(2494.4,-1643,13.7,getElementPosition(player))<=2)then--LSGROVE
					if(ATMRobState2~=true)then
						return false
					end
					
					ATMRobState2=false
					
					setTimer(function()
						ATMRobState2=true
					end,ATMRobCooldown*60*1000,1)
					setPedAnimation(player,"bomber","BOM_Plant_Loop",-1,true,false,false)
					createNewsShow("Red","Breaking News","The ATM at the Grove Street is being robbed!",10000)
					sendMSGForTeam("[ACTION]: The ATM at the Grove Street is being robbed!","Police",200,0,0)
					outputLog("The ATM at the Grove Street is being robbed! ("..getPlayerName(player)..")","Teamsys")
					givePlayerWantedLevel(player,3)
					ATMRobPlayerTimer[player]=setTimer(function()
						local ATMrobbedMoney=math.random(5000,10000)
						setPedAnimation(player)
						givePlayerSelfMoney(player,"money",ATMrobbedMoney)
						givePlayerEXP(player,25)
						outputChatBox("You robbed the ATM successfully! You get $"..ATMrobbedMoney,player,0,150,0)
						sendMSGForTeam("[ACTION]: The ATM at the Grove Street was successfully robbed!","Police",0,200,0)
					end,ATMRobTimer*60*1000,1)
					triggerClientEvent(player,"show:atmrobtimer",player,ATMRobTimer*60)
				elseif(getDistanceBetweenPoints3D(1203.1,-919.40002,42.7,getElementPosition(player))<=2)then--LS Temple
					if(ATMRobState3~=true)then
						return false
					end
					
					ATMRobState3=false
					
					setTimer(function()
						ATMRobState3=true
					end,ATMRobCooldown*60*1000,1)
					setPedAnimation(player,"bomber","BOM_Plant_Loop",-1,true,false,false)
					createNewsShow("Red","Breaking News","The ATM at Temple Burgershot is being robbed!",10000)
					sendMSGForTeam("[ACTION]: The ATM at Temple Burgershot is being robbed!","Police",200,0,0)
					outputLog("The ATM at Temple Burgershot is being robbed! ("..getPlayerName(player)..")","Teamsys")
					givePlayerWantedLevel(player,3)
					ATMRobPlayerTimer[player]=setTimer(function()
						local ATMrobbedMoney=math.random(5000,10000)
						setPedAnimation(player)
						givePlayerSelfMoney(player,"money",ATMrobbedMoney)
						givePlayerEXP(player,25)
						outputChatBox("You robbed the ATM successfully! You get $"..ATMrobbedMoney,player,0,150,0)
						sendMSGForTeam("[ACTION]: The ATM at Temple Burgershot was successfully robbed!","Police",0,200,0)
					end,ATMRobTimer*60*1000,1)
					triggerClientEvent(player,"show:atmrobtimer",player,ATMRobTimer*60)
				elseif(getDistanceBetweenPoints3D(2130.2,-1151.3,23.7,getElementPosition(player))<=2)then--LS Coutt and schutz
					if(ATMRobState4~=true)then
						return false
					end
					
					ATMRobState4=false
					
					setTimer(function()
						ATMRobState4=true
					end,ATMRobCooldown*60*1000,1)
					setPedAnimation(player,"bomber","BOM_Plant_Loop",-1,true,false,false)
					createNewsShow("Red","Breaking News","The ATM at the Coutt and Schutz carhouse is being robbed!",10000)
					sendMSGForTeam("[ACTION]: The ATM at the Coutt and Schutz carhouse is being robbed!","Police",200,0,0)
					outputLog("The ATM at the Coutt and Schutz carhouse is being robbed! ("..getPlayerName(player)..")","Teamsys")
					givePlayerWantedLevel(player,3)
					ATMRobPlayerTimer[player]=setTimer(function()
						local ATMrobbedMoney=math.random(5000,10000)
						setPedAnimation(player)
						givePlayerSelfMoney(player,"money",ATMrobbedMoney)
						givePlayerEXP(player,25)
						outputChatBox("You robbed the ATM successfully! You get $"..ATMrobbedMoney,player,0,150,0)
						sendMSGForTeam("[ACTION]: The ATM at the Coutt and Schutz carhouse was successfully robbed!","Police",0,200,0)
					end,ATMRobTimer*60*1000,1)
					triggerClientEvent(player,"show:atmrobtimer",player,ATMRobTimer*60)
				elseif(getDistanceBetweenPoints3D(1484.8,-1772.3,18.4,getElementPosition(player))<=2)then--LS Civilian-spawn
					if(ATMRobState5~=true)then
						return false
					end
					
					ATMRobState5=false
					
					setTimer(function()
						ATMRobState5=true
					end,ATMRobCooldown*60*1000,1)
					setPedAnimation(player,"bomber","BOM_Plant_Loop",-1,true,false,false)
					createNewsShow("Red","Breaking News","The ATM at Newbie-spawn is being robbed!",10000)
					sendMSGForTeam("[ACTION]: The ATM at Newbie-spawn is being robbed!","Police",200,0,0)
					outputLog("The ATM at Newbie-spawn is being robbed! ("..getPlayerName(player)..")","Teamsys")
					givePlayerWantedLevel(player,3)
					ATMRobPlayerTimer[player]=setTimer(function()
						local ATMrobbedMoney=math.random(5000,10000)
						setPedAnimation(player)
						givePlayerSelfMoney(player,"money",ATMrobbedMoney)
						givePlayerEXP(player,25)
						outputChatBox("You robbed the ATM successfully! You get $"..ATMrobbedMoney,player,0,150,0)
						sendMSGForTeam("[ACTION]: The ATM at Newbie-spawn was successfully robbed!","Police",0,200,0)
					end,ATMRobTimer*60*1000,1)
					triggerClientEvent(player,"show:atmrobtimer",player,ATMRobTimer*60)
				end
				
			else
				notificationShow(player,"error","Not enough cops online! (3)")
			end
		else
			notificationShow(player,"error","You are not in a gang!")
		end
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if(isTimer(ATMRobPlayerTimer[source]))then
		killTimer(ATMRobPlayerTimer[source])
	end
end)
addEventHandler("onPlayerQuit",root,function()
	if(isTimer(ATMRobPlayerTimer[source]))then
		killTimer(ATMRobPlayerTimer[source])
	end
end)