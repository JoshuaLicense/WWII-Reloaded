function FallOfFrance(iOldPlayer, bCapital, iX, iY, iNewPlayer, iPopulation, bConquest, iGreatWorksPresent, iGreatWorksXferred)
	print("~	Fall of france called!")
	
	if(iX == 13 and iY == 66) then
		print("~	Paris has been captured")
		
		if(iNewPlayer == playerid_GERMANY or iNewPlayer == playerid_ITALY) then
			print("~	Captured by either Gemany or Italy")
			
			local iValue = savedData.GetValue("FranceHasFallen") or 0
			
			if (iValue ~= 1) then
				print("~	First occurence")
				savedData.SetValue("FranceHasFallen", 1)
				--GameEvents.CityCaptureComplete.Remove( FallOfFrance )
				GameEvents.GameDoTurn.Add( DoFallOfFrance )
			end
		end
	end
end

function DoFallOfFrance ( )

	GameEvents.CityCaptureComplete.Remove( FallOfFrance )
	GameEvents.GameDoTurn.Remove( DoFallOfFrance )
	print("~	English units on French soil get a 50% to make it back (or die trying)")
	local pEngland = Players[playerid_ENGLAND]
	
	local EnglishCity = pEngland:GetCapitalCity()
	
	for unit in pEngland:Units() do
		if unit:GetPlot():GetOwner() == playerid_FRANCE then
			if math.random(1, 2) > 1 and EnglishCity then
				print("~		Escaped: " .. unit:GetName());
				unit:SetXY(EnglishCity:GetX(), EnglishCity:GetY())
			else
				print("~		Killed: " .. unit:GetName());
				unit:Kill(false, -1)
			end
		end
	end
	
	print("~	Change French units ownership")
	
	local iVichy = GetPlayerIDFromCivID (VICHY, true)
	local pVichy = Players[iVichy]
	
	local iFrenchColony = GetPlayerIDFromCivID (FRENCH_COLONY, true)
	local pFrenchColony = Players[iFrenchColony]
	
	local pFrance = Players[playerid_FRANCE]
	local pGermany = Players[playerid_GERMANY]
	local pJapan = Players[playerid_JAPAN]
	local pItaly = Players[playerid_ITALY]
	
	for iPlotLoop = 0, Map.GetNumPlots()-1, 1 do
		local plot = Map.GetPlotByIndex(iPlotLoop)
		local x = plot:GetX()
		local y = plot:GetY()
		local ownerID = plot:GetOwner() -- check only owned plot... not water

		if x == 13 and y == 66 then
			-- do nothing
			print("PARIS!")
		elseif (ownerID ~= -1) then 
			local originalOwner = plot:GetOriginalOwner()
			
			-- Reset French captured cities to original owner and restore colonies
			if (originalOwner ~= ownerID) and (originalOwner == iFrenchColony or ownerID == playerid_FRANCE) then

				if plot:IsCity() then
					print("~		Liberate city : " .. city:GetName() )
					local city = plot:GetPlotCity()
					
					Players[originalOwner]:AcquireCity(city, false, true)
				else
					plot:SetOwner(originalOwner, -1)
				end
			-- Nice, Ajaccio region to Italy
			elseif originalOwner == playerid_FRANCE and 
				((x == 16 and y == 61) or 
				(x == 16 and y == 62) or 
				(x == 15 and y == 63)) then
				
				print("(".. x ..",".. y ..") = Plot in Italy occupied territory")
				plot:SetOwner(playerid_ITALY, -1 )
			-- Vichy territory
			elseif originalOwner == playerid_FRANCE and 
				(((x > 11 and y > 59) and (x < 17 and y < 65)) or 
				(x == 11 and y == 63) or 
				(x == 11 and y == 62) or 
				(x == 11 and y == 61) or 
				(x == 11 and y == 60)) then 
				
				print("(".. x ..",".. y ..") = Plot in Vichy territory")
				if plot:IsCity() and ownerID ~= iVichy then
					local city = plot:GetPlotCity()
					
					pVichy:AcquireCity(city, false, true)
					--print("POPULATION:" .. city:GetPopulation())
				else
					plot:SetOwner(iVichy, -1 ) 
				end	
			-- Occupied territory
			elseif originalOwner == playerid_FRANCE and ((x > 6 and y > 59) and (y < 70 and x < 17)) then 
				print("(".. x ..",".. y ..") = Plot in occupied territory")
				
				if plot:IsCity() and ownerID ~= playerid_GERMANY then
					local city = plot:GetPlotCity()
					
					pGermany:AcquireCity(city, false, true)
				else
					plot:SetOwner(playerid_GERMANY, -1 ) 
				end						
			-- Japanese territory
			elseif originalOwner == iFrenchColony and ((x > 74 and y > 36) and (x < 81 and y < 48)) then
				print("(".. x ..",".. y ..") = Plot in Japanese territory")
				
				if plot:IsCity() and ownerID ~= playerid_JAPAN then
					local city = plot:GetPlotCity()
					
					pJapan:AcquireCity(city, false, true)
				else
					plot:SetOwner(playerid_JAPAN, -1 ) 
				end
			end
		end
		
		if plot:IsCity() and originalOwner == playerid_FRANCE and ownerID ~= playerid_FRANCE then
			local city = plot:GetPlotCity()
			
			if city and city:IsResistance() then
				city:ChangeResistanceTurns(-city:GetResistanceTurns())
			end
		end		
	end
	
	local Air = {}
	local Sea = {}
	local Land = {}

	for unit in pFrance:Units() do
		if(unit:GetUnitType() == CONVOY) then 
			unit:Kill(false, -1)
		elseif not unit:IsDead() and not unit:IsFighting() then
			if unit:GetDomainType() == DomainTypes.DOMAIN_AIR then
				table.insert(Air, { Unit = unit, XP = unit:GetExperience() })
			elseif unit:GetDomainType() == DomainTypes.DOMAIN_SEA then
				table.insert(Sea, { Unit = unit, XP = unit:GetExperience() })
			else
				table.insert(Land, { Unit = unit, XP = unit:GetExperience() })
			end
		end
	end
	
	table.sort(Air, function(a,b) return a.XP < b.XP end)
	table.sort(Sea, function(a,b) return a.XP < b.XP end)
	table.sort(Land, function(a,b) return a.XP < b.XP end)

	print("~	Dealing with air units")
	for i, data in ipairs(Air) do
		print("~	".. i .. data.Unit:GetName())
		
		if i > 2 then
			print("~		No more than 2 air units")
			data.Unit:Kill(false, -1)
		elseif i == 1 then
			data.Unit:SetXY(11,48)
		else
			local rand = math.random(1, 10)
			if rand < 2 and EnglishCity then	
				print("~		goes to England")
				data.Unit:SetXY(iEnglandCityX, iEnglandCityY)
			else 
				print("~		goes to Vichy")
				local newUnit = ChangeUnitOwner (data.Unit, iVichy)
				newUnit:SetXY(27, 39) -- VICHY
			end
		end
	end
	
	print("~	Dealing with land units")
	for i, data in ipairs(Land) do
		print("~	".. i .. data.Unit:GetName())
		
		if i > 4 then
			print("~		No more than 4 land units")
			data.Unit:Kill(false, -1)
		elseif i == 1 then
			data.Unit:SetXY(12,72)
		elseif data.Unit:GetUnitType() == FR_LEGION then -- Special treatment for Legion
			print("~		Unit is part of the foreign Legion")
			data.Unit:SetXY(11,48)
		else -- Rest to vichy
			print("~		goes to Vichy")
			local newUnit = ChangeUnitOwner (data.Unit, iVichy)
			newUnit:SetXY(13, 62) -- VICHY
		end
	end
	
	print("~	Dealing with sea units")
	for i, data in ipairs(Sea) do
		print("~	".. i .. data.Unit:GetName())
		
		if i > 5 then
			print("~		No more than 5 sea units")
			data.Unit:Kill(false, -1)
		elseif i == 1 then
			print("~		Leave this one")
		else -- Rest to vichy
			local rand = math.random( 1, 100 )					
			if rand <= 75 then -- 75% chance to follow governement in Vichy
				print("~		goes to Vichy ")
				
				if data.Unit:GetY() < 52 then
					if rand < 85 then -- 15% of not being destroyed
						print("~		but destroyed... rand: <= "..rand )
						data.Unit:Kill(false, -1)
					end
				else 
					local newUnit = ChangeUnitOwner(data.Unit, iVichy)
					newUnit:SetXY(15, 60)
				end
			end
		end
	end
	
	-- Change diplomacy
	local teamGermany = Teams[ pGermany:GetTeam() ]
	local teamItaly = Teams[ pItaly:GetTeam() ]
	local teamFrance = Teams[ pFrance:GetTeam() ]
	
	pVichy:ChangeMinorCivFriendshipWithMajor( playerid_GERMANY, 50 )
	pVichy:ChangeMinorCivFriendshipWithMajor( playerid_ITALY, 50 )
	pVichy:ChangeMinorCivFriendshipWithMajor( playerid_JAPAN, 50 )
	
	-- Change relations before declaring war
	pFrenchColony:ChangeMinorCivFriendshipWithMajor( playerid_FRANCE, -50 )
	pFrenchColony:ChangeMinorCivFriendshipWithMajor( playerid_ENGLAND, -50 )

	MakePeace( playerid_GERMANY, iFrenchColony )
	MakePeace( playerid_ITALY, iFrenchColony )
	
	-- Change relations to make the colonies *friendly*
	pFrenchColony:ChangeMinorCivFriendshipWithMajor( playerid_FRANCE, 50 )
	pFrenchColony:ChangeMinorCivFriendshipWithMajor( playerid_GERMANY, 50 )
	pFrenchColony:ChangeMinorCivFriendshipWithMajor( playerid_JAPAN, 50 )

	if Game.GetActivePlayer() ~= iFrance then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, pFrance:GetName() .. " has fled from Paris with all the gold of France promising to continue the fight from french colonies.", pFrance:GetName() .. " in exile !", -1, -1)
	end
	pFrance:SetGold(pFrance:GetGold() + 5000)

	pGermany:InitUnit(GE_MARDER_I, 13, 66)
	pGermany:InitUnit(GE_MARDER_I, 13, 66)
	pGermany:InitUnit(GE_MARDER_I, 13, 66)
	
	print("Fall of France completed!")
