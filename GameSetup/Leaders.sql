--------------------------------
-- Leaders
--------------------------------			
INSERT INTO Leaders 
	(Type, 													Description, 					Civilopedia, 																	CivilopediaTag, 																ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 		PortraitIndex)
VALUES		
	('LEADER_WWII_CHURCHILL', 	'TXT_KEY_LEADER_WWII_CHURCHILL', 'TXT_KEY_LEADERS_WWII_CHURCHILL_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_WWII_CHURCHILL', 	'DiploUK.xml',	9, 						3, 						8, 							8, 			6, 				9, 				6, 						5, 				8, 			4, 			4, 				6, 			6, 			'WW2_LEADERS', 1),
	('LEADER_WWII_DEGAULLE', 	'TXT_KEY_LEADER_WWII_DEGAULLE', 'TXT_KEY_LEADERS_WWII_DEGAULLE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_WWII_DEGAULLE', 	'DiploFrance.xml',			7, 						6, 						6, 							8, 			2, 				6, 				7, 						3, 				3, 			7, 			1, 				7, 			5, 			'WW2_LEADERS', 5),
	('LEADER_WWII_HITLER', 	'TXT_KEY_LEADER_WWII_HITLER', 'TXT_KEY_LEADERS_WWII_HITLER_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_WWII_HITLER', 	'DiploGermany.xml',						9, 						5, 						7, 							9, 			2, 				5, 				8, 						2, 				4, 			6, 			1, 				6, 			9, 			'WW2_LEADERS', 0),
	('LEADER_WWII_MUSSOLINI', 	'TXT_KEY_LEADER_WWII_MUSSOLINI', 'TXT_KEY_LEADERS_WWII_MUSSOLINI_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_WWII_MUSSOLINI', 	'DiploItaly.xml',							8, 						3, 						6, 							8, 			4, 				4, 				4, 						4, 				3, 			4, 			2, 				2, 			4, 			'WW2_LEADERS', 6);
	
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
	(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_WAR', 			6),
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
	('LEADER_WWII_CHURCHILL', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_WAR', 			4),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_AFRAID', 		6),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
	('LEADER_WWII_DEGAULLE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_WAR', 			7),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	9),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
	('LEADER_WWII_HITLER', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_WAR', 			6),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_GUARDED', 		5),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_AFRAID', 		4),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
	('LEADER_WWII_MUSSOLINI', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
		
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------		
INSERT INTO Leader_MinorCivApproachBiases 
	(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		
	('LEADER_WWII_CHURCHILL', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
	('LEADER_WWII_CHURCHILL', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
	('LEADER_WWII_CHURCHILL', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	9),
	('LEADER_WWII_CHURCHILL', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
	('LEADER_WWII_CHURCHILL', 	'MINOR_CIV_APPROACH_BULLY', 		2),
	('LEADER_WWII_DEGAULLE', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
	('LEADER_WWII_DEGAULLE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		2),
	('LEADER_WWII_DEGAULLE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
	('LEADER_WWII_DEGAULLE', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
	('LEADER_WWII_DEGAULLE', 	'MINOR_CIV_APPROACH_BULLY', 		3),
	('LEADER_WWII_HITLER', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
	('LEADER_WWII_HITLER', 	'MINOR_CIV_APPROACH_FRIENDLY', 		2),
	('LEADER_WWII_HITLER', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
	('LEADER_WWII_HITLER', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
	('LEADER_WWII_HITLER', 	'MINOR_CIV_APPROACH_BULLY', 		9),
	('LEADER_WWII_MUSSOLINI', 		'MINOR_CIV_APPROACH_IGNORE', 		4),
	('LEADER_WWII_MUSSOLINI', 		'MINOR_CIV_APPROACH_FRIENDLY', 		3),
	('LEADER_WWII_MUSSOLINI', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
	('LEADER_WWII_MUSSOLINI', 		'MINOR_CIV_APPROACH_CONQUEST', 		7),
	('LEADER_WWII_MUSSOLINI', 		'MINOR_CIV_APPROACH_BULLY', 		4);

--------------------------------	
-- Leader_Flavors
--------------------------------						
INSERT INTO Leader_Flavors 
	(LeaderType, 				FlavorType, 						Flavor)
VALUES		
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_OFFENSE', 					5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_DEFENSE', 					6),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_CITY_DEFENSE', 				6),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_MILITARY_TRAINING', 		7),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_RECON', 					4),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_RANGED', 					3),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_MOBILE', 					3),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_NAVAL', 					9),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_NAVAL_RECON', 				8),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_NAVAL_GROWTH', 				8),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	8),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_AIR', 						9),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_EXPANSION', 				6),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_GROWTH', 					5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_INFRASTRUCTURE', 			7),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_PRODUCTION', 				7),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_GOLD', 						7),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_SCIENCE', 					6),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_CULTURE', 					6),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_HAPPINESS', 				7),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_GREAT_PEOPLE', 				5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_WONDER', 					3),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_RELIGION', 					4),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_DIPLOMACY', 				8),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_SPACESHIP', 				4),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_WATER_CONNECTION', 			4),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_NUKE', 						2),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_USE_NUKE', 					2),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_ESPIONAGE', 				5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_AIRLIFT', 					2),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		9),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_ARCHAEOLOGY', 				5),
	('LEADER_WWII_CHURCHILL', 	'FLAVOR_AIR_CARRIER', 				5),
	
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_OFFENSE', 					6),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_DEFENSE', 					7),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_CITY_DEFENSE', 				6),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_MILITARY_TRAINING', 		5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_RECON', 					4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_RANGED', 					4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_MOBILE', 					6),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_NAVAL', 					3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_NAVAL_RECON', 				3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_NAVAL_GROWTH', 				3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_AIR', 						6),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_EXPANSION', 				6),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_GROWTH', 					3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_INFRASTRUCTURE', 			6),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_PRODUCTION', 				4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_GOLD', 						4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_SCIENCE', 					5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_CULTURE', 					8),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_HAPPINESS', 				4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_GREAT_PEOPLE', 				5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_WONDER', 					3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_RELIGION', 					5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_DIPLOMACY', 				4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_SPACESHIP', 				3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_WATER_CONNECTION', 			4),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_NUKE', 						3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_USE_NUKE', 					3),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_ESPIONAGE', 				5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_AIRLIFT', 					5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_ARCHAEOLOGY', 				5),
	('LEADER_WWII_DEGAULLE', 	'FLAVOR_AIR_CARRIER', 				5),

	('LEADER_WWII_HITLER', 	'FLAVOR_OFFENSE', 					9),
	('LEADER_WWII_HITLER', 	'FLAVOR_DEFENSE', 					4),
	('LEADER_WWII_HITLER', 	'FLAVOR_CITY_DEFENSE', 				3),
	('LEADER_WWII_HITLER', 	'FLAVOR_MILITARY_TRAINING', 		9),
	('LEADER_WWII_HITLER', 	'FLAVOR_RECON', 					4),
	('LEADER_WWII_HITLER', 	'FLAVOR_RANGED', 					4),
	('LEADER_WWII_HITLER', 	'FLAVOR_MOBILE', 					7),
	('LEADER_WWII_HITLER', 	'FLAVOR_NAVAL', 					5),
	('LEADER_WWII_HITLER', 	'FLAVOR_NAVAL_RECON', 				5),
	('LEADER_WWII_HITLER', 	'FLAVOR_NAVAL_GROWTH', 				5),
	('LEADER_WWII_HITLER', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
	('LEADER_WWII_HITLER', 	'FLAVOR_AIR', 						6),
	('LEADER_WWII_HITLER', 	'FLAVOR_EXPANSION', 				9),
	('LEADER_WWII_HITLER', 	'FLAVOR_GROWTH', 					3),
	('LEADER_WWII_HITLER', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
	('LEADER_WWII_HITLER', 	'FLAVOR_INFRASTRUCTURE', 			6),
	('LEADER_WWII_HITLER', 	'FLAVOR_PRODUCTION', 				6),
	('LEADER_WWII_HITLER', 	'FLAVOR_GOLD', 						4),
	('LEADER_WWII_HITLER', 	'FLAVOR_SCIENCE', 					8),
	('LEADER_WWII_HITLER', 	'FLAVOR_CULTURE', 					6),
	('LEADER_WWII_HITLER', 	'FLAVOR_HAPPINESS', 				4),
	('LEADER_WWII_HITLER', 	'FLAVOR_GREAT_PEOPLE', 				4),
	('LEADER_WWII_HITLER', 	'FLAVOR_WONDER', 					3),
	('LEADER_WWII_HITLER', 	'FLAVOR_RELIGION', 					0),
	('LEADER_WWII_HITLER', 	'FLAVOR_DIPLOMACY', 				6),
	('LEADER_WWII_HITLER', 	'FLAVOR_SPACESHIP', 				3),
	('LEADER_WWII_HITLER', 	'FLAVOR_WATER_CONNECTION', 			4),
	('LEADER_WWII_HITLER', 	'FLAVOR_NUKE', 						3),
	('LEADER_WWII_HITLER', 	'FLAVOR_USE_NUKE', 					3),
	('LEADER_WWII_HITLER', 	'FLAVOR_ESPIONAGE', 				8),
	('LEADER_WWII_HITLER', 	'FLAVOR_AIRLIFT', 					5),
	('LEADER_WWII_HITLER', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
	('LEADER_WWII_HITLER', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
	('LEADER_WWII_HITLER', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
	('LEADER_WWII_HITLER', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
	('LEADER_WWII_HITLER', 	'FLAVOR_ARCHAEOLOGY', 				5),
	('LEADER_WWII_HITLER', 	'FLAVOR_AIR_CARRIER', 				5),
	
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_OFFENSE', 					7),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_DEFENSE', 					4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_CITY_DEFENSE', 				4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_MILITARY_TRAINING', 		7),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_RECON', 					6),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_RANGED', 					5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_MOBILE', 					5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_NAVAL', 					8),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_NAVAL_RECON', 				7),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_NAVAL_GROWTH', 				7),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_AIR', 						4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_EXPANSION', 				8),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_GROWTH', 					4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_TILE_IMPROVEMENT', 			4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_INFRASTRUCTURE', 			6),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_PRODUCTION', 				8),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_GOLD', 						4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_SCIENCE', 					4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_CULTURE', 					4),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_HAPPINESS', 				6),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_GREAT_PEOPLE', 				3),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_WONDER', 					2),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_RELIGION', 					2),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_DIPLOMACY', 				3),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_SPACESHIP', 				2),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_WATER_CONNECTION', 			3),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_NUKE', 						2),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_USE_NUKE', 					2),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_ESPIONAGE', 				7),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_AIRLIFT', 					1),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_ARCHAEOLOGY', 				5),
	('LEADER_WWII_MUSSOLINI', 		'FLAVOR_AIR_CARRIER', 				5);

