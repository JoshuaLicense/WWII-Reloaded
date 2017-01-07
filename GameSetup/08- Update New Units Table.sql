-----------------------------------------------
-- Initialize Unit Classes Overrides 
-----------------------------------------------

-- The Unit table is fille with generic units and none of them should be build, except a few.
INSERT INTO Civilization_UnitClassOverrides (CivilizationType, UnitClassType, UnitType)
	SELECT Civilizations.Type, UnitClasses.Type, NULL
	FROM UnitClasses JOIN Civilizations ON (UnitClasses.Type <> 'UNITCLASS_FIELD_GUN' AND UnitClasses.Type <> 'UNITCLASS_ARTILLERY' AND UnitClasses.Type <> 'UNITCLASS_ANTI_AIRCRAFT_GUN');

-- Here we set which unit classes the Minor Civilizations can build (which include the above exception)
DELETE FROM Civilization_UnitClassOverrides
	WHERE CivilizationType = 'CIVILIZATION_MINOR' AND (UnitClassType ='UNITCLASS_INFANTRY' OR UnitClassType ='UNITCLASS_OLD_LIGHT_TANK' OR UnitClassType ='UNITCLASS_OLD_TANK' OR UnitClassType ='UNITCLASS_OLD_FIGHTER' OR UnitClassType ='UNITCLASS_DESTROYER');

-----------------------------------------------
-- Make ArtDefine_UnitMemberCombats 
-----------------------------------------------

-- Works for single or multiple figures, with Var being '' in case of single (or first) figure
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, 
			MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats JOIN UnitConfiguration ON  (UnitMemberType = 'ART_DEF_UNIT_MEMBER_' || UnitConfiguration.Template AND Var <> '_LTD' AND Var <> 'RCKT');

-- Special case for rocket artillery
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, 
			MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats JOIN UnitConfiguration ON  (UnitMemberType = 'ART_DEF_UNIT_MEMBER_ROCKETARTILLERY' AND Var = 'RCKT');
	
-- Last to die (var = '_LTD')
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation, LastToDie)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax,
			TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale,	TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack,
			HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance,
			OnlyTurnInMovementActions, RushAttackFormation, 1
	FROM ArtDefine_UnitMemberCombats JOIN UnitConfiguration ON  (UnitMemberType = 'ART_DEF_UNIT_MEMBER_' || UnitConfiguration.Template AND Var = '_LTD');

-----------------------------------------------
-- Make ArtDefine_UnitMemberCombatWeapons 
-----------------------------------------------

INSERT OR REPLACE INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, "ID", VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius)
	SELECT 'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, "Index", SubIndex, ArtDefine_UnitMemberCombatWeapons.ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius
	FROM ArtDefine_UnitMemberCombatWeapons JOIN UnitConfiguration ON (UnitMemberType = 'ART_DEF_UNIT_MEMBER_' || UnitConfiguration.Template AND Var <> 'RCKT');

-- Special case for rocket artillery
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, "ID", VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius)
	SELECT 'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, "Index", SubIndex, ArtDefine_UnitMemberCombatWeapons.ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius
	FROM ArtDefine_UnitMemberCombatWeapons JOIN UnitConfiguration ON (UnitMemberType = 'ART_DEF_UNIT_MEMBER_ROCKETARTILLERY' AND Var = 'RCKT');
		
	
-----------------------------------------------
-- Make ArtDefine_UnitMemberInfos 
-----------------------------------------------

-- Use default scale
INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, Scale, ZOffset, Domain, 
			UnitConfiguration.fxsxml || '.fxsxml', MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos INNER JOIN UnitConfiguration ON (Type = 'ART_DEF_UNIT_MEMBER_' || UnitConfiguration.Template AND UnitConfiguration.Scl ISNULL AND Var <> 'RCKT');

-- Special case for rocket artillery & Use default scale	
INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey, Scale, ZOffset, Domain, 
			UnitConfiguration.fxsxml || '.fxsxml', MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos INNER JOIN UnitConfiguration ON (Type = 'ART_DEF_UNIT_MEMBER_ROCKETARTILLERY' AND Var = 'RCKT' AND UnitConfiguration.Scl ISNULL);

