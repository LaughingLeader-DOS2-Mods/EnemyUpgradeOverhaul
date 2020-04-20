local TranslatedString = LeaderLib.Classes["TranslatedString"]

local ArmorBoostText = {Name = TranslatedString:Create("h05040c61g84bfg4989ga083g48f7642fbeb5","Armor Boost"), Color = "#CCCCCC"}
local MagicArmorBoostText = {Name = TranslatedString:Create("h8fecc0a7g0c7eg4a22g8528g1a6ac5bf5f30","Magic Armor Boost"), Color = "#4499FF"}
local VitalityBoostText = {Name = TranslatedString:Create("h0982817bgf111g4dc3g811bga9fbd51ab0ca","Vitality Boost"), Color = "#CC0000"}
local DamageBoostText = {Name = TranslatedString:Create("h6f6ccb6ag9cc6g4122g9040g432f4e787491","Damage Boost"), Color = "#FF0033"}

---@class UpgradeInfoData
local UpgradeInfoData = {
	---@type TranslatedString
	Name = {},
	Color = "#FFFFFF",
	Lore = 1
}
UpgradeInfoData.__index = UpgradeInfoData

---@param name TranslatedString
---@return UpgradeInfoData
function UpgradeInfoData:Create(name, ...)
    local this =
    {
		Name = name,
	}
	local params = {...}
	if params[1] ~= nil then
		this.Color = params[1]
	end
	if params[2] ~= nil then
		this.Lore = params[2]
	end
	setmetatable(this, self)
    return this
end

