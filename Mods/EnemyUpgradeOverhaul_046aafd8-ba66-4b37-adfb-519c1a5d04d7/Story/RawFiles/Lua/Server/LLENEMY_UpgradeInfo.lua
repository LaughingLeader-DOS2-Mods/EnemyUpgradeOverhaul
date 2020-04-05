--EnemyUpgradeOverhaul["UpgradeInfo"] = {}

function LLENEMY_Ext_StoreUpgradeInfo(uuid, str)
	if LeaderLib.Common.StringIsNullOrEmpty(uuid) == false and LeaderLib.Common.StringIsNullOrEmpty(str) == false then
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = str
		if Ext.IsDeveloperMode() then
			Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Stored upgrade info entry for (" .. uuid .. ")")
		end
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
		if Ext.IsDeveloperMode() then
			Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Removed upgrade info entry for (" .. uuid .. ")")
		end
	end
end

function LLENEMY_Ext_StoreChallengePoints(uuid, cpstr)
	if LeaderLib.Common.StringIsNullOrEmpty(uuid) == false and cpstr ~= nil then
		local cp = math.tointeger(cpstr)
		if cp > 0 then
			EnemyUpgradeOverhaul.ChallengePoints[uuid] = cp
		end
	end
end

function LLENEMY_Ext_SendChallengePoints()
	if Ext.Version() >= 42 then
		Ext.BroadcastMessage("LLENEMY_ChallengePoints", Ext.JsonStringify(EnemyUpgradeOverhaul.ChallengePoints), nil)
	end
end

function LLENEMY_Ext_RemoveChallengePoints(uuid)
	local info = EnemyUpgradeOverhaul.ChallengePoints[uuid]
	if info ~= nil then
		EnemyUpgradeOverhaul.ChallengePoints[uuid] = nil
	end
end