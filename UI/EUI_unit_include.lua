local math_max = math.max
local string_format = string.format
local tostring = tostring

local DomainTypes_DOMAIN_AIR = DomainTypes.DOMAIN_AIR
local Game = Game
local GameDefines_MOVE_DENOMINATOR = GameDefines.MOVE_DENOMINATOR
local GameInfo = EUI.GameInfoCache
local L = Locale.ConvertTextKey
local Players = Players
local PreGame = PreGame
local Teams = Teams

local ModDB = Modding.OpenSaveData()

function LoadConvoyDB(sQuery, ...)
	for row in ModDB.Query(sQuery, ...) do
		Convoy = {
			UnitID = row.Unit,
			RouteID = row.Route,
			Type = row.Cargo,
			Reference = row.Reference
		}
	end
	return Convoy
end

function EUI.ShortUnitTip( unit )
	local activePlayerID = Game.GetActivePlayer()
--	local activePlayer = Players[activePlayerID]
	local activeTeamID = Game.GetActiveTeam()
	local activeTeam = Teams[activeTeamID]

	local unitOwnerID = unit:GetOwner()
	local unitOwner = Players[unitOwnerID]
	local unitTeamID = unit:GetTeam()

	local civAdjective = unitOwner:GetCivilizationAdjective()
	local nickName = unitOwner:GetNickName()

	local unitTip
	if activeTeamID == unitTeamID or ( unitOwner:IsMinorCiv() and unitOwner:IsAllies( activePlayerID ) ) then
		unitTip = "[COLOR_POSITIVE_TEXT]"
	elseif activeTeam:IsAtWar( unitTeamID ) then
		unitTip = "[COLOR_NEGATIVE_TEXT]"
	else
		unitTip = "[COLOR_WHITE]"
	end
	unitTip = unitTip .. L(unit:GetNameKey()) .. "[ENDCOLOR]"

	-- Player using nickname
	if PreGame.IsMultiplayerGame() and nickName and #nickName > 0 then

		unitTip = L( "TXT_KEY_MULTIPLAYER_UNIT_TT", nickName, civAdjective, unitTip )

	elseif activeTeam:IsHasMet( unitTeamID ) then

		unitTip = L( "TXT_KEY_PLOTROLL_UNIT_DESCRIPTION_CIV", civAdjective, unitTip )
		if unit:HasName() then
			unitTip = L(unit:GetNameNoDesc()) .. " (" .. unitTip .. ")"
		end
	end

	local originalOwnerID = unit:GetOriginalOwner()
	local originalOwner = originalOwnerID and Players[originalOwnerID]
	if originalOwner and originalOwnerID ~= unitOwnerID and activeTeam:IsHasMet( originalOwner:GetTeam() ) then
		unitTip = unitTip .. " (" .. originalOwner:GetCivilizationAdjective() .. ")"
	end

	-- Debug stuff
	if Game.IsDebugMode() then
		unitTip = unitTip .. " (".. tostring(unitOwnerID) ..":" .. tostring(unit:GetID()) .. ")"
	end

	-- Moves & Combat Strength
	local unitMoves = 0
	local unitStrength = unit.GetBaseCombatStrength and unit:GetBaseCombatStrength() or unit:GetCombatStrength() --BE stupid function name change
	-- todo unit:GetMaxDefenseStrength()
	local rangedStrength = unit.GetBaseRangedCombatStrength and unit:GetBaseRangedCombatStrength() or unit:GetRangedCombatStrength() --BE stupid function name change

	if unit:GetDomainType() == DomainTypes_DOMAIN_AIR then
		unitStrength = rangedStrength
		rangedStrength = 0
		unitMoves = unit:Range()
	else
		if unitOwnerID == activePlayerID then
			unitMoves = unit:MovesLeft()
		else
			unitMoves = unit:MaxMoves()
		end
		unitMoves = unitMoves / GameDefines_MOVE_DENOMINATOR
	end

	-- In Orbit?
	if unit.IsInOrbit and unit:IsInOrbit() then
		unitTip = unitTip .. " " .. "[COLOR_CYAN]" .. L( "TXT_KEY_PLOTROLL_ORBITING" ) .. "[ENDCOLOR]"

	else
		-- Moves
		if unitMoves > 0 then
			unitTip = string_format("%s %.3g[ICON_MOVES]", unitTip, unitMoves )
		end

		-- Strength
		if unitStrength > 0 then
			local adjustedUnitStrength = (math_max(100 + unit:GetStrategicResourceCombatPenalty(), 10) * unitStrength) / 100
			--todo other modifiers eg unhappy...
			if adjustedUnitStrength < unitStrength then
				adjustedUnitStrength = string_format(" [COLOR_NEGATIVE_TEXT]%.3g[ENDCOLOR]", adjustedUnitStrength )
			end
			unitTip = unitTip .. " " .. adjustedUnitStrength .. "[ICON_STRENGTH]"
		end

		-- Ranged Strength
		if rangedStrength > 0 then
			unitTip = unitTip .. " " .. rangedStrength .. "[ICON_RANGE_STRENGTH]"..unit:Range().." "
		end

		-- Religious Fervor
		if unit.GetReligion then
			local religionID = unit:GetReligion()
			if religionID > 0 then
				local spreadsLeft = unit:GetSpreadsLeft()
				unitTip = unitTip .. " "
				if spreadsLeft > 0 then
					unitTip = unitTip .. spreadsLeft
				end
				unitTip = unitTip .. tostring( (GameInfo.Religions[ religionID ] or {}).IconString ) .. L( Game.GetReligionName( religionID ) )
			end
		end
		
		-- Hit Points
		if unit:IsHurt() then
			unitTip = unitTip .. " " .. L( "TXT_KEY_PLOTROLL_UNIT_HP", unit:GetCurrHitPoints() )
		end
	end

	-- Embarked?
	if unit:IsEmbarked() then
		unitTip = unitTip .. " " .. L( "TXT_KEY_PLOTROLL_EMBARKED" )
	end
	
	-- Personnel & Materiel 
	if unit:GetDamage() > 0 then
		unitTip = unitTip .. "[NEWLINE]Requested: "
		if unit:GetPersonnelPerHP() > 0 then
			unitTip = unitTip .. unit:GetPersonnelPerHP() * unit:GetDamage() .. "[ICON_PERSONNEL] "
		end
		if unit:GetMaterielPerHP() > 0 then
			unitTip = unitTip .. unit:GetMaterielPerHP() * unit:GetDamage() .. "[ICON_MATERIEL]"
		end
	end
	-- per hp
	if unit:GetPersonnelPerHP() > 0 or unit:GetMaterielPerHP() > 0 then
		unitTip = unitTip .. "[NEWLINE]Per HitPoint: "
		unitTip = unitTip .. (unit:GetPersonnelPerHP() > 0 and unit:GetPersonnelPerHP() or 0) .. "[ICON_PERSONNEL] "
		unitTip = unitTip .. (unit:GetMaterielPerHP() > 0 and unit:GetMaterielPerHP() or 0) .. "[ICON_MATERIEL]"
	end

	-- fuel
	if unit:GetBaseFuelConsumption() > 0 then
		unitTip = unitTip .. "[NEWLINE]Fuel Consumption: " .. unit:GetFuelConsumption() .. "/" .. unit:GetBaseFuelConsumption() .. " [ICON_FUEL]" -- (Max: " .. unit:GetBaseFuelConsumption() .. ")" 
	end
	
	-- convoys
	if unit:GetUnitType() == GameInfo.Units.UNIT_CONVOY.ID then
		local loadData = LoadConvoyDB("SELECT * FROM Convoys WHERE Unit = ? AND Player = ?", unit:GetID(), unitOwnerID)
		
		local transportType = loadData.Type
		local transportReference = loadData.Reference
		
		local destPlot = unit:GetConvoyPlot()
		
		if transportReference and transportType then
			local strTransport = ""
			local strDestination = ""
			
			-- Convoys 
			TRANSPORT_PERSONNEL = 1
			TRANSPORT_MATERIEL = 2
			TRANSPORT_FUEL = 3
			TRANSPORT_UNIT = 4
			TRANSPORT_GOLD = 5
			
			if transportType == TRANSPORT_MATERIEL then
				strTransport = transportReference .. " [ICON_MATERIEL] materiel"
			elseif transportType == TRANSPORT_PERSONNEL then
				strTransport = transportReference .. " [ICON_PERSONNEL] personnel"
			elseif transportType == TRANSPORT_UNIT then 
				local unitInfo = GameInfo.Units[transportReference]
				local unitName = Locale.ConvertTextKey( unitInfo.Description ) .. " (" .. Locale.ToUpper(Locale.ConvertTextKey(GameInfo.UnitClasses[unitInfo.Class].Description)) .. ")"
				strTransport = "" .. unitName
			elseif transportType == TRANSPORT_FUEL then
				strTransport = transportReference .. " [ICON_FUEL] fuel"
			elseif transportType == TRANSPORT_GOLD then
				strTransport = transportReference .. " [ICON_GOLD] gold"
			else 
				strTransport = transportReference .. " unknown cargo"
			end
			unitTip = unitTip .. "[NEWLINE]Cargo: ".. strTransport
			
			if destPlot:IsCity() then
				local city = destPlot:GetPlotCity()
				strDestination = city:GetName()
			else
				strDestination = " plot (".. destPlot:GetX() .."," .. destPlot:GetY() ..")"
			end			
			
			unitTip = unitTip .. "[NEWLINE]Destination: ".. strDestination
		end
			
	elseif unit:GetDomainType() == DomainTypes.DOMAIN_LAND and not unit:IsEmbarked() and unitStrength > 0 then
		unitTip = unitTip .. "[NEWLINE]" .. L( "TXT_KEY_SUPPLY_LINE_EFFICIENCY", unit:GetSupplyLineEfficiency() )
	end

	return unitTip
end