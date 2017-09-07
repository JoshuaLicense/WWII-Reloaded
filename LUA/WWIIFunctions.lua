print("------------------ Loaded WWIIFunctions.lua ------------------")

function UpdateDate()
	Game.SetNumeralDate(g_Calendar[Game.GetGameTurn()].Number);
end

function GetPlayerIDFromCivID (id, bIsMinor)
	if ( bIsMinor ) then
		for player_num = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
			local player = Players[player_num]
			if ( id == player:GetMinorCivType() ) then
				return player_num
			end
		end
	else
		for player_num = 0, GameDefines.MAX_MAJOR_CIVS-1 do
			local player = Players[player_num]
			if ( id == player:GetCivilizationType() ) then
				return player_num
			end
		end
	end
	if (id) then 
		print ("WARNING : can't find Player ID for civ ID = " .. id)
	else	
		print ("WARNING : civID is NILL or FALSE") 
	end
	return false
end

function DeclareWar(iPlayer1, iPlayer2)
	local player1 = Players[ iPlayer1 ]
	local player2 = Players[ iPlayer2 ]
	
	if not (player1:IsAlive() and player2:IsAlive()) then return end
	
	local team1 = Teams[ player1:GetTeam() ]
	local team2 = Teams[ player2:GetTeam() ]
	if not team1:IsAtWar( player2:GetTeam() ) then
		team1:DeclareWar( player2:GetTeam() )
	end
end

function MakePeace(iPlayer1, iPlayer2)
	local player1 = Players[ iPlayer1 ]
	local player2 = Players[ iPlayer2 ]
	
	if not (player1:IsAlive() and player2:IsAlive()) then return end
	
	local team1 = Teams[ player1:GetTeam() ]
	local team2 = Teams[ player2:GetTeam() ]
	if team1:IsAtWar( player2:GetTeam() ) then
		team1:MakePeace( player2:GetTeam() )
	end
end

function CreateAlliance(pPlayer1, pPlayer2)
	local team = Teams[ pPlayer1:GetTeam() ]
	local team2 = Teams[ pPlayer2:GetTeam() ]
	team:AddTeam( pPlayer2:GetTeam() )
	print (" - " .. pPlayer1:GetName() .. " is now permanently allied with " .. pPlayer2:GetName() )
	Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, pPlayer1:GetName() .. " and " .. pPlayer2:GetName().. " are now permanently allied", "Permanent Alliance created !")
end

function TurnToMonth()
	local turn = Game.GetGameTurn()
	local month = 0
	local turnDate = 0
	if g_Calendar[turn] then
		turnDate = tostring(g_Calendar[turn].Number)
		month = tonumber(string.sub(turnDate, 5, 6))
	end
	print ("   - exctracting month = " .. month .. " from date = " .. turnDate)
	return month
end

function Shuffle(t)
  local n = #t
 
  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end

function BroadcastNotification(type, text, title, x, y, id1, id2)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local player = Players[playerID]
		if player and player:IsAlive() then
			player:AddNotification(type, text, title, x, y, id1, id2)
		end
	end
end

function ChangeUnitOwner (unit, iNewOwner)

	local player = Players[ iNewOwner ]

	-- get position and damage before killing the unit !
	local x = unit:GetX()
	local y = unit:GetY()
	local damage = unit:GetDamage()
	local moves = unit:GetMoves()

	-- create the new unit from the old one
	local newUnit = player:InitUnit(unit:GetUnitType(), x, y)
	newUnit:SetExperience ( unit:GetExperience() )
	newUnit:SetLevel ( unit:GetLevel() )
	newUnit:SetDamage(damage)
	newUnit:SetMoves(moves)
	newUnit:SetName(unit:GetNameNoDesc())
	newUnit:SetOriginalOwner(unit:GetOriginalOwner()) -- so it always return the first unit owner, even after multiple change
	newUnit:SetEmbarked(unit:IsEmbarked())
	for unitPromotion in GameInfo.UnitPromotions() do
		local unitPromotionID = unitPromotion.ID
		if( unit:IsHasPromotion( unitPromotionID ) ) then
			newUnit:SetHasPromotion( unitPromotionID, true )
		end
	end
			
	-- kill old unit
	unit:Kill()

	return newUnit -- in case we want to do something with the new unit...
