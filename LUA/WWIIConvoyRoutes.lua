print("------------------ Loaded WWIIConvoyRoutes.lua ------------------")

------------------------------------------------------------------------------
-- Convoy Initialization
------------------------------------------------------------------------------
TRANSPORT_PERSONNEL = 1
TRANSPORT_MATERIEL = 2
TRANSPORT_FUEL = 3
TRANSPORT_UNIT = 4
TRANSPORT_GOLD = 5

function SaveConvoyDB(sQuery, ...)
	for _ in savedData.Query(sQuery, ...) do end
end

function LoadConvoyDB(sQuery, ...)

	for row in savedData.Query(sQuery, ...) do
		Convoy = {
			UnitID = row.Unit,
			RouteID = row.Route,
			Type = row.Cargo,
			Reference = row.Reference
		}
	end
	
	return Convoy
end

function Count(sQuery, ...)
	
	local iCount
	
	for row in savedData.Query(sQuery, ...) do
		iCount = row.Count
	end
	return iCount
end

function CheckConvoyDestination(iPlayer, plot)
	print('- Checking convoy destination!')
	if plot:IsFriendlyTerritory(iPlayer) then
		local city = plot:GetPlotCity()
		
		if city then
			if not city:IsBlockaded() then
				print("		- " .. city:GetName() .. " is the destination and not blockaded!")
				return plot
			end
		else
			print("		- (" .. plot:GetX() .. ", " .. plot:GetY() .. ") is the destination!")
			return plot
		end
	end
	return false
end

function InitConvoyUnit(iPlayer, startPlot, objPlot, routeID)
	print('- Try to spawn convoy unit')
	
	local player = Players[iPlayer]

	local unit = player:InitUnit(CONVOY, startPlot:GetX(), startPlot:GetY())
	if unit then
		unit:SetConvoyPlot(objPlot)

		local strDestination = ""
		if objPlot:IsCity() then
			local city = objPlot:GetPlotCity()
			strDestination = city:GetName()
		else
			strDestination = " plot (".. objPlot:GetX() .."," .. objPlot:GetY() ..")";
		end

		local transport = g_Convoy[routeID].Cargo()
		SaveConvoyDB("INSERT INTO Convoys(Player, Unit, Route, Cargo, Reference) VALUES(?, ?, ?, ?, ?)", iPlayer, unit:GetID(), routeID, transport.Type, transport.Reference)

		local strTransport = ""
		if transport.Type == TRANSPORT_MATERIEL then
			strTransport = transport.Reference .. " materiel"
		elseif transport.Type == TRANSPORT_PERSONNEL then
			strTransport = transport.Reference .. " personnel"
		elseif transport.Type == TRANSPORT_UNIT then 
			local unitInfo = GameInfo.Units[transport.Reference]
			strTransport = Locale.ConvertTextKey( unitInfo.Description ) .. " (" .. Locale.ToUpper(Locale.ConvertTextKey(GameInfo.UnitClasses[unitInfo.Class].Description)) .. ")"
		elseif transport.Type == TRANSPORT_GOLD then 
			strTransport = transport.Reference .. " gold"
		elseif transport.Type == TRANSPORT_FUEL then 
			strTransport = transport.Reference .. " fuel"
		end

		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "New convoy has set off, transporting " .. strTransport .. " to " .. strDestination, "New convoy has set off!", startPlot:GetX(), startPlot:GetY())
		return true
	end
	return false
end

