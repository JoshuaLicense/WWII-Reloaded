--------------------------------------------------------------------------------------------
-- AI 
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = -1 WHERE Name IN('AI_HOMELAND_MOVE_PRIORITY_PATROL', 'AI_HOMELAND_MOVE_PRIORITY_SENTRY', 'AI_HOMELAND_MOVE_PRIORITY_MOBILE_RESERVE');
UPDATE Defines SET Value = 1 	WHERE Name = 'AI_HOMELAND_MAX_DEFENSIVE_MOVE_TURNS';
UPDATE Defines SET Value = 10 WHERE Name = 'COMBAT_DAMAGE';

UPDATE Defines SET Value = 2 WHERE Name = 'AI_STRATEGY_DEFEND_MY_LANDS_BASE_UNITS';
UPDATE Defines SET Value = 0 WHERE Name = 'AI_STRATEGY_DEFEND_MY_LANDS_UNITS_PER_CITY';

UPDATE Defines SET Value = 2 WHERE Name = 'AI_OPERATIONAL_MAX_RECRUIT_TURNS_DEFAULT';
UPDATE Defines SET Value = 4 WHERE Name = 'AI_OPERATIONAL_MAX_RECRUIT_TURNS_ENEMY_TERRITORY';


DELETE FROM MultiUnitFormation_SlotEntries WHERE MultiUnitFormationType = 'MUFORMATION_SMALL_CITY_ATTACK_FORCE' and PrimaryUnitType = 'UNITAI_CITY_BOMBARD' and SecondaryUnitType = 'UNITAI_RANGED';

DELETE FROM MultiUnitFormation_SlotEntries WHERE MultiUnitFormationType = 'MUFORMATION_BASIC_CITY_ATTACK_FORCE' and PrimaryUnitType = 'UNITAI_CITY_BOMBARD' and SecondaryUnitType = 'UNITAI_RANGED';
DELETE FROM MultiUnitFormation_SlotEntries WHERE MultiUnitFormationType = 'MUFORMATION_BASIC_CITY_ATTACK_FORCE' and PrimaryUnitType = 'UNITAI_ATTACK' and SecondaryUnitType = 'UNITAI_DEFENSE';

DELETE FROM MultiUnitFormation_SlotEntries WHERE MultiUnitFormationType = 'MUFORMATION_BIGGER_CITY_ATTACK_FORCE' and PrimaryUnitType = 'UNITAI_CITY_BOMBARD' and SecondaryUnitType = 'UNITAI_RANGED';
DELETE FROM MultiUnitFormation_SlotEntries WHERE MultiUnitFormationType = 'MUFORMATION_BIGGER_CITY_ATTACK_FORCE' and PrimaryUnitType = 'UNITAI_ATTACK' and SecondaryUnitType = 'UNITAI_COUNTER';

DELETE FROM MultiUnitFormation_SlotEntries WHERE MultiUnitFormationType = 'MUFORMATION_CITY_STATE_ATTACK_FORCE' and PrimaryUnitType = 'UNITAI_CITY_BOMBARD' and SecondaryUnitType = 'UNITAI_RANGED';

INSERT INTO MultiUnitFormation_SlotEntries
	(MultiUnitFormationType, 								PrimaryUnitType, 			SecondaryUnitType, 		MultiUnitPositionType, 		RequiredSlot)
