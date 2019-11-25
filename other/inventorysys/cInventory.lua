--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local validItemsTable={
["Weed"]=true,
["Burger"]=true,
["Crowbar"]=true
}

local itemTextsTable={
["Weed"]="Weed:\nto sell or use",
["Burger"]="Burger:\nto fill your health",
["Crowbar"]="Crowbar:\nfor breaking up a container"
}

local itemImagesTable={
["Weed"]="Weed.png",
["Burger"]="Burger.png",
["Crowbar"]="Crowbar.png"
}
local standartInventoryTXT="No item selected!"

bindKey("i","down",function()
	if(isLoggedin())then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked",true)
			CoD.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-400/2,500,400,settings.general.servername.." - Inventory",false,tocolor(255,255,255),nil,nil,settings.general.guimaincolor,nil,nil,nil,true)
			dgsWindowSetSizable(CoD.Window[1],false)
			dgsWindowSetMovable(CoD.Window[1],false)
			CoD.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,CoD.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			
			CoD.Gridlist[1]=dgsCreateGridList(10,10,240,355,false,CoD.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			item=dgsGridListAddColumn(CoD.Gridlist[1],"item",0.6)
			amount=dgsGridListAddColumn(CoD.Gridlist[1],"amount",0.2)
			
			CoD.Label[1]=dgsCreateLabel(270,15,100,20,standartInventoryTXT,false,CoD.Window[1])
			
			dgsGridListSetSortEnabled(CoD.Gridlist[1],false)
			
			
			CoD.Button[2]=dgsCreateButton(275,320,200,40,"use item",false,CoD.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
			
			
			addEventHandler("onDgsMouseClick",CoD.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item1=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item1>0)then
							local selectedGrid,_=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							local selectedItem=dgsGridListGetItemText(CoD.Gridlist[1],selectedGrid,item)
							if(selectedItem)then
								if(validItemsTable[selectedItem])then
									dgsSetText(CoD.Label[1],itemTextsTable[selectedItem])
									if(isElement(CoD.Image[1]))then
										CoD.Image[1]:destroy()
									end
									CoD.Image[1]=dgsCreateImage(315,120,120,120,":"..settings.general.scriptname.."/files/IMAGES/Inventory/"..itemImagesTable[selectedItem],false,CoD.Window[1])
								end
							end
						else
							if(isElement(CoD.Image[1]))then
								CoD.Image[1]:destroy()
							end
							dgsSetText(CoD.Label[1],standartInventoryTXT)
						end
					end
				end,
			false)
			addEventHandler("onDgsMouseClick",CoD.Button[2],
				function(btn,state)
					if(btn=="left" and state=="down")then
						local item1=dgsGridListGetSelectedItem(CoD.Gridlist[1])
						if(item1>0)then
							local selectedGrid,_=dgsGridListGetSelectedItem(CoD.Gridlist[1])
							local selectedItem=dgsGridListGetItemText(CoD.Gridlist[1],selectedGrid,item)
							if(selectedItem)then
								if(validItemsTable[selectedItem])then
									triggerServerEvent("use:item",lp,selectedItem)
								end
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
			fillInventoryList()
		end
	end
end)

function fillInventoryList()
	fillWithItems(CoD.Gridlist[1],item,amount)
end
addEvent("refresh:inventory",true)
addEventHandler("refresh:inventory",root,fillInventoryList)

function fillWithItems(grid,itemName,itemCount)
	dgsGridListClear(grid)
	local Weed=syncClientGetElementData("Weed")
	if(Weed>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Weed",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Weed),false,false)
	end
	
	local Burger=syncClientGetElementData("Burger")
	if(Burger>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Burger",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Burger),false,false)
	end
	
	local Crowbar=syncClientGetElementData("Crowbar")
	if(Crowbar>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Crowbar",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Crowbar),false,false)
	end
end







local lsdColorsTable={{255,0,255},{0,255,0},{255,255,255},{255,255,0},{151,255,255},{255,0,0},{255,20,147},{0,250,154},{0,255,255}}
local drugColorsTable={{0,200,0},{0,100,0},{0,220,0},{0,80,0}}
local drugLight

function drawDrugEffects_Func()
	for i=100,350,1 do
		local color,x,y=math.random(1,#drugColorsTable),math.random(3,15),math.random(3,17)
		local posx,posy=math.random(1,GLOBALscreenX-x),math.random(1,GLOBALscreenY-y)
		dxDrawRectangle(posx,posy,x,y,tocolor(drugColorsTable[color][1],drugColorsTable[color][2],drugColorsTable[color][3],math.random(1,160)),false,true)
	end
	
	local x,y,z=getElementPosition(lp)
	setSearchLightStartPosition(drugLight,x,y,z+10)
	setSearchLightEndPosition(drugLight,x,y,z-0.95)
end

addEvent("use:weedeffect",true)
addEventHandler("use:weedeffect",root,function()
	if(not(isTimer(WeedTimer)))then
		local counter=0
		WeedTimer=setTimer(function()
			counter=counter+1
			if(counter==8)then
				local x,y,z=getElementPosition(lp)
				setGameSpeed(0.8)
				drugLight=createSearchLight(x,y,z+20,x,y,z-0.95,0.1,5)
				setElementHealth(lp,getElementHealth(lp)+1)
				addEventHandler("onClientRender",root,drawDrugEffects_Func)
			end
			if(counter==11)then
				setCameraShakeLevel(80)
				if(isElement(WeedSound))then
					WeedSound:destroy()
				end
				WeedSound=playSound(":"..settings.general.scriptname.."/files/SOUNDS/Weedeffects.mp3",true)
				setSoundVolume(WeedSound,syncClientGetElementData("Soundvolume"))
			end
			if(counter>=60)then
				destroyElement(drugLight)
				setCameraShakeLevel(0)
				setGameSpeed(1)
				WeedTimer:destroy()
				if(isElement(WeedSound))then
					WeedSound:destroy()
				end
				removeEventHandler("onClientRender",root,drawDrugEffects_Func)
			end
		end,1000,60)
	end
end)