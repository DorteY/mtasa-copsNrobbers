--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

cRegisterLogin={}
cRegisterLogin. __index=cRegisterLogin

local windowState=false

function teamCounter()
	civilianCounter=0
	policeCounter=0
	groveCounter=0
	ballasCounter=0
	policeCounterMax=65
	groveCounterMax=65
	ballasCounterMax=65
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"team")=="Civilian")then
			civilianCounter=civilianCounter+1
		elseif(getElementData(v,"team")=="Police")then
			policeCounter=policeCounter+1
		elseif(getElementData(v,"team")=="Grove")then
			groveCounter=groveCounter+1
		elseif(getElementData(v,"team")=="Ballas")then
			ballasCounter=ballasCounter+1
		end
	end
	dxDrawRectangle(700*Gsx,165*Gsy,600*Gsx,30*Gsy,tocolor(0,0,0,150),false)
	dxDrawText(civilianCounter,835*Gsx,170*Gsy,100*Gsx,20*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT4,_,_,_,_,false,_,_)
	dxDrawText(policeCounter.." / "..groveCounterMax,1130*Gsx,170*Gsy,100*Gsx,20*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT4,_,_,_,_,false,_,_)
	
	dxDrawRectangle(700*Gsx,525*Gsy,600*Gsx,30*Gsy,tocolor(0,0,0,150),false)
	dxDrawText(ballasCounter.." / "..ballasCounterMax,835*Gsx,530*Gsy,100*Gsx,20*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT4,_,_,_,_,false,_,_)
	dxDrawText(groveCounter.." / "..groveCounterMax,1130*Gsx,530*Gsy,100*Gsx,20*Gsy,tocolor(255,255,255,255),1.20*Gsx,dxFONT4,_,_,_,_,false,_,_)
end

