
local upgrade_info = {}

function LLENEMY_EXT_StoreUpgradeInfo(uuid, str)
	upgrade_info[uuid] = str
	Ext.Print("Stored upgrade_info: " .. uuid .. " = " .. str)
end

function LLENEMY_EXT_RemoveUpgradeInfo(uuid)
	upgrade_info[uuid] = nil;
	Ext.Print("Removed upgrade_info entry for " .. uuid)
end

local function StatusGetDescriptionParam(status, statusSource, character, param)
	Ext.Print("[LLENEMY_DescriptionParams.lua] Getting params for (".. tostring(status) ..") Character (".. tostring(character.MyGuid) ..") param ("..tostring(param)..") Source ("..tostring(statusSource.MyGuid)..").")
	
	if status == "LLENEMY_UPGRADE_INFO" then
		if param == "UpgradeInfo" then
			Ext.Print("Getting upgrade_info for " .. tostring(character.MyGuid))
			local info_str = upgrade_info[character.MyGuid]
			if info_str ~= nil then
				return info_str
			end
		end
	else
		local func = EnemyUpgradeOverhaul.StatusDescriptionParams[status]
		if func ~= nil then
			local result = pcall(func, character, param, statusSource)
			return result
		end
	end
end
Ext.RegisterListener("StatusGetDescriptionParam", StatusGetDescriptionParam)

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)
