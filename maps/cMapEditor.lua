function requestLODsClient()
	triggerServerEvent("requestLODsClient", root)
end
addEventHandler("onClientResourceStart", root, requestLODsClient)

function setLODsClient(lodTbl)
	for i, model in ipairs(lodTbl) do
		engineSetModelLODDistance(model, 300)
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", root, setLODsClient)

function applyBreakableState()
	for k, obj in pairs(getElementsByType("object", root)) do
		local breakable = getElementData(obj, "breakable")
		if breakable then
			setObjectBreakable(obj, breakable == "true")
		end
	end
end
addEventHandler("onClientResourceStart", root, applyBreakableState)

local allDimObj={}
function alldimensionsobject_create()
    local allObject=getElementsByType('alldimensionsobject')
    for theKey,theObject in ipairs(allObject)do
        local object=createObject(getElementData(theObject,"model"),getElementData(theObject,"posX"),getElementData(theObject,"posY"),getElementData(theObject,"posZ"),getElementData(theObject,"rotX"),getElementData(theObject,"rotY"),getElementData(theObject,"rotZ"))
        setElementInterior(object, getElementData(theObject,"interior"))
        setElementDimension(object, getElementData(theObject,"dimension"))
        setObjectScale(object, getElementData(theObject,"scale"))
        setElementAlpha(object, getElementData(theObject,"alpha"))
        if(getElementData(theObject,"doublesided") )then
            setElementDoubleSided ( object,true )
        end

        table.insert(allDimObj, object)
    end
    --alldimensionsobject
end
addEventHandler("onClientResourceStart",root,alldimensionsobject_create)

function alldimensionsobject_recreate()
    allDimObj={}
    alldimensionsobject_create()
end

local lastDIM=0
function onClientDimChange()
    local newDim=getElementDimension(getLocalPlayer())
    if(newDim~=lastDIM)then
       lastDIM=newDim
       for theKey, theObject in ipairs(allDimObj)do
            setElementDimension(theObject,newDim)
       end
    end
end
addEventHandler("onClientRender",root,onClientDimChange)

function reloadMapExtensions()
    applyBreakableState()
    requestLODsClient()
    alldimensionsobject_recreate()
end
addEvent("reloadMapExtensions_event",true)
addEventHandler("reloadMapExtensions_event",root,reloadMapExtensions)