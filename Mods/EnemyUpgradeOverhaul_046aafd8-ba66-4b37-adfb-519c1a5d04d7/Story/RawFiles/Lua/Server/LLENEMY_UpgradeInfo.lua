--EnemyUpgradeOverhaul["UpgradeInfo"] = {}

function LLENEMY_Ext_StoreUpgradeInfo(uuid, str)
	if LeaderLib.Common.StringIsNullOrEmpty(uuid) == false and LeaderLib.Common.StringIsNullOrEmpty(str) == false then
		local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
		local info = {
			upgrades = str,
			cp = cp,
			isDuplicant = IsTagged(uuid, "LLENEMY_Duplicant") == 1
		}
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = info
		local region = GetRegion(uuid)
		local dupesTable = Osi.DB_LLENEMY_Duplication_Temp_Active:Get(uuid, nil, region)
		if dupesTable ~= nil and #dupesTable > 0 then
			for i,entry in pairs(dupesTable) do
				local dupeUUID = entry[2]
				if dupeUUID ~= nil and dupeUUID ~= "" then
					local dupeTable = {
						upgrades = str,
						cp = cp,
						isDuplicant = true
					}
					EnemyUpgradeOverhaul.UpgradeInfo[dupeUUID] = dupeTable
				end
			end
		end
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