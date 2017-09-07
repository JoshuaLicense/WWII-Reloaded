print("------------------ Loaded WWIIMain.lua ------------------")

Game.ToggleDebugMode()

include("\WWIIDefines.lua")
include("\WWIIFunctions.lua")

include("\WWIITraits.lua")
include("\WWIIDiplomacy.lua")
include("\WWIIMilitary.lua")

include("\WWIIConvoyRoutes.lua")
include("\WWIIHistoricEvents.lua")
include("\WWIIOperations.lua")

function PlayerDoTurn(iPlayer)
	PlayerTraits( iPlayer )
	InitializeConvoys( iPlayer )
end
GameEvents.PlayerDoTurn.Add( PlayerDoTurn )

function GameDoTurn()
	UpdateDate()
	LendLeaseAct()

	SetMinorRelations()
	SetMinorDiplomacy()
	SetMajorDiplomacy()
end
GameEvents.GameDoTurn.Add( GameDoTurn )

function UnitSetXY(iPlayer, iUnitID, iX, iY)
	UnitTraits(iPlayer, iUnitID, iX, iY)
end
GameEvents.UnitSetXY.Add( UnitSetXY )

if savedData.GetValue("FranceHasFallen") ~= 1 then
	GameEvents.CityCaptureComplete.Add( FallOfFrance )
end
if savedData.GetValue("PolandHasFallen") ~= 1 then
	GameEvents.CityCaptureComplete.Add( FallOfPoland )
end
if savedData.GetValue("DenmarkHasFallen") ~= 1 then
	GameEvents.BattleStarted.Add( FallOfDenmark )
end

----------------------------------------------------------------

function ProjectCreated(iPlayer, iCity, iProject, bGold, bFaith)
	CheckOperations(iPlayer, iProject)
end
GameEvents.CityCreated.Add( ProjectCreated )

function SortOperations(iPlayer, iCity, iProjectType)
	local isOperation = GameInfo.Projects[iProjectType].Operation
	if isOperation then
		if g_OpsAvailable[iPlayer] then
			for _, Op in pairs(g_OpsAvailable[iPlayer]) do
				if Op == iProjectType then
					return true
				end
			end	
		end
		return false
	end
	return true
end
GameEvents.CityCanCreate.Add( SortOperations )

g_OpsAvailable = {
	[playerid_GERMANY] = { OPERATION_WESERUBUNG, OPERATION_FALLGELB, OPERATION_SONNENBLUME, }, --OPERATION_TWENTYFIVE, OPERATION_MARITA },
	--[playerid_JAPAN] = { OPERATION_PACIFIC },
	[playerid_AMERICA] = { OPERATION_TORCH },
	[playerid_USSR] = { OPERATION_MOTHERLAND },
}

-- Operations
g_Projects = {
	[OPERATION_WESERUBUNG] = { -- projectID as index !
		Name = "TXT_KEY_OPERATION_WESERUBUNG",
		PlayerID = playerid_GERMANY,
		OrderOfBattle = {
			{	Name = "Paragroup 1 (Narvik)", X = 22, Y = 70, CivID = GERMANY, -- spawn at Berlin
				Group = {	GE_PARATROOPER,	GE_PARATROOPER	},
				UnitsXP = {		10,				15,	}, 
				ObjectiveX = 22, -- Narvik
				ObjectiveY = 89,
				LaunchType = "ParaDrop",
				LaunchX = 22, -- Destination plot
				LaunchY = 87, -- (22,87) = Near Narvik
			},
			{	Name = "Paragroup 2 (Oslo)", X = 22, Y = 70, CivID = GERMANY, -- spawn at Berlin
				Group = {	GE_PARATROOPER,	GE_PARATROOPER,	},
				UnitsXP = {		10,				15,	}, 
				ObjectiveX = 20, -- Narvik
				ObjectiveY = 79,
				LaunchType = "ParaDrop",
				LaunchX = 18, -- Destination plot
				LaunchY = 81, -- (18, 81) = Near Oslo
			},
		},		
		GameEvent = OperationWeserubung,	
		Condition = IsGermanyReadyForWeserubung, -- Must refer to a function, remove this line to use the default condition (always true)
	},
	[OPERATION_SONNENBLUME] = {
		Name = "TXT_KEY_OPERATION_SONNENBLUME",
		PlayerID = playerid_GERMANY,
		OrderOfBattle = {
			{	Name = "Afrika Korps", X = 20, Y = 45, CivID = GERMANY,
				Group = {	GE_INFANTRY,  GE_INFANTRY,	GE_PANZER_III, GE_PANZER_III },
				UnitsXP = {		10,				15,		 	10	}, 
				ObjectiveX = 32, -- Suez
				ObjectiveY = 47,
			},
		},
		GameEvent = OperationSonneblume,
		Condition = IsGermanyReadyForSonnenblume,	
	},
}
----------------------------------------------------------------

