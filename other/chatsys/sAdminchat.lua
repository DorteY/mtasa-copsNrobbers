--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function Adminchat_Func(player,cmd,...)
	if(isLoggedin(player))then
		if(tonumber(getElementData(player,"AdminLVL"))>=1)then
			if(not player:isDead())then
				for _,v in ipairs(getElementsByType("player"))do
					if(isLoggedin(v))then
						if(tonumber(getElementData(v,"AdminLVL"))>=1)then
							if(tonumber(getElementData(player,"AdminLVL"))>=1)then
								outputChatBox("[#c80000Admin#ffffff]: "..settings.general.adminlvlColorToHASH[getElementData(player,"AdminLVL")]..""..settings.general.adminlvlnames[getElementData(player,"AdminLVL")].." #FFFFFF"..getPlayerName(player)..": "..stringTextWithAllParameters(...).."",v,255,255,255,true)
							end
						end
					end
				end
				outputLog("[Admin]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...).."","Chatsys")
			end
		end
	end
end
addCommandHandler("adminchat",Adminchat_Func)
addCommandHandler("a",Adminchat_Func)