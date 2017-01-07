print("------------------ Loaded WWIIDiplomacy.lua ------------------")

g_Major_Diplomacy = {
	[19390901] = {
		{Type = DEN, Civ1 = FRANCE, Civ2 = GERMANY},
		{Type = DEN, Civ1 = ENGLAND, Civ2 = GERMANY},
		{Type = PAL, Civ1 = FRANCE, Civ2 = ENGLAND},
	},
	[19390903] = {
		--{Type = DOW, Civ1 = FRANCE, Civ2 = GERMANY},
		{Type = DOW, Civ1 = ENGLAND, Civ2 = GERMANY},

		{Type = DEN, Civ1 = AMERICA, Civ2 = GERMANY},
		--{Type = DEN, Civ1 = ITALY, Civ2 = FRANCE},
		{Type = DEN, Civ1 = ITALY, Civ2 = ENGLAND},

		{Type = DOF, Civ1 = GERMANY, Civ2 = USSR},
	},
	[19400610] = { 
		--{Type = DOW, Civ1 = ITALY, Civ2 = FRANCE},
		--{Type = DOW, Civ1 = ITALY, Civ2 = ENGLAND},
		{Type = PAL, Civ1 = GERMANY, Civ2 = ITALY},
	},
	[19400927] = { 
		{Type = DOF, Civ1 = GERMANY, Civ2 = JAPAN},
	},
	[19410622] = { 
		{Type = DOW, Civ1 = GERMANY, Civ2 = USSR},
		--{Type = DOW, Civ1 = ITALY, Civ2 = USSR},
		{Type = DOF, Civ1 = FRANCE, Civ2 = USSR},
		{Type = DOF, Civ1 = ENGLAND, Civ2 = USSR},
	},
	[19411207] = { 
		--{Type = PAL, Civ1 = FRANCE, Civ2 = AMERICA},
		{Type = PAL, Civ1 = ENGLAND, Civ2 = AMERICA},
		--{Type = PAL, Civ1 = CHINA, Civ2 = AMERICA},
		--{Type = PAL, Civ1 = CHINA, Civ2 = FRANCE},
		{Type = PAL, Civ1 = JAPAN, Civ2 = GERMANY},
		
		{Type = DOW, Civ1 = GERMANY, Civ2 = AMERICA},
		--{Type = DOW, Civ1 = GERMANY, Civ2 = CHINA},
		--{Type = DOW, Civ1 = ITALY, Civ2 = AMERICA},
		--{Type = DOW, Civ1 = ITALY, Civ2 = CHINA},
		--{Type = DOW, Civ1 = JAPAN, Civ2 = AMERICA},
		--{Type = DOW, Civ1 = JAPAN, Civ2 = FRANCE},
		--{Type = DOW, Civ1 = JAPAN, Civ2 = ENGLAND},
		
		{Type = DOF, Civ1 = USSR, Civ2 = AMERICA},
	},
}

g_Major_Minor_Diplomacy = {
	[19390701] = {
		{Type = DOW, Major = JAPAN, Minor = CHINA},
	},
	[19390901] = { 
		{Type = DOW, Major = GERMANY, Minor = POLAND},
	},
	[19390917] = { 
		{Type = DOW, Major = USSR, Minor = POLAND},	
	},
	[19391130] = { 
		{Type = DOW, Major = USSR, Minor = FINLAND},
	},
	[19400313] = { 
		{Type = PEA, Major = USSR, Minor = FINLAND},
	},
	[19400409] = { 
		{Type = DOW, Major = GERMANY, Minor = DENMARK},
		{Type = DOW, Major = GERMANY, Minor = NORWAY},
	},
	[19400510] = { 
		{Type = DOW, Major = GERMANY, Minor = BELGIUM},
		{Type = DOW, Major = GERMANY, Minor = NETHERLANDS},
	},
	[19401028] = {
		{Type = DOW, Major = ITALY, Minor = GREECE},
	},
	[19410406] = { 
		{Type = DOW, Major = ITALY, Minor = YUGOSLAVIA},
		{Type = DOW, Major = GERMANY, Minor = YUGOSLAVIA},
	},	
	[19410502] = { 
		{Type = DOW, Major = ENGLAND, Minor = IRAQ},
	},	
	[19410622] = { 
		{Type = DOW, Major = USSR, Minor = ROMANIA},
		{Type = DOW, Major = USSR, Minor = FINLAND},
		{Type = DOW, Major = USSR, Minor = HUNGARY},
	},
	[19410825] = {
		{Type = DOW, Major = ENGLAND, Minor = IRAN},
		{Type = DOW, Major = USSR, Minor = IRAN},
	},
	[19421110] = { 
		{Type = DOW, Major = FRANCE, Minor = VICHY},
		{Type = DOW, Major = ENGLAND, Minor = VICHY},
	},
}

