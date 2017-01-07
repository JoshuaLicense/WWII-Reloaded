print("------------------ Loaded WWIIDefines.lua ------------------")

savedData = Modding.OpenSaveData();

--------------------------------------------------------------------------------------------
-- Operations
--------------------------------------------------------------------------------------------
OPERATION_WESERUBUNG		= GameInfo.Projects.OPERATION_WESERUBUNG.ID
OPERATION_SEELOWE			= GameInfo.Projects.OPERATION_SEELOWE.ID
--OPERATION_CHINA				= GameInfo.Projects.OPERATION_CHINA.ID
--OPERATION_PACIFIC			= GameInfo.Projects.OPERATION_PACIFIC.ID
OPERATION_NORWAY			= GameInfo.Projects.OPERATION_NORWAY.ID
OPERATION_FALLGELB			= GameInfo.Projects.OPERATION_FALLGELB.ID
OPERATION_SONNENBLUME		= GameInfo.Projects.OPERATION_SONNENBLUME.ID
--OPERATION_TWENTYFIVE		= GameInfo.Projects.OPERATION_TWENTYFIVE.ID
--OPERATION_MARITA			= GameInfo.Projects.OPERATION_MARITA.ID
OPERATION_TORCH				= GameInfo.Projects.OPERATION_TORCH.ID
OPERATION_MOTHERLAND	= GameInfo.Projects.OPERATION_MOTHERLAND.ID

--
-- Promotions 
--
--PROMOTION_PARADROP 			= GameInfo.UnitPromotions.PROMOTION_PARADROP.ID
--PROMOTION_LONG_PARADROP 	= GameInfo.UnitPromotions.PROMOTION_LONG_PARADROP.ID
--PROMOTION_AIR_RECON 		= GameInfo.UnitPromotions.PROMOTION_AIR_RECON.ID

--------------------------------------------------------------------------------------------
-- Diplo Enums
--------------------------------------------------------------------------------------------
DOF = 0 -- Declaration of Friendship
DEN = 1 -- Denounciation
DOW = 2 -- Declaration of War
PAL = 3 -- Permanent Alliance
PEA = 4 -- Signe Peace Treaty

--------------------------------------------------------------------------------------------
-- Civilizations
--------------------------------------------------------------------------------------------
FRANCE =	GameInfo.Civilizations.CIVILIZATION_WWII_FRANCE.ID
ENGLAND =	GameInfo.Civilizations.CIVILIZATION_WWII_UK.ID
USSR =		GameInfo.Civilizations.CIVILIZATION_WWII_USSR.ID
GERMANY =	GameInfo.Civilizations.CIVILIZATION_WWII_GERMANY.ID
ITALY =		GameInfo.Civilizations.CIVILIZATION_WWII_ITALY.ID
AMERICA =	GameInfo.Civilizations.CIVILIZATION_WWII_USA.ID
JAPAN =		GameInfo.Civilizations.CIVILIZATION_WWII_JAPAN.ID

for i = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local player = Players[i];
	if (player:IsEverAlive()) then
		local civType = player:GetCivilizationType();
		if(civType == ENGLAND) then
			playerid_ENGLAND = i;
		elseif(civType == GERMANY) then
			playerid_GERMANY = i;
		elseif(civType == FRANCE) then
			playerid_FRANCE = i;
		elseif(civType == ITALY) then
			playerid_ITALY = i;
		elseif(civType == AMERICA) then
			playerid_AMERICA = i;
		elseif(civType == JAPAN) then
			playerid_JAPAN = i;
		elseif(civType == USSR) then
			playerid_USSR = i;
		end
	end
end


--------------------------------------------------------------------------------------------
-- Allies & Axis
--------------------------------------------------------------------------------------------
g_Allied = {
	[FRANCE] =	true,
	[ENGLAND] = true,
	[USSR] =	true,
	[AMERICA] = true,
}

g_Axis = {
	[GERMANY] = true,
	[ITALY] =	true,
	[JAPAN] =	true,
}

--------------------------------------------------------------------------------------------
-- Minor Civs
--------------------------------------------------------------------------------------------
BRITISH_COMMONWEALTH = GameInfo.MinorCivilizations.MINOR_CIV_BRITISH_COMMONWEALTH.ID
DUTCH_EAST_INDIES = GameInfo.MinorCivilizations.MINOR_CIV_DUTCH_EAST_INDIES.ID
ITALIAN_EMPIRE = GameInfo.MinorCivilizations.MINOR_CIV_ITALIAN_EMPIRE.ID
FRENCH_COLONY = GameInfo.MinorCivilizations.MINOR_CIV_FRENCH_COLONY.ID
IRAN = GameInfo.MinorCivilizations.MINOR_CIV_IRAN.ID
YUGOSLAVIA = GameInfo.MinorCivilizations.MINOR_CIV_YUGOSLAVIA.ID
VICHY = GameInfo.MinorCivilizations.MINOR_CIV_VICHY.ID
TURKEY = GameInfo.MinorCivilizations.MINOR_CIV_TURKEY.ID
LATIN_AMERICA = GameInfo.MinorCivilizations.MINOR_CIV_LATIN_AMERICA.ID
POLAND = GameInfo.MinorCivilizations.MINOR_CIV_POLAND.ID
NETHERLANDS = GameInfo.MinorCivilizations.MINOR_CIV_NETHERLANDS.ID
IRELAND = GameInfo.MinorCivilizations.MINOR_CIV_IRELAND.ID
HUNGARY = GameInfo.MinorCivilizations.MINOR_CIV_HUNGARY.ID
THAILAND = GameInfo.MinorCivilizations.MINOR_CIV_THAILAND.ID
SWEDEN = GameInfo.MinorCivilizations.MINOR_CIV_SWEDEN.ID
ARABIA = GameInfo.MinorCivilizations.MINOR_CIV_ARABIA.ID
BELGIUM = GameInfo.MinorCivilizations.MINOR_CIV_BELGIUM.ID
NORWAY = GameInfo.MinorCivilizations.MINOR_CIV_NORWAY.ID
EGYPT = GameInfo.MinorCivilizations.MINOR_CIV_EGYPT.ID
DENMARK = GameInfo.MinorCivilizations.MINOR_CIV_DENMARK.ID
BALTIC_STATES = GameInfo.MinorCivilizations.MINOR_CIV_BALTIC_STATES.ID
NEPAL = GameInfo.MinorCivilizations.MINOR_CIV_NEPAL.ID
ROMANIA = GameInfo.MinorCivilizations.MINOR_CIV_ROMANIA.ID
SWITZERLAND = GameInfo.MinorCivilizations.MINOR_CIV_SWITZERLAND.ID
FINLAND = GameInfo.MinorCivilizations.MINOR_CIV_FINLAND.ID
GREECE = GameInfo.MinorCivilizations.MINOR_CIV_GREECE.ID
IRAQ = GameInfo.MinorCivilizations.MINOR_CIV_IRAQ.ID
BULGARIA = GameInfo.MinorCivilizations.MINOR_CIV_BULGARIA.ID
MONGOLIA = GameInfo.MinorCivilizations.MINOR_CIV_MONGOLIA.ID
CHINA = GameInfo.MinorCivilizations.MINOR_CIV_REPUBLIC_OF_CHINA.ID

