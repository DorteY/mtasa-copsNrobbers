--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

gTime=getRealTime()
gYear=tostring(gTime.year+1900)
gWeekday=gTime.weekday+1
gMonth=tostring(gTime.month+1)
gDay=tostring(gTime.monthday)
gHour=tostring(gTime.hour)
gMinute=tostring(gTime.minute)
gSecond=tostring(gTime.second)

function getElementSpeed(element,unit)
	if(unit==nil)then
		unit=0
	end
	if(isElement(element))then
		local x,y,z=getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit=="1")then
			return(x^2+y^2+z^2)^0.5*100
		else
			return(x^2+y^2+z^2)^0.5*1.91*100
		end
	else
		return false
	end
end
function setElementSpeed(element,unit,speed)
	if(unit==nil)then unit=0 end
	if(speed==nil)then speed=0 end
	speed=tonumber(speed)
	local acSpeed=getElementSpeed(element,unit)
	if(acSpeed~=false)then
		local diff=speed/acSpeed
		local x,y,z=getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
	return false
end

function isLoggedin(player)
	if(not player)then
		player=lp
	end
	if(isElement(player))then
		return tonumber(getElementData(player,"Loggedin"))==1
	end
end

function getAdminLevel(player)
	local alevel=tonumber(getElementData(player,"AdminLVL"))
	if(not alevel or alevel==nil)then
		return 0
	end
	if(isElement(player))then
		return tonumber(alevel)
	end
end
function stringTextWithAllParameters(...)
	local tbl={...}
	return table.concat(tbl," ")
end


function realtime()
	setTime(gTime.hour,gTime.minute)
end
addEventHandler("onResourceStart",resourceRoot,realtime)

function damagePlayer(player,amount,damager,weapon)
	if(isElement(player))then
		local armor=getPedArmor(player)
		local health=getElementHealth(player)
		if(armor>0)then
			if(armor>=amount)then
				setPedArmor(player,armor-amount)
			else
				setPedArmor(player,0)
				amount=math.abs(armor-amount)
				setElementHealth(player,health-amount)
				if(getElementHealth(player)-amount<=0)then
					killPed(player,damager,weapon,3,false)
				end
			end
		else
			if(getElementHealth(player)-amount<=0)then
				killPed(player,damager,weapon,3,false)
			end
			setElementHealth(player,health-amount)
		end
	end
end




--//Infobox
function sortArray(tbl)
	local array = {}
	local size = table.size ( tbl )
	local curBiggest = 0
	local curID = 0
	
	for k = 1, size do
		for i = 1, size do
			if tbl[i] > curBiggest then
				curBiggest = tbl[i]
				curID = i
			end
		end
		array[k] = curBiggest
		tbl[curID] = 0
		curBiggest = 0
	end
	
	return array
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do
		length = length + 1
	end
    return length
end

function table.reverse(t) 
    local reversedTable = {} 
    local itemCount = #t  
    for k, v in ipairs(t) do 
        reversedTable[itemCount + 1 - k] = v  
    end 
    return reversedTable  
end 

function tableMerge(t1, t2)
    for k,v in pairs(t2) do
    	if type(v) == "table" then
    		if type(t1[k] or false) == "table" then
    			tableMerge(t1[k] or {}, t2[k] or {})
    		else
    			t1[k] = v
    		end
    	else
    		t1[k] = v
    	end
    end
    return t1
end

--//Logsys
local LogPath = "LOGS/"
function outputLog(text,logname)
	if(not(logname))then logname = "allround" end
	
	logname = logname..".log"
	log = getLog(LogPath..logname)
	filesize = fileGetSize(log)
	fileSetPos(log,filesize)
	fileWrite(log,logTimestamp()..": "..text.."\n")
	fileClose(log)
end
function getLog(path)
	if(not(fileExists(path)))then
		fileClose(fileCreate(path))
	end
	return fileOpen(path,false)
end

function logTimestamp()
	if(#gMonth==1)then gMonth = "0"..gMonth end
	if(#gDay==1)then gDay = "0"..gDay end
	if(#gHour==1)then gHour = "0"..gHour end
	if(#gMinute==1)then gMinute = "0"..gMinute end
	if(#gSecond==1)then gSecond = "0"..gSecond end
	
	return "["..gMonth.."."..gDay.."."..gYear.." "..gHour..":"..gMinute..":"..gSecond.."]"
end

--//Timestamp
function timestamp ()
	local timestamp = tostring(gMonth.."."..gDay.."."..gYear..", "..gHour..":"..gMinute)
	return timestamp
end

function timestampDays ( add )
	local regtime = getRealTime()
	local day = regtime.monthday + add
	local year = regtime.year + 1900
	while day > 365 do
		day = day - 365
		year = year + 1
	end
	local month = regtime.month + 1
	local hour = regtime.hour + winterzeit
	if hour == 24 then hour = 0 end
	local minute = regtime.minute
	local timestamp = day.."."..month.."."..year
	return timestamp
end

function getSecTime(duration)
	if(not duration)then
		duration = 0
	end
	local time = getRealTime()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	
	local total = year * 365 * 24 * 60 + day * 24 * 60 + ( hour + duration ) * 60 + minute
	
	return total
end

function getMinTime ()
	return getSecTime ( 0 )
end

function getSecondTime ( duration )
	local time = getRealTime ()
	local year = time.year
	local day = time.yearday
	local hour = time.hour
	local minute = time.minute
	local seconds = time.second
	
	local total=0
	total=year*365*24*60*60
	total=total+day*24*60*60
	total=total+hour*60*60
	total=total+minute*60
	total=total+seconds+duration
	return total
end

function getTBanSecTime(duration)
	return getSecTime(duration)
end