--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local SOUND_TEXT_BACKGROUND_X = GLOBALscreenX  * 0.4
local SOUND_TEXT_BACKGROUND_Y = GLOBALscreenY * 0.05
local SOUND_TEXT_BACKGROUND_H = GLOBALscreenY * 0.05
local SOUND_TEXT_BACKGROUND_PADDING = GLOBALscreenY / 76.8

local SOUND_TEXT_BACKGROUND_COLOR_R = 245
local SOUND_TEXT_BACKGROUND_COLOR_G = 245
local SOUND_TEXT_BACKGROUND_COLOR_B = 245
local SOUND_TEXT_BACKGROUND_COLOR_A = 255

local SOUND_TEXT_X1 = GLOBALscreenX  * 0.4
local SOUND_TEXT_Y1 = GLOBALscreenY * 0.05
local SOUND_TEXT_X2 = GLOBALscreenX  * 0.6
local SOUND_TEXT_Y2 = GLOBALscreenY * 0.1

local SOUND_TEXT_FONT   = "pricedown"
local SOUND_TEXT_SCALE  = GLOBALscreenY / 768
local SOUND_TEXT_HALIGN = "center"
local SOUND_TEXT_VALIGN = "center"

local SOUND_TEXT_COLOR_R = 0
local SOUND_TEXT_COLOR_G = 0
local SOUND_TEXT_COLOR_B = 0
local SOUND_TEXT_COLOR_A = 255

local SOUND_TEXT_FADE_TIME       = 2000
local SOUND_TEXT_FADE_WAIT_TIME  = 6000
local SOUND_TEXT_TOTAL_FADE_TIME = SOUND_TEXT_FADE_WAIT_TIME + SOUND_TEXT_FADE_TIME * 2

--------------------------------- End of settings ---------------------------------

local displayText  = ""
local startTick
local eventHandled = false

function showRadioDisplay(text)
	if type(text) == "string" then
		displayText = text
		local tick  = getTickCount()
					
		if not startTick then
			startTick = tick
		else
			local fadeTime = tick - startTick
			
			if fadeTime > (SOUND_TEXT_TOTAL_FADE_TIME - SOUND_TEXT_FADE_TIME) then
				startTick = startTick + fadeTime - (fadeTime - (SOUND_TEXT_TOTAL_FADE_TIME - SOUND_TEXT_FADE_TIME))
			elseif fadeTime > SOUND_TEXT_FADE_TIME then
				startTick = tick - SOUND_TEXT_FADE_TIME
			end
		end
		
		if not eventHandled then
			addEventHandler("onClientRender",getRootElement(),renderRadioDisplay, true, "low-1")
			eventHandled = true
		end
		
		return true
	end
	
	return false
end

function hideRadioDisplay()
	if eventHandled then
		startTick = math.min(startTick,getTickCount() - (SOUND_TEXT_TOTAL_FADE_TIME - SOUND_TEXT_FADE_TIME))
		
		return true
	end
	
	return false
end

function renderRadioDisplay()
	local tick       = getTickCount()
	local timeFading = tick - startTick
	
	if timeFading < SOUND_TEXT_TOTAL_FADE_TIME then
		local alpha
		
		if timeFading < SOUND_TEXT_FADE_TIME then
			alpha = timeFading / SOUND_TEXT_FADE_TIME
		elseif timeFading > (SOUND_TEXT_TOTAL_FADE_TIME - SOUND_TEXT_FADE_TIME) then
			alpha = 1 - (timeFading - (SOUND_TEXT_TOTAL_FADE_TIME - SOUND_TEXT_FADE_TIME)) / SOUND_TEXT_FADE_TIME
		else
			alpha = 1
		end
		
		local width = dxGetTextWidth(displayText,SOUND_TEXT_SCALE,SOUND_TEXT_FONT) + SOUND_TEXT_BACKGROUND_PADDING * 2
		
		dxDrawRectangle(GLOBALscreenX / 2 - width / 2,SOUND_TEXT_BACKGROUND_Y,width,SOUND_TEXT_BACKGROUND_H,tocolor(SOUND_TEXT_BACKGROUND_COLOR_R,SOUND_TEXT_BACKGROUND_COLOR_G,SOUND_TEXT_BACKGROUND_COLOR_B,alpha*SOUND_TEXT_BACKGROUND_COLOR_A))
		dxDrawText(displayText,SOUND_TEXT_X1,SOUND_TEXT_Y1,SOUND_TEXT_X2,SOUND_TEXT_Y2,tocolor(SOUND_TEXT_COLOR_R,SOUND_TEXT_COLOR_G,SOUND_TEXT_COLOR_B,alpha*SOUND_TEXT_COLOR_A),SOUND_TEXT_SCALE,SOUND_TEXT_FONT,SOUND_TEXT_HALIGN,SOUND_TEXT_VALIGN)
	else
		startTick    = nil
		eventHandled = false
		
		removeEventHandler("onClientRender",getRootElement(),renderRadioDisplay)
	end
end