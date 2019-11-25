--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

addEvent("buy:shopitem",true)
addEventHandler("buy:shopitem",root,function(typ,amount)
	if(typ=="Burger")then
		if(amount:len()>=1)then
			if(getPlayerSelfMoney(client,"money")>=tonumber(amount*settings.shop.price.burger))then
				if(syncGetElementData(client,"Burger")+amount<=50)then
					syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+amount)
					takePlayerSelfMoney(client,"money",amount*settings.shop.price.burger)
				else
					notificationShow(client,"error","You can not own more than 50x Burgers")
				end
			else
				notificationShow(client,"error","You do have not enough money! ($"..amount*settings.shop.price.burger..")")
			end
		end
	end
end)