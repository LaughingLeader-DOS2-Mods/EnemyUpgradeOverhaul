---@class StatBoost
local StatBoost = {
	Stat = "",
	Min = 1,
	Max = 1
}
StatBoost.__index = StatBoost

---@param stat string
---@param min integer
---@param max integer
---@return StatBoost
function StatBoost:Create(stat,min,max)
    local this =
    {
		Stat = stat,
		Min = min,
		Max = max
	}
	setmetatable(this, self)
    return this
end

---A boost to be used with NRD_ItemSetPermanentBoost.
---@class ItemBoost
local ItemBoost = {
	StatType = "",
	SlotType = "",
	WeaponType = "",
	TwoHanded = nil,
	Boosts = {},
	MinLevel = -1,
	MaxLevel = -1,
	Chance = 100
}
ItemBoost.__index = ItemBoost

---@param boost ItemBoost
---@param vars table
local function SetVars(boost, vars)
	if vars ~= nil then
		if vars.StatType ~= nil then boost.StatType = vars.StatType end
		if vars.MinLevel ~= nil then boost.MinLevel = vars.MinLevel end
		if vars.MaxLevel ~= nil then boost.MaxLevel = vars.MaxLevel end
		if vars.Chance ~= nil then boost.Chance = vars.Chance end
		if vars.SlotType ~= nil then boost.SlotType = vars.SlotType end
		if vars.TwoHanded ~= nil then boost.TwoHanded = vars.TwoHanded end
		if vars.WeaponType ~= nil then boost.WeaponType = vars.WeaponType end
	end
end

---@param statBoosts table
---@param vars table
---@return ItemBoost
function ItemBoost:Create(statBoosts, vars)
    local this =
    {
		Boosts = statBoosts,
		MinLevel = -1,
		MaxLevel = -1,
		Chance = 100
	}
	setmetatable(this, self)
	SetVars(this, vars)
    return this
end

---Applies stat boosts to an item.
---@param item string
---@param mod number A modifier to apply to the number, i.e. -1 to make it a negative boost.
---@return ItemBoost
function ItemBoost:Apply(item,mod)
	if mod == nil or mod == 0 then mod = 1 end
	if self.Boosts ~= nil and #self.Boosts > 0 then
		for i,v in pairs(self.Boosts) do
			--Ext.Print(LeaderLib.Common.Dump(v))
			if v.Stat == "Skills" then
				local currentValue = NRD_ItemGetPermanentBoostString(item, v.Stat)
				local nextValue = ""
				if currentValue == nil or currentValue == "" then
					nextValue = v.Min
				else
					nextValue = currentValue .. ";" .. v.Min
				end
				NRD_ItemSetPermanentBoostString(item, v.Stat, nextValue)
				LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding boost ["..v.Stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(nextValue)..")")
			elseif v.Stat == "ItemColor" then
				local currentValue = NRD_ItemGetPermanentBoostString(item, v.Stat)
				NRD_ItemSetPermanentBoostString(item, v.Stat, v.Min)
				LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding boost ["..v.Stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(v.Min)..")")
			else
				local currentValue = NRD_ItemGetPermanentBoostInt(item, v.Stat)
				if currentValue == nil then currentValue = 0 end
				local valMod = Ext.Random(v.Min, v.Max) * mod
				local nextValue = currentValue + valMod
				NRD_ItemSetPermanentBoostInt(item, v.Stat, nextValue)
				LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding boost ["..v.Stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(nextValue)..")")
			end
		end
	else
		Ext.PrintError("[LLENEMY_ItemCorruptionBoosts.lua:ItemBoost:Apply] nil Boosts?")
		Ext.PrintError(LeaderLib.Common.Dump(self))
	end
end

---@class ItemBoostGroup
local ItemBoostGroup = {
	ID = "",
	Entries = {}
}
ItemBoostGroup.__index = ItemBoostGroup

---@param id string
---@param entries table
---@return ItemBoostGroup
function ItemBoostGroup:Create(id, entries)
    local this =
    {
		ID = id,
		Entries = entries,
	}
	setmetatable(this, self)
    return this
end