VALUES
	('MUFORMATION_SMALL_CITY_ATTACK_FORCE', 'UNITAI_ATTACK', 			'UNITAI_DEFENSE', 		'MUPOSITION_FRONT_LINE', 	0),
	
	('MUFORMATION_BASIC_CITY_ATTACK_FORCE', 'UNITAI_ATTACK', 			'UNITAI_DEFENSE', 		'MUPOSITION_FRONT_LINE',	0),
	('MUFORMATION_BASIC_CITY_ATTACK_FORCE', 'UNITAI_CITY_BOMBARD','UNITAI_CITY_BOMBARD','MUPOSITION_BOMBARD',			0),
	('MUFORMATION_BASIC_CITY_ATTACK_FORCE', 'UNITAI_ATTACK', 			'UNITAI_DEFENSE', 		'MUPOSITION_FRONT_LINE',	1),
	('MUFORMATION_BASIC_CITY_ATTACK_FORCE', 'UNITAI_ATTACK',			'UNITAI_DEFENSE',			'MUPOSITION_FRONT_LINE',	1),
	
	('MUFORMATION_BIGGER_CITY_ATTACK_FORCE','UNITAI_FAST_ATTACK',	'UNITAI_FAST_ATTACK', 'MUPOSITION_FRONT_LINE',	1),
	('MUFORMATION_BIGGER_CITY_ATTACK_FORCE','UNITAI_CITY_BOMBARD','UNITAI_CITY_BOMBARD','MUPOSITION_FRONT_LINE',	1);

--------------------------------------------------------------------------------------------
-- Date 
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = 36 WHERE Name = 'HIDDEN_START_TURN_OFFSET';
UPDATE Defines SET Value = 6 WHERE Name = 'WEEKS_PER_MONTHS';
UPDATE Defines SET Value = 1939 WHERE Name = 'START_YEAR';

--------------------------------------------------------------------------------------------
-- Improvements
--------------------------------------------------------------------------------------------

UPDATE Improvements SET DefenseModifier = 20	WHERE Type = 'IMPROVEMENT_MANUFACTORY';
UPDATE Improvements SET DefenseModifier = 25	WHERE Type = 'IMPROVEMENT_CITY_RUINS';
UPDATE Improvements SET DefenseModifier = 30	WHERE Type = 'IMPROVEMENT_TRADING_POST';
UPDATE Improvements SET DefenseModifier = 40	WHERE Type = 'IMPROVEMENT_BUNKER';
UPDATE Improvements SET DefenseModifier = 75	WHERE Type = 'IMPROVEMENT_FORT';
UPDATE Improvements SET DefenseModifier = 100	WHERE Type = 'IMPROVEMENT_CITADEL';

UPDATE Improvements SET NearbyEnemyDamage = 0	WHERE Type = 'IMPROVEMENT_CITADEL';

UPDATE ArtDefine_Landmarks SET Scale = 0.65*Scale 
	WHERE ResourceType = 'ART_DEF_RESOURCE_ALUMINUM'
		OR ResourceType = 'ART_DEF_RESOURCE_COAL'
		OR ResourceType = 'ART_DEF_RESOURCE_COAL_HEAVY'
		OR ResourceType = 'ART_DEF_RESOURCE_ALUMINUM_HEAVY'
		OR ResourceType = 'ART_DEF_RESOURCE_COAL_HEAVY_MARSH'
		OR ResourceType = 'ART_DEF_RESOURCE_COAL_MARSH'
		OR ResourceType = 'ART_DEF_RESOURCE_IRON'
		OR ResourceType = 'ART_DEF_RESOURCE_IRON_HEAVY'
		OR ResourceType = 'ART_DEF_RESOURCE_IRON_HEAVY_MARSH'
		OR ResourceType = 'ART_DEF_RESOURCE_IRON_MARSH'
		OR ResourceType = 'ART_DEF_RESOURCE_OIL'
		OR ResourceType = 'ART_DEF_RESOURCE_OIL_HEAVY'
		OR ResourceType = 'ART_DEF_RESOURCE_URANIUM_MARSH'
		OR ResourceType = 'ART_DEF_RESOURCE_URANIUM_HEAVY_MARSH'
		OR ResourceType = 'ART_DEF_RESOURCE_URANIUM_HEAVY'
		OR ResourceType = 'ART_DEF_RESOURCE_URANIUM';
		
--------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = -250		WHERE Name = 'DEFICIT_UNIT_DISBANDING_THRESHOLD';-- prevent disbanding when negative income

UPDATE Defines SET Value = 1000000	WHERE Name = 'GREAT_GENERALS_THRESHOLD';
UPDATE Defines SET Value = 2		WHERE Name = 'RECON_VISIBILITY_RANGE';