--------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------
BARRICADE =			GameInfo.Buildings.BUILDING_WALLS.ID
FACTORY =				GameInfo.Buildings.BUILDING_FACTORY.ID
ARSENAL =				GameInfo.Buildings.BUILDING_ARSENAL.ID
HARBOR =				GameInfo.Buildings.BUILDING_HARBOR.ID
RADIO =					GameInfo.Buildings.BUILDING_BROADCAST_TOWER.ID
BARRACKS =			GameInfo.Buildings.BUILDING_BARRACKS.ID
ACADEMY =				GameInfo.Buildings.BUILDING_MILITARY_ACADEMY.ID
BASE =					GameInfo.Buildings.BUILDING_MILITARY_BASE.ID
BANK =					GameInfo.Buildings.BUILDING_BANK.ID
LAND_FACTORY =	GameInfo.Buildings.BUILDING_LAND_FACTORY.ID
SMALL_AIR_FACTORY =		GameInfo.Buildings.BUILDING_SMALL_AIR_FACTORY.ID
MEDIUM_AIR_FACTORY =	GameInfo.Buildings.BUILDING_MEDIUM_AIR_FACTORY.ID
LARGE_AIR_FACTORY =		GameInfo.Buildings.BUILDING_LARGE_AIR_FACTORY.ID
SHIPYARD =			GameInfo.Buildings.BUILDING_SHIPYARD.ID
OPEN_CITY =			GameInfo.Buildings.BUILDING_OPEN_CITY.ID
LEGION_HQ =			GameInfo.Buildings.BUILDING_LEGION_HQ.ID
SYNTHETIC_FUEL_PLANT =	GameInfo.Buildings.BUILDING_SYNTHETIC_FUEL_PLANT.ID
OIL_REFINERY =	GameInfo.Buildings.BUILDING_OIL_REFINERY.ID

--------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------
SETTLER				= GameInfo.Units.UNIT_SETTLER.ID
--FORTIFIED_GUN		= GameInfo.Units.UNIT_FORTIFIED_GUN.ID
GREAT_GENERAL 		= GameInfo.Units.UNIT_GREAT_GENERAL.ID

-- Infantries -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INFANTRY				= GameInfo.Units.UNIT_INFANTRY.ID -- NumType for unit naming...
FR_INFANTRY				= GameInfo.Units.UNIT_FRENCH_INFANTRY.ID
FR_LEGION				= GameInfo.Units.UNIT_FRENCH_FOREIGNLEGION.ID
US_INFANTRY				= GameInfo.Units.UNIT_AMERICAN_INFANTRY.ID
US_MARINES				= GameInfo.Units.UNIT_AMERICAN_MARINES.ID
GE_INFANTRY				= GameInfo.Units.UNIT_GERMAN_INFANTRY.ID
GE_SS_INFANTRY			= GameInfo.Units.UNIT_GERMAN_SS_INFANTRY.ID
JP_INFANTRY				= GameInfo.Units.UNIT_JAPAN_INFANTRY.ID
UK_INFANTRY				= GameInfo.Units.UNIT_ENGLISH_INFANTRY.ID
IT_INFANTRY				= GameInfo.Units.UNIT_ITALIAN_INFANTRY.ID
RU_INFANTRY				= GameInfo.Units.UNIT_RUSSIAN_INFANTRY.ID
RU_NAVAL_INFANTRY		= GameInfo.Units.UNIT_RUSSIAN_NAVAL_INFANTRY.ID
CH_INFANTRY				= GameInfo.Units.UNIT_CHINESE_INFANTRY.ID
GR_INFANTRY				= GameInfo.Units.UNIT_GREEK_INFANTRY.ID
PL_INFANTRY				= GameInfo.Units.UNIT_POLAND_INFANTRY.ID
HU_INFANTRY				= GameInfo.Units.UNIT_HUNGARY_INFANTRY.ID
DU_INFANTRY				= GameInfo.Units.UNIT_DUTCH_INFANTRY.ID
SP_INFANTRY				= GameInfo.Units.UNIT_SPAIN_INFANTRY.ID
SW_INFANTRY				= GameInfo.Units.UNIT_SWEDEN_INFANTRY.ID

RESISTANCE				= GameInfo.Units.UNIT_RESISTANCE.ID

-- Mechanized Infantries ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MECHANIZED_INFANTRY 	= GameInfo.Units.UNIT_MECHANIZED_INFANTRY.ID -- NumType for unit naming...
GE_MECH_INFANTRY 		= GameInfo.Units.UNIT_GERMAN_MECH_INFANTRY.ID
FR_MECH_INFANTRY 		= GameInfo.Units.UNIT_FRENCH_MECH_INFANTRY.ID
US_MECH_INFANTRY 		= GameInfo.Units.UNIT_AMERICAN_MECH_INFANTRY.ID
RU_MECH_INFANTRY 		= GameInfo.Units.UNIT_RUSSIAN_MECH_INFANTRY.ID
UK_MECH_INFANTRY 		= GameInfo.Units.UNIT_BRITISH_MECH_INFANTRY.ID

-- Paratrooper ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PARATROOPER				= GameInfo.Units.UNIT_PARATROOPER.ID -- NumType for unit naming...
GE_PARATROOPER			= GameInfo.Units.UNIT_GERMAN_PARATROOPER.ID
FR_PARATROOPER			= GameInfo.Units.UNIT_FRENCH_PARATROOPER.ID
GR_PARATROOPER			= GameInfo.Units.UNIT_GREEK_PARATROOPER.ID
JP_PARATROOPER			= GameInfo.Units.UNIT_JAPAN_PARATROOPER.ID
IT_PARATROOPER			= GameInfo.Units.UNIT_ITALIAN_PARATROOPER.ID
CH_PARATROOPER			= GameInfo.Units.UNIT_CHINESE_PARATROOPER.ID
US_PARATROOPER			= GameInfo.Units.UNIT_AMERICAN_PARATROOPER.ID
RU_PARATROOPER			= GameInfo.Units.UNIT_RUSSIAN_PARATROOPER.ID
UK_PARATROOPER			= GameInfo.Units.UNIT_BRITISH_PARATROOPER.ID

-- Special Forces -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SPECIAL_FORCES			= GameInfo.Units.UNIT_SPECIAL_FORCES.ID -- NumType for unit naming...
GE_SPECIAL_FORCES		= GameInfo.Units.UNIT_GERMAN_SPECIAL_FORCES.ID
FR_SPECIAL_FORCES		= GameInfo.Units.UNIT_FRENCH_SPECIAL_FORCES.ID
GR_SPECIAL_FORCES		= GameInfo.Units.UNIT_GREEK_SPECIAL_FORCES.ID
JP_SPECIAL_FORCES		= GameInfo.Units.UNIT_JAPAN_SPECIAL_FORCES.ID
IT_SPECIAL_FORCES		= GameInfo.Units.UNIT_ITALIAN_SPECIAL_FORCES.ID
CH_SPECIAL_FORCES		= GameInfo.Units.UNIT_CHINESE_SPECIAL_FORCES.ID
US_SPECIAL_FORCES		= GameInfo.Units.UNIT_AMERICAN_SPECIAL_FORCES.ID
RU_SPECIAL_FORCES		= GameInfo.Units.UNIT_RUSSIAN_SPECIAL_FORCES.ID
UK_SPECIAL_FORCES		= GameInfo.Units.UNIT_BRITISH_SPECIAL_FORCES.ID

