

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
	local upgradeKeys = {}
	for status,data in pairs(EnemyUpgradeOverhaul.UpgradeData.Statuses) do
		if character.Character:HasStatus(status) == 1 then
			table.insert(upgradeKeys, status)
		end
	end
	local count = #upgradeKeys
	if count > 0 then
		table.sort(upgradeKeys, sortupgrades)
		local output = "<br><img src='Icon_Line' width='350%'><br>"
		local i = 0
		for _,status in ipairs(upgradeKeys) do
			local infoText = LLENEMY_Ext_UpgradeInfo_GetText(status)
			if infoText ~= nil then
				local color = infoText.Color
				---@type TranslatedString
				local translatedString = infoText.Name
				if translatedString ~= nil then
					if color ~= nil and color ~= "" then
						local text = string.gsub(upgradeInfoEntryColorText.Value, "%[1%]", translatedString.Value):gsub("%[2%]", color)
						output = output..text
					else
						output = output..string.gsub(upgradeInfoEntryColorlessText.Value, "%[1%]", translatedString.Value)
					end
					if i < count - 1 then
						output = output.."<br>"
					end
				end
			end
			i = i + 1
		end
		--LeaderLib.Print("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Upgrade info for (" .. uuid .. ") is nil or empty ("..LeaderLib.Common.Dump(data)..")")
		--LeaderLib.Print("Upgrade info (".. tostring(uuid)..") = ("..output..")")
		return output
	end
	return ""
end
EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_UpgradeInfo"] = StatDescription_UpgradeInfo

-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Easy", 1, 10);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Medium", 11, 16);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Hard", 17, 25);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Insane", 26, 99);
-- LLENEMY_Rewards_AddTreasurePool("LLENEMY.Rewards.Impossible", 100, 999);

local function StatDescription_ChallengePoints(character, param, statusSource)
	local output = "<br><img src='Icon_Line' width='350%'><br>"
	local isTagged = false
	for k,tbl in pairs(EnemyUpgradeOverhaul.ChallengePointsText) do
		if character.Character:HasTag(tbl.Tag) then
			if character.Character:HasTag("LLENEMY_Duplicant") ~= 1 then
				output = output .. string.gsub(EnemyUpgradeOverhaul.DropText.Value, "%[1%]", tbl.Text.Value)
			else
				output = output .. string.gsub(EnemyUpgradeOverhaul.ShadowDropText.Value, "%[1%]", tbl.Text.Value)
			end
			isTagged = true
		end
	end
	if Ext.IsDeveloperMode() then
		Ext.Print("CP Tooltip(".. tostring(character.NetID)..") = ("..output..")")
	end
	-- if data.isDuplicant == true then
	-- 	output = output .. "<br><font color='#65C900' size='14'>Grants no experience, but drops guaranteed loot.</font>"
	-- end
	if isTagged then
		return output
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
	LeaderLib.Print("[LLENEMY_StatusGetDescriptionParam] status("..tostring(status.Name)..") statusSource("..tostring(statusSource)..")["..tostring(statusSource.MyGuid).."] character("..tostring(character)..")["..tostring(character.MyGuid).."] param("..tostring(param)..")")

	if Ext.IsDeveloperMode() and Ext.Version() < 43 then
		if character ~= nil then
			LeaderLib_Ext_Debug_TraceCharacter(character)
		end
		if statusSource ~= nil then
			LeaderLib_Ext_Debug_TraceCharacter(statusSource)
		end
	end
	local func = EnemyUpgradeOverhaul.StatusDescriptionParams[param]
	if func ~= nil then
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
