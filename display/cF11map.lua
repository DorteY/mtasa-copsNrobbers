--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local screenW,screenH = guiGetScreenSize()
local middleX,middleY = screenW/2,screenH/2

local localPlayer  = getLocalPlayer()
local thisResource = getThisResource()

local toggle        = false
local zoom          = 1
local zoomRate      = 0.1
local movementSpeed = 5
local minZoomLimit  = 1
local maxZoomLimit  = 5

local xOffset = 0
local yOffset = 0

local x,y         = 0,0
local hSize,vSize = 0,0

local R,G,B,A      = 255,255,255,175
local mapDrawColor = tocolor(R,G,B,A)
local normalColor  = tocolor(255,255,255,255)

local mapFile                           = "files/IMAGES/Radar/Map.jpg"
local mapFile2                          = "files/IMAGES/Radar/Map2.jpg"
local mapFile3                          = "files/IMAGES/Radar/Map3.jpg"
local mapFile4                          = "files/IMAGES/Radar/Map4.jpg"
local topLeftWorldX,topLeftWorldY       = -3000,3000
local lowerRightWorldX,lowerRightWorldY = 3000,-3000
local mapWidth,mapHeight                = 6000,6000
local pixelsPerMeter                    = screenH/6000
local imageOwnerResource                = getThisResource()

local abs=math.abs

function calculateFirstCoordinates()
	hSize=pixelsPerMeter*mapWidth*zoom
	vSize=pixelsPerMeter*mapHeight*zoom
	
	x=middleX-hSize/2+xOffset*zoom
	y=middleY-vSize/2+yOffset*zoom
end
addEventHandler("onClientResourceStart",getResourceRootElement(),calculateFirstCoordinates)

function unloadImageOnOwnerResourceStop(resource)
	if resource==imageOwnerResource and resource~=thisResource then
		setPlayerMapImage()
	end
end
addEventHandler("onClientResourceStop",getRootElement(),unloadImageOnOwnerResourceStop)

function drawMap()
	if not CDN:getReady()then
		return
	end
	if(tonumber(syncClientGetElementData("Radar"))==3)then
		if not toggle then
			dxDrawImage(0,0,0,0,mapFile,0,0,0,0,false)
		else
			checkMovement()
			
			hSize=pixelsPerMeter*mapWidth*zoom
			vSize=pixelsPerMeter*mapHeight*zoom
			
			x=middleX-hSize/2+xOffset*zoom
			y=middleY-vSize/2+yOffset*zoom
			
			dxDrawImage(x,y,hSize,vSize,mapFile,0,0,0,mapDrawColor,false)
			
			drawRadarAreas()
			drawBlips()
			drawLocalPlayerArrow()
		end
	elseif(tonumber(syncClientGetElementData("Radar"))==1)then
		if not toggle then
			dxDrawImage(0,0,0,0,mapFile2,0,0,0,0,false)
		else
			checkMovement()
			
			hSize=pixelsPerMeter*mapWidth*zoom
			vSize=pixelsPerMeter*mapHeight*zoom
			
			x=middleX-hSize/2+xOffset*zoom
			y=middleY-vSize/2+yOffset*zoom
			
			dxDrawImage(x,y,hSize,vSize,mapFile2,0,0,0,mapDrawColor,false)
			
			drawRadarAreas()
			drawBlips()
			drawLocalPlayerArrow()
		end
	elseif(tonumber(syncClientGetElementData("Radar"))==2)then
		if not toggle then
			dxDrawImage(0,0,0,0,mapFile3,0,0,0,0,false)
		else
			checkMovement()
			
			hSize=pixelsPerMeter*mapWidth*zoom
			vSize=pixelsPerMeter*mapHeight*zoom
			
			x=middleX-hSize/2+xOffset*zoom
			y=middleY-vSize/2+yOffset*zoom
			
			dxDrawImage(x,y,hSize,vSize,mapFile3,0,0,0,mapDrawColor,false)
			
			drawRadarAreas()
			drawBlips()
			drawLocalPlayerArrow()
		end
	elseif(tonumber(syncClientGetElementData("Radar"))==4)then
		if not toggle then
			dxDrawImage(0,0,0,0,mapFile4,0,0,0,0,false)
		else
			checkMovement()
			
			hSize=pixelsPerMeter*mapWidth*zoom
			vSize=pixelsPerMeter*mapHeight*zoom
			
			x=middleX-hSize/2+xOffset*zoom
			y=middleY-vSize/2+yOffset*zoom
			
			dxDrawImage(x,y,hSize,vSize,mapFile4,0,0,0,mapDrawColor,false)
			
			drawRadarAreas()
			drawBlips()
			drawLocalPlayerArrow()
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawMap)

