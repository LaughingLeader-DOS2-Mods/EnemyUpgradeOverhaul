---@type ModSettings
local ModSettings = LeaderLib.Classes.ModSettingsClasses.ModSettings
local settings = ModSettings:Create("046aafd8-ba66-4b37-adfb-519c1a5d04d7")
settings.Global:AddFlags({
	"LLENEMY_Debug_LevelCapDisabled",
	"LLENEMY_EnemyLevelingEnabled",
	"LLENEMY_HardModeEnabled",
	"LLENEMY_HardModeRollingDisabled",
	"LLENEMY_RewardsDisabled",
	"LLENEMY_VoidwokenSourceSpawningEnabled",
	--"LLENEMY_WorldUpgradesEnabled",
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
settings.Global:AddVariable("LLENEMY_Scaling_LevelModifier", 0)
settings.Global:AddVariable("Hardmode_MinBonusRolls", 1)
settings.Global:AddVariable("Hardmode_MaxBonusRolls", 4)

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