EnemyUpgradeOverhaul.UpgradeData = {
	Statuses = {
		LLENEMY_TALENT_BACKSTAB = UpgradeInfoData:Create(TranslatedString:Create("h9305ff62g9590g4f7fg82beg5e3ab9edafbf", "Talent: Backstab"), "#F59B00"),
		LLENEMY_TALENT_GLADIATOR = UpgradeInfoData:Create(TranslatedString:Create("h3d6d46bbg4819g48fbga980gcb521d5c49d8", "Talent: Gladiator"), "#F59B00"),
		LLENEMY_TALENT_GREEDYVESSEL = UpgradeInfoData:Create(TranslatedString:Create("h4cf1c406gceb1g411fga0d9gc9832cc4d2f5", "Talent: Greedy Vessel"), "#F1D466"),
		LLENEMY_TALENT_HAYMAKER = UpgradeInfoData:Create(TranslatedString:Create("h0dda4bf0g924ag4c8bgaf5ag1d6e7e643b50", "Talent: Haymaker"), "#B083FF"),
		LLENEMY_TALENT_INDOMITABLE = UpgradeInfoData:Create(TranslatedString:Create("hb52d1ac1g7c4fg45a4g87d8g52056a5a2ba2", "Talent: Indomitable"), "#DC0015"),
		LLENEMY_TALENT_LEECH = UpgradeInfoData:Create(TranslatedString:Create("h7e28471fg1959g47e6g9d58g4d4f8ce054f6", "Talent: Leech"), "#DC0015"),
		LLENEMY_TALENT_LONEWOLF = UpgradeInfoData:Create(TranslatedString:Create("h3b229661g43b9g44e1gbaebgc33ab487ce44", "Talent: Lone Wolf"), "#DC0015", 3),
		LLENEMY_TALENT_MAGICCYCLES = UpgradeInfoData:Create(TranslatedString:Create("h09ee507ag16fag471cg9e13gf4b0a614dcb8", "Talent: Magic Cycles"), "#22C3FF"),
		LLENEMY_TALENT_MASTERTHIEF = UpgradeInfoData:Create(TranslatedString:Create("hba05c2f9g55f0g4b5agb936g5ff5daa6877e", "Talent: Master Thief"), "#F1D466"),
		LLENEMY_TALENT_QUICKSTEP = UpgradeInfoData:Create(TranslatedString:Create("h79f5b874g6cb3g4a99ga1cfg9f472c12036f", "Talent: The Pawn"), "#AABB00"),
		LLENEMY_TALENT_RANGERRANGE = UpgradeInfoData:Create(TranslatedString:Create("h15a9ae98gb2d3g49d5gbccbg0aecd38fe18c", "Talent: Quickdraw"), "#AABB00"),
		LLENEMY_TALENT_SADIST = UpgradeInfoData:Create(TranslatedString:Create("h1c81c46bg9330g4d43gba21g6b72b951b3fd", "Talent: Sadist"), "#FF3382", 2),
		LLENEMY_TALENT_SOULCATCHER = UpgradeInfoData:Create(TranslatedString:Create("h9a2a7390gc764g4fa0g8e97gf73ffac2a93c", "Talent: Soulcatcher"), "#22C3FF"),
		LLENEMY_TALENT_TORTURER = UpgradeInfoData:Create(TranslatedString:Create("h18ff40ffg5d06g48c6gb09egaec569a55aa8", "Talent: Torturer"), "#DC0015", 2),
		LLENEMY_TALENT_WHATARUSH = UpgradeInfoData:Create(TranslatedString:Create("hd0938a28g404dg47bagb7afg1ab9a2215f9d", "Talent: What a Rush"), "#47E982", 1),
		LLENEMY_TALENT_UNSTABLE = UpgradeInfoData:Create(TranslatedString:Create("h2b8ca96eg181cg4d13gaef5g84d2bb6f88fc", "Talent: Unstable"), "#FF3382", 1),
		LLENEMY_INF_ACID = UpgradeInfoData:Create(TranslatedString:Create("he9cb8fddg5db3g4d64ga27cgb93613250725", "Melter"), "#81AB00"),
		LLENEMY_INF_ACID_G = UpgradeInfoData:Create(TranslatedString:Create("h1049b802g537bg4815gb5b6g34c387f9aa9c", "Elite Melter"), "#81AB00"),
		LLENEMY_INF_BLESSED_ICE = UpgradeInfoData:Create(TranslatedString:Create("h6e85fa28gc76eg423egaf24g5c0c278717bf", "Heatsapper"), "#CFECFF"),
		LLENEMY_INF_BLESSED_ICE_G = UpgradeInfoData:Create(TranslatedString:Create("h9cf11b15g91d4g4d12gae38ga5a8f70272be", "Elite Heatsapper"), "#CFECFF"),
		LLENEMY_INF_BLOOD = UpgradeInfoData:Create(TranslatedString:Create("h0d2c2ac4g44e2g48dfg835dgcc860fcdd0d9", "Bloodbender"), "#AA3938"),
		LLENEMY_INF_BLOOD_G = UpgradeInfoData:Create(TranslatedString:Create("h31d032dcg2e05g4d91gb846g125bbed07f42", "Elite Bloodbender"), "#AA3938"),
		LLENEMY_INF_CURSED_ELECTRIC = UpgradeInfoData:Create(TranslatedString:Create("hd71fe8a1g0247g42c5g8bfcg2408029eca06", "Teslacoil"), "#7F25D4"),
		LLENEMY_INF_CURSED_ELECTRIC_G = UpgradeInfoData:Create(TranslatedString:Create("hdcdcd727gc9e6g4548g88dag25a265517c1b", "Elite Teslacoil"), "#7F25D4"),
		LLENEMY_INF_ELECTRIC = UpgradeInfoData:Create(TranslatedString:Create("hd419ca09g8d69g4af6g840egdd4a81f7587f", "Circuitbreaker"), "#7D71D9"),
		LLENEMY_INF_ELECTRIC_G = UpgradeInfoData:Create(TranslatedString:Create("h24cc83b3g5ce3g44d2ga7fbg7c743030b0a2", "Elite Circuitbreaker"), "#7D71D9"),
		LLENEMY_INF_FIRE = UpgradeInfoData:Create(TranslatedString:Create("hc3f8497bg97acg449ag910ag07b825f3b8bb", "Firestarter"), "#FE6E27"),
		LLENEMY_INF_FIRE_G = UpgradeInfoData:Create(TranslatedString:Create("hd880d646g45b4g4fa6ga6cbgd746dcd242bd", "Elite Firestarter"), "#FE6E27"),
		LLENEMY_INF_NECROFIRE = UpgradeInfoData:Create(TranslatedString:Create("h8e75cbbdg06d7g4404gbfb2g92f6fd11147d", "Infernoblazer"), "#FFAB00"),
		LLENEMY_INF_NECROFIRE_G = UpgradeInfoData:Create(TranslatedString:Create("had606e03g6713g4064g84c0gf28395d81019", "Elite Infernoblazer"), "#FE6E27"),
		LLENEMY_INF_OIL = UpgradeInfoData:Create(TranslatedString:Create("hba68eb52gbd87g443fga8acgb61922bf4211", "Earthcracker"	), "#C7A758"),
		LLENEMY_INF_OIL_G = UpgradeInfoData:Create(TranslatedString:Create("he7dfdae3gf1bbg47ecg84edg1a094e326d94", "Elite Earthcracker"), "#C7A758"),
		LLENEMY_INF_POISON = UpgradeInfoData:Create(TranslatedString:Create("h78f9641bgaf92g4bc4gb27bg759d63a0353f", "Venomstriker"), "#65C900"),
		LLENEMY_INF_POISON_G = UpgradeInfoData:Create(TranslatedString:Create("h0e137225ge71fg4b5dg9822g1f73a6646671", "Elite Venomstriker"), "#65C900"),
		LLENEMY_INF_WATER = UpgradeInfoData:Create(TranslatedString:Create("h645270dag6b15g47a8gad4bgfcc34034a77e", "Cascader"), "#1199DE"),
		LLENEMY_INF_WATER_G = UpgradeInfoData:Create(TranslatedString:Create("h70e74b6fg7c33g41e5g8bf4g6fe9a096a69d", "Elite Cascader"), "#188EFF"),
		LLENEMY_BONUS_TREASURE_ROLL = UpgradeInfoData:Create(TranslatedString:Create("h194ac7f5g9da2g4067g83efgf23de735ad79", "Bonus Treasure"), "#D040D0"),
		LLENEMY_IMMUNITY_LOSECONTROL = UpgradeInfoData:Create(TranslatedString:Create("h8cfd1ba3gcfb3g4f0cga950gc29672af34c9", "Perfect Control"), "#FFAB00"),
		LLENEMY_DOUBLE_DIP = UpgradeInfoData:Create(TranslatedString:Create("hf180561cge97ag426cg84ddg83dd257ce95d", "Double Dip"), "#D040D0"),
		LLENEMY_PERSEVERANCE_MASTERY = UpgradeInfoData:Create(TranslatedString:Create("hdaeb8fa0g4a4fg4cd5gbf0eg0c7cbe96c990", "Perseverance Mastery"), "#F1D466", 3),
		LLENEMY_BONUSSKILLS_SINGLE = UpgradeInfoData:Create(TranslatedString:Create("he79478e5gfa95g4461gba2bg9122ba540b28", "Bonus Skill"), "#F1D466", 1),
		LLENEMY_BONUSSKILLS_SOURCE = UpgradeInfoData:Create(TranslatedString:Create("hd1a568b1g2c56g4343gb1fcg4ae8f47c28e4", "Bonus Source Skill"), "#46B195", 4),
		LLENEMY_BONUSSKILLS_SET_NORMAL = UpgradeInfoData:Create(TranslatedString:Create("h5aa2a41bgbaa4g46d0g9987ge5c19c4b4aa4", "Bonus Skillset"), "#B823CB", 3),
		LLENEMY_BONUSSKILLS_SET_ELITE = UpgradeInfoData:Create(TranslatedString:Create("h7040a2f0g29d3g43d6ga656gb5eb0aac1934", "Elite Skillset"), "#73F6FF", 4),
		-- Hidden vanilla statuses
		LLENEMY_HERBMIX_COURAGE = UpgradeInfoData:Create(TranslatedString:Create("h503bd9fag7526g41abgbe28g612e3bffe6a1","Courage"), "#AAF0FF"),
		LLENEMY_HERBMIX_FEROCITY = UpgradeInfoData:Create(TranslatedString:Create("hefe488c0g2e40g4f25gb312g21899f4bbd90","Ferocity"), "#FF3382"),
		LLENEMY_FARSIGHT = UpgradeInfoData:Create(TranslatedString:Create("hcfb65642g97f6g46b5g9d2bg359144ae1012","Farsight"), "#88A25B"),
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

EnemyUpgradeOverhaul.DropText = TranslatedString:Create("h623a7ed0gaaacg4c3egacdfg56f3c23a1dec", "<font color='#00FFAA' size='16'>Will drop [1] on death.</font>")
EnemyUpgradeOverhaul.ShadowDropText = TranslatedString:Create("h662390f7gfd9eg4a56g95e5g658283cc548a", "<font color='#9B30FF' size='16'>Grants Treasure of the Shadow Realm ([1]) on death.</font>")

EnemyUpgradeOverhaul.HiddenDropText = TranslatedString:Create("h623a9ed0gaaacg4c3egacdfg56f1c23a1dec", "<font color='#00FFAA' size='16'>Drops ??? on death.</font>")
EnemyUpgradeOverhaul.HiddenShadowDropText = TranslatedString:Create("h882390f1gfd9eg4a56g95e5g658283cc548a", "<font color='#9B30FF' size='16'>Drops ??? on death.</font>")

EnemyUpgradeOverhaul.ChallengePointsText = {
	{Tag = "LLENEMY_CP_01", Min = 1, Max = 10, Text = TranslatedString:Create("h5addfbc4gcac7g4935g8effg8096574b8913", "<font color='#FFFFFF' size='12'>Regular Bonus Loot</font>")},
	{Tag = "LLENEMY_CP_02", Min = 11, Max = 16, Text = TranslatedString:Create("h8a442345g8c3ag4161g8f45gd93745f99d3e", "<font color='#4197E2' size='14'>Great Loot</font>")},
	{Tag = "LLENEMY_CP_03", Min = 17, Max = 31, Text = TranslatedString:Create("hf03d120ag2329g476dg94dcg7df0d27c3e1e", "<font color='#F7BA14' size='16'>Good Loot</font>")},
	{Tag = "LLENEMY_CP_04", Min = 32, Max = 99, Text = TranslatedString:Create("h8886e1f1gb725g4e9fg8f5bg4ab1f7262f48", "<font color='#B823CB' size='18'>Great Loot</font>")},
	{Tag = "LLENEMY_CP_05", Min = 100, Max = 999, Text = TranslatedString:Create("h99aba0bag7acbg4deagb9f3g0c52b807ce09", "<font color='#FF00CC' size='18'>Amazing Loot</font>")},
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