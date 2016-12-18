--------------------------------------------------------------
--------------------------------------------------------------
-- WWII Setup
-- Author: Firaxis, Invidious, Gademon
--------------------------------------------------------------

ModId = "dfb37c69-71cb-408d-8f1e-caa96fc1a5d7"
ModVersion = Modding.GetActivatedModVersion(ModId);

ScenarioFixedMap = "MAPS/WWIIMap.Civ5Map"
ScenarioCivilizations = {
	[0] = "CIVILIZATION_WWII_UK",
	[1] = "CIVILIZATION_WWII_FRANCE",
	[2] = "CIVILIZATION_WWII_GERMANY",
	[3] = "CIVILIZATION_WWII_ITALY",
	[4] = "CIVILIZATION_ENGLAND",
	[5] = "CIVILIZATION_CHINA",
	[6] = "CIVILIZATION_JAPAN",
	[7] = "CIVILIZATION_AMERICA"
}
ScenarioDifficulties = { 		"HANDICAP_CHIEFTAIN", "HANDICAP_WARLORD", 	"HANDICAP_PRINCE", 	"HANDICAP_KING", 	"HANDICAP_EMPEROR", "HANDICAP_IMMORTAL", 	"HANDICAP_DEITY", }
ScenarioDifficultyNames = { "Private", 						"Corporal", 					"Sergeant", 				"Lieutenant", 		"Captain", 					"Colonel", 						"General", }

ScenarioDefaultDifficulty = "HANDICAP_KING"

----------------------------------------------------------------
include( "IconSupport" )
include( "UniqueBonuses" )

----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------
g_CurrentPlayerIndex = nil; --default to random
g_CurrentDifficulty = nil;

ScenarioMajorCivs = (ScenarioCivilizations ~= nil) and table.count(ScenarioCivilizations) or 0

g_FixedMapPath = ScenarioFixedMap and Modding.GetEvaluatedFilePath(ModId, ModVersion, ScenarioFixedMap).EvaluatedPath or nil

----------------------------------------------------------------
function OnBack()
	if(not Controls.SelectCivScrollPanel:IsHidden()) then
		ToggleCivSelection();
	else
		UIManager:DequeuePopup( ContextPtr );
	end
end
----------------------------------------------------------------       
Controls.BackButton:RegisterCallback(Mouse.eLClick, OnBack);
----------------------------------------------------------------
ContextPtr:SetInputHandler( function(uiMsg, wParam, lParam)
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
			OnBack();
        end
    end
    return true;
end);
----------------------------------------------------------------
-- Handle Start Button
Controls.StartButton:RegisterCallback(Mouse.eLClick, function()
	PreGame.Reset()

	-- Setup the fixed map
	PreGame.SetMapScript(g_FixedMapPath)
	PreGame.SetLoadWBScenario(true)
	
	-- Setup the player
	UI.ResetScenarioPlayerSlots(true)

	local playerIndex = g_CurrentPlayerIndex
	if (playerIndex == nil) then
		playerIndex = math.random(0, ScenarioMajorCivs - 1)
	end
	
	-- Swap Civilization to make active player the new index.
	if (playerIndex ~= nil) then
		UI.MoveScenarioPlayerToSlot(playerIndex, 0)
	end

	-- Setup the handicap    
	PreGame.SetOverrideScenarioHandicap(true)
	PreGame.SetHandicap(0, g_CurrentDifficulty)
	PreGame.SetGameSpeed(2);

	Events.SerialEventStartGame();
	UIManager:SetUICursor(1);
end);

-------------------------------------------------
function BuildDifficultySelectList()
  for diffIndex, diffType in ipairs(ScenarioDifficulties) do
    local diff = GameInfo.HandicapInfos[diffType]
    if (diff ~= nil) then
      local controlTable = {}
      ContextPtr:BuildInstanceForControl("ItemInstance", controlTable, Controls.DifficultyStack)

      if (diff.ID == g_CurrentDifficulty) then
        g_CurrentDifficultyButton = controlTable
        controlTable.SelectionAnim:SetHide(false)
      end

      IconHookup(diff.PortraitIndex, 64, diff.IconAtlas, controlTable.Icon)
      controlTable.Help:LocalizeAndSetText(diff.Help)
      controlTable.Name:LocalizeAndSetText(ScenarioDifficultyNames[diffIndex])
      controlTable.Button:SetToolTipString(Locale.ConvertTextKey(diff.Help))
      controlTable.Button:RegisterCallback(Mouse.eLClick, function() DifficultySelected(controlTable, diff.ID) end)
    end
  end
  
  Controls.DifficultyStack:CalculateSize()
  Controls.DifficultyStack:ReprocessAnchoring()
  Controls.DifficultyScrollPanel:CalculateInternalSize()
end

----------------------------------------------------------------
function DifficultySelected(button, difficulty)
  g_CurrentDifficulty = difficulty
  g_CurrentDifficultyButton.SelectionAnim:SetHide(true)

  button.SelectionAnim:SetHide(false)
  g_CurrentDifficultyButton = button
