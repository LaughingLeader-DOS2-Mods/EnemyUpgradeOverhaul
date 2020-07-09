
---@class ItemBoostGroup
local ItemBoostGroup = {
	ID = "",
	Entries = {},
	Limit = -1,
	Applied = 0,
}
ItemBoostGroup.__index = ItemBoostGroup

---@param boost ItemBoost
---@param vars table
local function SetVars(boost, vars)
	if vars ~= nil then
		if vars.Limit ~= nil then boost.Limit = vars.Limit end
	end
end

---@param id string
---@param entries table
---@param vars table|nil
---@return ItemBoostGroup
function ItemBoostGroup:Create(id, entries, vars)
    local this =
    {
		ID = id,
		Entries = entries,
	}
	setmetatable(this, self)
	SetVars(this, vars)
    return this
end

---@type ItemBoostGroup
Classes.ItemBoostGroup = ItemBoostGroup

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
	if itemBoost.Limit > 0 and itemBoost.Applied >= itemBoost.Limit then
		return false
	end
	if itemBoost.ObjectCategories ~= nil then
		local objectCategory = Ext.StatGetAttribute(stat, "ObjectCategory")
		if objectCategory == "MageGloves" or objectCategory == "ClothGloves" then
			print("ObjectCategory check:",stat,objectCategory)
		end
		if itemBoost.ObjectCategories[objectCategory] ~= true then
			return false
		end
	end
	if statType == "Weapon" then
		local weaponType = Ext.StatGetAttribute(stat, "WeaponType")
		if itemBoost.WeaponType ~= "" then
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
		elseif itemBoost.BlockWeaponTypes ~= nil and itemBoost.BlockWeaponTypes[weaponType] == true then
			return false
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

function ItemBoostGroup:ResetApplied()
	for i,v in pairs(self.Entries) do
		v.Applied = 0
	end
end

function ItemBoostGroup:GetRandomEntries(totalEntries)
	local ranEntries = {}
	local shuffled = LeaderLib.Common.ShuffleTable(self.Entries)
	local total = 0
	while total < totalEntries do
		local entry = LeaderLib.Common.GetRandomTableEntry(shuffled)
		table.insert(ranEntries, entry)
		total = total + 1
	end
	return ranEntries
end

---@param item string
---@param stat string
---@param statType string
---@param level integer
---@param mod number
---@param noRandomization boolean
---@param limit integer|nil
---@param minAmount integer|nil
---@return ItemBoostGroup
function ItemBoostGroup:Apply(item,stat,statType,level,mod,noRandomization,limit,minAmount)
	if limit == nil then 
		if self.Limit > 0 then
			limit = self.Limit
		else
			limit = 0
		end
	end
	if minAmount == nil then minAmount = 0 end
	if limit > 0 and self.Applied >= limit then
		self.Applied = 0
		return limit
	end
	local totalApplied = 0
	if #self.Entries > 0 then
		LeaderLib.PrintDebug("Applying boosts from group: " .. tostring(self.ID) .. " | Total: " .. tostring(#self.Entries))
		if noRandomization == true then
			for i,v in pairs(self.Entries) do
				if limit > 0 and totalApplied >= limit then
					self:ResetApplied()
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
			if minAmount > 0 then
				local loopLimit = 0
				while totalApplied < minAmount and loopLimit < 999 do
					local shuffled = LeaderLib.Common.ShuffleTable(self.Entries)
					for i,v in pairs(shuffled) do
						if limit > 0 and totalApplied >= limit then
							self:ResetApplied()
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
					loopLimit = loopLimit + 1
				end
			else
				for i,v in pairs(self.Entries) do
					if limit > 0 and totalApplied >= limit then
						self:ResetApplied()
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
		end
		if totalApplied == 0 then
			local shuffled = LeaderLib.Common.ShuffleTable(self.Entries)
			for i,v in pairs(shuffled) do
				if CanAddBoost(v, stat, statType) then
					if v.MinLevel <= 0 and v.MaxLevel <= 0 or (level >= v.MinLevel and (level <= v.MaxLevel or v.MaxLevel <= 0)) then
						v:Apply(item,mod)
						totalApplied = totalApplied + 1
						self:ResetApplied()
						return totalApplied
					end
				end
			end
		end
	end
	self:ResetApplied()
	return totalApplied
end