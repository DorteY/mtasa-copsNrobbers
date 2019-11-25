--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local pedTable={
--//SKINID,X,Y,Z,ROT,INT,DIM,COLRANGE,WEAPONID,NAME,CHATMSG
{280,1553.1,-1673.7,16.2,90,0,0,0.8,31,"LSPD Guardian","This is the L.S.P.D"},--LSPD Schranke
{280,1553.1,-1677.7,16.2,90,0,0,0.8,31,"LSPD Guardian","This is the L.S.P.D"},--LSPD Schranke
{280,1544.1,-1631.9,13.4,90,0,0,1.0,31,"LSPD Officer","This is the L.S.P.D backyard"},--LSPD Schranke
--//Burgershots
{167,376.5,-65.8,1001.5,180,10,50,1.9,nil,"Employee",nil},--LS Tempel
{167,376.5,-65.8,1001.5,180,10,51,1.9,nil,"Employee",nil},--LV Redsants
}

addEventHandler("onClientResourceStart",resourceRoot,function()
	local Peds={}
	for i,v in pairs(pedTable)do
		if(#pedTable>=1)then
			Peds[i]={}
			Peds[i].Ped=createPed(v[1],v[2],v[3],v[4],v[5])
			Peds[i].Col=createColSphere(v[2],v[3],v[4],v[8])
			if(not v[9]==nil)then
				givePedWeapon(Peds[i].Ped,v[9],999,true)
			end
			setElementInterior(Peds[i].Ped,v[6])
			setElementInterior(Peds[i].Col,v[6])
			setElementDimension(Peds[i].Ped,v[7])
			setElementDimension(Peds[i].Col,v[7])
			setElementFrozen(Peds[i].Ped,true)
			setElementData(Peds[i].Ped,"name:ped",v[10])
			
			addEventHandler("onClientPedDamage",Peds[i].Ped,function()
				cancelEvent()
			end)
			
			addEventHandler("onClientColShapeHit",Peds[i].Col,function(player)
				if(player==lp)then
					if(getElementInterior(lp)==getElementInterior(source)and getElementDimension(lp)==getElementDimension(source))then
						if(not(isPedInVehicle(lp))and isPedOnGround(lp))then
							setPedAnimation(Peds[i].Ped,"PED","IDLE_CHAT")
							if v[11] then
								outputChatBox(v[11],200,200,200)
							end
						end
					end
				end
			end)
			
			addEventHandler("onClientColShapeLeave",Peds[i].Col,function(player)
				if(player==lp)then
					if(getElementInterior(lp)==getElementInterior(source)and getElementDimension(lp)==getElementDimension(source))then
						setPedAnimation(Peds[i].Ped)
					end
				end
			end)
			
		end
	end
end)

addEventHandler("onClientRender",root,function()
	if(isLoggedin())then
		if(not(isPedDead(lp)))then
			for _,v in pairs(getElementsByType("ped"))do
				if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
					local px,py,pz=getPedBonePosition(v,8)
					local x,y,z=getPedBonePosition(lp,8)
					
					if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=15 and isLineOfSightClear(px,py,pz,x,y,z,true,false,false,true,false))then
						if(getElementData(v,"name:ped"))then
							if(not(isPedDead(v)))then
								local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true)
								
								if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)>1)then
									scale=1.7-(getDistanceBetweenPoints3D(px,py,pz,x,y,z)/70)
								else
									scale=1.7
								end
								
								if(sx and sy)then
									if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
										dxDrawText(getElementData(v,"name:ped"),sx,sy,sx,sy,tocolor(0,0,0,255),scale,dxFONT2,"center","center")
										dxDrawText(getElementData(v,"name:ped"),sx-2,sy-2,sx,sy,tocolor(50,50,50,255),scale,dxFONT2,"center","center")
									end
								end
								
							end
						end
					end
				end
			end
			
			for _,v in pairs(getElementsByType("object"))do
				local objectid=getElementModel(v)
				if(v:getDimension()==0 and v:getInterior()==0)then
					local px,py,pz=getElementPosition(lp)
					local x,y,z=getElementPosition(v)
					
					if(objectid==2942)then
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=8)then
							local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
							
							if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)>1)then
								scale=1.5-(getDistanceBetweenPoints3D(px,py,pz,x,y,z)/70)
							else
								scale=1.5
							end
							
							if(sx and sy)then
								if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
									dxDrawRectangle(sx-70,sy+15,140,50,tocolor(50,50,50,220),false)
									dxDrawText("ATM",sx-2,sy+73,sx,sy,tocolor(255,255,255,255),scale,dxFONT2,"center","center")
								end
							end
						end
					end
				end
			end
			
		end
	end
end)