UPDATE Defines SET Value = 5				WHERE Name = 'BONUS_PER_ADJACENT_FRIEND'; -- default 10
UPDATE Defines SET Value = -33		WHERE Name = 'RIVER_ATTACK_MODIFIER'; -- default -20

UPDATE Defines SET Value = 300		WHERE Name = 'AIR_UNIT_REBASE_RANGE_MULTIPLIER';
UPDATE Defines SET Value = 3 WHERE Name = 'EMBARKED_UNIT_MOVEMENT';

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
-- Terrains & Features
--------------------------------------------------------------------------------------------
UPDATE Terrains SET Movement = 5 WHERE Type IN('TERRAIN_SNOW', 'TERRAIN_DESERT');
DELETE FROM Terrain_Yields WHERE YieldType = 'YIELD_FOOD';

UPDATE Features SET Movement = 3 WHERE Type = 'FEATURE_FLOOD_PLAINS';
DELETE FROM Feature_YieldChanges WHERE YieldType IN('YIELD_FOOD', 'YIELD_CULTURE', 'YIELD_FAITH', 'YIELD_SCIENCE');
DELETE FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_FUJI';

INSERT INTO Improvement_Yields(ImprovementType, YieldType, Yield) VALUES ('IMPROVEMENT_TRADING_POST', 'YIELD_PRODUCTION', 1);
UPDATE Improvement_Yields SET Yield = 2 WHERE ImprovementType = 'IMPROVEMENT_MINE';

--------------------------------------------------------------------------------------------
-- Routes
--------------------------------------------------------------------------------------------
UPDATE Routes SET GoldMaintenance = 1;

--------------------------------------------------------------------------------------------
-- Projects
--------------------------------------------------------------------------------------------
ALTER TABLE Projects ADD AIOnly boolean default 0;
ALTER TABLE Projects ADD Operation boolean default 0;
ALTER TABLE Projects ADD UnlockType int default 0;
ALTER TABLE Projects ADD UnlockValue int default 0;
ALTER TABLE Projects ADD UnitReference text default 0;

-- Create new project buildingreq table
CREATE TABLE `Project_BuildingClassRequireds` (
	`ProjectType`	TEXT,
	`BuildingClassType`	TEXT, 
	foreign key (ProjectType) references Projects(Type), 
	foreign key(BuildingClassType) references BuildingClasses(Type));

--------------------------------------------------------------------------------------------
-- Operations
--------------------------------------------------------------------------------------------
INSERT INTO Projects 
	(Type, 										Description, 										Help, 																Civilopedia, 													Strategy, 														MaxGlobalInstances, MaxTeamInstances, Cost, IconAtlas, 		PortraitIndex, 	Operation, 	UnlockType,	UnlockValue)
