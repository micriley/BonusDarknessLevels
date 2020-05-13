-- IMPORT @ DEFAULT
-- PRIORITY 150

--[[ Installation Instructions:
	Place this file in /Content/Mods/BonusDarknessLevels/Scripts
	Add 'Import "../Mods/BonusDarknessLevels/Scripts/BonusDarknessLevels.lua"' to the bottom of RoomManager.lua
	Configure by changing values in the config table below
	Load/reload a save
--]]

--[[
Mod: BonusDarknessLevels
Author: Mike Riley(TurboCop)
        A mod that lets zagreus have temporary bonus levels from the mirror of darkness, but only for that run.
-]]

--[[
    Github location: 
]]
ModUtil.RegisterMod("BonusDarknessLevels")


local config = --  
{
    Enabled = true, -- Easy access to turn on and off this mod
    Testing = false
}

BonusDarknessLevels.config = config
if config.Enabled then
    if config.Testing then
        -- Print some useful stack information from codex button in testing mode
        ModUtil.BaseOverride("BeginOpeningCodex", function()
            if GameState ~= nil then
                if GameState.MetaUpgrades ~= nil then
                    ModUtil.Hades.PrintStack("GameState.MetaUpgrades.MoneyMetaUpgrade")
                    ModUtil.Hades.PrintStack(GameState.MetaUpgrades.MoneyMetaUpgrade)
                else
                    ModUtil.Hades.PrintStack("GameState.MetaUpgrades is nil!")
                end
            else
                ModUtil.Hades.PrintStack("GameState is nil!")
            end
            if CurrentRun ~= nil then
                if CurrentRun.MetaUpgrades ~= nil then
                    ModUtil.Hades.PrintStack("CurrentRun.MetaUpgrades.MoneyMetaUpgrade")
                    ModUtil.Hades.PrintStack(CurrentRun.MetaUpgrades.MoneyMetaUpgrade)
                else
                    ModUtil.Hades.PrintStack("CurrentRun.MetaUpgrades is nil!")
                end
            else
                ModUtil.Hades.PrintStack("CurrentRun is nil!")
            end
            ModUtil.Hades.PrintStack("CurrentRun.DeathFunctionName")
            ModUtil.Hades.PrintStack(CurrentRun.DeathFunctionName)
        end, BonusDarknessLevels)
    end
    
    ModUtil.LoadOnce(function()
            -- Configure MetaUpgradeData with the new upgrade costs and 'standardlevels' so we know what to reset to.
            -- Testing has small cost for easy testing.
            if config.Testing then
                MetaUpgradeData.HealthMetaUpgrade.CostTable = {40, 45, 50, 55, 60, 70, 75, 80, 85, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
                MetaUpgradeData.HighHealthDamageMetaUpgrade.CostTable = { 50, 100, 150, 200, 250, 1, 1, 1, 1, 1 }
                MetaUpgradeData.HealthEncounterEndRegenMetaUpgrade.CostTable = { 25, 75, 150, 500, 1, 1, 1, 1 }
                MetaUpgradeData.DoorHealMetaUpgrade.CostTable = { 10, 20, 40, 1, 1, 1 }
                MetaUpgradeData.DarknessHealMetaUpgrade.CostTable = { 30, 60, 1, 1 }
                MetaUpgradeData.AmmoMetaUpgrade.CostTable = { 20, 80, 1, 1, 1 }
                MetaUpgradeData.ReloadAmmoMetaUpgrade.CostTable = { 60, 120, 1, 1 }
                MetaUpgradeData.ReloadAmmoMetaUpgrade.CostTable = { 60, 120, 1, 1 }
                MetaUpgradeData.StaminaMetaUpgrade.CostTable = { 50, 1 }
                MetaUpgradeData.StaminaMetaUpgrade.HelpTextTable[2] = "StaminaMetaUpgrade_On"
                MetaUpgradeData.BackstabMetaUpgrade.CostTable = { 10, 15, 20, 25, 30, 1, 1, 1, 1, 1 }
                MetaUpgradeData.FirstStrikeMetaUpgrade.CostTable = { 10, 15, 20, 25, 30, 1, 1, 1, 1, 1 }
                MetaUpgradeData.StoredAmmoVulnerabilityMetaUpgrade.CostTable = { 10, 30, 50, 70, 90, 1, 1, 1, 1, 1 }
                MetaUpgradeData.StoredAmmoSlowMetaUpgrade.CostTable = { 20, 40, 60, 80, 100, 1, 1, 1, 1, 1 }
                MetaUpgradeData.VulnerabilityEffectBonusMetaUpgrade.CostTable = { 50, 100, 1, 1}
                MetaUpgradeData.GodEnhancementMetaUpgrade.CostTable = { 50, 100, 1, 1}
                MetaUpgradeData.ExtraChanceMetaUpgrade.CostTable = {30, 500, 1000, 1, 1, 1}
                MetaUpgradeData.ExtraChanceReplenishMetaUpgrade.CostTable = {600, 1}
                MetaUpgradeData.MoneyMetaUpgrade.CostTable = { 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
                MetaUpgradeData.InterestMetaUpgrade.CostTable = { 70, 90, 110, 1, 1, 1 }
                MetaUpgradeData.RareBoonDropMetaUpgrade.MaxInvestment = 80
                MetaUpgradeData.EpicBoonDropMetaUpgrade.MaxInvestment = 40
                MetaUpgradeData.DuoRarityBoonDropMetaUpgrade.MaxInvestment = 30
                MetaUpgradeData.RunProgressRewardMetaUpgrade.MaxInvestment = 20
                MetaUpgradeData.RerollMetaUpgrade.CostTable = { 500, 1000, 2000, 3000, 4000, 5000, 10000, 20000, 30000, 40000, 50000, 70000, 90000, 100000, 120000, 140000, 160000, 180000, 200000 }
                MetaUpgradeData.RerollPanelMetaUpgrade.CostTable ={ 1000, 5000, 10000, 25000, 50000, 75000, 100000, 1000000 }
            else
                MetaUpgradeData.HealthMetaUpgrade.CostTable = {40, 45, 50, 55, 60, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135 }
                MetaUpgradeData.HighHealthDamageMetaUpgrade.CostTable = { 50, 100, 150, 200, 250, 300, 350, 400, 450, 500 }
                MetaUpgradeData.HealthEncounterEndRegenMetaUpgrade.CostTable = { 25, 75, 150, 500, 750, 1000, 2000, 4000 }
                MetaUpgradeData.DoorHealMetaUpgrade.CostTable = { 10, 20, 40, 80, 160, 320 }
                MetaUpgradeData.DarknessHealMetaUpgrade.CostTable = { 30, 60, 120, 240 }
                MetaUpgradeData.AmmoMetaUpgrade.CostTable = { 20, 80, 160, 320, 640 }
                MetaUpgradeData.ReloadAmmoMetaUpgrade.CostTable = { 60, 120, 180, 240 }
                MetaUpgradeData.StaminaMetaUpgrade.CostTable = { 50, 500 }
                MetaUpgradeData.StaminaMetaUpgrade.HelpTextTable[2] = "StaminaMetaUpgrade_On"
                MetaUpgradeData.BackstabMetaUpgrade.CostTable = { 10, 15, 20, 25, 30, 35, 40, 45, 50, 55 }
                MetaUpgradeData.FirstStrikeMetaUpgrade.CostTable = { 10, 15, 20, 25, 30, 35, 40, 45, 50, 55 }
                MetaUpgradeData.StoredAmmoVulnerabilityMetaUpgrade.CostTable = { 10, 30, 50, 70, 90, 110, 130, 150, 170, 190 }
                MetaUpgradeData.StoredAmmoSlowMetaUpgrade.CostTable = { 20, 40, 60, 80, 100, 120, 140, 160, 180, 200 }
                MetaUpgradeData.VulnerabilityEffectBonusMetaUpgrade.CostTable = { 50, 100, 150, 200}
                MetaUpgradeData.GodEnhancementMetaUpgrade.CostTable = { 50, 100, 150, 200}
                MetaUpgradeData.ExtraChanceMetaUpgrade.CostTable = {30, 500, 1000, 2000, 4000, 8000}
                MetaUpgradeData.ExtraChanceReplenishMetaUpgrade.CostTable = {600, 1200}
                MetaUpgradeData.MoneyMetaUpgrade.CostTable = { 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125 }
                MetaUpgradeData.InterestMetaUpgrade.CostTable = { 70, 90, 110, 130, 150, 170 }
                MetaUpgradeData.RareBoonDropMetaUpgrade.MaxInvestment = 80
                MetaUpgradeData.RareBoonDropMetaUpgrade.MaxCostIncrease = 5
                MetaUpgradeData.EpicBoonDropMetaUpgrade.MaxInvestment = 40
                MetaUpgradeData.EpicBoonDropMetaUpgrade.MaxCostIncrease = 10
                MetaUpgradeData.DuoRarityBoonDropMetaUpgrade.MaxInvestment = 30
                MetaUpgradeData.DuoRarityBoonDropMetaUpgrade.MaxCostIncrease = 10
                MetaUpgradeData.RunProgressRewardMetaUpgrade.MaxInvestment = 20
                MetaUpgradeData.RunProgressRewardMetaUpgrade.MaxCostIncrease = 10
                MetaUpgradeData.RerollMetaUpgrade.CostTable = { 500, 1000, 2000, 3000, 4000, 5000, 10000, 20000, 30000, 40000, 50000, 70000, 90000, 100000, 120000, 140000, 160000, 180000, 200000 }
                MetaUpgradeData.RerollPanelMetaUpgrade.CostTable ={ 1000, 5000, 10000, 25000, 50000, 75000, 100000, 1000000 }
            end
            MetaUpgradeData.HealthMetaUpgrade.standardLevels = 10
            MetaUpgradeData.HighHealthDamageMetaUpgrade.standardLevels = 5
            MetaUpgradeData.HealthEncounterEndRegenMetaUpgrade.standardLevels = 4
            MetaUpgradeData.DoorHealMetaUpgrade.standardLevels = 3
            MetaUpgradeData.DarknessHealMetaUpgrade.standardLevels = 2
            MetaUpgradeData.DarknessHealMetaUpgrade.standardLevels = 2
            MetaUpgradeData.AmmoMetaUpgrade.standardLevels = 2
            MetaUpgradeData.ReloadAmmoMetaUpgrade.standardLevels = 2
            MetaUpgradeData.ReloadAmmoMetaUpgrade.standardLevels = 2
            MetaUpgradeData.StaminaMetaUpgrade.standardLevels = 1
            MetaUpgradeData.BackstabMetaUpgrade.standardLevels = 5
            MetaUpgradeData.FirstStrikeMetaUpgrade.standardLevels = 5
            MetaUpgradeData.StoredAmmoVulnerabilityMetaUpgrade.standardLevels = 5
            MetaUpgradeData.StoredAmmoSlowMetaUpgrade.standardLevels = 5
            MetaUpgradeData.VulnerabilityEffectBonusMetaUpgrade.standardLevels = 2
            MetaUpgradeData.GodEnhancementMetaUpgrade.standardLevels = 2
            MetaUpgradeData.ExtraChanceMetaUpgrade.standardLevels = 3
            MetaUpgradeData.ExtraChanceMetaUpgrade.standardLevels = 3
            MetaUpgradeData.ExtraChanceReplenishMetaUpgrade.standardLevels = 1
            MetaUpgradeData.MoneyMetaUpgrade.standardLevels = 10
            MetaUpgradeData.InterestMetaUpgrade.standardLevels = 3
            MetaUpgradeData.RareBoonDropMetaUpgrade.standardLevels = 40
            MetaUpgradeData.EpicBoonDropMetaUpgrade.standardLevels = 20
            MetaUpgradeData.DuoRarityBoonDropMetaUpgrade.standardLevels = 15
            MetaUpgradeData.RunProgressRewardMetaUpgrade.standardLevels = 10
            MetaUpgradeData.RerollMetaUpgrade.standardLevels = 10
            MetaUpgradeData.RerollPanelMetaUpgrade.standardLevels = 4
        end)

    --- ModUtil.BaseOverride("GetMetaUpgradePrice", function(metaUpgrade, index)
    ---     --- Override GetMetaUpgradePrice to make the MaxInvestment style cost tables have increasing costs too beyond their standardLevels
    ---     if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---         ModUtil.Hades.PrintStack("Calling GetMetaUpgradePrice")
    ---     end
    ---     if metaUpgrade.CostTable then
    ---         if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---             ModUtil.Hades.PrintStack("Using metaUpgrade.CostTable")
    ---         end
    ---         return metaUpgrade.CostTable[index + 1]
    ---     else
    ---         if metaUpgrade.MaxInvestment ~= nil and metaUpgrade.MaxInvestment <= index then
    ---             if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---                 ModUtil.Hades.PrintStack("Using metaUpgrade.MaxInvestment at max check")
    ---             end
    ---             return nil
    ---         end
    ---         local additionalCost = 0
    ---         if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---             ModUtil.Hades.PrintStack("Index.." .. index)
    ---             ModUtil.Hades.PrintStack("maxInvestment.." .. metaUpgrade.MaxInvestment)
    ---             ModUtil.Hades.PrintStack("MaxCostIncrease.." .. metaUpgrade.MaxCostIncrease)
    ---             ModUtil.Hades.PrintStack("standardLevels.." .. metaUpgrade.standardLevels)
    ---         end
    ---         if metaUpgrade.MaxInvestment ~= nil and metaUpgrade.standardLevels ~= nil and index > metaUpgrade.standardLevels and metaUpgrade.MaxCostIncrease ~= nil then
    ---             if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---                 ModUtil.Hades.PrintStack("Using metaUpgrade.MaxCostIncrease additionalCost ")
    ---             end
    ---             additionalCost = metaUpgrade.MaxCostIncrease * (index - metaUpgrade.standardLevels)
    ---         elseif metaUpgrade.CostIncreaseInterval ~= nil and metaUpgrade.CostIncreaseInterval > 0 then
    ---             if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---                 ModUtil.Hades.PrintStack("Using metaUpgrade.CostIncreaseinterval metaupgrade")
    ---             end
    ---             additionalCost = math.floor(index / metaUpgrade.CostIncreaseInterval) * metaUpgrade.CostIncrease
    ---         end
    ---         local returnValue = metaUpgrade.Cost + additionalCost
    ---         if metaUpgrade.Icon  == "MirrorIcon_EpicBoonChance" then
    ---             ModUtil.Hades.PrintStack("Returning " .. returnValue)
    ---         end
    ---         return metaUpgrade.Cost + additionalCost
    ---     end
    --- end, BonusDarknessLevels)

    ModUtil.BaseOverride("StartNewRun",function( prevRun, args )
        -- NOTE: Need to completely replace startNewRun because I need to inject values into current run before doing some caluclations
        SetupRunData()
        ResetUI()

        CurrentRun = {}
        -- START CUSTOM CODE
        CurrentRun.MetaUpgrades = {} -- Remaking this missing datum for current run
        CurrentRun.DamageRecord = {}
        CurrentRun.HealthRecord = {}
        CurrentRun.ConsumableRecord = {}
        CurrentRun.ActualHealthRecord = {}
        CurrentRun.BlockTimerFlags = {}
        CurrentRun.WeaponsFiredRecord = {}
        for metaUpgradeName, metaUpgradeData in pairs( MetaUpgradeData ) do -- For every meta upgrade from the gamestate
            if GameState.MetaUpgrades[metaUpgradeName] ~= nil and MetaUpgradeData[metaUpgradeName] ~= nil then -- If there's a standard level cap
                CurrentRun.MetaUpgrades[metaUpgradeName] = GameState.MetaUpgrades[metaUpgradeName] -- add to the current run
                if MetaUpgradeData[metaUpgradeName].standardLevels ~= nil and GameState.MetaUpgrades[metaUpgradeName] > MetaUpgradeData[metaUpgradeName].standardLevels then --- If above the cap
                    GameState.MetaUpgrades[metaUpgradeName] = MetaUpgradeData[metaUpgradeName].standardLevels --Reset gamestate values to what the standard max is
                end 
            end
        end
        -- END OF CUSTOM CODE
        if args ~= nil then
            if args.RunOverrides ~= nil then
                for key, value in pairs( args.RunOverrides ) do
                    CurrentRun[key] = value
                end
            end
            CurrentRun.ForceNextEncounterData = args.Encounter
        end
        CurrentRun.Hero = CreateNewHero( prevRun, args )

        if prevRun ~= nil and prevRun.BonusDarknessWeapon ~= nil and CurrentRun.Hero.Weapons[ prevRun.BonusDarknessWeapon ] then
            AddTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait" )
        end

        EquipKeepsake( CurrentRun.Hero )
        EquipAssist( CurrentRun.Hero )
        EquipWeaponUpgrade( CurrentRun.Hero )
        CurrentRun.RoomHistory = {}
        UpdateRunHistoryCache( CurrentRun )
        CheckRunStartFlags( CurrentRun )

        CurrentRun.RoomCreations = {}
        CurrentRun.LootTypeHistory = {}
        CurrentRun.NPCInteractions = {}
        CurrentRun.AnimationState = {}
        CurrentRun.EventState = {}
        CurrentRun.ActivationRecord = {}
        CurrentRun.SpeechRecord = {}
        CurrentRun.TextLinesRecord = {}
        CurrentRun.TriggerRecord = {}
        CurrentRun.UseRecord = {}
        CurrentRun.GiftRecord = {}
        CurrentRun.HintRecord = {}
        CurrentRun.EnemyUpgrades = {}
        CurrentRun.BlockedEncounters = {}
        CurrentRun.InvulnerableFlags = {}
        CurrentRun.PhasingFlags = {}
        CurrentRun.Money = CalculateStartingMoney()
        CurrentRun.MoneySpent = 0
        CurrentRun.MoneyRecord = {}
        CurrentRun.BonusDarknessWeapon = GetRandomUnequippedWeapon()
        CurrentRun.ActiveObjectives = {}
        CurrentRun.RunDepthCache = 1
        CurrentRun.GameplayTime = 0
        CurrentRun.BiomeTime = 0
        CurrentRun.ActiveBiomeTimer = GetNumMetaUpgrades("BiomeSpeedShrineUpgrade") > 0
        CurrentRun.NumRerolls = GetNumMetaUpgrades( "RerollMetaUpgrade" ) + GetNumMetaUpgrades("RerollPanelMetaUpgrade")
        CurrentRun.ThanatosSpawns = 0
        CurrentRun.SupportAINames = {}
        CurrentRun.Hero.TargetMetaRewardsAdjustSpeed = 10.0
        CurrentRun.ClosedDoors = {}
        CurrentRun.CompletedStyxWings = 0
        CurrentRun.TargetShrinePointThreshold = GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() )
        CurrentRun.BannedEliteAttributes = {}
        if ConfigOptionCache.EasyMode then
            CurrentRun.EasyModeLevel = GameState.EasyModeLevel
        end
        InitHeroLastStands( CurrentRun.Hero )

        InitializeRewardStores( CurrentRun )
        SelectBannedEliteAttributes( CurrentRun )

        if args ~= nil and args.RoomName ~= nil then
            CurrentRun.CurrentRoom = CreateRoom( RoomData[args.RoomName], args )
        else
            CurrentRun.CurrentRoom = ChooseStartingRoom( CurrentRun, "Tartarus" )
        end

        return CurrentRun
    end, BonusDarknessLevels)
    
    ModUtil.WrapBaseFunction("HandleDeath", function( HandleDeath, currentRun, killer, killingUnitWeapon )
        --- On Handle death, make sure the metaupgrades are nulled out
        CurrentRun.MetaUpgrades = nil
        currentRun.MetaUpgrades = nil
        HandleDeath( currentRun, killer, killingUnitWeapon )
    end, BonusDarknessLevels)
end