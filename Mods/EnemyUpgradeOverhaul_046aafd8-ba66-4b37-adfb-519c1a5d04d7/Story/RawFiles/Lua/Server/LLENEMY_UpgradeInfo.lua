function LLENEMY_Ext_SetChallengePointsTag(uuid)
	local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
	if cp == nil or cp < 0 then cp = 0 end
	for k,tbl in pairs(EnemyUpgradeOverhaul.ChallengePointsText) do
		if cp >= tbl.Min and cp <= tbl.Max then
			SetTag(uuid, tbl.Tag)
		else
			ClearTag(uuid, tbl.Tag)
		end
	end
end

local function HasUpgrades(uuid)
	for key,group in pairs(EnemyUpgradeOverhaul.UpgradeData) do
		for status,infoText in pairs(group) do
			if HasActiveStatus(uuid, status) == 1 then
				return true
			end
		end
	end
	return false
end

function LLENEMY_Ext_UpgradeInfo_ApplyInfoStatus(uuid)
	if HasUpgrades(uuid) then
		if HasActiveStatus(uuid, "LLENEMY_UPGRADE_INFO") == 0 then
			ApplyStatus(uuid, "LLENEMY_UPGRADE_INFO", -1.0, 0, uuid);
		end
	else
		RemoveStatus(uuid, "LLENEMY_UPGRADE_INFO");
	end
end