end

function GetAdjacentPlots(plot, bIncludeSelf)
	--print("   - Getting adjacent plots for " .. plot:GetX() .. ",".. plot:GetY())
	
	if not plot then
		print("- WARNING ! plot is nil for GetAdjacentPlots()")
	end

	local plotList = {}
	if bIncludeSelf and plot then
		table.insert(plotList, plot)
	end
	local direction_types = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
	}
	for loop, direction in ipairs(direction_types) do
		local adjPlot = Map.PlotDirection( plot:GetX(), plot:GetY(), direction)
		if ( adjPlot ~= nil ) then
			print("      - adding plot at " .. adjPlot:GetX() .. ",".. adjPlot:GetY())
			table.insert(plotList, adjPlot)
		end
	end
	print("   - num adjacent plots = " .. #plotList)
	return plotList
end

function CheckVictory()
	
	local iAlliesKeyCitiesLeft = 0;
	local iAxisKeyCitiesLeft = 0;
	
	local bKeyCityExists = false;
	
	for _, city in ipairs(g_Cities) do
		if city.Key then
			-- Check who owns it...
			local pPlot = Map.GetPlot(city.X, city.Y)
			local pCity = pPlot:GetPlotCity()
			
			if pCity then
				if g_Allied[pCity:GetOwner()] ~= nil then -- Allied key city
					iAlliesKeyCitiesLeft = iAlliesKeyCitiesLeft + 1
				elseif g_Axis[pCity:GetOwner()] ~= nil then
					iAxisKeyCitiesLeft = iAxisKeyCitiesLeft + 1
				end
				
			end
		end
	end
	print ("Axis: " .. iAxisKeyCitiesLeft)
	print ("Allies: " .. iAlliessKeyCitiesLeft)
	
	if iAlliesKeyCitiesLeft == 0 or iAxisKeyCitiesLeft == 0 then -- someone has won!!
		local pPlayerWon = iAlliesKeyCitiesLeft > 0 and Players[playerid_ENGLAND] or Players[playerid_GERMANY]
		
		PreGame.SetGameOption('GAMEOPTION_NO_EXTENDED_PLAY', true);	-- No extended play allowed
		
		local victoryType = iAlliesKeyCitiesLeft > 0 and 'VICTORY_ALLIED_EUROPE' or 'VICTORY_AXIS_EUROPE'
		Game.SetWinner(pPlayerWon:GetTeam(), GameInfo.Victories[victoryType].ID);					
		GameEvents.GameCoreTestVictory.Remove(TestVictory)
	end
end
GameEvents.GameCoreTestVictory.Add(TestVictory);

include('InstanceManager')

function InitScoreUI()
	ContextPtr:LookUpControl('/InGame/TopPanel/Score'):SetToolTipCallback( ToolTipUpdateScore )
	UpdateScoreString()
end
Events.LoadScreenClose.Add( InitScoreUI )

local tipControlTable = {};
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable );

