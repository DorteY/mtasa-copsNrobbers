--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function Teamchat_Func(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"Mutedtime"))==0)then
			if(not player:isDead())then
				for _,v in ipairs(getElementsByType("player"))do
					if(isLoggedin(v))then
						if(getElementData(v,"team")==getElementData(player,"team"))then
							outputChatBox(""..settings.general.teamColorToHASH[getElementData(player,"team")].."[Team]#ffffff: "..getPlayerName(player)..": "..stringTextWithAllParameters(...),v,255,255,255,true)
						end
					end
				end
				outputLog("[Team]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...).."","Chatsys")
			end
		else
			notificationShow(player,"error","You are muted! ("..tonumber(syncGetElementData(player,"Mutedtime")).." minutes)")
		end
	end
end
addCommandHandler("t",Teamchat_Func)