--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo) & Lars             ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local cdn={}

downloadMusicState=false

function downloadMusicP()
	downloadMusic=playSound("https://lake-gaming.com/Downloadmusic.mp3",true)
	downloadMusicState=true
end

function downloadMusic_Func()
	if(downloadMusicState~=false)then
		downloadMusic:stop()
		unbindKey("m","down",downloadMusic_Func)
		downloadMusicState=false
	end
end
bindKey("m","down",downloadMusic_Func)

function cdn.new()
    local self=setmetatable({},{__index=cdn})
    self.m_Counter=0
    self.m_Max=0
    self.m_Content={}
    self.m_Ready=false
	
	downloadMusicP()
	
    addEvent("cdn:receiveContent",true)
    addEvent("cdn:receiveFile",true)
    addEvent("cdn:onClientReady",true)
    addEventHandler("cdn:receiveContent",root,function(...)self:receiveContent(...)end)
    addEventHandler("cdn:receiveFile",root,function(...)self:receiveFile(...)end)
    self.m_fRender=function(...)self:renderMain(...)end
    self.m_ScreenX,self.m_ScreenY=guiGetScreenSize()
    self.m_Width,self.m_Heigth=320,40
    triggerServerEvent("cdn:requireContent",lp)
    setCameraMatrix(1778.8,-1323.5,123.4,1779.5,-1324,122.9)
    return self
end

function cdn:receiveContent(list)
    local demanded={}
    for _,v in pairs(list)do
        if fileExists(v[1])then
            local file=fileOpen(v[1],true)
            if(file)then
                if(md5(fileRead(file,fileGetSize(file)))~=v[2])then
                    self.m_Max=self.m_Max+1
                    demanded[self.m_Max]=v[1]
                end
                fileClose(file)
            end
        else
            self.m_Max=self.m_Max+1
            demanded[self.m_Max]=v[1]
        end
    end
    if self.m_Max>0 then
        self.m_Content=demanded
        addEventHandler("onClientRender",root,self.m_fRender)
        triggerServerEvent("cdn:requireFiles",lp,self.m_Content)
    else
        self:setReady()
    end
end

function cdn:receiveFile(data,path,counter)
    local file=fileCreate(path)
    if(file)then
        fileWrite(file,data)
        fileClose(file)
        self.m_Counter=counter
        if(self.m_Counter==self.m_Max)then
            self:setReady()
        else
            triggerServerEvent("cdn:requestNextFile",lp,lp)
        end
    end
end

function cdn:setReady()
    triggerEvent("cdn:onClientReady",root,resourceRoot)
    removeEventHandler("onClientRender",root,self.m_fRender)
    self.m_Ready=true
	if(downloadMusicState~=false)then
		downloadMusic:stop()
	end
	unbindKey("m","down",downloadMusic_Func)
	downloadMusicState=false
end

function cdn:getReady()
    return self.m_Ready
end

local ScreenSource=dxCreateScreenSource(GLOBALscreenX,GLOBALscreenY)
local blurStrength=7
local blurShader=dxCreateShader(":"..settings.general.scriptname.."/files/SHADERS/Blur.fx")
function cdn:renderMain(delta)
	if(self.m_Counter>0)then
		showChat(false)
		
		dxUpdateScreenSource(ScreenSource)
		dxSetShaderValue(blurShader,"ScreenSource",ScreenSource)
		dxSetShaderValue(blurShader,"BlurStrength",blurStrength)
		dxSetShaderValue(blurShader,"UVSize",GLOBALscreenX,GLOBALscreenY)
		dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,blurShader)
		dxDrawText("Downloading files...",960*Gsx,480*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),2.0*Gsx,"bankgothic","center","center",_,_,false,_,_)
		if(downloadMusicState~=false)then
			dxDrawText("Press 'm' to stop the music",950*Gsx,1300*Gsy,984*Gsx,496*Gsy,tocolor(255,255,255,255),1.2*Gsx,"bankgothic","center","center",_,_,false,_,_)
		end
		
		setElementData(lp,"lobby","download...")
		
		dxDrawRectangle(self.m_ScreenX/2-self.m_Width/2, self.m_ScreenY-(self.m_Heigth*3)-160,self.m_Width,self.m_Heigth,tocolor(120,120,120,200),true)
		local width=(self.m_Counter*(self.m_Width--[[-10]]))/self.m_Max
		dxDrawRectangle(self.m_ScreenX/2-self.m_Width/2,self.m_ScreenY-(self.m_Heigth*3)-160,width,self.m_Heigth,tocolor(60,60,60,200),true)
	end
end

addEventHandler("onClientResourceStart",resourceRoot,function()
    _G["CDN"]=cdn.new()
end)