end

-------------------------------------------------
function Initialize()

	Controls.RedWW2Logo:SetTextureAndResize( "Background_21.dds" )
	
	-- Civilizations
	BuildCivSelectList()
	SetPlayerIndex(g_CurrentPlayerIndex)
	
	-- Difficulty
	g_CurrentDifficulty = GameInfo.HandicapInfos[ScenarioDefaultDifficulty].ID
	if(g_CurrentDifficulty == nil) then
		g_CurrentDifficulty = GameInfo.HandicapInfos()();	-- Get first handicap found.
	end
	
	BuildDifficultySelectList()
	
	-- build the buttons
	
	Controls.CivilizationButton:RegisterCallback(Mouse.eLClick, function() ToggleCivSelection() end);
end

----------------------------------------------------------------
function ToggleCivSelection()
	if(not Controls.SelectCivScrollPanel:IsHidden()) then
		Controls.SelectCivScrollPanel:SetHide(true);
		Controls.DifficultyBox:SetHide(false);
		Controls.DoMBox:SetHide(false);
		Controls.StartButton:SetHide(false);
	else
		BuildCivSelectList();
		Controls.SelectCivScrollPanel:SetHide(false);
		Controls.DifficultyBox:SetHide(true);
		Controls.DoMBox:SetHide(true);
		Controls.StartButton:SetHide(true);
	end
end

----------------------------------------------------------------
function BuildCivSelectList()

	Controls.SelectCivStack:DestroyAllChildren(); 
	
	--Create Random Selection Entry if it's not already selected
	if(g_CurrentPlayerIndex ~= nil) then
	
		local controlTable = {};
		ContextPtr:BuildInstanceForControl( "SelectCivInstance", controlTable, Controls.SelectCivStack );
		
		controlTable.Button:SetVoid1( -1 );
		controlTable.Button:RegisterCallback( Mouse.eLClick, function() SetPlayerIndex(nil); ToggleCivSelection(); end );

		controlTable.Title:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER");
		controlTable.Description:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER_HELP");
		IconHookup( 22, 128, "LEADER_ATLAS", controlTable.Portrait );
		
		if(questionOffset ~= nil) then       
			controlTable.Icon:SetTexture( questionTextureSheet );
			controlTable.Icon:SetTextureOffset( questionOffset );
			controlTable.IconShadow:SetTexture( questionTextureSheet );
			controlTable.IconShadow:SetTextureOffset( questionOffset );
		end
		
		local primaryColor       = GameInfo.Colors.COLOR_DARK_GREY;
		local primaryColorVector = Vector4( primaryColor.Red, primaryColor.Green, primaryColor.Blue, primaryColor.Alpha );
		controlTable.Icon:SetColor( primaryColorVector );
		
		local secondaryColor       = GameInfo.Colors.COLOR_LIGHT_GREY;
		local secondaryColorVector = Vector4( secondaryColor.Red, secondaryColor.Green, secondaryColor.Blue, secondaryColor.Alpha );
		controlTable.TeamColor:SetColor( secondaryColorVector );
	
		-- Sets Trait bonus Text
		controlTable.BonusDescription:SetText( "" );
	
		 -- Sets Bonus Icons
		local maxSmallButtons = 2;
		for buttonNum = 1, maxSmallButtons, 1 do
			local buttonName = "B"..tostring(buttonNum);
			controlTable[buttonName]:SetTexture( questionTextureSheet );
			controlTable[buttonName]:SetTextureOffset( questionOffset );
			controlTable[buttonName]:SetToolTipString( unknownString );
			controlTable[buttonName]:SetHide(false);
			local buttonFrameName = "BF"..tostring(buttonNum);
			controlTable[buttonFrameName]:SetHide(false);
		end
	end 
		 
	for playerIndex, civType in pairs(ScenarioCivilizations) do
		if(playerIndex ~= g_CurrentPlayerIndex) then
		
			local civ = GameInfo.Civilizations[civType];
			
			-- Use the Civilization_Leaders table to cross reference from this civ to the Leaders table
			local leader = GameInfo.Leaders[GameInfo.Civilization_Leaders( "CivilizationType = '" .. civ.Type .. "'" )().LeaderheadType];
			local leaderDescription = leader.Description;
		    
			local colorSet = GameInfo.PlayerColors[civ.DefaultPlayerColor];
		    
			local primaryColor       = GameInfo.Colors[colorSet.PrimaryColor];
			local primaryColorVector = Vector4( primaryColor.Red, primaryColor.Green, primaryColor.Blue, primaryColor.Alpha );
		    
			local secondaryColor       = GameInfo.Colors[colorSet.SecondaryColor];
			local secondaryColorVector = Vector4( secondaryColor.Red, secondaryColor.Green, secondaryColor.Blue, secondaryColor.Alpha );
		        
			local controlTable = {};
			ContextPtr:BuildInstanceForControl( "SelectCivInstance", controlTable, Controls.SelectCivStack );
		    
			controlTable.Button:SetVoid1( civ.ID );
			controlTable.Button:RegisterCallback( Mouse.eLClick, function() SetPlayerIndex(playerIndex); ToggleCivSelection(); end);
		   			
			controlTable.Description:SetText( Locale.ConvertTextKey( civ.Description ) );

			IconHookup( leader.PortraitIndex, 128, leader.IconAtlas, controlTable.Portrait );
			local textureOffset, textureAtlas = IconLookup( civ.PortraitIndex, 64, civ.IconAtlas );
			if textureOffset ~= nil then       
				controlTable.Icon:SetTexture( textureAtlas );
				controlTable.Icon:SetTextureOffset( textureOffset );
				controlTable.IconShadow:SetTexture( textureAtlas );
				controlTable.IconShadow:SetTextureOffset( textureOffset );
			end

			controlTable.Icon:SetColor( primaryColorVector );
			controlTable.TeamColor:SetColor( secondaryColorVector );
		    
			-- Sets Trait bonus Text
			local leaderTrait = GameInfo.Leader_Traits("LeaderType ='" .. leader.Type .. "'")();
			local trait = leaderTrait.TraitType;
			local gameTrait = GameInfo.Traits[trait];
			controlTable.BonusDescription:SetText( Locale.ConvertTextKey( gameTrait.Description ));
		 
		 	local title = string.format("%s (%s)", Locale.ConvertTextKey("TXT_KEY_RANDOM_LEADER_CIV", leaderDescription, civ.ShortDescription), Locale.ConvertTextKey(gameTrait.ShortDescription));
			controlTable.Title:SetText(title);
			
			PopulateUniqueBonuses( controlTable, civ, leader );
		end
	end
	
	Controls.SelectCivStack:CalculateSize();
	Controls.SelectCivStack:ReprocessAnchoring();
	Controls.SelectCivScrollPanel:CalculateInternalSize();