-- TANKS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TANK					= GameInfo.Units.UNIT_TANK_CIV4.ID -- NumType for unit naming...
-- France
FR_AMR35				= GameInfo.Units.UNIT_TANK_AMR35.ID
FR_FCM36				= GameInfo.Units.UNIT_TANK_FCM36.ID
FR_R35					= GameInfo.Units.UNIT_TANK_R35.ID
FR_R35_BONUS			= GameInfo.Units.UNIT_TANK_R35_BONUS.ID
FR_R40					= GameInfo.Units.UNIT_TANK_R40.ID
FR_H35					= GameInfo.Units.UNIT_TANK_H35.ID
FR_H39					= GameInfo.Units.UNIT_TANK_H39.ID
FR_AMC35				= GameInfo.Units.UNIT_TANK_AMC35.ID
FR_CHAR_D1				= GameInfo.Units.UNIT_TANK_CHAR_D1.ID
FR_CHAR_D2				= GameInfo.Units.UNIT_TANK_CHAR_D2.ID
FR_S35					= GameInfo.Units.UNIT_TANK_S35.ID
FR_B1					= GameInfo.Units.UNIT_TANK_B1.ID
FR_ARL44				= GameInfo.Units.UNIT_TANK_ARL44.ID 
FR_CHAR_2C				= GameInfo.Units.UNIT_TANK_CHAR_2C.ID
-- Italy
IT_L6_40				= GameInfo.Units.UNIT_TANK_L6_40.ID
IT_M11_39				= GameInfo.Units.UNIT_TANK_M11_39.ID
IT_M13_40				= GameInfo.Units.UNIT_TANK_M13_40.ID
IT_M14_41				= GameInfo.Units.UNIT_TANK_M14_41.ID
IT_M15_42				= GameInfo.Units.UNIT_TANK_M15_42.ID
IT_P26_40				= GameInfo.Units.UNIT_TANK_P26_40.ID
-- USSR
RU_BT2					= GameInfo.Units.UNIT_TANK_BT2.ID
RU_BT7					= GameInfo.Units.UNIT_TANK_BT7.ID
RU_T26					= GameInfo.Units.UNIT_TANK_T26.ID
RU_T70					= GameInfo.Units.UNIT_TANK_T70.ID
RU_T28					= GameInfo.Units.UNIT_TANK_T28.ID
RU_T34					= GameInfo.Units.UNIT_TANK_T34.ID
RU_T34_76				= GameInfo.Units.UNIT_TANK_T34_76.ID
RU_T34_85				= GameInfo.Units.UNIT_TANK_T34_85.ID
RU_KV1					= GameInfo.Units.UNIT_TANK_KV1.ID
RU_IS_1					= GameInfo.Units.UNIT_TANK_IS_1.ID
RU_IS_2					= GameInfo.Units.UNIT_TANK_IS_2.ID
RU_IS_3					= GameInfo.Units.UNIT_TANK_IS_3.ID
RU_IS_7					= GameInfo.Units.UNIT_TANK_IS_7.ID
-- U.K.
UK_CRUISER_I			= GameInfo.Units.UNIT_TANK_CRUISER_MKI.ID
UK_CRUISER_II			= GameInfo.Units.UNIT_TANK_CRUISER_MKII.ID
UK_CRUISER_III			= GameInfo.Units.UNIT_TANK_CRUISER_MKIII.ID
UK_CRUISER_IV			= GameInfo.Units.UNIT_TANK_CRUISER_MKIV.ID
UK_A10_VALENTINE		= GameInfo.Units.UNIT_TANK_VALENTINE.ID
UK_A13_COVENANTER		= GameInfo.Units.UNIT_TANK_A13_MKIII.ID
UK_A15_CRUSADER			= GameInfo.Units.UNIT_TANK_A15_CRUSADER.ID
UK_A15_CRUSADER_MKIII	= GameInfo.Units.UNIT_TANK_A15_CRUSADER_MKIII.ID
UK_A24					= GameInfo.Units.UNIT_TANK_A24_CAVALIER.ID
UK_A27					= GameInfo.Units.UNIT_TANK_A27_CENTAUR.ID
UK_CROMWELL				= GameInfo.Units.UNIT_TANK_CROMWELL.ID
UK_A30					= GameInfo.Units.UNIT_TANK_A30_CHALLENGER.ID
UK_A34					= GameInfo.Units.UNIT_TANK_A34_COMET.ID
UK_VICKERS_MK6B			= GameInfo.Units.UNIT_TANK_VICKERS_MKVIB.ID
UK_TETRARCH				= GameInfo.Units.UNIT_TANK_TETRARCH.ID
UK_MATILDA_I			= GameInfo.Units.UNIT_TANK_MATILDA_I.ID
UK_M3_GRANT				= GameInfo.Units.UNIT_TANK_M3_GRANT.ID
UK_MATILDA_II			= GameInfo.Units.UNIT_TANK_MATILDA_II.ID
UK_M4_FIREFLY			= GameInfo.Units.UNIT_TANK_M4_FIREFLY.ID
UK_CHURCHILL			= GameInfo.Units.UNIT_TANK_CHURCHILL.ID
UK_A41					= GameInfo.Units.UNIT_TANK_A41_CENTURION.ID
UK_A39					= GameInfo.Units.UNIT_TANK_A39_TORTOISE.ID
-- Germany
GE_PANZER_I				= GameInfo.Units.UNIT_TANK_PANZER_I.ID
GE_PANZER_35			= GameInfo.Units.UNIT_TANK_PANZER_35.ID
GE_PANZER_38			= GameInfo.Units.UNIT_TANK_PANZER_38.ID
GE_PANZER_II			= GameInfo.Units.UNIT_TANK_PANZER_II.ID
GE_PANZER_II_L			= GameInfo.Units.UNIT_TANK_PANZER_II_L.ID
GE_PANZER_III			= GameInfo.Units.UNIT_TANK_PANZER_III.ID
GE_PANZER_III_J			= GameInfo.Units.UNIT_TANK_PANZER_III_J.ID
GE_PANZER_IV			= GameInfo.Units.UNIT_TANK_PANZER_IV.ID
GE_PANZER_IV_G			= GameInfo.Units.UNIT_TANK_PANZER_IV_G.ID
GE_PANZER_IV_H			= GameInfo.Units.UNIT_TANK_PANZER_IV_H.ID
GE_PANZER_V				= GameInfo.Units.UNIT_TANK_PANZER_V_PANTHER.ID
GE_PANZER_VI			= GameInfo.Units.UNIT_TANK_PANZER_VI_TIGER.ID
GE_PANZER_VIB			= GameInfo.Units.UNIT_TANK_PANZER_VIB_TIGER_II.ID
GE_PANZER_VIII			= GameInfo.Units.UNIT_TANK_PANZER_VIII_MAUS.ID
-- Greece
GR_VICKERS_MKE			= GameInfo.Units.UNIT_TANK_VICKERS_MKE_GREECE.ID
GR_VICKERS_MKII			= GameInfo.Units.UNIT_TANK_VICKERS_MKII_GREECE.ID
-- Poland
PL_VICKERS_MKE_A		= GameInfo.Units.UNIT_TANK_VICKERS_MKE_A.ID
PL_7TP					= GameInfo.Units.UNIT_TANK_7TP.ID
PL_10TP					= GameInfo.Units.UNIT_TANK_10TP.ID
-- U.S.A.
US_M3STUART				= GameInfo.Units.UNIT_TANK_M3_STUART.ID
US_M5STUART				= GameInfo.Units.UNIT_TANK_M5_STUART.ID
US_M24CHAFFEE			= GameInfo.Units.UNIT_TANK_M24_CHAFFEE.ID
US_SHERMAN				= GameInfo.Units.UNIT_TANK_SHERMAN.ID
US_SHERMAN_IIA			= GameInfo.Units.UNIT_TANK_SHERMAN_IIA.ID
US_SHERMAN_III			= GameInfo.Units.UNIT_TANK_SHERMAN_III.ID
US_SHERMAN_IIIA			= GameInfo.Units.UNIT_TANK_SHERMAN_IIIA.ID
US_SHERMAN_IV			= GameInfo.Units.UNIT_TANK_SHERMAN_IV.ID
US_SHERMAN_JUMBO		= GameInfo.Units.UNIT_TANK_SHERMAN_JUMBO.ID
US_SHERMAN_EASYEIGHT	= GameInfo.Units.UNIT_TANK_SHERMAN_EASYEIGHT.ID
US_M26_PERSHING			= GameInfo.Units.UNIT_TANK_M26_PERSHING.ID
US_T28_95				= GameInfo.Units.UNIT_TANK_T28_95.ID
-- Japan
JP_TYPE95				= GameInfo.Units.UNIT_TANK_TYPE95.ID
JP_TYPE97_SHINHORO		= GameInfo.Units.UNIT_TANK_TYPE97_SHINHOTO.ID
JP_TYPE97				= GameInfo.Units.UNIT_TANK_TYPE97.ID
JP_TYPE4				= GameInfo.Units.UNIT_TANK_TYPE4_KE_NU.ID
JP_TYPE1				= GameInfo.Units.UNIT_TANK_TYPE1_CHI_HE.ID
JP_TYPE3				= GameInfo.Units.UNIT_TANK_TYPE3_CHI_NU.ID
JP_TYPE4_CHI_TO			= GameInfo.Units.UNIT_TANK_TYPE4_CHI_TO.ID
JP_TYPE5				= GameInfo.Units.UNIT_TANK_TYPE5_CHI_RI.ID
JP_TYPE100				= GameInfo.Units.UNIT_TANK_TYPE100.ID
-- China
CH_T26B					= GameInfo.Units.UNIT_TANK_T26B.ID
-- Hungary
HU_38M_TOLDI			= GameInfo.Units.UNIT_TANK_38M_TOLDI_I.ID
HU_40M_TURAN			= GameInfo.Units.UNIT_TANK_40M_TURAN_I.ID
-- Netherlands
DU_VICKERS_M1936		= GameInfo.Units.UNIT_TANK_VICKERS_M1936.ID
DU_MTSL					= GameInfo.Units.UNIT_TANK_MTSL.ID

