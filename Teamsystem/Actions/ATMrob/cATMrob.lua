--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("open:atmhack",true)
addEventHandler("open:atmhack",lp,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-320/2,GLOBALscreenY/2-200/2,320,200,settings.general.servername.." - Rob ATM",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(294,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			dgsCreateLabel(10,10,100,20,"WARNING: An ATM robbery takes 1-2 minutes!",false,CoD.Window[1])
			
			CoD.Button[2]=dgsCreateButton(20,120,280,40,"Start rob ATM",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						dgsCloseWindow(CoD.Window[1])
						setWindowData("remove","cursor_clicked",true)
						triggerServerEvent("hack:atm",lp,lp)
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						dgsCloseWindow(CoD.Window[1])
						setWindowData("remove","cursor_clicked",true)
					end
				end,
			false)
			
		end
	end
end)


addEvent("show:atmrobtimer",true)
addEventHandler("show:atmrobtimer",root,function(time)
	if(isTimer(cATMrobTimer))then
		killTimer(cATMrobTimer)
	end
	timer=time
	
	addEventHandler("onClientRender",root,drawATMrobTimer)
	cATMrobTimer=setTimer(function()
		timer=timer-1
		if(timer==0)then
			removeEventHandler("onClientRender",root,drawATMrobTimer)
			if(isTimer(cATMrobTimer))then killTimer(cATMrobTimer)end
		end
	end,1000,timer)
end)

function drawATMrobTimer()
	if(not lp:isDead())then
		if(getElementData(lp,"ElementClicked")==false and isPlayerMapVisible(lp)==false)then
			dxDrawRectangle(1625*Gsx,595*Gsy,280*Gsx,120*Gsy,settings.general.guimaincolor,false)
			dxDrawRectangle(1645*Gsx,630*Gsy,240*Gsx,2*Gsy,tocolor(255,255,255,255),false)
			dxDrawText("ATM-rob timer",3325*Gsx,600*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
			dxDrawText(timer.." seconds...",3325*Gsx,645*Gsy,200*Gsx,922*Gsy,tocolor(255,255,255,255),1.00*Gsx,dxFONT,"center",_,_,_,false,_,_)
		end
	end
end