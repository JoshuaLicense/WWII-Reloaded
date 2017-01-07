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