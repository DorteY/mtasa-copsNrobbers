--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //


local enableBlips = true
local renderNorthBlip = true
local alwaysRenderMap = false
local worldW, worldH = 1536, 1536--3072
local blip = 12
local sx, sy = guiGetScreenSize()
local rt = dxCreateRenderTarget(290, 200)--190 175
local xFactor, yFactor = sx/1536, sy/1536
local yFactor = xFactor

function findRotation(x1,y1,x2,y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end
  return t
end
function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle) --90
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x+dx, y+dy
end

function Minimap_Func()
	if(isLoggedin(lp))then
		if(not lp:isDead())then
			if(lp:getInterior()==0 and lp:getDimension()==0)then
				if getElementData(lp,"open:selectteamGUI")==false then
					if getElementData(lp,"intchange")==false then
						if tonumber(syncClientGetElementData("Radar"))==3 then
							if not CDN:getReady() then
								return
							end
							setPlayerHudComponentVisible("radar",false)
							if (not isPlayerMapVisible()) then
								local mW, mH = dxGetMaterialSize(rt)
								local x, y = getElementPosition(lp)
								local X, Y = mW/2 -(x/(6000/worldW)), mH/2 +(y/(6000/worldH))
								local camX,camY,camZ = getElementRotation(getCamera())
								dxSetRenderTarget(rt, true)
								if alwaysRenderMap or getElementInterior(lp) == 0 then
									dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1)
									dxDrawImage(X - worldW/2, mH/5 + (Y - worldH/2), worldW, worldH, "files/IMAGES/Radar/Map.jpg", camZ, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
								end
								dxSetRenderTarget()
								dxDrawRectangle((10)*xFactor, sy-((200+10))*yFactor, (300)*xFactor, (200)*yFactor, tocolor(0, 0, 0, 175))
								dxDrawImage((10+5)*xFactor, sy-((200+5))*yFactor, (300-10)*xFactor, (190)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, 150))
								local rx, ry, rz = getElementRotation(lp)
								local lB = (15)*xFactor --15
								local rB = (15+290)*xFactor
								local tB = sy-(205)*yFactor
								local bB = tB + (190)*yFactor
								local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor --35
								local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
								
								for k,v in ipairs(getElementsByType("blip"))do
									local bx, by = getElementPosition(v)
									local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
									local maxDist = getBlipVisibleDistance(v)
									if actualDist <= maxDist and getElementDimension(v)==getElementDimension(lp) and getElementInterior(v)==getElementInterior(lp) then
										local dist = actualDist/(6000/((worldW+worldH)/2))
										local rot = findRotation(bx, by, x, y)-camZ
										local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
										local bpx = math.max(lB, math.min(rB, bpx))
										local bpy = math.max(tB, math.min(bB, bpy))
										local icon = getElementData(v, "customIcon") or getBlipIcon(v)
										local _, _, _, bcA = getBlipColor(v)
										local bcR, bcG, bcB = 255, 255, 255
										if getBlipIcon(v) == 0 then
											bcR, bcG, bcB = getBlipColor(v)
										end
										local bS = getBlipSize(v)
										dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, "files/IMAGES/Radar/Icons/"..icon..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
									end
								end
								if renderNorthBlip then
									local rot = -camZ+180
									local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot)
									local bpx = math.max(lB, math.min(rB, bpx))
									local bpy = math.max(tB, math.min(bB, bpy))
									local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy)
									local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot)
									if bpx and bpy then
										local bpx = math.max(lB, math.min(rB, bpx))
										local bpy = math.max(tB, math.min(bB, bpy))
										dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "files/IMAGES/Radar/Icons/4.png", 0, 0, 0)
									end
								end
								dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2)*yFactor, "files/IMAGES/Radar/Icons/2.png", camZ-rz, 0, 0)
							end
						elseif tonumber(syncClientGetElementData("Radar"))==1 then
							if not CDN:getReady() then
								return
							end
							setPlayerHudComponentVisible("radar",false)
							if (not isPlayerMapVisible()) then
								local mW, mH = dxGetMaterialSize(rt)
								local x, y = getElementPosition(lp)
								local X, Y = mW/2 -(x/(6000/worldW)), mH/2 +(y/(6000/worldH))
								local camX,camY,camZ = getElementRotation(getCamera())
								dxSetRenderTarget(rt, true)
								if alwaysRenderMap or getElementInterior(lp) == 0 then
									dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1)
									dxDrawImage(X - worldW/2, mH/5 + (Y - worldH/2), worldW, worldH, "files/IMAGES/Radar/Map2.jpg", camZ, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
								end
								dxSetRenderTarget()
								dxDrawRectangle((10)*xFactor, sy-((200+10))*yFactor, (300)*xFactor, (200)*yFactor, tocolor(0, 0, 0, 175))
								dxDrawImage((10+5)*xFactor, sy-((200+5))*yFactor, (300-10)*xFactor, (190)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, 150))
								local rx, ry, rz = getElementRotation(lp)
								local lB = (15)*xFactor --15
								local rB = (15+290)*xFactor
								local tB = sy-(205)*yFactor
								local bB = tB + (190)*yFactor
								local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor --35
								local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
								
								for k,v in ipairs(getElementsByType("blip"))do
									local bx, by = getElementPosition(v)
									local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
									local maxDist = getBlipVisibleDistance(v)
									if actualDist <= maxDist and getElementDimension(v)==getElementDimension(lp) and getElementInterior(v)==getElementInterior(lp) then
										local dist = actualDist/(6000/((worldW+worldH)/2))
										local rot = findRotation(bx, by, x, y)-camZ
										local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
										local bpx = math.max(lB, math.min(rB, bpx))
										local bpy = math.max(tB, math.min(bB, bpy))
										local icon = getElementData(v, "customIcon") or getBlipIcon(v)
										local _, _, _, bcA = getBlipColor(v)
										local bcR, bcG, bcB = 255, 255, 255
										if getBlipIcon(v) == 0 then
											bcR, bcG, bcB = getBlipColor(v)
										end
										local bS = getBlipSize(v)
										dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, "files/IMAGES/Radar/Icons/"..icon..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
									end
								end
								if renderNorthBlip then
									local rot = -camZ+180
									local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot)
									local bpx = math.max(lB, math.min(rB, bpx))
									local bpy = math.max(tB, math.min(bB, bpy))
									local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy)
									local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot)
									if bpx and bpy then
										local bpx = math.max(lB, math.min(rB, bpx))
										local bpy = math.max(tB, math.min(bB, bpy))
										dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "files/IMAGES/Radar/Icons/4.png", 0, 0, 0)
									end
								end
								dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2)*yFactor, "files/IMAGES/Radar/Icons/2.png", camZ-rz, 0, 0)
							end
						elseif tonumber(syncClientGetElementData("Radar"))==2 then
							if not CDN:getReady() then
								return
							end
							setPlayerHudComponentVisible("radar",false)
							if (not isPlayerMapVisible()) then
								local mW, mH = dxGetMaterialSize(rt)
								local x, y = getElementPosition(lp)
								local X, Y = mW/2 -(x/(6000/worldW)), mH/2 +(y/(6000/worldH))
								local camX,camY,camZ = getElementRotation(getCamera())
								dxSetRenderTarget(rt, true)
								if alwaysRenderMap or getElementInterior(lp) == 0 then
									dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1)
									dxDrawImage(X - worldW/2, mH/5 + (Y - worldH/2), worldW, worldH, "files/IMAGES/Radar/Map3.jpg", camZ, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
								end
								dxSetRenderTarget()
								dxDrawRectangle((10)*xFactor, sy-((200+10))*yFactor, (300)*xFactor, (200)*yFactor, tocolor(0, 0, 0, 175))
								dxDrawImage((10+5)*xFactor, sy-((200+5))*yFactor, (300-10)*xFactor, (190)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, 150))
								local rx, ry, rz = getElementRotation(lp)
								local lB = (15)*xFactor --15
								local rB = (15+290)*xFactor
								local tB = sy-(205)*yFactor
								local bB = tB + (190)*yFactor
								local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor --35
								local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
								
								for k,v in ipairs(getElementsByType("blip"))do
									local bx, by = getElementPosition(v)
									local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
									local maxDist = getBlipVisibleDistance(v)
									if actualDist <= maxDist and getElementDimension(v)==getElementDimension(lp) and getElementInterior(v)==getElementInterior(lp) then
										local dist = actualDist/(6000/((worldW+worldH)/2))
										local rot = findRotation(bx, by, x, y)-camZ
										local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
										local bpx = math.max(lB, math.min(rB, bpx))
										local bpy = math.max(tB, math.min(bB, bpy))
										local icon = getElementData(v, "customIcon") or getBlipIcon(v)
										local _, _, _, bcA = getBlipColor(v)
										local bcR, bcG, bcB = 255, 255, 255
										if getBlipIcon(v) == 0 then
											bcR, bcG, bcB = getBlipColor(v)
										end
										local bS = getBlipSize(v)
										dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, "files/IMAGES/Radar/Icons/"..icon..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
									end
								end
								if renderNorthBlip then
									local rot = -camZ+180
									local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot)
									local bpx = math.max(lB, math.min(rB, bpx))
									local bpy = math.max(tB, math.min(bB, bpy))
									local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy)
									local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot)
									if bpx and bpy then
										local bpx = math.max(lB, math.min(rB, bpx))
										local bpy = math.max(tB, math.min(bB, bpy))
										dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "files/IMAGES/Radar/Icons/4.png", 0, 0, 0)
									end
								end
								dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2)*yFactor, "files/IMAGES/Radar/Icons/2.png", camZ-rz, 0, 0)
							end
						elseif(syncClientGetElementData("Radar")==4)then
							setPlayerHudComponentVisible("radar",true)
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,Minimap_Func)