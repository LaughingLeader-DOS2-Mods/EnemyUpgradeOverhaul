---A wrapper around a table of boosts, to be used with NRD_ItemSetPermanentBoost, or through applied tags (TagBoost).
---@class ItemBoost
local ItemBoost = {
	StatType = "",
	---@type ItemSlot
	SlotType = "",
	WeaponType = "",
	--- Weapon types to ignore for this boost
	---@type table<string,bool>
	BlockWeaponTypes = {},
	TwoHanded = nil,
	---@type StatBoost|TagBoost[]
	Boosts = {},
	MinLevel = -1,
	MaxLevel = -1,
	Chance = 100,
	Limit = -1,
	Applied = 0,
	---@type table<string,boolean> Optional set of object categories to limit this group to
	ObjectCategories = nil,
	All = true, -- Apply all boosts?,
	Type = "ItemBoost"
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
		if vars.BlockWeaponTypes ~= nil then boost.BlockWeaponTypes = vars.BlockWeaponTypes end
		if vars.Limit ~= nil then boost.Limit = vars.Limit end
		if vars.All ~= nil then boost.All = vars.All end
		if vars.ObjectCategories ~= nil then 
			if #vars.ObjectCategories > 0 then -- Array type
				boost.ObjectCategories = {}
				for i,v in pairs(vars.ObjectCategories) do
					boost.ObjectCategories[v] = true
				end
			elseif next(vars.ObjectCategories) ~= nil then -- Key/Value type
				boost.ObjectCategories = vars.ObjectCategories
			end
		end
	end
end

---@param statBoosts StatBoost|TagBoost[]
---@param vars table
---@return ItemBoost
function ItemBoost:Create(boosts, vars)
    local this =
    {
		Boosts = boosts,
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
---@param itemBoostObject ItemBoost
---@param boost StatBoost|TagBoost
local function ApplyBoost(item,mod,itemBoostObject,boost)
	if boost.Type == "StatBoost" then
		if boost.Stat == "Skills" then
			local currentValue = NRD_ItemGetPermanentBoostString(item, boost.Stat)
			local nextValue = ""
			if currentValue == nil or currentValue == "" then
				nextValue = boost.Min
			else
				nextValue = currentValue .. ";" .. boost.Min
			end
			NRD_ItemSetPermanentBoostString(item, boost.Stat, nextValue)
			LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding boost ["..boost.Stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(nextValue)..")")
		elseif boost.Stat == "ItemColor" then
			local currentValue = NRD_ItemGetPermanentBoostString(item, boost.Stat)
			NRD_ItemSetPermanentBoostString(item, boost.Stat, boost.Min)
			LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding boost ["..boost.Stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(boost.Min)..")")
		else
			local currentValue = NRD_ItemGetPermanentBoostInt(item, boost.Stat)
			if currentValue == nil then currentValue = 0 end
			local valMod = Ext.Random(math.floor(boost.Min), math.max(boost.Max)) * mod
			if boost.Stat == "WeaponRange" then
				valMod = (Ext.Random(math.floor(boost.Min * 100), math.ceil(boost.Max * 100)) * mod) / 100
			end
			
			local nextValue = currentValue + valMod
			NRD_ItemSetPermanentBoostInt(item, boost.Stat, nextValue)
			LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding boost ["..boost.Stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(nextValue)..")")
		end
		itemBoostObject.Applied = itemBoostObject.Applied + 1
	elseif boost.Type == "TagBoost" then
		LeaderLib.PrintDebug("[LLENEMY_ItemCorruptionDeltamods.lua:Boost:Apply] Adding TagBoost ["..boost.Tag.."] to item ["..item.."].")
		SetTag(item, boost.Tag)
		if boost.OnTagAdded ~= nil then
			local status,err = xpcall(boost.OnTagAdded, debug.traceback, item, boost.Tag)
			if not status then
				PrintError("[EnemyUpgradeOverhaul] Error calling OnTagAdded callback:")
				PrintError(err)
			end
		end
		itemBoostObject.Applied = itemBoostObject.Applied + 1
	elseif boost.Type == "ItemBoost" then
		boost:Apply(item, mod)
		itemBoostObject.Applied = itemBoostObject.Applied + boost.Applied
	end
end

---Applies stat boosts to an item.
---@param item string
---@param mod number A modifier to apply to the number, i.e. -1 to make it a negative boost.
---@return ItemBoost
function ItemBoost:Apply(item, mod)
	if mod == nil or mod == 0 then mod = 1 end
	if self.Boosts ~= nil and #self.Boosts > 0 then
		if self.All == true then
			for i,v in pairs(self.Boosts) do
				ApplyBoost(item, mod, self, v)
			end
		else
			local boost = nil
			if #self.Boosts > 1 then
				boost = Common.GetRandomTableEntry(self.Boosts)
			else
				boost = self.Boosts[1]
			end
			if boost ~= nil then
				ApplyBoost(item, mod, self, boost)
			end
		end
	else
		Ext.PrintError("[LLENEMY_ItemCorruptionBoosts.lua:ItemBoost:Apply] nil Boosts?")
		Ext.PrintError(LeaderLib.Common.Dump(self))
	end
end

---@type ItemBoost
Classes.ItemBoost = ItemBoost