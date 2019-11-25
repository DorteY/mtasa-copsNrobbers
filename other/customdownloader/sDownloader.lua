--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo) & Lars             ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local cdn={}

function cdn.new()
	local self=setmetatable({},{__index=cdn})
	
	self.m_Content={}
	self.m_Connections={}
	self:refreshContent()
	
	addEvent("cdn:requireContent",true)
	addEvent("cdn:requireFiles",true)
	addEvent("cdn:requestNextFile",true)
	addEventHandler("cdn:requireContent",root,function()self:sendContentList()end)
	addEventHandler("cdn:requireFiles",root,function(...)self:sendDemandedFiles(...)end)
	addEventHandler("cdn:requestNextFile",root,function(...)self:sendNextFile(...)end)
	return self
end

function cdn:refreshContent()
	local meta=xmlLoadFile("meta.xml")
	if(meta)then
		for _,v in ipairs(xmlNodeGetChildren(meta))do 
			if xmlNodeGetName(v)=="cdn" then
				local path=xmlNodeGetAttribute(v,"src")
				local file=fileOpen(path,true)
				if(file)then
					table.insert(self.m_Content,{path,md5(fileRead(file,fileGetSize(file)))})
					fileClose(file)
				end
			end
		end
		xmlUnloadFile(meta)
	end
end

function cdn:sendContentList()
	triggerClientEvent(client,"cdn:receiveContent",client,self.m_Content)
end

function cdn:sendDemandedFiles(paths)
	self.m_Connections[client]={
		_counter=0,
		_paths=paths,
	}
    self:sendNextFile(client)
end

function cdn:sendNextFile(client)
    local session=self.m_Connections[client]
    if(session)then
        session._counter=session._counter+1
        local file=fileOpen(session._paths[session._counter], true)
        if(file)then
            triggerLatentClientEvent(client,"cdn:receiveFile",1000000,false,client, 
                fileRead(file, fileGetSize(file)), 
                session._paths[session._counter], 
                session._counter
            )
            fileClose(file)
            if(session._counter==#session._paths)then
                self.m_Connections[client]=nil
            end
        end
    end
end

addEventHandler("onResourceStart",resourceRoot,function()
	_G["CDN"]=cdn.new()
end)