local function PropertyMatch(itemBoostProp, prop)
	if itemBoostProp == nil or itemBoostProp == "" then
		return true
	else
		return itemBoostProp == prop
	end
end

---@param itemBoost ItemBoost
---@param stat string
---@param statType string
local function CanAddBoost(itemBoost,stat,statType)
	if statType == "Weapon" then
		if itemBoost.WeaponType ~= "" then
			local weaponType = Ext.StatGetAttribute(stat, "WeaponType")
			if weaponType == itemBoost.WeaponType then
				if itemBoost.TwoHanded ~= nil then
					local isTwoHanded = Ext.StatGetAttribute(stat, "IsTwoHanded")
					if isTwoHanded == "Yes" and itemBoost.TwoHanded == true then
						return true
					else
						return false
					end
				else
					return true
				end
			else
				return false
			end
		elseif itemBoost.TwoHanded ~= nil then
			local isTwoHanded = Ext.StatGetAttribute(stat, "IsTwoHanded")
			if isTwoHanded == "Yes" and itemBoost.TwoHanded == true then
				return true
			else
				return false
			end
		end
	end
	if PropertyMatch(itemBoost.StatType, statType) then
		if itemBoost.SlotType ~= "" then
			local slot = Ext.StatGetAttribute(stat, "Slot")
			if itemBoost.SlotType == slot or itemBoost.SlotType == "Ring" and slot == "Ring2" then
				return true
			else
				return false
			end
		end
	end
	return true
end

---@param itemBoost ItemBoost
local function RollForBoost(itemBoost)
	if itemBoost.Chance < 100 and itemBoost.Chance > 0 then
		local roll = Ext.Random(1,100)
		if roll <= itemBoost.Chance then
			return true
		end
	elseif itemBoost.Chance >= 100 then
		return true
	end
	return false
end

