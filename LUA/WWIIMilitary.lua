print("------------------ Loaded WWIIMilitary.lua ------------------")

g_Initial_OOB = {
	-- FR
	{Name = "French army", 				X = 13, Y = 66, Domain = "Land", 	CivID = FRANCE,		Group = {FR_INFANTRY, FR_AMR35, FR_B1, FR_S35, ARTILLERY} },
	--{Name = "French AI army",			X = 12, Y = 63, Domain = "Land", AI = true, CivID = FRANCE, Group = {FR_INFANTRY, FR_INFANTRY, FR_CHAR_D1, AT_GUN} },
	
	{Name = "French metr. aviation",	X = 13, Y = 66, Domain = "Air", 	CivID = FRANCE, 	Group = {FR_HAWK75, FR_MS406} },
	--{Name = "French metr. aviation",	X = 13, Y = 66, Domain = "Air", AI = true, CivID = FRANCE, Group = {FR_MS406, FR_MB152} },
	
	{Name = "French Mediteranean fleet",X = 15, Y = 58, Domain = "Sea", 	CivID = FRANCE,		Group = {FR_FANTASQUE, FR_FANTASQUE, FR_FANTASQUE, FR_SUBMARINE, FR_SUBMARINE, FR_BATTLESHIP_2, FR_BATTLESHIP} },
	{Name = "French Oceanic fleet",		X = 7, Y = 63, 	Domain = "Sea", 	CivID = FRANCE, 	Group = {FR_FANTASQUE,  FR_GALISSONIERE, FR_SUBMARINE} },
	-- EN
	{Name = "England army", 			X = 12, Y = 74, Domain = "Land", 	CivID = ENGLAND,	Group = {UK_INFANTRY, UK_TETRARCH, ARTILLERY}, UnitsXP = {30, 30, 15} },
	{Name = "England Exped. corp Egypt",X = 30, Y = 46, Domain = "Land", 	CivID = ENGLAND, 	Group = {UK_INFANTRY, UK_CRUISER_I, UK_VICKERS_MK6B} },	
	
	{Name = "Commonwealth Africa",		X = 28, Y = 14, Domain = "Land", 	IsMinor = true, 	CivID = BRITISH_COMMONWEALTH, Group = {UK_INFANTRY} },	
	{Name = "Commonwealth India",		X = 60, Y = 51, Domain = "Land", 	IsMinor = true, 	CivID = BRITISH_COMMONWEALTH, Group = {UK_INFANTRY, UK_INFANTRY} },	
	{Name = "Commonwealth Australia",	X = 104, Y = 13,Domain = "Land", 	IsMinor = true, 	CivID = BRITISH_COMMONWEALTH, Group = {UK_INFANTRY} },	
	{Name = "Commonwealth North Africa",X = 35, Y = 49, Domain = "Land", 	IsMinor = true, 	CivID = BRITISH_COMMONWEALTH, Group = {UK_INFANTRY} },	
	
	{Name = "England Metropole RAF", 	X = 12, Y = 72, Domain = "Air", 	CivID = ENGLAND, 	Group = {UK_SPITFIRE, UK_HURRICANE, UK_WELLINGTON} },
	--{Name = "England Metr. RAF AI", 	X = 12, Y = 72, Domain = "Air", AI = true, CivID = ENGLAND, Group = {UK_SPITFIRE } },
	{Name = "England Malta RAF", 		X = 20, Y = 51, Domain = "Air", 	CivID = ENGLAND, 	Group = {UK_HURRICANE} },
	--{Name = "England Egypt RAF", 		X = 32, Y = 47, Domain = "Air", 	CivID = ENGLAND, 	Group = {UK_HURRICANE} },
	
	{Name = "England Home fleet", 		X = 14, Y = 78, Domain = "Sea", 	CivID = ENGLAND, 	Group = {UK_TRIBA, UK_TRIBA, UK_DIDO, UK_DIDO, UK_BATTLESHIP, UK_BATTLESHIP_2, UK_ELIZABETH} },
	{Name = "England Atlantic fleet", 	X = 4, Y = 70, 	Domain = "Sea", 	CivID = ENGLAND, 	Group = {UK_TRIBA} },
	{Name = "England Med. fleet", 		X = 11, Y = 53, Domain = "Sea", 	CivID = ENGLAND, 	Group = {UK_TRIBA, UK_TRIBA, UK_SUBMARINE, UK_ELIZABETH} },
	{Name = "England Pacific fleet", 	X = 84, Y = 43, Domain = "Sea", 	CivID = ENGLAND, 	Group = {UK_TRIBA, UK_DIDO, UK_SUBMARINE, UK_BATTLESHIP} },
	--{Name = "England AI Bonus", 		X = 8, Y = 81, 	Domain = "Sea", AI = true, CivID = ENGLAND, Group = {UK_TRIBA, UK_TRIBA, UK_DIDO} },
	
	-- GE
	{Name = "German central army", 		X = 22, Y = 70, Domain = "Land", 	CivID = GERMANY, 	Group = {GE_INFANTRY, GE_INFANTRY, GE_PANZER_III, GE_PANZER_I, ARTILLERY, } },
	{Name = "German west army", 		X = 17, Y = 69, Domain = "Land", 	CivID = GERMANY, 	Group = {GE_INFANTRY, GE_INFANTRY, GE_SS_INFANTRY, GE_PANZER_III, GE_PANZER_I, ARTILLERY} },
	{Name = "German prussia army", 		X = 26, Y = 73, Domain = "Land", 	CivID = GERMANY, 	Group = {GE_INFANTRY} },
	--{Name = "German central AI army", X = 18, Y = 67, Domain = "Land", AI = true, CivID = GERMANY, Group = {GE_INFANTRY, GE_PANZER_I, GE_PANZER_III, GE_PANZER_IV, AT_GUN}, UnitsXP = {30,30,45,45,30,15}, },
	--{Name = "German east AI army",	X = 22, Y = 66, Domain = "Land", AI = true, CivID = GERMANY, Group = {GE_INFANTRY, GE_PANZER_II, GE_PANZER_III, GE_PANZER_IV, AT_GUN}, UnitsXP = {30,30,45,45,30,15}, },
	
	{Name = "German Luftwaffe", 		X = 22, Y = 70, Domain = "Air", 	CivID = GERMANY,	Group = {GE_BF109, GE_BF109, GE_HE111, GE_JU87,} },
	--{Name = "German Luft. AI Bonus",	X = 20, Y = 66, Domain = "Air", AI = true, CivID = GERMANY, Group = {GE_HE111, GE_HE111,} },
	
	{Name = "German Fleet", 			X = 21, Y = 73, Domain = "Sea", 	CivID = GERMANY, 	Group = {GE_BATTLESHIP_2, GE_DESTROYER, GE_BATTLESHIP, GE_SUBMARINE } },
	--{Name = "German Sub. AI bonus", 	X = 174, Y = 63,Domain = "Sea", AI = true, CivID = GERMANY, Group = { GE_SUBMARINE, GE_SUBMARINE, GE_SUBMARINE, GE_SUBMARINE,} },

	-- IT
	{Name = "Italian army", 			X = 20, Y = 59, Domain = "Land", 	CivID = ITALY, 		Group = {IT_INFANTRY, IT_INFANTRY, IT_M11_39} },
	{Name = "Italian colonial army",	X = 26, Y = 44, Domain = "Land", 	CivID = ITALY, 		Group = {IT_INFANTRY, IT_INFANTRY, IT_M11_39, IT_M11_39, ARTILLERY} },
	
	{Name = "Italian colonial army",	X = 32, Y = 33, Domain = "Land",  	IsMinor = true,		CivID = ITALIAN_EMPIRE, Group = {IT_INFANTRY, IT_INFANTRY} },
	{Name = "Italian air", 				X = 20, Y = 58, Domain = "Air", 	CivID = ITALY, 		Group = {IT_CR42, IT_CR42, IT_CR42} },
	--{Name = "Italian air AI Bonus", 	X = 20, Y = 58, 	Domain = "Air", AI = true, CivID = ITALY, Group = {IT_CR42, IT_SM79} },
	
	{Name = "Italian west fleet", 		X = 18, Y = 57, Domain = "Sea", 	CivID = ITALY, 		Group = {IT_SOLDATI} },
	{Name = "Italian east fleet", 		X = 24, Y = 53, Domain = "Sea", 	CivID = ITALY, 		Group = {IT_SOLDATI, IT_SOLDATI, IT_ZARA, IT_DI_CAVOUR, IT_SUBMARINE, IT_SUBMARINE, IT_BATTLESHIP} },
	-- US (17th Largest Army at the time - No army/airforce)
	{Name = "American Pacific fleet", 	X = 127, Y = 63,Domain = "Sea", 	CivID = AMERICA, 	Group = {US_BATTLESHIP, US_CARRIER, US_FLETCHER, US_FLETCHER, US_BALTIMORE, US_BALTIMORE, US_SUBMARINE} },
	{Name = "American Atlantic Fleet", 	X = 158, Y = 64,Domain = "Sea", 	CivID = AMERICA, 	Group = {US_BATTLESHIP, US_FLETCHER, US_FLETCHER, US_BALTIMORE, US_FLETCHER,} },
	{Name = "American Panama Fleet", 	X = 151, Y = 41,Domain = "Sea", 	CivID = AMERICA, 	Group = {US_SUBMARINE, US_SUBMARINE} },
	-- USSR
	{Name = "USSR central army", 		X = 38, Y = 73, Domain = "Land", 	CivID = USSR,		Group = {RU_INFANTRY, } },
	{Name = "USSR west army", 			X = 32, Y = 69, Domain = "Land", 	CivID = USSR,		Group = {RU_BT2, AT_GUN} },
	{Name = "USSR north army", 			X = 31, Y = 77, Domain = "Land", 	CivID = USSR,		Group = {RU_INFANTRY, RU_T28} },
	--{Name = "USSR AI moscow army", X = 33, Y = 72, Domain = "Land", AI = true, CivID = USSR, Group = {RU_INFANTRY, RU_INFANTRY, RU_BT2, RU_T28} },
	{Name = "USSR east army", 			X = 64, Y = 75, Domain = "Land", 	CivID = USSR, 		Group = {RU_INFANTRY, RU_T28 } },
	--{Name = "USSR AI east army", X = 60, Y = 73, Domain = "Land", AI = true, CivID = USSR, Group = {RU_INFANTRY, RU_BT2 } },
	
	{Name = "USSR central aviation", 	X = 38, Y = 73, Domain = "Air", 	CivID = USSR, 		Group = {RU_I16, RU_I16} },
	--{Name = "USSR central aviation AI Bonus", X = 38, Y = 73, Domain = "Air", AI = true, CivID = USSR, Group = {RU_I16, RU_I16, RU_TB3, RU_TB3 } },
	
	{Name = "USSR North fleet",	 		X = 29, Y = 78, Domain = "Sea",		CivID = USSR, 		Group = {RU_GANGUT, RU_SUBMARINE} },
	{Name = "USSR Central fleet", 		X = 36, Y = 62, Domain = "Sea", 	CivID = USSR, 		Group = {RU_GANGUT, RU_GNEVNY,} },
	-- JP
	{Name = "Japanese Manc. army", 		X = 87, Y = 67, Domain = "Land", 	CivID = JAPAN, 		Group = {JP_INFANTRY, JP_INFANTRY, JP_INFANTRY, ARTILLERY} },
	{Name = "Japanese army", 			X = 94, Y = 57, Domain = "Land", 	CivID = JAPAN, 		Group = {JP_INFANTRY, ARTILLERY} },
	
	{Name = "Japanese Korea Air", 		X = 89, Y = 64, Domain = "Air", 	CivID = JAPAN,		Group = {JP_AICHI, } },
	{Name = "Japanese Air", 			X = 97, Y = 58, Domain = "Air", 	CivID = JAPAN, 		Group = {JP_A6M2, JP_A6M2} },
	--{Name = "Japanese Air AI Bonus", X = 97, Y = 58, Domain = "Air", AI = true,CivID = JAPAN, Group = {JP_A6M2, JP_KI21} },
	
	{Name = "Japanese Western fleet", 	X = 88, Y = 60, Domain = "Sea", 	CivID = JAPAN, 		Group = {JP_SUBMARINE, JP_BATTLESHIP_2, JP_KAGERO, JP_TAKAO, JP_BATTLESHIP, JP_KAGERO, JP_KAGERO,} },
	{Name = "Japanese Eastern Fleet", 	X = 100, Y = 57,Domain = "Sea", 	CivID = JAPAN, 		Group = {JP_SUBMARINE, JP_TAKAO, JP_BATTLESHIP, JP_KAGERO, JP_KAGERO, JP_CARRIER, JP_CARRIER} },
	-- CH
	{Name = "Chinese South army", 		X = 76, Y = 54, Domain = "Land", 	IsMinor = true, CivID = CHINA, 		Group = {CH_INFANTRY, CH_INFANTRY} },
	{Name = "Chinese West army", 		X = 66, Y = 65, Domain = "Land", 	IsMinor = true, CivID = CHINA, 		Group = {CH_INFANTRY} },
	{Name = "Chinese South-East army", 		X = 82, Y = 52, Domain = "Land", 	IsMinor = true, CivID = CHINA, 		Group = {CH_INFANTRY, CH_INFANTRY} },
	{Name = "Chinese North-East army", 		X = 79, Y = 63, Domain = "Land", 	IsMinor = true, CivID = CHINA, 		Group = {CH_INFANTRY} },

	-- MINORS
	{Name = "Greek army", 				X = 27, Y = 56, Domain = "Land", 	CivID = GREECE, 	IsMinor = true, Group = {GR_INFANTRY, GR_VICKERS_MKE} },
	{Name = "Greek air force", 			X = 28, Y = 56, Domain = "Air", 	CivID = GREECE, 	IsMinor = true, Group = {GR_P24, GR_P24} },
	{Name = "Greek navy", 				X = 30, Y = 56, Domain = "Sea", 	CivID = GREECE, 	IsMinor = true, Group = {GR_PISA, GR_GEORGIOS} },
	
	{Name = "Polish army",			X = 27, Y = 70,		Domain = "Land",	CivID = POLAND,		IsMinor = true, Group = {PL_INFANTRY, AT_GUN, PL_10TP } },
	{Name = "Polish army east",		X = 29, Y = 69,		Domain = "Land",	CivID = POLAND,		IsMinor = true, Group = {PL_VICKERS_MKE_A} },
	{Name = "Polish air force",		X = 27, Y = 70,		Domain = "Air",		CivID = POLAND,		IsMinor = true, Group = {PL_PZL37, PL_P11, } },
	{Name = "Polish fleet",			X = 26, Y = 79,		Domain = "Sea",		CivID = POLAND,		IsMinor = true, Group = {PL_SUBMARINE} },
	
	{Name = "Romanian army",		X = 31, Y = 63,		Domain = "Land",	CivID = ROMANIA,	IsMinor = true, Group = {INFANTRY, AT_GUN, RO_TACAM, ARTILLERY} },
	{Name = "Bulgarian army",		X = 29, Y = 60,		Domain = "Land",	CivID = BULGARIA,	IsMinor = true, Group = {INFANTRY, ARTILLERY} },
	{Name = "Hungarian army",		X = 26, Y = 64,		Domain = "Land",	CivID = HUNGARY,	IsMinor = true, Group = {HU_INFANTRY, HU_38M_TOLDI, HU_40M_TURAN, ARTILLERY} },
	{Name = "Hungarian air force",	X = 25, Y = 65,		Domain = "Air",		CivID = HUNGARY,	IsMinor = true, Group = {HU_RE2000, HU_CA135} },
	
	{Name = "Yugoslavian army",		X = 26, Y = 61,		Domain = "Land",	CivID = YUGOSLAVIA,	IsMinor = true, Group = {INFANTRY, AT_GUN, YU_SKODA, ARTILLERY} },
	
	{Name = "Belgian army",			X = 15, Y = 70,		Domain = "Land",	CivID = BELGIUM,	IsMinor = true, Group = {INFANTRY} },
	{Name = "Belgian Congo", 		X = 20, Y = 25,		Domain = "Land",	CivID = BELGIUM,	IsMinor = true, Group = {INFANTRY} },
	{Name = "Netherlands army",		X = 16, Y = 72,		Domain = "Land",	CivID = NETHERLANDS,IsMinor = true, Group = {DU_INFANTRY} },
	{Name = "Dutch air force",		X = 16, Y = 72,		Domain = "Air",		CivID = NETHERLANDS,IsMinor = true, Group = {DU_FOKKER_DXXI} },

	{Name = "Finlish army",			X = 28, Y = 81,		Domain = "Land",	CivID = FINLAND,	IsMinor = true, Group = {SW_INFANTRY, AT_GUN, SW_INFANTRY, FI_BT42, ARTILLERY} },
	{Name = "Norweigan army",		X = 20, Y = 79,		Domain = "Land",	CivID = NORWAY,		IsMinor = true, Group = {INFANTRY, AT_GUN} },
	
	--{Name = "Iranian army",			X = 45, Y = 53,		Domain = "Land",	CivID = IRAN,		IsMinor = true, Group = {INFANTRY, INFANTRY} },
	--{Name = "Iraqi army",			X = 40, Y = 51,		Domain = "Land",	CivID = IRAQ,		IsMinor = true, Group = {INFANTRY} },
	
	--{Name = "Thai army",			X = 75, Y = 40,		Domain = "Land",	CivID = THAILAND,	IsMinor = true, Group = {INFANTRY} },
	--{Name = "Nepalese army",		X = 65, Y = 52,		Domain = "Land",	CivID = NEPAL,		IsMinor = true, Group = {INFANTRY} },
	
	-- Generals 
	{Name = "German Generals", 			X = 22, Y = 70, Domain = "City", 	CivID = GERMANY, 	Group = { GREAT_GENERAL, GREAT_GENERAL }, UnitsName = { "Heinrich Himmler", "Erich von Manstein" } },
	{Name = "English Generals", 		X = 12, Y = 72, Domain = "City", 	CivID = ENGLAND, 	Group = { GREAT_GENERAL }, UnitsName = { "Alan Brooke" } },
	{Name = "English (Egypt) Generals", X = 32, Y = 47, Domain = "City", 	CivID = ENGLAND, 	Group = { GREAT_GENERAL }, UnitsName = { "Bernard Montgomery" } },
	{Name = "US Generals", 				X = 154,Y = 63,Domain = "City", 	CivID = AMERICA, 	Group = { GREAT_GENERAL, GREAT_GENERAL }, UnitsName = { "George S. Patton", "Dwight D. Eisenhower" } },
	{Name = "USSR Generals", 			X = 38, Y = 73, Domain = "City", 	CivID = USSR, 		Group = { GREAT_GENERAL }, UnitsName = { "Georgy Zhukov" } },
	{Name = "Japanese Generals",		X = 87, Y = 67, Domain = "City", 	CivID = JAPAN, 		Group = { GREAT_GENERAL }, UnitsName = { "Tomoyuki Yamashita" } },
	--{Name = "Chinese Generals",			X = 77, Y = 53, Domain = "City", 	CivID = CHINA, 		Group = { GREAT_GENERAL }, UnitsName = { "Mao Zedong" } },]]
}

