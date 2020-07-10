---@class StatBoost
local StatBoost = {
	Stat = "",
	Min = 1,
	Max = 1,
	Type = "StatBoost"
}
StatBoost.__index = StatBoost

---@param stat string
---@param min integer|string Either a numerical value for a stat, or a string for boosts like Skills.
---@param max integer
---@return StatBoost
function StatBoost:Create(stat,min,max)
    local this =
    {
		Stat = stat,
		Type = "StatBoost"
	}
	if min ~= nil then
		this.Min = min
	end
	if max ~= nil then
		this.Max = max
	end
	setmetatable(this, self)
    return this
end

---@type StatBoost
Classes.StatBoost = StatBoost