-- Assault Guns ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RU_SU122				= GameInfo.Units.UNIT_ASSAULT_GUN_SU122.ID
RU_SU152				= GameInfo.Units.UNIT_ASSAULT_GUN_SU152.ID
RU_KV2					= GameInfo.Units.UNIT_ASSAULT_GUN_KV2.ID
RU_ISU122				= GameInfo.Units.UNIT_ASSAULT_GUN_ISU122.ID
RU_ISU152				= GameInfo.Units.UNIT_ASSAULT_GUN_ISU152.ID
FR_SAU40				= GameInfo.Units.UNIT_ASSAULT_GUN_SAU40.ID
GE_STUG_III				= GameInfo.Units.UNIT_ASSAULT_GUN_STUG_III.ID
GE_STUG_III_F			= GameInfo.Units.UNIT_ASSAULT_GUN_STUG_III_F.ID
GE_STUG_III_G			= GameInfo.Units.UNIT_ASSAULT_GUN_STUG_III_G.ID
GE_STUG_IV				= GameInfo.Units.UNIT_ASSAULT_GUN_STUG_IV.ID
GE_BRUMMBAR				= GameInfo.Units.UNIT_ASSAULT_GUN_BRUMMBAR.ID
GE_STURMTIGER			= GameInfo.Units.UNIT_ASSAULT_GUN_STURMTIGER.ID
IT_SM41					= GameInfo.Units.UNIT_ASSAULT_GUN_M41.ID
JP_TYPE2				= GameInfo.Units.UNIT_ASSAULT_GUN_TYPE2.ID
FI_BT42					= GameInfo.Units.UNIT_ASSAULT_GUN_BT42.ID

-- Tank Destroyer -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FR_W15_TCC				= GameInfo.Units.UNIT_TANK_DESTROYER_W15_TCC.ID
FR_AMR35_ZT3			= GameInfo.Units.UNIT_TANK_DESTROYER_AMR35_ZT3.ID
FR_37L					= GameInfo.Units.UNIT_TANK_DESTROYER_37L.ID
GE_PZJAGER_I			= GameInfo.Units.UNIT_TANK_DESTROYER_PZJ_I.ID
GE_MARDER_II			= GameInfo.Units.UNIT_TANK_DESTROYER_MARDER_II.ID
GE_MARDER_II_D			= GameInfo.Units.UNIT_TANK_DESTROYER_MARDER_II_D.ID
GE_MARDER_I				= GameInfo.Units.UNIT_TANK_DESTROYER_MARDER_I.ID
GE_MARDER_III			= GameInfo.Units.UNIT_TANK_DESTROYER_MARDER_III.ID
GE_MARDER_III_H			= GameInfo.Units.UNIT_TANK_DESTROYER_MARDER_III_H.ID
GE_MARDER_III_M			= GameInfo.Units.UNIT_TANK_DESTROYER_MARDER_III_M.ID
GE_HETZER				= GameInfo.Units.UNIT_TANK_DESTROYER_HETZER.ID
GE_NASHORN				= GameInfo.Units.UNIT_TANK_DESTROYER_NASHORN.ID
GE_PZJ_IV				= GameInfo.Units.UNIT_TANK_DESTROYER_PZJ_IV.ID
GE_PZJ_IV_L70			= GameInfo.Units.UNIT_TANK_DESTROYER_PZJ_IV_L70.ID
GE_JAGDPANTHER			= GameInfo.Units.UNIT_TANK_DESTROYER_JAGDPANTHER.ID
GE_FERDINAND			= GameInfo.Units.UNIT_TANK_DESTROYER_FERDINAND.ID
GE_JAGDTIGER			= GameInfo.Units.UNIT_TANK_DESTROYER_JAGDTIGER.ID
UK_ARCHER				= GameInfo.Units.UNIT_TANK_DESTROYER_ARCHER.ID
US_ACHILLES				= GameInfo.Units.UNIT_TANK_DESTROYER_ACHILLES.ID
RU_ZIS30				= GameInfo.Units.UNIT_TANK_DESTROYER_ZIS30.ID
RU_SU76					= GameInfo.Units.UNIT_TANK_DESTROYER_SU76.ID
RU_SU85					= GameInfo.Units.UNIT_TANK_DESTROYER_SU85.ID
RU_SU100				= GameInfo.Units.UNIT_TANK_DESTROYER_SU100.ID
IT_L40					= GameInfo.Units.UNIT_TANK_DESTROYER_L40.ID
IT_M41					= GameInfo.Units.UNIT_TANK_DESTROYER_M41.ID
IT_M42M					= GameInfo.Units.UNIT_TANK_DESTROYER_M42M.ID
IT_M42T					= GameInfo.Units.UNIT_TANK_DESTROYER_M42T.ID
IT_M43					= GameInfo.Units.UNIT_TANK_DESTROYER_M43.ID
US_M10					= GameInfo.Units.UNIT_TANK_DESTROYER_M10.ID
US_M18					= GameInfo.Units.UNIT_TANK_DESTROYER_M18.ID
US_M36					= GameInfo.Units.UNIT_TANK_DESTROYER_M36.ID
JP_HO_NI_I				= GameInfo.Units.UNIT_TANK_DESTROYER_HO_NI_I.ID
JP_HO_NI_II				= GameInfo.Units.UNIT_TANK_DESTROYER_HO_NI_II.ID
JP_HO_NI_III			= GameInfo.Units.UNIT_TANK_DESTROYER_HO_NI_III.ID
JP_NA_TO				= GameInfo.Units.UNIT_TANK_DESTROYER_NA_TO.ID
YU_SKODA				= GameInfo.Units.UNIT_TANK_DESTROYER_SKODA.ID
RO_TACAM				= GameInfo.Units.UNIT_TANK_DESTROYER_TACAM.ID