-- Initial Order of Battle
function InitializeMilitary()
	if g_Initial_OOB then
		for i, oob in ipairs (g_Initial_OOB) do
			local playerID = GetPlayerIDFromCivID (oob.CivID, oob.IsMinor)	
			local player = Players[playerID]
			
			if (not (player:IsHuman() and oob.AI)) then
				print("Placing ".. oob.Name)
				if oob.Domain == "Land" or  oob.Domain == "Sea" then
					PlaceUnits(oob)
				elseif oob.Domain == "Air" or oob.Domain == "City" then
					PlaceAirUnits(oob)
				else
					print("WARNING, domain is not valid : ".. oob.Domain)
				end
			end
		end
	end
end

function PlaceUnits(oob)
	local playerID = GetPlayerIDFromCivID( oob.CivID, oob.IsMinor )
	local player = Players [ playerID ]
	local plot = Map.GetPlot(oob.X, oob.Y)
	local plotList = GetAdjacentPlots(plot, true)
	local placedUnits = 0
	
	for i, unitPlot in ipairs (plotList) do
		local unitType = oob.Group[i]
		if unitPlot:GetNumUnits() > 0 then
			print("- WARNING : trying to place unit on occupied plot at " .. unitPlot:GetX() .."," .. unitPlot:GetY())
		end
		if unitType and unitPlot:GetNumUnits() == 0 then
			local unit = player:InitUnit(unitType, unitPlot:GetX(), unitPlot:GetY())
			FinalizeUnitFromOOB(unit, oob, i)
			placedUnits = placedUnits + 1
		end
	end
	if placedUnits < #oob.Group then
		print("- WARNING : asked to place " ..  tostring(#oob.Group) .. " units, but found valid plots for only " .. tostring(placedUnits))
	end
end

function PlaceAirUnits(oob)
	local playerID = GetPlayerIDFromCivID( oob.CivID, oob.IsMinor )
	local player = Players [ playerID ]
	local plot = Map.GetPlot(oob.X, oob.Y)
	
	for i, unitType in ipairs (oob.Group) do
		local unit = player:InitUnit(unitType, oob.X, oob.Y)
		FinalizeUnitFromOOB(unit, oob, i)
	end
end

function FinalizeUnitFromOOB(unit, oob, i)

	if unit:GetDomainType() == DomainTypes.DOMAIN_LAND and unit:GetPlot():IsWater() then
		print("- initializing Land unit on sea...")
		if (not unit:IsHasPromotion(PROMOTION_EMBARKATION)) then
			print("   - Adding embarked promotion unitID =".. unit:GetID())
			unit:SetHasPromotion(PROMOTION_EMBARKATION, true)
		end
		unit:Embark(unit:GetPlot())
	end
	if unit:GetDomainType() == DomainTypes.DOMAIN_SEA and not unit:GetPlot():IsWater() then
		print("- WARNING : tried to spawn a sea unit on land, calling JumpToNearestValidPlot()...")
		unit:JumpToNearestValidPlot() -- safe with sea units ?
	end
	if oob.UnitsName and oob.UnitsName[i] then
		print("   - Set name to unitID =".. unit:GetID())
		unit:SetName(oob.UnitsName[i])
	end
	if oob.UnitsXP and oob.UnitsXP[i] then
		print("   - Set XP to unitID =".. unit:GetID())
		unit:SetExperience(oob.UnitsXP[i])
	end
	if oob.Promotions and oob.Promotions[i] then
		print("   - Set promotion to unitID =".. unit:GetID())
		for j, promotion in pairs(oob.Promotions[i]) do
			unit:SetHasPromotion(promotion, true)
		end
	end
	if oob.ObectiveX and oob.ObjectiveY then -- Initial objective is set for all units of all groups tagged InitialObjective = true		
		print("   - Set Initial objective to unitID =".. unit:GetID())
		unit:SetDeployFromOperationTurn(1)
	end
end

---------------------------------------------------------
function DisplaceToCapital (pCivilian)

	pPlayer = Players[pCivilian:GetOwner()]
	local pCapital =  pPlayer:GetCapitalCity()
	if pCapital and pCapital:GetOwner() == pCivilian:GetOwner() then
		pCivilian:SetXY(pCapital:GetX(), pCapital:GetY())
		return true
	end
	return false
end

function OnCivilianCaptured(iPlayer, iUnitID) 

	local player = Players[iPlayer]
	local unit = player:GetUnitByID(iUnitID)
	if unit == nil then
	    return false
	end
	
	if unit:GetUnitType() ~= GameInfoTypes["UNIT_GREAT_GENERAL"] then
	    return false
	end

	return DisplaceToCapital(unit);
end
GameEvents.CanDisplaceCivilian.Add(OnCivilianCaptured)

function OnUnitKilled(iPlayer, iUnitID) 

	local player = Players[iPlayer]
	local unit = player:GetUnitByID(iUnitID)
	if (unit == nil) then
	    return false
	end
	
	if unit:GetUnitType() ~= GameInfoTypes["UNIT_GREAT_GENERAL"] then
	    return false
	end

	return DisplaceToCapital(unit)
end
GameEvents.CanSaveUnit.Add(OnUnitKilled)
---------------------------------------------------------
