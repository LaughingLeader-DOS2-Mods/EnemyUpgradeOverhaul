local ShadowItemNames = {
	"Ac'thaorrirc",
	"Ach-Math",
	"Acxuthash",
	"Agibhus",
	"Aibradhrish",
	"Aibragnuh",
	"Aikhubrorh",
	"Ainaioxo",
	"Aiueghrouthler",
	"Aiughrimbre",
	"Aiuxothlarh",
	"Aizyggdu",
	"Alost",
	"Amhygnexz",
	"Anougr'itho",
	"Athoughad",
	"Avrethlor",
	"Bhap'gni",
	"Bhiopaxr",
	"Botha",
	"Braognu",
	"Brejhi",
	"Bryndoh",
	"C'tholp'gno",
	"Cnirv'dror",
	"Ctedro",
	"Cthucno",
	"Cthymbrix",
	"Ctiojh'dhrox",
	"Ctuggilbh",
	"Cxedhros",
	"Cxezun",
	"Cxocnurc",
	"D'aacto",
	"D'aorv'gnalbh",
	"D'oct'drust",
	"D'undilbh",
	"Dh-Ugu",
	"Dhorthoth-Mor",
	"Dithro",
	"Eghaior'ithi",
	"Eghrap'metl",
	"Egl-Iat",
	"Ekhidhr'xexz",
	"Ephothaol",
	"Eshoubhush",
	"Evraobrah",
	"Ghiothrherc",
	"Gho-Dacte",
	"Ghraadrr'rolbh",
	"Ghraarvesz",
	"Ghrelth'vhass",
	"Ghrognnor",
	"Gn'both",
	"Grebr'itrelbh",
	"Grourvo",
	"Hakeih-Rhla",
	"Iakhuidr'dhroh",
	"Iakthaadrran",
	"Iaubrolped",
	"Iaudaobh'krun",
	"Iauv'atlen",
	"Iauzoxixr",
	"Ibhuxhag",
	"Icnorr'dhreg",
	"Icthaztosz",
	"Ictoulug",
	"Idurv'kud",
	"Igactachua",
	"Iggn-Kehlor",
	"Iggtilao",
	"Ihon",
	"Illa",
	"Itothrath",
	"Itumbra",
	"Iushexhod",
	"Iuthulpast",
	"Iuvhaiozhoh",
	"Ivh'orus",
	"Ivizh'xe",
	"Kegnu",
	"Kelhathaniha",
	"Kelkal",
	"Khoxul",
	"Khyjh'krerh",
	"Kiothlux",
	"Kthaolpun",
	"Ktheggd'xeg",
	"Mh'edhro",
	"Mh'edre",
	"Mh'ujh'ithulbh",
	"Mhourv'ithu",
	"Mhuimbre",
	"Mluilkun",
	"N'kigoshat",
	"Naul",
	"Ngathlu",
	"Ngibhexr",
	"Ntharuggndho",
	"Od'uillarc",
	"Ot-Ot",
	"Oth-Nor",
	"Ozhaioghox",
	"Phabboisc",
	"Rniglo",
	"Shotha",
	"Taal'vho",
	"Taola",
	"Taorrass",
	"Th'thuarlatl",
	"Thuklex",
	"Toklor",
	"Tribrest",
	"Uakrn",
	"Ubornot-Gush",
	"Ubrivhuxr",
	"Uctaarin",
	"Ucthioghaxz",
	"Ugaxhig",
	"Ugott-Eit",
	"Ukhithuth",
	"Ukhorvilb",
	"Ukhougnatl",
	"Utrygdurh",
	"V'iozi",
	"V'yl'xa",
	"Vaiogh'dhre",
	"Vh'agro",
	"Vh'ylk'enda",
	"Vhaogd'drirc",
	"Vhograx",
	"Vruxhelbh",
	"Yamhaokle",
	"Yamlodrexr",
	"Yaz'oggd'kroxz",
	"Yazaggd'ithast",
	"Yg'stago",
	"Yighraokl'ler",
	"Yigraogr'zhe",
	"Yishuivheh",
	"Yiv'ioggdelbh",
	"Yokelpest",
	"Yomhuira",
	"Yov'aiothle",
	"Ythucnotl",
	"Z'iztexz",
	"Z'uthab",
	"Zaiozhun",
	"Zhoztid",
	"Zithix",
	"Actaioxon",
	"Aizhulthe",
	"Anguzhus",
	"Bhuggdash",
	"Bhylthas",
	"Brunda",
	"Diogro",
	"Douxuth",
	"Grolp'endotl",
	"Ihiozed",
	"Imh'iognna",
	"Ivh'unda",
	"Mhopass",
	"Ngygh'xulb",
	"Onguth'lu",
	"Ud'aand'xel",
	"Uzhaiodr'kru",
	"Vh'ibrix",
	"Vh'ubha",
	"Yigaagnu",
}

