local entries = {
	LLENEMY_ShadowBonus_Madness = Classes.TagBoost:Create("LLENEMY_ShadowBonus_Madness","LLENEMY_ShadowBonus_Madness_Enabled", {HasToggleScript = true, DisplayInTooltip = true}),
	LLENEMY_ShadowBonus_StunDefense = Classes.TagBoost:Create("LLENEMY_ShadowBonus_StunDefense","LLENEMY_ShadowBonus_StunDefense_Enabled", {DisplayInTooltip = true}),
	LLENEMY_ShadowBonus_DotCleanser = Classes.TagBoost:Create("LLENEMY_ShadowBonus_DotCleanser","LLENEMY_ShadowBonus_DotCleanser_Enabled", {DisplayInTooltip = true}),
	LLENEMY_ShadowBonus_CursedFire = Classes.TagBoost:Create("LLENEMY_ShadowBonus_CursedFire","LLENEMY_ShadowBonus_CursedFire_Enabled", {DisplayInTooltip = true}),
	LLENEMY_ShadowBonus_ShockingRain = Classes.TagBoost:Create("LLENEMY_ShadowBonus_ShockingRain","LLENEMY_ShadowBonus_ShockingRain_Enabled", {DisplayInTooltip = true}),
	LLENEMY_ShadowBonus_SlipperyRogue = Classes.TagBoost:Create("LLENEMY_ShadowBonus_SlipperyRogue","LLENEMY_ShadowBonus_SlipperyRogue_Enabled", {DisplayInTooltip = true}),
	LLENEMY_ShadowBonus_DefensiveStart = Classes.TagBoost:Create("LLENEMY_ShadowBonus_DefensiveStart","LLENEMY_ShadowBonus_DefensiveStart_Enabled", {DisplayInTooltip = true}),
}

if Ext.IsClient() then
	Ext.RegisterListener("SessionLoaded", function()
		for tag,entry in pairs(entries) do
			LeaderLib.UI.RegisterItemTooltipTag(tag)
		end
	end)
end

return entries