VALUES
	('OPERATION_WESERUBUNG', 	'TXT_KEY_OPERATION_WESERUBUNG', 'TXT_KEY_OPERATION_WESERUBUNG_DESC', 	'TXT_KEY_OPERATION_WESERUBUNG_DESC', 	'TXT_KEY_OPERATION_WESERUBUNG_DESC', 	-1,									1, 								465,	'BW_ATLAS_1', 10, 						1,					1,					19400101),
	('OPERATION_SEELOWE', 		'TXT_KEY_OPERATION_SEELOWE', 		'TXT_KEY_OPERATION_SEELOWE_DESC', 		'TXT_KEY_OPERATION_SEELOWE_DESC', 		'TXT_KEY_OPERATION_SEELOWE_DESC', 		-1,									1, 								750,	'BW_ATLAS_1', 10, 						1,					1,					19400401),
	('OPERATION_NORWAY', 			'TXT_KEY_OPERATION_NORWAY', 		'TXT_KEY_OPERATION_NORWAY_DESC', 			'TXT_KEY_OPERATION_NORWAY_DESC', 			'TXT_KEY_OPERATION_NORWAY_DESC', 			-1,									1, 								1,		'BW_ATLAS_1', 10, 						1,					1,					19400401),
	('OPERATION_FALLGELB', 		'TXT_KEY_OPERATION_FALLGELB',		'TXT_KEY_OPERATION_FALLGELB_DESC', 		'TXT_KEY_OPERATION_FALLGELB_DESC', 		'TXT_KEY_OPERATION_FALLGELB_DESC', 		-1,									1, 								1,		'BW_ATLAS_1', 10, 						1,					1,					19391101),
	('OPERATION_SONNENBLUME', 'TXT_KEY_OPERATION_SONNENBLUME','TXT_KEY_OPERATION_SONNENBLUME_DESC', 'TXT_KEY_OPERATION_SONNENBLUME_DESC', 'TXT_KEY_OPERATION_SONNENBLUME_DESC',	-1,									1, 								425,	'BW_ATLAS_1', 10, 						1,					1,					19401210),
	('OPERATION_TORCH', 			'TXT_KEY_OPERATION_TORCH',			'TXT_KEY_OPERATION_TORCH_DESC', 			'TXT_KEY_OPERATION_TORCH_DESC', 			'TXT_KEY_OPERATION_TORCH_DESC', 			-1,									1, 								750,	'BW_ATLAS_1', 10, 						1,					1,					19420610),
	('OPERATION_MOTHERLAND', 	'TXT_KEY_OPERATION_MOTHERLAND',	'TXT_KEY_OPERATION_MOTHERLAND_DESC', 	'TXT_KEY_OPERATION_MOTHERLAND_DESC', 	'TXT_KEY_OPERATION_MOTHERLAND_DESC',	-1,									1, 								200,	'BW_ATLAS_1', 10, 						1,					1,					19411204);

INSERT INTO Project_Flavors
	(ProjectType, 						FlavorType, 			Flavor)
VALUES
	('OPERATION_WESERUBUNG', 	'FLAVOR_OFFENSE', 75),
	('OPERATION_WESERUBUNG', 	'FLAVOR_DEFENSE', 10),
	('OPERATION_SEELOWE', 		'FLAVOR_OFFENSE', 75),
	('OPERATION_SEELOWE', 		'FLAVOR_DEFENSE', 10),
	('OPERATION_NORWAY', 			'FLAVOR_OFFENSE', 75),
	('OPERATION_NORWAY', 			'FLAVOR_DEFENSE', 10),
	('OPERATION_FALLGELB',  	'FLAVOR_OFFENSE', 75),
	('OPERATION_FALLGELB',  	'FLAVOR_DEFENSE', 10),
	('OPERATION_SONNENBLUME', 'FLAVOR_OFFENSE', 65),
	('OPERATION_SONNENBLUME', 'FLAVOR_DEFENSE', 20),
	('OPERATION_TORCH', 		 	'FLAVOR_OFFENSE', 75),
	('OPERATION_TORCH', 		 	'FLAVOR_DEFENSE', 50),
	('OPERATION_MOTHERLAND',  'FLAVOR_OFFENSE', 20),
	('OPERATION_MOTHERLAND',  'FLAVOR_DEFENSE', 100);
	
INSERT INTO Project_BuildingClassRequireds 
	(ProjectType, 						BuildingClassType)
VALUES
	('OPERATION_WESERUBUNG', 	'BUILDINGCLASS_MILITARY_BASE'),
	('OPERATION_SEELOWE', 		'BUILDINGCLASS_MILITARY_BASE'),
	('OPERATION_NORWAY', 			'BUILDINGCLASS_MILITARY_BASE'),
	('OPERATION_FALLGELB', 		'BUILDINGCLASS_MILITARY_BASE'),
	('OPERATION_SONNENBLUME', 'BUILDINGCLASS_MILITARY_BASE'),
	('OPERATION_TORCH', 			'BUILDINGCLASS_MILITARY_BASE'),
	('OPERATION_MOTHERLAND', 	'BUILDINGCLASS_BROADCAST_TOWER');

--------------------------------------------------------------------------------------------
-- Resources
--------------------------------------------------------------------------------------------
DELETE FROM Resource_YieldChanges;