--------------------------------	
-- Leader_Traits
--------------------------------						
INSERT INTO Leader_Traits 
	(LeaderType, 				TraitType)
VALUES
	('LEADER_WWII_CHURCHILL', 	'TRAIT_NEVER_SURRENDER'),
	('LEADER_WWII_DEGAULLE', 	'TRAIT_RESISTANCE'),
	('LEADER_WWII_HITLER', 	'TRAIT_BLITZKRIEG'),
	('LEADER_WWII_MUSSOLINI', 	'TRAIT_MARENOSTRUM');

--------------------------------
-- Traits
--------------------------------	
INSERT INTO Traits 
	(Type, 							Description, 						ShortDescription)
VALUES		
	('TRAIT_NEVER_SURRENDER', 	'TXT_KEY_TRAIT_NEVER_SURRENDER', 'TXT_KEY_TRAIT_NEVER_SURRENDER_DESC'),
	('TRAIT_BLITZKRIEG', 	'TXT_KEY_TRAIT_BLITZKRIEG', 'TXT_KEY_TRAIT_BLITZKRIEG_DESC'),
	('TRAIT_RESISTANCE', 	'TXT_KEY_TRAIT_RESISTANCE', 'TXT_KEY_TRAIT_RESISTANCE_DESC'),
	('TRAIT_MARENOSTRUM', 	'TXT_KEY_TRAIT_MARENOSTRUM', 'TXT_KEY_TRAIT_MARENOSTRUM_DESC');
	
UPDATE Traits SET NavalUnitMaintenanceModifier = -33 WHERE Type = "TRAIT_MARENOSTRUM";

INSERT INTO Trait_FreePromotionUnitCombats
	(TraitType, UnitCombatType, PromotionType)
VALUES
	("TRAIT_BLITZKRIEG", "UNITCOMBAT_ARMOR", "PROMOTION_BLITZ");