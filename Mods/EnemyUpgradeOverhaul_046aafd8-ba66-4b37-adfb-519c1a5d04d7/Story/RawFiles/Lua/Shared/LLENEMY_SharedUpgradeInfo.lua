local TranslatedString = LeaderLib.Classes["TranslatedString"]

local ArmorBoostText = {Name = TranslatedString:Create("h05040c61g84bfg4989ga083g48f7642fbeb5","Armor Boost"), Color = "#CCCCCC"}
local MagicArmorBoostText = {Name = TranslatedString:Create("h8fecc0a7g0c7eg4a22g8528g1a6ac5bf5f30","Magic Armor Boost"), Color = "#4499FF"}
local VitalityBoostText = {Name = TranslatedString:Create("h0982817bgf111g4dc3g811bga9fbd51ab0ca","Vitality Boost"), Color = "#CC0000"}
local DamageBoostText = {Name = TranslatedString:Create("h6f6ccb6ag9cc6g4122g9040g432f4e787491","Damage Boost"), Color = "#FF0033"}

EnemyUpgradeOverhaul.UpgradeData = {
	Statuses = {
		LLENEMY_TALENT_BACKSTAB = {Name = TranslatedString:Create("h9305ff62g9590g4f7fg82beg5e3ab9edafbf", "Talent: Backstab"), Color = "#F59B00"},
		LLENEMY_TALENT_GLADIATOR = {Name = TranslatedString:Create("h3d6d46bbg4819g48fbga980gcb521d5c49d8", "Talent: Gladiator"), Color = "#F59B00"},
		LLENEMY_TALENT_GREEDYVESSEL = {Name = TranslatedString:Create("h4cf1c406gceb1g411fga0d9gc9832cc4d2f5", "Talent: Greedy Vessel"), Color = "#E9D047"},
		LLENEMY_TALENT_HAYMAKER = {Name = TranslatedString:Create("h0dda4bf0g924ag4c8bgaf5ag1d6e7e643b50", "Talent: Haymaker"), Color = "#b083ff"},
		LLENEMY_TALENT_INDOMITABLE = {Name = TranslatedString:Create("hb52d1ac1g7c4fg45a4g87d8g52056a5a2ba2", "Talent: Indomitable"), Color = "#e94947"},
		LLENEMY_TALENT_LEECH = {Name = TranslatedString:Create("h7e28471fg1959g47e6g9d58g4d4f8ce054f6", "Talent: Leech"), Color = "#C80030"},
		LLENEMY_TALENT_LONEWOLF = {Name = TranslatedString:Create("h3b229661g43b9g44e1gbaebgc33ab487ce44", "Talent: Lone Wolf"), Color = "#DC0015"},
		LLENEMY_TALENT_MAGICCYCLES = {Name = TranslatedString:Create("h09ee507ag16fag471cg9e13gf4b0a614dcb8", "Talent: Magic Cycles"), Color = "#22c3ff"},
		LLENEMY_TALENT_MASTERTHIEF = {Name = TranslatedString:Create("hba05c2f9g55f0g4b5agb936g5ff5daa6877e", "Talent: Master Thief"), Color = "#C9AA58"},
		LLENEMY_TALENT_QUICKSTEP = {Name = TranslatedString:Create("h79f5b874g6cb3g4a99ga1cfg9f472c12036f", "Talent: The Pawn"), Color = "#AABB00"},
		LLENEMY_TALENT_RANGERRANGE = {Name = TranslatedString:Create("h15a9ae98gb2d3g49d5gbccbg0aecd38fe18c", "Talent: Quickdraw"), Color = "#AABB00"},
		LLENEMY_TALENT_SADIST = {Name = TranslatedString:Create("h1c81c46bg9330g4d43gba21g6b72b951b3fd", "Talent: Sadist"), Color = "#ff5771"},
		LLENEMY_TALENT_SOULCATCHER = {Name = TranslatedString:Create("h9a2a7390gc764g4fa0g8e97gf73ffac2a93c", "Talent: Soulcatcher"), Color = "#73F6FF"},
		LLENEMY_TALENT_TORTURER = {Name = TranslatedString:Create("h18ff40ffg5d06g48c6gb09egaec569a55aa8", "Talent: Torturer"), Color = "#960000"},
		LLENEMY_TALENT_WHATARUSH = {Name = TranslatedString:Create("hd0938a28g404dg47bagb7afg1ab9a2215f9d", "Talent: What a Rush"), Color = "#47e982"},
		LLENEMY_INF_ACID = {Name = TranslatedString:Create("he9cb8fddg5db3g4d64ga27cgb93613250725", "Melter"), Color = "#81AB00"},
		LLENEMY_INF_ACID_G = {Name = TranslatedString:Create("h1049b802g537bg4815gb5b6g34c387f9aa9c", "Elite Melter"), Color = "#81AB00"},
		LLENEMY_INF_BLESSED_ICE = {Name = TranslatedString:Create("h6e85fa28gc76eg423egaf24g5c0c278717bf", "Heatsapper"), Color = "#CFECFF"},
		LLENEMY_INF_BLESSED_ICE_G = {Name = TranslatedString:Create("h9cf11b15g91d4g4d12gae38ga5a8f70272be", "Elite Heatsapper"), Color = "#CFECFF"},
		LLENEMY_INF_BLOOD = {Name = TranslatedString:Create("h0d2c2ac4g44e2g48dfg835dgcc860fcdd0d9", "Bloodbender"), Color = "#AA3938"},
		LLENEMY_INF_BLOOD_G = {Name = TranslatedString:Create("h31d032dcg2e05g4d91gb846g125bbed07f42", "Elite Bloodbender"), Color = "#AA3938"},
		LLENEMY_INF_CURSED_ELECTRIC = {Name = TranslatedString:Create("hd71fe8a1g0247g42c5g8bfcg2408029eca06", "Teslacoil"), Color = "#7F25D4"},
		LLENEMY_INF_CURSED_ELECTRIC_G = {Name = TranslatedString:Create("hdcdcd727gc9e6g4548g88dag25a265517c1b", "Elite Teslacoil"), Color = "#7F25D4"},
		LLENEMY_INF_ELECTRIC = {Name = TranslatedString:Create("hd419ca09g8d69g4af6g840egdd4a81f7587f", "Circuitbreaker"), Color = "#7D71D9"},
		LLENEMY_INF_ELECTRIC_G = {Name = TranslatedString:Create("h24cc83b3g5ce3g44d2ga7fbg7c743030b0a2", "Elite Circuitbreaker"), Color = "#7D71D9"},
		LLENEMY_INF_FIRE = {Name = TranslatedString:Create("hc3f8497bg97acg449ag910ag07b825f3b8bb", "Firestarter"), Color = "#FE6E27"},
		LLENEMY_INF_FIRE_G = {Name = TranslatedString:Create("hd880d646g45b4g4fa6ga6cbgd746dcd242bd", "Elite Firestarter"), Color = "#FE6E27"},
		LLENEMY_INF_NECROFIRE = {Name = TranslatedString:Create("h8e75cbbdg06d7g4404gbfb2g92f6fd11147d", "Infernoblazer"), Color = "#DD9911"},
		LLENEMY_INF_NECROFIRE_G = {Name = TranslatedString:Create("had606e03g6713g4064g84c0gf28395d81019", "Elite Infernoblazer"), Color = "#FE6E27"},
		LLENEMY_INF_OIL = {Name = TranslatedString:Create("hba68eb52gbd87g443fga8acgb61922bf4211", "Earthcracker"	), Color = "#C7A758"},
		LLENEMY_INF_OIL_G = {Name = TranslatedString:Create("he7dfdae3gf1bbg47ecg84edg1a094e326d94", "Elite Earthcracker"), Color = "#C7A758"},
		LLENEMY_INF_POISON = {Name = TranslatedString:Create("h78f9641bgaf92g4bc4gb27bg759d63a0353f", "Venomstriker"), Color = "#65C900"},
		LLENEMY_INF_POISON_G = {Name = TranslatedString:Create("h0e137225ge71fg4b5dg9822g1f73a6646671", "Elite Venomstriker"), Color = "#65C900"},
		LLENEMY_INF_WATER = {Name = TranslatedString:Create("h645270dag6b15g47a8gad4bgfcc34034a77e", "Cascader"), Color = "#1199DE"},
		LLENEMY_INF_WATER_G = {Name = TranslatedString:Create("h70e74b6fg7c33g41e5g8bf4g6fe9a096a69d", "Elite Cascader"), Color = "#188EFF"},
		LLENEMY_BONUS_TREASURE_ROLL = {Name = TranslatedString:Create("h194ac7f5g9da2g4067g83efgf23de735ad79", "Bonus Treasure"), Color = "#D040D0"},
		LLENEMY_IMMUNITY_LOSECONTROL = {Name = TranslatedString:Create("h8cfd1ba3gcfb3g4f0cga950gc29672af34c9", "Perfect Control"), Color = "#FFAB00"},
		LLENEMY_DOUBLE_DIP = {Name = TranslatedString:Create("hf180561cge97ag426cg84ddg83dd257ce95d", "Double Dip"), Color = "#FF22FF"},
		LLENEMY_PERSEVERANCE_MASTERY = {Name = TranslatedString:Create("hdaeb8fa0g4a4fg4cd5gbf0eg0c7cbe96c990", "Perseverance Mastery"), Color = "#E4CE93"},
		LLENEMY_BONUSSKILLS_SINGLE = {Name = TranslatedString:Create("he79478e5gfa95g4461gba2bg9122ba540b28", "Bonus Skill"), Color = "#F1D466"},
		LLENEMY_BONUSSKILLS_SOURCE = {Name = TranslatedString:Create("hd1a568b1g2c56g4343gb1fcg4ae8f47c28e4", "Bonus Source Skill"), Color = "#46B195"},
		LLENEMY_BONUSSKILLS_SET_NORMAL = {Name = TranslatedString:Create("h5aa2a41bgbaa4g46d0g9987ge5c19c4b4aa4", "Bonus Skillset"), Color = "#B823CB"},
		LLENEMY_BONUSSKILLS_SET_ELITE = {Name = TranslatedString:Create("h7040a2f0g29d3g43d6ga656gb5eb0aac1934", "Elite Skillset"), Color = "#73F6FF"},
		-- Hidden vanilla statuses
		LLENEMY_HERBMIX_COURAGE = {Name = TranslatedString:Create("h503bd9fag7526g41abgbe28g612e3bffe6a1","Courage"), Color = "#AAF0FF"},
		LLENEMY_HERBMIX_FEROCITY = {Name = TranslatedString:Create("h6eb5da84g4569g4975g9b4dgbd3f7dffeb2a","Demonic Celerity"), Color = "#FF3322"},
		LLENEMY_FARSIGHT = {Name = TranslatedString:Create("hcfb65642g97f6g46b5g9d2bg359144ae1012","Farsight"), Color = "#88A25B"},
	},
	--Generated Boosts
	DamageBoostStatuses = {
		["LLENEMY_BOOST_DAMAGE_5"] = DamageBoostText,
		["LLENEMY_BOOST_DAMAGE_10"] = DamageBoostText,
		["LLENEMY_BOOST_DAMAGE_15"] = DamageBoostText,
		["LLENEMY_BOOST_DAMAGE_20"] = DamageBoostText,
		["LLENEMY_BOOST_DAMAGE_25"] = DamageBoostText,
	},
	VitalityBoostStatuses = {
		["LLENEMY_BOOST_VITALITY_5"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_10"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_15"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_20"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_25"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_30"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_35"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_40"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_45"] = VitalityBoostText,
		["LLENEMY_BOOST_VITALITY_50"] = VitalityBoostText,
	},
	ArmorBoostStatuses = {
		["LLENEMY_BOOST_ARMOR_5"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_10"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_15"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_20"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_25"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_30"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_35"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_40"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_45"] = ArmorBoostText,
		["LLENEMY_BOOST_ARMOR_50"] = ArmorBoostText,
	},
	MagicArmorBoostStatuses = {
		["LLENEMY_BOOST_MAGICARMOR_5"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_10"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_15"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_20"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_25"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_30"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_35"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_40"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_45"] = MagicArmorBoostText,
		["LLENEMY_BOOST_MAGICARMOR_50"] = MagicArmorBoostText,
	},
}

---Get an upgrade's info text table.
---@param status string
---@return table
function LLENEMY_Ext_UpgradeInfo_GetText(status)
	local infoText = EnemyUpgradeOverhaul.UpgradeData.Statuses[status]
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.ArmorBoostStatuses[status] end
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.MagicArmorBoostStatuses[status] end
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.DamageBoostStatuses[status] end
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.VitalityBoostStatuses[status] end
	if infoText ~= nil then
		return infoText
	end
	return nil
end