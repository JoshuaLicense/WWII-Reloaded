-------------------------------
-- TopPanel.lua
-- coded by bc1 from Civ V 1.0.3.276 code
-- code is common using gk_mode and bnw_mode switches
-- compatible with Putmalk's Civ IV Diplomacy Features Mod v10
-- compatible with Gazebo's City-State Diplomacy Mod (CSD) for Brave New World v 23
-------------------------------
include( "EUI_utilities" )

Events.SequenceGameInitComplete.Add(function()
print( "Loading EUI top panel",ContextPtr,os.clock(), [[ 
 _____           ____                  _
|_   _|__  _ __ |  _ \ __ _ _ __   ___| |
  | |/ _ \| '_ \| |_) / _` | '_ \ / _ \ |
  | | (_) | |_) |  __/ (_| | | | |  __/ |
  |_|\___/| .__/|_|   \__,_|_| |_|\___|_|
          |_|
]])
local civ5_mode = InStrategicView ~= nil
local civBE_mode = not civ5_mode
local gk_mode = Game.GetReligionName ~= nil
local bnw_mode = Game.GetActiveLeague ~= nil
local civ5bnw_mode = civ5_mode and bnw_mode

-------------------------------
-- minor lua optimizations
-------------------------------
local math_ceil = math.ceil
local math_cos = math.cos
local math_floor = math.floor
local math_max = math.max
local math_min = math.min
local math_pi = math.pi
local math_sin = math.sin
local os_date = os.date
local os_time = os.time
local pairs = pairs
local tonumber = tonumber
local S = string.format

--EUI_utilities
local IconHookup = EUI.IconHookup
local CityPlots = EUI.CityPlots
local PopScratchDeal = EUI.PopScratchDeal
local PushScratchDeal = EUI.PushScratchDeal
local table = EUI.table
local YieldIcons = EUI.YieldIcons
local YieldNames = EUI.YieldNames
local GreatPeopleIcon = EUI.GreatPeopleIcon
local GameInfo = EUI.GameInfoCache -- warning! use iterator ONLY with table field conditions, NOT string SQL query
local GetHelpTextForAffinity
if civBE_mode then
	include( "EUI_tooltips" )
	GetHelpTextForAffinity = EUI.GetHelpTextForAffinity
end

local ButtonPopupTypes = ButtonPopupTypes
local ContextPtr = ContextPtr
local Controls = Controls
local DomainTypes = DomainTypes
local Events = Events
local FaithPurchaseTypes = FaithPurchaseTypes
local Game = Game
local GameDefines = GameDefines
local GameInfoTypes = GameInfoTypes
local GameOptionTypes = GameOptionTypes
local L = Locale.ConvertTextKey
local Locale = Locale
local Mouse = Mouse
local OptionsManager = OptionsManager
local OrderTypes = OrderTypes
local Players = Players
local PreGame = PreGame
local ResourceUsageTypes = ResourceUsageTypes
local Teams = Teams
local TradeableItems = TradeableItems
local UI = UI
local YieldTypes = YieldTypes

-------------------------------
-- Globals
-------------------------------

local g_activePlayerID, g_activePlayer, g_activeTeamID, g_activeTeam, g_activeCivilizationID, g_activeCivilization, g_activeTeamTechs

local g_isBasicHelp, g_isScienceEnabled, g_isPoliciesEnabled, g_isHappinessEnabled, g_isReligionEnabled, g_isHealthEnabled

local g_deal = UI.GetScratchDeal()
local g_resourceString = {}
local g_isSmallScreen = UIManager:GetScreenSizeVal() < (civ5bnw_mode and 1900 or 1600)
local g_isPopupUp = false
local g_requestTopPanelUpdate, g_requestToolTipControl, g_requestToolTipFunction
local g_toolTipHandler = {}

local g_options = Modding.OpenUserData( "Enhanced User Interface Options", 1)
local g_clockFormats = { "%H:%M", "%I:%M %p", "%X", "%c" }
local g_clockFormat, g_alarmTime
local g_startTurn = Game.GetStartTurn()

local g_scienceTextColor = civ5_mode and "[COLOR:33:190:247:255]" or "[COLOR_MENU_BLUE]"
local g_currencyIcon = civ5_mode and "[ICON_GOLD]" or "[ICON_ENERGY]"
local g_currencyString = civ5_mode and "GOLD" or "ENERGY"
--local g_happinessIcon = civ5_mode and "[ICON_HAPPY]" or "[ICON_HEALTH]"
local g_happinessString = civ5_mode and "HAPPINESS" or "HEALTH"

local textTipControls = {}
local tipControls = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", textTipControls )
TTManager:GetTypeControlTable( "EUI_TopPanelProgressTooltip", tipControls )
local g_luxuries = table()
for resource in GameInfo.Resources() do
	if Game.GetResourceUsageType(resource.ID) == ResourceUsageTypes.RESOURCEUSAGE_LUXURY then
		g_luxuries:insert( resource )
	end
end
g_luxuries:sort( function(a,b) return Locale.Compare( a.Description, b.Description ) == -1 end )
-------------------------------
-- Utilities
-------------------------------
local function GamePopup( popupType, data2 )
	Events.SerialEventGameMessagePopup{ Type = popupType, Data1 = 1, Data2 = data2 }
end
local GamePedia = Events.SearchForPediaEntry

local function Colorize( x )
	if x > 0 then
		return "[COLOR_POSITIVE_TEXT]" .. x .. "[ENDCOLOR]"
	elseif x < 0 then
		return "[COLOR_WARNING_TEXT]" .. x .. "[ENDCOLOR]"
	else
		return "0"
	end
end
local function ColorizeSigned( x )
	if x > 0 then
		return "[COLOR_POSITIVE_TEXT]+" .. x .. "[ENDCOLOR]"
	elseif x < 0 then
		return "[COLOR_WARNING_TEXT]" .. x .. "[ENDCOLOR]"
	else
		return "0"
	end
end
local function ColorizeAbs( x )
	if x > 0 then
		return "[COLOR_POSITIVE_TEXT]" .. x .. "[ENDCOLOR]"
	elseif x < 0 then
		return "[COLOR_WARNING_TEXT]" .. -x .. "[ENDCOLOR]"
	else
		return "0"
	end
end
local function requestToolTip( control )
	tipControls.Box:SetHide( false )
	g_requestToolTipControl = control
end
local function requestTextToolTip( control )
	textTipControls.TopPanelMouseover:SetHide( false )
	g_requestToolTipControl = control
end
local function setTextToolTip( tipText )
	textTipControls.TooltipLabel:SetText( tipText )
	return textTipControls.TopPanelMouseover:DoAutoSize()
end

-------------------------------------------------
-- Top Panel Update
-------------------------------------------------

local function UpdateTopPanelNow()

	g_requestTopPanelUpdate = false

	-----------------------------
	-- Update Resources
	-----------------------------

	for resourceID, resourceInstance in pairs( g_resourceString ) do
		local resource = GameInfo.Resources[ resourceID ]

		local numResourceUsed = g_activePlayer:GetNumResourceUsed( resourceID )

		if numResourceUsed > 0
			or ( g_activeTeamTechs:HasTech(GameInfoTypes[resource.TechReveal])
			and ( civBE_mode or g_activeTeamTechs:HasTech(GameInfoTypes[resource.TechCityTrade]) ) )
		then
			resourceInstance:SetText( Colorize( g_activePlayer:GetNumResourceAvailable(resourceID, true) ) .. resource.IconString )
		else
			resourceInstance:SetText( "" )
		end
	end

	-----------------------------
	-- Update turn counter
	-----------------------------
	local gameTurn = Game.GetGameTurn()
	if g_startTurn > 0 then
		gameTurn = gameTurn .. "("..(gameTurn-g_startTurn)..")"
	end
	Controls.CurrentTurn:LocalizeAndSetText( "TXT_KEY_TP_TURN_COUNTER", gameTurn )

	local culturePerTurn, cultureProgress

	if civ5_mode then
		-- Clever Firaxis...
		culturePerTurn = g_activePlayer:GetTotalJONSCulturePerTurn()
		cultureProgress = g_activePlayer:GetJONSCulture()
		
		-----------------------------
		-- Update yields
		-----------------------------
		Controls.PersonnelPerTurn:LocalizeAndSetText( "TXT_KEY_TOP_PANEL_PERSONNEL", g_activePlayer:GetYield(YieldTypes.YIELD_PERSONNEL), g_activePlayer:GetYieldPerTurn(YieldTypes.YIELD_PERSONNEL) - g_activePlayer:GetRequiredYield(YieldTypes.YIELD_PERSONNEL, true, true) )

		Controls.MaterielPerTurn:LocalizeAndSetText( "TXT_KEY_TOP_PANEL_MATERIEL", g_activePlayer:GetYield(YieldTypes.YIELD_MATERIEL), g_activePlayer:GetYieldPerTurn(YieldTypes.YIELD_MATERIEL) - g_activePlayer:GetRequiredYield(YieldTypes.YIELD_MATERIEL, true, true) )

		Controls.FuelPerTurn:LocalizeAndSetText( "TXT_KEY_TOP_PANEL_FUEL", g_activePlayer:GetYield(YieldTypes.YIELD_FUEL), g_activePlayer:GetYieldPerTurn(YieldTypes.YIELD_FUEL) - g_activePlayer:GetRequiredYield(YieldTypes.YIELD_FUEL, false, true) )
		
		-----------------------------
		-- Update gold stats
		-----------------------------

		Controls.GoldPerTurn:LocalizeAndSetText( "TXT_KEY_TOP_PANEL_GOLD", g_activePlayer:GetGold(), g_activePlayer:CalculateGoldRate() )
		
		-----------------------------
		-- Update Alerts
		-----------------------------

		local unitsSupplyProductionModifier = g_activePlayer:GetUnitProductionMaintenanceMod()
		local unitsSupplied = g_activePlayer:GetNumUnitsSupplied()
		
		local unitsTotal = g_activePlayer:GetNumUnits()
		local unitsFromCities = g_activePlayer:GetNumUnitsSuppliedByCities()
		local unitsFromPopulation = g_activePlayer:GetNumUnitsSuppliedByPopulation()
		local unitsFromHandicap = g_activePlayer:GetNumUnitsSuppliedByHandicap()
		
		if unitsSupplyProductionModifier < 0	then
			local tips = table()
			local unitsOver = g_activePlayer:GetNumUnitsOutOfSupply()

			tips:insert( L("TXT_KEY_UNIT_SUPPLY_REACHED_TOOLTIP", unitsSupplied, unitsOver, unitsSupplyProductionModifier, unitsFromCities, unitsFromPopulation, unitsFromHandicap) )
			
			Controls.WarningString:SetText( "[ICON_STRENGTH] " .. L( "TXT_KEY_UNIT_SUPPLY_REACHED", unitSupplyProductionModifier ) )

			Controls.WarningString:SetToolTipString( tips:concat( "[NEWLINE][NEWLINE]" ) )
			Controls.WarningString:SetHide(false)
			--Controls.UnitSupplyString:SetHide(false)
		else
			local tips = table()
			local unitsLeft = unitsSupplied - unitsTotal
			
			tips:insert( L("TXT_KEY_UNIT_SUPPLY_TOOLTIP", unitsSupplied, unitsTotal, unitsFromCities, unitsFromPopulation, unitsFromHandicap ) )

			Controls.WarningString:SetText( "[ICON_STRENGTH] " .. L( "TXT_KEY_UNIT_SUPPLY", unitsLeft ) )

			Controls.WarningString:SetToolTipString( tips:concat( "[NEWLINE][NEWLINE]" ) )
			Controls.WarningString:SetHide(false)
			--Controls.UnitSupplyString:SetHide(false)
		end

		-----------------------------
		-- Update date
		-----------------------------
		local date = Game.GetTurnString()

		Controls.CurrentDate:SetText( date )
	else
		-----------------------------
		-- Update affinity status
		-----------------------------
		Controls.Purity:LocalizeAndSetText( "TXT_KEY_AFFINITY_STATUS", GameInfo.Affinity_Types.AFFINITY_TYPE_PURITY.IconString, g_activePlayer:GetAffinityLevel( GameInfoTypes.AFFINITY_TYPE_PURITY ) )
		local percentToNextPurityLevel = g_activePlayer:GetAffinityPercentTowardsNextLevel( GameInfoTypes.AFFINITY_TYPE_PURITY )
		if g_activePlayer:GetAffinityPercentTowardsMaxLevel( GameInfoTypes.AFFINITY_TYPE_PURITY ) >= 100 then
			percentToNextPurityLevel = 100
		end
		Controls.PurityProgressBar:Resize(5, math_floor((percentToNextPurityLevel/100)*30))

		Controls.Harmony:LocalizeAndSetText( "TXT_KEY_AFFINITY_STATUS", GameInfo.Affinity_Types.AFFINITY_TYPE_HARMONY.IconString, g_activePlayer:GetAffinityLevel( GameInfoTypes.AFFINITY_TYPE_HARMONY ) )
		local percentToNextHarmonyLevel = g_activePlayer:GetAffinityPercentTowardsNextLevel( GameInfoTypes.AFFINITY_TYPE_HARMONY )
		if g_activePlayer:GetAffinityPercentTowardsMaxLevel( GameInfoTypes.AFFINITY_TYPE_HARMONY ) >= 100 then
			percentToNextHarmonyLevel = 100
		end
		Controls.HarmonyProgressBar:Resize(5, math_floor((percentToNextHarmonyLevel/100)*30))

		Controls.Supremacy:LocalizeAndSetText( "TXT_KEY_AFFINITY_STATUS", GameInfo.Affinity_Types.AFFINITY_TYPE_SUPREMACY.IconString, g_activePlayer:GetAffinityLevel( GameInfoTypes.AFFINITY_TYPE_SUPREMACY ) )
		local percentToNextSupremacyLevel = g_activePlayer:GetAffinityPercentTowardsNextLevel( GameInfoTypes.AFFINITY_TYPE_SUPREMACY )
		if g_activePlayer:GetAffinityPercentTowardsMaxLevel( GameInfoTypes.AFFINITY_TYPE_SUPREMACY ) >= 100 then
			percentToNextSupremacyLevel = 100
		end
		Controls.SupremacyProgressBar:Resize(5, math_floor((percentToNextSupremacyLevel/100)*30))

		-----------------------------
		-- Update energy stats
		-----------------------------

		Controls.GoldPerTurn:LocalizeAndSetText( "TXT_KEY_TOP_PANEL_ENERGY", g_activePlayer:GetEnergy(), g_activePlayer:CalculateGoldRate() )

		-----------------------------
		-- Update Health
		-----------------------------
		if g_isHealthEnabled then
			local excessHealth = g_activePlayer:GetExcessHealth()
			if excessHealth < 0 then
				Controls.HealthString:SetText( S("[COLOR_RED]%i[ENDCOLOR][ICON_HEALTH_3]", -excessHealth) )
			else
				Controls.HealthString:SetText( S("[COLOR_GREEN]%i[ENDCOLOR][ICON_HEALTH_1]", excessHealth) )
			end
--				SetAutoWidthGridButton( Controls.HealthString, strHealth, BUTTON_PADDING )
		end

		-- Clever Firaxis...
		culturePerTurn = g_activePlayer:GetTotalCulturePerTurn()
		cultureProgress = g_activePlayer:GetCulture()
	end

	-----------------------------
	-- Update Culture
	-----------------------------

	if g_isPoliciesEnabled then

		local cultureTheshold = g_activePlayer:GetNextPolicyCost()
		local cultureProgressNext = cultureProgress + culturePerTurn
		local turnsRemaining = ""

		if cultureTheshold > 0 then
			Controls.CultureBar:SetPercent( cultureProgress / cultureTheshold )
			Controls.CultureBarShadow:SetPercent( cultureProgressNext / cultureTheshold )
			if culturePerTurn > 0 then
				turnsRemaining = math_ceil((cultureTheshold - cultureProgress) / culturePerTurn )
			end
			Controls.CultureBox:SetHide(false)
		else
			Controls.CultureBox:SetHide(true)
		end

		Controls.CultureTurns:SetText(turnsRemaining)
		Controls.CultureString:SetText( S("[COLOR_MAGENTA]+%i[ENDCOLOR][ICON_CULTURE]", culturePerTurn ) )
	end

	Controls.TopPanelInfoStack:CalculateSize()
	Controls.TopPanelDiploStack:CalculateSize()
	Controls.TopPanelInfoStack:ReprocessAnchoring()
	Controls.TopPanelDiploStack:ReprocessAnchoring()
	Controls.TopPanelBarL:SetSizeX( Controls.TopPanelInfoStack:GetSizeX() + 15 )
	Controls.TopPanelBarR:SetSizeX( Controls.TopPanelDiploStack:GetSizeX() + 15 )
end

---------------
-- Civilopedia
---------------
Controls.CivilopediaButton:RegisterCallback( Mouse.eLClick, function() GamePedia( "" ) end )

---------------
-- Menu
---------------
Controls.MenuButton:RegisterCallback( Mouse.eLClick,
function()
	return UIManager:QueuePopup( LookUpControl( "/InGame/GameMenu" ), PopupPriority.InGameMenu )
end)

local function SetMark( line, size, percent, label, text )
	local r0 = size/2
	local r1 = size * 0.43
	local r2 = size * 0.47
	local angle = percent * math_pi * 2
	local x = math_sin( angle )
	local y = -math_cos( angle )
	line:SetEndVal( r1 * x + r0, r1 * y + r0 )
	label:SetOffsetVal( r2 * x, r2 * y )
	label:SetText( text )
end

-------------------------------------------------
-- Personnel Tooltip & Click Actions
-------------------------------------------------
g_toolTipHandler.PersonnelPerTurn = function()-- control )

	local tips = table()
	
	local iYield = YieldTypes.YIELD_PERSONNEL;
	local iTotalYield = g_activePlayer:GetYield(iYield)
	
	local iBaseYieldPerTurn = g_activePlayer:GetBaseYieldPerTurn(iYield)
	local iPerTurnFromCities = g_activePlayer:GetYieldPerTurnFromCities(iYield)
	local iPerTurnFromMinors = g_activePlayer:GetYieldPerTurnFromMinorCivs(iYield)
	local iPerTurnFromTraits = g_activePlayer:GetYieldPerTurnFromTraits(iYield)
	
	local iTotalIncome = iPerTurnFromCities + iPerTurnFromMinors + iPerTurnFromTraits;
	
	local iYieldPerTurn = g_activePlayer:GetYieldPerTurn(iYield) -- after deductions
	
	tips:insertLocalized( "TXT_KEY_TP_AVAILABLE_PERSONNEL", iTotalYield ) 
	tips:insert( "" )

	-- Income
	tips:insert( "[COLOR_WHITE]" )
	tips:insertLocalized( "TXT_KEY_TP_PERSONNEL_PER_TURN", iBaseYieldPerTurn )
	
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_PERSONNEL_FROM_CITY", iPerTurnFromCities )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_PERSONNEL_FROM_MINOR", iPerTurnFromMinors )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_PERSONNEL_FROM_TRAIT", iPerTurnFromTraits )
	
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_PERSONNEL_FROM_UNCATEGORIZED", iBaseYieldPerTurn - iTotalIncome )
	tips:insert( "[ENDCOLOR]" )

	-- Spending

	tips:insert( "[COLOR:255:150:150:255]" )
	tips:insertLocalized( "TXT_KEY_TP_UNIT_HEALING", g_activePlayer:GetRequiredYield(iYield, true, true) )
	tips:insert( "[ENDCOLOR]" )

	-- Basic explanation

	if g_isBasicHelp then
		tips:insert( "" )
		tips:insertLocalized( L"TXT_KEY_PERSONNEL_HELP_INFO" )
	end
	
	return setTextToolTip( tips:concat( "[NEWLINE]" ) )
