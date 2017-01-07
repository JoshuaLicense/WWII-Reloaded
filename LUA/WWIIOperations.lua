print("------------------ Loaded WWIIOperations.lua ------------------")

function CheckOperations(iPlayer, iProject)
	print("CheckOperations called!")
	
	local player = Players[iPlayer]
	local project = GameInfo.Projects[iProject]

	if player and (project and project.Operation) then
		print("here")
		if g_Projects[iProject] then
		print(g_Projects[iProject].PlayerID .. "and" .. iPlayer)
		
			if g_Projects[iProject].PlayerID == iPlayer then
			print("here3")
			
				local condition = true
				if g_Projects[iProject].Condition then 
					condition = g_Projects[iProject].Condition()
				end
				
				if condition then
					print("- Launching operation ID : " .. iPlayer)
					print("- Codename : " .. Locale.ConvertTextKey(project.Description))
					
					if g_Projects[iProject].Callback then
						g_Projects[iProject].Callback()
					end
					
					BroadcastNotification(NotificationTypes.NOTIFICATION_PROJECT_COMPLETED, Locale.ConvertTextKey(g_Projects[iProject].Name).." launched !", Locale.ConvertTextKey(g_Projects[iProject].Name).." launched !", nil, nil, id, PlayerID )
				
					LaunchUnits(g_Projects[iProject].OrderOfBattle)
				else
					print("- Condition NOT met, add a gameevent!")
					GameEvents.PlayerDoTurn.Add( g_Projects[iProject].GameEvent )
				end
			end
		end
	else
		print("player or project not found")
	end
end

function OperationSonneblume( iPlayer )
	if iPlayer ~= playerid_GERMANY then return false end
	
	print("OperationSonneblume gameevent called!")
	
	local project = GameInfo.Projects["OPERATION_SONNENBLUME"]
	if g_Projects[project.ID].Condition() then
		print("Condition is true, so CheckOperations should launch!")
		CheckOperations(iPlayer, project.ID)
		-- Condition is now true, remove the gameevnts and launch
		GameEvents.PlayerDoTurn.Remove( OperationSonneblume )
	else
		return false
	end
end

function OperationWeserubung( iPlayer )
	if iPlayer ~= playerid_GERMANY then return false end
	
	print("OperationWeserubung gameevent called!")
	
	local project = GameInfo.Projects["OPERATION_WESERUBUNG"]
	if g_Projects[project.ID].Condition() then
		print("Condition is true, so CheckOperations should launch!")
		CheckOperations(iPlayer, project.ID)
		-- Condition is now true, remove the gameevnts and launch
		GameEvents.PlayerDoTurn.Remove( OperationWeserubung )
	else
		return false
	end
end

function LaunchUnits(OrderOfBattle)

	for i, oob in ipairs (OrderOfBattle) do
		local playerID = GetPlayerIDFromCivID( oob.CivID, oob.IsMinor )
		local player = Players [ playerID ]
		
		print("   - Launching " .. tostring(oob.Name))
		
		local plot = Map.GetPlot(oob.X, oob.Y)
		local plotList = GetAdjacentPlots(plot, true)

		local validPlotList = {}
		local objectivePlot = nil
		local bParadrop = (oob.LaunchType and oob.LaunchType == "ParaDrop")
		
		if bParadrop then
			objectivePlot = Map.GetPlot(oob.LaunchX, oob.LaunchY)
			local objectivePlotList = GetAdjacentPlots(objectivePlot, true)
			
			for i, testPlot in pairs(objectivePlotList) do
				if testPlot:GetNumUnits() == 0 and not testPlot:IsWater() and not testPlot:IsImpassable() and not testPlot:IsMountain() and not testPlot:IsCity() then
					table.insert(validPlotList, testPlot)
				end
			end
			Shuffle(validPlotList)
		end
	
	--	if player:GetID() == Game:GetActivePlayer() and bParadrop then
		if bParadrop then
			print("   - Looking at objective at " .. tostring(objectivePlot:GetX()) .. "," .. tostring(objectivePlot:GetY()))
			UI.LookAt(objectivePlot)
		end

		local placedUnits = 0
		local unitList = {}

		for i, unitPlot in ipairs (plotList) do
			local unitType = oob.Group[i]
			if unitType then
				local unit = player:InitUnit(unitType, unitPlot:GetX(), unitPlot:GetY())
				FinalizeUnitFromOOB(unit, oob, i)
				placedUnits = placedUnits + 1
				table.insert(unitList, unit:GetID())
			end
		end
		
		-- now the show for paradrop...
		if bParadrop then
			spotterList = {}
			print("   - Placing spotters for Paradrop mission...")
			for i, unit in pairs (unitList) do		
				local dropPlot = validPlotList[i]		
				local spotter = player:InitUnit(SETTLER, dropPlot:GetX(), dropPlot:GetY())
				spotter:SetHasPromotion(PROMOTION_AIR_RECON, true)

				print("     - Placing spotters at " .. tostring(dropPlot:GetX()) .."," .. tostring(dropPlot:GetY()))
				table.insert(spotterList, spotter:GetID())
			end

			local paraList = {}
			for i, unit in pairs (unitList) do
				local unit = player:GetUnitByID(unit)
				local dropPlot = validPlotList[i]
				
				print("   - Launch Paradrop mission for " .. unit:GetName() .. " (unitID = ".. unit:GetID() .. ") at " .. tostring(dropPlot:GetX()) .."," .. tostring(dropPlot:GetY()))
				
				local bHasParadrop = false
				if unit:IsHasPromotion(PROMOTION_PARADROP) then
					unit:SetHasPromotion(PROMOTION_PARADROP, false)
					bHasParadrop = true
				end
				
				unit:SetHasPromotion(PROMOTION_LONG_PARADROP, true)
				unit:PopMission()
				unit:PushMission(MissionTypes.MISSION_PARADROP, dropPlot:GetX(), dropPlot:GetY())

				unit:SetHasPromotion(PROMOTION_LONG_PARADROP, false)
				if bHasParadrop then
					unit:SetHasPromotion(PROMOTION_PARADROP, true)
				end
				unit:PopMission()
			end

			if oob.ObjectiveX and oob.ObjectiveY then
				print(" - Adding Dominance zone: ".. oob.ObjectiveX .. ", " .. oob.ObjectiveY)
				player:AddTemporaryDominanceZone(oob.ObjectiveX, oob.ObjectiveY)
			end
			
			print("   - Remove spotters for Paradrop mission...")
			for _, unit in pairs(spotterList) do
				local unit = player:GetUnitByID(unit)
				
				unit:Kill(true)
			end
		end
	end
end

-- Conditions 
function IsGermanyReadyForWeserubung()
	
	local pGermany = Players[ playerid_GERMANY ]
	local tGermany = Teams[ pGermany:GetTeam() ]
	local pNorway = Players[ GetPlayerIDFromCivID(NORWAY, true) ]
	
	if tGermany:IsAtWar( pNorway:GetTeam() ) then
		print("- Germany is at war with Norway!")
		if Map.GetPlot(22, 70):GetOwner() == playerid_GERMANY then -- Berlin
			print("- Berlin NOT occupied!")
			return true
		end
	end
	return false
end
function IsGermanyReadyForSonnenblume()

	local iValue = savedData.GetValue("FranceHasFallen") or 0
	
	if iValue == 1 then
		print("	- Sonneblume: France has fallen")
		if Map.GetPlot(26, 48):GetOwner() ~= GetPlayerIDFromCivID(ITALIAN_COLONY, true) then
			print("	- Sonneblume: Benghazi captured")
			return true
		end
	end
	
	return false
end