function ToolTipUpdateScore( control )
	local player = Players[Game:GetActivePlayer()]
	
	local strText = "[ICON_MEDAL] Objective:[NEWLINE][NEWLINE]All key cities of your opponents must have been captured by you or your allies while all of your cities (and those of your allies) must still be under your control.[NEWLINE]";
	
	local strAlliedColor = g_Axis[Game:GetActivePlayer()] ~= nil and '[COLOR_POSITIVE_TEXT]' or '[COLOR_NEGATIVE_TEXT]'
	local strAxisColor = g_Axis[Game:GetActivePlayer()] ~= nil and '[COLOR_NEGATIVE_TEXT]' or '[COLOR_POSITIVE_TEXT]'
	
	local alliedCities = {}
	local axisCities = {}
	
	for _, city in ipairs(g_Cities) do
		if city.Key then
			-- Check who owns it...
			local pPlot = Map.GetPlot(city.X, city.Y)
			local pCity = pPlot:GetPlotCity()
			local pOwner = Players[pCity:GetOwner()]
			
			if pCity then
				if g_Allied[pCity:GetOwner()] ~= nil then -- Allied key city
					table.insert(alliedCities, pCity)
				elseif g_Axis[pCity:GetOwner()] ~= nil then
					table.insert(axisCities, pCity)					
				end
			end
		end
	end
	
	strText = strText .. "[NEWLINE]----------------------------------------------------------------[NEWLINE]"
	strText = strText .. "[NEWLINE]Allied cities: "
	
	for _, pCity in ipairs(alliedCities) do
		local pOwner = Players[pCity:GetOwner()]
		strText = strText .. "[NEWLINE][ICON_BULLET] " .. strAlliedColor .. pCity:GetName() .."[ENDCOLOR] controlled by ".. strAlliedColor .. pOwner:GetName() .. "[ENDCOLOR]"
	end
	
	strText = strText .. "[NEWLINE][NEWLINE]----------------------------------------------------------------[NEWLINE]"
	strText = strText .. "[NEWLINE]Axis cities: "
	
	for _, pCity in ipairs(axisCities) do
		local pOwner = Players[pCity:GetOwner()]
		strText = strText .. "[NEWLINE][ICON_BULLET] " .. strAxisColor .. pCity:GetName() .."[ENDCOLOR] controlled by ".. strAxisColor .. pOwner:GetName() .. "[ENDCOLOR]"
	end
	
	tipControlTable.TooltipLabel:SetText( strText );
	tipControlTable.TopPanelMouseover:SetHide(false);
    
	-- Autosize tooltip
	tipControlTable.TopPanelMouseover:DoAutoSize();
end

function UpdateScoreString()

	local scoreString = "[ICON_MEDAL] Captured cities: "
	
	local iAlliesTotalKeyCities = 0
	local iAxisTotalKeyCities = 0
	
	local iAlliesKeyCitiesCaptured = 0
	local iAxisKeyCitiesCaptured = 0
	
	for _, city in ipairs(g_Cities) do
		if city.Key then
			-- Check who owns it...
			local pPlot = Map.GetPlot(city.X, city.Y)
			local pCity = pPlot:GetPlotCity()
			
			if pCity then
				if g_Allied[pCity:GetOriginalOwner()] then
					iAlliesTotalKeyCities = iAlliesTotalKeyCities + 1
				end
				if g_Axis[pCity:GetOriginalOwner()] then
					iAxisTotalKeyCities = iAxisTotalKeyCities + 1
				end
				
				if g_Allied[pCity:GetOriginalOwner()] and pCity:GetOwner() ~= pCity:GetOriginalOwner() then
					iAlliesKeyCitiesCaptured = iAlliesKeyCitiesCaptured + 1
				elseif g_Axis[pCity:GetOwner()] == true and pCity:GetOwner() ~= pCity:GetOriginalOwner() then
					iAxisKeyCitiesCaptured = iAxisKeyCitiesCaptured + 1
				end
			end
		end
	end
	
	local strAlliedColor = g_Axis[Game:GetActivePlayer()] ~= nil and '[COLOR_POSITIVE_TEXT]' or '[COLOR_NEGATIVE_TEXT]'
	local strAxisColor = g_Axis[Game:GetActivePlayer()] ~= nil and '[COLOR_NEGATIVE_TEXT]' or '[COLOR_POSITIVE_TEXT]'

	scoreString = scoreString .. "Allied = " .. strAlliedColor .. iAlliesKeyCitiesCaptured .. "[ENDCOLOR]/" .. iAlliesTotalKeyCities .. ", Axis = " .. strAxisColor .. iAxisKeyCitiesCaptured .. "[ENDCOLOR]/" .. iAxisTotalKeyCities
	
	ContextPtr:LookUpControl("/InGame/TopPanel/Score"):SetText( scoreString )
	ContextPtr:LookUpControl("/InGame/TopPanel/Score"):SetHide( false )
end
GameEvents.CityCaptureComplete.Add(	UpdateScoreString )