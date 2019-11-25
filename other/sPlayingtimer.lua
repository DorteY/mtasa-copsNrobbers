--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local paydayPlayerTimerTable={}
function setPlayerPaydayTimer(player)
	if(not(isTimer(paydayPlayerTimerTable[player])))then
		paydayPlayerTimerTable[player]=setTimer(function()
			Payday_Func(player)
		end,1*60*1000,0)
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(paydayPlayerTimerTable[source]))then
		--killTimer(paydayPlayerTimerTable[source])
		paydayPlayerTimerTable[source]:destroy()
	end
end)

function Payday_Func(player)
	if(isElement(player))then
		if(isLoggedin(player))then
			if(getElementData(player,"open:selectteamGUI")==false)then
				if(getElementData(player,"AFK")==false)then
					syncSetElementData(player,"Playingtime",tonumber(syncGetElementData(player,"Playingtime"))+1)
					syncSetElementData(player,"WeekPlayingtime",tonumber(syncGetElementData(player,"WeekPlayingtime"))+1)
					
					if(tonumber(syncGetElementData(player,"PremiumLVL"))>=1)then
						syncSetElementData(player,"PremiumLVL",tonumber(syncGetElementData(player,"PremiumLVL"))-1)
						if(tonumber(syncGetElementData(player,"PremiumLVL"))==0)then
							outputChatBox("Your premium has just expired!",player,200,0,0)
							deleteBlaster(player)
						end
					end
					if(tonumber(syncGetElementData(player,"Mutedtime"))>=1)then
						syncSetElementData(player,"Mutedtime",tonumber(syncGetElementData(player,"Mutedtime"))-1)
						if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
							outputChatBox("You are now unmuted!",player,200,0,0)
						end
					end
					
					
					if(tonumber(syncGetElementData(player,"Jailtime"))>=1)then
						syncSetElementData(player,"Jailtime",tonumber(syncGetElementData(player,"Jailtime"))-1)
						if(tonumber(syncGetElementData(player,"Jailtime"))==0)then
							fadeElementInterior(player,globalTables["Police"]["jailoutspawn"][1],globalTables["Police"]["jailoutspawn"][2],globalTables["Police"]["jailoutspawn"][3],globalTables["Police"]["jailoutspawn"][4],0,0,true)
						end
					end
					
					if(math.floor(syncGetElementData(player,"Playingtime")/60)==(syncGetElementData(player,"Playingtime")/60))then
						
						
						
						
						if(tonumber(getElementData(player,"Wanteds"))>=1)then
							setElementData(player,"Wanteds",tonumber(getElementData(player,"Wanteds"))-1)
							outputChatBox("You have lost 1 Wanted",player,200,0,0)
						end
						
					end
				end
			end
		end
	end
end