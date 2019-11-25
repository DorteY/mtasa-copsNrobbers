--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo) & Lars-Marcel      ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local fonts={
	header=dxCreateFont("files/FONTS/HARABARA.ttf",25),
	normal=dxCreateFont("files/FONTS/HARABARA.ttf",16),
	normal2=dxCreateFont("files/FONTS/HARABARA.ttf",13)
}

local notification = {
	display = false,
	sound = nil,
}

function notificationShow(typ, text, lng)
	local time = string.len(text)*50
	if (time < 5000) then
		time = 5000
	end
	if (tonumber(lng) ~= nil) then time = lng*1000 end
	
	if isTimer(notification.timer)then
		killTimer(notification.timer)
	end
	
	if isElement(notification.sound) then
		destroyElement(notification.sound)
		notification.sound = nil
	end
	
	notification = {}
	notification = {
		display = true,
		image = ":"..settings.general.scriptname.."/files/IMAGES/Infobox/"..typ..".png",
		text = text,
		startTick = getTickCount(),
		curYpos = 0,
		time = time,
		timer = nil,
		state = "starting",
		sound = nil
	}

	
	--setTimer(function()
		notification.sound = playSound(":"..settings.general.scriptname.."/files/SOUNDS/Infobox/"..typ..".mp3")
	--end, 250, 1)
	
	setWindowFlashing(true, 9999)
	
	outputConsole("[Notification]: "..text)
	
	if (isTrayNotificationEnabled()) then
		local ityp = "default"
		if (typ == "info" or typ == "warning" or typ == "error") then
			ityp = typ
		end
		createTrayNotification(text, ityp, true)
	end
end
addEvent("notificationShow", true)
addEventHandler("notificationShow", root, notificationShow)

addEventHandler("onClientRender", root, function ()
	if (notification.display == true) then
		
		if (notification.state == "starting") then
			
			local progress = (getTickCount() - notification.startTick) / 800
			local intY = interpolateBetween(-130, 0, 0, 22, 0, 0, progress, "InOutQuad")
			if intY then
				notification.curYpos = intY
			else
				notification.curYpos = 100
			end
			if (progress > 1) then
				notification.state = "showing"
				notification.timer = setTimer(function()
					notification.startTick = getTickCount()
					notification.state = "hiding"
				end, notification.time, 1)
			end
		elseif (notification.state == "showing") then
			notification.curYpos = 22
		elseif (notification.state == "hiding") then
			local progress = (getTickCount() - notification.startTick) / 500
			local intY = interpolateBetween(22, 0, 0, -190, 0, 0, progress, "Linear")
			if (intY) then
				notification.curYpos = intY
			else
				notification.curYpos = 100
			end
			if progress > 1 then
				notification.display = false
				notification.state = nil
				return
			end
		else
			return
		end
		
		local x, y = (GLOBALscreenX/2 - 364/2), notification.curYpos
		local textX, textY = x+40, notification.curYpos+35
		local textWidth, textHeight = 345, 50

		dxDrawRectangle(x, y-5, 364, 127, tocolor(0, 0, 0, 162), false)
        dxDrawImage(x+12, y+2, 40, 40, notification.image, 0, 0, 0, tocolor(255, 255, 255), false)
        dxDrawText(notification.text, textX--[[+10]], textY, textX+textWidth-50, textY+textHeight, tocolor(255, 255, 255, 255), 0.70, fonts.normal, "center", "center", false, true, false, false, false)
        dxDrawText("Information", textX, textY-90, textX+textWidth, textY+textHeight, tocolor(120,120,120,255), 0.50, fonts.header, "center", "center", false, false, false, false, false)
	end
end)

local textdiff = GLOBALscreenX/2200
local infoTable = {}
local timePerLetter = 50
local baseTime = 5000
local alpha = 255
local infoHeight = 0.02
local infoFade = 0.002

local BoxTypes = {
	["info"] = {
		lineColor = tocolor(0,146,255,alpha),
		textColor = tocolor(255,255,255,255),
		customSound = "files/SOUNDS/Infobox/info.mp3"
	},
	["error"] = {
		lineColor = tocolor(200,0,0,alpha),
		textColor = tocolor(255,255,255,255),
		customSound = "files/SOUNDS/Infobox/error.mp3"
	},
	["success"] = {
		lineColor = tocolor(0,200,0,alpha),
		textColor = tocolor(255,255,255,255),
		customSound = "files/SOUNDS/Infobox/success.mp3"
	}	
}

function infoSetText(s)
	infoTable.text = s
end

