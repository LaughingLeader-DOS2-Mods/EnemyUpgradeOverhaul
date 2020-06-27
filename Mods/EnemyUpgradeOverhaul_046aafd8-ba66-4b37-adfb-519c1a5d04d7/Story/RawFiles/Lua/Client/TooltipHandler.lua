---@class TranslatedString
local TranslatedString = LeaderLib.Classes["TranslatedString"]

local maxSummonsText = TranslatedString:Create("hd248998fge250g4a7bg8dd3gc88f19fbe5f6", "Maximum Summons")
local ShadowItemFallbackDescription = "A <i>strange</i> item retrieved from a <font color='#9B30FF' face='Copperplate Gothic Bold'>Shadow Orb</font>.<br><font color='#BDA0CB'>Cold to the touch, when this item is held, your grip on reality may begin to slip.</font>"
local ShadowItemDescription = TranslatedString:Create("h179efab0g7e6cg441ag8083gb11964394dc4", ShadowItemFallbackDescription)
local ShadowItemNameAffix = TranslatedString:Create("h1d44d1a4g804bg43fbg80dfgd3e3d07a897d", "<font color='#A020F0'>[1] of Shadows</font>")

---@param item EsvItem
---@param tooltip TooltipData
local function OnItemTooltip(item, tooltip)
	if item ~= nil then
		if item:HasTag("LLENEMY_ShadowItem") then
			local maxSummons = item.Stats.MaxSummons
			for i,stat in pairs(item.Stats.DynamicStats) do
				if stat ~= nil then
					maxSummons = maxSummons + stat.MaxSummons
				end
			end
			if maxSummons > 0 then
				print(maxSummons)
				local element = {
					Type = "AbilityBoost",
					Label = maxSummonsText.Value,
					Value = maxSummons,
				}
				tooltip:AppendElement(element)
			end
			local element = tooltip:GetElement("ItemDescription")
			if element ~= nil then
				if not LeaderLib.StringHelpers.IsNullOrEmpty(element.Label) then
					element.Label = element.Label .. "<br>" .. ShadowItemDescription.Value
				else
					element.Label = ShadowItemDescription.Value
				end
			end
			if item.ItemType == "Armor" then
				element = tooltip:GetElement("ItemName")
				if element ~= nil then
					element.Label = ShadowItemNameAffix.Value:gsub("%[1%]", element.Label:gsub("<font.->", ""):gsub("</font>.*", ""))
				end
			end
		end
	end
end

local function Init()
	Game.Tooltip.RegisterListener("Item", nil, OnItemTooltip)
end
return {
	Init = Init
}