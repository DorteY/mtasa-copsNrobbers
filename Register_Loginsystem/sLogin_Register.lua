--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

sRegisterLogin={
	["inventoryTable"]={
		"Weed","Burger","Crowbar"
	},
	["userdataTable"]={
		"Money","Bankmoney","AdminLVL","PremiumLVL","Playingtime","WeekPlayingtime","Jailtime","Mutedtime","LEVELBallas","LEVELGrove","LEVELPolice","EXPBallas","EXPGrove","EXPPolice","Kills","Deaths","Wanteds","Vehicleslots","Introtask","SpawnX","SpawnY","SpawnZ","SpawnROT"
	},
	["usersettingsTable"]={
		"Hitglocke","Soundvolume","FPSLIMIT","Radar","Nametag","Autologin","Hitglock"
	},
	playerBlipTable={},
	recruiterMoney=10000,
}
sRegisterLogin. __index=sRegisterLogin

addEvent("func:register",true)
addEventHandler("func:register",root,function(username,passwort,email,recruiter)
	if(MySQL.ready~=false)then
		local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","USERDATA","EMail",email),-1)
		if(not result or not result[1])then
			local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","USERDATA","Serial",getPlayerSerial(client)),-1)
			if(not result or not result[1])then
				local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","USERDATA","Username",username),-1)
				if(not result or not result[1])then
					
					if(recruiter and #recruiter>=1)then
						local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","USERDATA","Username",recruiter),-1)
						if(#result==0)then
							notificationShow(client,"error","The specified advertiser does not exist!")
							return false
						else
							if(getPlayerFromName(recruiter))then
								outputChatBox("You become $"..sRegisterLogin.recruiterMoney,recruiter)
								syncSetElementData(recruiter,"Money",tonumber(syncGetElementData(recruiter,"Money"))+sRegisterLogin.recruiterMoney)
							else
								MySQL.handler:exec("UPDATE ?? SET ??=?+? WHERE ??=?","USERDATA","Money",sRegisterLogin.recruiterMoney,"Username",getPlayerName(recruiter))--i don't know if it works
							end
						end
					else
						recruiter="NONE"
					end
					
					for _,v in ipairs(globalTables["notallowedcaracterTable"])do
						if(string.find(username,v,1,true))then
							if(string.lower(username,v,1,true))then
								notificationShow(client,"error","There are no special characters or color codes allowed! (Just: - _ [ ] .)")
								return false
							end
						end
					end
					
					
					setPlayerName(client,username)
					
					local hashLG=md5(hash("sha512",passwort))
					local pname=getPlayerName(client)
					local pip=getPlayerIP(client)
					local serial=getPlayerSerial(client)
					
					local IDcounter=dbPoll(_dbQuery(MySQL.handler,"SELECT ?? FROM ?? WHERE UID=UID","UID","UIDcounter"),-1)[1]["UID"]
					MySQL.handler:exec("UPDATE ?? SET ??=?","UIDcounter","UID",IDcounter+1)

					local RegisterDate=tostring(gMonth.."."..gDay.."."..gYear..", "..gHour..":"..gMinute)
					local LastloginDate=RegisterDate

					playerUID[pname]=IDcounter
					
					MySQL.handler:exec("INSERT INTO ACHIEVMENTS (UID,Username) VALUES (?,?)",IDcounter,pname)
					MySQL.handler:exec("INSERT INTO INVENTORY (UID,Username,Weed,Burger,Crowbar) VALUES (?,?,?,?,?)",IDcounter,pname,'0','0','0')
					MySQL.handler:exec("INSERT INTO USERDATA (UID,Username,Passwort,EMail,Serial,IP,Recruiter,RegisterDate,LastloginDate,Money,Bankmoney,AdminLVL,PremiumLVL,Playingtime,WeekPlayingtime,Jailtime,Mutedtime,LEVELBallas,LEVELGrove,LEVELPolice,EXPBallas,EXPGrove,EXPPolice,Kills,Deaths,Wanteds,Vehicleslots,Introtask,SpawnX,SpawnY,SpawnZ,SpawnROT) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,hashLG,email,serial,pip,recruiter,RegisterDate,LastloginDate,'15000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','4','1','1481.2','-1770.6','18.8','0')
					MySQL.handler:exec("INSERT INTO USERSETTINGS (UID,Username,Hitglocke,Soundvolume,FPSLIMIT,Radar,Nametag,Autologin,Hitglock) VALUES (?,?,?,?,?,?,?,?,?)",IDcounter,pname,'0','1','64','1','1','0','1')
					
					
					sRegisterLogin:setDatas(client)
					client:setFrozen(false)
					triggerClientEvent(client,"destroy:login",client)
					setElementData(client,"ElementClicked",false)
					
				else
					triggerClientEvent(client,"draw:infobox",root,"error","This name is already taken, choose another!",8000)
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Only 1 account per serial is allowed! (Old name: ".. result[1]["Username"] .."",8000)
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The entered e-mail is already taken!",8000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"warning","The serverstart is in progress!",8000)
	end
end)

function sRegisterLogin:setDatas(player)
	local pname=getPlayerName(player)
	local pip=getPlayerIP(player)
	
	setCameraTarget(player,player)
	
	setElementData(player,"AFK",false)
	setElementData(player,"intchange",false)
	setElementData(player,"InTuninggarage",false)
	setElementData(player,"ElementClicked",false)
	setElementData(player,"tazer",false)
	setElementData(player,"Loggedin",1)
	syncSetElementData(player,"Savezone",0)
	toggleAllControls(player,true)
	
	--//Userdata
	for i=1,#sRegisterLogin["inventoryTable"] do
		syncSetElementData(player,sRegisterLogin["inventoryTable"][i],MySQL:getPdata("INVENTORY","UID",playerUID[pname],sRegisterLogin["inventoryTable"][i]),true)
	end
	--//Userdata
	for i=1,#sRegisterLogin["userdataTable"] do
		syncSetElementData(player,sRegisterLogin["userdataTable"][i],MySQL:getPdata("USERDATA","UID",playerUID[pname],sRegisterLogin["userdataTable"][i]))
	end
	--//Usersettings
	for i=1,#sRegisterLogin["usersettingsTable"] do
		syncSetElementData(player,sRegisterLogin["usersettingsTable"][i],MySQL:getPdata("USERSETTINGS","UID",playerUID[pname],sRegisterLogin["usersettingsTable"][i]))
	end
	
	setPlayerPaydayTimer(player)
	loadVehicles(getPlayerName(player))
	checkDailyReward(player)
	
	--//Bindkeys
	bindKey(client,"1","down",changeTazerToDeagle_changeDeagleToTazer)
	bindKey(player,",","down",lockVehicle)
	bindKey(player,"f3","down",openVehpanel)
	bindKey(player,"f9","down",openAchievmentpanel)
	
	bindKey(player,"f10","down","chatbox","adminchat")
	bindKey(player,"y","down","chatbox","t")
	bindKey(player,"z","down","chatbox","global")
	
	
	MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA","IP",pip,"Username",pname)
	MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA","LoggedinDB",1,"Username",pname)
	MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA","LastloginDate",gMonth.."."..gDay.."."..gYear..", "..gHour..":"..gMinute,"Username",pname)
	
	triggerClientEvent(player,"draw:infobox",root,"success","You have successfully loggedin!",8000)
	outputDebugString("The player "..pname.." has loggedin.",0,255,255,255)
	outputLog("The player "..pname.." has loggedin.","Login_Logout")
	
	setElementData(player,"lobby","login")
	
	triggerClientEvent(player,"open:teamselect",player)
	
	if tonumber(syncGetElementData(player,"FPSLIMIT"))<=29 then
		syncSetElementData(player,"FPSLIMIT",tonumber(30))
		setFPSLimit(30)
	end
	
	if(tonumber(syncGetElementData(player,"Playingtime"))<=180)then
		outputChatBox("F1 - for informations/help",player,200,200,200)
	end
	
	
	if(not sRegisterLogin.playerBlipTable[player])then
		sRegisterLogin.playerBlipTable[player]=createBlipAttachedTo(player,0,2,r,g,b,_,500)
	end
end

function sRegisterLogin.setTeam(team)
	if(team)then
		local pname=getPlayerName(client)
		setElementData(client,"team",team)
		
		if(team~="Civilian")then
			rdmSkin=math.random(1,#globalTables[team]["skins"])
			skin=globalTables[team]["skins"][rdmSkin]
			
			x,y,z,rot,int,dim=globalTables[team]["spawns"][1],globalTables[team]["spawns"][2],globalTables[team]["spawns"][3],globalTables[team]["spawns"][4],globalTables[team]["spawns"][5],globalTables[team]["spawns"][6]
		else
			cx,cy,cz,rot=MySQL:getPdata("USERDATA","Username",pname,"SpawnX"),MySQL:getPdata("USERDATA","Username",pname,"SpawnY"),MySQL:getPdata("USERDATA","Username",pname,"SpawnZ"),MySQL:getPdata("USERDATA","Username",pname,"SpawnROT")
		end
		
		if(team=="Civilian")then
			if(sRegisterLogin.playerBlipTable[client])then
				setBlipColor(sRegisterLogin.playerBlipTable[client],200,200,200,255)
			end
			if(isElement(client))then
				spawnPlayer(client,cx,cy,cz,rot,0,0,0)
				setCameraTarget(client,client)
			end
		elseif(team=="Police")then
			if(sRegisterLogin.playerBlipTable[client])then
				setBlipColor(sRegisterLogin.playerBlipTable[client],0,0,200,255)
			end
			if(isElement(client))then
				spawnPlayer(client,x,y,z,rot,skin,int,dim)
				setCameraTarget(client,client)
			end
		elseif(team=="Grove")then
			if(sRegisterLogin.playerBlipTable[client])then
				setBlipColor(sRegisterLogin.playerBlipTable[client],0,200,0,255)
			end
			if(isElement(client))then
				spawnPlayer(client,x,y,z,rot,skin,int,dim)
				setCameraTarget(client,client)
			end
		elseif(team=="Ballas")then
			if(sRegisterLogin.playerBlipTable[client])then
				setBlipColor(sRegisterLogin.playerBlipTable[client],130,0,150,255)
			end
			if(isElement(client))then
				spawnPlayer(client,x,y,z,rot,skin,int,dim)
				setCameraTarget(client,client)
			end
		end
		
		jailCheck_Func(client)
		client:setFrozen(false)
		setElementData(client,"lobby","ingame")
	end
	
	if(getElementData(client,"duty:admin")==true)then
		syncSetElementData(client,"duty:admin",false)
	end
end
addEvent("set:team",true)
addEventHandler("set:team",root,sRegisterLogin.setTeam)

addEvent("func:login",true)
addEventHandler("func:login",root,function(username,passwort)
	if(MySQL.ready~=false)then
	local hashLG=md5(hash("sha512",passwort))
		local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","USERDATA","Username",username,"Passwort",hashLG),-1)
		if(result and result[1])then
			setPlayerName(client,username)
			sRegisterLogin:setDatas(client)
			client:setFrozen(true)
			triggerClientEvent(client,"destroy:login",client)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The username/password combination is not correct or not available!",8000)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"warning","The serverstart is in progress!",8000)
	end
end)

function sRegisterLogin:savePlayerData(player)
	if(isLoggedin(player))then
		local pname=getPlayerName(player)
		
		--//Inventory
		for i=1,#sRegisterLogin["inventoryTable"] do
			MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","INVENTORY",sRegisterLogin["inventoryTable"][i],syncGetElementData(player,sRegisterLogin["inventoryTable"][i]),"UID",playerUID[pname])
		end
		--//Userdata
		for i=1,#sRegisterLogin["userdataTable"] do
			MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA",sRegisterLogin["userdataTable"][i],syncGetElementData(player,sRegisterLogin["userdataTable"][i]),"UID",playerUID[pname])
		end
		--//Usersettings
		for i=1,#sRegisterLogin["usersettingsTable"] do
			MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERSETTINGS",sRegisterLogin["usersettingsTable"][i],syncGetElementData(player,sRegisterLogin["usersettingsTable"][i]),"UID",playerUID[pname])
		end
		
		outputDebugString("The data from "..getPlayerName(player).. " has been saved.",0,255,255,255)
		outputLog("The player "..getPlayerName(player).." has loggedout.","Login_Logout")
		
	end
end

function setPlayerStats_Func()
	setPlayerBlurLevel(source,0)
	setElementData(source,"Loggedin",0)
	setElementData(source,"lobby","connecting")
	
	setPedStat(source,22,500)
	setPedStat(source,69,900)
	setPedStat(source,70,999)
	setPedStat(source,71,999)
	setPedStat(source,72,999)
	setPedStat(source,73,999)
	setPedStat(source,74,999)
	setPedStat(source,75,999)
	setPedStat(source,76,999)
	setPedStat(source,77,999)
	setPedStat(source,78,999)
	setPedStat(source,79,999)
	setPedStat(source,160,999)
	setPedStat(source,229,999)
	setPedStat(source,230,999)
end
addEventHandler("onResourceStart",resourceRoot,setPlayerStats_Func)
addEventHandler("onPlayerJoin",root,setPlayerStats_Func)

function checkDailyReward(player)
	local pname=getPlayerName(player)
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","DAILYREWARD","Username",pname),-1)
	if(result and result[1])then
	else
		local rdm=math.random(1,2)
		if(rdm==1)then
			local rdmMoney=math.random(400,1200)
			outputChatBox("Dailylogin: $"..rdmMoney,player,0,200,0)
			givePlayerSelfMoney(player,"money",rdmMoney)
		elseif(rdm==2)then
			local rdmPremiumMinutes=math.random(20,60)
			outputChatBox("Dailylogin: x"..rdmPremiumMinutes.." premiumminutes",player,0,200,0)
			syncSetElementData(player,"PremiumLVL",tonumber(getElementData(player,"PremiumLVL"))+rdmPremiumMinutes)
		end
		MySQL.handler:exec("INSERT INTO DAILYREWARD (Username) VALUES (?)",pname)
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isLoggedin(source))then
		local pname=getPlayerName(source)
		sRegisterLogin:savePlayerData(source)
		local x,y,z=getElementPosition(source)
		local rx,ry,rz=getElementRotation(source)
		if(x)and(y)and(z)and(rz)then
			if(source:getDimension()==0 and source:getInterior()==0)then
				if(getElementData(source,"team")=="Civilian")then
					MySQL.handler:exec("UPDATE ?? SET ??=?,??=?,??=?,??=? WHERE ??=?","USERDATA","SpawnX",x,"SpawnY",y,"SpawnZ",z,"SpawnROT",rz,"UID",playerUID[pname])
				end
			end
		end
		MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA","LoggedinDB",0,"UID",playerUID[pname])
		if(isTimer(TazerTimer[source]))then
			if(tonumber(getElementData(source,"Wanteds"))>=1)then
				syncSetElementData(source,"Jailtime",tonumber(getElementData(source,"Wanteds"))*8)
				setElementData(source,"Wanteds",tonumber(0))
				jailCheck_Func(source)
			end
		end
	end
	if(sRegisterLogin.playerBlipTable[source] and isElement(sRegisterLogin.playerBlipTable[source]))then
		sRegisterLogin.playerBlipTable[source]:destroy()
	end
end)

addEvent("get:changelogs",true)
addEventHandler("get:changelogs",root,function()
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? ORDER BY SortID","CHANGELOGS"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			table.insert(tbl,{v["ID"],v["Changes"]})
		end
		triggerClientEvent(client,"show:changelogs",client,tbl)
	end
end)

addEvent("check:autologin",true)
addEventHandler("check:autologin",root,function()
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","USERDATA","Serial",getPlayerSerial(client)),-1)
	if(result and result[1])then
		if(MySQL:getPdata("USERDATA","Username",getPlayerName(client),"Serial")==getPlayerSerial(client))then
			if(MySQL:getPdata("USERSETTINGS","Username",getPlayerName(client),"Autologin")==1)then
				setPlayerName(client,getPlayerName(client))
				sRegisterLogin:setDatas(client)
				triggerClientEvent(client,"destroy:login",client)
				setElementFrozen(client,false)
			end
		end
	end
end)


addEvent("set:settings",true)
addEventHandler("set:settings",root,function(typ,amount)
	if(typ)then
		if(typ=="Radar")then
			if(amount>=1 and amount<=4)then
				syncSetElementData(client,"Radar",tonumber(amount))
				notificationShow(client,"success","Radar: "..tonumber(amount))
				triggerClientEvent(client,"refresh:selfmenu",client,"Radar")
			end
		elseif(typ=="Sound")then
			if(amount>=0 and amount<=100)then
				syncSetElementData(client,"Soundvolume",tonumber(amount))
				notificationShow(client,"success","loudness: "..tonumber(amount).."%")
				triggerClientEvent(client,"refresh:selfmenu",client,"Sound")
			end
		elseif(typ=="Hitglock")then
			if(amount>=1 and amount<=4)then
				syncSetElementData(client,"Hitglock",tonumber(amount))
				notificationShow(client,"success","Hitglock: "..tonumber(amount))
				triggerClientEvent(client,"refresh:selfmenu",client,"Hitglock")
			end
		elseif(typ=="FPSLIMIT")then
			if(amount>=30 and amount<=100)then
				syncSetElementData(client,"FPSLIMIT",tonumber(amount))
				notificationShow(client,"success","FPS Limit: "..tonumber(amount))
				triggerClientEvent(client,"refresh:selfmenu",client,"FPSLIMIT")
			end
		elseif(typ=="Autologin")then
			if(amount==0)then
				syncSetElementData(client,"Autologin",tonumber(0))
				notificationShow(client,"success","Autologin deactivated")
				triggerClientEvent(client,"refresh:selfmenu",client,"Autologin")
			elseif(amount==1)then
				syncSetElementData(client,"Autologin",tonumber(1))
				notificationShow(client,"success","Autologin activated")
				triggerClientEvent(client,"refresh:selfmenu",client,"Autologin")
			end
		end
	end
end)