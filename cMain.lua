--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

loadstring(exports.dgs:dgsImportFunction())()

CoD={Window={},Button={},Gridlist={},GridlistColumn={},Label={},Edit={},Image={},Tabpanel={},Tab={},Music={},Memo={},Combo={},ComboItem={},CPicker={}}

lp=getLocalPlayer()
GLOBALscreenX,GLOBALscreenY=guiGetScreenSize()
Gsx=GLOBALscreenX/1920
Gsy=GLOBALscreenY/1080

setJetpackMaxHeight(9999)
setOcclusionsEnabled(false)
setWorldSoundEnabled(5,false)

dxFONT=dxCreateFont("files/FONTS/BEBAS.ttf",14)
dxFONT2=dxCreateFont("files/FONTS/SEGOEUI.ttf",10)
dxFONT3=dxCreateFont("files/FONTS/Arial.ttf",12)
dxFONT4=dxCreateFont("files/FONTS/Roboto-Thin.ttf",11)

function isMouseInPosition(x,y,width,height)
	if(not isCursorShowing())then
		return false
	end
    local cx,cy=getCursorPosition()
    local cx,cy=(cx*GLOBALscreenX),(cy*GLOBALscreenY)
    if((cx>=x and cx<=x+width)and(cy>=y and cy<=y+height))then
        return true
    else
        return false
    end
end

function showCursor_Func()
	if(isLoggedin(lp))then
		if(getElementData(lp,"ElementClicked")==false)then
			showCursor(not(isCursorShowing()))
		end
	end
end
bindKey("m","down",showCursor_Func)
bindKey("b","down",showCursor_Func)
bindKey("ralt","down",showCursor_Func)

function getPOS()
	if(tonumber(getElementData(lp,"AdminLVL"))>=5)then
		x,y,z=getElementPosition(lp)
		xr,yr,zr=getElementRotation(lp)
		outputChatBox("Your Position: "..x..", " ..y..", " ..z,239,100,0,true)
		outputChatBox("Your Rotation: "..xr..", " ..yr..", " ..zr,239,100,0,true)
		
		setClipboard(x..","..y..","..z)
	end
end
addCommandHandler("pos",getPOS)

function dxDrawEmptyRectangle(x,y,width,height,color,_width,postGUI)
	_width=_width or 1
	dxDrawLine(x,y,x+width,y,color,_width,postGUI)
	dxDrawLine(x,y,x,y+height,color,_width,postGUI)
	dxDrawLine(x,y+height,x+width,y+height,color,_width,postGUI)
	return dxDrawLine(x+width,y,x+width,y+height,color,_width,postGUI)
end

local ScreenSource=dxCreateScreenSource(GLOBALscreenX,GLOBALscreenY)
local blurStrength=7
function createBlurShader()
	if(fileExists(":"..settings.general.scriptname.."/files/SHADERS/Blur.fx"))then
		blurShader=dxCreateShader(":"..settings.general.scriptname.."/files/SHADERS/Blur.fx")
	else
		setTimer(function()
			createBlurShader()
		end,1000,1)
	end
end
createBlurShader()

function renderBlur()
	if(blurShader)then
		dxUpdateScreenSource(ScreenSource)
		dxSetShaderValue(blurShader,"ScreenSource",ScreenSource)
		dxSetShaderValue(blurShader,"BlurStrength",blurStrength)
		dxSetShaderValue(blurShader,"UVSize",GLOBALscreenX,GLOBALscreenY)
		dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,blurShader)
	end
end


function setWindowData(typ,typ2,typ3)
	if(typ=="add")then
		if(typ2=="blur")then
			removeEventHandler("onClientRender",root,renderBlur)
			addEventHandler("onClientRender",root,renderBlur)
		end
		if(typ2=="cursor_clicked")then
			showCursor(true)
			setElementData(lp,"ElementClicked",true)
		end
		if(typ3==true)then
			local sound=playSound(":"..settings.general.scriptname.."/files/SOUNDS/UI/Open.mp3")
			setSoundVolume(sound,syncClientGetElementData("Soundvolume"))
		end
	end
	if(typ=="remove")then
		if(typ2=="blur")then
			removeEventHandler("onClientRender",root,renderBlur)
		end
		if(typ2=="cursor_clicked")then
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end
		if(typ3==true)then
			local sound=playSound(":"..settings.general.scriptname.."/files/SOUNDS/UI/Close.mp3")
			setSoundVolume(sound,syncClientGetElementData("Soundvolume"))
		end
		
		if(getElementData(lp,"InTuninggarage")~=false)then
			triggerServerEvent("spawn:tuninggarage",lp)
			unbindKey("arrow_r","down",bindRightTuningsys_Func)
			unbindKey("arrow_l","down",bindLeftTuningsys_Func)
		end
		
	end