-- Artilleries ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ARTILLERY				= GameInfo.Units.UNIT_ARTILLERY.ID
RU_ARTILLERY			= GameInfo.Units.UNIT_ARTILLERY_ML20.ID
AT_GUN					= GameInfo.Units.UNIT_FIELD_GUN.ID
RU_AT_GUN				= GameInfo.Units.UNIT_FIELD_GUN_ZIS3.ID
AA_GUN					= GameInfo.Units.UNIT_ANTI_AIRCRAFT_GUN.ID
-- Mobile Artilleries ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FR_MOBILE_AA_GUN		= GameInfo.Units.UNIT_MOBILE_AA_GUN_HOTCHKISS.ID
RU_ZSU37				= GameInfo.Units.UNIT_MOBILE_AA_GUN_ZSU37.ID
RU_BM13					= GameInfo.Units.UNIT_MOBILE_ARTILLERY_BM13.ID
RU_BM13_16				= GameInfo.Units.UNIT_MOBILE_ARTILLERY_BM13_16.ID
RU_SU26					= GameInfo.Units.UNIT_MOBILE_ARTILLERY_SU26.ID
GE_MOBILE_AA_GUN		= GameInfo.Units.UNIT_MOBILE_AA_GUN_FLK_PZI.ID
GE_MOBILE_AA_38			= GameInfo.Units.UNIT_MOBILE_AA_GUN_FLK_PZ38.ID
GE_MOBILE_AA_MOBEL		= GameInfo.Units.UNIT_MOBILE_AA_GUN_MOBELWAGEN.ID
GE_MOBILE_AA_WIRBEL		= GameInfo.Units.UNIT_MOBILE_AA_GUN_WIRBELWIND.ID
GE_MOBILE_AA_OST		= GameInfo.Units.UNIT_MOBILE_AA_GUN_OSTWIND.ID
GE_MOBILE_AA_KUGEL		= GameInfo.Units.UNIT_MOBILE_AA_GUN_KUGELBLITZ.ID
GE_MOBILE_AA_COELIAN	= GameInfo.Units.UNIT_MOBILE_AA_GUN_COELIAN.ID
GE_MOBILE_BISON			= GameInfo.Units.UNIT_MOBILE_ARTILLERY_BISON.ID
GE_MOBILE_GRILLE		= GameInfo.Units.UNIT_MOBILE_ARTILLERY_GRILLE.ID
GE_MOBILE_WESPE			= GameInfo.Units.UNIT_MOBILE_ARTILLERY_WESPE.ID
GE_MOBILE_HUMMEL		= GameInfo.Units.UNIT_MOBILE_ARTILLERY_HUMMEL.ID
UK_MOBILE_AA_GUN		= GameInfo.Units.UNIT_MOBILE_AA_GUN_CRUSADER.ID
UK_MOBILE_AA_VICKERS	= GameInfo.Units.UNIT_MOBILE_AA_GUN_VICKERS_UK.ID
UK_MOBILE_BISHOP		= GameInfo.Units.UNIT_MOBILE_ARTILLERY_BISHOP.ID
US_M7					= GameInfo.Units.UNIT_MOBILE_ARTILLERY_M7.ID
US_M12					= GameInfo.Units.UNIT_MOBILE_ARTILLERY_M12.ID
US_M40					= GameInfo.Units.UNIT_MOBILE_ARTILLERY_M40.ID
US_SEXTON				= GameInfo.Units.UNIT_MOBILE_ARTILLERY_SEXTON.ID
US_M16A1				= GameInfo.Units.UNIT_MOBILE_AA_GUN_M16A1.ID
IT_AUTOCANNONE			= GameInfo.Units.UNIT_MOBILE_AA_GUN_AUTOCANNONE.ID
JP_TYPE98				= GameInfo.Units.UNIT_MOBILE_AA_GUN_TYPE98.ID
JP_HO_RO				= GameInfo.Units.UNIT_MOBILE_ARTILLERY_HO_RO.ID
JP_HA_TO				= GameInfo.Units.UNIT_MOBILE_ARTILLERY_HA_TO.ID
GR_MOBILE_AA_VICKERS	= GameInfo.Units.UNIT_MOBILE_AA_GUN_VICKERS_GR.ID

-- FIGHTERS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FIGHTER					= GameInfo.Units.UNIT_FIGHTER_CIV4.ID -- NumType for unit naming...
-- Fighters -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FR_MS406				= GameInfo.Units.UNIT_FIGHTER_MS406.ID
FR_HAWK75				= GameInfo.Units.UNIT_FIGHTER_HAWK75.ID
FR_P40					= GameInfo.Units.UNIT_FIGHTER_P40_FRANCE.ID
FR_MB152				= GameInfo.Units.UNIT_FIGHTER_MB152.ID
FR_D520					= GameInfo.Units.UNIT_FIGHTER_D520.ID
FR_D790					= GameInfo.Units.UNIT_FIGHTER_D790.ID
FR_HURRICANE			= GameInfo.Units.UNIT_FIGHTER_HURRICANE_FR.ID
IT_CR42					= GameInfo.Units.UNIT_FIGHTER_CR42.ID
IT_C200					= GameInfo.Units.UNIT_FIGHTER_C200.ID
IT_G50					= GameInfo.Units.UNIT_FIGHTER_G50.ID
IT_C202					= GameInfo.Units.UNIT_FIGHTER_C202.ID
IT_C205					= GameInfo.Units.UNIT_FIGHTER_C205.ID
IT_G55					= GameInfo.Units.UNIT_FIGHTER_G55.ID
IT_CAPRONI				= GameInfo.Units.UNIT_FIGHTER_CAPRONI.ID
RU_I16					= GameInfo.Units.UNIT_FIGHTER_I16.ID
RU_LAGG3				= GameInfo.Units.UNIT_FIGHTER_LAGG3.ID
RU_LA5					= GameInfo.Units.UNIT_FIGHTER_LA5.ID
RU_LA5_V2				= GameInfo.Units.UNIT_FIGHTER_LA5_V2.ID
RU_LA7					= GameInfo.Units.UNIT_FIGHTER_LA7.ID
RU_YAK_7				= GameInfo.Units.UNIT_FIGHTER_YAK7.ID
RU_YAK_9				= GameInfo.Units.UNIT_FIGHTER_YAK9.ID
UK_SPITFIRE				= GameInfo.Units.UNIT_FIGHTER_SPITFIRE.ID
UK_SPITFIRE_V			= GameInfo.Units.UNIT_FIGHTER_SPITFIRE_MKV.ID
UK_SPITFIRE_IX			= GameInfo.Units.UNIT_FIGHTER_SPITFIRE_MKIX.ID
UK_HURRICANE			= GameInfo.Units.UNIT_FIGHTER_HURRICANE.ID
UK_HURRICANE_II			= GameInfo.Units.UNIT_FIGHTER_HURRICANE_MKII.ID
UK_TYPHOON				= GameInfo.Units.UNIT_FIGHTER_TYPHOON.ID
UK_TEMPEST				= GameInfo.Units.UNIT_FIGHTER_TEMPEST.ID
UK_METEOR				= GameInfo.Units.UNIT_FIGHTER_METEOR.ID
GE_BF109				= GameInfo.Units.UNIT_FIGHTER_BF109.ID
GE_BF109_F				= GameInfo.Units.UNIT_FIGHTER_BF109_F.ID
GE_BF109_G				= GameInfo.Units.UNIT_FIGHTER_BF109_G.ID
GE_BF109_T				= GameInfo.Units.UNIT_FIGHTER_BF109_T.ID
GE_FW190				= GameInfo.Units.UNIT_FIGHTER_FW190.ID
GE_ME262				= GameInfo.Units.UNIT_FIGHTER_ME262.ID
US_P36					= GameInfo.Units.UNIT_FIGHTER_P36.ID
US_P40					= GameInfo.Units.UNIT_FIGHTER_P40.ID
US_P47					= GameInfo.Units.UNIT_FIGHTER_P47.ID
US_P51					= GameInfo.Units.UNIT_FIGHTER_P51.ID
US_F2A					= GameInfo.Units.UNIT_FIGHTER_F2A.ID
US_F4U					= GameInfo.Units.UNIT_FIGHTER_F4U.ID
US_F4F					= GameInfo.Units.UNIT_FIGHTER_F4F.ID
US_F6F					= GameInfo.Units.UNIT_FIGHTER_F6F.ID
JP_A5M					= GameInfo.Units.UNIT_FIGHTER_A5M.ID
JP_A6M2					= GameInfo.Units.UNIT_FIGHTER_A6M2_ZERO.ID
JP_A6M5					= GameInfo.Units.UNIT_FIGHTER_A6M5_ZERO.ID
JP_A7M					= GameInfo.Units.UNIT_FIGHTER_A7M.ID
JP_KI43					= GameInfo.Units.UNIT_FIGHTER_KI43.ID
JP_KI44					= GameInfo.Units.UNIT_FIGHTER_KI44.ID
JP_KI84					= GameInfo.Units.UNIT_FIGHTER_KI84.ID
JP_KI61					= GameInfo.Units.UNIT_FIGHTER_KI61.ID
JP_KI100				= GameInfo.Units.UNIT_FIGHTER_KI100.ID
JP_KI100_II				= GameInfo.Units.UNIT_FIGHTER_KI100_II.ID
JP_N1K2					= GameInfo.Units.UNIT_FIGHTER_N1K2.ID
JP_J2M					= GameInfo.Units.UNIT_FIGHTER_J2M.ID
CH_P40N					= GameInfo.Units.UNIT_FIGHTER_P40N_CHINA.ID
PL_P11					= GameInfo.Units.UNIT_FIGHTER_P11.ID
GR_P24					= GameInfo.Units.UNIT_FIGHTER_P24.ID
GR_SPITFIRE				= GameInfo.Units.UNIT_FIGHTER_SPITFIRE_GREECE.ID
DU_FOKKER_DXXI			= GameInfo.Units.UNIT_FIGHTER_FOKKER_DXXI.ID
HU_RE2000				= GameInfo.Units.UNIT_FIGHTER_RE2000.ID
-- Heavy Fighters -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FR_POTEZ630				= GameInfo.Units.UNIT_FIGHTER_POTEZ630.ID
UK_WHIRLWIND			= GameInfo.Units.UNIT_FIGHTER_WHIRLWIND.ID
UK_BEAUFIGHTER			= GameInfo.Units.UNIT_FIGHTER_BEAUFIGHTER.ID
GE_BF110				= GameInfo.Units.UNIT_FIGHTER_BF110.ID
GE_BF110_F4				= GameInfo.Units.UNIT_FIGHTER_BF110_F4.ID
GE_JU88_C				= GameInfo.Units.UNIT_FIGHTER_JU88_C.ID
GE_HE219				= GameInfo.Units.UNIT_FIGHTER_HE219.ID
US_P38					= GameInfo.Units.UNIT_FIGHTER_P38.ID
DU_FOKKER_GI			= GameInfo.Units.UNIT_FIGHTER_FOKKER_GI.ID
						
