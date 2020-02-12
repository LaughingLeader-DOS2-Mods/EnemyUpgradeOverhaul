
local upgrade_info = {}
local upgrade_ids = {}

function LLENEMY_EXT_CreateUpgradeInfoID(character)
	local hearing = NRD_CharacterGetComputedStat(character, "Hearing", 0)
	local id = hearing
	local hearingmult = 0
	if upgrade_ids[id] ~= nil then
		hearingmult = hearingmult + 1
		id = hearing + hearingmult
		while upgrade_ids[id] ~= nil do
			hearingmult = hearingmult + 1
			id = hearing + hearingmult
		end
		NRD_CharacterSetPermanentBoostInt(character, "Hearing", hearingmult)
		CharacterAddAttribute(character, "Dummy", 0)
	end
	Osi.LLENEMY_UpgradeInfo_Internal_StoreUpgradeID(character, id)
	upgrade_ids[id] = GetUUID(character)
	Ext.Print("Stored upgrade_ids["..tostring(id).."] = " .. GetUUID(character))
end

function LLENEMY_EXT_StoreUpgradeInfo(uuid, str)
	if str ~= nil and str ~= "" then
		upgrade_info[uuid] = str
		Ext.Print("Stored upgrade_info: " .. uuid .. " = " .. str)
	end
end

function LLENEMY_EXT_RemoveUpgradeInfo(uuid)
	upgrade_info[uuid] = nil;
	for key,v in pairs(upgrade_ids) do
		if v == uuid then
			upgrade_ids[key] = nil
			Ext.Print("Removed upgrade_ids hearing key for " .. uuid)
		end
	end
	Ext.Print("Removed upgrade_info entry for " .. uuid)
end

local function split(s, sep)
    local fields = {}

    local sep = sep or " "
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

    return fields
end

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

local function StatusGetDescriptionParam(status, statusSource, character, param)
	if status.Name == "LLENEMY_UPGRADE_INFO" and EnemyUpgradeOverhaul.SINGLEPLAYER == true then
		if param == "UpgradeInfo" then
			local hearing = character.Hearing
			--Ext.Print("Looking for ID for hearing(".. tostring(hearing)..")")
			local uuid = upgrade_ids[hearing]
			if uuid ~= nil then
				--Ext.Print("Getting upgrade_info for hearing(".. tostring(hearing)..") = uuid(".. tostring(uuid)..")")
				local info_str = upgrade_info[uuid]
				if info_str ~= nil then
					local upgrades = split(info_str, ";")
					table.sort(upgrades, sortupgrades)
					local count = #upgrades
					local output = "<br>"
					local i = 0
					for k,v in pairs(upgrades) do
						local color = upgrade_colors[v]
						if color ~= nil then
							output = output.."<font color='"..color.."' size='18'>"..v.."</font>"
						else
							output = output.."<font size='18'>"..v.."</font>"
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
--Ext.RegisterListener("StatusGetDescriptionParam", StatusGetDescriptionParam)
Ext.Print("[LLENEMY_DescriptionParams.lua] Registered listener StatusGetDescriptionParam.")

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)