-- Use custom scale
INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, Scl, ZOffset, Domain, 
			UnitConfiguration.fxsxml || '.fxsxml', MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos INNER JOIN UnitConfiguration ON (Type = 'ART_DEF_UNIT_MEMBER_' || UnitConfiguration.Template AND UnitConfiguration.Scl NOT NULL AND Var <> 'RCKT');

-- Special case for rocket artillery & Use custom scale
INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	'ART_DEF_UNIT_MEMBER_' || UnitKey, Scl, ZOffset, Domain, 
			UnitConfiguration.fxsxml || '.fxsxml', MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos INNER JOIN UnitConfiguration ON (Type = 'ART_DEF_UNIT_MEMBER_ROCKETARTILLERY' AND Var = 'RCKT' AND UnitConfiguration.Scl NOT NULL);


-----------------------------------------------
-- We don't check special case from here
-----------------------------------------------

UPDATE UnitConfiguration
	SET Var = '' WHERE Var = 'RCKT';

-----------------------------------------------
-- Make ArtDefine_UnitInfoMemberInfos 
-----------------------------------------------

-- Remove previous entries, if any
DELETE FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType IN (SELECT 'ART_DEF_UNIT_' || UnitKey FROM UnitConfiguration);

-- Use default number of member
INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType, UnitMemberInfoType, NumMembers)
	SELECT	'ART_DEF_UNIT_' || UnitKey, 'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, NumMembers
	FROM ArtDefine_UnitInfoMemberInfos INNER JOIN UnitConfiguration ON (UnitConfiguration.Nb ISNULL AND UnitInfoType = 'ART_DEF_UNIT_' || UnitConfiguration.Template);

-- Use custom number of member
INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType, UnitMemberInfoType, NumMembers)
	SELECT	'ART_DEF_UNIT_' || UnitKey, 'ART_DEF_UNIT_MEMBER_' || UnitKey || Var, Nb
	FROM UnitConfiguration WHERE (UnitConfiguration.Nb NOT NULL);
	
---------------------------------------------------------
-- Keep only the entry pointing to the template's statistic in config table for each unit type
---------------------------------------------------------

DELETE FROM UnitConfiguration
	WHERE   Var <> '';

---------------------------------------------------------
-- Make ArtDefine_UnitInfos from remaining unique entries
---------------------------------------------------------

-- Use default formation
INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	'ART_DEF_UNIT_' || UnitKey, DamageStates, Formation
	FROM ArtDefine_UnitInfos INNER JOIN UnitConfiguration
		ON 'ART_DEF_UNIT_' || UnitConfiguration.Template = Type AND UnitConfiguration.Form ISNULL;

-- Use custom formation
INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	'ART_DEF_UNIT_' || UnitKey, DamageStates, Form
	FROM ArtDefine_UnitInfos INNER JOIN UnitConfiguration 
		ON 'ART_DEF_UNIT_' || UnitConfiguration.Template = Type AND UnitConfiguration.Form NOT NULL;

---------------------------------------------------------
-- Unit statistics: First copy all value from template
---------------------------------------------------------

INSERT INTO Units (Type, Description, Civilopedia, Strategy, Help, Requirements,
					 Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
					 UnitArtInfo, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, /*ProjectPrereq,*/ SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, 
					 UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas, Materiel, Personnel, FuelConsumption, KeyName)
	SELECT	'UNIT_' || UnitKey, Description, Civilopedia, Strategy, Help, Requirements,
					 Combat, RangedCombat, Cost, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain, CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost, MinAreaSize, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra, SpreadReligion, CombatLimit, RangeAttackOnlyInDomain, RangeAttackIgnoreLOS, RangedCombatLimit, XPValueAttack, XPValueDefense, SpecialCargo, DomainCargo, Conscription, ExtraMaintenanceCost, NoMaintenance, Unhappiness,
			'ART_DEF_UNIT_' || UnitKey, UnitArtInfoCulturalVariation, UnitArtInfoEraVariation, /*'PROJECT_' || UnitKey,*/ SpaceshipProject, LeaderPromotion, LeaderExperience, DontShowYields, ShowInPedia, MoveRate, 
					 UnitFlagIconOffset, PortraitIndex, IconAtlas, UnitFlagAtlas, Materiel, Personnel, FuelConsumption, UnitKey
	FROM Units INNER JOIN UnitConfiguration ON  (Type = 'UNIT_' || UnitConfiguration.Template);

