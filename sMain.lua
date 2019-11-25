--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

timeTillDrogentruckDisappears=20*60*1000

addEventHandler("onPlayerLogin",root,function()
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT AdminLVL FROM ?? WHERE ??=? AND ??=?","USERDATA","Serial",getPlayerSerial(source),"Username",getPlayerName(source)),-1)
	if(result and result[1])then
		for i=1,#result do
			local alevel=tonumber(result[i]["AdminLVL"])
			if(alevel>=4)then
				return true
			else
				cancelEvent(true)
			end
		end
	end
end)

function dontHoldWeapon()
	source:setWeaponSlot(0)
end

function giveVehicleSpecialUpgrade(veh)
	local vehmodel=getElementModel(veh)
	local thisveh=getOriginalHandling(vehmodel)
	
	local sportmotor=syncGetElementData(veh,"customengine")
	if(sportmotor and sportmotor>=1)then
		setVehicleHandling(veh,"maxVelocity",thisveh["maxVelocity"]+30/3*sportmotor)
		setVehicleHandling(veh,"engineAcceleration",thisveh["engineAcceleration"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*sportmotor))
		setVehicleHandling(veh,"engineInertia",thisveh["engineInertia"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*sportmotor))
	end
	
	local fahrtyp=syncGetElementData(veh,"customdrivetyp")
	if(fahrtyp)then
		setVehicleHandling(veh,"driveType",fahrtyp)
	end
	
	local amored=syncGetElementData(veh,"veharmor")
	if(amored and amored==1)then
		veh:setHealth(1500)
	elseif(amored and amored==2)then
		veh:setHealth(1700)
	elseif(amored and amored==3)then
		veh:setHealth(1900)
	end
end

--//T-Ban System
function timebanPlayer(pname,time,admin,reason)
	local player=findPlayerByName(pname)
	
	if(pname)then
		local sec=getTBanSecTime(time)
		local serial=dbPoll(_dbQuery(MySQL.handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","USERDATA","Username",pname),-1)[1]["Serial"]
		
		MySQL.handler:exec("INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","BANS","Username","Admin","Grund","Serial","Time",pname,admin,reason,serial,sec)
		outputChatBox("Player "..pname.." has been banned by "..admin.." for "..time.." hours! (Reason: "..tostring(reason)..")",root,255,0,0)
		
		if(isElement(player))then
			kickPlayer(player,"You was banned for "..time..".hours by "..admin.."! (Reason: "..reason..")")
		end
		return true
	end
	return false
end


function createNewsShow(typ,htext,text,time)
	for _,v in ipairs(getElementsByType("player"))do
		triggerClientEvent(v,"show:newsbox",v,typ,htext,text,time)
	end
end


function givePlayerSelfMoney(player,typ,amount)
	--if(player==client)then
		if(isLoggedin(player))then
			local amount=tonumber(amount)
			if(amount)then
				if(typ=="money")then
					if(isElement(player))then
						syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+amount)
					end
				elseif(typ=="bankmoney")then
					if(isElement(player))then
						syncSetElementData(player,"Bankmoney",tonumber(syncGetElementData(player,"Bankmoney"))+amount)
					end
				end
			end
		end
	--end
end
function takePlayerSelfMoney(player,typ,amount)
	--if(player==client)then
		if(isLoggedin(player))then
			local amount=tonumber(amount)
			if(amount)then
				if(typ=="money")then
					if(isElement(player))then
						syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-amount)
					end
				elseif(typ=="bankmoney")then
					if(isElement(player))then
						syncSetElementData(player,"Bankmoney",tonumber(syncGetElementData(player,"Bankmoney"))-amount)
					end
				end
			end
		end
	--end
end
function getPlayerSelfMoney(player,typ,amount)
	--if(player==client)then
		if(isLoggedin(player))then
			local amount=tonumber(amount)
			if(typ=="money")then
				return tonumber(syncGetElementData(player,"Money"))
			elseif(typ=="bankmoney")then
				return tonumber(syncGetElementData(player,"Bankmoney"))
			end
		end
	--end
end


function givePlayerWantedLevel(player,amount)
	--if(player==client)then
		if(isLoggedin(player))then
			local amount=tonumber(amount)
			if(amount)then
				setElementData(player,"Wanteds",tonumber(getElementData(player,"Wanteds"))+amount)
				if(tonumber(getElementData(player,"Wanteds"))>6)then
					setElementData(player,"Wanteds",tonumber(6))
				end
			end
		end
	--end
end

function givePlayerEXP(player,amount)
	if(isLoggedin(player))then
		local amount=tonumber(amount)
		if(amount)then
			if(getElementData(player,"team")~="Civilian")then
				if(getElementData(player,"team")=="Ballas")then
					syncSetElementData(player,"EXPBallas",tonumber(syncGetElementData(player,"EXPBallas"))+amount)
				elseif(getElementData(player,"team")=="Grove")then
					syncSetElementData(player,"EXPGrove",tonumber(syncGetElementData(player,"EXPGrove"))+amount)
				elseif(getElementData(player,"team")=="Police")then
					syncSetElementData(player,"EXPPolice",tonumber(syncGetElementData(player,"EXPPolice"))+amount)
				end
				uLevel(player)
			end
		end
	end
end


function kickHighPingPlayers_Func()
	for _,v in ipairs(getElementsByType("player"))do
		if(getPlayerPing(v)>=650)then
			kickPlayer(v,"Server","Ping over 650!")
		end
	end
end
setTimer(kickHighPingPlayers_Func,10000,0)


function fadeElementInterior(player,x,y,z,rot,int,dim,frozen)
	if(player and isElement(player)and getElementType(player)=="player")then
		if(getElementData(player,"intchange")==false)then
			setElementData(player,"intchange",true)
			triggerClientEvent(player,"createLoadscreen",player)
			
			if(frozen==true)then
				player:setFrozen(true)
				setTimer(setElementFrozen,3200,1,player,false)
			end
			
			setTimer(function()
				if(x)and(y)and(z)and(int)and(dim)and(rot)then
					player:setPosition(x,y,z)
					player:setInterior(int)
					player:setDimension(dim)
					player:setRotation(0,0,rot)
					setElementData(player,"intchange",false)
				end
			end,3000,1)
		end
	end
end

function reloadWeapon_Func()
	reloadPedWeapon(client)
end
addEvent("reload:weapon", true)
addEventHandler("reload:weapon",resourceRoot,reloadWeapon_Func)


Vehicles={}