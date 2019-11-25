--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local updateTimer
local scroll=0
local userCounter=0
local staffCounter=0
plp={}

function refreshScoreboard()
	userCounter=0
	staffCounter=0
	if(isLoggedin(lp))then
		plp={}
		local i=0
		for i,v in ipairs(getElementsByType("player"))do
			local ping=getPlayerPing(v)
			local pname=getPlayerName(v)
			
			if(isLoggedin(v))then
				if(not getElementData(v,"team")or getElementData(v,"team")==nil)then
					team="-"
				else
					team=getElementData(v,"team")
				end
				alevel=tonumber(getElementData(v,"AdminLVL"))
				adminrang=settings.general.adminlvlnames[alevel]
				playingtime=tonumber(getElementData(v,"Playingtime"))
				spielzeit=math.floor(playingtime/60)..":"..(playingtime-math.floor(playingtime/60)*60)
				kills=tonumber(getElementData(v,"Kills"))
				deaths=tonumber(getElementData(v,"Deaths"))
				premium=tonumber(getElementData(v,"PremiumLVL"))
				lobby=getElementData(v,"lobby")
				afk=getElementData(v,"AFK")
			else
				adminrang="-"
				spielzeit="-"
				playingtime="-"
				alevel="-"
				team="-"
				kills="-"
				deaths="-"
				premium="-"
				afk="-"
			end
			
			plp[i]={}
			plp[i].name=pname
			plp[i].adminrang=adminrang
			plp[i].alevel=alevel
			plp[i].spielzeit=spielzeit
			plp[i].playingtime=playingtime
			plp[i].team=team
			plp[i].kills=kills
			plp[i].deaths=deaths
			plp[i].premium=premium
			plp[i].ping=ping
			plp[i].lobby=lobby
			plp[i].afk=afk
			
			if(getElementData(v,"AdminLVL"))then
				if(tonumber(getElementData(v,"AdminLVL"))>=1)then
					staffCounter=staffCounter+1
				else
					userCounter=userCounter+1
				end
			end
			
			i=i+1
			
		end
		table.sort(plp,function(a,b)
			return a.team < b.team
		end)
	end
end

function getPingColor(ping)
	if ping<=50 then
		return 0,200,0
	elseif ping<=150 then
		return 200,200,0
	else
		return 200,0,0
	end
end

function drawScoreboard()
	local rr,gg,bb,aa=10,10,10,160
	if(isLoggedin())then
		if(isPlayerMapVisible(lp)==false)then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"intchange")==false)then
					di=0
					dxDrawImage(GLOBALscreenX/2-680/2+280,GLOBALscreenY/2-400/2-100,140,100,"files/IMAGES/LogoBlack.png")
					
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2,680,30,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+32,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+59,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+86,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+113,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+140,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+167,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+194,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+221,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+248,680,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+275,680,25,tocolor(rr,gg,bb,aa),_)
					
					dxDrawText("name",GLOBALscreenX/2-680/2+40,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("team",GLOBALscreenX/2-680/2+240,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("kills",GLOBALscreenX/2-680/2+360,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("deaths",GLOBALscreenX/2-680/2+430,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("state",GLOBALscreenX/2-680/2+520,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("ping",GLOBALscreenX/2-680/2+620,GLOBALscreenY/2-400/2+4,680,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					
					for i=0+scroll,10+scroll do
						if(plp[i])then
							pingR,pingG,pingB=getPingColor(plp[i].ping)
							team=plp[i].team
							if(team=="Police" or team=="Grove" or team=="Ballas")then
								teamR,teamG,teamB=settings.general.teamColors[team][1],settings.general.teamColors[team][2],settings.general.teamColors[team][3]
							else
								teamR,teamG,teamB=255,255,255
							end
							if(isMouseInPosition(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+(di*27)+32,680,25))then
								dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+(di*27)+32,680,25,tocolor(50,50,50,140),false)
								
								dxDrawRectangle(GLOBALscreenX/2-680/2-230,GLOBALscreenY/2-400/2,220,200,tocolor(0,0,0,160),false)
								dxDrawRectangle(GLOBALscreenX/2-680/2-230,GLOBALscreenY/2-400/2+25,220,2,settings.general.guimaincolor,false)
								dxDrawText("name: "..plp[i].name,GLOBALscreenX/2-680/2-220,GLOBALscreenY/2-400/2+5,680,200,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,true,_,_)
								dxDrawText("play time: "..plp[i].spielzeit,GLOBALscreenX/2-680/2-220,GLOBALscreenY/2-400/2+35,680,200,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,true,_,_)
								dxDrawText("Adminlevel: "..plp[i].adminrang,GLOBALscreenX/2-680/2-220,GLOBALscreenY/2-400/2+55,680,200,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,true,_,_)
							end
							
							if(plp[i].afk~=false)then
								if(plp[i].afk)then
									dxDrawText("[AFK] "..plp[i].name,GLOBALscreenX/2-680/2+25,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
								end
							else
								dxDrawText(plp[i].name,GLOBALscreenX/2-680/2+25,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							end
							dxDrawText(plp[i].team,GLOBALscreenX/2-680/2+240,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(teamR,teamG,teamB,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].kills,GLOBALscreenX/2-680/2+360,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].deaths,GLOBALscreenX/2-680/2+430,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].lobby,GLOBALscreenX/2-680/2+520,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].ping,GLOBALscreenX/2-680/2+620,GLOBALscreenY/2-400/2+35+(di*27),680,400,tocolor(pingR,pingG,pingB,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							
							di=di+1
						end
					end
					
					dxDrawRectangle(GLOBALscreenX/2-680/2,GLOBALscreenY/2-400/2+302,680,30,settings.general.guimaincolor,false)
					uCounter=userCounter
					sCounter=staffCounter
					dxDrawText("Players: "..uCounter.."", GLOBALscreenX/2-680/2+20,GLOBALscreenY/2-400/2+302,680,400,tocolor(0,0,0,255),1.30,dxFONT,"left","top",_,_,false,_,_)
					dxDrawText("Team: "..sCounter.."", GLOBALscreenX/2-680/2+585,GLOBALscreenY/2-400/2+302,680,400,tocolor(0,0,0,255),1.30,dxFONT,"left","top",_,_,false,_,_)
				end
			end
		end
	end
end

function scrollDown()
	if(#getElementsByType("player")-scroll<2)then
		scroll=#getElementsByType("player")
	else
		scroll=scroll+2
	end
end

function scrollUp()
	if(scroll<=2)then
		scroll=0
	else
		scroll=scroll-2
	end
end

bindKey("tab","down",function()
	addEventHandler("onClientRender",root,drawScoreboard)
	refreshScoreboard()
	if(isTimer(updateTimer))then
		killTimer(updateTimer)
	end
	updateTimer=setTimer(refreshScoreboard,1500,0)
	bindKey("mouse_wheel_down","down",scrollDown)
	bindKey("mouse_wheel_up","down",scrollUp)
	toggleControl("next_weapon",false)
	toggleControl("previous_weapon",false)
	toggleControl("fire",false)
end)

bindKey("tab","up",function()
	removeEventHandler("onClientRender",root,drawScoreboard)
	unbindKey("mouse_wheel_down","down",scrollDown)
	unbindKey("mouse_wheel_up","down",scrollUp)
	toggleControl("next_weapon",true)
	toggleControl("previous_weapon",true)
	toggleControl("fire",true)
	di=0
	i=0
end)