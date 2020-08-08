---@class TagBoost
local TagBoost = {
	Tag = "",
	Flag = "",
	Type = "TagBoost",
	DisplayInTooltip = false,
	---@type function<string,string>
	OnTagAdded = nil,
	HasToggleScript = false,
	---@type string
	TitleColor = nil
}
TagBoost.__index = TagBoost

---@param tag string
---@param flag string
---@param params table
---@param onTagAdded function
---@return TagBoost
function TagBoost:Create(tag,flag,params,onTagAdded)
    local this =
    {
		Tag = tag,
		Flag = flag,
		OnTagAdded = onTagAdded or nil,
		DisplayInTooltip = false,
		HasToggleScript = false,
	}
	if params ~= nil then
		for prop,value in pairs(params) do
			this[prop] = value
		end
	end
	setmetatable(this, self)
    return this
end

---@type TagBoost
Classes.TagBoost = TagBoost