g_Minor_Minor_Diplomacy = {
	[19410410] = {
		{Type = DOW, Minor1 = HUNGARY, Minor2 = YUGOSLAVIA},
	},
	[19410406] = {
		{Type = DOW, Minor1 = BULGARIA, Minor2 = YUGOSLAVIA},
		{Type = DOW, Minor1 = BULGARIA, Minor2 = GREECE},
	},
}

g_Major_Minor_Relations = {
	[19390701] = { 
		-- Allies
		{Value = 120, Major = ENGLAND, Minor = BRITISH_COMMONWEALTH},
		{Value = 120, Major = ENGLAND, Minor = EGYPT},
		{Value = 120, Major = ENGLAND, Minor = IRAQ},
		{Value = 120, Major = ENGLAND, Minor = POLAND},
		
		{Value = 120, Major = FRANCE, Minor = FRENCH_COLONY},
		
		{Value = 120, Major = ITALY, Minor = ITALIAN_EMPIRE},
		
		-- Friends
		{Value = 50, Major = ENGLAND, Minor = NORWAY},
		{Value = 50, Major = ENGLAND, Minor = GREECE},
		{Value = 50, Major = ENGLAND, Minor = YUGOSLAVIA},
		{Value = 50, Major = ENGLAND, Minor = FRENCH_COLONY},
		
		{Value = 50, Major = FRANCE, Minor = POLAND},
		{Value = 50, Major = FRANCE, Minor = EGYPT},
		{Value = 50, Major = FRANCE, Minor = IRAQ},
		{Value = 50, Major = FRANCE, Minor = GREECE},
		{Value = 50, Major = FRANCE, Minor = YUGOSLAVIA},
		{Value = 50, Major = FRANCE, Minor = BRITISH_COMMONWEALTH},
		
		{Value = 50, Major = GERMANY, Minor = HUNGARY},
		{Value = 50, Major = GERMANY, Minor = ROMANIA},
		{Value = 50, Major = GERMANY, Minor = BULGARIA},
		{Value = 50, Major = GERMANY, Minor = ITALIAN_EMPIRE},
		{Value = 50, Major = GERMANY, Minor = SWEDEN},
		
		{Value = 50, Major = ITALY, Minor = HUNGARY},
		{Value = 50, Major = ITALY, Minor = ROMANIA},
		{Value = 50, Major = ITALY, Minor = BULGARIA},
		
		{Value = 50, Major = USSR, Minor = IRAN},
		{Value = 50, Major = USSR, Minor = IRAQ},
		{Value = 50, Major = USSR, Minor = MONGOLIA},
		{Value = 50, Major = USSR, Minor = EGYPT},
		
		{Value = 50, Major = JAPAN, Minor = THAILAND},
		-- Unhappy
		{Value = -50, Major = USSR, Minor = FINLAND},
		{Value = -50, Major = FRANCE, Minor = THAILAND},
	},
	[19400510] = {
		{Value = 120, Major = ENGLAND, Minor = BELGIUM},
		{Value = 120, Major = ENGLAND, Minor = NETHERLANDS},
		{Value = 120, Major = ENGLAND, Minor = DUTCH_EAST_INDIES},
		
		{Value = 50, Major = FRANCE, Minor = BELGIUM},
		{Value = 50, Major = FRANCE, Minor = NETHERLANDS},
		{Value = 50, Major = FRANCE, Minor = DUTCH_EAST_INDIES},
	},
	[19400614] = { 
		{Value = 120, Major = USSR, Minor = BALTIC},		
	},
	[19401028] = {
		{Value = 120, Major = ENGLAND, Minor = GREECE},
		{Value = 50, Major = FRANCE, Minor = GREECE},
	},
	[19410420] = { 
		{Value = -50, Major = ENGLAND, Minor = IRAQ},
		{Value = -50, Major = FRANCE, Minor = IRAQ},
		
		{Value = 50, Major = GERMANY, Minor = IRAQ},
		{Value = 50, Major = ITALY, Minor = IRAQ},
	},	
	[19410406] = {
		{Value = 120, Major = GERMANY, Minor = BULGARIA},
		{Value = 50, Major = ITALY, Minor = BULGARIA},
	},
	[19410622] = { 
		{Value = 120, Major = GERMANY, Minor = ROMANIA},
		{Value = 120, Major = GERMANY, Minor = FINLAND},
		{Value = 50, Major = ITALY, Minor = FINLAND},
		{Value = 50, Major = ITALY, Minor = ROMANIA},
	},
	[19411207] = {
		{Value = 120, Major = ENGLAND, Minor = CHINA},
		{Value = 120, Major = FRANCE, Minor = CHINA},
		{Value = 120, Major = USSR, Minor = CHINA},
		{Value = 120, Major = AMERICA, Minor = CHINA},
	},
	[19420125] = {
		{Value = 120, Major = JAPAN, Minor = THAILAND},
	},
}

