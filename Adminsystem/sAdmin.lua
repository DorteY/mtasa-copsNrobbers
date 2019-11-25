--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function executeAdminServerCMD_func(cmd,arguments)
	executeCommandHandler(cmd,client,arguments)
end
addEvent("executeAdminServerCMD",true)
addEventHandler("executeAdminServerCMD",root,executeAdminServerCMD_func)

function LakeZ_Saveuserdata_Func(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=4)then
			for _,v in ipairs(getElementsByType("player"))do
				sRegisterLogin:savePlayerData(v)
			end
		end
	end
end
addEvent("save:userdata",true)
addEventHandler("save:userdata",root,LakeZ_Saveuserdata_Func)
addCommandHandler("sud",LakeZ_Saveuserdata_Func)

function sendMSGForAdmins(text,r,g,b)
	if(not r)then
		r,g,b=255,255,255
	end
	for _,v in ipairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
				outputChatBox(text,v,r,g,b)
			end
		end
	end
end

function clearchat_Func(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			for i=1,250 do
				outputChatBox(" ")
			end
			clearChatBox(root)
			createNewsShow("Red","Admin news",getPlayerName(player).." has cleared the chat!",10000)
		else
			notificationShow(player,"error","You are not a Trial-Supporter!")
		end
	end
end
addCommandHandler("cc",clearchat_Func)
addCommandHandler("clearchat",clearchat_Func)

local function rBan_Func(player,cmd,kplayer,...)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=3 and(not client or client==player))then
		if(kplayer)then
			local reason=table.concat({...}, " ")
			local target=getPlayerFromName(kplayer)
			local serial=getPlayerSerial(target)
			if(#reason>=3)then
				if(not target)then
					if(kplayer)then
						local serial=dbPoll(_dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","USERDATA","Username",kplayer),-1)[1]["Serial"]
						outputChatBox("The player was banned. (offline)!",player,200,0,0)
						dbExec (handler, "INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","userbans","Username","Admin","Grund","Serial",kplayer,getPlayerName(player),reason,serial)
						outputLog(getPlayerName(player).." has "..kplayer.." banned permanently! Reason: "..tostring(reason).." (offline!)","Adminsystem")
						sendDiscordMessage(4,getPlayerName(player).." has "..kplayer.." banned permanently! Reason: "..tostring(reason).." (offline!)")
					else
						notificationShow(player,"error","The player does not exist!")
					end
				else
					if(getAdminLevel(player)>getAdminLevel(target))then
						notificationShow(player,"error","The player has no lower admin rank than you!")
						return
					end
					outputChatBox(getPlayerName(target).." has been banned from the server by "..getPlayerName(player).." permanently (Reason: "..tostring(reason)..")",root,255,0,0)
					sendDiscordMessage(4,getPlayerName(player).." has "..kplayer.." banned permanently! Reason: "..tostring(reason))
					dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","userbans","Username","Admin","Grund","Serial",kplayer,getPlayerName(player),reason,serial)
					kickPlayer(target,player,tostring(reason).." (banned!)")
					outputLog(getPlayerName(player).." has "..kplayer.." banned permanently! Reason: "..tostring(reason),"Adminsystem")
				end
			else
				notificationShow(player,"error","Enter a reason with 3 characters or higher!")
			end
		else
			notificationShow(player,"error","Use: /rban NAME REASON")
		end	
	else
		notificationShow(player,"error","You are not a Moderator!")
	end	
end
addCommandHandler("rban",rBan_Func)
local function UnbanDB_Func(qh,player,kplayer) 
	local result=dbPoll(qh,0)
	if(result and result[1])then
		local name=result[1]["Username"]
		dbExec(handler,"DELETE FROM userbans WHERE Username LIKE ?",name)
		outputChatBox(getPlayerName(player).." has "..kplayer.." unbanned!",root,200,0,0)
		outputLog("Staff "..getPlayerName(player).." has "..kplayer.." unbanned!","Adminsystem")
	end
end
function Unban_Func(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=4)then
			_dbQuery(UnbanDB_Func,{player,kplayer},handler,"SELECT ?? FROM ?? WHERE ??=?","Username","userbans","Username",kplayer)
		else
			notificationShow(player,"error","You are not a Administrator!")
		end
	end
end
addCommandHandler("unban",Unban_Func)
local function tBan_Func(player,cmd,kplayer,btime,...)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=2 and(not client or client==player))then
		if(kplayer and btime and tonumber(btime)~=nil)then
			if tonumber(btime)>=1 and tonumber(btime)<=10 then
				local reason=table.concat({...}," ")
				if(reason)then
					if(#reason>=3)then
						local target=findPlayerByName(kplayer)
						if(not isElement(target))then
							local success=timebanPlayer(kplayer,tonumber(btime),getPlayerName(player),reason)			
							if success==false then
								notificationShow(player,"error","Use: /tban NAME TIME REASON")
							end
							return
						end
						local name=getPlayerName(target)
						local savename=name
						local success=timebanPlayer(savename,tonumber(btime),getPlayerName(player),reason)
						if success==false then
							notificationShow(player,"error","Use: /tban NAME TIME REASON")
						else
							outputChatBox("Player "..kplayer.." has been banned by "..getPlayerName(player).."! Reason: "..tostring(reason).." Time: "..btime,root,255,0,0)
						end
					else
						notificationShow(player,"error","Enter a reason with 3 characters or higher!")
					end
				else
					notificationShow(player,"error","Use: /tban NAME TIME REASON")
				end
			end
		else
			notificationShow(player,"error","Use: /tban NAME TIME REASON")
		end
	else
		notificationShow(player,"error","You are not a Supporter!")
	end
end
addCommandHandler("tban",tBan_Func)

local function rKick_Func(player,cmd,kplayer,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=2 and(not client or client==player))then
			if(kplayer)then
				local reason={...}
				local reason=table.concat(reason," ")
				local target=findPlayerByName(kplayer)
				if(#reason>=3)then
					if not isElement(target)then
						notificationShow(player,"error","The player is offline!")
						return
					end
					if(getAdminLevel(player)>getAdminLevel(target))then
						outputChatBox(getPlayerName(target).." has been kicked from the server by "..getPlayerName(player).."! Reason: "..reason,root,255,0,0)
						sendDiscordMessage(4,getPlayerName(target).." has been kicked from the server by "..getPlayerName(player).."! Reason: "..reason)
						takeAllWeapons(target)
						kickPlayer(target,player,tostring(reason))	
					else
						notificationShow(player,"error","The player has no lower admin rank than you!")
					end
				else
					notificationShow(player,"error","Enter a reason with 3 characters or higher!")
				end
			end
		else
			notificationShow(player,"error","You are not a Supporter!")
		end
	end
end
addCommandHandler("rkick",rKick_Func)

function mutePlayer_Func(player,cmd,kplayer,time,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local reason={...}
			local reason=table.concat(reason," ")
			local target=findPlayerByName(kplayer)
			if(#time>=1)then
				if(#reason>=3)then
					if(not isElement(target))then
						notificationShow(player,"error","The player is offline!")
						return false
					end
					
					outputChatBox(getPlayerName(target).." has been muted by "..getPlayerName(player).."! Reason: "..reason.." Time: "..time.."(minutes)",root,255,0,0)
					sendDiscordMessage(4,getPlayerName(target).." has been muted by "..getPlayerName(player).."! Reason: "..reason.." Time: "..time.."(minutes)")
					triggerClientEvent(player,"draw:infobox",root,"success","The player is now muted for ("..time..")minutes!",6000)
					if(tonumber(syncGetElementData(target,"Mutedtime"))>30000)then
						syncSetElementData(target,"Mutedtime",30000)
					else
						syncSetElementData(target,"Mutedtime",tonumber(syncGetElementData(target,"Mutedtime"))+time)
					end
				else
					notificationShow(player,"error","Enter a reason with 3 characters or higher!")
				end
			end
		end
	end
end
addCommandHandler("rmute",mutePlayer_Func)
function unMutePlayer_Func(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local target=findPlayerByName(kplayer)
			if(not isElement(target))then
				notificationShow(player,"error","The player is offline!")
				return false
			end
			if(tonumber(syncGetElementData(target,"Mutedtime"))>=1)then
				outputChatBox(getPlayerName(target).." has been unmuted by "..getPlayerName(player).."!",root,255,0,0)
				sendDiscordMessage(4,getPlayerName(target).." has been unmuted by "..getPlayerName(player).."!")
				syncSetElementData(target,"Mutedtime",tonumber(0))
				triggerClientEvent(player,"draw:infobox",root,"success","The player is now unmuted!",6000)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","The player is not muted!",6000)
			end
		end
	end
end
addCommandHandler("runmute",unMutePlayer_Func)

local function Spec_Func(player,cmd,spec)
	local oldspecposTable={}
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
		local spec=spec and findPlayerByName(spec)or nil
		if(spec==nil)then
			if oldspecposTable[player] then
				setElementInterior(player,oldspecposTable[player][2])
				setElementDimension(player,oldspecposTable[player][1])
				oldspecposTable[player]=nil
			end
			fadeCamera(player,true)
			setCameraTarget(player,player)
			setElementFrozen(player,false)
		elseif(spec)then
			setElementFrozen(player,true)
			local dim2,int2=getElementDimension(player),getElementInterior(player)
			oldspecposTable[player]={dim2,int2}
			local dim,int=getElementDimension(spec),getElementInterior(spec)
			setElementInterior(player,int)
			setElementDimension(player,dim)
			fadeCamera(player,true)
			setCameraTarget(player,spec)
			notificationShow(player,"info","To exit the Spectator mode, type only /spec",10)
			outputLog("The admin "..getPlayerName(player).." has spectatet "..getPlayerName(spec).."","Adminsystem")
		else
			notificationShow(player,"error","Use: /spec NAME")
		end
	end
end
addCommandHandler("spec",Spec_Func)


local function gotoXYZ_Func(player,cmd,x,y,z)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
		setElementPosition(player,tonumber(x),tonumber(y),tonumber(z))
	end
end
addCommandHandler("xyz",gotoXYZ_Func)


local function Adminlist_Func(player)
	if(isLoggedin(player))then
		for _,v in pairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				if(tonumber(syncGetElementData(v,"AdminLvL"))>=1)then
					outputChatBox("The following team members are currently online:",player,0,150,150)
					outputChatBox(""..settings.general.adminlvlColorToHASH[getElementData(v,"AdminLvL")]..""..settings.general.adminlvlnames[getElementData(v,"AdminLvL")].."#FFFFFF, "..getPlayerName(v).."",player,255,255,255,true)
				else
					outputChatBox("currently there are no staff member online!",player,0,150,150)
				end
			end
		end
	end
end
addCommandHandler("staff",Adminlist_Func)

function Chatsys(player,cmd,typ)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=2)then
			if(typ)then
				if(typ=="global")then
					if globalChatState==true then
						globalChatState=false
						outputChatBox("[INFO]: The Global-chat was disabled by "..getPlayerName(player).."!",root,200,0,0)
					else
						globalChatState=true
						outputChatBox("[INFO]: The Global-chat was activated by "..getPlayerName(player).."!",root,200,0,0)
					end
				end
			else notificationShow(player,"error","Enter a typ! (global)")end
		else
			notificationShow(player,"error","You are not a Trial-Supporter!")
		end
	end
end
addCommandHandler("chatsys",Chatsys)

function setAdminLVL_Func(player,cmd,kplayer,amount)
	if(tonumber(syncGetElementData(client,"AdminLvL"))>=5)then
		local target=getPlayerFromName(kplayer)
		if(not isElement(target))then
			notificationShow(player,"error","The player is offline!")
			return false
		end
		syncSetElementData(target,"AdminLvL",tonumber(amount))
		triggerClientEvent(player,"draw:infobox",root,"success","Adminlevel from "..getPlayerName(target).." set to "..amount.."!",6000)
	end
end
addCommandHandler("setadminlvl",setAdminLVL_Func)
function setPremiumLVL_Func(player,cmd,kplayer,amount)
	if(tonumber(syncGetElementData(client,"AdminLvL"))>=5)then
		local target=getPlayerFromName(kplayer)
		if(not isElement(target))then
			notificationShow(player,"error","The player is offline!")
			return false
		end
		syncSetElementData(target,"PremiumLVL",tonumber(syncGetElementData(target,"PremiumLVL"))+tonumber(amount*60))
		triggerClientEvent(player,"draw:infobox",root,"success","PremiumLVL from "..getPlayerName(target).." set to "..amount*60 .."!",6000)
	end
end
addCommandHandler("setpremiumlvl",setPremiumLVL_Func)

function pwChange_Func(player,cmd,target,newPW)
	local newPW=md5(hash("sha512",newPW))
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
		if(newPW and target)then
			dbExec(handler,"UPDATE USERDATA SET ??=? WHERE ??=?","Passwort",newPW,"Username",target)
			outputChatBox("Password changed!",player,0,160,0)
		end
	end
end
addCommandHandler("pwchange",pwChange_Func)






function generateBonuscode_Func(player,cmd,item,amount,typ)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=3)then
		if(item and amount and typ)then
			if(typ=="Normal")then
				if(item~="AdminLvL" or item~="Playingtime" or item~="Level")then
					local code=math.random(100000,999999)
					local result=dbPoll(_dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","BONUSCODES","Code",code),-1)
					if(#result==0)then
						dbExec(handler,"INSERT INTO BONUSCODES (Typ,Code,Item,Amount) VALUES (?,?,?,?)",typ,code,item,amount)
						outputChatBox("Bonuscode: "..code.." "..amount.."x "..item,player,0,200,0)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","This item is not allowed!",7500)
				end
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Enter a Item,Amount and Typ\nExample: Burger 10 Normal",7500)
		end
	end
end
addCommandHandler("createBonuscode",generateBonuscode_Func)

addEvent("use:bonuscode",true)
addEventHandler("use:bonuscode",root,function(typ,code)
	local code=tonumber(code)
	local result=dbPoll(_dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","BONUSCODES","Code",code),-1)
	if(#result>=1)then
		local item=MySQL:getPdata("BONUSCODES","Code",code,"Item")
		local amount=MySQL:getPdata("BONUSCODES","Code",code,"Amount")
		syncSetElementData(client,item,getElementData(client,item)+amount)
		dbExec(handler,"DELETE FROM ?? WHERE ??=? AND ??=?","BONUSCODES","Code",code,"Typ",typ)
		outputChatBox("Bonuscode: "..code.." used! You get: "..amount.."x "..item,client,0,200,0)
	end
end)