end
Controls.PersonnelPerTurn:RegisterCallback( Mouse.eLClick, function() GamePopup( ButtonPopupTypes.BUTTONPOPUP_MILITARY_OVERVIEW ) end )
Controls.PersonnelPerTurn:RegisterCallback( Mouse.eRClick, function() GamePedia( S("TXT_KEY_%s_HEADING1_TITLE", g_currencyString) ) end )
Controls.PersonnelPerTurn:SetToolTipCallback( requestTextToolTip )

-------------------------------------------------
-- Materiel Tooltip & Click Actions
-------------------------------------------------
g_toolTipHandler.MaterielPerTurn = function()-- control )

	local tips = table()
	
	local iYield = YieldTypes.YIELD_MATERIEL;
	local iTotalYield = g_activePlayer:GetYield(iYield)
	
	local iBaseYieldPerTurn = g_activePlayer:GetBaseYieldPerTurn(iYield)
	local iPerTurnFromCities = g_activePlayer:GetYieldPerTurnFromCities(iYield)
	local iPerTurnFromMinors = g_activePlayer:GetYieldPerTurnFromMinorCivs(iYield)
	local iPerTurnFromTraits = g_activePlayer:GetYieldPerTurnFromTraits(iYield)
	
	local iTotalIncome = iPerTurnFromCities + iPerTurnFromMinors + iPerTurnFromTraits;
	
	local iYieldPerTurn = g_activePlayer:GetYieldPerTurn(iYield) -- after deductions
	
	tips:insertLocalized( "TXT_KEY_TP_AVAILABLE_MATERIEL", iTotalYield ) 
	tips:insert( "" )

	-- Income
	tips:insert( "[COLOR_WHITE]" )
	tips:insertLocalized( "TXT_KEY_TP_MATERIEL_PER_TURN", iBaseYieldPerTurn )
	
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_MATERIEL_FROM_CITY", iPerTurnFromCities )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_MATERIEL_FROM_MINOR", iPerTurnFromMinors )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_MATERIEL_FROM_TRAIT", iPerTurnFromTraits )
	
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_MATERIEL_FROM_UNCATEGORIZED", iBaseYieldPerTurn - iTotalIncome )
	tips:insert( "[ENDCOLOR]" )

	-- Spending

	tips:insert( "[COLOR:255:150:150:255]" )
	tips:insertLocalized( "TXT_KEY_TP_UNIT_HEALING", g_activePlayer:GetRequiredYield(iYield, true, true) )
	tips:insert( "[ENDCOLOR]" )

	-- Basic explanation

	if g_isBasicHelp then
		tips:insert( "" )
		tips:insertLocalized( L"TXT_KEY_MATERIEL_HELP_INFO" )
	end
	
	return setTextToolTip( tips:concat( "[NEWLINE]" ) )
