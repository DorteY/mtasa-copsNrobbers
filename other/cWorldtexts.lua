--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function draw3Dtexts_Func()
	local x,y,z=getElementPosition(lp)
	if(isLoggedin())then
		local worldtextsTable={
			{257,70.0,1003.6,6,20,"weapon store"},--LSPD Weaponshop
			{2499.7,-1707,1014.7,3,26,"weapon store"},--Grove Weaponshop
			{1215.7,-26,1000.9,3,27,"weapon store"},--Ballas Weaponshop
		}
		for _,v in ipairs(worldtextsTable)do
			local px,py,pz=v[1],v[2],v[3] or 0,0,0
			if(getDistanceBetweenPoints3D(x,y,z,px,py,pz)<=12)and(isLineOfSightClear(x,y,z,px,py,pz,true,true,true,true,true))then
				if(getElementInterior(lp,v[4]))then
					if(getElementDimension(lp,v[5]))then
						local sx,sy=guiGetScreenSize()or 0,0
						local x,y=getScreenFromWorldPosition(px,py,pz)
						if(x)and(y)then
							local dis=getDistanceBetweenPoints3D(x,y,z,px,py,pz)
							x=x-20
							dxDrawText(v[6],x,y,x,y,tocolor(0,0,0,200),1.5)
							dxDrawText(v[6],x+1,y+1,x,y,tocolor(255,255,255,200),1.5)
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,draw3Dtexts_Func)