end

function FallOfPoland(iOldPlayer, bCapital, iX, iY, iNewPlayer, iPopulation, bConquest, iGreatWorksPresent, iGreatWorksXferred)
	print("~	Fall of poland called!")
	
	if(iX == 27 and iY == 70) then
		print("~	Warsaw has been captured")
		
		if(iNewPlayer == playerid_GERMANY or iNewPlayer == playerid_USSR) then
			print("~	Captured by either Gemany, USSR or Italy")
			
			local iValue = savedData.GetValue("PolandHasFallen") or 0
			
			if (iValue ~= 1) then
				print("~	First occurence")
				savedData.SetValue("PolandHasFallen", 1)
				GameEvents.CityCaptureComplete.Remove( FallOfPoland )
				
				local pUSSR = Players[playerid_USSR]
				local pGermany = Players[playerid_GERMANY]
				
				local iPoland = GetPlayerIDFromCivID (POLAND, true)
				local pPoland = Players[iPoland]

				for unit in pPoland:Units() do
					if not unit:IsDead() and not unit:IsFighting() then
						unit:Kill(false, -1)
					end
				end

				for iPlotLoop = 0, Map.GetNumPlots()-1, 1 do
					local plot = Map.GetPlotByIndex(iPlotLoop)
					local x = plot:GetX()
					local y = plot:GetY()
					local ownerID = plot:GetOwner() -- check only owned plot... not water
					
					if (ownerID ~= -1) then 
						local originalOwner = plot:GetOriginalOwner()

						-- Reset Polish captured cities to original owner
						if (originalOwner ~= ownerID and ownerID == iPoland) then

							if plot:IsCity() then
								print("~		Liberate city : " .. city:GetName() )
								local city = plot:GetPlotCity()
								
								Players[originalOwner]:AcquireCity(city, false, true)
							else
								print("~		Liberate plot : (" .. x ..", " .. y .. ")")
								plot:SetOwner(originalOwner, -1)
							end

						-- USSR territory
						elseif originalOwner == iPoland and (x > 27 and x < 31) then 
							
							print("(".. x ..",".. y ..") = Plot in USSR territory")
							if plot:IsCity() and ownerID ~= playerid_USSR then
								local city = plot:GetPlotCity()
								
								pUSSR:AcquireCity(city, false, true)
							else
								plot:SetOwner(playerid_USSR, -1 ) 
							end
						
						-- German territory
						elseif originalOwner == iPoland and (x > 22 and x < 28) then 
						
							print("(".. x ..",".. y ..") = Plot in german territory")
							if plot:IsCity() and ownerID ~= playerid_GERMANY then
								local city = plot:GetPlotCity()
								
								pGermany:AcquireCity(city, false, true)
							else
								plot:SetOwner(playerid_GERMANY, -1 ) 
							end
						end
						
						if plot:IsCity() and originalOwner == iPoland and ownerID ~= iPoland then
							local city = plot:GetPlotCity()
							
							if city and city:IsResistance() then
								city:ChangeResistanceTurns(-city:GetResistanceTurns())
							end
						end
					end
				end
				
				Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, "The Polish governement has fled the country, Poland has fallen under German and Soviet control.", "Poland has fallen !", 27, 70)

				print("Fall of Poland completed!")
			end
		end
	end
