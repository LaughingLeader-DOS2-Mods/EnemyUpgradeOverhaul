--EnemyUpgradeOverhaul["UpgradeInfo"] = {}

function LLENEMY_Ext_StoreUpgradeInfo(uuid, str)
	if LeaderLib.Common.StringIsNullOrEmpty(uuid) == false and LeaderLib.Common.StringIsNullOrEmpty(str) == false then
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = str
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Stored upgrade info entry for (" .. uuid .. ")")
	end
end

function LLENEMY_Ext_SendUpgradeInfo()
	if Ext.Version() >= 42 then
		Ext.BroadcastMessage("LLENEMY_UpgradeInfo", Ext.JsonStringify(EnemyUpgradeOverhaul.UpgradeInfo), nil)
	end
end

function LLENEMY_Ext_RemoveUpgradeInfo(uuid)
	local info = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
	if info ~= nil then
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = nil
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Removed upgrade info entry for (" .. uuid .. ")")
	end
end