function InitializeConvoys(iPlayer)
	if g_Convoy then
		local player = Players [ iPlayer ]
		if (not player:IsAlive()) or player:IsBarbarian() then
			return
		end
		for routeID, data in ipairs(g_Convoy) do
			if iPlayer == GetPlayerIDFromCivID( data.CivID, data.IsMinor ) then
				print("- Checking maritime route: ".. g_Convoy[routeID].Name)
				
				local ConvoysOnRoute = Count("SELECT COUNT(*) as Count FROM Convoys WHERE Player = ? AND Route = ?", iPlayer, routeID)
				if(ConvoysOnRoute < data.MaxConvoysOnRoute) then
					local rand = math.random( 1, 100 )
					local bSpawned = false
					
					local condition = true
					if data.Condition then
						condition = data.Condition()
					end
					
					local objPlot = false
					
					for i, destination in ipairs(g_Convoy[routeID].DestinationList) do
						local destPlot = Map.GetPlot(destination.X, destination.Y)
						if destPlot and not objPlot then
							objPlot = CheckConvoyDestination(iPlayer, destPlot)
						end
					end
					
					if not objPlot then
						print("      - Can't get a destination...")
					end

					if not condition then
						print("      - Condition is not true...")
					end
					
					if condition and objPlot and rand <= data.Frequency then
						print("   - Spawning! Frequency = " .. data.Frequency .. ", random percent = " .. rand )
						
						local numTry = 0
						while not bSpawned and numTry < #data.SpawnList do 

							local randPlot = math.random( 1, #data.SpawnList )
							local spawn = data.SpawnList[randPlot]
							
							local startPlot = Map.GetPlot(spawn.X, spawn.Y)
							
							bSpawned = InitConvoyUnit(iPlayer, startPlot, objPlot, routeID)
							numTry = numTry + 1
						end
					end
				else 
					print(" 		- Reached max convoys onroute")
				end
			end		
		end
	end
end
-- GameEvents.PlayerDoTurn.Add(InitializeConvoys);

-----------------------------------------
-- Lend Lease Act
-----------------------------------------

function LendLeaseAct()

	local turn = Game.GetGameTurn()
	local turnDate, prevDate = 0, 0
	if g_Calendar[turn] then turnDate = g_Calendar[turn].Number else turnDate = 19470105 end
	if g_Calendar[turn-1] then prevDate = g_Calendar[turn-1].Number else  prevDate = turnDate - 1 end

	if 19410311 <= turnDate and 19410311 > prevDate then
		savedData.SetValue("LendLease", 1)
		GameEvents.GameDoTurn.Remove( LendLeaseAct );
		
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, " America has passed the Lend Lease Act; France, the United Kingdom and the USSR will recieve extra convoys from America.", "Lend Lease Act Passed!")
	end
end
--GameEvents.GameDoTurn.Add( LendLeaseAct )

function IsLendLeaseActive()
	local iValue = savedData.GetValue("LendLease")
	if iValue == 1 then
		return true
	else
		return false
	end
end

------------------------------------------------------------------------------
-- Route Conditions
------------------------------------------------------------------------------
function CheckUKConvoys() return (Map.GetPlot(9,75):GetOwner() == playerid_ENGLAND and IsLendLeaseActive()) end
function CheckUSEastConvoys()
	return (Map.GetPlot(155,65):GetOwner() == playerid_AMERICA and IsLendLeaseActive()) 
end
function CheckUSWestConvoys() return (Map.GetPlot(130,64):GetOwner() == playerid_AMERICA and IsLendLeaseActive()) end

function IsHongKongAlly() return Map.GetPlot(84,48):GetOwner() == playerid_ENGLAND end
function IsPanamaAlly() return Map.GetPlot(150,40):GetOwner() == playerid_AMERICA end
function IsManillaAlly() return Map.GetPlot(88,42):GetOwner() == playerid_AMERICA end
function IsSaigonAlly() return Map.GetPlot(79,38):GetOwner() == GetPlayerIDFromCivID (FRENCH_COLONY, true) end

function IsManillaPuppet() return Map.GetPlot(88,42):GetOwner() ~= playerid_AMERICA end
function IsHongKongPuppet() return Map.GetPlot(84,48):GetOwner() ~= playerid_ENGLAND end
function IsSaigonPuppet() return Map.GetPlot(79,38):GetOwner() ~= GetPlayerIDFromCivID (FRENCH_COLONY, true) end

function IsRailroadOpenLuleaToNarvik() 
	local Narvik = Map.GetPlot(22,89)
	local Lulea = Map.GetPlot(26,86)
	local Germany = Players[playerid_GERMANY]
	
	return (not IsNotWinter() and Narvik:GetOwner() == playerid_GERMANY and Germany:IsPlotConnectedToPlot(Lulea, Narvik, RouteTypes.ROUTE_RAILROAD))
end

function IsRailroadOpenBandarToStalingrad() 
	local Bandar = Map.GetPlot(42,49)
	local Stalingrad = Map.GetPlot(41,68)
	local USSR = Players[GetPlayerIDFromCivID(USSR, false)]
	
	return (CheckUSEastConvoys() and Bandar:GetOwner() == GetPlayerIDFromCivID(IRAN, true) and USSR:IsPlotConnectedToPlot(Bandar, Stalingrad, RouteTypes.ROUTE_RAILROAD))
end

function IsNotWinter() return (TurnToMonth() < 10 and TurnToMonth() > 4) end
	