function drawRadarAreas()
	local radarareas=getElementsByType("radararea")
	if #radarareas>0 then
		local tick=abs(getTickCount()%1000-500)
		local aFactor=tick/500
		
		for k,v in ipairs(radarareas) do
			local x,y=getElementPosition(v)
			local sx,sy=getRadarAreaSize(v)
			local r,g,b,a=getRadarAreaColor(v)
			local flashing=isRadarAreaFlashing(v)
			
			if flashing then
				a=a*aFactor
			end
			
			local hx1,hy1 = getMapFromWorldPosition(x,y+sy)
			local hx2,hy2 = getMapFromWorldPosition(x+sx,y)
			local width   = hx2-hx1
			local height  = hy2-hy1
			
			dxDrawRectangle(hx1,hy1,width,height,tocolor(r,g,b,a),false)
		end
	end
end

function drawBlips()
	for k,v in ipairs(getElementsByType("blip")) do
		if not getElementData(v,"DoNotDrawOnMaximap") then
			local icon=getBlipIcon(v) or 0
			local size=(getBlipSize(v) or 2)*4
			local r,g,b,a=getBlipColor(v)
			
			if icon~=0 then
				r,g,b=255,255,255
				size=20
			end
			
			local x,y,z=getElementPosition(v)
			x,y=getMapFromWorldPosition(x,y)
			
			local halfsize=size/2
			
			dxDrawImage(x-halfsize,y-halfsize,size,size,"files/IMAGES/Radar/Icons/"..icon..".png",0,0,0,tocolor(r,g,b,a),false)
		end
	end
end

function drawLocalPlayerArrow()
	local x,y,z=getElementPosition(localPlayer)
	local r=getPedRotation(localPlayer)
	
	local mapX,mapY=getMapFromWorldPosition(x,y)
	
	dxDrawImage(mapX-8,mapY-8,16,16,"files/IMAGES/Radar/Icons/2.png",(-r)%360,0,0,normalColor,false)
end

function zoomOutRecalculate()
	local newVSize=pixelsPerMeter*mapHeight*zoom
	if newVSize>screenH then
		local newY=middleY-newVSize/2+yOffset*zoom
		
		if newY>0 then
			yOffset=-(middleY-newVSize/2)/zoom
		elseif newY<=(-newVSize+screenH) then
			yOffset=(middleY-newVSize/2)/zoom
		end
	else
		yOffset=0
	end
	
	local newHSize=pixelsPerMeter*mapWidth*zoom
	if newHSize>screenW then
		local newX=middleX-newHSize/2+xOffset*zoom
		
		if newX>=0 then
			xOffset=-(middleX-newHSize/2)/zoom
		elseif newX<=(-newHSize+screenW) then
			xOffset=(middleX-newHSize/2)/zoom
		end
	else
		xOffset=0
	end
end