end

----------------------------------------------------------------
function SetPlayerIndex(playerIndex)
	g_CurrentPlayerIndex = playerIndex;
	
	if(playerIndex ~= nil) then		
		--Set up items for specified player.
		local civType = ScenarioCivilizations[playerIndex];

		-- Use the Civilization_Leaders table to cross reference from this civ to the Leaders table
		local civ = GameInfo.Civilizations[civType];
		local leader = GameInfo.Leaders[GameInfo.Civilization_Leaders( "CivilizationType = '" .. civ.Type .. "'" )().LeaderheadType];
		local leaderDescription = leader.Description;
		
		-- Set Civ Leader Icon
		IconHookup( leader.PortraitIndex, 128, leader.IconAtlas, Controls.Portrait );
			
		-- Set Civ Icon
		IconHookup( civ.PortraitIndex, 64, civ.IconAtlas, Controls.IconShadow );
			
		-- Sets Trait bonus Text
		local leaderTrait = GameInfo.Leader_Traits("LeaderType ='" .. leader.Type .. "'")();
		local trait = leaderTrait.TraitType;
		Controls.BonusDescription:LocalizeAndSetText(GameInfo.Traits[trait].Description);

		-- Set Leader & Civ Text
		local title = Locale.ConvertTextKey("TXT_KEY_RANDOM_LEADER_CIV", leaderDescription, civ.ShortDescription);
		title = string.format("%s (%s)", title, Locale.ConvertTextKey(GameInfo.Traits[trait].ShortDescription));
		
		Controls.Title:SetText(title);
		
		---- Sets Bonus Icons
		PopulateUniqueBonuses( Controls, civ, leader );
	        
		-- Sets Dawn of Man Quote
		Controls.Quote:LocalizeAndSetText(civ.DawnOfManQuote or "");
    else
		-- Setup entry for random player.
		Controls.Title:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER");
		IconHookup( 22, 128, "LEADER_ATLAS", Controls.Portrait  );
		
		if(questionOffset ~= nil) then 
			Controls.IconShadow:SetTexture( questionTextureSheet );
			Controls.IconShadow:SetTextureOffset( questionOffset );
		end
		-- Sets Trait bonus Text
		Controls.BonusDescription:SetText( "" );
	
		 -- Sets Bonus Icons
		local maxSmallButtons = 2;
		for buttonNum = 1, maxSmallButtons, 1 do
			local buttonName = "B"..tostring(buttonNum);
			Controls[buttonName]:SetTexture( questionTextureSheet );
			Controls[buttonName]:SetTextureOffset( questionOffset );
			Controls[buttonName]:SetToolTipString( unknownString );
			Controls[buttonName]:SetHide(false);
			local buttonFrameName = "BF"..tostring(buttonNum);
			Controls[buttonFrameName]:SetHide(false);
		end
		
		-- Sets Dawn of Man Quote
		Controls.Quote:LocalizeAndSetText("TXT_KEY_BRIEFING_TEXT");		
    end

	Controls.MainStack:CalculateSize();
	Controls.MainStack:ReprocessAnchoring();
	Controls.DoMScrollPanel:CalculateInternalSize();
end

Initialize()