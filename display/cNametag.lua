--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

cNametag={}
cNametag.__index=cNametag

nameSphere=createColSphere(0,0,0,settings.general.nametagerange)

nameTagPlayers={}
nameTagVisible={}
nameTagHP={}
nameTagImages={}
nameTagAimTarget=lp

local players=getElementsByType("player")
for _,v in pairs(players)do
	setPlayerNametagShowing(v,false)
end
addEventHandler("onClientPlayerJoin",root,function()
	setPlayerNametagShowing(source,false)
end)

function nameTagSpawn()
	detachElements(nameSphere)
	if isElement(lp)then
		attachElements(nameSphere,lp)
	end
end
setTimer(nameTagSpawn,1000,0)

function nameTagSphereHit(element,dim)
	if getElementType(element)=="player" and not(element==lp)then
		nameTagPlayers[element]=true
		nameTagImages[element]={}
		--nameTagCheckPlayerSight(element)
		cNametag:checkPlayerSight(element)
	end
end
addEventHandler("onClientColShapeHit",nameSphere,nameTagSphereHit)

function cNametag:checkPlayerSight(player)
--function nameTagCheckPlayerSight(player)
	if isElement(player)then
		local x1,y1,z1=getPedBonePosition(player,8)
		local x2,y2,z2=getPedBonePosition(lp,8)
		local hit=processLineOfSight(x1,y1,z1,x2,y2,z2,true,false,false,true,false)
		nameTagVisible[player]=not hit
		if nameTagVisible[player]then
			nameTagHP[player]=getElementHealth(lp)
		end
		
		local team=getElementData(player,"team")
		
		if not nameTagImages[player]then
			nameTagImages[player]={}
		end
		nameTagImages[player]["Staffmember.png"]=false
		nameTagImages[player]["Adminduty.png"]=false
		--//Wanteds
		nameTagImages[player]["Wanted1.png"]=false
		nameTagImages[player]["Wanted2.png"]=false
		nameTagImages[player]["Wanted3.png"]=false
		nameTagImages[player]["Wanted4.png"]=false
		nameTagImages[player]["Wanted5.png"]=false
		nameTagImages[player]["Wanted6.png"]=false
		--Teams
		nameTagImages[player]["TeamPolice.png"]=false
		nameTagImages[player]["TeamBallas.png"]=false
		nameTagImages[player]["TeamGrove.png"]=false
		
		if(tonumber(getElementData(player,"AdminLVL")))then
			if(tonumber(getElementData(player,"AdminLVL"))>=1)then
				nameTagImages[player]["Staffmember.png"]=true
			end
		end
		if(getElementData(player,"duty:admin")~=false)then
			nameTagImages[player]["Adminduty.png"]=true
		end
		--//Teams
		if(team)then
			if(team=="Police")then
				nameTagImages[player]["TeamPolice.png"]=true
			elseif(team=="Grove")then
				nameTagImages[player]["TeamGrove.png"]=true
			elseif(team=="Ballas")then
				nameTagImages[player]["TeamBallas.png"]=true
			end
		end
		--//Wanteds
		if(tonumber(getElementData(player,"Wanteds")))then
			if(tonumber(getElementData(player,"Wanteds"))==1)then
				nameTagImages[player]["Wanted1.png"]=true
			elseif(tonumber(getElementData(player,"Wanteds"))==2)then
				nameTagImages[player]["Wanted2.png"]=true
			elseif(tonumber(getElementData(player,"Wanteds"))==3)then
				nameTagImages[player]["Wanted3.png"]=true
			elseif(tonumber(getElementData(player,"Wanteds"))==4)then
				nameTagImages[player]["Wanted4.png"]=true
			elseif(tonumber(getElementData(player,"Wanteds"))==5)then
				nameTagImages[player]["Wanted5.png"]=true
			elseif(tonumber(getElementData(player,"Wanteds"))==6)then
				nameTagImages[player]["Wanted6.png"]=true
			end
		end
	else
		nameTagPlayers[player]=nil
		nameTagVisible[player]=nil
		nameTagHP[player]=nil
	end
end

function nameTagSphereLeave(element)
	nameTagPlayers[element]=nil
	nameTagVisible[element]=nil
	nameTagHP[element]=nil
end
addEventHandler("onClientColShapeLeave",nameSphere,nameTagSphereLeave)

local levelRenderTargets={}

