--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local function buyFoodBurgershot_Func(player)
	if(getElementInterior(player)==10 and getElementDimension(player)==50)then
		triggerClientEvent(player,"open:burgershotUI",player)
	elseif(getElementInterior(player)==10 and getElementDimension(player)==51)then
		triggerClientEvent(player,"open:burgershotUI",player)
	end
end

local buyFoodBurgershot=createCmarker(376.5,-67.4,1001.5,10,50,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Shop.png",nil,0.9,false,buyFoodBurgershot_Func)
local buyFoodBurgershot=createCmarker(376.5,-67.4,1001.5,10,51,":"..settings.general.scriptname.."/files/IMAGES/cMarker/Shop.png",nil,0.9,false,buyFoodBurgershot_Func)