--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local DB={
HOST="127.0.0.1",
PORT="3306",
NAME="LakeGaming",
PASS="P0qmr57IEp1lcJ4H",
USER="LakeGaming",
OTHER="autoreconnect=1","share=0",
}

_dbQuery=dbQuery
function dbQuery()
    return false
end

_dbExec=dbExec
function dbExec()
    return false
end

playerUID={}
MySQL={handler=nil,ready=false}
MySQL.__index=MySQL
function MySQL:constructor()
	MySQL.handler=dbConnect("mysql","dbname="..DB.NAME..";host="..DB.HOST..";port="..DB.PORT,DB.USER,DB.PASS,DB.OTHER)
	print("[MYSQL] Opening connection to MySQL database..")
	if(MySQL.handler)then
		print("[MYSQL] Connection to the MySQL database was successfully established!")
		setTimer(function()
			MySQL.ready=true
		end,15*1000,1)
	else
		print("[MYSQL] Failed to connect to MySQL database!")
		getThisResource():stop()
		return nil
	end
	
	--//Player UID system
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT ??,?? FROM ??","UID","Username","USERDATA"),-1)
	for i=1,#result do
		local uid=tonumber(result[i]["UID"])
		local name=result[i]["Username"]
		playerUID[name]=uid
	end
	playerUID["none"]=0
end
addEventHandler("onResourceStart",resourceRoot,function()MySQL:constructor()end,false)
function MySQL:deconstructor()
	if(not MySQL.handler)then
		return nil
	end
	destroyElement(MySQL.handler)
	print("[MYSQL] Closed connection to MySQL database.")
	return nil
end
addEventHandler("onResourceStop",resourceRoot,function()MySQL:deconstructor()end,false)


function MySQL:getPdata(from,where,name,data)
	local sql=_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?",from,where,name)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end

function MySQL:getVdata(owner,slot,data)
	local sql=_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","VEHICLES","owner",owner,"slot",slot)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end
function MySQL:getVVdata(from,where,name,andd,name2,data)
	local sql=_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=? AND ??=?",from,where,name,andd,name2)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end


addEventHandler("onPlayerConnect",root,function(ni,ip,uni,se,ver)
	local result=nil
	local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","BANS","Serial",se),-1)
	local deleteit=false
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["Time"]~=0 and(result[i]["Time"]-getTBanSecTime(0))<=0)then
				deleteit=true
			else
				local admin=tostring(result[i]["Admin"])
				local reason=tostring(result[i]["Grund"])
				local time=math.floor(((result[i]["Time"]-getTBanSecTime(0))/60)*100)/100
				if time>=0 then
					cancelEvent(true,"You were banned by "..admin.."! Reason: "..reason..", Time: "..time)
				else
					cancelEvent(true,"You were banned by "..admin.." permanently! Reason: "..reason)
				end
				return
			end
		end
		if(deleteit)then
			MySQL.handler:exec("DELETE FROM ?? WHERE ??=?","BANS","Serial",se)
		end
	end
	
	if(settings.general.devtime==true)then
		local result=dbPoll(_dbQuery(MySQL.handler,"SELECT * FROM ?? WHERE ??=?","WHITELIST","Serial",se),-1)
		if(result and result[1])then
			return true
		else
			cancelEvent(true,"The Development mode is active!")
		end
	end
end)


--//Whitelist
addCommandHandler("addwhitelist",function(player,cmd,name,serial)
	local accname=getAccountName(getPlayerAccount(player))
	if(isObjectInACLGroup("user."..accname,aclGetGroup("Admin")))then
		if(name)and(serial)then
			MySQL.handler:exec("INSERT INTO WHITELIST (NAME,Serial) VALUES ('"..name.."', '"..serial.."')")
			notificationShow(player,"success","Entry successfull created!")
		else
			outputChatBox("Der korrekte Befehl lautet: /addwhitelist Name Serial",player,255,0,0)
		end
	end
end)

--//Add changelog
addCommandHandler("addchangelog",function(player,cmd,SortID,ID,...)
	if(isLoggedin(player))then
		 if(tonumber(syncGetElementData(player,"AdminLVL"))>=5)then
			if(SortID)and(ID)then
				MySQL.handler:exec("INSERT INTO CHANGELOGS (SortID,ID,Changes) VALUES ('"..SortID.."', '"..ID.."', '"..stringTextWithAllParameters(...).."')")
				notificationShow(player,"success","Changelog v."..ID.." succesfully added!")
				sendDiscordMessage(5,ID.." - "..tostring(gMonth.."."..gDay.."."..gYear).." ```"..stringTextWithAllParameters(...).."```")
			end
		end
	end
end)