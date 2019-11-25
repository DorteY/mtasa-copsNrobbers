--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function cTazer_Func(attacker,weapon)
	if(attacker and weapon==23)then
		if(getElementData(attacker,"team")=="Police")then
			triggerServerEvent("tazer:target",lp)
			cancelEvent()
		end
	end
end
addEventHandler("onClientPlayerDamage",lp,cTazer_Func)