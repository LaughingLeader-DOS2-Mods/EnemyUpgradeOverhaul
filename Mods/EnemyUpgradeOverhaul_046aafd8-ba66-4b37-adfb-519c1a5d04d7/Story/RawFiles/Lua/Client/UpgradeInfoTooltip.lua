---@class TranslatedString
local TranslatedString = LeaderLib.Classes["TranslatedString"]

local function sortupgrades(a,b)
	return a:upper() < b:upper()
end

local upgradeInfoEntryColorText = TranslatedString:Create("ha4587526ge140g42f9g9a98gc92b537d4209", "<img src='Icon_BulletPoint'><font color='[2]' size='18'>[1]</font>")
local upgradeInfoEntryColorlessText = TranslatedString:Create("h869a7616gfbb7g4cc2ga233g7c22612af67b", "<img src='Icon_BulletPoint'><font size='18'>[1]</font>")

---@param character EsvCharacter
local function GetUpgradeInfoText(character)
	if HighestLoremaster == nil or HighestLoremaster == 0 then
		pcall(function()
			if LeaderLib.UI.ClientCharacter ~= nil then
				local clientChar = Ext.GetCharacter(LeaderLib.UI.ClientCharacter)
				if clientChar ~= nil and clientChar.Stats.Loremaster > 0 then
					HighestLoremaster = clientChar.Stats.Loremaster
				end
			end
		end)
	end
	local upgradeKeys = {}
	for status,data in pairs(UpgradeData.Statuses) do
		if character:GetStatus(status) ~= nil then
			table.insert(upgradeKeys, status)
		end
	end
	local count = #upgradeKeys
	if count > 0 then
		table.sort(upgradeKeys, sortupgrades)
		local output = "<img src='Icon_Line' width='350%'><br>"
		local i = 0
		for _,status in ipairs(upgradeKeys) do
			local infoText = UpgradeInfo_GetText(status)
			if infoText ~= nil then
				local color = infoText.Color
				if HighestLoremaster > 0 then
					---@type TranslatedString
					local translatedString = infoText.Name
					if translatedString ~= nil then
						local nameText = translatedString.Value
						if infoText.Lore > 0 and HighestLoremaster < infoText.Lore then
							nameText = "???"
						end
						if color ~= nil and color ~= "" then
							local text = string.gsub(upgradeInfoEntryColorText.Value, "%[1%]", nameText):gsub("%[2%]", color)
							output = output..text
						else
							output = output..string.gsub(upgradeInfoEntryColorlessText.Value, "%[1%]", nameText)
						end
					end
				else
					if color ~= nil and color ~= "" then
						local text = string.gsub(upgradeInfoEntryColorText.Value, "%[1%]", "???"):gsub("%[2%]", color)
						output = output..text
					else
						output = output..string.gsub(upgradeInfoEntryColorlessText.Value, "%[1%]", "???")
					end
				end
				if i < count - 1 then
					output = output.."<br>"
				end
			end
			i = i + 1
		end
		--LeaderLib.PrintDebug("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Upgrade info for (" .. uuid .. ") is nil or empty ("..LeaderLib.Common.Dump(data)..")")
		--LeaderLib.PrintDebug("Upgrade info (".. tostring(uuid)..") = ("..output..")")
		return output
	end
	return ""
end

---@param character EsvCharacter
local function GetChallengePointsText(character)
	local output = "<img src='Icon_Line' width='350%'><br>"
	local isTagged = false
	for k,tbl in pairs(ChallengePointsText) do
		if character:HasTag(tbl.Tag) then
			if HighestLoremaster >= 2 then
				if character:GetStatus("LLENEMY_DUPLICANT") == nil then
					output = output .. string.gsub(DropText.Value, "%[1%]", tbl.Text.Value)
				else
					output = output .. string.gsub(ShadowDropText.Value, "%[1%]", tbl.Text.Value)
				end
			else
				if character:GetStatus("LLENEMY_DUPLICANT") == nil then
					output = output .. HiddenDropText.Value
				else
					output = output .. HiddenShadowDropText.Value
				end
			end
			isTagged = true
		end
	end
	--LeaderLib.PrintDebug("CP Tooltip | Name("..tostring(character.Name)..") NetID(".. tostring(character.NetID)..") character.Stats.NetID("..tostring(Ext.GetCharacter(character.NetID).Stats.NetID)..")")
	--LeaderLib.PrintDebug("Tags: " .. LeaderLib.Common.Dump(character:GetTags()))
	-- if statusSource ~= nil then
	-- 	LeaderLib.PrintDebug("CP Tooltip | Source Name("..tostring(statusSource.Name)..") NetID(".. tostring(statusSource.NetID)..") character.Stats.NetID("..tostring(Ext.GetCharacter(statusSource.NetID).Stats.NetID)..")")
	-- 	LeaderLib.PrintDebug("Tags: " .. LeaderLib.Common.Dump(statusSource:GetTags()))
	-- end
	-- if data.isDuplicant == true then
	-- 	output = output .. "<br><font color='#65C900' size='14'>Grants no experience, but drops guaranteed loot.</font>"
	-- end
	if isTagged then
		return output
	end
	return ""
end

return {
	GetUpgradeInfoText = GetUpgradeInfoText,
	GetChallengePointsText = GetChallengePointsText
}