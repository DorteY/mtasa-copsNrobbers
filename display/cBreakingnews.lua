--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local BreakingNewsState=false

local chatcolor="#ffffff"
local r,g,b,a=255,255,255,255

addEvent("show:newsbox",true)
addEventHandler("show:newsbox",root,function(typ,htext,text,time)
	if(isTimer(NewsShowTimer))then killTimer(NewsShowTimer)end
		BreakingNewsText=text
		BreakingNewsHText=htext
	if(time)then
		if(typ)then
			if(not lp:isDead())then
				if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
					if(typ=="Red")then
						chatcolor="#ff5858"
						r,g,b,a=255,88,88,255
					elseif(typ=="Yellow" )then
						chatcolor="#d2d246"
						r,g,b,a=200,200,50,255
					end
					
					if(BreakingNewsState~=true)then
						addEventHandler("onClientRender",root,drawNewsbox_Func)
					end
					
					BreakingNewsState=true
					
					NewsShowTimer=setTimer(function()
						removeEventHandler("onClientRender",root,drawNewsbox_Func)
						BreakingNewsState=false
					end,time,1)
					
				else
					outputChatBox(chatcolor..htext..": #ffffff"..text,255,255,255,true)
				end
			end
		end
	end
end)


function drawNewsbox_Func()
	if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
		dxDrawRectangle(0*Gsx,0*Gsy,800*Gsx,40*Gsy,tocolor(r,g,b,a),true)
		dxDrawRectangle(185*Gsx,3*Gsy,610*Gsx,33*Gsy,tocolor(255,255,255,255),true)
		dxDrawText(BreakingNewsHText..":",80*Gsx,6*Gsy,100*Gsx,20*Gsy,tocolor(255,255,255,255),1.40*Gsx,dxFONT4,"center",_,_,_,true,_,_)
		dxDrawText(BreakingNewsText,195*Gsx,7*Gsy,300*Gsx,20*Gsy,tocolor(0,0,0,255),1.40*Gsx,dxFONT4,_,_,_,_,true,_,_)
	end
end