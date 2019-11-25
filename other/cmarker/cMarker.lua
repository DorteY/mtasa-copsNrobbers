--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local starttick=getTickCount()
local goingup=true
local customPickupCacheTable={}


addEventHandler("onClientRender",root,function()
	if(isLoggedin())then
		local tick=getTickCount()
		local progress=(tick-starttick)/1000
		if(progress>1)then
			progress=progress-1
			starttick=starttick+1000
			goingup=not goingup
		end
		local plusZ=interpolateBetween(0,0,0,0.5,0,0,goingup and progress or 1-progress,"OutQuad")
		local index=0
		local customPickup=getElementByID("customPickup",index)
		while customPickup~=false and customPickup~=nil do
			if(customPickupCacheTable[customPickup]==nil)then
				customPickupCacheTable[customPickup]={}
			end
			if(customPickupCacheTable[customPickup]._imgobj==nil)then
				customPickupCacheTable[customPickup]._imgobj=dxCreateTexture(getElementData(customPickup,"customPickup.image"))
			end
			if(customPickupCacheTable[customPickup]._imgunderground==nil)then
				customPickupCacheTable[customPickup]._imgunderground=dxCreateTexture(getElementData(customPickup,"customPickup.uimage"))
			end
			local px,py,pz=unpack(getElementData(customPickup,"customPickup.positions"))
			local z=getGroundPosition(px-0.5,py,pz-0.5)+0.05
			dxDrawMaterialLine3D(px-0.5,py,z,px-0.5+1,py,z,customPickupCacheTable[customPickup]._imgunderground,1,tocolor(255,255,255,155),px-0.5+1,py,z+1)
			dxDrawMaterialLine3D(px,py,(pz+0.4+plusZ),px,py,(pz-0.4+plusZ),customPickupCacheTable[customPickup]._imgobj,1,tocolor(255,255,255,255))
			index=index+1
			customPickup=getElementByID("customPickup",index)
		end
    end
end)