function checkMovement()
	-- Zoom
	if getPedControlState("radar_zoom_in") and zoom<maxZoomLimit then
		zoom=zoom+zoomRate
		if zoom>maxZoomLimit then zoom=maxZoomLimit end
	elseif getPedControlState("radar_zoom_out") and zoom>minZoomLimit then
		zoom=zoom-zoomRate
		if zoom<minZoomLimit then zoom=minZoomLimit end
		
		zoomOutRecalculate()
	end
	
	-- Move
	if getPedControlState("radar_move_north") then
		local newY=y-yOffset*zoom+(yOffset+movementSpeed)*zoom
		if newY<0 then
			yOffset=yOffset+movementSpeed
		end
	end
	if getPedControlState("radar_move_south") then
		local newY=y-yOffset*zoom+(yOffset-movementSpeed)*zoom
		if newY>(-vSize+screenH) then
			yOffset=yOffset-movementSpeed
		end
	end
	if getPedControlState("radar_move_west") then
		local newXOff=(xOffset+movementSpeed)
		local newX=x-xOffset*zoom+newXOff*zoom
		
		if newX<0 then
			xOffset=xOffset+movementSpeed
		end
	end
	if getPedControlState("radar_move_east") then
		local newX=x-xOffset*zoom+(xOffset-movementSpeed)*zoom
		if newX>(-hSize+screenW) then
			xOffset=xOffset-movementSpeed
		end
	end
end

addEvent("onClientPlayerMapHide")
addEvent("onClientPlayerMapShow")

function toggleMap()
	if(isLoggedin())then
		if getElementData(lp,"open:selectteamGUI")==false then
			if toggle then
				if triggerEvent("onClientPlayerMapHide",getRootElement(),false) then
					toggle=false
					showChat(true)
				end
			else
				if triggerEvent("onClientPlayerMapShow",getRootElement(),false) then
					toggle=true
					showChat(false)
				end
			end
		end
	end
end
bindKey("F11","up",toggleMap)

-- Export functions

function getPlayerMapBoundingBox()
	return x,y,x+hSize,y+vSize
end

function setPlayerMapBoundingBox(startX,startY,endX,endY)
	if type(startX)=="number" and type(startY)=="number" and type(endX)=="number" and type(endY)=="number" then
--		TODO
		return true
	end
	return false
end

function isPlayerMapVisible()
	return toggle
end

function setPlayerMapVisible(newToggle)
	if type(newToggle)=="boolean" then
		toggle=newToggle
		
		if toggle then
			triggerEvent("onClientPlayerMapShow",getRootElement(),true)
		else
			triggerEvent("onClientPlayerMapHide",getRootElement(),true)
		end
		
		return true
	end
	return false
end

function getMapFromWorldPosition(worldX,worldY)
	local mapX=x+pixelsPerMeter*(worldX-topLeftWorldX)*zoom
	local mapY=y+pixelsPerMeter*(topLeftWorldY-worldY)*zoom
	return mapX,mapY
end

function getWorldFromMapPosition(mapX,mapY)
	local worldX=topLeftWorldX+mapWidth/hSize*(mapX-x)
	local worldY=topLeftWorldY-mapHeight/vSize*(mapY-y)
	return worldX,worldY
end

function setPlayerMapImage(image,tLX,tLY,lRX,lRY)
	if image and type(image)=="string" and type(tLX)=="number" and type(tLY)=="number" and type(lRX)=="number" and type(lRY)=="number" then
		sourceResource                    = sourceResource or thisResource
		if string.find(image,":")~=1 then
			sourceResourceName                = getResourceName(sourceResource)
			image                             = ":"..sourceResourceName.."/"..image
		end
		
		if dxDrawImage(0,0,0,0,image,0,0,0,0,false) then
			imageOwnerResource                = sourceResource
			
			mapFile                           = image
			topLeftWorldX,topLeftWorldY       = tLX,tLY
			lowerRightWorldX,lowerRightWorldY = lRX,lRY
			mapWidth,mapHeight                = lRX-tLX,tLY-lRY
			pixelsPerMeter                    = math.min(screenW/(mapWidth),screenH/mapHeight)
			
			zoom                              = 1
			xOffset                           = 0
			yOffset                           = 0
			
			return true
		end
	elseif not image then
		imageOwnerResource                = thisResource
		
		mapFile                           = "files/IMAGES/Radar/Map.jpg"
		topLeftWorldX,topLeftWorldY       = -3000,3000
		lowerRightWorldX,lowerRightWorldY = 3000,-3000
		mapWidth,mapHeight                = 6000,6000
		pixelsPerMeter                    = screenH/6000
		
		zoom                              = 1
		xOffset                           = 0
		yOffset                           = 0
		
		return true
	end
	
	return false
