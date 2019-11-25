--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //


function loadBloodScreen()
	if(fileExists("files/IMAGES/Bloodscreen.png"))then
		Bloodscreen=guiCreateStaticImage(0,0,1,1,"files/IMAGES/Bloodscreen.png",true)
		guiSetAlpha(Bloodscreen,0)
		guiSetEnabled(Bloodscreen,false)
	else setTimer(loadBloodScreen,1000,1)end
end
loadBloodScreen()

function showBloodFlash()
	guiSetEnabled(Bloodscreen,true)
	if(isTimer(bloodTimer))then
		killTimer(bloodTimer)
	end
	bloodTimer=setTimer(bloodFlash,50,0)
	guiSetAlpha(Bloodscreen,1)
end

function bloodFlash()
	local alpha=guiGetAlpha(Bloodscreen)
	if(alpha==0)then
		killTimer(bloodTimer)
		guiSetEnabled(Bloodscreen,false)
	else
		guiSetAlpha(Bloodscreen,alpha-0.1)
	end
end

function cancelAllDamage(attacker,weapon,bodypart,loss)
	if(attacker==lp)then
		if(not(weapon==17 and getElementModel(source)==285))then
			if(attacker and weapon and bodypart and loss)then
				if(globalTables["weaponDMG"][weapon])then
					if(syncClientGetElementData("Hitglocke")>=2)then
						hitsound=playSound(":"..settings.general.scriptname.."/files/SOUNDS/Hitsound"..syncClientGetElementData("Hitglocke")..".mp3")
						setSoundVolume(hitsound,0.3)
					end
					triggerServerEvent("damageCalcServer",lp,attacker,weapon,bodypart,loss,source)
				end
			end
		end
	elseif(lp==source)then
		if(not(isPedDead(source)))then
			showBloodFlash()
		end
		if(attacker and weapon and bodypart and loss)then
			if(globalTables["weaponDMG"][weapon])then
				cancelEvent()
			end
		end
	end
end
addEventHandler("onClientPlayerDamage",root,cancelAllDamage)