---------------------------------------------------------
-- Then update each value that is specific to the new unit
---------------------------------------------------------

-- ProjectPrereq
UPDATE Units SET ProjectPrereq = 'PROJECT_' || KeyName
			WHERE EXISTS (SELECT ProjTrigger FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.ProjTrigger NOT NULL);

-- Combat
UPDATE Units SET Combat = Combat + (SELECT Cbt FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Cbt NOT NULL)
			WHERE EXISTS  (SELECT Cbt FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Cbt NOT NULL);

-- Ranged Combat
UPDATE Units SET RangedCombat = RangedCombat + (SELECT Rgcbt FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Rgcbt NOT NULL)
			WHERE EXISTS        (SELECT Rgcbt FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Rgcbt NOT NULL);

-- Cost
UPDATE Units SET Cost = Cost + (SELECT Cst FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Cst NOT NULL)
			WHERE EXISTS (SELECT Cst FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Cst NOT NULL);

-- Moves
UPDATE Units SET Moves = Moves + (SELECT Mvt FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Mvt NOT NULL)
			WHERE EXISTS (SELECT Mvt FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Mvt NOT NULL);

-- Immobile
UPDATE Units SET Immobile = (SELECT Imb FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Imb NOT NULL)
			WHERE EXISTS    (SELECT Imb FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Imb NOT NULL);
				
-- Range
UPDATE Units SET Range = Range + (SELECT Rng FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Rng NOT NULL)
			WHERE EXISTS (SELECT Rng FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Rng NOT NULL);
					
-- UnitFlagIconOffset
UPDATE Units SET UnitFlagIconOffset = (SELECT Flag FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Flag NOT NULL)
			WHERE EXISTS			  (SELECT Flag FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Flag NOT NULL);
					
-- PortraitIndex
UPDATE Units SET PortraitIndex = (SELECT Icon FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Icon NOT NULL)
			WHERE EXISTS		 (SELECT Icon FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Icon NOT NULL);
					
-- IconAtlas
UPDATE Units SET IconAtlas = (SELECT IcAtl FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.IcAtl NOT NULL)
			WHERE EXISTS	 (SELECT IcAtl FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.IcAtl NOT NULL);
					
-- UnitFlagAtlas
UPDATE Units SET UnitFlagAtlas = (SELECT FlagAtl FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.FlagAtl NOT NULL)
			WHERE EXISTS		 (SELECT FlagAtl FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.FlagAtl NOT NULL);

-- Materiel / HP
UPDATE Units SET Materiel = Materiel + (SELECT Mat FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Mat  NOT NULL)
			WHERE EXISTS	(SELECT Mat FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Mat  NOT NULL);

-- Personnel / HP
UPDATE Units SET Personnel = Personnel + (SELECT Pers FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Pers  NOT NULL)
			WHERE EXISTS	 (SELECT Pers FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND UnitConfiguration.Pers  NOT NULL);

