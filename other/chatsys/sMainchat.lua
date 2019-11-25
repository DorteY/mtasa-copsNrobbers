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
end,5000,0)

addEventHandler("onPlayerPrivateMessage",root,
function()
    cancelEvent()
end)

function Localchat_Func(message,messageTyp)
	if(isLoggedin(source))then
		if not source:isDead()then
			if(tonumber(syncGetElementData(source,"Mutedtime"))==0)then
				if(messageTyp==0)then
					if(not(antiSpamMSG[source]))then
						antiSpamMSG[source]=0
					end
					antiSpamMSG[source]=antiSpamMSG[source]+1
					
					if(antiSpamMSG[source]<=3)then
						local x,y,z=getElementPosition(source)
						local chatSphere=createColSphere(x,y,z,16)
						local nearbyPlayers=getElementsWithinColShape(chatSphere,"player")
						
						for _,v in ipairs(nearbyPlayers)do
							if(isLoggedin(v))then
								outputChatBox("[Local]: "..getPlayerName(source).." says: "..message,v,255,255,255)
							end
						end
						outputLog("[Local]: "..getPlayerName(source).." says: "..message.."","Chatsys")
						sendDiscordMessage(1,"[Local]: "..getPlayerName(source)..": "..message)
					else
						notificationShow(source,"error","Please dont spam!")
					end
				elseif(messageTyp==2)then
					executeCommandHandler("t",source,message)
				end
			else
				notificationShow(source,"error","You are muted! ("..tonumber(syncGetElementData(source,"Mutedtime")).." minutes)")
			end
		end
	end
	cancelEvent()
end
addEventHandler("onPlayerChat",root,Localchat_Func)