local lastMsg = nil
function infoShow(typ, msg, args)
	if (lastMsg == msg and (typ ~= "minus" and typ ~= "plus")) then return end
	lastMsg = msg
	
	local data = {
		msg = msg,
		startTime = getTickCount(),
		endTime = utfLen(msg)*timePerLetter+baseTime,
		height = 0,
		lineCount = 1,
		state = "open"
	}
	local maxTextWidthPerLine = 200
	local newText = ""
	for word in string.gmatch(data.msg, "%S+") do
		if (dxGetTextWidth(newText.." "..word, 1, fonts.normal2) >= ((0.1855*GLOBALscreenX)+40)) then
			newText = newText.."\n"..word
		else
			newText = newText.." "..word
		end
	end
	data.msg = string.sub(newText, 2)
	local _, lng = string.gsub(data.msg, "(.-)\r?\n", "")
	data.lineCount = data.lineCount + lng
	
	if (typ == "own" and type(args) == "table") then
		if args.sound then
			playSoundFrontEnd(args.sound)
		end
		data.lineColor = (args.lineColor or BoxTypes["info"].lineColor)
		data.textColor = args.textColor or BoxTypes["info"].textColor
		data.icon = args.icon or BoxTypes["info"].icon
	else
		if BoxTypes[typ].sound then
			playSoundFrontEnd(BoxTypes[typ].sound)
		end
		if BoxTypes[typ].customSound then
			playSound(BoxTypes[typ].customSound)
		end
		data.lineColor = (BoxTypes[typ].lineColor or BoxTypes["info"].lineColor)
		data.textColor = BoxTypes[typ].textColor or BoxTypes["info"].textColor
		data.icon = BoxTypes[typ].icon or BoxTypes["info"].icon
	end
	table.insert(infoTable, data)
	setWindowFlashing(true, 9999)
	
	outputConsole("[Info]: "..msg)
end
addEvent("infoShow", true)
addEventHandler("infoShow", root, infoShow)

local function updateNoti(index)
	info = infoTable[index]
	if (type(info) == "table") then
		local endTime = (info.startTime+info.endTime)*#infoTable
		if index == 1 then
			endTime = (info.startTime+info.endTime)
		end
		if getTickCount() > endTime then
			info.state = "close"
			lastMsg = nil
		end
		
		if info.state == "open" then
			if info.height < infoHeight then
				info.height = info.height+infoFade
			else
				info.height = infoHeight
				info.state = "ready"
			end
		elseif info.state == "close" then
			if info.height > infoFade then
				info.height = info.height-infoFade
			else
				info.height = 0
				table.remove(infoTable, index)
			end
		end
	end
end

addEventHandler("onClientRender", root, function()
	local absHeight  = 0.74
	local _infoTable = table.reverse(infoTable)
	for index, info in ipairs(_infoTable) do
		
		local fix = 0
		if (info.lineCount < 3) then
			fix = 12
		elseif (info.lineCount < 4) then
			fix = 8
		elseif (info.lineCount < 5) then
			fix = 6
		end
		local boxWidth, boxHeight	= 0.1855*GLOBALscreenX, (info.height*info.lineCount)*GLOBALscreenY+fix
		local boxStartX, boxStartY	= GLOBALscreenX/2-0.488*GLOBALscreenX, (absHeight*GLOBALscreenY)-boxHeight
		local boxEndX, boxEndY		= boxStartX+boxWidth, boxStartY+boxHeight
				
		dxDrawRectangle(boxStartX, boxStartY, boxWidth, boxHeight, tocolor(0, 0, 0, 161))
		if not info.icon then
			dxDrawText(utf8.escape(info.msg),boxStartX+7, boxStartY+3, boxEndX, boxEndY, info.textColor, (1/infoHeight*info.height)*textdiff, fonts.normal2, "left", "center", false, false, false, false, false)
		else
			dxDrawText(utf8.escape(info.msg),boxStartX+45, boxStartY+3, boxEndX, boxEndY, info.textColor, (1/infoHeight*info.height)*textdiff, fonts.normal2, "left", "center", false, false, false, false, false)
		end
		dxDrawLine(boxStartX-1, boxStartY-1, boxEndX-1, boxStartY-1, info.lineColor, 3)
		if info.icon then
		local newBoxHeight = boxHeight
		if info.lineCount == 1 then newBoxHeight = newBoxHeight-8 end
		if info.lineCount == 2 then newBoxHeight = (newBoxHeight-8)-21.6 end
			dxDrawImage(boxStartX+5, boxStartY+4, boxWidth-328, newBoxHeight, info.icon, 0, 0, 0, tocolor(255, 255, 255), false)
		end

		updateNoti(index)
		absHeight = absHeight - (boxHeight/GLOBALscreenY) - 0.01
	end
end)