function cRegisterLogin:renderFunc()
	setCameraMatrix(1778.8,-1323.5,123.4,1779.5,-1324,122.9)
	dgsSetInputMode("no_binds")
	dgsSetInputMode("no_binds_when_editing")
	fadeCamera(true)
	
	setWindowData("add","cursor_clicked",false)
	CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-585/2,GLOBALscreenY/2-375/2,585,375,settings.general.servername.." - Login/Register",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
	dgsWindowSetSizable(CoD.Window[1],false)
	dgsWindowSetMovable(CoD.Window[1],false)
	
	CoD.Tabpanel[1]=dgsCreateTabPanel(10,10,565,320,false,CoD.Window[1])
	CoD.Tab[1]=dgsCreateTab("Login",CoD.Tabpanel[1])
	dgsCreateImage(0,10,75,50,":"..settings.general.scriptname.."/files/IMAGES/LogoWhite.png",false,CoD.Tab[1])
	dgsCreateLabel(95,65,100,20,"Username:",false,CoD.Tab[1],_,_,_,_,_,_,"center",_)
	CoD.Edit[1]=dgsCreateEdit(60,80,170,30,lp:getName(),false,CoD.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	dgsSetProperty(CoD.Edit[1],"maxLength",15)
	dgsCreateLabel(95,115,100,20,"Password:",false,CoD.Tab[1],_,_,_,_,_,_,"center",_)
	CoD.Edit[2]=dgsCreateEdit(60,130,170,30,"",false,CoD.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	dgsEditSetMasked(CoD.Edit[2],true)
	dgsCreateLabel(375,3,100,20,"Updates/Changelogs:",false,CoD.Tab[1],_,_,_,_,_,_,"center",_)
	dgsCreateLabel(375,282,100,20,"Legend: +Added -Removed ~Revised #Fixxed",false,CoD.Tab[1],_,_,_,_,_,_,"center",_)
	CoD.Label[55]=dgsCreateLabel(10,332,100,20,"Version: "..settings.general.version,false,CoD.Window[1])
	triggerServerEvent("get:changelogs",lp)
	triggerServerEvent("check:autologin",lp)
	
	CoD.Button[1]=dgsCreateButton(60,210,170,35,"log in",false,CoD.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",CoD.Button[1],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local username=dgsGetText(CoD.Edit[1])or ""
				local passwort=dgsGetText(CoD.Edit[2])or ""
				
				if(username:len()>=3 and username:len()<=15)then
					if(passwort:len()>=4)then
						triggerServerEvent("func:login",lp,username,passwort)
					else
						notificationShow("error","The password must be at least 4 characters!")
					end
				else
					notificationShow("error","Your name must contain minimum 3 and maximum 15 letters/numbers!")
				end
			end
		end,
	false)
	
	
	CoD.Tab[2]=dgsCreateTab("Register",CoD.Tabpanel[1])
	dgsCreateImage(0,10,75,50,":"..settings.general.scriptname.."/files/IMAGES/LogoWhite.png",false,CoD.Tab[2])
	dgsCreateLabel(120,15,100,20,"Username:",false,CoD.Tab[2],_,_,_,_,_,_,"center",_)
	CoD.Edit[3]=dgsCreateEdit(80,30,180,40,lp:getName(),false,CoD.Tab[2],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	dgsSetProperty(CoD.Edit[3],"maxLength",15)
	dgsCreateLabel(350,15,100,20,"E-Mail:",false,CoD.Tab[2],_,_,_,_,_,_,"center",_)
	CoD.Edit[4]=dgsCreateEdit(310,30,180,40,"",false,CoD.Tab[2],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	dgsCreateLabel(120,75,100,20,"Password:",false,CoD.Tab[2],_,_,_,_,_,_,"center",_)
	CoD.Edit[5]=dgsCreateEdit(80,90,180,40,"",false,CoD.Tab[2],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	dgsCreateLabel(350,75,100,20,"Password Repeat:",false,CoD.Tab[2],_,_,_,_,_,_,"center",_)
	CoD.Edit[6]=dgsCreateEdit(310,90,180,40,"",false,CoD.Tab[2],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	dgsEditSetMasked(CoD.Edit[5],true)
	dgsEditSetMasked(CoD.Edit[6],true)
	dgsCreateLabel(120,135,100,20,"recruiter?",false,CoD.Tab[2],_,_,_,_,_,_,"center",_)
	CoD.Edit[7]=dgsCreateEdit(80,150,180,40,"",false,CoD.Tab[2],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
	
	dgsCreateLabel(20,225,100,20,"There are no special characters or color codes allowed! (Just: - _ [ ] .)",false,CoD.Tab[2])
	
	CoD.Button[2]=dgsCreateButton(10,250,545,40,"Create an account",false,CoD.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",CoD.Button[2],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local username=dgsGetText(CoD.Edit[3])or ""
				local email=dgsGetText(CoD.Edit[4])or ""
				local passwort=dgsGetText(CoD.Edit[5])or ""
				local passwort2=dgsGetText(CoD.Edit[6])or ""
				local recruiter=dgsGetText(CoD.Edit[7])or ""
				
				if(username:len()>=3 and username:len()<=15)then
					if(passwort:len()>=4)then
						if passwort==passwort2 then
							if(string.match(email,'^[%w+%.%-_]+@[%w+%.%-_]+%.%a%a+$')==email and email:len()>=7)then
								triggerServerEvent("func:register",lp,username,passwort,email,recruiter)
								windowState=false
							else
								notificationShow("error","Enter a valid email!")
							end
						else
							notificationShow("error","The passwords do not match!")
						end
					else
						notificationShow("error","The password must be at least 4 characters!")
					end
				else
					notificationShow("error","Your name must contain minimum 3 and maximum 15 letters / numbers!")
				end
			end
		end,
	false)
end
addEvent("cdn:onClientReady",true)
addEventHandler("cdn:onClientReady",resourceRoot,function()cRegisterLogin:renderFunc()end)

function cLoginRegisterrenderSelectTeamFunc()
	if(windowState==false)then
		windowState=true
		setCameraMatrix(1778.8,-1323.5,123.4,1779.5,-1324,122.9)
		setWindowData("add","cursor_clicked",false)
		setElementData(lp,"open:selectteamGUI",true)
		setElementData(lp,"lobby","teamselect")
		Civilian=guiCreateStaticImage(700*Gsx,200*Gsy,300*Gsx,300*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Teams/Civilian.png",false)
		Police=guiCreateStaticImage(1000*Gsx,200*Gsy,300*Gsx,300*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Teams/Police.png",false)
		Ballas=guiCreateStaticImage(700*Gsx,560*Gsy,300*Gsx,300*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Teams/Ballas.png",false)
		Grove=guiCreateStaticImage(1000*Gsx,560*Gsy,300*Gsx,300*Gsy,":"..settings.general.scriptname.."/files/IMAGES/Teams/Grove.png",false)
		
		
		
		addEventHandler("onClientGUIClick",Civilian,
			function()
				triggerServerEvent("set:team",lp,"Civilian")
				if(isElement(Grove))then
					Grove:destroy()
				end
				if(isElement(Police))then
					Police:destroy()
				end
				if(isElement(Ballas))then
					Ballas:destroy()
				end
				if(isElement(Civilian))then
					Civilian:destroy()
				end
				showChat(true)
				setElementData(lp,"open:selectteamGUI",false)
				removeEventHandler("onClientRender",root,updateLoginRegisterSelectTeamGUI)
				removeEventHandler("onClientRender",root,teamCounter)
				setWindowData("remove","cursor_clicked",false)
				windowState=false
			end,
		false)
		addEventHandler("onClientGUIClick",Police,
			function()
				if(policeCounter<policeCounterMax)then
					triggerServerEvent("set:team",lp,"Police")
					if(isElement(Grove))then
						Grove:destroy()
					end
					if(isElement(Police))then
						Police:destroy()
					end
					if(isElement(Ballas))then
						Ballas:destroy()
					end
					if(isElement(Civilian))then
						Civilian:destroy()
					end
					showChat(true)
					setElementData(lp,"open:selectteamGUI",false)
					removeEventHandler("onClientRender",root,updateLoginRegisterSelectTeamGUI)
					removeEventHandler("onClientRender",root,teamCounter)
					setWindowData("remove","cursor_clicked",false)
					windowState=false
				else notificationShow("error","This team is already full!")end
			end,
		false)
		addEventHandler("onClientGUIClick",Grove,
			function()
				if(groveCounter<groveCounterMax)then
					triggerServerEvent("set:team",lp,"Grove")
					if(isElement(Grove))then
						Grove:destroy()
					end
					if(isElement(Police))then
						Police:destroy()
					end
					if(isElement(Ballas))then
						Ballas:destroy()
					end
					if(isElement(Civilian))then
						Civilian:destroy()
					end
					showChat(true)
					setElementData(lp,"open:selectteamGUI",false)
					removeEventHandler("onClientRender",root,updateLoginRegisterSelectTeamGUI)
					removeEventHandler("onClientRender",root,teamCounter)
					setWindowData("remove","cursor_clicked",false)
					windowState=false
				else notificationShow("error","This team is already full!")end
			end,
		false)
		addEventHandler("onClientGUIClick",Ballas,
			function()
				if(ballasCounter<ballasCounterMax)then
					triggerServerEvent("set:team",lp,"Ballas")
					if(isElement(Grove))then
						Grove:destroy()
					end
					if(isElement(Police))then
						Police:destroy()
					end
					if(isElement(Ballas))then
						Ballas:destroy()
					end
					if(isElement(Civilian))then
						Civilian:destroy()
					end
					showChat(true)
					setElementData(lp,"open:selectteamGUI",false)
					removeEventHandler("onClientRender",root,updateLoginRegisterSelectTeamGUI)
					removeEventHandler("onClientRender",root,teamCounter)
					setWindowData("remove","cursor_clicked",false)
					windowState=false
				else notificationShow("error","This team is already full!")end
			end,
		false)
		
		addEventHandler("onClientRender",root,teamCounter)
		addEventHandler("onClientRender",root,updateLoginRegisterSelectTeamGUI)
	end
end
addEvent("open:teamselect",true)
addEventHandler("open:teamselect",root,cLoginRegisterrenderSelectTeamFunc)
function updateLoginRegisterSelectTeamGUI()
	if(getElementData(lp,"open:selectteamGUI")==true)then
		if(isMouseInPosition(700*Gsx,200*Gsy,300*Gsx,300*Gsy))then--Civilian
			guiSetAlpha(Civilian,1)
		else
			guiSetAlpha(Civilian,0.70)
		end
		if(isMouseInPosition(1000*Gsx,200*Gsy,300*Gsx,300*Gsy))then--Police
			guiSetAlpha(Police,1)
		else
			guiSetAlpha(Police,0.70)
		end
		if(isMouseInPosition(700*Gsx,560*Gsy,300*Gsx,300*Gsy))then--Ballas
			guiSetAlpha(Ballas,1)
		else
			guiSetAlpha(Ballas,0.70)
		end
		if(isMouseInPosition(1000*Gsx,560*Gsy,300*Gsx,300*Gsy))then--Grove
			guiSetAlpha(Grove,1)
		else
			guiSetAlpha(Grove,0.70)
		end
	end
end

addEvent("destroy:login",true)
addEventHandler("destroy:login",root,function()
	if(isElement(CoD.Window[1]))then
		dgsCloseWindow(CoD.Window[1])
	end
	if(GLOBALscreenX<=1680 and GLOBALscreenY<=1050)then
		outputChatBox("You play on a small resolution, some windows can be displayed incorrectly to you not with you.",255,255,255)
	end
end)

addEvent("show:changelogs",true)
addEventHandler("show:changelogs",root,function(tbl)
	CoD.Gridlist[1]=dgsCreateGridList(280,20,275,260,false,CoD.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	local version=dgsGridListAddColumn(CoD.Gridlist[1],"Version",0.25)
	local change=dgsGridListAddColumn(CoD.Gridlist[1],"Change/Update",1.65)
	
	for _,v in ipairs(tbl)do
		local row=dgsGridListAddRow(CoD.Gridlist[1])
		dgsGridListSetItemText(CoD.Gridlist[1],row,version,v[1],false,false)
		dgsGridListSetItemText(CoD.Gridlist[1],row,change,v[2],false,false)
	end
	
	dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
end)