-- BOMBERS --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BOMBER					= GameInfo.Units.UNIT_BOMBER.ID -- NumType for unit naming...
-- Attack Aircrafts -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FR_LN401				= GameInfo.Units.UNIT_BOMBER_LN401.ID
IT_BA65					= GameInfo.Units.UNIT_BOMBER_BA65.ID
GE_JU87					= GameInfo.Units.UNIT_BOMBER_JU87.ID
GE_JU87T				= GameInfo.Units.UNIT_BOMBER_JU87T.ID
RU_IL2					= GameInfo.Units.UNIT_BOMBER_IL2.ID
RU_IL2M3				= GameInfo.Units.UNIT_BOMBER_IL2M3.ID
RU_IL10					= GameInfo.Units.UNIT_BOMBER_IL10.ID
JP_AICHI				= GameInfo.Units.UNIT_BOMBER_AICHI.ID
GR_FAIREY				= GameInfo.Units.UNIT_BOMBER_FAIREY.ID
UK_SWORDFISH			= GameInfo.Units.UNIT_BOMBER_SWORDFISH.ID
-- Fast/Light Bombers ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FR_AMIOT350				= GameInfo.Units.UNIT_BOMBER_AMIOT350.ID
FR_BR690				= GameInfo.Units.UNIT_BOMBER_BR690.ID
FR_BR810				= GameInfo.Units.UNIT_BOMBER_BR810.ID
UK_MOSQUITO				= GameInfo.Units.UNIT_BOMBER_MOSQUITO.ID
RU_PE2					= GameInfo.Units.UNIT_BOMBER_PE2.ID
RU_TU2					= GameInfo.Units.UNIT_BOMBER_TU2.ID
IT_SM79					= GameInfo.Units.UNIT_BOMBER_SM79.ID
GE_JU88					= GameInfo.Units.UNIT_BOMBER_JU88.ID
GE_AR234				= GameInfo.Units.UNIT_BOMBER_AR234.ID
GE_HO229				= GameInfo.Units.UNIT_BOMBER_HO229.ID
US_A20					= GameInfo.Units.UNIT_BOMBER_A20.ID
PL_PZL37				= GameInfo.Units.UNIT_BOMBER_PZL37.ID
JP_G4M3					= GameInfo.Units.UNIT_BOMBER_G4M3.ID
-- Medium Bombers -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IT_SM84					= GameInfo.Units.UNIT_BOMBER_SM84.ID
UK_WELLINGTON			= GameInfo.Units.UNIT_BOMBER_WELLINGTON.ID
GE_HE111				= GameInfo.Units.UNIT_BOMBER_HE111.ID
RU_IL4					= GameInfo.Units.UNIT_BOMBER_IL4.ID
JP_KI21					= GameInfo.Units.UNIT_BOMBER_KI21.ID
US_B25					= GameInfo.Units.UNIT_BOMBER_B25.ID
CH_B25					= GameInfo.Units.UNIT_BOMBER_B25_CHINA.ID
GR_BLENHEIM				= GameInfo.Units.UNIT_BOMBER_BLENHEIM_GREECE.ID
DU_FOKKER_TV			= GameInfo.Units.UNIT_BOMBER_FOKKER_TV.ID
HU_CA135				= GameInfo.Units.UNIT_BOMBER_CA135.ID
-- Heavy Bombers --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RU_TB3					= GameInfo.Units.UNIT_BOMBER_TB3.ID
RU_PE8					= GameInfo.Units.UNIT_BOMBER_PE8.ID
GE_HE177				= GameInfo.Units.UNIT_BOMBER_HE177.ID
UK_HALIFAX				= GameInfo.Units.UNIT_BOMBER_HALIFAX.ID
UK_LANCASTER			= GameInfo.Units.UNIT_BOMBER_LANCASTER.ID
US_B17					= GameInfo.Units.UNIT_BOMBER_B17.ID
US_B24					= GameInfo.Units.UNIT_BOMBER_B24.ID
US_B29					= GameInfo.Units.UNIT_BOMBER_B29.ID
						
-- Convoy ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CONVOY					= GameInfo.Units.UNIT_CONVOY.ID
						
-- Destroyers -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DESTROYER				= GameInfo.Units.UNIT_DESTROYER.ID -- NumType for unit naming...
FR_FANTASQUE			= GameInfo.Units.UNIT_DESTROYER_FANTASQUE.ID
GE_DESTROYER			= GameInfo.Units.UNIT_DESTROYER_TYPE_1934A.ID
UK_TRIBA				= GameInfo.Units.UNIT_DESTROYER_TRIBA.ID
RU_GNEVNY				= GameInfo.Units.UNIT_DESTROYER_GNEVNY.ID
IT_SOLDATI				= GameInfo.Units.UNIT_DESTROYER_SOLDATI.ID
US_FLETCHER				= GameInfo.Units.UNIT_DESTROYER_FLETCHER.ID
JP_KAGERO				= GameInfo.Units.UNIT_DESTROYER_KAGERO.ID
GR_GEORGIOS				= GameInfo.Units.UNIT_DESTROYER_GEORGIOS.ID
						
