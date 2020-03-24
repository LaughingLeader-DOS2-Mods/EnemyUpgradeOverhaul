--EnemyUpgradeOverhaul["UpgradeInfo"] = {}

function LLENEMY_Ext_StoreUpgradeInfo(uuid, str)
	if LeaderLib.Common.StringIsNullOrEmpty(uuid) == false and LeaderLib.Common.StringIsNullOrEmpty(str) == false then
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = str
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Stored upgrade info entry for (" .. uuid .. ")")
		if Ext.Version() >= 42 then
			Ext.BroadcastMessage("LLENEMY_UpgradeInfo", Ext.JsonStringify(EnemyUpgradeOverhaul.UpgradeInfo), nil)
		end
	end
end

function LLENEMY_Ext_RemoveUpgradeInfo(uuid)
	local info = EnemyUpgradeOverhaul.UpgradeInfo[uuid]
	if info ~= nil then
		EnemyUpgradeOverhaul.UpgradeInfo[uuid] = nil
		Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Removed upgrade info entry for (" .. uuid .. ")")
	end
end

function LLENEMY_Ext_TestNetMessage(channel, payload)
	local host = CharacterGetHostCharacter()
	Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Sending message: [".. tostring(channel) .."]" .. tostring(payload))
	Ext.BroadcastMessage(channel, payload, "09478f32-8fbf-4502-a59d-011e4d1b3d4d")
end

local function LLENEMY_PayloadTest(channel, payload)
	Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Received message: [".. tostring(channel) .."]" .. tostring(payload))
end

Ext.RegisterNetListener("LLENEMY_PayloadTest", LLENEMY_PayloadTest)