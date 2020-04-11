

---@class TranslatedString
local TranslatedString = LeaderLib.Classes["TranslatedString"]

local function sortupgrades(a,b)
	return a:upper() < b:upper()
end

local function LLENEMY_OnGetClientInfo(channel, data)
	EnemyUpgradeOverhaul["UpgradeInfo"] = Ext.JsonParse(data)
	if Ext.IsDeveloperMode() then
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Received upgrade info:")
		Ext.Print("======")
		Ext.Print(data)
		Ext.Print("======")
	end
end

Ext.RegisterNetListener("LLENEMY_UpgradeInfo", LLENEMY_OnGetClientInfo)

local upgradeInfoEntryColorText = TranslatedString:Create("ha4587526ge140g42f9g9a98gc92b537d4209", "<img src='Icon_BulletPoint'><font color='[2]' size='18'>[1]</font>")
local upgradeInfoEntryColorlessText = TranslatedString:Create("h869a7616gfbb7g4cc2ga233g7c22612af67b", "<img src='Icon_BulletPoint'><font size='18'>[1]</font>")

local function StatDescription_UpgradeInfo(character, param, statusSource)
	local uuid = character.MyGuid
	if Ext.Version() >= 43 and character.NetID ~= nil then
		uuid = character.NetID
	end
	if uuid ~= nil then
		--Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Getting upgrade info for (" .. uuid .. ")")
		local data = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
		if data ~= nil and data.upgrades ~= nil then
			local upgrades = data.upgrades
			local upgradeKeys = {}
			for k in pairs(upgrades) do
				if LeaderLib.Common.TableHasEntry(upgradeKeys, k) ~= true then
					table.insert(upgradeKeys, k)
				end
			end
			table.sort(upgradeKeys, sortupgrades)
			local count = #upgradeKeys
			--LeaderLib.Print("Upgrades (".. LeaderLib.Common.Dump(upgrades)..")")
			--LeaderLib.Print("Upgrade Keys (".. LeaderLib.Common.Dump(upgradeKeys)..")")
			local output = "<br><img src='Icon_Line' width='350%'><br>"
			local i = 0
			for _,status in ipairs(upgradeKeys) do
				local statusCount = upgrades[status]
				local infoText = LLENEMY_Ext_UpgradeInfo_GetText(status)
				if infoText ~= nil then
					local countText = ""
					if statusCount ~= nil and statusCount > 1 then
						countText = "x"..tostring(statusCount)
					end
					local color = infoText.Color
					---@type TranslatedString
					local translatedString = infoText.Name
					if translatedString ~= nil then
						if color ~= nil and color ~= "" then
							local text = string.gsub(upgradeInfoEntryColorText.Value, "%[1%]", translatedString.Value .. countText):gsub("%[2%]", color)
							output = output..text
						else
							output = output..string.gsub(upgradeInfoEntryColorlessText.Value, "%[1%]", translatedString.Value .. countText)
						end
						if i < count - 1 then
							output = output.."<br>"
						end
					end
				end
				i = i + 1
			end
			--LeaderLib.Print("Upgrade info (".. tostring(uuid)..") = ("..output..")")
			return output
		end
	end
	return ""
end
EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_UpgradeInfo"] = StatDescription_UpgradeInfo

-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Easy", 1, 10);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Medium", 11, 16);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Hard", 17, 25);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Insane", 26, 99);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Impossible", 100, 999);

local dropText = TranslatedString:Create("h623a7ed0gaaacg4c3egacdfg56f3c23a1dec", "<font color='#00FFAA' size='16'>Will drop [1] on death.</font>")
local shadowDropText = TranslatedString:Create("h662390f7gfd9eg4a56g95e5g658283cc548a", "<font color='#9B30FF' size='16'>Grants Treasure of the Shadow Realm ([1]) on death.</font>")

