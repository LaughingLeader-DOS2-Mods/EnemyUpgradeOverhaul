local settings = LeaderLib.SettingsManager.GetMod("046aafd8-ba66-4b37-adfb-519c1a5d04d7", true, false)
settings.Global:AddLocalizedFlags({
	"LLENEMY_Debug_LevelCapDisabled",
	"LLENEMY_EnemyLevelingEnabled",
	"LLENEMY_HardModeEnabled",
	"LLENEMY_HardModeRollingDisabled",
	"LLENEMY_RewardsDisabled",
	"LLENEMY_VoidwokenSourceSpawningEnabled",
	"LLENEMY_AuraUpgradesDisabled",
	"LLENEMY_BonusBuffUpgradesDisabled",
	"LLENEMY_BonusSkillsUpgradesDisabled",
	"LLENEMY_BuffUpgradesDisabled",
	"LLENEMY_ClassUpgradesUpgradesDisabled",
	"LLENEMY_DuplicationUpgradesDisabled",
	"LLENEMY_ImmunityUpgradesDisabled",
	"LLENEMY_TalentUpgradesDisabled",
	"LLENEMY_SummoningUpgradesDisabled",
})
settings.Global:AddLocalizedVariable("LLENEMY_Scaling_LevelModifier", "LLENEMY_Variable_AutoLeveling_Modifier", 0, 30, 1)
settings.Global:AddLocalizedVariable("Hardmode_MinBonusRolls", "LLENEMY_Variable_Hardmode_MinBonusRolls", 1, 4, 1)
settings.Global:AddLocalizedVariable("Hardmode_MaxBonusRolls", "LLENEMY_Variable_Hardmode_MaxBonusRolls", 4, 6, 1)
--settings.Global:AddLocalizedVariable("EnemySkillIgnoreList", {})

---@param self SettingsData
---@param name string
---@param data VariableData
settings.UpdateVariable = function(self, name, data)
	if name == "LLENEMY_Scaling_LevelModifier" then
		local entry = Osi.DB_LLENEMY_LevelModifier:Get(nil)
		if entry ~= nil then
			data.Value = entry[1][1]
		end
	end
end
return settings