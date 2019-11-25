--//                                                  \\
--||   Project: MTA - Cops 'n' Robbers                ||
--||   Developers: DorteY(Lorenzo)                    ||
--||                                                  ||
--||   Since: 2019 (Lake-Gaming.com)                  ||
--\\                                                  //

function playerClick(btn,state,clickedElement,x,y,z,screenPosX,screenPosY)
	if(isLoggedin(source))then
		if(not source:isDead())then
			if(state=="down" and btn=="left")then
				if(getElementData(source,"ElementClicked")==false)then
					if(clickedElement and isElement(clickedElement))then
						local x,y,z=getElementPosition(source)
						local ox,oy,oz=getElementPosition(clickedElement)
						if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=5)then
							local modelID=getElementModel(clickedElement)
							if(modelID==2332 or modelID==1829)then -- tresor
								if(tonumber(getElementData(clickedElement,"isVault"))~=nil) then
									openVault(source,getElementData(clickedElement,"isVault"))
								end
							elseif(modelID==2942)then
								if isEvil(source)then
									triggerClientEvent(source,"open:atmhack",source)
								else
									notificationShow(source,"error","You are not in a gang!")
								end
							elseif(getElementType(clickedElement)=="player")then
								--if(getPlayerName(clickedElement)==getPlayerName(source))then
									if(tonumber(getElementData(clickedElement,"Wanteds"))>=1)then
										if(isTimer(TazerTimer[clickedElement]))then
											if(isPedInVehicle(source)and getPedOccupiedVehicleSeat(source)==0)then
												local veh=getPedOccupiedVehicle(source)
												for i=1,3 do
													if(getVehicleOccupant(veh,i)==false)then
														if(isTimer(TazerTimer[clickedElement]))then
															killTimer(TazerTimer[clickedElement])
														end
														toggleAllControls(clickedElement,false,true,true) 
														warpPedIntoVehicle(clickedElement,veh,i)
														takeAllWeapons(clickedElement)
														break
													end
												end
											end
										end
									end
								--end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onPlayerClick",root,playerClick)