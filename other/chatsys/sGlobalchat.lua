--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local antiSpamMSG={}
setTimer(function()
	for _,v in ipairs(getElementsByType("player"))do
		antiSpamMSG[v]=0
	end
end,15000,0)

local blockTable={"@"}

function Globalchat_Func(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
			if(not player:isDead())then
				if(globalChatState==true)then
					if(stringTextWithAllParameters()==nil)then	
					else
						for _,v in ipairs(blockTable)do
							if(string.find(stringTextWithAllParameters(...),v,1,true))then
								if(string.lower(stringTextWithAllParameters(...),v,1,true))then
									return false
								end
							end
						end
						
						if(not(antiSpamMSG[player]))then
							antiSpamMSG[player]=0
						end
						antiSpamMSG[player]=antiSpamMSG[player]+1
						
						if(antiSpamMSG[player]<=3)then
							if(tonumber(getElementData(player,"AdminLVL"))>=1)then
								outputChatBox("[#969600Global#ffffff]: "..settings.general.adminlvlColorToHASH[getElementData(player,"AdminLVL")]..""..settings.general.adminlvlnames[getElementData(player,"AdminLVL")].." #FFFFFF"..getPlayerName(player)..": "..stringTextWithAllParameters(...).."",root,255,255,255,true)
								outputLog("[Global]: "..settings.general.adminlvlnames[getElementData(player,"AdminLVL")].." "..getPlayerName(player)..": "..stringTextWithAllParameters(...).."","Chatsys")
							else
								outputChatBox("[#969600Global#ffffff]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...),root,255,255,255,true)
								outputLog("[Global]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chatsys")
							end
							sendDiscordMessage(1,"[Global]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...))
						else
							notificationShow(player,"error","Please dont spam!")
						end
					end
				end
			end
		else
			notificationShow(player,"error","You are muted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." minutes)")
		end
	end
end
addCommandHandler("global",Globalchat_Func)
addCommandHandler("Global",Globalchat_Func)