end
Controls.MaterielPerTurn:RegisterCallback( Mouse.eLClick, function() GamePopup( ButtonPopupTypes.BUTTONPOPUP_MILITARY_OVERVIEW ) end )
Controls.MaterielPerTurn:RegisterCallback( Mouse.eRClick, function() GamePedia( S("TXT_KEY_%s_HEADING1_TITLE", g_currencyString) ) end )
Controls.MaterielPerTurn:SetToolTipCallback( requestTextToolTip )

-------------------------------------------------
-- Fuel Tooltip & Click Actions
-------------------------------------------------
g_toolTipHandler.FuelPerTurn = function()-- control )

	local tips = table()
	
	local iYield = YieldTypes.YIELD_FUEL;
	local iTotalYield = g_activePlayer:GetYield(iYield)
	
	local iBaseYieldPerTurn = g_activePlayer:GetBaseYieldPerTurn(iYield)
	local iPerTurnFromCities = g_activePlayer:GetYieldPerTurnFromCities(iYield)
	local iPerTurnFromMinors = g_activePlayer:GetYieldPerTurnFromMinorCivs(iYield)
	local iPerTurnFromTraits = g_activePlayer:GetYieldPerTurnFromTraits(iYield)
	
	local iTotalIncome = iPerTurnFromCities + iPerTurnFromMinors + iPerTurnFromTraits;
	local iTotalExpenditure = g_activePlayer:GetRequiredYield(iYield, false, true)
	
	local iYieldPerTurn = g_activePlayer:GetYieldPerTurn(iYield) -- after deductions
	
	tips:insertLocalized( "TXT_KEY_TP_AVAILABLE_FUEL", iTotalYield ) 
	tips:insert( "" )

	-- Income
	tips:insert( "[COLOR_WHITE]" )
	tips:insertLocalized( "TXT_KEY_TP_FUEL_PER_TURN", iBaseYieldPerTurn )
	
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_FUEL_FROM_CITY", iPerTurnFromCities )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_FUEL_FROM_MINOR", iPerTurnFromMinors )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_FUEL_FROM_TRAIT", iPerTurnFromTraits )
	
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_FUEL_FROM_UNCATEGORIZED", iBaseYieldPerTurn - iTotalIncome )
	tips:insert( "[ENDCOLOR]" )

	-- Spending

	tips:insert( "[COLOR:255:150:150:255]" )
	tips:insertLocalized( "TXT_KEY_TP_UNIT_MAINTENANCE", iTotalExpenditure )
	tips:insert( "[ENDCOLOR]" )

	tips:insert( "" );
	if g_activePlayer:GetYield(YieldTypes.YIELD_FUEL) > GameDefines.LIGHT_FUEL_RATIONING or not g_activePlayer:IsAtWar() then
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CURRENT", "None" )

	elseif g_activePlayer:GetYield(YieldTypes.YIELD_FUEL) > GameDefines.MEDIUM_FUEL_RATIONING then
		tips:insert( "[COLOR:255:255:60:255]" )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CURRENT", "Light" )
		tips:insert( "[ENDCOLOR]" )
		
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_MOVEMENT", (100 - GameDefines.LIGHT_RATIONING_MOVES) )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CONSUMPTION", (100 - GameDefines.LIGHT_RATIONING_CONSUMPTION) )
	
		tips:insert( "" )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_SAVED", (iTotalExpenditure * GameDefines.LIGHT_RATIONING_CONSUMPTION / 100) )
	elseif g_activePlayer:GetYield(YieldTypes.YIELD_FUEL) > GameDefines.HEAVY_FUEL_RATIONING then
		tips:insert( "[COLOR:255:155:60:255]" )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CURRENT", "Medium" )
		tips:insert( "[ENDCOLOR]" )
		
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_MOVEMENT", (100 - GameDefines.MEDIUM_RATIONING_MOVES) )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CONSUMPTION", (100 - GameDefines.MEDIUM_RATIONING_CONSUMPTION) )
	
		tips:insert( "" )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_SAVED", (iTotalExpenditure * GameDefines.MEDIUM_RATIONING_CONSUMPTION / 100) )
	else
		tips:insert( "[COLOR:255:60:60:255]" )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CURRENT", "Heavy" )
		tips:insert( "[ENDCOLOR]" )
		
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_MOVEMENT", (100 - GameDefines.HEAVY_RATIONING_MOVES) )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_CONSUMPTION", (100 - GameDefines.HEAVY_RATIONING_CONSUMPTION) )
	
		tips:insert( "" )
		tips:insertLocalized( "TXT_KEY_TP_RATIONING_SAVED", math.floor(iTotalExpenditure * GameDefines.HEAVY_RATIONING_CONSUMPTION / 100) )
	end	
	
	-- Basic explanation
	if g_isBasicHelp then
		tips:insert( "" )
		tips:insertLocalized( L"TXT_KEY_FUEL_HELP_INFO" )
	end
	
	return setTextToolTip( tips:concat( "[NEWLINE]" ) )
