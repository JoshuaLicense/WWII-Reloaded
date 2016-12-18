--------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = -250		WHERE Name = 'DEFICIT_UNIT_DISBANDING_THRESHOLD';-- prevent disbanding when negative income

UPDATE Defines SET Value = 300		WHERE Name = 'AIR_UNIT_REBASE_RANGE_MULTIPLIER';
--------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------
DELETE FROM Building_FreeUnits;

-- That's the list of buildings you can construct.
UPDATE Buildings SET Cost = -1
	WHERE Type <> 'BUILDING_WALLS'
	AND Type <> 'BUILDING_FACTORY'
	AND Type <> 'BUILDING_ARSENAL'
	AND Type <> 'BUILDING_HARBOR'
	AND Type <> 'BUILDING_BROADCAST_TOWER'
	AND Type <> 'BUILDING_BARRACKS'
	AND Type <> 'BUILDING_MILITARY_ACADEMY'
	AND Type <> 'BUILDING_MILITARY_BASE'
	AND Type <> 'BUILDING_BANK';

--------------------------------------------------------------------------------------------
-- Minor Civilizations
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = 100000	WHERE Name LIKE 'MINOR_GOLD_GIFT_%';
UPDATE Defines SET Value = 1000	WHERE Name LIKE 'FRIENDSHIP_THRESHOLD_CAN_BULLY';
UPDATE Defines SET Value = 1000	WHERE Name LIKE 'FRIENDSHIP_THRESHOLD_CAN_PLEDGE_TO_PROTECT';
UPDATE Defines SET Value = 0	WHERE Name LIKE 'FRIENDSHIP_PER_UNIT_GIFTED';
UPDATE Defines SET Value = 1	WHERE Name LIKE 'MINOR_UNIT_GIFT_TRAVEL_TURNS';

--------------------------------------------------------------------------------------------
-- Technologies
--------------------------------------------------------------------------------------------
UPDATE Technologies SET Era = 'ERA_INDUSTRIAL' WHERE Type='TECH_SATELLITES';
UPDATE Technologies SET Era = 'ERA_INDUSTRIAL' WHERE Type='TECH_RAILROADS';

UPDATE Technologies SET AllowEmbassyTradingAllowed = 0;

--------------------------------------------------------------------------------------------
-- Routes
--------------------------------------------------------------------------------------------
UPDATE Routes SET GoldMaintenance = 1;

--------------------------------------------------------------------------------------------
-- Resources
--------------------------------------------------------------------------------------------
DELETE FROM Resource_YieldChanges;

UPDATE Resources SET TechReveal = NULL;
UPDATE Resources SET TechReveal = 'TECH_FUTURE_TECH' WHERE Type = 'RESOURCE_HORSE';

--------------------------------------------------------------------------------------------
-- City
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = 15000 	WHERE Name = 'BASE_CITY_GROWTH_THRESHOLD';
UPDATE Defines SET Value = 0 			WHERE Name = 'FOOD_CONSUMPTION_PER_POPULATION';

UPDATE Defines SET Value = 1			WHERE Name = 'BUY_PLOTS_DISABLED';

UPDATE Defines SET Value = 0		WHERE Name = 'CITY_ATTACK_RANGE';
UPDATE Defines SET Value = 100		WHERE Name = 'CITY_CAPTURE_POPULATION_PERCENT';

--------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = 1000000	WHERE Name = 'GREAT_GENERALS_THRESHOLD';
UPDATE Defines SET Value = 2		WHERE Name = 'RECON_VISIBILITY_RANGE';

UPDATE Defines SET Value = 5				WHERE Name = 'BONUS_PER_ADJACENT_FRIEND'; -- default 10
UPDATE Defines SET Value = -33		WHERE Name = 'RIVER_ATTACK_MODIFIER'; -- default -20

--------------------------------------------------------------------------------------------
-- Yields
--------------------------------------------------------------------------------------------

INSERT INTO Yields (Type, Description, IconString, ColorString, ImageTexture, MinCity, AiWeightPercent) VALUES 
	('YIELD_PERSONNEL', 'TXT_KEY_YIELD_PERSONNEL', '[ICON_PERSONNEL]', '[COLOR_WHITE]', 'YieldAtlas_128_Tourism.dds', 0, 80),
	('YIELD_MATERIEL', 'TXT_KEY_YIELD_MATERIEL', '[ICON_MATERIEL]', '[COLOR_WHITE]', 'YieldAtlas_128_Tourism.dds', 0, 80),
	('YIELD_FUEL', 'TXT_KEY_YIELD_FUEL', '[ICON_FUEL]', '[COLOR_WHITE]', 'YieldAtlas_128_Tourism.dds', 0, 80);

--------------------------------------------------------------------------------------------
-- Process
--------------------------------------------------------------------------------------------
DELETE FROM Processes WHERE Type != 'PROCESS_WEALTH';
INSERT INTO Processes (Type, Description, Help, TechPrereq, IconAtlas, PortraitIndex) 
VALUES 
	('PROCESS_RECRUITING', 'TXT_KEY_PROCESS_RECRUITING', 'TXT_KEY_PROCESS_RECRUITING_HELP', 'TECH_CURRENCY', 'WW2_PROCESSES_ICONS', 0),
	('PROCESS_WAR_BONDS', 'TXT_KEY_PROCESS_WAR_BONDS', 'TXT_KEY_PROCESS_WAR_BONDS_HELP', 'TECH_CURRENCY', 'WW2_PROCESSES_ICONS', 1);

UPDATE Process_ProductionYields SET Yield = 100 WHERE ProcessType = 'PROCESS_WEALTH';

INSERT INTO Process_ProductionYields (ProcessType, YieldType, Yield) VALUES 
	('PROCESS_WAR_BONDS', 'YIELD_MATERIEL', 100), 
	('PROCESS_RECRUITING', 'YIELD_PERSONNEL', 100);
