---@class TranslatedString
local TranslatedString = LeaderLib.Classes["TranslatedString"]

local maxSummonsText = TranslatedString:Create("hd248998fge250g4a7bg8dd3gc88f19fbe5f6", "Maximum Summons")
local ShadowItemFallbackDescription = "A <i>strange</i> item retrieved from a <font color='#9B30FF' face='Copperplate Gothic Bold'>Shadow Orb</font>.<br><font color='#BDA0CB'>Cold to the touch, when this item is held, your grip on reality may begin to slip.</font>"
local ShadowItemDescription = TranslatedString:Create("h179efab0g7e6cg441ag8083gb11964394dc4", ShadowItemFallbackDescription)
local ShadowItemNameColor = TranslatedString:Create("h0301fb1cg95a6g47e5gade7g8ccfc0ffef2f", "<font color='[1]'>[2]</font>")
local ShadowItemNameAffix = TranslatedString:Create("h1d44d1a4g804bg43fbg80dfgd3e3d07a897d", "<font color='#A020F0'>[1] of Shadows</font>")
local ShadowItemRarity = TranslatedString:Create("habff2fe9g031cg4c7cg85feg28a1fa25fb14", "<font color='[1]'>Shadow Treasure</font>")
local ShadowItemRarityDescription = TranslatedString:Create("h6d3ad5e8g6bf2g4c8dgb1b8gef0e3ead4982", "<font color='#33FF88' size='20'>Appraisers say this item used to be [1].</font>")

local rarityColor = {
	Common = "#AEA8FF",
	Uncommon = "#877FFF",
	Rare = "#6D50FF",
	Epic = "#8A2BE2",
	Legendary = "#7F00FF",
	Divine = "#AA00FF",
	Unique = "#BF5FFF"
}

local originalRarityColor = {
	Common = "#FFFFFF",
	Uncommon = "#00A900",
	Rare = "#33CCFF",
	Epic = "#A346E9",
	Legendary = "#D1007C",
	Divine = "#EBC808",
	Unique = "#C7A758"
}

local rarityName = {
	Common = TranslatedString:Create("h5c0f3da4g83a2g4f3fg9944gc80920bcb4df", "Common"),
	Uncommon = TranslatedString:Create("h7682e16bg7c69g4a72g8f1fg1b32519665f3", "Uncommon"),
	Rare = TranslatedString:Create("heb7ba0d5g7f4cg49e9g9ce2g86cf5e5bd277", "Rare"),
	Epic = TranslatedString:Create("hd75b2771g8abag49b5g9b8egb608d51b9ddf", "Epic"),
	Legendary = TranslatedString:Create("h97227897g1345g4046gbb62g842dcc292db1", "Legendary"),
	Divine = TranslatedString:Create("h09d00ab3g7edbg4569ga4d7gf37b9b7b04cb", "Divine"),
	Unique = TranslatedString:Create("h04685fd1g024ag4641gaed6g0ffb2d0ff103", "Unique"),
}

---@param item EsvItem
---@param tooltip TooltipData
local function OnItemTooltip(item, tooltip)
	--print(item.Stats.ItemTypeReal, item:HasTag("LLENEMY_ShadowItem"), Ext.JsonStringify(tooltip.Data))
	--print(item.StatsId, item.RootTemplate, item.MyGuid, item:HasTag("LLENEMY_ShadowItem"))
	--Ext.PostMessageToServer("LLENEMY_Debug_PrintComboCategory", item.MyGuid)
	--print(string.format("%s ComboCategory:\n%s", item.Stats.Name, Ext.JsonStringify(item.Stats.ComboCategory)))
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
				local element = {
					Type = "AbilityBoost",
					Label = maxSummonsText.Value,
					Value = maxSummons,
				}
				tooltip:AppendElement(element)
			end
			local rarity = item.Stats.ItemTypeReal
			if rarity == nil then
				rarity = "Common"
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
					element.Label = element.Label .. "<br><font size='16'>" .. ShadowItemDescription.Value .. "</font>"
				else
					element.Label = "<font size='16'>" .. ShadowItemDescription.Value .. "</font>"
				end
				local rarityName = string.format("<font color='%s'>%s</font>", originalRarityColor[rarity], rarityName[rarity].Value)
				element.Label = element.Label .. "<br>" .. ShadowItemRarityDescription:ReplacePlaceholders(rarityName)
			end
			element = tooltip:GetElement("ItemName")
			if element ~= nil then
				-- Shadow Treasure has custom name colors, so we remove the default rarity color here.
				element.Label = element.Label:gsub("<font.->", "<font color='"..color.."'>")
			end
		end
	end
