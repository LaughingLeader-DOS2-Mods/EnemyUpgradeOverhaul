
local upgrade_info = {}

function LLENEMY_EXT_StoreUpgradeInfo(uuid, str)
	upgrade_info[uuid] = str
end

local function StatusGetDescriptionParam(status, statusSource, character, param)
	if status == "LLENEMY_UPGRADE_INFO" then
		if param == "UpgradeInfo" then
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