UPDATE Resources SET TechCityTrade = NULL;
UPDATE Resources SET TechReveal = NULL;
UPDATE Resources SET TechReveal = 'TECH_FUTURE_TECH' WHERE Type = 'RESOURCE_HORSE';
UPDATE Resources SET AIStopTradingEra = 'ERA_INDUSTRIAL';

--------------------------------------------------------------------------------------------
-- City
--------------------------------------------------------------------------------------------
UPDATE Defines SET Value = 0			WHERE Name = 'CITY_STARTING_RINGS';

UPDATE Defines SET Value = 15000 	WHERE Name = 'BASE_CITY_GROWTH_THRESHOLD';
UPDATE Defines SET Value = 0 			WHERE Name = 'FOOD_CONSUMPTION_PER_POPULATION';

UPDATE Defines SET Value = 500 		WHERE Name = 'CITY_STRENGTH_DEFAULT';
UPDATE Defines SET Value = 30 		WHERE Name = 'CITY_STRENGTH_POPULATION_CHANGE';
UPDATE Defines SET Value = 350 		WHERE Name = 'CITY_STRENGTH_UNIT_DIVISOR';
UPDATE Defines SET Value = 300 		WHERE Name = 'CITY_STRENGTH_HILL_CHANGE';
UPDATE Defines SET Value = 4 			WHERE Name = 'CITY_STRENGTH_TECH_BASE';
UPDATE Defines SET Value = 2.4 		WHERE Name = 'CITY_STRENGTH_TECH_EXPONENT';
UPDATE Defines SET Value = 0 			WHERE Name = 'CITY_STRENGTH_TECH_MULTIPLIER';

UPDATE Defines SET Value = 1			WHERE Name = 'BUY_PLOTS_DISABLED';

UPDATE Defines SET Value = 0			WHERE Name = 'CITY_ATTACK_RANGE';
UPDATE Defines SET Value = 100		WHERE Name = 'CITY_CAPTURE_POPULATION_PERCENT';

UPDATE Defines SET Value = 300		WHERE Name = 'TRADE_ROUTE_BASE_GOLD';
UPDATE Defines SET Value = 5			WHERE Name = 'TRADE_ROUTE_CAPITAL_POP_GOLD_MULTIPLIER';
UPDATE Defines SET Value = 50			WHERE Name = 'TRADE_ROUTE_CITY_POP_GOLD_MULTIPLIER';

UPDATE Eras SET CityBombardEffectTag = "ART_DEF_VEFFECT_ANTIAIR_IMPACT_AIR";

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
DELETE FROM Process_Flavors WHERE ProcessType != 'PROCESS_WEALTH';
DELETE FROM Process_ProductionYields WHERE ProcessType = 'PROCESS_RESEARCH';
DELETE FROM LeagueProjects;

INSERT INTO Processes (Type, Description, Help, TechPrereq, IconAtlas, PortraitIndex) 
VALUES 
	('PROCESS_RECRUITING', 'TXT_KEY_PROCESS_RECRUITING', 'TXT_KEY_PROCESS_RECRUITING_HELP', 'TECH_CURRENCY', 'WW2_PROCESSES_ICONS', 0),
	('PROCESS_WAR_BONDS', 'TXT_KEY_PROCESS_WAR_BONDS', 'TXT_KEY_PROCESS_WAR_BONDS_HELP', 'TECH_CURRENCY', 'WW2_PROCESSES_ICONS', 1);

UPDATE Process_ProductionYields SET Yield = 100 WHERE ProcessType = 'PROCESS_WEALTH';

INSERT INTO Process_ProductionYields (ProcessType, YieldType, Yield) VALUES 
	('PROCESS_WAR_BONDS', 'YIELD_MATERIEL', 100), 
	('PROCESS_RECRUITING', 'YIELD_PERSONNEL', 100);

--------------------------------------------------------------------------------------------
-- New Defines
--------------------------------------------------------------------------------------------
INSERT INTO Defines (Name, Value) VALUES ('SUPPLY_TRUCKS_MOVEMENT', 6); 	-- Distance before supply Line start losing efficiency, based on the movement cost of the full supply line (1 point = 1 move on flat terrain with no road/railroad/features)
INSERT INTO Defines (Name, Value) VALUES ('SUPPLY_TRUCKS_PLOT_LIMIT', 20); -- Cuts down the processing late game (3x the trucks movement approx.)

