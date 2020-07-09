---@class StatBoost
local StatBoost = {
	Stat = "",
	Min = 1,
	Max = 1,
	Type = "StatBoost"
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
		Max = max,
		Type = "StatBoost"
	}
	setmetatable(this, self)
    return this
end

---@type StatBoost
Classes.StatBoost = StatBoost