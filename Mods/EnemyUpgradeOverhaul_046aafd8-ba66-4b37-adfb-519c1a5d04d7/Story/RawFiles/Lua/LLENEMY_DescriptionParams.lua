
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

local function StatusGetDescriptionParam(status, statusSource, character, param)
	--Ext.Print("[LLENEMY_DescriptionParams.lua] Getting params for (".. tostring(status.Name) ..") param ("..tostring(param)..")")
	--LLENEMY_Ext_TraceCharacterStats_Restricted(character)
	--Ext.Print(tostring(character.Experience))
	--Ext.Print(tostring(LeaderLib.Common.Dump(character.Experience)))
	--LLENEMY_Ext_TraceCharacterStats_Restricted(character)
	--LLENEMY_Ext_TraceCharacterStats_Restricted(statusSource)

	if status.Name == "LLENEMY_UPGRADE_INFO" then
		if param == "UpgradeInfo" then
			local hearing = character.Hearing
			--Ext.Print("Looking for ID for hearing(".. tostring(hearing)..")")
			local uuid = upgrade_ids[hearing]
			if uuid ~= nil then
				--Ext.Print("Getting upgrade_info for hearing(".. tostring(hearing)..") = uuid(".. tostring(uuid)..")")
				local info_str = upgrade_info[uuid]
				if info_str ~= nil then
					local affixes = split(info_str, ";")
					--table.sort(affixes, function(a, b) return a:upper() < b:upper() end)
					local output = ""
					for k,v in pairs(affixes) do
						output = output .. v .. "<br>"
					end
					--Ext.Print("Upgrade info (".. tostring(info_str)..")")
					return output
				end
			end
			return ""
		end
	else
		local func = EnemyUpgradeOverhaul.StatusDescriptionParams[status.Name]
		if func ~= nil then
			local result = pcall(func, character, param, statusSource)
			return result
		end
	end
end
Ext.RegisterListener("StatusGetDescriptionParam", StatusGetDescriptionParam)
Ext.Print("[LLENEMY_DescriptionParams.lua] Registered listener StatusGetDescriptionParam.")

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)