end

local upgradeInfoHelpers = Ext.Require("Client/UpgradeInfoTooltip.lua")

---@param character EsvCharacter
---@param status EsvStatus
---@param tooltip TooltipData
local function OnUpgradeInfoTooltip(character, status, tooltip)
	local element = tooltip:GetElement("StatusDescription")
	if element ~= nil then
		local upgradeInfoText = upgradeInfoHelpers.GetUpgradeInfoText(character)
		if not character:HasTag("LLENEMY_RewardsDisabled") then
			local challengePointsText = upgradeInfoHelpers.GetChallengePointsText(character)
			element.Label = string.format("%s<br>%s<br>%s", element.Label, upgradeInfoText, challengePointsText)
		else
			element.Label = string.format("%s<br>%s", element.Label, upgradeInfoText)
		end
	end
end

local function FormatTagElements(tooltip_mc, group, ...)
	group.iconId = 16
	--group.setupHeader()
	for i=0,#group.list.content_array,1 do
		local element = group.list.content_array[i]
		if element ~= nil then
			local b,result = xpcall(function()
				-- local icon = element.getChildAt(3) or element.getChildByName("tt_groupIcon")
				-- if icon ~= nil then
				-- 	icon.gotoAndStop(17)
				-- else
				-- 	element.removeChildAt(3)
				-- end
				element.removeChildAt(3) -- Removes the tag icon

				element.label_txt.x = 0
				element.value_txt.x = 0
				element.warning_txt.x = 0

				local tag = element.label_txt.htmlText
				local tagEntry = ItemCorruption.TagBoosts[tag]

				if tagEntry ~= nil then
					local tagName,nameHandle = Ext.GetTranslatedStringFromKey(tag)
					local tagDesc,descHandle = Ext.GetTranslatedStringFromKey(tag.."_Description")
					tagDesc = GameHelpers.Tooltip.ReplacePlaceholders(tagDesc)
					element.label_txt.htmlText = tagName
					element.warning_txt.htmlText = tagDesc
					element.warning_txt.y = element.label_txt.y + element.label_txt.textHeight
				end
			end, debug.traceback)
			if not b then
				print("[EUO:FormatTagElements] Error:")
				print(result)
			end
		end
	end
	--tooltip_mc.resetBackground()
	--[[
	CASEINSENSITIVE : uint = 1
	  Specifies case-insensitive sorting for the Array class sorting methods.
	DESCENDING : uint = 2
	  Specifies descending sorting for the Array class sorting methods.
	NUMERIC : uint = 16
	  Specifies numeric (instead of character-string) sorting for the Array class sorting methods.
	RETURNINDEXEDARRAY : uint = 8
	  Specifies that a sort returns an array that consists of array indices.
	UNIQUESORT : uint = 4
	  Specifies the unique sorting requirement for the Array class sorting methods.
	]]
	--tooltip_mc.list.TOP_SPACING = 0
	--tooltip_mc.list.m_SortOnFieldName = "label_txt"
	--tooltip_mc.list.m_SortOnOptions = 1
	--print(string.format("m_SortOnFieldName(%s) m_SortOnOptions(%s)", tooltip_mc.list.m_SortOnFieldName, tooltip_mc.list.m_SortOnOptions))
	--tooltip_mc.repositionElements()
end

local function FormatTagTooltip(ui, tooltip_mc, ...)
	if #tooltip_mc.list.content_array > 0 then
		for i=0,#tooltip_mc.list.content_array,1 do
			local group = tooltip_mc.list.content_array[i]
			if group ~= nil then
				if group.groupID == 13 and group.list ~= nil then
					FormatTagElements(tooltip_mc, group, ...)
				end
			end
		end
	end
end

local function Init()
	Game.Tooltip.RegisterListener("Item", nil, OnItemTooltip)
	Game.Tooltip.RegisterListener("Status", "LLENEMY_UPGRADE_INFO", OnUpgradeInfoTooltip)
	--LeaderLib.UI.RegisterListener("OnTooltipPositioned", FormatTagTooltip)
end
return {
	Init = Init
}