end
Controls.FuelPerTurn:RegisterCallback( Mouse.eLClick, function() GamePopup( ButtonPopupTypes.BUTTONPOPUP_MILITARY_OVERVIEW ) end )
Controls.FuelPerTurn:RegisterCallback( Mouse.eRClick, function() GamePedia( S("TXT_KEY_%s_HEADING1_TITLE", g_currencyString) ) end )
Controls.FuelPerTurn:SetToolTipCallback( requestTextToolTip )

-------------------------------------------------
-- Gold Tooltip & Click Actions
-------------------------------------------------
g_toolTipHandler.GoldPerTurn = function()-- control )
	local tips = table()

	local goldPerTurnFromDiplomacy = g_activePlayer:GetGoldPerTurnFromDiplomacy()
	local goldPerTurnFromOtherPlayers = math_max(0,goldPerTurnFromDiplomacy) * 100
	local goldPerTurnToOtherPlayers = -math_min(0,goldPerTurnFromDiplomacy)

	local goldPerTurnFromReligion = gk_mode and g_activePlayer:GetGoldPerTurnFromReligion() * 100 or 0
	local goldPerTurnFromCities = g_activePlayer:GetGoldFromCitiesTimes100()
	local cityConnectionGold = g_activePlayer:GetCityConnectionGoldTimes100()
	local playerTraitGold = 0
	local tradeRouteGold = 0
	local goldPerTurnFromPolicies = 0

	local unitCost = g_activePlayer:CalculateUnitCost()
	local unitSupply = g_activePlayer:CalculateUnitSupply()
	local buildingMaintenance = g_activePlayer:GetBuildingGoldMaintenance()
	local improvementMaintenance = g_activePlayer:GetImprovementGoldMaintenance()
	local vassalMaintenance = g_activePlayer.GetVassalGoldMaintenance and g_activePlayer:GetVassalGoldMaintenance() or 0	-- Compatibility with Putmalk's Civ IV Diplomacy Features Mod
	local routeMaintenance = 0
	local beaconEnergyDelta = 0

	if bnw_mode then
		tradeRouteGold = g_activePlayer:GetGoldFromCitiesMinusTradeRoutesTimes100()
		goldPerTurnFromCities, tradeRouteGold = tradeRouteGold, goldPerTurnFromCities - tradeRouteGold
		playerTraitGold = g_activePlayer:GetGoldPerTurnFromTraits() * 100
		if g_activePlayer:IsAnarchy() then
			tips:insert( L("TXT_KEY_TP_ANARCHY", g_activePlayer:GetAnarchyNumTurns() ) )
			tips:insert( "" )
		end
	end

	-- Total gold
	local totalIncome, totalWealth
	local explicitIncome = goldPerTurnFromCities + goldPerTurnFromOtherPlayers + cityConnectionGold + goldPerTurnFromReligion + tradeRouteGold + playerTraitGold
	if civ5_mode then
		totalWealth = g_activePlayer:GetGold()
		totalIncome = explicitIncome
	else
		totalWealth = g_activePlayer:GetEnergy()
		totalIncome = g_activePlayer:CalculateGrossGoldTimes100() + goldPerTurnToOtherPlayers * 100
		goldPerTurnFromPolicies = g_activePlayer:GetGoldPerTurnFromPolicies()
		explicitIncome = explicitIncome + goldPerTurnFromPolicies
		routeMaintenance = g_activePlayer:GetRouteEnergyMaintenance()
		beaconEnergyDelta = g_activePlayer:GetBeaconEnergyCostPerTurn()
	end
	tips:insert( L( "TXT_KEY_TP_AVAILABLE_GOLD", totalWealth ) )
	local totalExpenses = unitCost + unitSupply + buildingMaintenance + improvementMaintenance + goldPerTurnToOtherPlayers + vassalMaintenance + routeMaintenance + beaconEnergyDelta
	tips:insert( "" )

	-- Gold per turn

	tips:insert( S( "[COLOR_YELLOW]%+g[ENDCOLOR] ", g_activePlayer:CalculateGoldRateTimes100() / 100 ) .. L(S("TXT_KEY_REPLAY_DATA_%sPERTURN", g_currencyString)) )

	-- Income

	tips:insert( "[COLOR_WHITE]" )
	tips:insert( L("TXT_KEY_TP_TOTAL_INCOME", totalIncome / 100 ) )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_CITY_OUTPUT", goldPerTurnFromCities / 100 )

	if bnw_mode then
		tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_FROM_CITY_CONNECTIONS", g_currencyString), cityConnectionGold / 100 )
		tips:insertLocalizedBulletIfNonZero( civ5_mode and "TXT_KEY_TP_GOLD_FROM_ITR" or "TXT_KEY_TP_ENERGY_FROM_TRADE_ROUTES", tradeRouteGold / 100 )
		tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_FROM_TRAITS", g_currencyString), playerTraitGold / 100 )
		tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_ENERGY_FROM_POLICIES", goldPerTurnFromPolicies / 100 )
	else
		tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_FROM_TR", g_currencyString), cityConnectionGold / 100 )
	end

	tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_FROM_OTHERS", g_currencyString), goldPerTurnFromOtherPlayers / 100 )
	tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_FROM_RELIGION", g_currencyString), goldPerTurnFromReligion / 100 )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_YIELD_FROM_UNCATEGORIZED", (totalIncome - explicitIncome) / 100 )
	tips:insert( "[ENDCOLOR]" )

	-- Spending

	tips:insert( "[COLOR:255:150:150:255]" .. L("TXT_KEY_TP_TOTAL_EXPENSES", totalExpenses ) )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_UNIT_MAINT", unitCost )
	tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_UNIT_SUPPLY", g_currencyString), unitSupply )
	tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_BUILDING_MAINT", g_currencyString), buildingMaintenance )
	tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_TILE_MAINT", g_currencyString), improvementMaintenance )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_ENERGY_ROUTE_MAINT", routeMaintenance )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_GOLD_VASSAL_MAINT", vassalMaintenance )	-- Compatibility with Putmalk's Civ IV Diplomacy Features Mod
	tips:insertLocalizedBulletIfNonZero( S("TXT_KEY_TP_%s_TO_OTHERS", g_currencyString), goldPerTurnToOtherPlayers )
	tips:insertLocalizedBulletIfNonZero( "TXT_KEY_TP_ENERGY_TO_BEACON", beaconEnergyDelta )
	tips:insert( "[ENDCOLOR]" )

	-- show gold available for trade to the active player
	local tipIndex = #tips

	for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1 do

		local player = Players[playerID]

		-- Valid player? - Can't be us, has to be alive, and has to be met
		if playerID ~= g_activePlayerID and player:IsAlive() and g_activeTeam:IsHasMet( player:GetTeam() ) then
			tips:insert( "[ICON_BULLET]" .. player:GetName() .. S("  %i%s(%+i)",
					g_deal:GetGoldAvailable(playerID, -1), g_currencyIcon, player:CalculateGoldRate() ) )
		end
	end

	if #tips > tipIndex then
		tips:insert( tipIndex+1, "" )
		tips:insert( tipIndex+2, L"TXT_KEY_EO_RESOURCES_AVAILBLE" )
	end

	-- Basic explanation

	if g_isBasicHelp then
		tips:insert( "" )
		tips:insertLocalized( S("TXT_KEY_TP_%s_EXPLANATION", g_currencyString) )
	end

	return setTextToolTip( tips:concat( "[NEWLINE]" ) )