------------------------------------------------------------------------------
-- Route Transport
------------------------------------------------------------------------------
function GetHongKongCargo() return {Type = TRANSPORT_GOLD, Reference = 1000} end
function GetPanamaCargo() return {Type = TRANSPORT_GOLD, Reference = 250} end
function GetManillaCargo() return {Type = TRANSPORT_GOLD, Reference = 750} end
function GetSaigonCargo() return {Type = TRANSPORT_GOLD, Reference = 500} end
function GetScandanavianCargo() return {Type = TRANSPORT_MATERIEL, Reference = 500} end

function GetLendLeaseCargo()
	local rand = math.random(1, 8);
	local transport;
	
	if rand < 3 then
		transport = {Type = TRANSPORT_FUEL, Reference = 1000}
	else
		transport = {Type = TRANSPORT_MATERIEL, Reference = 1000}
	end
	
	return transport;
end

------------------------------------------------------------------------------
-- Route list (Must match the order below)
------------------------------------------------------------------------------
-- UK
US_TO_UK = 1 -- Lend Lease
HONGKONG_TO_UK = 2

-- USSR
UK_TO_USSR = 3 
US_TO_USSR_ARCTIC = 4 -- Lend Lease
US_TO_USSR_FAR_EAST = 5
US_TO_USSR_PERSIAN = 6

-- FR
US_TO_FRANCE = 7 -- Lend Lease
SAIGON_TO_FRANCE = 8

-- US
PANAMA_TO_US = 9 -- Gold
MANILLA_TO_US = 10

-- GE
NORWAY_TO_GERMANY = 11 -- Winter months
SWEDEN_TO_GERMANY = 12 -- Summer

-- IT

-- JP
HONGKONG_TO_JAPAN = 13
MANILLA_TO_JAPAN = 14
SAIGON_TO_JAPAN = 15

