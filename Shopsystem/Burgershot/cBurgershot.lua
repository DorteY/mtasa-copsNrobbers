--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("open:burgershotUI",true)
addEventHandler("open:burgershotUI",root,function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			local BurgerCount=0
			setWindowData("add","cursor_clicked",true)
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-250/2,400,250,settings.general.servername.." - BurgershotUI",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Button[2]=dgsCreateButton(10,10,35,150,"<",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[3]=dgsCreateButton(355,10,35,150,">",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[4]=dgsCreateButton(60,10,35,150,"<<",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			CoD.Button[5]=dgsCreateButton(305,10,35,150,">>",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			dgsCreateImage(150,40,100,100,":"..settings.general.scriptname.."/files/IMAGES/Inventory/Burger.png",false,CoD.Window[1])
			CoD.Label[1]=dgsCreateLabel(195,25,20,20,"0",false,CoD.Window[1],_,_,_,_,_,_,"center",_)
			
			CoD.Button[6]=dgsCreateButton(10,175,380,40,"Buy 0x $0",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",CoD.Button[6],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local amount=dgsGetText(CoD.Label[1])
						triggerServerEvent("buy:shopitem",lp,"Burger",amount)
					end
				end,
			false)
			
			addEventHandler("onDgsMouseClick",CoD.Button[5],
				function(btn,state)
					if(btn=="left" and state=="up")then
						BurgerCount=BurgerCount+2
						if(BurgerCount>=20)then
							BurgerCount=20
						end
						dgsSetText(CoD.Label[1],BurgerCount)
						dgsSetText(CoD.Button[6],"Buy "..BurgerCount.."x $"..BurgerCount*settings.shop.price.burger)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[4],
				function(btn,state)
					if(btn=="left" and state=="up")then
						BurgerCount=BurgerCount-2
						if(BurgerCount<=0)then
							BurgerCount=0
						end
						dgsSetText(CoD.Label[1],BurgerCount)
						dgsSetText(CoD.Button[6],"Buy "..BurgerCount.."x $"..BurgerCount*settings.shop.price.burger)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[3],
				function(btn,state)
					if(btn=="left" and state=="up")then
						BurgerCount=BurgerCount+1
						if(BurgerCount>=20)then
							BurgerCount=20
						end
						dgsSetText(CoD.Label[1],BurgerCount)
						dgsSetText(CoD.Button[6],"Buy "..BurgerCount.."x $"..BurgerCount*settings.shop.price.burger)
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if(btn=="left" and state=="up")then
						BurgerCount=BurgerCount-1
						if(BurgerCount<=0)then
							BurgerCount=0
						end
						dgsSetText(CoD.Label[1],BurgerCount)
						dgsSetText(CoD.Button[6],"Buy "..BurgerCount.."x $"..BurgerCount*settings.shop.price.burger)
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