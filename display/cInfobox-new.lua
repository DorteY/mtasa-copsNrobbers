--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

Infobox={}

function Infobox.new(...)
    local o=setmetatable({},{__index=Infobox})
    if o.constructor then
        o:constructor(...)
    end
    return o
end

function Infobox:constructor()
    self.m_fDraw=function(...)self:draw(...)end
    self.m_IsDrawing=false
    self.m_Boxs={}
    self.m_Width=325
    self.m_Height=100
    self.m_Height2=25
    self.m_PosX=GLOBALscreenX-5-self.m_Width
    self.m_PosY=300
    self.m_Alpha=255
    self.m_WidthNew=325
    self.m_HeightNew=100
    self.m_PosYNew=325
    addEvent("draw:infobox",true)
    addEventHandler("draw:infobox",root,function(...)self:create(...)end)
end

function Infobox:getProgress(idx)
	return(getTickCount()-self.m_Boxs[idx].startTime)/(self.m_Boxs[idx].endTime-self.m_Boxs[idx].startTime)
end

local sound=nil
function Infobox:create(typ,msg,time,title,color)
	if(typ)then
		if(typ=="error")then
			color=tocolor(200,0,0,alpha)
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="success")then
			color=tocolor(0,200,0,alpha)
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="money")then
			color=tocolor(50,50,50,alpha)
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="info")then
			color=tocolor(0,110,220,alpha)
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="warning")then
			color=tocolor(255,240,60,alpha)
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		end
		sound=playSound(":"..settings.general.scriptname.."/files/SOUNDS/Infobox/"..typ..".mp3")
		setSoundVolume(sound,tonumber(syncClientGetElementData("Soundvolume"))or 0.6)
	end
    local now=getTickCount()
    table.insert(self.m_Boxs,{
        title=title or "Information",
        msg=msg or "",
		color=color or tocolor(255,255,255,alpha),
		typ=typ or "",
        posX=GLOBALscreenX+5,
        posY=self.m_PosY+(self.m_Height*#self.m_Boxs)+(10*#self.m_Boxs),
        posYNew=self.m_PosY+(self.m_Height*#self.m_Boxs)+(20*#self.m_Boxs),
        alpha=0,
        startTime=now,
        endTime=now+750,
        stage=1
    })
    if(not self.m_IsDrawing)then
        self.m_IsDrawing=true
        addEventHandler("onClientRender",root,self.m_fDraw)
    end
end

function Infobox:draw(delta)
    if(#self.m_Boxs==0)then
        self.m_IsDrawing=false
        removeEventHandler("onClientRender",root,self.m_fDraw)
    end
	
    for idx,box in ipairs(self.m_Boxs)do
        if(box.stage==1)then
            local alpha,posX,_=interpolateBetween(box.alpha,box.posX,0,self.m_Alpha,self.m_PosX,0,self:getProgress(idx),"Linear")
            dxDrawRectangle(posX,box.posY,self.m_Width,self.m_Height2,tocolor(0,0,0,200))
            dxDrawRectangle(posX,box.posY+25,self.m_Width,75,tocolor(0,0,0,160))
            dxDrawLine(posX,box.posY,posX+self.m_Width,box.posY,box.color)    
            dxDrawLine(posX,box.posY+25,posX+self.m_Width,box.posY+25,tocolor(0,0,0,alpha))    
            dxDrawLine(posX,box.posY+self.m_Height,posX+self.m_Width,box.posY+self.m_Height,tocolor(0,0,0,alpha))
            dxDrawLine(posX,box.posY,posX,box.posY+self.m_Height,tocolor(0,0,0,alpha))
            dxDrawLine(posX+self.m_Width,box.posY,posX+self.m_Width,box.posY+self.m_Height,tocolor(0,0,0,alpha))
            dxDrawText(box.title,posX,box.posY,posX+self.m_Width,box.posY+25,tocolor(255,255,255,alpha),1,"default-bold","center","center")
            dxDrawText(box.msg,posX,box.posY+25,posX+self.m_Width,box.posY+25+75,tocolor(255,255,255,alpha),1,"default-bold","center","center")
			dxDrawImage(posX+2,box.posY+2,22.5,22.5,":"..settings.general.scriptname.."/files/IMAGES/Infobox/"..(box.typ)..".png",0,0,0,tocolor(255,255,255),false)

            if(getTickCount()>=box.endTime)then
                box.posX=self.m_PosX
                box.alpha=self.m_Alpha
                box.startTime=getTickCount()
                box.endTime=box.startTime+3000
                box.stage=2
            end
        end
        
        if(box.stage==2)then
            dxDrawRectangle(box.posX,box.posY,self.m_Width,self.m_Height2,tocolor(0,0,0,200))
            dxDrawRectangle(box.posX,box.posY+25,self.m_Width,75,tocolor(0,0,0,160))
            dxDrawLine(box.posX,box.posY,box.posX+self.m_Width,box.posY,box.color)    
            dxDrawLine(box.posX,box.posY+25,box.posX+self.m_Width,box.posY+25,tocolor(0,0,0,box.alpha))    
            dxDrawLine(box.posX,box.posY+self.m_Height,box.posX+self.m_Width,box.posY+self.m_Height,tocolor(0,0,0,box.alpha))
            dxDrawLine(box.posX,box.posY,box.posX,box.posY+self.m_Height,tocolor(0,0,0,box.alpha))
            dxDrawLine(box.posX+self.m_Width,box.posY,box.posX+self.m_Width,box.posY+self.m_Height,tocolor(0,0,0,box.alpha))
            dxDrawText(box.title,box.posX,box.posY,box.posX+self.m_Width,box.posY+25,tocolor(255,255,255,box.alpha),1,"default-bold","center","center")
            dxDrawText(box.msg,box.posX,box.posY+25,box.posX+self.m_Width,box.posY+25+75,tocolor(255,255,255,box.alpha),1,"default-bold","center","center")
			dxDrawImage(box.posX+2,box.posY+2,22.5,22.5,":"..settings.general.scriptname.."/files/IMAGES/Infobox/"..(box.typ)..".png",0,0,0,tocolor(255,255,255),false)
			
            if(getTickCount()>=box.endTime)then
                box.startTime=getTickCount()
                box.endTime=box.startTime+750
                box.stage=3
            end
        end
		
        if(box.stage==3)then
            local alpha,posY,_=interpolateBetween(box.alpha,box.posY,0,0,-self.m_Height-5,0,self:getProgress(idx),"Linear")
            dxDrawRectangle(box.posX,posY,self.m_Width,self.m_Height2,tocolor(0,0,0,200))
            dxDrawRectangle(box.posX,posY+25,self.m_Width,75,tocolor(0,0,0,160))
            dxDrawLine(box.posX,posY,box.posX+self.m_Width,posY,box.color)    
            dxDrawLine(box.posX,posY+25,box.posX+self.m_Width,posY+25,tocolor(0,0,0,alpha))    
            dxDrawLine(box.posX,posY+self.m_Height,box.posX+self.m_Width,posY+self.m_Height,tocolor(0,0,0,alpha))
            dxDrawLine(box.posX,posY,box.posX,posY+self.m_Height,tocolor(0,0,0,alpha))
            dxDrawLine(box.posX+self.m_Width,posY,box.posX+self.m_Width,posY+self.m_Height,tocolor(0,0,0,alpha))
            dxDrawText(box.title,box.posX,posY,box.posX+self.m_Width,posY+25,tocolor(255,255,255,alpha),1,"default-bold","center","center")
            dxDrawText(box.msg,box.posX,posY+25,box.posX+self.m_Width,posY+25+75,tocolor(255,255,255,alpha),1,"default-bold","center","center")
			dxDrawImage(box.posX+2,posY+2,22.5,22.5,":"..settings.general.scriptname.."/files/IMAGES/Infobox/"..(box.typ)..".png",0,0,0,tocolor(255,255,255),false)

            if(getTickCount()>=box.endTime)then
                table.remove(self.m_Boxs,idx)
            end
        end
    end
end

addEvent("cdn:onClientReady",true)
addEventHandler("cdn:onClientReady",resourceRoot,function()
	g_InfoBox=Infobox.new()
	function infobox_start_func(...)
		g_InfoBox:create(...)
	end
end)