end


addEventHandler("onClientPlayerWasted",lp,function()
	if(isElement(CoD.Window[1]))then
		dgsCloseWindow(CoD.Window[1])
		setWindowData("remove","cursor_clicked",false)
		setWindowData("remove","blur")
	end
	if(isElement(CoD.Window[2]))then
		dgsCloseWindow(CoD.Window[2])
		setWindowData("remove","cursor_clicked",false)
		setWindowData("remove","blur")
	end
	if(isTimer(WeedTimer))then
		killTimer(WeedTimer)
		setGameSpeed(1)
	end
end)

--//Loadingscreen
function drawLoadingScreen_Func()
	if(loadscreenAlpha<255)then
		loadscreenAlpha=loadscreenAlpha+0.85
	end
	dxDrawRectangle(0,0,GLOBALscreenX,GLOBALscreenY,tocolor(0,0,0,loadscreenAlpha),true)
	dxDrawText("Loading...",950*Gsx,430*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),1.3*Gsx,dxFONT4,"center","center",_,_,false,_,_)
	dxDrawText("Did you know already?\n\n"..loadscreenFakt,950*Gsx,800*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),1.0*Gsx,dxFONT4,"center","center",_,_,false,_,_)
end

addEvent("createLoadscreen",true)
addEventHandler("createLoadscreen",root,function()
	loadscreenFakt=globalTables["facts"][math.random(1,#globalTables["facts"])]
	loadscreenAlpha=0
	fadeCamera(false)
	removeEventHandler("onClientRender",root,drawLoadingScreen_Func)
	addEventHandler("onClientRender",root,drawLoadingScreen_Func)
	
	setTimer(function()
		fadeCamera(true)
		removeEventHandler("onClientRender",root,drawLoadingScreen_Func)
	end,3000,1)
end)

function isPedAiming(ped)
	if(ped and isElement(ped))then
		if(getElementType(ped)=="player" or getElementType(ped)=="ped")then
			if getPedTask(ped,"secondary",0)=="TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

addEventHandler("onClientPedDamage",root,function()
	if(getElementData(source,"dontdamagePED")==true)then
		cancelEvent()
	end
end)

addEventHandler("onClientResourceStart",resourceRoot,function()
	--//Break Objects
	for _,v in pairs(getElementsByType("object"))do
		local objectid=getElementModel(v)
		
		if(objectid==2942)then
			setObjectBreakable(v,false)
		end
	end
	
	--//Renderdistance
	for _,v in pairs(globalTables["loaddistance"])do
		engineSetModelLODDistance(v[1],v[2])
	end
end)

--//Stop rotor
function ResetRotor1_Func(heli)
	local h=tonumber(getHelicopterRotorSpeed(heli))
	if(h)then
		if(h<0.016)then
			setHelicopterRotorSpeed(heli,0)
		else
			setHelicopterRotorSpeed(heli,(h*0.935))
		end
	end
end
function ResetRotor2_Func(heli)
	local h=tonumber(getHelicopterRotorSpeed(heli))
	if(h)then
		if(h<0.22)then
			setHelicopterRotorSpeed(heli,h*1.01)
		else
			setHelicopterRotorSpeed(heli,0.22)
		end
	end
end
function ResetRotor_Func()
	local veh=getElementsByType("vehicle")
	for _,v in ipairs(veh)do
		local m=getElementModel(v)
		if((m==548)or(m==425)or(m==417)or(m==487)or(m==588)or(m==497)or(m==563)or(m==447)or(m==469)or(m==488))then
			if getVehicleEngineState(v) then
				ResetRotor2_Func(v)
			else
				ResetRotor1_Func(v)
			end
		end
	end
end
addEventHandler("onClientPreRender",root,ResetRotor_Func)