INSERT INTO Defines (Name, Value) VALUES ('CITY_MAX_PLOT_CONTROL_RANGE', 6);
INSERT INTO Defines (Name, Value) VALUES ('UNIT_MAX_PLOT_CONTROL_RANGE', 3);

INSERT INTO Defines (Name, Value) VALUES ('MAX_HEALING_PERCENTAGE', 10);
INSERT INTO Defines (Name, Value) VALUES ('HEALING_HIGH_DANGER', 15000);
INSERT INTO Defines (Name, Value) VALUES ('HEALING_MEDIUM_DANGER', 5000);
INSERT INTO Defines (Name, Value) VALUES ('HEALING_LOW_DANGER', 1);

INSERT INTO Defines (Name, Value) VALUES ('HEAVY_FUEL_RATIONING', 500);
INSERT INTO Defines (Name, Value) VALUES ('MEDIUM_FUEL_RATIONING', 1000);
INSERT INTO Defines (Name, Value) VALUES ('LIGHT_FUEL_RATIONING', 2500);

INSERT INTO Defines (Name, Value) VALUES ('HEAVY_RATIONING_MOVES', 30);
INSERT INTO Defines (Name, Value) VALUES ('MEDIUM_RATIONING_MOVES', 60);
INSERT INTO Defines (Name, Value) VALUES ('LIGHT_RATIONING_MOVES', 80);

INSERT INTO Defines (Name, Value) VALUES ('HEAVY_RATIONING_CONSUMPTION', 50);
INSERT INTO Defines (Name, Value) VALUES ('MEDIUM_RATIONING_CONSUMPTION', 65);
INSERT INTO Defines (Name, Value) VALUES ('LIGHT_RATIONING_CONSUMPTION', 85);

INSERT INTO Defines (Name, Value) VALUES ('OCCUPIED_PRODUCTION_MODIFIER', -25);
INSERT INTO Defines (Name, Value) VALUES ('OCCUPIED_CITY_CONNECTION_MODIFIER', -25);

--------------------------------------------------------------------------------------------
-- Unit Supply Production Modifier
--------------------------------------------------------------------------------------------
UPDATE HandicapInfos SET ProductionFreeUnits = 0, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 20 WHERE Type = 'HANDICAP_DEITY';
UPDATE HandicapInfos SET ProductionFreeUnits = 0, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 20 WHERE Type = 'HANDICAP_IMMORTAL';
UPDATE HandicapInfos SET ProductionFreeUnits = 0, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 25 WHERE Type = 'HANDICAP_EMPEROR';
UPDATE HandicapInfos SET ProductionFreeUnits = 0, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 25 WHERE Type = 'HANDICAP_KING';
UPDATE HandicapInfos SET ProductionFreeUnits = 5, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 25 WHERE Type = 'HANDICAP_PRINCE';
UPDATE HandicapInfos SET ProductionFreeUnits = 7, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 25 WHERE Type = 'HANDICAP_WARLORD';
UPDATE HandicapInfos SET ProductionFreeUnits = 7, ProductionFreeUnitsPerCity = 2, ProductionFreeUnitsPopulationPercent = 25 WHERE Type = 'HANDICAP_CHIEFTAIN';
UPDATE HandicapInfos SET ProductionFreeUnits = 10, ProductionFreeUnitsPerCity = 2, ProductionFreeUnitsPopulationPercent = 25 WHERE Type = 'HANDICAP_SETTLER';

UPDATE HandicapInfos SET ProductionFreeUnits = 0, ProductionFreeUnitsPerCity = 1, ProductionFreeUnitsPopulationPercent = 25, RouteCostPercent = 100, UnitCostPercent = 100, BuildingCostPercent = 100 WHERE Type = 'HANDICAP_AI_DEFAULT';
UPDATE HandicapInfos SET AIUnitSupplyPercent = 0;