end
Controls.GoldPerTurn:RegisterCallback( Mouse.eLClick, function() GamePopup( ButtonPopupTypes.BUTTONPOPUP_ECONOMIC_OVERVIEW ) end )
Controls.GoldPerTurn:RegisterCallback( Mouse.eRClick, function() GamePedia( S("TXT_KEY_%s_HEADING1_TITLE", g_currencyString) ) end )
Controls.GoldPerTurn:SetToolTipCallback( requestTextToolTip )

-------------------------------------------------
-- Strategic Resources Tooltips & Click Actions
-------------------------------------------------
local function ResourcesToolTip( control )

	local tips = table()

	-- show resources available to the active player

	local resource = GameInfo.Resources[ control:GetVoid1() ]
	local resourceID = resource and resource.ID
	if resourceID and Game.GetResourceUsageType(resourceID) == ResourceUsageTypes.RESOURCEUSAGE_STRATEGIC then

		local numResourceUsed = g_activePlayer:GetNumResourceUsed( resourceID )

		if numResourceUsed > 0 or
			( g_activeTeamTechs:HasTech( GameInfoTypes[ resource.TechReveal ] ) and
			g_activeTeamTechs:HasTech( GameInfoTypes[ resource.TechCityTrade ] ) )
		then
--			local numResourceTotal = g_activePlayer:GetNumResourceTotal( resourceID, true )	-- true means includes both imports & minors - but exports are deducted regardless
			local numResourceAvailable = g_activePlayer:GetNumResourceAvailable( resourceID, true )	-- same as (total - used)
			local numResourceExport = g_activePlayer:GetResourceExport( resourceID )
			local numResourceImport = g_activePlayer:GetResourceImport( resourceID ) + g_activePlayer:GetResourceFromMinors( resourceID )
			local numResourceLocal = g_activePlayer:GetNumResourceTotal( resourceID, false ) + numResourceExport

			tips:insert( ColorizeAbs(numResourceAvailable) .. resource.IconString .. " " .. Locale.ToUpper(resource.Description) )
			tips:insert( "----------------" )

			----------------------------
			-- Local Resources in Cities
			----------------------------
			tips:insert( "" )
			tips:insert( Colorize(numResourceLocal) .. " " .. L"TXT_KEY_EO_LOCAL_RESOURCES" )

			-- Resources from city terrain
			for city in g_activePlayer:Cities() do
				local numConnectedResource = 0
				local numUnconnectedResource = 0
				for plot in CityPlots( city ) do
					local numResource = plot:GetNumResource()
					if numResource > 0  and resourceID == plot:GetResourceType( g_activeTeamID ) then
						if plot:IsCity() or (not plot:IsImprovementPillaged() and plot:IsResourceConnectedByImprovement( plot:GetImprovementType() )) then
							numConnectedResource = numConnectedResource + numResource
						else
							numUnconnectedResource = numUnconnectedResource + numResource
						end
					end
				end
				local tip = ""
				if numConnectedResource > 0 then
					tip = " " .. ColorizeAbs( numConnectedResource ) .. resource.IconString
				end
				if numUnconnectedResource > 0 then
					tip = tip .. " " .. ColorizeAbs( -numUnconnectedResource ) .. resource.IconString
				end
				if #tip > 0 then
					tips:insert( "[ICON_BULLET]" .. city:GetName() .. tip )
				end
			end
			if gk_mode then
				-- Resources from buildings
				local tipIndex = #tips
				for row in GameInfo.Building_ResourceQuantity{ ResourceType = resource.Type } do
					local building = GameInfo.Buildings[ row.BuildingType ]
					local numResource = row.Quantity
					if building and numResource and numResource > 0 then
						local buildingID = building.ID
						-- count how many such buildings player has
						local numExisting = g_activePlayer:CountNumBuildings( buildingID )
						-- count how many such units player is building
						local numBuilds = 0
						for city in g_activePlayer:Cities() do
							if city:GetProductionBuilding() == buildingID then
								numBuilds = numBuilds + 1
							end
						end
						-- can player build this building someday ?
						local canBuildSomeday
						-- check whether this Unit has been blocked out by the civ XML
						local buildingOverride = GameInfo.Civilization_BuildingClassOverrides{ CivilizationType = g_activeCivilization.Type, BuildingClassType = building.BuildingClass }()
						if buildingOverride then
							canBuildSomeday = buildingOverride.BuildingType == building.Type
						else
							canBuildSomeday = GameInfo.BuildingClasses[ building.BuildingClass ].DefaultBuilding == building.Type
						end
						canBuildSomeday = canBuildSomeday and not (
							-- no espionage buildings for a non-espionage game
							( Game.IsOption(GameOptionTypes.GAMEOPTION_NO_ESPIONAGE) and building.IsEspionage )
							-- Has obsolete tech?
							or ( building.ObsoleteTech and g_activeTeamTechs:HasTech( GameInfoTypes[building.ObsoleteTech] ) )
						)
						if canBuildSomeday or numExisting > 0 or numBuilds > 0 then
							local totalResource = (numExisting + numBuilds) * numResource
							local tip = "[COLOR_YIELD_FOOD]" .. L( building.Description ) .. "[ENDCOLOR]"
							if canBuildSomeday then
								local tech = building.PrereqTech and GameInfo.Technologies[ building.PrereqTech ]
								if tech and not g_activeTeamTechs:HasTech( tech.ID ) then
									tip = tip .. " [COLOR_CYAN]" .. L(tech.Description) .. "[ENDCOLOR]"
								end
								local policyBranch = building.PolicyBranchType and GameInfo.PolicyBranchTypes[ building.PolicyBranchType ]
								if policyBranch and not g_activePlayer:GetPolicyBranchChosen( policyBranch.ID ) then
									tip = tip .. " [COLOR_MAGENTA]" .. L(policyBranch.Description) .. "[ENDCOLOR]"
								end
							end
							if totalResource > 0 then
								tipIndex = tipIndex+1
								tips:insert( tipIndex, "[ICON_BULLET]" .. totalResource .. resource.IconString .. " = " ..  numExisting .. " (+" .. numBuilds .. ") " .. tip )
							else
								tips:insert( "[ICON_BULLET] (" .. numResource .. "/" .. tip .. ")" )
							end
						end
					end
				end
			end
			----------------------------
			-- Import & Export Breakdown
			----------------------------

			-- Get specified resource traded with the active player

			local itemType, duration, finalTurn, data1, data2, data3, flag1, fromPlayerID
			local gameTurn = Game.GetGameTurn()-1
			local Exports = {}
			local Imports = {}
			for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1 do
				Exports[ playerID ] = {}
				Imports[ playerID ] = {}
			end
			PushScratchDeal()
			for i = 0, UI.GetNumCurrentDeals( g_activePlayerID ) - 1 do
				UI.LoadCurrentDeal( g_activePlayerID, i )
				local otherPlayerID = g_deal:GetOtherPlayer( g_activePlayerID )
				g_deal:ResetIterator()
				repeat
					if bnw_mode then
						itemType, duration, finalTurn, data1, data2, data3, flag1, fromPlayerID = g_deal:GetNextItem()
					else
						itemType, duration, finalTurn, data1, data2, fromPlayerID = g_deal:GetNextItem()
					end
					-- data1 is resourceID, data2 is quantity

					if itemType == TradeableItems.TRADE_ITEM_RESOURCES and data1 == resourceID and data2 then
						if fromPlayerID == g_activePlayerID then
							Exports[otherPlayerID][finalTurn] = (Exports[otherPlayerID][finalTurn] or 0) + data2
						else
							Imports[fromPlayerID][finalTurn] = (Imports[fromPlayerID][finalTurn] or 0) + data2
						end
					end
				until not itemType
			end
			PopScratchDeal()

			----------------------------
			-- Resource Imports
			----------------------------
			if numResourceImport > 0 then
				tips:insert( "" )
				tips:insert( Colorize(numResourceImport) .. " " .. L"TXT_KEY_RESOURCES_IMPORTED" )
				for playerID, row in pairs( Imports ) do
					local tip = ""
					for turn, quantity in pairs(row) do
						if quantity > 0 then
							tip = tip .. " " .. quantity .. resource.IconString .. "(" .. turn - gameTurn .. ")"
						end
					end
					if #tip > 0 then
						tips:insert( "[ICON_BULLET]" .. Players[ playerID ]:GetCivilizationShortDescription() .. tip )
					end
				end
				for minorID = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1 do
					local minor = Players[ minorID ]
					if minor and minor:IsAlive() and minor:GetAlly() == g_activePlayerID then
						local quantity = minor:GetResourceExport(resourceID)
						if quantity > 0 then
							tips:insert( "[ICON_BULLET]" .. minor:GetCivilizationShortDescription() .. " " .. quantity .. resource.IconString )
						end
					end
				end
			end
			----------------------------
			-- Resource Exports
			----------------------------
			if numResourceExport > 0 then
				tips:insert( "" )
				tips:insert( Colorize(-numResourceExport) .. " " .. L"TXT_KEY_RESOURCES_EXPORTED" )
				for playerID, row in pairs( Exports ) do
					local tip = ""
					for turn, quantity in pairs(row) do
						if quantity > 0 then
							tip = tip .. " " .. quantity .. resource.IconString .. "(" .. turn - gameTurn .. ")"
						end
					end
					if #tip > 0 then
						tips:insert( "[ICON_BULLET]" .. Players[ playerID ]:GetCivilizationShortDescription() .. tip )
					end
				end
			end

			----------------------------
			-- Resource Useage Breakdown
			----------------------------
			tips:insert( "" )
			tips:insert( Colorize(-numResourceUsed) .. " " .. L"TXT_KEY_PEDIA_REQ_RESRC_LABEL" )
			local tipIndex = #tips

			for unit in GameInfo.Units() do
				local unitID = unit.ID
				local numResource = Game.GetNumResourceRequiredForUnit( unitID, resourceID )
				if numResource > 0 then
					-- count how many such units player has
					local numExisting = 0
					for unit in g_activePlayer:Units() do
						if unit:GetUnitType() == unitID then
							numExisting = numExisting + 1
						end
					end
					-- count how many such units player is building
					local numBuilds = 0
					for city in g_activePlayer:Cities() do
						for i=0, city:GetOrderQueueLength()-1 do
							local queuedOrderType, queuedItemType = city:GetOrderFromQueue( i )
							if queuedOrderType == OrderTypes.ORDER_TRAIN and queuedItemType == unitID then
								numBuilds = numBuilds + 1
							end
						end
					end
					-- can player build this unit someday ?
					local canBuildSomeday = true
					if bnw_mode then
						-- does player trait prohibits training this unit ?
						local leader = GameInfo.Leaders[ g_activePlayer:GetLeaderType() ]
						for leaderTrait in GameInfo.Leader_Traits{ LeaderType = leader.Type } do
							if GameInfo.Trait_NoTrain{ UnitClassType = unit.Class, TraitType = leaderTrait.TraitType }() then
								canBuildSomeday = false
								break
							end
						end
					end
					if canBuildSomeday then
						-- check whether this Unit has been blocked out by the civ XML unit override
						local unitOverride = GameInfo.Civilization_UnitClassOverrides{ CivilizationType = g_activeCivilization.Type, UnitClassType = unit.Class }()
						if unitOverride then
							canBuildSomeday = unitOverride.UnitType == unit.Type
						else
							canBuildSomeday = GameInfo.UnitClasses[ unit.Class ].DefaultUnit == unit.Type
						end
					end
					canBuildSomeday = canBuildSomeday and not (
						-- one City Challenge?
						( Game.IsOption(GameOptionTypes.GAMEOPTION_ONE_CITY_CHALLENGE) and (unit.Found or unit.FoundAbroad) )
						-- Faith Requirements?
						or ( g_isReligionEnabled and (unit.FoundReligion or unit.SpreadReligion or unit.RemoveHeresy) )
						-- obsolete by tech?
						or ( unit.ObsoleteTech and g_activeTeamTechs:HasTech( GameInfoTypes[unit.ObsoleteTech] ) )
					)
					if canBuildSomeday or numExisting > 0 or numBuilds > 0 then
						local totalResource = (numExisting + numBuilds) * numResource
						local tip = "[COLOR_YELLOW]" .. L( unit.Description ) .. "[ENDCOLOR]"
						if canBuildSomeday then
							-- Tech requirements
							local tech = unit.PrereqTech and GameInfo.Technologies[ unit.PrereqTech ]
							if tech and not g_activeTeamTechs:HasTech( tech.ID ) then
								tip = S( "%s [COLOR_CYAN]%s[ENDCOLOR]", tip, L(tech.Description) )
							end
							-- Policy Requirement
							local policy = civ5bnw_mode and unit.PolicyType and GameInfo.Policies[ unit.PolicyType ]
							if policy and not g_activePlayer:HasPolicy( policy.ID ) then
								tip = S( "%s [COLOR_MAGENTA]%s[ENDCOLOR]", tip, L(policy.Description) )
							end
							if civBE_mode then
								-- Affinity Level Requirements
								for affinityPrereq in GameInfo.Unit_AffinityPrereqs{ UnitType = unit.Type } do
									local affinityInfo = (tonumber( affinityPrereq.Level) or 0 ) > 0 and GameInfo.Affinity_Types[ affinityPrereq.AffinityType ]
									if affinityInfo and g_activePlayer:GetAffinityLevel( affinityInfo.ID ) < affinityPrereq.Level then
										tip = S("%s [%s]%i%s%s[ENDCOLOR]", tip, affinityInfo.ColorType, affinityPrereq.Level, affinityInfo.IconString or "???", L(affinityInfo.Description) )
									end
								end
							end
						end
						if totalResource > 0 then
							tipIndex = tipIndex+1
							tips:insert( tipIndex, "[ICON_BULLET]" .. totalResource .. resource.IconString .. " = " ..  numExisting .. " (+" .. numBuilds .. ") " .. tip )
						else
							tips:insert( "[ICON_BULLET] (" .. numResource .. "/" .. tip .. ")" )
						end
					end
				end
			end
			for building in GameInfo.Buildings() do
				local buildingID = building.ID
				local numResource = Game.GetNumResourceRequiredForBuilding( buildingID, resourceID )
				if numResource > 0 then
					-- count how many such buildings player has
					local numExisting = g_activePlayer:CountNumBuildings( buildingID )
					-- count how many such units player is building
					local numBuilds = 0
					for city in g_activePlayer:Cities() do
						for i=0, city:GetOrderQueueLength()-1 do
							local queuedOrderType, queuedItemType = city:GetOrderFromQueue( i )
							if queuedOrderType == OrderTypes.ORDER_CONSTRUCT and queuedItemType == buildingID then
								numBuilds = numBuilds + 1
							end
						end
					end
					-- can player build this building someday ?
					local canBuildSomeday
					-- check whether this Unit has been blocked out by the civ XML
					local buildingOverride = GameInfo.Civilization_BuildingClassOverrides{ CivilizationType = g_activeCivilization.Type, BuildingClassType = building.BuildingClass }()
					if buildingOverride then
						canBuildSomeday = buildingOverride.BuildingType == building.Type
					else
						canBuildSomeday = GameInfo.BuildingClasses[ building.BuildingClass ].DefaultBuilding == building.Type
					end
					canBuildSomeday = canBuildSomeday and not (
						-- no espionage buildings for a non-espionage game
						( Game.IsOption(GameOptionTypes.GAMEOPTION_NO_ESPIONAGE) and building.IsEspionage )
						-- Has obsolete tech?
						or ( civ5_mode and building.ObsoleteTech and g_activeTeamTechs:HasTech( GameInfoTypes[building.ObsoleteTech] ) )
					)
					if canBuildSomeday or numExisting > 0 or numBuilds > 0 then
						local totalResource = (numExisting + numBuilds) * numResource
						local tip = "[COLOR_YIELD_FOOD]" .. L( building.Description ) .. "[ENDCOLOR]"
						if canBuildSomeday then
							local tech = GameInfo.Technologies[ building.PrereqTech ]
							if tech and not g_activeTeamTechs:HasTech( tech.ID ) then
								tip = S( "%s [COLOR_CYAN]%s[ENDCOLOR]", tip, L(tech.Description) )
							end
							local policyBranch = civ5bnw_mode and building.PolicyBranchType and GameInfo.PolicyBranchTypes[ building.PolicyBranchType ]
							if policyBranch and not g_activePlayer:GetPolicyBranchChosen( policyBranch.ID ) then
								tip = S( "%s [COLOR_MAGENTA]%s[ENDCOLOR]", tip, L(policyBranch.Description) )
							end
							if civBE_mode then
								-- Affinity Level Requirements
								for affinityPrereq in GameInfo.Building_AffinityPrereqs{ BuildingType = building.Type } do
									local affinityInfo = (tonumber( affinityPrereq.Level) or 0 ) > 0 and GameInfo.Affinity_Types[ affinityPrereq.AffinityType ]
									if affinityInfo and g_activePlayer:GetAffinityLevel( affinityInfo.ID ) < affinityPrereq.Level then
										tip = S("%s [%s]%i%s%s[ENDCOLOR]", tip, affinityInfo.ColorType, affinityPrereq.Level, affinityInfo.IconString or "???", L(affinityInfo.Description) )
									end
								end
							end
						end
						if totalResource > 0 then
							tipIndex = tipIndex+1
							tips:insert( tipIndex, "[ICON_BULLET]" .. totalResource .. resource.IconString .. " = " ..  numExisting .. " (+" .. numBuilds .. ") " .. tip )
						else
							tips:insert( "[ICON_BULLET] (" .. numResource .. "/" .. tip .. ")" )
						end
					end
				end
			end
		end
	end

	-- show foreign strategic resources available for trade to the active player

	local tipIndex = #tips
	local totalResource = 0
	----------------------------
	-- Available for Import
	----------------------------
	for playerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do

		local player = Players[playerID]
		local isMinorCiv = player:IsMinorCiv()

		-- Valid player? - Can't be us, has to be alive, and has to be met
		if playerID ~= g_activePlayerID
			and player:IsAlive()
			and g_activeTeam:IsHasMet( player:GetTeam() )
			and not (isMinorCiv and player:IsAllies(g_activePlayerID))
		then
			local numResource = Game.GetResourceUsageType(resourceID) == ResourceUsageTypes.RESOURCEUSAGE_STRATEGIC
				and ( ( isMinorCiv and player:GetNumResourceTotal(resourceID, false) + player:GetResourceExport( resourceID ) )
				or ( g_deal:IsPossibleToTradeItem(playerID, g_activePlayerID, TradeableItems.TRADE_ITEM_RESOURCES, resourceID, 1) and player:GetNumResourceAvailable(resourceID, false) ) )
			if numResource and numResource > 0 then
				totalResource = totalResource + numResource
				tips:insert( "[ICON_BULLET]" .. player:GetCivilizationShortDescription() .. " " .. numResource .. resource.IconString )
			end
		end
	end
	if totalResource > 0 then
		tips:insert( tipIndex+1, "" )
		tips:insert( tipIndex+2, "----------------")
		tips:insert( tipIndex+3, totalResource .. " " .. L"TXT_KEY_EO_RESOURCES_AVAILBLE" )
	end

	return setTextToolTip( tips:concat( "[NEWLINE]" ) )
