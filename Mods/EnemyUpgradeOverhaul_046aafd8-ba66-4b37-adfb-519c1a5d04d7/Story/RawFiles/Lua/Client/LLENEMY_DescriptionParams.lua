local upgrade_colors = {
	["Talent: Assassin"] = "#AABB00",
	["Talent: Leech"] = "#C80030",
	["Talent: Lone Wolf"] = "#DC0015",
	["Talent: The Pawn"] = "#AABB00",
	["Talent: Quickdraw"] = "#AABB00",
	["Talent: What a Rush"] = "#47e982",
	["Talent: Torturer"] = "#960000",
	["Talent: Sadist"] = "#ff5771",
	["Talent: Haymaker"] = "#b083ff",
	["Talent: Gladiator"] = "#f59b00",
	["Talent: Indomitable"] = "#e94947",
	["Talent: Soulcatcher"] = "#73F6FF",
	["Talent: Master Thief"] = "#C9AA58",
	["Talent: Greedy Vessel"] = "#e9d047",
	["Talent: Magic Cycles"] = "#22c3ff",
	["Infernoblazer"] = "#7F00FF",
	["Elite Infernoblazer"] = "#FE6E27",
	["Cascader"] = "#188EDE",
	["Elite Cascader"] = "#FE6E27",
	["Heatsapper"] = "#CFECFF",
	["Elite Heatsapper"] = "#FE6E27",
	["Venomstriker"] = "#65C900",
	["Elite Venomstriker"] = "#FE6E27",
	["Melter"] = "#81AB00",
	["Elite Melter"] = "#FE6E27",
	["Circuitbreaker"] = "#7D71D9",
	["Elite Circuitbreaker"] = "#FE6E27",
	["Teslacoil"] = "#7F25D4",
	["Elite Teslacoil"] = "#FE6E27",
	["Bloodbender"] = "#AA3938",
	["Elite Bloodbender"] = "#FE6E27",
	["Earthcracker"] = "#C7A758",
	["Elite Earthcracker"] = "#FE6E27",
	["Firestarter"] = "#FE6E27",
	["Elite Firestarter"] = "#FE6E27",
	["Bonus Treasure"] = "#D040D0",
	["Perfect Control"] = "#FFAB00",
	["Double Dip"] = "#7F00FF",
	["Perseverance Mastery"] = "#E4CE93",
	["Bonus Skill"] = "#F1D466",
	["Bonus Skillset"] = "#B823CB",
	["Bonus Source Skill"] = "#46B195",
	["Elite Skillset"] = "#73F6FF",
	["Ferocity"] = "#DBDBDB",
	["Courage"] = "#DBDBDB",
}

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

local function StatDescription_UpgradeInfo(character, param, statusSource)
	local uuid = character.MyGuid
	if uuid ~= nil then
		--Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Getting upgrade info for (" .. uuid .. ")")
		local data = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
		if data ~= nil and data.upgrades ~= nil then
			local upgrades = LeaderLib.Common.Split(data.upgrades, ";")
			table.sort(upgrades, sortupgrades)
			local count = #upgrades
			local output = "<br><img src='Icon_Line' width='350%'><br>"
			local i = 0
			for k,v in pairs(upgrades) do
				local color = upgrade_colors[v]
				if color ~= nil then
					output = output.."<img src='Icon_BulletPoint'><font color='"..color.."' size='18'>"..v.."</font>"
				else
					output = output.."<img src='Icon_BulletPoint'><font size='18'>"..v.."</font>"
				end
				if i < count - 1 then
					output = output.."<br>"
				end
				i = i + 1
			end
			if Ext.IsDeveloperMode() then
				Ext.Print("Upgrade info (".. tostring(uuid)..") = ("..output..")")
			end
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

local cpNames = {
	{Min = 1, Max = 10, Text = "<font color='#FFFFFF' size='12'>Regular Bonus Loot</font>"},
	{Min = 11, Max = 16, Text = "<font color='#4197E2' size='14'>Good Loot</font>"},
	{Min = 17, Max = 25, Text = "<font color='#B823CB' size='16'>Great Loot</font>"},
	{Min = 26, Max = 99, Text = "<font color='#F7BA14' size='18'>Insane Loot</font>"},
	{Min = 100, Max = 999, Text = "<font color='#FF00CC' size='18'>Impossibly Amazing Loot</font>"},
}

local function StatDescription_ChallengePoints(character, param, statusSource)
	local uuid = character.MyGuid
	if uuid ~= nil then
		local data = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
		if data ~= nil and data.cp ~= nil then
			local cp = math.tointeger(data.cp)
			if cp ~= nil and cp > 0 then
				local output = "<br>" --<font face='Copperplate Gothic Light'>
				--output = output .. "<img src='Icon_BulletPoint'>"
				output = output .. "<font color='#65C900'>Will drop "
				
				for k,tbl in pairs(cpNames) do
					if cp >= tbl.Min and cp <= tbl.Max then
						output = output .. tbl.Text
					end
				end
				
				output = output .. "on death.</font>"
				
				if Ext.IsDeveloperMode() then
					Ext.Print("CP Tooltip(".. tostring(uuid)..") = ("..output..")")
				end
				return output
			end
		else
			if Ext.IsDeveloperMode() then
				Ext.Print("Character (".. tostring(uuid)..") has no stored CP on this client!")
			end
		end
	end
	return ""
end
EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_ChallengePoints"] = StatDescription_ChallengePoints

local function StatDescription_Counter(character, param, statusSource)
	--local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	--Ext.Print("Char: " .. tostring(character) .. " | " .. LeaderLib.Common.Dump(character))
	local initiative = character.Initiative
	--local percent = (initiative - COUNTER_MIN) / (COUNTER_MAX - COUNTER_MIN)
	local chance = (math.log(1 + initiative) / math.log(1 + EnemyUpgradeOverhaul.ExtraData.LLENEMY_Counter_MaxChance))
	--Ext.Print("Chance: " .. tostring(chance))
	--local chance = (math.log(initiative/COUNTER_MIN) / math.log(COUNTER_MAX/COUNTER_MIN)) * COUNTER_MAX
	return "<font color='#D416FF'>" .. tostring(math.floor(chance * EnemyUpgradeOverhaul.ExtraData.LLENEMY_Counter_MaxChance)) .. "%</font>"
end

EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_Talent_CounterChance"] = StatDescription_Counter

local function LLENEMY_StatusGetDescriptionParam(status, statusSource, character, param)
	--local params = LeaderLib.Common.FlattenTable{...}
	--Ext.Print("[LLENEMY_StatusGetDescriptionParam] Params:\n" .. tostring(LeaderLib.Common.Dump(params)))
	local func = EnemyUpgradeOverhaul.StatusDescriptionParams[param]
	if func ~= nil then
		Ext.Print("[LLENEMY_StatusGetDescriptionParam] Calling func for param " .. param)
		local b,result = pcall(func, character, param, statusSource)
		if b and result ~= nil then
			return result
		else
			return ""
		end
	end
	return nil
end
Ext.RegisterListener("StatusGetDescriptionParam", LLENEMY_StatusGetDescriptionParam)
Ext.Print("[LLENEMY_DescriptionParams.lua] Registered listener LLENEMY_StatusGetDescriptionParam.")

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)