------------------------------------------------------------------------------
-- Route array
------------------------------------------------------------------------------
g_Convoy = {
	---------------------------------------------
	------------------- UK ----------------------
	---------------------------------------------
	[US_TO_UK] = {
		Name = "New York to UK",
		SpawnList = { {X=156, Y=65} },
		Frequency = 20, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=9, Y=75}, {X=9, Y=79} }, -- Liverpool, Edinburgh
		CivID = ENGLAND, -- Route owner
		MaxConvoysOnRoute = 4, -- how many convoy can use that route at the same time
		Condition = CheckUSEastConvoys, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetLendLeaseCargo, -- Must refer to a function, remove this line to use the default function
	},
	[HONGKONG_TO_UK] = {
		Name = "Hong Kong to UK",
		SpawnList = { {X=83, Y=47} },
		Frequency = 15, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=9, Y=74}, {X=9, Y=79} }, -- Liverpool, Edinburgh
		CivID = ENGLAND, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsHongKongAlly, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetHongKongCargo, -- Must refer to a function, remove this line to use the default function
	},
	---------------------------------------------
	----------------- U.S.S.R -------------------
	---------------------------------------------
	[UK_TO_USSR] = {
		Name = "Liverpool to Murmansk",
		SpawnList = { {X=8, Y=75} },
		Frequency = 10, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=34, Y=89} }, -- Murmansk
		CivID = USSR, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = CheckUKConvoys, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetLendLeaseCargo, -- Must refer to a function, remove this line to use the default function
	},
	[US_TO_USSR_ARCTIC] = {
		Name = "New York to Murmansk",
		SpawnList = { {X=156, Y=65} },
		Frequency = 30, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=34, Y=89} }, -- Murmansk
		CivID = USSR, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = CheckUSEastConvoys, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetLendLeaseCargo, -- Must refer to a function, remove this line to use the default function
	},
	[US_TO_USSR_FAR_EAST] = {
		Name = "California to Vladivostok",
		SpawnList = { {X=130, Y=64} },
		Frequency = 20, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=94, Y=69} }, -- Vladivostok
		CivID = USSR, -- Route owner
		MaxConvoysOnRoute = 2, -- how many convoy can use that route at the same time
		Condition = CheckUSWestConvoys, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetLendLeaseCargo, -- Must refer to a function, remove this line to use the default function
	},
	[US_TO_USSR_PERSIAN] = {
		Name = "New York to Persian Gulf",
		SpawnList = { {X=156, Y=65} },
		Frequency = 30, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=42, Y=48} }, -- Iran
		CivID = USSR, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsRailroadOpenBandarToStalingrad, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetLendLeaseCargo, -- Must refer to a function, remove this line to use the default function
	},
	---------------------------------------------
	----------------- FRANCE --------------------
	---------------------------------------------
	[US_TO_FRANCE] = {
		Name = "New York to Brest",
		SpawnList = { {X=156, Y=65} },
		Frequency = 30, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=7, Y=67} }, -- Brest
		CivID = FRANCE, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = CheckUSEastConvoys, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetLendLeaseCargo, -- Must refer to a function, remove this line to use the default function
	},	
	[SAIGON_TO_FRANCE] = {
		Name = "Saigon to Brest",
		SpawnList = { {X=80, Y=38} },
		Frequency = 20, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=7, Y=67} }, -- Brest
		CivID = FRANCE, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsSaigonAlly, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetSaigonCargo, -- Must refer to a function, remove this line to use the default function
	},
	---------------------------------------------
	----------------- AMERICA -------------------
	---------------------------------------------
	[PANAMA_TO_US] = {
		Name = "Panama to New York",
		SpawnList = { {X=150, Y=41} },
		Frequency = 20, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=155, Y=65} }, -- New York
		CivID = AMERICA, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsPanamaAlly, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetPanamaCargo, -- Must refer to a function, remove this line to use the default function
	},
	[MANILLA_TO_US] = {
		Name = "Manilla to New York",
		SpawnList = { {X=88, Y=41} },
		Frequency = 20, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=155, Y=65} }, -- New York
		CivID = AMERICA, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsManillaAlly, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetManillaCargo, -- Must refer to a function, remove this line to use the default function
	},
	---------------------------------------------
	----------------- GERMANY -------------------
	---------------------------------------------
	[NORWAY_TO_GERMANY] = {
		Name = "Narvik to Kiel",
		SpawnList = { {X=22, Y=89} },
		Frequency = 25, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=19, Y=73}, {X=19, Y=72}, }, -- Keil, Hamburg
		CivID = GERMANY, -- Route owner
		MaxConvoysOnRoute = 3, -- how many convoy can use that route at the same time
		Condition = IsRailroadOpenLuleaToNarvik, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetScandanavianCargo, -- Must refer to a function, remove this line to use the default function
	},
	[SWEDEN_TO_GERMANY] = {
		Name = "Lulea to Kiel",
		SpawnList = { {X=26, Y=85} },
		Frequency = 50, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=26, Y=73}, {X=23, Y=73}, {X=19, Y=73}, }, -- Keil, Danzig, Konigsberg
		CivID = GERMANY, -- Route owner
		MaxConvoysOnRoute = 3, -- how many convoy can use that route at the same time
		Condition = IsNotWinter, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetScandanavianCargo, -- Must refer to a function, remove this line to use the default function
	},
	---------------------------------------------
	----------------- JAPAN ---------------------
	---------------------------------------------
	[HONGKONG_TO_JAPAN] = {
		Name = "Hong kong to Tokyo",
		SpawnList = { {X=83, Y=47} },
		Frequency = 10, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=97, Y=58} }, -- Tokyo
		CivID = JAPAN, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsHongKongPuppet, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetHongKongCargo, -- Must refer to a function, remove this line to use the default function
	},
	[MANILLA_TO_JAPAN] = {
		Name = "Manilla to Tokyo",
		SpawnList = { {X=88, Y=41} },
		Frequency = 10, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=97, Y=58} }, -- Tokyo
		CivID = JAPAN, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsManillaPuppet, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetManillaCargo, -- Must refer to a function, remove this line to use the default function
	},	
	[SAIGON_TO_JAPAN] = {
		Name = "Saigon to Japan",
		SpawnList = { {X=80, Y=38} },
		Frequency = 10, -- probability (in percent) of convoy spawning at each turn
		DestinationList = { {X=97, Y=58} }, -- Tokyo
		CivID = JAPAN, -- Route owner
		MaxConvoysOnRoute = 1, -- how many convoy can use that route at the same time
		Condition = IsSaigonPuppet, -- Must refer to a function, remove this line to use the default condition (true)
		Cargo = GetSaigonCargo, -- Must refer to a function, remove this line to use the default function
	},
}