end
local function ResourcesTipHandler( control )
	g_requestToolTipFunction = ResourcesToolTip
	g_requestToolTipControl = control
end

local function OnResourceLClick()-- resourceID )
	return GamePopup( ButtonPopupTypes.BUTTONPOPUP_ECONOMIC_OVERVIEW )
end
local function OnResourceRClick( resourceID )
	return GamePedia( GameInfo.Resources[ resourceID ].Description )
end

for resource in GameInfo.Resources() do
	local resourceID = resource.ID
	if Game.GetResourceUsageType( resourceID ) == ResourceUsageTypes.RESOURCEUSAGE_STRATEGIC then
		local instance = {}
		ContextPtr:BuildInstanceForControlAtIndex( "ResourceInstance", instance, Controls.TopPanelDiploStack, 8 )
		instance = instance.ResourceItem
		g_resourceString[ resourceID ] = instance
		instance:SetVoid1( resourceID )
		instance:SetToolTipCallback( ResourcesTipHandler )
		instance:RegisterCallback( Mouse.eLClick, OnResourceLClick )
		instance:RegisterCallback( Mouse.eRClick, OnResourceRClick )
	end
end

-------------------------------------------------
-- Initialization
-------------------------------------------------

local function UpdateTopPanel()
	g_requestTopPanelUpdate = true
