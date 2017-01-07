print("------------------ Loaded WWIITraits.lua ------------------")

function UnitTraits(iPlayer, iUnitID, iX, iY)

	local plot = Map.GetPlot(iX, iY)
	local player = Players[iPlayer]
	local unit = player:GetUnitByID(iUnitID)

	if plot and iPlayer == playerid_ENGLAND and unit:GetDomainType() ~= DomainTypes.DOMAIN_SEA then -- English get the bonus over the UK
		
		local NoSurrenderID = GameInfo.UnitPromotions["PROMOTION_NEVER_SURRENDER"].ID
		if unit:IsHasPromotion(NoSurrenderID) then -- if they don't have the promotion give it em
			if not (plot:GetOriginalOwner() == iPlayer) then
				unit:SetHasPromotion(NoSurrenderID, false)
			end
		else
			if plot:GetOriginalOwner() == iPlayer then
				unit:SetHasPromotion(NoSurrenderID, true)
			end
		end	
	elseif iPlayer == playerid_ITALY and unit:GetDomainType() == DomainTypes.DOMAIN_SEA then -- Italians 
		
		local MarenostrumID = GameInfo.UnitPromotions["PROMOTION_MARENOSTRUM"].ID
		if unit:IsHasPromotion(MarenostrumID) then -- if they don't have the promotion give it em
			if ((iX > 5 and iY > 45) and (iX < 37 and iY < 59)) or ((iX > 12 and iY > 58) and (iX < 25 and iY < 63)) and not (iX == 33 and iY == 46) then
				unit:SetHasPromotion(MarenostrumID, false)
			end
		else
			if ((iX > 5 and iY > 45) and (iX < 37 and iY < 59)) or ((iX > 12 and iY > 58) and (iX < 25 and iY < 63)) and not (iX == 33 and iY == 46) then -- Med
				unit:SetHasPromotion(MarenostrumID, true)
			end
		end
	end
end

function PlayerTraits(iPlayer)
	local player = Players[iPlayer]
	
	if savedData.GetValue("FranceHasFallen") == 1 then
		if player:GetCivilizationType() == FRANCE then
			local frenchSoil = {
				{X = 11, Y = 66},
				{X = 11, Y = 65},
				{X = 15, Y = 67},
			}
			
			local rand = math.random(100)
			
			if rand > 98 and savedData.GetValue("FranceHasFallen") then
				print("Random true 2%, trying to spawn resistance");
				
				for i, frenchPlot in ipairs(frenchSoil) do
					local plot = Map.GetPlot(frenchPlot.X, frenchPlot.Y)
					print ("Owner .. " .. plot:GetOwner() .. " france id is ".. playerid_FRANCE)
					if plot:GetOwner() ~= playerid_FRANCE and plot:GetNumUnits() == 0 then
						print("Found a plot that is not in French control")
						
						local lastSpawned = savedData.GetValue("ResistanceLastSpawned") or 0
						
						if (lastSpawned - Game.GetGameTurn()) > 20 then
							print("lastSpawn if true.")
							player:InitUnit(RESISTANCE, frenchPlot.X, frenchPlot.Y)
							savedData.SetValue("ResistanceLastSpawned", Game.GetGameTurn())
						end
					end
				end
			end
		end
	end
end

function CityCaptureTraits(iOldPlayer, bCapital, iX, iY, iNewPlayer, iPopulation, bConquest, iGreatWorksPresent, iGreatWorksXferred)
	print(iOldPlayer .."," .. iX .. iY .."," .. iNewPlayer ..",".. iPopulation)
	
	local player = Players[iOldPlayer]
	
	if player:GetCivilizationType() == USSR then -- Only russia get the trait	
		print("Is USSR")
		local FactorySites = { -- Urals
			{X = 50, Y = 71},
			{X = 51, Y = 70},
			{X = 52, Y = 74}
		}
		
		local WesternCities = {
			["32,69"] = { -- Kiev
				{X = 33, Y = 71}, -- Manufactories
			},
			["36,64"] = { -- Sevastopol
				{X = 36, Y = 66},
			}
		}
		
		local ManufactoryImprovement = GameInfo.Improvements.IMPROVEMENT_MANUFACTORY.ID
		
		if WesternCities[iX ..",".. iY] then -- If the city exists, remove manufactories
			print("An eligible eastern city captured")
			local factoriesMoved = savedData.GetValue("FactoriesDestroyed") or 0
			
			for i, plots in ipairs(WesternCities[iX ..",".. iY]) do
				local plot = Map.GetPlot(plots.X, plots.Y)
				
				if plot:GetImprovementType() == ManufactoryImprovement then
					print("Plot has manufactory, REMOVED")
					plot:SetImprovementType(-1)
					
					if factoriesMoved ~= nil then
						savedData.SetValue("FactoriesDestroyed", factoriesMoved + 1);
					end
				end
			end
			
			if FactorySites[factoriesMoved - 1] then
				print(FactorySites[factoriesMoved - 1].X .."HEREEERERERE")
				
				local plot = Map.GetPlot(FactorySites[factoriesMoved - 1].Y, FactorySites[factoriesMoved - 1].X)
				
				if plot:GetImprovementType() ~= ManufactoryImprovement then
					print("Change to manufactory")
					plot:SetImprovementType(ManufactoryImprovement)
				end
			end
		end
	end
end