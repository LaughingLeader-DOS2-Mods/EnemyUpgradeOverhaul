local TagBoost = Classes.TagBoost
local StatBoost = Classes.StatBoost
local ItemBoost = Classes.ItemBoost
local ItemBoostGroup = Classes.ItemBoostGroup

local ModBoosts = {
	--Odinblade Spectre Class
	["e4a5c8ca-7f04-23ab-8115-18161eb702bf"] = function()
		table.insert(ItemCorruption.Boosts.ObjectCategory.MageGloves, ItemBoostGroup:Create("SpectreSpells", {
			ItemBoost:Create({
				StatBoost:Create("Skills","Projectile_OdinSpectre_TormentedVolley"),
				StatBoost:Create("Skills","Projectile_OdinSpectre_EssenceBolt"),
				StatBoost:Create("Skills","Projectile_OdinSpectre_SoulPierce"),
				StatBoost:Create("Skills","Projectile_OdinSpectre_ConduitOfTheCruel"),
			},{Limit=1, All=false}),
		}, {Chance=20}))
	end,
	-- Odinblade's Scoundrel Overhaul
	["0dc94eaa-688d-4a90-b43b-1a1fb2392f84"] = function()
		table.insert(ItemCorruption.Boosts.ObjectCategory.LightGloves, ItemBoostGroup:Create("ScoundrelSkills", {
			ItemBoost:Create({
				StatBoost:Create("Skills","Target_OdinSCO_SinisterStrike"),
				StatBoost:Create("Skills","MultiStrike_OdinSCO_ShadowStep"),
				StatBoost:Create("Skills","Shout_OdinSCO_SlipIntoShadows"),
			},{Limit=1, All=false}),
		}, {Chance=20}))
	end,
}

local function AddModBoosts()
	for uuid,callback in pairs(ModBoosts) do
		if Ext.IsModLoaded(uuid) then
			pcall(callback)
		end
	end
end

return {
	Init = AddModBoosts
}