function SetMinorRelations()
	if g_Major_Minor_Relations then
		local turn = Game.GetGameTurn()
		if g_Calendar[turn] then turnDate = g_Calendar[turn].Number else turnDate = 19470105 end
		if g_Calendar[turn-1] then prevDate = g_Calendar[turn-1].Number else prevDate = turnDate - 1 end
		
		for date, relations in pairs(g_Major_Minor_Relations) do
			if date <= turnDate and date > prevDate then
				if (relations) then
					for i, diploChange in ipairs (relations) do
						local Major = Players[ GetPlayerIDFromCivID( diploChange.Major ) ]
						local Minor = Players[ GetPlayerIDFromCivID( diploChange.Minor, true ) ]
						
						if(Major and Minor) then
							Minor:ChangeMinorCivFriendshipWithMajor( GetPlayerIDFromCivID( diploChange.Major ), diploChange.Value )
							print (" - " .. Minor:GetName() .. " (ID "..diploChange.Minor..") have changed relationship (".. diploChange.Value ..") with " .. Major:GetName() .. " (ID "..diploChange.Major..")")
						end
					end
				end	
			end
		end
	end
end

function SetMajorDiplomacy()

	if g_Major_Diplomacy then
		local turn = Game.GetGameTurn()
		if g_Calendar[turn] then turnDate = g_Calendar[turn].Number else turnDate = 19470105 end
		if g_Calendar[turn-1] then prevDate = g_Calendar[turn-1].Number else prevDate = turnDate - 1 end
		
		for date, relations in pairs(g_Major_Diplomacy) do
			if date <= turnDate and date > prevDate then
				if (relations) then
					for i, diploChange in ipairs (relations) do
						if (diploChange.Type == DOF) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Civ1 ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Civ2 ) ]

							player:DoForceDoF( GetPlayerIDFromCivID( diploChange.Civ2 ) )

							print (" - " .. player:GetName() .. " (ID "..diploChange.Civ1..") and " .. player2:GetName() .. " (ID "..diploChange.Civ2..") have made a declaration of friendship")

						-- denounciation
						elseif (diploChange.Type == DEN) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Civ1 ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Civ2 ) ]

							player:DoForceDenounce( GetPlayerIDFromCivID( diploChange.Civ2 ) )

							print (" - " .. player:GetName() .. " (ID "..diploChange.Civ1..") has denounced " .. player2:GetName() .. " (ID "..diploChange.Civ2..")")

						-- declaration of war
						elseif (diploChange.Type == DOW) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Civ1 ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Civ2 ) ]
													
							DeclareWar(GetPlayerIDFromCivID( diploChange.Civ1 ),GetPlayerIDFromCivID( diploChange.Civ2 ))

							print (" - " .. player:GetName() .. " (ID "..diploChange.Civ1..") has declared war against " .. player2:GetName() .. " (ID "..diploChange.Civ2..")")

						-- permanent alliance
						elseif (diploChange.Type == PAL) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Civ1 ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Civ2 ) ]

							CreateAlliance(player, player2)

						-- sign peace treaty
						elseif (diploChange.Type == PEA) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Civ1 ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Civ2 ) ]

							MakePeace(GetPlayerIDFromCivID( diploChange.Civ1 ), GetPlayerIDFromCivID( diploChange.Civ2 ))

							print (" - " .. player:GetName() .. " (ID "..diploChange.Civ1..") has signed a peace treaty with " .. player2:GetName() .. " (ID "..diploChange.Civ2..")")
						end
					end
				end	
			end
		end
	end