local cpNames = {
	{Min = 1, Max = 10, Text = TranslatedString:Create("h5addfbc4gcac7g4935g8effg8096574b8913", "<font color='#FFFFFF' size='12'>Regular Bonus Loot</font>")},
	{Min = 11, Max = 16, Text = TranslatedString:Create("h8a442345g8c3ag4161g8f45gd93745f99d3e", "<font color='#4197E2' size='14'>Good Loot</font>")},
	{Min = 17, Max = 31, Text = TranslatedString:Create("hf03d120ag2329g476dg94dcg7df0d27c3e1e", "<font color='#F7BA14' size='16'>Great Loot</font>")},
	{Min = 32, Max = 99, Text = TranslatedString:Create("h8886e1f1gb725g4e9fg8f5bg4ab1f7262f48", "<font color='#B823CB' size='18'>Insane Loot</font>")},
	{Min = 100, Max = 999, Text = TranslatedString:Create("h99aba0bag7acbg4deagb9f3g0c52b807ce09", "<font color='#FF00CC' size='18'>Impossibly Amazing Loot</font>")},
}

local function StatDescription_ChallengePoints(character, param, statusSource)
	local uuid = character.MyGuid
	if uuid ~= nil then
		local data = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
		if data ~= nil then
			local output = ""
			if data.cp ~= nil then
				local cp = math.tointeger(data.cp)
				if cp ~= nil and cp > 0 then
					output = "<br><img src='Icon_Line' width='350%'><br>"
					for k,tbl in pairs(cpNames) do
						if cp >= tbl.Min and cp <= tbl.Max then
							if data.isDuplicant ~= true then
								output = output .. string.gsub(dropText.Value, "%[1%]", tbl.Text.Value)
							else
								output = output .. string.gsub(shadowDropText.Value, "%[1%]", tbl.Text.Value)
							end
						end
					end
				end
			end
			-- if data.isDuplicant == true then
			-- 	output = output .. "<br><font color='#65C900' size='14'>Grants no experience, but drops guaranteed loot.</font>"
			-- end
			if Ext.IsDeveloperMode() then
				Ext.Print("CP Tooltip(".. tostring(uuid)..") = ("..output..")")
			end
			return output
		else
			if Ext.IsDeveloperMode() then
				Ext.Print("Character (".. tostring(uuid)..") has no stored CP on this client!")
			end
		end
	end
	return ""
end
EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_ChallengePoints"] = StatDescription_ChallengePoints

local counterParamText = TranslatedString:Create("h662390f7gfd9eg4a56g95e5g658283cc548a", "<font color='#D416FF'>[1]%</font>")

local function StatDescription_Counter(character, param, statusSource)
	--local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	--Ext.Print("Char: " .. tostring(character) .. " | " .. LeaderLib.Common.Dump(character))
	local initiative = character.Initiative
	--local percent = (initiative - COUNTER_MIN) / (COUNTER_MAX - COUNTER_MIN)
	local chance = (math.log(1 + initiative) / math.log(1 + EnemyUpgradeOverhaul.ExtraData.LLENEMY_Counter_MaxChance))
	--Ext.Print("Chance: " .. tostring(chance))
	--local chance = (math.log(initiative/COUNTER_MIN) / math.log(COUNTER_MAX/COUNTER_MIN)) * COUNTER_MAX
	return string.gsub(counterParamText.Value, "%[1%]", tostring(math.floor(chance * EnemyUpgradeOverhaul.ExtraData.LLENEMY_Counter_MaxChance)))
end

EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_Talent_CounterChance"] = StatDescription_Counter

local function LLENEMY_StatusGetDescriptionParam(status, statusSource, character, param)
	Ext.Print("[LLENEMY_StatusGetDescriptionParam] status("..tostring(status.Name)..") statusSource("..tostring(statusSource)..")["..tostring(statusSource.MyGuid).."] character("..tostring(character)..")["..tostring(character.MyGuid).."] param("..tostring(param)..")")
	--local params = LeaderLib.Common.FlattenTable{...}
	--Ext.Print("[LLENEMY_StatusGetDescriptionParam] Params:\n" .. tostring(LeaderLib.Common.Dump(params)))
	local func = EnemyUpgradeOverhaul.StatusDescriptionParams[param]
	if func ~= nil then
		--Ext.Print("[LLENEMY_StatusGetDescriptionParam] Calling func for param " .. param)
		local b,result = pcall(func, character, param, statusSource)
		if b and result ~= nil then
			return result
		end
	end
	return ""
end
Ext.RegisterListener("StatusGetDescriptionParam", LLENEMY_StatusGetDescriptionParam)
Ext.Print("[LLENEMY_DescriptionParams.lua] Registered listener LLENEMY_StatusGetDescriptionParam.")

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)