---@param item string
---@param stat string
---@param statType string
---@param level integer
---@param mod number
---@param noRandomization boolean
---@return ItemBoostGroup
function ItemBoostGroup:Apply(item,stat,statType,level,mod,noRandomization,limit)
	if limit == nil then limit = 0 end
	local totalApplied = 0
	if #self.Entries > 0 then
		LeaderLib.PrintDebug("Applying boosts from group: " .. tostring(self.ID) .. " | Total: " .. tostring(#self.Entries))
		if noRandomization == true then
			for i,v in pairs(self.Entries) do
				if limit > 0 and totalApplied >= limit then
					return totalApplied
				end
				if CanAddBoost(v, stat, statType) then
					if v.MinLevel <= 0 and v.MaxLevel <= 0 then
						v:Apply(item,mod)
						totalApplied = totalApplied + 1
					elseif level >= v.MinLevel and (level <= v.MaxLevel or v.MaxLevel <= 0) then
						v:Apply(item,mod)
						totalApplied = totalApplied + 1
					end
				end
			end
		else
			for i,v in pairs(self.Entries) do
				if limit > 0 and totalApplied >= limit then
					return totalApplied
				end
				if CanAddBoost(v, stat, statType) then
					if v.MinLevel <= 0 and v.MaxLevel <= 0 or (level >= v.MinLevel and (level <= v.MaxLevel or v.MaxLevel <= 0)) then
						if RollForBoost(v) then
							v:Apply(item,mod)
							totalApplied = totalApplied + 1
						end
					end
				end
			end
		end
		if totalApplied == 0 then
			local shuffled = LeaderLib.Common.ShuffleTable(self.Entries)
			for i,v in pairs(shuffled) do
				if CanAddBoost(v, stat, statType) then
					if v.MinLevel <= 0 and v.MaxLevel <= 0 or (level >= v.MinLevel and (level <= v.MaxLevel or v.MaxLevel <= 0)) then
						v:Apply(item,mod)
						totalApplied = totalApplied + 1
						return totalApplied
					end
				end
			end
		end
	else
		Ext.PrintError("[ItemBoostGroup:Apply] Empty Entries?")
		Ext.PrintError(LeaderLib.Common.Dump(self))
	end
	return totalApplied
end

local armorResistances = {
	"FireResistance",
	"AirResistance",
	"WaterResistance",
	"EarthResistance",
	"PoisonResistance",
	"PiercingResistance",
	"PhysicalResistance",
	--"ShadowResistance",
	--"CorrosiveResistance",
	--"MagicResistance",
}

CorruptionBoosts = {
	Weapon = {
		ItemBoostGroup:Create("WeaponMain", {
			ItemBoost:Create({
				StatBoost:Create("DamageFromBase",1,5),
				StatBoost:Create("CriticalChance",1,5),
			},{Chance=50}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,5),
				StatBoost:Create("DodgeBoost",1,5),
			},{Chance=50}),
		})
	},
	Shield = {
		ItemBoostGroup:Create("ShieldMain", {
			ItemBoost:Create({
				StatBoost:Create("Blocking",1,5),
				StatBoost:Create("ArmorBoost",1,5),
			},{Chance=50}),
			ItemBoost:Create({
				StatBoost:Create("MagicArmorBoost",1,5),
				StatBoost:Create("PiercingResistance",1,5),
			},{Chance=10}),
		})
	},
	Armor = {
		ItemBoostGroup:Create("ArmorMain", {
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,3),
			},{Chance=10, MinLevel=1,MaxLevel=8,SlotType="Gloves"}),
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,5),
			},{Chance=10, MinLevel=9,MaxLevel=13,SlotType="Gloves"}),
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,7),
			},{Chance=10, MinLevel=14,MaxLevel=-1,SlotType="Gloves"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,3),
			},{Chance=25, MinLevel=1,MaxLevel=8,SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,5),
			},{Chance=25, MinLevel=9,MaxLevel=13,SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,7),
			},{Chance=25, MinLevel=14,MaxLevel=-1,SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("VitalityBoost",1,3),
			},{Chance=25, MinLevel=1,MaxLevel=8,SlotType="Breast"}),
			ItemBoost:Create({
				StatBoost:Create("VitalityBoost",1,5),
			},{Chance=25, MinLevel=9,MaxLevel=13,SlotType="Breast"}),
			ItemBoost:Create({
				StatBoost:Create("VitalityBoost",1,7),
			},{Chance=25, MinLevel=14,MaxLevel=-1,SlotType="Breast"}),
			ItemBoost:Create({
				StatBoost:Create("MemoryBoost",1,1),
			},{Chance=10, SlotType="Helmet"}),
			ItemBoost:Create({
				StatBoost:Create("StartAP",1,1),
			},{Chance=2, SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("MaxAP",1,1),
			},{Chance=1, SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("SourcePointsBoost",1,1),
			},{Chance=1, SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("MovementSpeedBoost",1,5),
			},{Chance=5, SlotType="Boots"}),
			ItemBoost:Create({
				StatBoost:Create("MaxSummons",1,1),
			},{Chance=2, SlotType="Helmet"}),
			ItemBoost:Create({
				StatBoost:Create("ChanceToHitBoost",1,5),
			},{Chance=3, SlotType="Helmet"}),
			ItemBoost:Create({
				StatBoost:Create("RuneSlots",1,1),
			},{Chance=1}),
		})
	},
	---@type ItemBoostGroup
	Resistances = {}
}

local resistancesItemBoostGroup = ItemBoostGroup:Create("Resistances");
for i,v in pairs(armorResistances) do
	local a = ItemBoost:Create({
		StatBoost:Create(v,1,2),
	},{Chance=10, MinLevel=1,MaxLevel=8})
	local b = ItemBoost:Create({
		StatBoost:Create(v,2,4),
	},{Chance=10, MinLevel=9,MaxLevel=13})
	local c = ItemBoost:Create({
		StatBoost:Create(v,4,8),
	},{Chance=10, MinLevel=14,MaxLevel=-1})
	resistancesItemBoostGroup.Entries[#resistancesItemBoostGroup.Entries+1] = a
	resistancesItemBoostGroup.Entries[#resistancesItemBoostGroup.Entries+1] = b
	resistancesItemBoostGroup.Entries[#resistancesItemBoostGroup.Entries+1] = c
end

CorruptionBoosts.Resistances = resistancesItemBoostGroup

Ext.Print("CorruptionBoosts:")
Ext.Print(LeaderLib.Common.Dump(CorruptionBoosts))