--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

cHud={hudTable={"ammo","armour","clock","health","money","weapon","wanted","area_name","vehicle_name","breath","clock","ammo"}}
cHud. __index=cHud

function cHud:deconstructorComponents()
	for i=1,#cHud.hudTable do
		setPlayerHudComponentVisible(cHud.hudTable[i],false)
	end
	toggleControl("radar",false)
end
addEventHandler("onClientRender",root,function()cHud:deconstructorComponents()end)

local i=0
function cHud:constructor()
	if(isLoggedin())then
		if(getElementData(lp,"open:selectteamGUI")==false)then
			if(getElementData(lp,"intchange")==false)then
				if(not lp:isDead())then
					if(isPlayerMapVisible(lp)==false)then
						if not CDN:getReady()then
							return
						end
						local health=getElementHealth(lp)or 0
						local armor=getPedArmor(lp)or 0
						local lvvl=getElementData(lp,"LEVEL"..getElementData(lp,"team"))or 0
						local pep=syncClientGetElementData("EXP"..getElementData(lp,"team"))or 0
						local wanted=tonumber(getElementData(lp,"Wanteds"))or 0
						local jailtime=tonumber(syncClientGetElementData("Jailtime"))or 0
						local weaponID=getPedWeapon(lp)or 0
						local health=240/100*health
						local armor=240/100*armor
						local pep=240/settings.general.level_exp[lvvl]*pep
						
						local healthTXT=math.floor(getElementHealth(lp))or 0
						local armorTXT=math.floor(getPedArmor(lp))or 0
						local lvvlTXT=getElementData(lp,"LEVEL"..getElementData(lp,"team"))or 0
						local pepTXT=syncClientGetElementData("EXP"..getElementData(lp,"team"))or 0
						
						i=i+1
						dxDrawRectangle(1625*Gsx,15*Gsy,280*Gsx,30*Gsy,tocolor(0,0,0,220),false)--Background(Name)
						dxDrawText(lp:getName(),1635*Gsx,20*Gsy,200*Gsx,22*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT2,_,_,_,_,false,_,_)--name Text
						dxDrawImage(1800*Gsx,18*Gsy,35*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/LogoWhite.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawText("v."..settings.general.version,3540*Gsx,20*Gsy,200*Gsx,22*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)--version Text
						dxDrawRectangle(1625*Gsx,50*Gsy,280*Gsx,35*Gsy,tocolor(0,0,0,220),false)--Background(Armor)
						dxDrawImage(1875*Gsx,54.7*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/Armor.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawImage(1629*Gsx,54.7*Gsy,240*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/ArmorBG.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawImageSection(1629*Gsx,54.7*Gsy,armor*Gsx,25*Gsy,i,0,1.55*armor,10,":"..settings.general.scriptname.."/files/IMAGES/Hud/ArmorBAR.png")
						dxDrawText(armorTXT.."%",3295*Gsx,55*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
						
						dxDrawRectangle(1625*Gsx,90*Gsy,280*Gsx,35*Gsy,tocolor(0,0,0,220),false)--Background(Health)
						dxDrawImage(1875*Gsx,94.7*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/Health.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawImage(1629*Gsx,94.7*Gsy,240*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/HealthBG.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawImageSection(1629*Gsx,94.7*Gsy,health*Gsx,25*Gsy,i,0,1.55*health,10,":"..settings.general.scriptname.."/files/IMAGES/Hud/HealthBAR.png")
						dxDrawText(healthTXT.."%",3295*Gsx,95*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
						
						dxDrawRectangle(1625*Gsx,130*Gsy,280*Gsx,35*Gsy,tocolor(0,0,0,220),false)--Background(Level)
						dxDrawImage(1875*Gsx,134.7*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/Level.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawImage(1629*Gsx,134.7*Gsy,240*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/LevelBG.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawImageSection(1629*Gsx,134.7*Gsy,pep*Gsx,25*Gsy,i,0,1.55*pep,10,":"..settings.general.scriptname.."/files/IMAGES/Hud/LevelBAR.png")
						dxDrawText(lvvlTXT,3575*Gsx,138.5*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),0.70*Gsx,dxFONT,"center",_,_,_,false,_,_)
						if(getElementData(lp,"team")~="Civilian")then
							dxDrawText(pepTXT.."/"..settings.general.level_exp[lvvlTXT],3295*Gsx,135*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
						else
							dxDrawText("0",3295*Gsx,135*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
						end
						
						dxDrawRectangle(1625*Gsx,170*Gsy,280*Gsx,35*Gsy,tocolor(0,0,0,220),false)--Background(Money)
						dxDrawImage(1875*Gsx,174.7*Gsy,25*Gsx,25*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/Money.png",0,0,0,tocolor(255,255,255,255),false)
						dxDrawText("$ "..math.floor(mymoney),1640*Gsx,175*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,_,_,_,_,false,_,_)
						
						dxDrawEmptyRectangle(1510*Gsx,15*Gsy,105*Gsx,106*Gsy,tocolor(0,0,0,220),4,false)
						dxDrawRectangle(1510*Gsx,15*Gsy,105*Gsx,106*Gsy,tocolor(0,0,0,160),false)
						dxDrawImage(1513*Gsx,17*Gsy,100*Gsx,100*Gsy,"files/IMAGES/Hud/Weapons/"..tostring(weaponID)..".png",0.0,0.0,0.0,tocolor(255,255,255,200),false)
						dxDrawRectangle(1510*Gsx,130*Gsy,105*Gsx,35*Gsy,tocolor(0,0,0,220),false)--Background(Ammo)
						if(lp:getWeapon()==0)then
							dxDrawText("Fist",1532*Gsx,136*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
						else
							dxDrawText(getPedAmmoInClip(lp).." | "..getPedTotalAmmo(lp)-getPedAmmoInClip(lp),1532*Gsx,136*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
						end
						
						if(tonumber(syncClientGetElementData("Jailtime"))>=1)then
							dxDrawRectangle(1625*Gsx,210*Gsy,280*Gsx,35*Gsy,tocolor(0,0,0,220),false)
							dxDrawText("Jailtime: "..jailtime.." minutes",1640*Gsx,218*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT4,_,_,_,_,false,_,_)
						end
						
						
						for i=0,5 do
							if(wanted>=tonumber(i+1))then
								dxDrawImage(1545*Gsx+i*48.5*Gsx+80*Gsx,220*Gsy,40*Gsx,40*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Hud/Wanted.png",0,0,0,tocolor(220,220,0,255),true)
							end
						end
						
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,function()cHud:constructor()end)