--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEventHandler("onClientResourceStart",root,function()
	for _,v in pairs(getElementsByType("object"))do
		if(getElementModel(v)==2942)then
			local x,y,z=getElementPosition(v)
			ATMmarker=createMarker(x,y,z,"corona",1,0,0,0,0)
			
			addEventHandler("onClientMarkerHit",ATMmarker,function(player,dim)
				if(player==lp and dim)then
					openAtmUI_Func(lp)
				end
			end)
			
		end
	end
end)

function openAtmUI_Func()
	if(isLoggedin(lp))then
		if(not lp:isInVehicle())then
			local x,y,z=getElementPosition(lp)
			local location=getZoneName(x,y,z,true)
			
			setWindowData("add","cursor_clicked",true)
			guiSetInputMode("no_binds")
			guiSetInputMode("no_binds_when_editing")
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-350/2,GLOBALscreenY/2-320/2,350,320,settings.general.servername.." - ATM - "..location,false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(324,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Tabpanel[1]=dgsCreateTabPanel(10,10,325,270,false,CoD.Window[1])
			CoD.Tab[1]=dgsCreateTab("deposit",CoD.Tabpanel[1])
			CoD.Label[1]=dgsCreateLabel(60,5,200,20,"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")),false,CoD.Tab[1],_,_,_,_,_,_,"center",_)
			CoD.Edit[1]=dgsCreateEdit(15,125,295,45,"",false,CoD.Tab[1])
			CoD.Button[2]=dgsCreateButton(15,190,295,45,"pay in",false,CoD.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Tab[2]=dgsCreateTab("withdraw",CoD.Tabpanel[1])
			CoD.Label[2]=dgsCreateLabel(60,5,200,20,"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")),false,CoD.Tab[2],_,_,_,_,_,_,"center",_)
			CoD.Edit[2]=dgsCreateEdit(15,125,295,45,"",false,CoD.Tab[2])
			CoD.Button[3]=dgsCreateButton(15,190,295,45,"pay out",false,CoD.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",CoD.Button[3],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local money=dgsGetText(CoD.Edit[2])
						if(money~="")then
							triggerServerEvent("transfer:money",lp,money,"pay:outATM")
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local money=dgsGetText(CoD.Edit[1])
						if(money~="")then
							triggerServerEvent("transfer:money",lp,money,"pay:inATM")
						end
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
end

addEvent("refresh:atm",true)
addEventHandler("refresh:atm",root,function()
	dgsSetText(CoD.Label[1],"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")))
	dgsSetText(CoD.Label[2],"Bankbalance: $"..tonumber(syncClientGetElementData("Bankmoney")))
end)