function cNametag:constructor()
	setElementData(lp,"isChatBoxInputActive",tostring(isChatBoxInputActive()))
	local x,y,z,sx,sy
	local name,social
	local r,g,b,armor
	local images,drawn
	
	if not CDN:getReady()then
		return
	end
	
	if(isLoggedin(lp))then
		--if(tonumber(getElementData(lp,"Nametag"))==1)then
			if(isPlayerMapVisible(lp)==false)then
				for key,_ in pairs(nameTagVisible)do
					if(isElement(key))then
						if(nameTagVisible[key])then
							local x,y,z=getElementPosition(key)
							if(x)and(y)and(z)then
								sx,sy=getScreenFromWorldPosition(x,y,z+1.1,1000,true)
								if(sy)and(sy)then
									r,g,b=calcRGBByHP(key)
									r1,g1,b1=80,80,80
									name=getPlayerName(key)
									social=""
									
									if(isChatBoxInputActive())then
										setElementData(lp,"isChatBoxInputActive",true)
									else
										setElementData(lp,"isChatBoxInputActive",false)
									end
									if(getElementData(key,"isChatBoxInputActive")==true)then 
										social="writes..."
									end
									if(getElementData(key,"duty:admin")==true)then
										social="Supportmodus"
										r1,g1,b1=200,0,0
									end
									if(tonumber(getElementData(key,"PremiumLVL"))>=1 and tonumber(getElementData(key,"AdminLVL"))==0)then
										dxDrawText(name.."#DAA520 [VIP]",sx-2,sy-2,sx,sy,tocolor(r,g,b,255),1.2,dxFONT4,"center","center")
									else
										dxDrawText(name,sx-2,sy-2,sx,sy,tocolor(r,g,b,255),1.2,dxFONT4,"center","center")
									end
									
									dxDrawText(social,sx,sy+30,sx,sy,tocolor(0,0,0,255),.9,"default-bold","center","center")
									dxDrawText(social,sx-2,sy-1+30,sx,sy,tocolor(r1,g1,b1,255),.9,"default-bold","center","center")
									dxSetRenderTarget()
									
									images,drawn=0,0
									for _,v in pairs(nameTagImages[key])do
										if(v)then
											images=images+1
										end
									end
									for i,v in pairs(nameTagImages[key])do
										if(v)then
											local imgpath=":"..settings.general.scriptname.."/FILES/IMAGES/Nametag/"..i
											if(images/2==math.floor(images/2))then
												dxDrawImage(sx+20*(drawn)-images*20+20,sy+20,20,20,imgpath)
												drawn=drawn+1
											else
												dxDrawImage(sx+20*(drawn)-images*20/2,sy+20,20,20,imgpath)
												drawn=drawn+1
											end
										end
									end
								end
							end
						end
					else
						cNametag:checkPlayerSight(key)
					end
				end
			end
		--end
	end
end
addEventHandler("onClientRender",root,function()cNametag:constructor()end)

function calcRGBByHP(player)
	local hp=player:getHealth()
	local armor=player:getArmor()
	if hp<=0 then
		return 0,0,0
	else
		if armor>0 then
			armor=math.abs(armor-0.01)
			return 0+(2.55*armor),(255),0+(2.55*armor)
		else
		hp=math.abs(hp-0.01)
		return(100-hp)*2.55/2,(hp*2.55),0
		end
	end
end

function reCheckNameTag()
	if(isElement(getCameraTarget()))then
		detachElements(nameSphere)
		attachElements(nameSphere,getCameraTarget())
	end
	setElementInterior(nameSphere,getElementInterior(lp))
	setElementDimension(nameSphere,getElementDimension(lp))
	if(isPedAiming(lp)and getPedWeaponSlot(lp)==6)then
		local x1,y1,z1=getPedTargetStart(lp)
		local x2,y2,z2=getPedTargetEnd(lp)
		local boolean,x,y,z,hit=processLineOfSight(x1,y1,z1,x2,y2,z2)
		if(boolean)then
			if(isElement(hit))then
				if(getElementType(hit)=="player")then
					nameTagAimTarget=hit
					nameTagPlayers[nameTagAimTarget]=nameTagAimTarget
				end
			end
		end
	end
	for i,_ in pairs(nameTagPlayers)do
		cNametag:checkPlayerSight(i)
	end
end
setTimer(reCheckNameTag,1000,0)