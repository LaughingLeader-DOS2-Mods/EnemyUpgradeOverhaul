--EnemyUpgradeOverhaul["UpgradeInfo"] = {}

function LLENEMY_Ext_StoreUpgradeInfo(uuid, str)
	if LeaderLib.Common.StringIsNullOrEmpty(uuid) == false and LeaderLib.Common.StringIsNullOrEmpty(str) == false then
		local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = {
			upgrades = str,
			cp = cp
		}
		if Ext.IsDeveloperMode() then
			Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Stored upgrade info entry for (" .. uuid .. ")")
		end
	end
end

function LLENEMY_Ext_SendUpgradeInfo()
	if Ext.IsDeveloperMode() then
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Sending update info to clients.")
	end
	if Ext.Version() >= 42 then
		Ext.BroadcastMessage("LLENEMY_UpgradeInfo", Ext.JsonStringify(EnemyUpgradeOverhaul.UpgradeInfo), nil)
	end
end

function LLENEMY_Ext_RemoveUpgradeInfo(uuid)
	local info = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
	if info ~= nil then
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = nil
		if Ext.IsDeveloperMode() then
			Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Removed upgrade info entry for (" .. uuid .. ")")
		end
	end
end