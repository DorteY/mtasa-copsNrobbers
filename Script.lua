--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

setFPSLimit(settings.general.serverfps)
local function SetGametyp_Func()
	if(settings.general.devtime==true)then
		setGameType(settings.general.servernameK.." - "..settings.general.version.." - Development")
	else
		setGameType(settings.general.servernameK.." - "..settings.general.version)
	end
end
setTimer(SetGametyp_Func,1000,0)

local function setServerPassword_Func()
	if(settings.general.devtime==true)then
		setServerPassword("fusjfushnfs")
	else
		setServerPassword("")
	end
end
setTimer(setServerPassword_Func,1000,1)

addEventHandler("onResourceStart",resourceRoot,function()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			setElementData(v,"ElementClicked",false)
			setElementData(v,"Loggedin",0)
			setElementData(v,"team",nil)
		end
	end
	MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA","LoggedInDB",0,"LoggedInDB",1)
	
	for i=1,#globalTables["glitches"] do
		setGlitchEnabled(globalTables["glitches"][i],false)
	end
	
	if(not isObjectInACLGroup("resource."..settings.general.scriptname,aclGetGroup("Admin")))then
		outputChatBox("The script starts without ACL rights!",root,255,0,0)
	end
end)

local rdmpw=math.random(100000,999999)
setTimer(function()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	local weekday=time.weekday
	
	if(hour==03 and minute==01)then
		sendDiscordMessage(2,"Server was succesfully restarted! (Version: "..settings.general.version..")")
	elseif(hour==03 and minute==00)then
		if(globalTables["days"][time.weekday+1]=="So")then
			MySQL.handler:exec("UPDATE USERDATA SET WeekPlayingtime='0' WHERE WeekPlayingtime>='1'")
		end
		_dbExec(MySQL.handler,"TRUNCATE TABLE DAILYREWARD")
		for _,v in ipairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				sRegisterLogin:savePlayerData(v)
				setElementData(v,"ElementClicked",false)
				setElementData(v,"Loggedin",0)
				setElementData(v,"team",nil)
			end
		end
		getThisResource():restart()
		setServerPassword("")
		MySQL.handler:exec("UPDATE ?? SET ??=? WHERE ??=?","USERDATA","LoggedInDB",0,"LoggedInDB",1)
	elseif(hour==02 and minute==55)then
		setServerPassword(rdmpw)
		outputChatBox("ATTENTION: Server restart in 5 minutes!",root,220,0,0)
		sendDiscordMessage(2,"Server restart in 5 minutes!")
	elseif(hour==02 and minute==50)then
		outputChatBox("ATTENTION: Server restart in 10 minutes!",root,220,0,0)
		sendDiscordMessage(2,"Server restart in 10 minutes!")
	elseif(hour==02 and minute==45)then
		outputChatBox("ATTENTION: Server restart in 15 minutes!",root,220,0,0)
		sendDiscordMessage(2,"Server restart in 15 minutes!")
	end
end,55000,0)