-- Description
UPDATE Units SET Description = (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_' || Units.KeyName = Tag)
			WHERE EXISTS	   (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_' || Units.KeyName = Tag);
			
UPDATE Units SET Description = (SELECT Name FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type)
			WHERE NOT EXISTS   (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_' || Units.KeyName = Tag)
			AND EXISTS (SELECT Name FROM UnitConfiguration WHERE 'UNIT_' || UnitConfiguration.UnitKey = Units.Type AND Name NOT NULL);

-- Civilopedia
UPDATE Units SET Civilopedia = (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_PEDIA_' || Units.KeyName  = Tag)
			WHERE EXISTS	   (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_PEDIA_' || Units.KeyName  = Tag);

-- Strategy
UPDATE Units SET Strategy = (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_' || Units.KeyName || '_STRATEGY'  = Tag)
			WHERE EXISTS	(SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_' || Units.KeyName || '_STRATEGY'  = Tag);

-- Help
UPDATE Units SET Help =  (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_HELP_' || Units.KeyName  = Tag)
			WHERE EXISTS (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_UNIT_HELP_' || Units.KeyName  = Tag);


---------------------------------------------------------
-- Fill secondary tables
---------------------------------------------------------
	
INSERT INTO Unit_AITypes (UnitType, UnitAIType)
	SELECT 'UNIT_' || UnitKey, UnitAIType
	FROM Unit_AITypes INNER JOIN UnitConfiguration ON  (UnitType= 'UNIT_' || UnitConfiguration.Template);
	
INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor)
	SELECT 'UNIT_' || UnitKey, FlavorType, Flavor
	FROM Unit_Flavors INNER JOIN UnitConfiguration ON  (UnitType= 'UNIT_' || UnitConfiguration.Template);
	
-- first set the free promotion from class template...
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_' || UnitKey, PromotionType
	FROM Unit_FreePromotions JOIN UnitConfiguration ON (UnitType= 'UNIT_' || UnitConfiguration.Template);

-- then replace the class template FreePromotion if there is one specific to the unit
REPLACE INTO Unit_FreePromotions (UnitType, PromotionType)
	SELECT 'UNIT_' || UnitKey, 'PROMOTION_' || UnitKey
	FROM UnitPromotions JOIN UnitConfiguration ON (UnitPromotions.Type = 'PROMOTION_' || UnitConfiguration.UnitKey);

INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
	SELECT 'UNIT_' || UnitKey, ResourceType, Cost
	FROM Unit_ResourceQuantityRequirements INNER JOIN UnitConfiguration ON  (UnitType= 'UNIT_' || UnitConfiguration.Template);

INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset)
	SELECT 'ART_DEF_UNIT_' || UnitKey, TileType, Asset
	FROM ArtDefine_StrategicView INNER JOIN UnitConfiguration ON  (StrategicViewType = 'ART_DEF_UNIT_' || UnitConfiguration.Template);	

REPLACE INTO Civilization_UnitClassOverrides (CivilizationType, UnitClassType, UnitType)
	SELECT 'CIVILIZATION_WWII_' || CivKey, Units.Class, 'UNIT_' || UnitKey
	FROM Units INNER JOIN UnitConfiguration ON Type = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.CivKey NOT NULL;

-----------------------------------------------
-- Fill Projects table 
-----------------------------------------------

-- Cost based on unit's cost and English text exist
INSERT OR REPLACE INTO Projects (Type, Description, Help, Civilopedia, Strategy, MaxGlobalInstances, MaxTeamInstances, Cost, IconAtlas, PortraitIndex, UnlockType, UnlockValue, UnitReference)
	SELECT 'PROJECT_' || UnitKey, 'TXT_KEY_PROJECT_' || UnitKey, 'TXT_KEY_PROJECT_' || UnitKey || '_DESC', Units.Civilopedia, Units.Strategy, -1, 1, ROUND(Units.Cost*0.75), Units.IconAtlas, Units.PortraitIndex, ProjTrigger, ProjValue, ProjReference
	FROM Units INNER JOIN UnitConfiguration ON (Units.Type = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.ProjCst ISNULL AND UnitConfiguration.ProjTrigger NOT NULL)
	WHERE EXISTS (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_PROJECT_' || UnitConfiguration.UnitKey  = Tag);
	
-- Cost based on unit's cost and English text does not exist
INSERT OR REPLACE INTO Projects (Type, Description, Help, Civilopedia, Strategy, MaxGlobalInstances, MaxTeamInstances, Cost, IconAtlas, PortraitIndex, UnlockType, UnlockValue, UnitReference)
	SELECT 'PROJECT_' || UnitKey, Units.Description || ' design', 'Allow the construction of ' || Units.Description || '.[NEWLINE]----------------[NEWLINE]{'|| Units.Help ||'}', Units.Civilopedia, Units.Strategy, -1, 1, ROUND(Units.Cost*0.75), Units.IconAtlas, Units.PortraitIndex, ProjTrigger, ProjValue, ProjReference
	FROM Units INNER JOIN UnitConfiguration ON (Units.Type = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.ProjCst ISNULL AND UnitConfiguration.ProjTrigger NOT NULL)
	WHERE NOT EXISTS (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_PROJECT_' || UnitConfiguration.UnitKey  = Tag);

-- Specific cost factor and English text exist
INSERT OR REPLACE INTO Projects (Type, Description, Help, Civilopedia, Strategy, MaxGlobalInstances, MaxTeamInstances, Cost, IconAtlas, PortraitIndex, UnlockType, UnlockValue, UnitReference)
	SELECT 'PROJECT_' || UnitKey, 'TXT_KEY_PROJECT_' || UnitKey, 'TXT_KEY_PROJECT_' || UnitKey || '_DESC', Units.Civilopedia, Units.Strategy, -1, 1, ROUND(Units.Cost*UnitConfiguration.ProjCst), Units.IconAtlas, Units.PortraitIndex, ProjTrigger, ProjValue, ProjReference
	FROM Units INNER JOIN UnitConfiguration ON (Units.Type = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.ProjCst NOT NULL AND UnitConfiguration.ProjTrigger NOT NULL)
	WHERE EXISTS (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_PROJECT_' || UnitConfiguration.UnitKey  = Tag);

-- Specific cost factor and English text does not exist
INSERT OR REPLACE INTO Projects (Type, Description, Help, Civilopedia, Strategy, MaxGlobalInstances, MaxTeamInstances, Cost, IconAtlas, PortraitIndex, UnlockType, UnlockValue, UnitReference)
	SELECT 'PROJECT_' || UnitKey, Units.Description || ' design', 'Allow the construction of ' || Units.Description || '.[NEWLINE]----------------[NEWLINE]{'|| Units.Help ||'}', Units.Civilopedia, Units.Strategy, -1, 1, ROUND(Units.Cost*UnitConfiguration.ProjCst), Units.IconAtlas, Units.PortraitIndex, ProjTrigger, ProjValue, ProjReference
	FROM Units INNER JOIN UnitConfiguration ON (Units.Type = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.ProjCst NOT NULL AND UnitConfiguration.ProjTrigger NOT NULL)
	WHERE NOT EXISTS (SELECT Tag FROM Language_en_US WHERE 'TXT_KEY_PROJECT_' || UnitConfiguration.UnitKey  = Tag);

INSERT OR REPLACE INTO Project_Flavors (ProjectType, FlavorType, Flavor)
	SELECT 'PROJECT_' || UnitKey, Unit_Flavors.FlavorType, Unit_Flavors.Flavor
	FROM Unit_Flavors INNER JOIN UnitConfiguration ON (Unit_Flavors.UnitType = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.ProjTrigger NOT NULL);
	
-- Insert building requirements for Projects (Default Academy)
INSERT OR REPLACE INTO Project_BuildingClassRequireds (ProjectType, BuildingClassType)
	SELECT 'PROJECT_' || UnitKey, 'BUILDINGCLASS_MILITARY_ACADEMY'
	FROM Projects INNER JOIN UnitConfiguration ON (Projects.Type = 'PROJECT_' || UnitConfiguration.UnitKey AND UnitConfiguration.ProjTrigger NOT NULL);
	
-- Insert project requirements for Projects
INSERT OR REPLACE INTO Project_Prereqs (ProjectType, PrereqProjectType, AmountNeeded)
	SELECT 'PROJECT_' || UnitKey, PreReqProj, 1
	FROM Projects INNER JOIN UnitConfiguration ON (Projects.Type = 'PROJECT_' || UnitConfiguration.UnitKey AND UnitConfiguration.PreReqProj NOT NULL);
	
-----------------------------------------------
-- Unit Upgrades
-----------------------------------------------

INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
	SELECT 'UNIT_' || UnitKey, 'UNITCLASS_' || UnitConfiguration.UnitClassUpgradeTo
	FROM Units INNER JOIN UnitConfiguration ON (Type = 'UNIT_' || UnitConfiguration.UnitKey AND UnitConfiguration.UnitClassUpgradeTo NOT NULL);

--------------------------------
-- Unit_BuildingClassRequireds
--------------------------------

INSERT INTO Unit_BuildingClassRequireds (UnitType, BuildingClassType)
SELECT Type, 'BUILDINGCLASS_BARRACKS' FROM Units WHERE Class IN('UNITCLASS_INFANTRY', 'UNITCLASS_INFANTRY_2', 'UNITCLASS_MECHANIZED_INFANTRY', 'UNITCLASS_MECHANIZED_INFANTRY_2') UNION ALL
SELECT Type, 'BUILDINGCLASS_FACTORY' FROM Units WHERE Class IN(	'UNITCLASS_OLD_LIGHT_TANK', 'UNITCLASS_LIGHT_TANK', 'UNITCLASS_LIGHT_TANK_2', 'UNITCLASS_LIGHT_TANK_2_B', 'UNITCLASS_LIGHT_TANK_3', 'UNITCLASS_LIGHT_TANK_DESTROYER', 
																'UNITCLASS_LIGHT_TANK_DESTROYER_2', 'UNITCLASS_LIGHT_TANK_DESTROYER_2_B', 'UNITCLASS_LIGHT_TANK_DESTROYER_3', 'UNITCLASS_LIGHT_TANK_DESTROYER_4', 
																'UNITCLASS_LIGHT_TANK_DESTROYER_4_B', 'UNITCLASS_LIGHT_TANK_DESTROYER_4_C', 'UNITCLASS_LIGHT_TANK_DESTROYER_5', 'UNITCLASS_LIGHT_INFANTRY_TANK', 'UNITCLASS_LIGHT_INFANTRY_TANK_B', 
																'UNITCLASS_LIGHT_INFANTRY_TANK_2', 'UNITCLASS_ARTILLERY', 'UNITCLASS_AT_GUN', 'UNITCLASS_AA_GUN', 'UNITCLASS_MECHANIZED_INFANTRY', 'UNITCLASS_MECHANIZED_INFANTRY_2', 'UNITCLASS_FIELD_GUN',
																'UNITCLASS_ANTI_AIRCRAFT_GUN') UNION ALL
SELECT Type, 'BUILDINGCLASS_LAND_FACTORY' FROM Units WHERE Class IN('UNITCLASS_CRUISER_TANK', 'UNITCLASS_CRUISER_TANK_B', 'UNITCLASS_CRUISER_TANK_2', 'UNITCLASS_CRUISER_TANK_2_B', 'UNITCLASS_CRUISER_TANK_3', 'UNITCLASS_CRUISER_TANK_4', 
																	'UNITCLASS_CRUISER_TANK_4_B', 'UNITCLASS_CRUISER_TANK_5', 'UNITCLASS_CRUISER_TANK_5_B', 'UNITCLASS_CRUISER_TANK_5_C', 'UNITCLASS_CRUISER_TANK_6', 'UNITCLASS_CRUISER_TANK_7', 
																	'UNITCLASS_INFANTRY_TANK', 'UNITCLASS_INFANTRY_TANK_2', 'UNITCLASS_OLD_TANK', 'UNITCLASS_TANK', 'UNITCLASS_TANK_B', 'UNITCLASS_TANK_C', 'UNITCLASS_TANK_D', 'UNITCLASS_TANK_E', 
																	'UNITCLASS_TANK_F', 'UNITCLASS_TANK_G', 'UNITCLASS_TANK_2', 'UNITCLASS_TANK_2_B', 'UNITCLASS_TANK_2_C', 'UNITCLASS_TANK_2_D', 'UNITCLASS_TANK_3', 'UNITCLASS_MAIN_BATTLE_TANK',
																	'UNITCLASS_HEAVY_TANK', 'UNITCLASS_HEAVY_TANK_B', 'UNITCLASS_HEAVY_TANK_2', 'UNITCLASS_HEAVY_TANK_2_B', 'UNITCLASS_HEAVY_TANK_2_C', 'UNITCLASS_HEAVY_TANK_2_D', 
																	'UNITCLASS_HEAVY_TANK_3', 'UNITCLASS_SUPER_HEAVY_TANK', 'UNITCLASS_TANK_DESTROYER', 'UNITCLASS_TANK_DESTROYER_B', 'UNITCLASS_TANK_DESTROYER_2', 
																	'UNITCLASS_TANK_DESTROYER_2_B', 'UNITCLASS_TANK_DESTROYER_3', 'UNITCLASS_HEAVY_TANK_DESTROYER', 'UNITCLASS_HEAVY_TANK_DESTROYER_2', 'UNITCLASS_ASSAULT_GUN',
																	'UNITCLASS_ASSAULT_GUN_B', 'UNITCLASS_ASSAULT_GUN_C', 'UNITCLASS_ASSAULT_GUN_2', 'UNITCLASS_ASSAULT_GUN_3', 'UNITCLASS_OLD_HEAVY_ASSAULT_GUN', 
																	'UNITCLASS_HEAVY_ASSAULT_GUN', 'UNITCLASS_HEAVY_ASSAULT_GUN_2', 'UNITCLASS_MOBILE_ARTILLERY', 'UNITCLASS_MOBILE_ARTILLERY_2', 'UNITCLASS_MOBILE_ARTILLERY_3', 
																	'UNITCLASS_MOBILE_ARTILLERY_4', 'UNITCLASS_MOBILE_AA_GUN', 'UNITCLASS_MOBILE_AA_GUN_B', 'UNITCLASS_MOBILE_AA_GUN_2', 'UNITCLASS_MOBILE_AA_GUN_2_B', 'UNITCLASS_MOBILE_AA_GUN_2_C',
																	'UNITCLASS_MOBILE_ARTILLERY_2_D', 'UNITCLASS_MOBILE_ARTILLERY_3') UNION ALL
SELECT Type, 'BUILDINGCLASS_SMALL_AIR_FACTORY' FROM Units WHERE Class IN(	'UNITCLASS_OLD_NAVY_FIGHTER', 'UNITCLASS_NAVY_FIGHTER', 'UNITCLASS_NAVY_FIGHTER_B', 'UNITCLASS_NAVY_FIGHTER_C', 'UNITCLASS_NAVY_FIGHTER_2', 'UNITCLASS_NAVY_FIGHTER_3',
																			'UNITCLASS_OLD_FIGHTER', 'UNITCLASS_FIGHTER', 'UNITCLASS_FIGHTER_B', 'UNITCLASS_FIGHTER_C', 'UNITCLASS_FIGHTER_D', 'UNITCLASS_FIGHTER_2', 'UNITCLASS_FIGHTER_2_B',
																			'UNITCLASS_FIGHTER_2_C', 'UNITCLASS_FIGHTER_2_D', 'UNITCLASS_FIGHTER_3', 'UNITCLASS_JET_FIGHTER', 'UNITCLASS_FIGHTER_BOMBER', 'UNITCLASS_FIGHTER_BOMBER_B', 
																			'UNITCLASS_FIGHTER_BOMBER_2', 'UNITCLASS_FIGHTER_BOMBER_2_B', 'UNITCLASS_ATTACK_AIRCRAFT', 'UNITCLASS_ATTACK_AIRCRAFT_B', 'UNITCLASS_ATTACK_AIRCRAFT_C', 
																			'UNITCLASS_NAVY_BOMBER', 'UNITCLASS_NAVY_BOMBER_2', 'UNITCLASS_TORPEDO_BOMBER') UNION ALL
SELECT Type, 'BUILDINGCLASS_MEDIUM_AIR_FACTORY' FROM Units WHERE Class IN(	'UNITCLASS_NAVY_LIGHT_BOMBER', 'UNITCLASS_NAVY_LIGHT_BOMBER', 'UNITCLASS_FAST_BOMBER', 'UNITCLASS_FAST_BOMBER_2', 'UNITCLASS_JET_BOMBER', 'UNITCLASS_JET_BOMBER_2', 
																			'UNITCLASS_HEAVY_FIGHTER', 'UNITCLASS_HEAVY_FIGHTER_B', 'UNITCLASS_HEAVY_FIGHTER_2', 'UNITCLASS_HEAVY_FIGHTER_3') UNION ALL
SELECT Type, 'BUILDINGCLASS_LARGE_AIR_FACTORY' FROM Units WHERE Class IN( 	'UNITCLASS_BOMBER', 'UNITCLASS_OLD_HEAVY_BOMBER', 'UNITCLASS_HEAVY_BOMBER', 'UNITCLASS_HEAVY_BOMBER_2', 'UNITCLASS_HEAVY_BOMBER_3') UNION ALL
SELECT Type, 'BUILDINGCLASS_SHIPYARD' FROM Units WHERE Class IN( 	'UNITCLASS_BATTLESHIP', 'UNITCLASS_BATTLESHIP_2', 'UNITCLASS_DESTROYER', 'UNITCLASS_DESTROYER_2', 'UNITCLASS_CRUISER', 'UNITCLASS_HEAVY_CRUISER', 'UNITCLASS_DREADNOUGHT', 
																	'UNITCLASS_SUBMARINE', 'UNITCLASS_SUBMARINE_2', 'UNITCLASS_SUBMARINE_3', 'UNITCLASS_CARRIER', 'UNITCLASS_CARRIER_2', 'UNITCLASS_CARRIER_3') UNION ALL
SELECT Type, 'BUILDINGCLASS_MILITARY_ACADEMY' FROM Units WHERE Class IN('UNITCLASS_PARATROOPER', 'UNITCLASS_SPECIAL_FORCES') UNION ALL
SELECT Type, 'BUILDINGCLASS_MILITARY_BASE' FROM Units WHERE Class = 'UNITCLASS_SPECIAL_FORCES';

UPDATE Unit_BuildingClassRequireds SET BuildingClassType = 'BUILDINGCLASS_LEGION_HQ' WHERE UnitType = 'UNIT_FRENCH_FOREIGNLEGION';
UPDATE Unit_BuildingClassRequireds SET BuildingClassType = 'BUILDINGCLASS_SHIPYARD' WHERE UnitType = 'UNIT_RUSSIAN_NAVAL_INFANTRY';
UPDATE Unit_BuildingClassRequireds SET BuildingClassType = 'BUILDINGCLASS_MILITARY_BASE' WHERE UnitType = 'UNIT_AMERICAN_MARINES';
UPDATE Unit_BuildingClassRequireds SET BuildingClassType = 'BUILDINGCLASS_MILITARY_BASE' WHERE UnitType = 'UNIT_GERMAN_SS_INFANTRY';

-----------------------------------------------
-- Stacking weights
-----------------------------------------------
UPDATE Units SET NumberStackingUnits = 1 WHERE Domain = 'DOMAIN_LAND' AND RangedCombat > 0;
UPDATE Units SET NumberStackingUnits = -1 WHERE Class = 'UNITCLASS_CONVOY';

UPDATE Units SET CanCaptureTerritory = 0 WHERE Domain IN('DOMAIN_AIR', 'DOMAIN_SEA') OR (Domain = 'DOMAIN_LAND' and (Range > 0 or Combat = 0));

-----------------------------------------------
-- Hitpoints
-----------------------------------------------
UPDATE Units SET MaxHitPoints = 75 WHERE Domain = 'DOMAIN_AIR';

UPDATE Units SET MaxHitPoints = 100 WHERE Domain = 'DOMAIN_LAND';
UPDATE Units SET MaxHitPoints = 200 WHERE Class = 'UNITCLASS_INFANTRY' OR Class = 'UNITCLASS_MECHANIZED_INFANTRY';
UPDATE Units SET MaxHitPoints = 150 WHERE Class = 'UNITCLASS_INFANTRY_2';

UPDATE Units SET MaxHitPoints = 75 WHERE Domain = 'DOMAIN_LAND' AND (Class LIKE '%TANK_DESTROYER%' OR Class LIKE '%ASSAULT_GUN%' OR Class LIKE '%ARTILLERY%' OR Class LIKE '%AA_GUN%' OR Class LIKE '%ANTI_AIRCRAFT_GUN%' OR Class LIKE '%FIELD_GUN%');
UPDATE Units SET MaxHitPoints = 50 WHERE Domain = 'DOMAIN_LAND' AND (Class LIKE '%FORTIFIED_GUN%');
UPDATE Units SET MaxHitPoints = 100 WHERE Domain = 'DOMAIN_LAND' AND (Class LIKE '%HEAVY%');
UPDATE Units SET MaxHitPoints = 10 WHERE Domain = 'DOMAIN_LAND' AND (Class LIKE '%SPECIAL_FORCES%');

UPDATE Units SET MaxHitPoints = 75 WHERE Domain = 'DOMAIN_SEA';

-----------------------------------------------
-- So the units don't get disbanded
-----------------------------------------------
UPDATE Units SET PrereqTech = 'TECH_BANKING';

-----------------------------------------------
-- Combat limits
-----------------------------------------------
UPDATE Units SET CombatLimit = 200 WHERE Range = 0;
UPDATE Units SET RangedCombatLimit = 200 WHERE Range > 0;

-----------------------------------------------
-- Range to a manageable amount
-----------------------------------------------
UPDATE Units SET Range = ((Range+1) / 2) WHERE Range > 1;

-- 
UPDATE Units SET Cost = Cost * 1.5 WHERE Cost > 0;
Update Projects SET Cost = Cost * 1.5 WHERE Cost > 0;

-----------------------------------------------
-- Delete UnitConfiguration table
-----------------------------------------------

--DROP TABLE UnitConfiguration;

-----------------------------------------------
-- Reset ID 
----------------------------------------------
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Units ORDER by ID;
UPDATE Units SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Units.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

UPDATE sqlite_sequence SET seq = (SELECT COUNT(ID) FROM Civilizations)-1 WHERE name = 'Units';