end

function SetMinorDiplomacy()
	if g_Major_Minor_Diplomacy then
		local turn = Game.GetGameTurn()
		if g_Calendar[turn] then turnDate = g_Calendar[turn].Number else turnDate = 19470105 end
		if g_Calendar[turn-1] then prevDate = g_Calendar[turn-1].Number else prevDate = turnDate - 1 end
		
		for date, relations in pairs(g_Major_Minor_Diplomacy) do
			if date <= turnDate and date > prevDate then
				if (relations) then
					for i, diploChange in ipairs (relations) do
						-- declaration of war
						if (diploChange.Type == DOW) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Major ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Minor, true ) ]
													
							DeclareWar(GetPlayerIDFromCivID( diploChange.Major ),GetPlayerIDFromCivID( diploChange.Minor, true ))

							print (" - " .. player:GetName() .. " (ID "..diploChange.Major..") has declared war against " .. player2:GetName() .. " (ID "..diploChange.Minor..")")
						-- sign peace treaty
						elseif (diploChange.Type == PEA) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Major ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Minor, true ) ]

							MakePeace(GetPlayerIDFromCivID( diploChange.Major ), GetPlayerIDFromCivID( diploChange.Minor, true ))

							print (" - " .. player:GetName() .. " (ID "..diploChange.Major..") has signed a peace treaty with " .. player2:GetName() .. " (ID "..diploChange.Minor..")")
						end
					end
				end	
			end
		end
		
		for date, relations in pairs(g_Minor_Minor_Diplomacy) do
			if date <= turnDate and date > prevDate then
				if (relations) then
					for i, diploChange in ipairs (relations) do
						-- declaration of war
						if (diploChange.Type == DOW) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Minor1, true ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Minor2, true ) ]
													
							DeclareWar(GetPlayerIDFromCivID( diploChange.Minor1, true ),GetPlayerIDFromCivID( diploChange.Minor2, true ))

							print (" - " .. player:GetName() .. " (ID "..diploChange.Minor1..") has declared war against " .. player2:GetName() .. " (ID "..diploChange.Minor2..")")
						-- sign peace treaty
						elseif (diploChange.Type == PEA) then
							local player = Players[ GetPlayerIDFromCivID( diploChange.Minor1, true ) ]
							local player2 = Players[ GetPlayerIDFromCivID( diploChange.Minor2, true ) ]

							MakePeace(GetPlayerIDFromCivID( diploChange.Minor1, true ), GetPlayerIDFromCivID( diploChange.Minor2, true ))

							print (" - " .. player:GetName() .. " (ID "..diploChange.Minor1..") has signed a peace treaty with " .. player2:GetName() .. " (ID "..diploChange.Minor2..")")
						end
					end
				end	
			end
		end
	end
end