local nameColors = {
	"#2E0854",
	"#4B0082",
	"#551A8B",
	"#5E2D79",
	"#660198",
	"#68228B",
	"#694489",
	"#6B238E",
	"#71637D",
	"#72587F",
	"#7D26CD",
	"#7F00FF",
	"#8A2BE2",
	"#912CEE",
	"#9932CC",
	"#9932CD",
	"#9A32CD",
	"#9B30FF",
	"#A020F0",
	"#AA00FF",
	"#B23AEE",
	"#BDA0CB",
	"#BF3EFF",
	"#BF5FFF",
}

local TranslatedString = LeaderLib.Classes["TranslatedString"]

local ShadowItemFallbackDescription = "A <i>strange</i> item retrieved from a <font color='#9B30FF' face='Copperplate Gothic Bold'>Shadow Orb</font>.<br><font color='#BDA0CB'>Cold to the touch, when this item is held, your grip on reality may begin to slip.</font>"
local ShadowItemDescription = TranslatedString:Create("h179efab0g7e6cg441ag8083gb11964394dc4", ShadowItemFallbackDescription)

local BOOSTS = {
	Weapon = {
		{MinLevel = 0, Boost = "LLENEMY_Boost_Weapon_Damage_Shadow_Small"},
		{MinLevel = 8, Boost = "LLENEMY_Boost_Weapon_Damage_Shadow_Medium"},
		{MinLevel = 12, Boost = "LLENEMY_Boost_Weapon_Damage_Shadow_Large"},
	}
}

