---@class TagBoost
local TagBoost = {
	Tag = "",
	Flag = "",
	Type = "TagBoost",
	DisplayInTooltip = false,
	---@type function<string,string>
	OnTagAdded = nil
}
TagBoost.__index = TagBoost

---@param tag string
---@param flag string
---@param autoDisplayInTooltip boolean
---@param onTagAdded function|nil
---@return TagBoost
function TagBoost:Create(tag,flag,autoDisplayInTooltip,onTagAdded)
    local this =
    {
		Tag = tag,
		Flag = flag,
		DisplayInTooltip = autoDisplayInTooltip or false,
		OnTagAdded = onTagAdded or nil,
		Type = "TagBoost"
	}
	setmetatable(this, self)
    return this
end

---@type TagBoost
Classes.TagBoost = TagBoost