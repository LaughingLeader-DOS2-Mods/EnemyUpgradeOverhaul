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
}

local function sortupgrades(a,b)
	return a:upper() < b:upper()
end

local client_test = {}
client_test[#client_test+1] = "TEST1"

local function StatusGetDescriptionParamClientDebug(status, statusSource, character, param)
	if LeaderLib.Common.TableHasEntry(client_test, status.Name) == false then
		client_test[#client_test+1] = status.Name
	end
	if status.Name == "LLENEMY_UPGRADE_INFO" then
		if param == "UpgradeInfo" then
			--table.sort(client_test, sortupgrades)
			local count = #client_test
			local output = "<br>"
			for i = 1, #client_test do
				local v = client_test[i]
				output = output.."<font size='18'>"..v.."</font>"
				if i <= count then
					output = output.."<br>"
				end
			end
			Ext.Print("Upgrade info ("..output..")")
			Ext.Print("client_test: ("..tostring(LeaderLib.Common.Dump(client_test))..")")
			return output
		end
	end
end
--Ext.RegisterListener("StatusGetDescriptionParam", StatusGetDescriptionParamClientDebug)

local function LLENEMY_OnSendUpgradeInfo(channel, data)
	if Ext.IsClient() then
		EnemyUpgradeOverhaul["UpgradeInfo"] = Ext.JsonParse(data)
	end
	if Ext.IsDeveloperMode() then
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Received upgrade info:")
		Ext.Print("======")
		Ext.Print(data)
		Ext.Print("======")
	end
end

Ext.RegisterNetListener("LLENEMY_UpgradeInfo", LLENEMY_OnSendUpgradeInfo)

local function LLENEMY_StatusGetDescriptionParam(status, statusSource, character, param)
	if status.Name == "LLENEMY_UPGRADE_INFO" then
		if param == "UpgradeInfo" then
			local uuid = character.MyGuid
			if uuid ~= nil then
				Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_DescriptionParams.lua] Getting upgrade info for (" .. uuid .. ")")
				local info_str = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
				if info_str ~= nil then
					local upgrades = LeaderLib.Common.Split(info_str, ";")
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
					--Ext.Print("Upgrade info (".. tostring(info_str)..")")
					return output
				end 
			end
		end
	else
		local func = EnemyUpgradeOverhaul.StatusDescriptionParams[status.Name]
		if func ~= nil then
			local result = pcall(func, character, param, statusSource)
			return result
		end
	end
end
Ext.RegisterListener("StatusGetDescriptionParam", LLENEMY_StatusGetDescriptionParam)
Ext.Print("[LLENEMY_DescriptionParams.lua] Registered listener LLENEMY_StatusGetDescriptionParam.")

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)