end

local function UpdateOptions()
	g_clockFormat = g_options
				and g_options.GetValue
				and g_options.GetValue( "Clock" ) == 1
				and g_clockFormats[ g_options.GetValue("ClockMode") or 1 ]
	Controls.CurrentTime:SetHide( not g_clockFormat )
	g_isBasicHelp = civBE_mode or not OptionsManager.IsNoBasicHelp()
	g_isScienceEnabled = not Game.IsOption(GameOptionTypes.GAMEOPTION_NO_SCIENCE)
	g_isPoliciesEnabled = not Game.IsOption(GameOptionTypes.GAMEOPTION_NO_POLICIES)
	g_isHappinessEnabled = civ5_mode and not Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HAPPINESS)
	g_isReligionEnabled = civ5_mode and gk_mode and not Game.IsOption(GameOptionTypes.GAMEOPTION_NO_RELIGION)
	g_isHealthEnabled = not (civ5_mode or Game.IsOption(GameOptionTypes.GAMEOPTION_NO_HEALTH) )
	UpdateTopPanel()
end

local function SetActivePlayer()
	g_activePlayerID = Game.GetActivePlayer()
	g_activePlayer = Players[g_activePlayerID]
	g_activeTeamID = g_activePlayer:GetTeam()
	g_activeTeam = Teams[g_activeTeamID]
	g_activeCivilizationID = g_activePlayer:GetCivilizationType()
	g_activeCivilization = GameInfo.Civilizations[ g_activeCivilizationID ]
	g_activeTeamTechs = g_activeTeam:GetTeamTechs()
	UpdateOptions()
