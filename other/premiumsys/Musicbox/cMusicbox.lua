--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local isSound=false
local subTrackOnSoundDown=0.1
local subTrackOnSoundUp=0.1

addEvent("open:musicboxpanel",true)
addEventHandler("open:musicboxpanel",root,function()
	if(isLoggedin())then
        if(getElementData(lp,"ElementClicked")==false)then
            if(tonumber(getElementData(lp,"PremiumLVL"))>=1 or tonumber(getElementData(lp,"AdminLVL"))>=2)then
                setWindowData("add","cursor_clicked",false)
                dgsSetInputMode("no_binds")
                dgsSetInputMode("no_binds_when_editing")
                CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-340/2,500,340,settings.general.servername.." - Ghettoblaster",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
                dgsWindowSetSizable(CoD.Window[1],false)
				dgsWindowSetMovable(CoD.Window[1],false)
				CoD.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				
				dgsCreateLabel(220,15,100,20,"Music uploader to streaming: kiwi6.com",false,CoD.Window[1])
				dgsCreateLabel(220,95,100,20,"Custom URL:",false,CoD.Window[1])
				CoD.Edit[1]=dgsCreateEdit(220,110,270,40,"",false,CoD.Window[1])
				CoD.Button[2]=dgsCreateButton(220,160,270,40,"play",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[3]=dgsCreateButton(220,210,270,40,"stop",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[4]=dgsCreateButton(360,260,130,40,"vol +",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				CoD.Button[5]=dgsCreateButton(220,260,130,40,"vol -",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)

                CoD.Gridlist[1]=dgsCreateGridList(10,10,200,295,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
                streamGridlist=dgsGridListAddColumn(CoD.Gridlist[1]," Streams",0.9)
                
                for _,v in ipairs(globalTables["StreamNames"])do
					local row=dgsGridListAddRow(CoD.Gridlist[1])
					dgsGridListSetItemText(CoD.Gridlist[1],row,streamGridlist,v,false,false)
                end
                
				dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
                
				
				addEventHandler("onDgsMouseClick",CoD.Button[5],
                    function(btn,state)
                        if(btn=="left" and state=="up")then
							if(isSound~=false)then
								local toVol=math.round(getSoundVolume(Ghettoblaster[lp])-subTrackOnSoundDown,2)
								if(toVol>0.0)then
									triggerEvent("draw:infobox",lp,"info","Volume: "..math.floor(toVol*100).."%",8000)
									triggerServerEvent("change:premmusicboxvolume",lp,toVol)
								end
							end
                        end
                    end,
                false)
                addEventHandler("onDgsMouseClick",CoD.Button[4],
                    function(btn,state)
                        if(btn=="left" and state=="up")then
							if(isSound~=false)then
								local toVol=math.round(getSoundVolume(Ghettoblaster[lp])+subTrackOnSoundUp,2)
								if(toVol<=1.0)then
									triggerEvent("draw:infobox",lp,"info","Volume: "..math.floor(toVol*100).."%",8000)
									triggerServerEvent("change:premmusicboxvolume",lp,toVol) 
								end
							end
                        end
                    end,
                false)
                addEventHandler("onDgsMouseClick",CoD.Button[3],
                    function(btn,state)
                        if(btn=="left" and state=="up")then
                            triggerServerEvent("delete:premmusicbox",lp,lp)
							isSound=false
                        end
                    end,
                false)
                addEventHandler("onDgsMouseClick",CoD.Button[2],
                    function(btn,state)
                        if(btn=="left" and state=="down")then
                            local url=dgsGetText(CoD.Edit[1])
							local item=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(CoD.Gridlist[1],dgsGridListGetSelectedItem(CoD.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("create:premmusicbox",lp,globalTables["StreamLinks"][clicked])
									isSound=true
								end
							else
								if(#url>=1)then
									triggerServerEvent("create:premmusicbox",lp,url)
									isSound=true
								end
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
end)


addEvent("stop:premmusic",true)
addEventHandler("stop:premmusic",root,function(player)
	if(isElement(Ghettoblaster[player]))then
		Ghettoblaster[player]:destroy()
	end
end)

addEvent("play:premmusic",true)
addEventHandler("play:premmusic",root,function(player,link)
    local x,y,z=getElementPosition(player)
    if(player:getInterior()==0 and player:getDimension()==0)then
        if(isElement(Ghettoblaster[player]))then
            Ghettoblaster[player]:destroy()
        end
        Ghettoblaster[player]=playSound3D(link,x,y,z)
        attachElements(Ghettoblaster[player],player)
    end
end)


addEvent("change:premmusicboxvolumeC",true)
addEventHandler("change:premmusicboxvolumeC",root,function(vol) 
	if(isElement(Ghettoblaster[source]))then
		setSoundVolume(Ghettoblaster[source],tonumber(vol))
	end
end)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end