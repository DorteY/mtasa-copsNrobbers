--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function uLevel(player)
	if(getElementData(player,"team")~="Civilian")then
		if(tonumber(syncGetElementData(player,"LEVEL"..getElementData(player,"team")..""))<=9)then
			if(getElementData(player,"team")=="Ballas")then
				if(tonumber(syncGetElementData(player,"EXPBallas"))>=settings.general.level_exp[tonumber(syncGetElementData(player,"LEVELBallas"))])then
					syncSetElementData(player,"LEVELBallas",tonumber(syncGetElementData(player,"LEVELBallas"))+1)
					syncSetElementData(player,"EXPBallas",tonumber(0))
					outputChatBox("Congratulations, you have just reached ballas-level "..tonumber(syncGetElementData(player,"LEVELBallas")).."!",player,255,255,255)
				end
			elseif(getElementData(player,"team")=="Grove")then
				if(tonumber(syncGetElementData(player,"EXPGrove"))>=settings.general.level_exp[tonumber(syncGetElementData(player,"LEVELGrove"))])then
					syncSetElementData(player,"LEVELGrove",tonumber(syncGetElementData(player,"LEVELGrove"))+1)
					syncSetElementData(player,"EXPGrove",tonumber(0))
					outputChatBox("Congratulations, you have just reached grove-level "..tonumber(syncGetElementData(player,"LEVELGrove")).."!",player,255,255,255)
				end
			elseif(getElementData(player,"team")=="Police")then
				if(tonumber(syncGetElementData(player,"EXPPolice"))>=settings.general.level_exp[tonumber(syncGetElementData(player,"LEVELPolice"))])then
					syncSetElementData(player,"LEVELPolice",tonumber(syncGetElementData(player,"LEVELPolice"))+1)
					syncSetElementData(player,"EXPPolice",tonumber(0))
					outputChatBox("Congratulations, you have just reached police-level "..tonumber(syncGetElementData(player,"LEVELPolice")).."!",player,255,255,255)
				end
			end
		end
	end
end