end

function getPlayerMapImage()
	return mapFile
end

function setPlayerMapColor(r,g,b,a)
	local color=tocolor(r,g,b,a)
	if color then
		mapDrawColor = color
		R,G,B,A      = r,g,b,a
		return true
	end
	return false
end

function setPlayerMapMovementSpeed(s)
	if type(s)=="number" then
		movementSpeed=s
		return true
	end
	return false
end

function getPlayerMapMovementSpeed()
	return movementSpeed
end

function getPlayerMapZoomFactor()
	return zoom
end

function getPlayerMapZoomRate()
	return zoomRate
end

function getBlipShowingOnMaximap(blip)
	if isElement(blip) and getElementType(blip)=="blip" then
		return not getElementData(blip,"DoNotDrawOnMaximap")
	end
	return false
end

function setBlipShowingOnMaximap(blip,toggle)
	if isElement(blip) and getElementType(blip)=="blip" and type(toggle)=="boolean" then
		return setElementData(blip,"DoNotDrawOnMaximap",not toggle,false)
	end
	return false
end

function setPlayerMapZoomFactor(z)
	if type(z)=="number" then
		if z>=minZoomLimit and z<=maxZoomLimit then
			local prevZoom=zoom
			zoom=z
			
			if z<prevZoom then
				zoomOutRecalculate()
			end
			
			return true
		end
	end
	return false
end

function setPlayerMapZoomRate(z)
	if type(z)=="number" then
		zoomRate=z
		return true
	end
	return false
end

function setPlayerMapMinZoomLimit(l)
	if type(l)=="number" then
		minZoomLimit=l
		return true
	end
	return false
end

function setPlayerMapMaxZoomLimit(l)
	if type(l)=="number" then
		maxZoomLimit=l
		return true
	end
	return false
end

function getPlayerMapMinZoomLimit()
	return minZoomLimit
end

function getPlayerMapMaxZoomLimit()
	return maxZoomLimit
end

function getPlayerMapColor()
	return R,G,B,A
end










cF11sidebar={
	MapLegendenName={
		"MAP Legende",
		"General",
		"Burgershots",
		"Vehicle",
		"Carhouses",
		"Pay 'n' Sprays",
		"Tuningshop",
		"Teams",
		"Police Station",
		"Grove Street",
		"RH Ballas",
	},
	MapLegendenImage={
		":"..settings.general.scriptname.."/files/IMAGES/Transparent.png",
		":"..settings.general.scriptname.."/files/IMAGES/Transparent.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/10.png",
		":"..settings.general.scriptname.."/files/IMAGES/Transparent.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/55.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/63.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/27.png",
		":"..settings.general.scriptname.."/files/IMAGES/Transparent.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/30.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/62.png",
		":"..settings.general.scriptname.."/files/IMAGES/Radar/Icons/59.png",
	}
}
cF11sidebar.__index=cF11sidebar

function cF11sidebar:constructor()
	if(isLoggedin())then
		if(isPlayerMapVisible(lp)~=false)then
		if not CDN:getReady()then
			return
		end
			local di=0
			for i=1,#cF11sidebar.MapLegendenName do
				dxDrawRectangle(1660*Gsx,20*Gsy,240*Gsx,20+(di*20.3)*Gsy,tocolor(0,0,0,255),false)
				dxDrawText(tostring(cF11sidebar.MapLegendenName[i]),3465*Gsx,21+(di*20)*Gsy,100*Gsx,40*Gsy,tocolor(255,255,255,255),1.10*Gsx,dxFONT2,"center",_,_,_,true,_,_)
				dxDrawImage(1665*Gsx,21+(di*20)*Gsy,20*Gsx,20*Gsy,cF11sidebar.MapLegendenImage[i],0,0,0,tocolor(255,255,255,255),true)
				di=di+1
			end
			dxDrawRectangle(1665*Gsx,41*Gsy,230*Gsx,1.5*Gsy,tocolor(60,60,60,255),false)
		end
	end
end
addEventHandler("onClientRender",root,function()cF11sidebar:constructor()end)