--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

local oldFilesTable={
"IMAGES/HospitalBG.png",
}

function deleteOldFiles_Func()
	for i=1,#oldFilesTable do
		if(fileExists(":"..settings.general.scriptname.."/files/"..oldFilesTable[i]))then
			fileDelete(":"..settings.general.scriptname.."/files/"..oldFilesTable[i])
		end
	end
	
	local newFile=fileCreate("Copyright.txt")
	if(newFile)then
		fileWrite(newFile,"LakeGaming | Cops 'n' Robbers | Gamemode - [Selfmade].\n\n\nAll Developers & contributors:\n\nDorteY(Lorenzo) - General gamemode\nLars - Customdownloader\nHade - Helping with dgsUI")
		fileClose(newFile)
	end
end
addEventHandler("onClientPlayerJoin",root,deleteOldFiles_Func)
addEventHandler("onClientResourceStart",root,deleteOldFiles_Func)