-- Cruisers -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CRUISER					= GameInfo.Units.UNIT_CRUISER.ID -- NumType for unit naming...
FR_GALISSONIERE			= GameInfo.Units.UNIT_CRUISER_GALISSONIERE.ID 
GE_LEIPZIG				= GameInfo.Units.UNIT_CRUISER_LEIPZIG.ID 
UK_DIDO					= GameInfo.Units.UNIT_CRUISER_DIDO.ID 
RU_KIROV				= GameInfo.Units.UNIT_CRUISER_KIROV.ID
US_BALTIMORE			= GameInfo.Units.UNIT_CRUISER_BALTIMORE.ID
JP_TAKAO				= GameInfo.Units.UNIT_CRUISER_TAKAO.ID
GR_PISA					= GameInfo.Units.UNIT_CRUISER_PISA.ID 
						
-- Heavy Cruisers -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
HEAVY_CRUISER			= GameInfo.Units.UNIT_HEAVY_CRUISER.ID -- NumType for unit naming...
GE_DEUTSCHLAND			= GameInfo.Units.UNIT_HEAVY_CRUISER_DEUTSCHLAND.ID 
IT_ZARA					= GameInfo.Units.UNIT_HEAVY_CRUISER_ZARA.ID 
						
-- Dreadnought ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DREADNOUGHT				= GameInfo.Units.UNIT_DREADNOUGHT.ID -- NumType for unit naming...
UK_ELIZABETH			= GameInfo.Units.UNIT_DREADNOUGHT_ELIZABETH.ID 
RU_GANGUT				= GameInfo.Units.UNIT_DREADNOUGHT_GANGUT.ID 
IT_DI_CAVOUR			= GameInfo.Units.UNIT_DREADNOUGHT_DI_CAVOUR.ID 
						
-- battleships ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BATTLESHIP				= GameInfo.Units.UNIT_BATTLESHIP.ID -- NumType for unit naming...
--BATTLESHIP_2			= GameInfo.Units.UNIT_BATTLESHIP_2.ID -- NumType for unit naming...
FR_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_DUNKERQUE.ID
FR_BATTLESHIP_2			= GameInfo.Units.UNIT_BATTLESHIP_RICHELIEU.ID
UK_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_ADMIRAL.ID
UK_BATTLESHIP_2			= GameInfo.Units.UNIT_BATTLESHIP_GEORGE_V.ID
GE_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_SCHARNHORST.ID
GE_BATTLESHIP_2			= GameInfo.Units.UNIT_BATTLESHIP_BISMARK.ID
IT_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_LITTORIO.ID
RU_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_SOYUZ.ID
US_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_SOUTH_DAKOTA.ID
US_BATTLESHIP_2			= GameInfo.Units.UNIT_BATTLESHIP_IOWA.ID
JP_BATTLESHIP			= GameInfo.Units.UNIT_BATTLESHIP_KONGO.ID
JP_BATTLESHIP_2			= GameInfo.Units.UNIT_BATTLESHIP_YAMOTO.ID
						
-- Submarines -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SUBMARINE				= GameInfo.Units.UNIT_SUBMARINE.ID -- NumType for unit naming...
SUBMARINE_2				= GameInfo.Units.UNIT_SUBMARINE_2.ID
SUBMARINE_3				= GameInfo.Units.UNIT_SUBMARINE_3.ID
FR_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_REDOUTABLE.ID
IT_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_MARCELLO.ID
UK_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_TCLASS.ID
RU_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_SHCHUKA.ID
GE_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_U_BOAT.ID
PL_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_ORZEL.ID
US_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_GATO.ID
JP_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_B1.ID
GR_SUBMARINE			= GameInfo.Units.UNIT_SUBMARINE_KATSONIS.ID
-- Carrier --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CARRIER					= GameInfo.Units.UNIT_CARRIER.ID -- NumType for unit naming...
US_CARRIER				= GameInfo.Units.UNIT_CARRIER_YORKTOWN.ID
JP_CARRIER				= GameInfo.Units.UNIT_CARRIER_KAGA.ID
FR_CARRIER				= GameInfo.Units.UNIT_CARRIER_JOFFRE.ID

CARRIER_2				= GameInfo.Units.UNIT_CARRIER_2.ID
CARRIER_3				= GameInfo.Units.UNIT_CARRIER_3.ID