end

-- GameEvents.BattleStarted.Add(function(iType, iPlotX, iPlotY) end)
function FallOfDenmark(iType, iX, iY)
	print("~	Checking for FallOfDenmark")
	
	if (iX == 21 and iY == 75) then -- City of denmark
		print("~	Copenhagen attacked!")

		local iValue = savedData.GetValue("DenmarkHasFallen") or 0
				
		if (iValue ~= 1) then
			print("~	First occurence")
			savedData.SetValue("DenmarkHasFallen", 1)

			local iDenmark = GetPlayerIDFromCivID (DENMARK, true)
			local pDenmark = Players[iDenmark]
			
			local pEngland = Players[playerid_ENGLAND]
			local pAmerica = Players[playerid_AMERICA]
			local pGermany = Players[playerid_GERMANY]

			for unit in pDenmark:Units() do
				unit:Kill(false, -1)
			end

			print("~ 	Updating map")
			for iPlotLoop = 0, Map.GetNumPlots()-1, 1 do
				local plot = Map.GetPlotByIndex(iPlotLoop)
				local x = plot:GetX()
				local y = plot:GetY()
				local ownerID = plot:GetOwner() -- check only owned plot... not water
				
				if (ownerID ~= -1) then 
					local originalOwner = plot:GetOriginalOwner()

					-- Liberate Danish captured cities to original owner
					if (originalOwner ~= ownerID and ownerID == iDenmark) then

						if plot:IsCity() then
							print("~		Liberate city : " .. city:GetName() )
							local city = plot:GetPlotCity()
							
							Players[originalOwner]:AcquireCity(city, false, true)
						else
							print("~		Liberate plot : (" .. x ..", " .. y .. ")")
							plot:SetOwner(originalOwner, -1)
						end
					-- German territory
					elseif originalOwner == iDenmark and (x > 18 and x < 22) then 
						
						print("(".. x ..",".. y ..") = Plot in German territory")
						if plot:IsCity() and ownerID ~= playerid_GERMANY then
							local city = plot:GetPlotCity()
							
							pGermany:AcquireCity(city, false, true)
						else
							plot:SetOwner(playerid_GERMANY, -1 ) 
						end
					-- British territory
					elseif originalOwner == iDenmark and (x > 0 and x < 5) then 
					
						print("(".. x ..",".. y ..") = Plot in British territory")
						if plot:IsCity() and ownerID ~= playerid_ENGLAND then
							local city = plot:GetPlotCity()
							
							pEngland:AcquireCity(city, false, true)
						else
							plot:SetOwner(playerid_ENGLAND, -1 ) 
						end
					-- American territory
					elseif originalOwner == iDenmark and ((x > 156 and x < 180) or x == 0)  then 
					
						print("(".. x ..",".. y ..") = Plot in British territory")
						if plot:IsCity() and ownerID ~= playerid_AMERICA then
							local city = plot:GetPlotCity()
							
							pAmerica:AcquireCity(city, false, true)
						else
							plot:SetOwner(playerid_AMERICA, -1 ) 
						end
					end
					
					if plot:IsCity() and originalOwner == iDenmark and ownerID ~= iDenmark then
						local city = plot:GetPlotCity()
						
						if city and city:IsResistance() then
							city:ChangeResistanceTurns(-city:GetResistanceTurns())
						end
					end
				end
			end

			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, "To prevent civilian losses " .. pDenmark:GetName() .. " has surrender to Germany, Denmark has fallen under German control. Remaining Denmark territory is now under U.K. and American protection", pDenmark:GetName() .. " has fallen !", iX, iY)
			GameEvents.BattleStarted.Remove( FallOfDenmark )			
			print("Fall of Denmark completed!")
		end
	end
end