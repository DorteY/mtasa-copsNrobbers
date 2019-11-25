--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

bindKey("f5","down",function()
	if(isLoggedin())then
        if(getElementData(lp,"ElementClicked")==false)then
            if(tonumber(getElementData(lp,"PremiumLVL"))>=1 or tonumber(getElementData(lp,"AdminLVL"))>=2)then
                setWindowData("add","cursor_clicked",true)
                dgsSetInputMode("no_binds")
                dgsSetInputMode("no_binds_when_editing")
                CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-240/2,400,240,settings.general.servername.." - Premiumpanel",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
                dgsWindowSetSizable(CoD.Window[1],false)
                dgsWindowSetMovable(CoD.Window[1],false)
                CoD.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
                
				CoD.Image[1]=dgsCreateImage(5,5,25,25,":"..settings.general.scriptname.."/files/IMAGES/Premium.png",false,CoD.Window[1])
				CoD.Button[2]=dgsCreateButton(15,40,180,40,"Musicbox",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[3]=dgsCreateButton(205,40,180,40,"Heal yourself (health & armor)\n$"..settings.premiumsys.healprice,false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",CoD.Button[3],
                    function(btn,state)
                        if(btn=="left" and state=="down")then
							triggerServerEvent("premium:heal",lp)
                        end
                    end,
                false)
				addEventHandler("onDgsMouseClick",CoD.Button[2],
                    function(btn,state)
                        if(btn=="left" and state=="down")then
                            dgsCloseWindow(CoD.Window[1])
							setWindowData("remove","cursor_clicked",false)
							triggerEvent("open:musicboxpanel",lp)
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
end)