--------------------------------------------------------------------------------------------
-- Cities
--------------------------------------------------------------------------------------------
g_Cities = {
	-- UK
	{X = 12, Y = 72, Buildings = { HARBOR, BANK, FACTORY }, }, -- LONDON
	{X = 9, Y = 70, Buildings = { HARBOR }, }, -- LIVERPOOL
	{X = 9, Y = 79, Buildings = { HARBOR, OIL_REFINERY }, }, -- EDINBURGH
	
	{X = 20, Y = 51, Buildings = { HARBOR, BARRICADE }, }, -- MALTA
	{X = 34, Y = 53, Buildings = { HARBOR }, }, -- NICOSIA
	{X = 32, Y = 47, Buildings = { HARBOR, BARRICADE }, }, -- SUEZ
	{X = 166, Y = 72, Buildings = { HARBOR }, }, -- ST JOHNS
	{X = 7, Y = 52, Buildings = { HARBOR, BARRICADE }, }, -- GIBRALTER
	{X = 84, Y = 48, Buildings = { HARBOR, BARRICADE }, }, -- HONG KONG
	{X = 161, Y = 5, Buildings = { HARBOR }, }, -- STANLEY
	-- BCW
	{X = 104, Y = 13, Buildings = { HARBOR }, }, -- SYDNEY
	{X = 112, Y = 12, Buildings = { HARBOR }, }, -- AUKLAND
	{X = 101, Y = 29, Buildings = { HARBOR }, }, -- PORT MORESBY
	{X = 78, Y = 32, Buildings = { HARBOR }, }, -- SINGAPORE
	{X = 53, Y = 48, Buildings = { HARBOR }, }, -- KARACHI
	{X = 33, Y = 41, Buildings = { HARBOR }, }, -- PORT SUDAN
	{X = 161, Y = 40, Buildings = { HARBOR }, }, -- GEORGETOWN
	{X = 153, Y = 46, Buildings = { HARBOR }, }, -- KINGSTON
	{X = 156, Y = 71, Buildings = { HARBOR }, }, -- QUEBEC CITY
	{X = 131, Y = 71, Buildings = { HARBOR }, }, -- VANCOUVER
	{X = 45, Y = 43, Buildings = { HARBOR }, }, -- MUSCAT
	{X = 39, Y = 38, Buildings = { HARBOR }, }, -- SANA'A
	{X = 35, Y = 49, Buildings = { HARBOR }, }, -- JERUSALEM
	{X = 33, Y = 26, Buildings = { HARBOR }, }, -- MOMBASA
	{X = 24, Y = 7, Buildings = { HARBOR }, }, -- CAPE TOWN
	{X = 13, Y = 33, Buildings = { HARBOR }, }, -- ACCRA
	{X = 6, Y = 35, Buildings = { HARBOR }, }, -- FREETOWN
	{X = 16, Y = 34, Buildings = { HARBOR }, }, -- LAGOS
	{X = 57, Y = 43, Buildings = { HARBOR }, }, -- BOMBAY
	{X = 72, Y = 42, Buildings = { HARBOR }, }, -- RANGOON
	-- FR
	{X = 13, Y = 66, Buildings = { OPEN_CITY, BANK }, }, -- PARIS
	{X = 15, Y = 60, Buildings = { HARBOR }, }, -- MARSEILLE
	{X = 10, Y = 69, Buildings = { HARBOR }, }, -- CHERBOURG
	{X = 7, Y = 67, Buildings = { HARBOR }, }, -- BREST
	{X = 11, Y = 48, Buildings = { LEGION_HQ }, }, -- SIDI BEL ABBES
	-- FR EM
	{X = 6, Y = 48, Buildings = { HARBOR }, }, -- CASABLANCA
	{X = 13, Y = 50, Buildings = { HARBOR }, }, -- ALGIERS
	{X = 17, Y = 51, Buildings = { HARBOR }, }, -- TUNIS
	{X = 38, Y = 19, Buildings = { HARBOR }, }, -- ANTANANARIVO	
	{X = 8, Y = 32, Buildings = { HARBOR }, }, -- MORNROVIA	
	{X = 79, Y = 38, Buildings = { HARBOR }, }, -- SAIGON	
	{X = 164, Y = 38, Buildings = { HARBOR }, }, -- CAYENNE	
	-- IT
	{X = 20, Y = 58, Buildings = { HARBOR, RADIO }, }, -- ROME
	{X = 22, Y = 56, Buildings = { HARBOR }, }, -- NANTES
	{X = 31, Y = 54, Buildings = { HARBOR }, }, -- RHODES
	-- IT EM
	{X = 26, Y = 48, Buildings = { HARBOR }, }, -- BENGHAZI
	{X = 19, Y = 47, Buildings = { HARBOR }, }, -- TRIPOLI
	{X = 36, Y = 30, Buildings = { HARBOR }, }, -- MOGADISHU
	{X = 34, Y = 39, Buildings = { HARBOR }, }, -- ASMARA
	-- GE
	{X = 19, Y = 73, Buildings = { HARBOR, SHIPYARD }, }, -- KIEL
	{X = 19, Y = 72, Buildings = { FACTORY, OIL_REFINERY }, }, -- HAMBURG
	{X = 26, Y = 73, Buildings = { HARBOR }, }, -- KONIGSBERG
	{X = 17, Y = 69, Buildings = { BARRICADE, SYNTHETIC_FUEL_PLANT, FACTORY, }, }, -- COLOGNE
	{X = 22, Y = 70, Buildings = { RADIO, BASE, BANK }, }, -- BERLIN
	{X = 20, Y = 66, Buildings = { SMALL_AIR_FACTORY, MEDIUM_AIR_FACTORY }, }, -- MUNICH
	-- USSR
	{X = 34, Y = 89, Buildings = { HARBOR }, }, -- MURMANSK
	{X = 31, Y = 78, Buildings = { HARBOR, BARRICADE }, }, -- LENINGRAD
	{X = 36, Y = 64, Buildings = { HARBOR }, }, -- SEVASTOPOL
	{X = 94, Y = 69, Buildings = { HARBOR }, }, -- VLADIVOSTOK
	{X = 38, Y = 73, Buildings = { RADIO, BARRACKS }, }, -- MOSCOW
	{X = 41, Y = 68, Buildings = { BARRACKS }, }, -- STALINGRAD
	-- CH (Captured Japan)
	{X = 87, Y = 56, Buildings = { HARBOR }, }, -- SHANGHAI	
	{X = 83, Y = 64, Buildings = { BARRACKS, RADIO}, }, -- BEIJING
	-- CH
	{X = 76, Y = 54, Buildings = { RADIO, BARRACKS, BANK }, }, -- CHONGQING	
	-- JP
	{X = 97, Y = 58, Buildings = { HARBOR, SHIPYARD, RADIO }, }, -- TOKYO
	{X = 93, Y = 57, Buildings = { HARBOR, SMALL_AIR_FACTORY, MEDIUM_AIR_FACTORY }, }, -- OSAKA
	{X = 90, Y = 54, Buildings = { HARBOR }, }, -- NAGASAKI	
	{X = 89, Y = 61, Buildings = { HARBOR, BARRACKS }, }, -- SEOUL
	{X = 89, Y = 64, Buildings = { BARRACKS, RADIO }, }, -- PYONGYANG
	{X = 87, Y = 67, Buildings = { HARBOR }, }, -- PYONGYANG
	{X = 97, Y = 68, Buildings = { HARBOR }, }, -- SAPPORO
	-- US
	{X = 154, Y = 63, Buildings = { HARBOR, BANK }, }, -- WASHINGTON
	{X = 155, Y = 65, Buildings = { HARBOR, BANK }, }, -- NEW YORK
	{X = 150, Y = 66, Buildings = { FACTORY }, }, -- DETROIT
	{X = 131, Y = 60, Buildings = { HARBOR }, }, -- LOS ANGELES
	{X = 130, Y = 64, Buildings = { HARBOR }, }, -- SAN FRANCISCO
	{X = 150, Y = 40, Buildings = { HARBOR }, }, -- PANAMA
	{X = 119, Y = 50, Buildings = { HARBOR }, }, -- HONOLULU
	{X = 110, Y = 54, Buildings = { HARBOR }, }, -- MIDWAY
	{X = 88, Y = 42, Buildings = { HARBOR }, }, -- MANILA
	-- MISC
	{X = 28, Y = 56, Buildings = { HARBOR }, }, -- ATHENS
	{X = 26, Y = 58, Buildings = { HARBOR }, }, -- TIRANE
	
	{X = 21, Y = 75, Buildings = { HARBOR }, }, -- COPENHAGEN
	
	{X = 24, Y = 79, Buildings = { HARBOR }, }, -- STOCKHOLM
	{X = 26, Y = 86, Buildings = { HARBOR }, }, -- LULEA
	{X = 20, Y = 79, Buildings = { HARBOR }, }, -- OSLO
	{X = 22, Y = 89, Buildings = { HARBOR }, }, -- NARVIK
	{X = 28, Y = 79, Buildings = { HARBOR, BARRICADE }, }, -- HELSINKI
	{X = 28, Y = 85, Buildings = { HARBOR }, }, -- OULU
	
	{X = 27, Y = 75, Buildings = { HARBOR }, }, -- RIGA
	{X = 23, Y = 73, Buildings = { HARBOR }, }, -- DANZIG
	
	{X = 16, Y = 72, Buildings = { HARBOR }, }, -- AMSTERDAM
	{X = 15, Y = 70, Buildings = { HARBOR }, }, -- BRUSSELS
	
	{X = 10, Y = 57, Buildings = { HARBOR }, }, -- BARCELONA
	
	{X = 4, Y = 55, Buildings = { HARBOR }, }, -- LISBON
	{X = 20, Y = 22, Buildings = { HARBOR }, }, -- LUANDA
	{X = 31, Y = 15, Buildings = { HARBOR }, }, -- LOURENCO MARQUES
	
	{X = 42, Y = 49, Buildings = { HARBOR }, }, -- BANDAR SHAHPUR
	
	{X = 31, Y = 59, Buildings = { HARBOR }, }, -- ISTANBUL
	
	{X = 75, Y = 40, Buildings = { HARBOR }, }, -- BANGKOK
	
	{X = 73, Y = 33, Buildings = { HARBOR }, }, -- MEDAN
	{X = 81, Y = 26, Buildings = { HARBOR }, }, -- BATAVIA
	{X = 84, Y = 28, Buildings = { HARBOR }, }, -- BANJARMASEN
	{X = 88, Y = 32, Buildings = { HARBOR }, }, -- MANADO
	{X = 96, Y = 32, Buildings = { HARBOR }, }, -- JAYAPURA
	{X = 162, Y = 38, Buildings = { HARBOR }, }, -- PARAMARIBO
	
	{X = 1, Y = 83, Buildings = { HARBOR }, }, -- REYKJAVIC	
}

--------------------------------------------------------------------------------------------
-- Calendar
--------------------------------------------------------------------------------------------
g_Calendar = {}

local monthList = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
local dayList = { "1", "5", "10", "15", "20", "25" }
local turn = 0

for year = 1939, 1946 do -- see large
	for month = 1, #monthList do
		for day = 1, #dayList do
			local bStart = (month >= 7 and year == 1939) -- Start date = july, 1st 1939
			if bStart or (year > 1939) then
				local numMonth, numDay
				if month < 10 then numMonth = "0"..month; else numMonth = month; end
				if tonumber(dayList[day]) < 10 then numDay = "0"..dayList[day]; else numDay = dayList[day]; end
				g_Calendar[turn] = { Text = monthList[month] .. " " .. dayList[day] .. ", " .. year, Number = tonumber(year..numMonth..numDay)}
				turn = turn + 1
			end		
		end
	end
end