------------------------------------------------------------------------------
--Unload and maintain convoys
------------------------------------------------------------------------------
function FinalizeConvoy(iUnit, iPlayer, iX, iY)
	local player = Players [ iPlayer ]
	
	print("A Convoy has reached it's destination!")
	local loadData = LoadConvoyDB("SELECT * FROM Convoys WHERE Player = ? AND Unit = ? ", iPlayer, iUnit)

	local transportType = loadData.Type
	local transportReference = loadData.Reference
	
	local plot = Map.GetPlot(iX, iY)
	local strDestination = ""
	if plot:IsCity() then
		local city = plot:GetPlotCity()
		strDestination = city:GetName()
	else
		strDestination = " plot (".. iX .."," .. iY ..")"
	end
	
	if transportType == TRANSPORT_MATERIEL then
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Convoy has reached " .. strDestination .. ", delivering " .. transportReference .." materiel", "Convoy unloading at " .. strDestination .." !", iX, iY)
		print("      - was transporting ".. transportReference .." materiel")
		player:ChangeYield(YieldTypes.YIELD_MATERIEL, transportReference)

	elseif transportType == TRANSPORT_PERSONNEL then
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Convoy has reached " .. strDestination .. ", delivering " .. transportReference .." personnel", "Convoy unloading at " .. strDestination .." !", iX, iY)
		print("      - was transporting ".. transportReference .." personnel")
		player:ChangeYield(YieldTypes.YIELD_PERSONNEL, transportReference)

	elseif transportType == TRANSPORT_FUEL then
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Convoy has reached " .. strDestination .. ", delivering " .. transportReference .." fuel", "Convoy unloading at " .. strDestination .." !", iX, iY)
		print("      - was transporting ".. transportReference .." oil")
		player:ChangeYield(YieldTypes.YIELD_FUEL, transportReference)

	elseif transportType == TRANSPORT_UNIT then 
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Convoy has reached " .. strDestination .. ", delivering an equiped unit", "Convoy unloading at " .. strDestination .." !", iX, iY)
		print("      - was transporting an unit")
		player:InitUnit(transportReference, x, y)

	elseif transportType == TRANSPORT_GOLD then 
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Convoy has reached " .. strDestination .. ", delivering " .. transportReference .." gold", "Convoy unloading at " .. strDestination .." !", iX, iY)
		print("      - was transporting ".. transportReference .." gold")
		player:ChangeGold(transportReference)
	else
		print("      - WARNING: unknown cargo type !")
	end
	
	SaveConvoyDB("DELETE FROM Convoys WHERE Unit = ? AND Player = ?", iUnit, iPlayer)
end
GameEvents.FinalizeConvoy.Add(FinalizeConvoy)

function UpdateConvoyDestination(iUnit, iPlayer)
	local player = Players [ iPlayer ]
	local unit = player:GetUnitByID(iUnit)
	
	local loadData = LoadConvoyDB("SELECT * FROM Convoys WHERE Player = ? AND Unit = ? ", iPlayer, iUnit)

	local objPlot = false
	
	for i, destination in ipairs(g_Convoy[loadDate.RouteID].DestinationList) do
		local destPlot = Map.GetPlot(destination.X, destination.Y)
		if destPlot and not objPlot then
			objPlot = CheckConvoyDestination(playerID, destPlot)
		end
	end		
	
	if objPlot then
		local strDestination = ""
		if objPlot:IsCity() then
			local city = objPlot:GetPlotCity()
			strDestination = city:GetName()
		else
			strDestination = " plot (".. objPlot:GetX() .."," .. objPlot:GetY() ..")";
		end
		
		print("Convoy has been redirected!")
		unit:SetConvoyPlot(objPlot)
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "A Convoy has been redirected to " .. strDestination, "Convoy redirected !", objPlot:GetX(), objPlot:GetY())
	else
		print("Removing convoy as no valid destination!")
		player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "A Convoy got destroyed as it has no valid destinations", "Convoy was destroyed", -1, -1)
		SaveConvoyDB("DELETE FROM Convoys WHERE Unit = ? AND Player = ?", iUnit, iPlayer)
	end
end
GameEvents.UpdateConvoyDestination.Add(UpdateConvoyDestination)

function OnConvoyKilled(iPlayer, iUnit) 

	local player = Players[iPlayer]
	local unit = player:GetUnitByID(iUnit)
	if (unit == nil) then
	    return false
	end
	
	if unit:GetUnitType() ~= GameInfoTypes["UNIT_CONVOY"] then
	    return false
	end

	print("Removing convoy from database, as it was captured/destroyed!")
	SaveConvoyDB("DELETE FROM Convoys WHERE Unit = ? AND Player = ?", iUnit, iPlayer)
end
GameEvents.CanSaveUnit.Add(OnUnitKilled)
