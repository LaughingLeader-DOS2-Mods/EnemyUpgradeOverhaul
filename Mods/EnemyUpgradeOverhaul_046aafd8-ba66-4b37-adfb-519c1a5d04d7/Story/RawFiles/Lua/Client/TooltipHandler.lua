---@class TranslatedString
local TranslatedString = LeaderLib.Classes["TranslatedString"]

local maxSummonsText = TranslatedString:Create("hd248998fge250g4a7bg8dd3gc88f19fbe5f6", "Maximum Summons")
local ShadowItemFallbackDescription = "A <i>strange</i> item retrieved from a <font color='#9B30FF' face='Copperplate Gothic Bold'>Shadow Orb</font>.<br><font color='#BDA0CB'>Cold to the touch, when this item is held, your grip on reality may begin to slip.</font>"
local ShadowItemDescription = TranslatedString:Create("h179efab0g7e6cg441ag8083gb11964394dc4", ShadowItemFallbackDescription)
local ShadowItemNameColor = TranslatedString:Create("h0301fb1cg95a6g47e5gade7g8ccfc0ffef2f", "<font color='[1]'>[2]</font>")
local ShadowItemNameAffix = TranslatedString:Create("h1d44d1a4g804bg43fbg80dfgd3e3d07a897d", "<font color='#A020F0'>[1] of Shadows</font>")
local ShadowItemRarity = TranslatedString:Create("habff2fe9g031cg4c7cg85feg28a1fa25fb14", "<font color='[1]'>Shadow Treasure</font>")

local rarityColor = {
	Common = "#BDA0CB",
	Uncommon = "#BF3EFF",
	Rare = "#A020F0",
	Epic = "#8A2BE2",
	Legendary = "#7F00FF",
	Divine = "#AA00FF",
	Unique = "#BF5FFF"
}

---@param item EsvItem
---@param tooltip TooltipData
local function OnItemTooltip(item, tooltip)
	if item ~= nil then
		if item:HasTag("LLENEMY_ShadowItem") then
			--print(item.ItemType, item.Stats.ItemType, item.Stats.ItemTypeReal)
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
			local rarity = item.Stats.ItemTypeReal
			if rarity == nil then
				rarity = "Epic"
			end
			local color = rarityColor[rarity]
			local element = tooltip:GetElement("ItemRarity")
			if element ~= nil then
				if element ~= nil then
					--element.Label = ShadowItemRarity.Value:gsub("%[1%]", element.Label)
					element.Label = ShadowItemRarity.Value:gsub("%[1%]", color)
				end
			end
			element = tooltip:GetElement("ItemDescription")
			if element ~= nil then
				if not LeaderLib.StringHelpers.IsNullOrEmpty(element.Label) then
					element.Label = element.Label .. "<br><br>" .. ShadowItemDescription.Value
				else
					element.Label = ShadowItemDescription.Value
				end
			end
			element = tooltip:GetElement("ItemName")
			if element ~= nil then
				--element.Label = ShadowItemNameAffix.Value:gsub("%[1%]", element.Label:gsub("<font.->", ""):gsub("</font>.*", ""))
				--element.Label = ShadowItemNameColor.Value:gsub("%[1%]", color):gsub("%[2%]", element.Label:gsub("<font.->", ""):gsub("</font>.*", ""))
				element.Label = element.Label:gsub("<font.->", "<font color='"..color.."'>")
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