function SetInitialCityBuilds()

	if g_Cities then
		for i, cityData in pairs (g_Cities) do
			local plot = Map.GetPlot(cityData.X, cityData.Y)
			if plot then
				local city = plot:GetPlotCity()
				if city then
					local player = Players[city:GetOwner()]

					if player:IsHuman() then -- auto-set wealth to all cities, micromanagement is allowed/encouraged, but not the default option
						city:PushOrder (OrderTypes.ORDER_MAINTAIN, GameInfo.Processes["PROCESS_WEALTH"].ID, -1, 0, false, false)
					end

					if cityData.Buildings then
						local numBuilding = 0
						for j, building in ipairs (cityData.Buildings) do
							city:SetNumRealBuilding(building, 1)
							numBuilding = numBuilding + 1
						end
					end
					
					-- Bonus for AI
					if (cityData.AIBuildings and not player:IsHuman()) then 
						for k, building in ipairs (cityData.AIBuildings) do
							city:SetNumRealBuilding(building, 1)
						end
					end
				end
			end
		end
	end
end

local iValue = savedData.GetValue("WWIIInitialized");

if iValue == nil then
	savedData.SetValue("WWIIInitialized", 1)

	UpdateDate()
	SetInitialCityBuilds()
	
	SetMinorRelations()
	SetMinorDiplomacy()
	SetMajorDiplomacy()
	
	for i = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local player = Players[i];
		if (player:IsEverAlive()) then
			local civType = player:GetCivilizationType();
			if(civType == ENGLAND) then
				player:ChangeYield(YieldTypes.YIELD_PERSONNEL, 5000)
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 5000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 6000)
				player:SetGreatGeneralCombatBonus(15)
			elseif(civType == GERMANY) then
				player:ChangeYield(YieldTypes.YIELD_PERSONNEL, 15000)
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 4000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 7000)
				player:SetGreatGeneralCombatBonus(20)
			elseif(civType == FRANCE) then
				player:ChangeYield(YieldTypes.YIELD_PERSONNEL, 5000)
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 4000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 6000)
				player:SetGreatGeneralCombatBonus(10)
			elseif(civType == ITALY) then
				player:ChangeYield(YieldTypes.YIELD_PERSONNEL, 3000)
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 2000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 7000)
				player:SetGreatGeneralCombatBonus(5)
			elseif(civType == AMERICA) then
				player:ChangeYield(YieldTypes.YIELD_PERSONNEL, 3000)
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 2000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 2500)
				player:SetGreatGeneralCombatBonus(15)
			elseif(civType == JAPAN) then
				player:ChangeYield(YieldTypes.YIELD_PERSONNEL, 7000)
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 4000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 8000)
				player:SetGreatGeneralCombatBonus(10)
			elseif(civType == USSR) then
				player:ChangeYield(YieldTypes.YIELD_MATERIEL, 5000)
				player:ChangeYield(YieldTypes.YIELD_FUEL, 6000)
				player:SetGreatGeneralCombatBonus(5)
			end
		end
	end
	
	InitializeMilitary()
	
	SaveConvoyDB("CREATE TABLE IF NOT EXISTS Convoys(Player INTEGER, Unit INTEGER, Route INTEGER, Cargo INTEGER, Reference INTEGER, PRIMARY KEY (Player, Unit))")
end