local function AddRandomBoosts(item,stat,statType,level)
	local boostTable = BOOSTS[statType]
	if boostTable ~= nil then
		local boosts = {}
		for i,entry in pairs(boostTable) do
			if entry.MinLevel >= level then
				boosts[#boosts+1] = entry.Boost
			end
		end
		local boostCount = #boosts
		local deltaMod = nil
		if boostCount == 1 then
			deltaMod = boosts[1]
		elseif boostCount > 0 then
			deltaMod = LeaderLib.Common.GetRandomTableEntry(boosts)
		end

		if deltaMod ~= nil then
			NRD_ItemCloneAddBoost("DeltaMod", deltaMod)
			if Ext.IsDeveloperMode() then
				LeaderLib.Print("[LLENEMY:LLENEMY_ItemMechanics.lua:AddRandomBoosts] Adding deltamod ("..deltaMod..") to item ["..item.."]("..stat..") at level ("..tostring(level)..")")
			end
		end
	end
end

local function SetRandomShadowName(item)
	--local handle,templateName = ItemTemplateGetDisplayString(item)
	local name = LeaderLib.Common.GetRandomTableEntry(ShadowItemNames)
	local color = LeaderLib.Common.GetRandomTableEntry(nameColors)
	name = string.format("<font color='%s'>%s</font>", color, name)
	NRD_ItemCloneSetString("CustomDisplayName", name)
	if Ext.IsDeveloperMode() then
		LeaderLib.Print("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] New shadow item name is ("..name..")")
	end
	NRD_ItemCloneSetString("CustomDescription", ShadowItemDescription.Value)
end

local function GetClone(item,stat,statType)
	local baseStat,rarity,level,seed = NRD_ItemGetGenerationParams(item)
	if level == nil then
		level = NRD_ItemGetInt(item, "LevelOverride")
		if level == 0 or level == nil then
			level = CharacterGetLevel(CharacterGetHostCharacter())
		end
	end
	if rarity == nil then rarity = "Rare" end
    local template = GetTemplate(item)
	local last_underscore = string.find(template, "_[^_]*$")
	local stripped_template = string.sub(template, last_underscore+1)
	NRD_ItemCloneBegin(item)
	NRD_ItemCloneResetProgression()
	NRD_ItemCloneSetString("RootTemplate", stripped_template)
	NRD_ItemCloneSetString("OriginalRootTemplate", stripped_template)
	if stat == nil or stat == "" then
		stat = baseStat
	end
	if seed ~= nil and seed > 0 then
		NRD_ItemCloneSetInt("GenerationRandom", seed)
	else
		NRD_ItemCloneSetInt("GenerationRandom", LEADERLIB_RAN_SEED)
	end

	if statType == "Weapon" then
		-- Damage type fix
		-- Deltamods with damage boosts may make the weapon's damage type be all of that type, so overwriting the statType
		-- fixes this issue.
		local damageTypeString = Ext.StatGetAttribute(stat, "Damage Type")
		if damageTypeString == nil then damageTypeString = "Physical" end
		local damageTypeEnum = LeaderLib.Data["DamageTypeEnums"][damageTypeString]
		NRD_ItemCloneSetInt("DamageTypeOverwrite", damageTypeEnum)
	end

	NRD_ItemCloneSetString("GenerationStatsId", stat)
	NRD_ItemCloneSetString("StatsEntryName", stat)
	NRD_ItemCloneSetString("ItemType", rarity)
	NRD_ItemCloneSetString("GenerationItemType", rarity)
	NRD_ItemCloneSetInt("HasGeneratedStats", 0)
	NRD_ItemCloneSetInt("GenerationLevel", level)
	NRD_ItemCloneSetInt("StatsLevel", level)
	NRD_ItemCloneSetInt("IsIdentified", 1)
	--NRD_ItemCloneSetInt("GMFolding", 0)
	AddRandomBoosts(item,stat,statType,level)
	SetRandomShadowName(item)
	local cloned = NRD_ItemClone()
	ItemRemove(item)
	--ItemLevelUpTo(cloned,level)
	return cloned
end

function LLENEMY_Ext_ShadowCorruptItem(item)
	local stat = NRD_ItemGetStatsId(item)
	local statType = NRD_StatGetType(stat)
	if BOOSTS[statType] ~= nil then
		local cloned = GetClone(item, stat, statType)
		local container = NRD_ItemGetParent(item)
		if container ~= nil then
			ItemToInventory(cloned, container, 1, 0, 0)
		end
		ItemRemove(item)
		return cloned
		--NRD_ItemSetIdentified(cloned, 1)
	end
	return item
end

local function LLENEMY_ShadowCorruptItemFunc(item)
	LLENEMY_Ext_ShadowCorruptItem(item)
end
Ext.NewCall(LLENEMY_ShadowCorruptItemFunc, "LLENEMY_ShadowCorruptItem", "(ITEMGUID)_Item");

function LLENEMY_ItemIsRare(item, itemType)
	if itemType ~= "Common" and itemType ~= "" then
		return true
	elseif ItemGetGoldValue(item) >= 250 then
		return true
	end
end

local function LLENEMY_TryScatterInventory(uuid)
	local x,y,z = GetPosition(uuid)
	local character = Ext.GetCharacter(uuid)
	if character ~= nil then
		local inventory = character:GetInventoryItems()
		if inventory ~= nil and #inventory > 0 then
			for k,v in pairs(inventory) do
				if ObjectExists(v) == 1 then
					--LLENEMY_Ext_Debug_PrintItemProperties(v)
					--LLENEMY_Ext_Debug_PrintFlags(v)
					--local equipped = LeaderLib_Ext_ItemIsEquipped(char,v)
					local item = Ext.GetItem(v)
					local stat = item.StatsId
					local equipped = item.Slot <= 13
					-- Stats that start with an underscore aren't meant for players
					if equipped ~= true and string.sub(stat, 1, 1) ~= "_" then
						ItemScatterAt(v, x,y,z)
						ItemClearOwner(v)
						
						LeaderLib.Print("[LLENEMY_ItemMechanics.lua:ScatterInventory] Scattering item ("..tostring(stat)..")["..v.."]")
						if not string.find(stat, "Gold") and (LLENEMY_ItemIsRare(v, item.ItemType)) then
							PlayEffect(v, "LLENEMY_FX_TreasureGoblins_Loot_Dropped_01");
						end
					else
						LeaderLib.Print("[LLENEMY_ItemMechanics.lua:ScatterInventory] Item ("..tostring(stat)..")["..v.."] is equipped ("..tostring(equipped)..") or an NPC item. Skipping.")
					end
				end
			end
		else
			error("Inventory from ("..uuid..") is empty or null!")
		end
	else
		error("Character from ("..uuid..") is null!")
	end
end

function LLENEMY_Ext_ScatterInventory(char)
	local success = pcall(LLENEMY_TryScatterInventory, char)
	if not success then
		LeaderLib.Print("[LLENEMY_ItemMechanics.lua:ScatterInventory] Failed to scatter items for ("..char..").")
	end
end

local function LLENEMY_Ext_DestroyEmptyContainer(uuid)
	local item = Ext.GetItem(uuid)
	local inventory = item:GetInventoryItems()
	if inventory == nil or #inventory <= 0 then
		ItemDestroy(uuid)
	end
end