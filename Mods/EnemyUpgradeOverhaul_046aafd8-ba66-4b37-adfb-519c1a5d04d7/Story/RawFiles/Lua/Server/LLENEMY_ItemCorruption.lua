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
	--"#2E0854",
	--"#4B0082",
	--"#551A8B",
	--"#5E2D79",
	--"#660198",
	--"#68228B",
	--"#694489",
	--"#6B238E",
	--"#71637D",
	--"#72587F",
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
local ItemBoost = LeaderLib.Classes["ItemBoost"]
local ItemBoostGroup = LeaderLib.Classes["ItemBoostGroup"]

local ShadowItemFallbackDescription = "A <i>strange</i> item retrieved from a <font color='#9B30FF' face='Copperplate Gothic Bold'>Shadow Orb</font>.<br><font color='#BDA0CB'>Cold to the touch, when this item is held, your grip on reality may begin to slip.</font>"
local ShadowItemDescription = TranslatedString:Create("h179efab0g7e6cg441ag8083gb11964394dc4", ShadowItemFallbackDescription)

local function RollForBoost(entry)
	if entry.Chance < 100 and entry.Chance > 0 then
		local roll = Ext.Random(1,100)
		LeaderLib.Print("[LLENEMY_ItemCorruption.lua:RollForBoost] Roll for ("..entry.Boost.."): ".. tostring(roll).."/"..tostring(entry.Chance))
		if roll <= entry.Chance then
			return true
		end
	else
		return true
	end
	return false
end