end
SetActivePlayer()

Controls.TopPanelBar:SetHide( not g_isSmallScreen )
Controls.TopPanelBarL:SetHide( g_isSmallScreen )
Controls.TopPanelBarR:SetHide( g_isSmallScreen )
Controls.TopPanelMask:SetHide( true )

ContextPtr:SetUpdate(
function()
--	if IsGameCoreBusy() then
--		return
--	end

	if g_alarmTime and os_time() >= g_alarmTime then
		g_alarmTime = nil
		UI.AddPopup{ Type = ButtonPopupTypes.BUTTONPOPUP_TEXT,
			Data1 = 800,	-- WrapWidth
			Option1 = true, -- show TopImage
			Text = os_date( g_clockFormat ) }
	end

	if g_clockFormat then
		Controls.CurrentTime:SetText( os_date( g_clockFormat ) )
	end

	if g_isPopupUp ~= UI.IsPopupUp() then
		Controls.TopPanelMask:SetHide( g_isPopupUp or g_isSmallScreen )
		g_isPopupUp = not g_isPopupUp
		UpdateTopPanelNow()

	elseif g_requestTopPanelUpdate then
		UpdateTopPanelNow()
	end

	if g_requestToolTipControl then
		local toolTipHandler = g_requestToolTipFunction or g_toolTipHandler[g_requestToolTipControl:GetID()]
		if toolTipHandler then
			toolTipHandler( g_requestToolTipControl )
		end
		g_requestToolTipControl = nil
		g_requestToolTipFunction = nil
	end
end)

Events.SerialEventGameDataDirty.Add( UpdateTopPanel )
Events.SerialEventTurnTimerDirty.Add( UpdateTopPanel )
Events.SerialEventCityInfoDirty.Add( UpdateTopPanel )
Events.SerialEventImprovementCreated.Add( UpdateTopPanel )	-- required to update happiness & resources if a resource got hooked up
Events.GameplaySetActivePlayer.Add( SetActivePlayer )
Events.GameOptionsChanged.Add( UpdateOptions )

-------------------------------------------------
-- Alarm Clock
-------------------------------------------------

for clockFormatIndex, clockFormat in ipairs( g_clockFormats ) do
	local instance = {}
	ContextPtr:BuildInstanceForControl( "ClockOptionInstance", instance, Controls.ClockOptions )
	instance = instance.ClockOption
	instance:GetTextButton():SetText( os_date( clockFormat ) )
	instance:SetCheck( g_clockFormat == clockFormat )
	instance:RegisterCheckHandler(
	function( isChecked )
		if isChecked then
			g_options.SetValue( "ClockMode", clockFormatIndex )
			UpdateOptions()
		end
	end)
end
local function GetAlarmOptions()
	g_alarmTime = nil
	local time = tonumber( g_options.GetValue( "AlarmTime" ) ) or 0
	local t = os_date( "*t", time )
	if t then
		Controls.AlarmHours:SetText( S( "%2d", t.hour ) )
		Controls.AlarmMinutes:SetText( S( "%2d", t.min ) )
		if time > os_time() + 1 then

			g_alarmTime = g_options.GetValue( "AlarmIsOn" ) == 1 and time
		end
	end
	Controls.AlarmCheckBox:SetCheck( g_alarmTime )
end
GetAlarmOptions()
Controls.ClockOptions:CalculateSize()
Controls.ClockOptionsPanel:SetSizeY( Controls.ClockOptions:GetSizeY() + 88 )

Controls.CurrentTime:RegisterCallback( Mouse.eLClick,
function()
	Controls.ClockOptionsPanel:SetHide( not Controls.ClockOptionsPanel:IsHidden() )
end)

Controls.ClockOptionsPanelClose:RegisterCallback( Mouse.eLClick,
function()
	Controls.ClockOptionsPanel:SetHide( true )
end)

local function SetAlarmOptions()
	local t = os_date("*t")
	t.hour = tonumber( Controls.AlarmHours:GetText() ) or 0
	t.min = tonumber( Controls.AlarmMinutes:GetText() ) or 0
	local time = os_time(t)

	if time < os_time()+2 then
		time = time + 86400	-- 1 day in seconds
	end
	g_options.SetValue( "AlarmTime", time )
	g_options.SetValue( "AlarmIsOn", Controls.AlarmCheckBox:IsChecked() )

	GetAlarmOptions()
end

Controls.AlarmHours:RegisterCallback( SetAlarmOptions )
Controls.AlarmMinutes:RegisterCallback( SetAlarmOptions )
Controls.AlarmCheckBox:RegisterCheckHandler( SetAlarmOptions )

print("Finished loading EUI top panel",os.clock())
end)
