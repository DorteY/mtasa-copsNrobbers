--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--\\                                                  //

local Superman = {}

-- Static global values
local rootElement = getRootElement()
local thisResource = getThisResource()

local supermanTable={
["DorteY"]=true,
}

-- Resource events
addEvent("superman:start", true)
addEvent("superman:stop", true)
addEvent("superman:checkRight", true)

--
-- Start/stop functions
--

function Superman.Start()
  local self = Superman

  addEventHandler("superman:start", rootElement, self.clientStart)
  addEventHandler("superman:stop", rootElement, self.clientStop)
  addEventHandler("onPlayerVehicleEnter",rootElement,self.enterVehicle)
  addEventHandler("onPlayerJoin",rootElement,self.updateRight)
  addEventHandler("onPlayerLogin",rootElement,self.updateRight)
  addEventHandler("onPlayerLogout",rootElement,self.updateRight)
  addEventHandler("superman:checkRight",rootElement,self.updateRight)

end
addEventHandler("onResourceStart", getResourceRootElement(thisResource), Superman.Start, false)

function Superman.clientStart()
  setElementData(client, "superman:flying", true)
end

function Superman.clientStop()
  setElementData(client, "superman:flying", false)
end

-- Fix for players glitching other players' vehicles by warping into them while superman is active, causing them to flinch into air and get stuck.
function Superman.enterVehicle()
	if getElementData(source,"superman:flying") or getElementData(source,"superman:takingOff") then
		removePedFromVehicle(source)
		local x,y,z = getElementPosition(source)
		setElementPosition(source,x,y,z)
	end
end

function Superman.updateRight()

	if client and source~=client then return end
	
	local isAllowed = false
	
		if supermanTable[getPlayerName(source)] then
			isAllowed=true
		else
			isAllowed=false
		end
	
	triggerClientEvent(source,"superman:updateRight",source,isAllowed)

end