local function AddRandomBoostsFromTable(item,stat,statType,level,boostTable)
	local boosts = {}
	for i,entry in pairs(boostTable) do
		--Ext.Print(tostring(i)..": "..LeaderLib.Common.Dump(entry))
		if entry["Entries"] ~= nil then
			Ext.Print("Value is an ItemBoostGroup.")
			local ranEntry = entry:GetRandomEntry()
			if ranEntry.MinLevel <= 0 and ranEntry.MaxLevel <= 0 then
				boosts[#boosts+1] = ranEntry
			elseif level >= ranEntry.MinLevel and (level <= ranEntry.MaxLevel or ranEntry.MaxLevel <= 0) then
				boosts[#boosts+1] = ranEntry
			end
		else
			Ext.Print("Value is an ItemBoost.")
			if entry.MinLevel <= 0 and entry.MaxLevel <= 0 then
				boosts[#boosts+1] = entry
			elseif level >= entry.MinLevel and (level <= entry.MaxLevel or entry.MaxLevel <= 0) then
				boosts[#boosts+1] = entry
			end
		end
	end
	LeaderLib.Print("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Boosts:\n" .. LeaderLib.Common.Dump(boosts))
	local boostCount = #boosts
	local boostAdded = false
	if boostCount == 1 then
		local entry = boosts[1]
		if entry ~= nil then
			if RollForBoost(entry) then
				NRD_ItemCloneAddBoost(entry.Type, entry.Boost)
				LeaderLib.Print("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Adding deltamod ["..entry.Type.."]".."("..entry.Boost..") to item ["..item.."]("..stat..")")
				boostAdded = true
			end
		end
	elseif boostCount > 0 then
		for i,entry in pairs(boosts) do
			if RollForBoost(entry) then
				NRD_ItemCloneAddBoost(entry.Type, entry.Boost)
				LeaderLib.Print("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Adding deltamod ["..entry.Type.."]".."("..entry.Boost..") to item ["..item.."]("..stat..")")
				boostAdded = true
			end
		end
	end
	if not boostAdded then
		local entry = LeaderLib.Common.GetRandomTableEntry(boosts)
		if entry ~= nil then
			NRD_ItemCloneAddBoost(entry.Type, entry.Boost)
			LeaderLib.Print("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Adding fallback deltamod ["..entry.Type.."]".."("..entry.Boost..") to item ["..item.."]("..stat..")")
		end
	end
	if statType == "Shield" then
		NRD_ItemCloneAddBoost("DeltaMod", "LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage")
	end
end

local function AddRandomBoosts(item,stat,statType,level)
	local boostTable = EnemyUpgradeOverhaul.CorruptionBoosts[statType]
	if boostTable ~= nil then
		AddRandomBoostsFromTable(item,stat,statType,level,boostTable)
	end
	--AddRandomBoostsFromTable(item,stat,statType,level,EnemyUpgradeOverhaul.CorruptionBoosts.All)
end

local function SetRandomShadowName(item,statType)
	if statType == "Weapon" then
		local name = LeaderLib.Common.GetRandomTableEntry(ShadowItemNames)
		local color = LeaderLib.Common.GetRandomTableEntry(nameColors)
		name = string.format("<font color='%s'>%s</font>", color, name)
		NRD_ItemCloneSetString("CustomDisplayName", name)
		if Ext.IsDeveloperMode() then
			LeaderLib.Print("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] New shadow item name is ("..name..")")
		end
		NRD_ItemCloneSetString("CustomDescription", ShadowItemDescription.Value)
	else
		-- Wrap original names in a purple color
		local handle,templateName = ItemTemplateGetDisplayString(GetTemplate(item))
		LeaderLib.Print("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] ("..item..") handle("..handle..") templateName("..templateName..")")
		local originalName = Ext.GetTranslatedString(handle, templateName)
		if originalName ~= NRD_ItemGetStatsId(item) and originalName ~= GetStatString(item) then
			-- Name isn't a stat entry name.
			local color = LeaderLib.Common.GetRandomTableEntry(nameColors)
			local name = string.format("<font color='%s'>%s</font>", color, originalName)
			NRD_ItemCloneSetString("CustomDisplayName", name)
			LeaderLib.Print("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] New shadow item name is ("..name..")")
		end
	end
end

local function GetClone(item,stat,statType)
	local baseStat,rarity,level,seed = NRD_ItemGetGenerationParams(item)
	if level == nil then
		level = NRD_ItemGetInt(item, "LevelOverride")
		if level == 0 or level == nil then
			level = CharacterGetLevel(CharacterGetHostCharacter())
		end
	end
	if rarity == nil or rarity == "Common" then
		rarity = "Uncommon"
	end
    local template = GetTemplate(item)
	local last_underscore = string.find(template, "_[^_]*$")
	local stripped_template = string.sub(template, last_underscore+1)
	NRD_ItemCloneBegin(item)
	--NRD_ItemCloneResetProgression()
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
		local damageTypeEnum = LeaderLib.Data.DamageTypeEnums[damageTypeString]
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
	SetRandomShadowName(item, statType)
	local cloned = NRD_ItemClone()
	ItemRemove(item)
	--ItemLevelUpTo(cloned,level)
	return cloned
end

local ignoredSlots = {
	Wings = true,
	Horns = true,
	Overhead = true,
}

local corruptableTypes = {
	Weapon = true,
	Shield = true,
	Armor = true,
}

local function ShadowCorruptItem(uuid, container)
	if uuid ~= nil then
		local item = Ext.GetItem(uuid)
		local stat = item.StatsId
		local statType = NRD_StatGetType(stat)
		if statType == "Weapon" or statType == "Armor" or statType == "Shield" then
			local equippedSlot = Ext.StatGetAttribute(stat, "Slot")
			LeaderLib.Print("[LLENEMY_ItemMechanics.lua:ShadowCorruptItem] stat("..tostring(stat)..") SlotNumber("..tostring(item.Slot)..") Slot("..tostring(equippedSlot)..") ItemType("..tostring(item.ItemType)..")")
			if ignoredSlots[equippedSlot] ~= true and string.sub(stat, 1, 1) ~= "_" then -- Not equipped in a hidden slot, not an NPC item
				if item.Slot > 13 then
					if EnemyUpgradeOverhaul.CorruptionBoosts[statType] ~= nil then
						local cloned = GetClone(uuid, stat, statType)
						if container == nil and ItemIsInInventory(uuid) then
							container = GetInventoryOwner(uuid)
							if container == nil then
								container = NRD_ItemGetParent(uuid)
							end
						end
						if container ~= nil then
							ItemToInventory(cloned, container, 1, 0, 0)
						else
							local x,y,z = GetPosition(uuid)
							if x == nil or y == nil or z == nil then
								x,y,z = GetPosition(CharacterGetHostCharacter())
							end
							TeleportToPosition(cloned, x,y,z, "", 0, 1)
						end
						ItemRemove(uuid)
						LeaderLib.Print("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Successfully corrupted ("..tostring(cloned)..")")
						return cloned
						--NRD_ItemSetIdentified(cloned, 1)
					else
						LeaderLib.Print("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] No boosts table for type ("..tostring(statType)..")")
					end
				end
			elseif item.Slot > 13 then -- Not equipped
				LeaderLib.Print("[LLENEMY_ItemMechanics.lua:ShadowCorruptItem] Deleting ("..uuid..") Stat("..tostring(stat)..") since it's an item that shouldn't be given to players.")
				ItemRemove(uuid)
				return nil
			end
		end
		return uuid
	else
		error("Item ("..tostring(uuid)..") is nil!")
		return nil
	end
end

function LLENEMY_Ext_ShadowCorruptItem(item)
	local container = GetInventoryOwner(item)
	local b,result = xpcall(ShadowCorruptItem, debug.traceback, item, container)
	if b then
		return result
	else
		LeaderLib.PrintError("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Error corrupting item:\n"..tostring(result))
	end
	return nil
end
Ext.NewCall(LLENEMY_Ext_ShadowCorruptItem, "LLENEMY_ShadowCorruptItem", "(ITEMGUID)_Item");

function LLENEMY_Ext_ShadowCorruptItems(uuid)
	InventoryLaunchIterator(uuid, "Iterators_LLENEMY_CorruptItem", "");
	--[[ local success = false
	local item = Ext.GetItem(uuid)
	if item ~= nil then
		local inventory = item:GetInventoryItems()
		if inventory ~= nil and #inventory > 0 then
			success = true
			for k,v in pairs(inventory) do
				LLENEMY_Ext_ShadowCorruptItem(v, uuid)
			end
		end
	end
	if not success then
		LeaderLib.Print("[LLENEMY_ItemMechanics.lua:LLENEMY_Ext_ShadowCorruptItems] Failed to get inventory for item ("..uuid..")")
		InventoryLaunchIterator(uuid, "Iterators_LLENEMY_CorruptItem", "");
	end ]]
end