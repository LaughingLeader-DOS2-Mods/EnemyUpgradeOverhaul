--EnemyUpgradeOverhaul["UpgradeInfo"] = {}

local function GetUpgradeInfo(uuid)
	local infoID = EnemyUpgradeOverhaul.GetInfoID(uuid)
	local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
	if cp == nil or cp < 0 then cp = 0 end
	local info = EnemyUpgradeOverhaul.UpgradeInfo[infoID]
	if info == nil then
		info = {
			upgrades = {},
			upgradesCount = 0,
			cp = cp,
			isDuplicant = IsTagged(uuid, "LLENEMY_Duplicant") == 1,
		}
		EnemyUpgradeOverhaul.UpgradeInfo[infoID] = info
	else
		info.cp = cp
	end
	return info
end

function LLENEMY_Ext_SetChallengePointsTag(uuid)
	local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
	if cp == nil or cp < 0 then cp = 0 end
	for k,tbl in pairs(EnemyUpgradeOverhaul.ChallengePointsText) do
		if cp >= tbl.Min and cp <= tbl.Max then
			SetTag(uuid, tbl.Tag)
		else
			if IsTagged(uuid, tbl.Tag) == 1 then
				ClearTag(uuid, tbl.Tag)
			end
		end
	end
end

function LLENEMY_Ext_UpgradeInfo_ResolveStatus(uuid, info)
	if info == nil then
		info = GetUpgradeInfo(uuid)
	end
	if info ~= nil and info.upgradesCount > 0 then
		if HasActiveStatus(uuid, "LLENEMY_UPGRADE_INFO") == 0 then
			ApplyStatus(uuid, "LLENEMY_UPGRADE_INFO", -1.0, 0, uuid);
		end
	else
		LLENEMY_Ext_UpgradeInfo_Remove(uuid)
	end
end

local function LLENEMY_UpgradeInfo_AddUpgrade(uuid, info, status)
	if info.upgrades[status] == nil then
		info.upgrades[status] = 1
		info.upgradesCount = info.upgradesCount + 1
	elseif LeaderLib.Common.StringIsNullOrEmpty(Ext.StatGetAttribute(status, "StackId")) then
		info.upgrades[status] = info.upgrades[status] + 1
		info.upgradesCount = info.upgradesCount + 1
	end
	LLENEMY_Ext_UpgradeInfo_CreateInfoString(uuid, info)
end

function LLENEMY_Ext_UpgradeInfo_CreateInfoString(uuid, info)
	Osi.DB_LLENEMY_UpgradeInfo_Temp_InfoString:Delete(uuid, nil)
	if info == nil then
		info = GetUpgradeInfo(uuid)
	end
	if info ~= nil and info.upgradesCount > 0 then
		local infoStr = LeaderLib.Common.StringJoin(";",info.upgrades)
		if infoStr ~= "" and infoStr ~= nil then
			Osi.DB_LLENEMY_UpgradeInfo_Temp_InfoString(uuid, infoStr)
			LeaderLib.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Saved upgrade info string for ("..uuid.."):("..infoStr..").")
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

function LLENEMY_Ext_UpgradeInfo_Build(uuid)
	local hasUpgrades = HasActiveStatus(uuid, "LLENEMY_UPGRADE_INFO") == 1 or HasUpgrades(uuid)
	if hasUpgrades then
		local info = GetUpgradeInfo(uuid)
		for key,group in pairs(EnemyUpgradeOverhaul.UpgradeData) do
			for status,infoText in pairs(group) do
				if HasActiveStatus(uuid, status) == 1 then
					LLENEMY_UpgradeInfo_AddUpgrade(uuid, info, status)
				end
			end
		end
		if info.upgradesCount > 0 then
			LLENEMY_Ext_UpgradeInfo_CreateInfoString(uuid, info)
			Osi.LLENEMY_UpgradeInfo_StartTimer("Timers_LLENEMY_UpgradeInfo_SendInfo", 50)
			local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
			if cp == nil or cp < 0 then cp = 0 end
			info.cp = cp
			LLENEMY_Ext_UpgradeInfo_ResolveStatus(uuid, info)
		else
			LLENEMY_Ext_UpgradeInfo_Remove(uuid)
		end
		
	end
end

function LLENEMY_Ext_OnUpgradeApplied(uuid, status)
	local infoText = EnemyUpgradeOverhaul.UpgradeData.Statuses[status]
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.ArmorBoostStatuses[status] end
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.MagicArmorBoostStatuses[status] end
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.DamageBoostStatuses[status] end
	--if infoText == nil then	infoText = EnemyUpgradeOverhaul.UpgradeData.VitalityBoostStatuses[status] end
	if infoText ~= nil then
		--Osi.DB_LLENEMY_UpgradeInfo_Temp_ActiveUpgrades(char, status)
		local info = GetUpgradeInfo(uuid)
		LLENEMY_UpgradeInfo_AddUpgrade(uuid, info, status)
		LLENEMY_Ext_UpgradeInfo_CreateInfoString(uuid, info)
		LeaderLib.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Added upgrade ("..status..") to info for ("..uuid..").")
		LLENEMY_Ext_UpgradeInfo_ResolveStatus(uuid, info)
		Osi.LLENEMY_UpgradeInfo_StartTimer("Timers_LLENEMY_UpgradeInfo_SendInfo", 250)
	end
end

function LLENEMY_Ext_UpgradeInfo_Send()
	local data = Ext.JsonStringify(EnemyUpgradeOverhaul.UpgradeInfo)
	LeaderLib.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Sending update info to clients:("..data..")")
	Ext.BroadcastMessage("LLENEMY_UpgradeInfo", data, nil)
end

function LLENEMY_Ext_UpgradeInfo_Remove(uuid)
	Osi.DB_LLENEMY_UpgradeInfo_Temp_InfoString:Delete(uuid, nil)
	local infoID = EnemyUpgradeOverhaul.GetInfoID(uuid)
	EnemyUpgradeOverhaul.UpgradeInfo[infoID] = nil
	if HasActiveStatus(uuid, "LLENEMY_UPGRADE_INFO") == 1 then
		RemoveStatus(uuid, "LLENEMY_UPGRADE_INFO")
	end
	Osi.LLENEMY_UpgradeInfo_StartTimer("Timers_LLENEMY_UpgradeInfo_SendInfo", 250)
end

function LLENEMY_Ext_UpgradeInfo_LoadSavedInfo()
	local saved = Osi.DB_LLENEMY_UpgradeInfo_Temp_InfoString:Get(nil, nil)
	if saved ~= nil and #saved > 0 then
		for i,entry in pairs(saved) do
			--LeaderLib.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Saved info ("..LeaderLib.Common.Dump(entry)..").")
			local uuid = entry[1]
			local infoStr = entry[2]
			if ObjectExists(uuid) == 1 and infoStr ~= nil and infoStr ~= "" then
				local info = GetUpgradeInfo(uuid)
				local upgrades = LeaderLib.Common.StringSplit(";", infoStr)
				if upgrades ~= nil and #upgrades > 0 then
					info.upgrades = {}
					info.upgradesCount = 0
					for i,status in pairs(upgrades) do
						if HasActiveStatus(uuid, status) == 1 then
							LLENEMY_UpgradeInfo_AddUpgrade(uuid, info, status)
						end
					end
					LeaderLib.Print("[EnemyUpgradeOverhaul:LLENEMY_UpgradeInfo.lua] Loaded upgrade info string for ("..uuid.."):("..infoStr..").")
					-- Re-create the info string since active statuses may have changed
					LLENEMY_Ext_UpgradeInfo_CreateInfoString(uuid, info)
					Osi.LLENEMY_UpgradeInfo_StartTimer("Timers_LLENEMY_UpgradeInfo_SendInfo", 250)
				end
			else
				Osi.DB_LLENEMY_UpgradeInfo_Temp_InfoString:Delete(uuid, nil)
			end
		end
	else
		local combatCharacters = Osi.DB_CombatCharacters:Get(nil,nil)
		if combatCharacters ~= nil and #combatCharacters > 0 then
			for i,entry in pairs(combatCharacters) do
				LeaderLib.Print("DB_CombatCharacters entry: " .. LeaderLib.Common.Dump(entry))
				local uuid = entry[1]
				if CharacterIsPlayer(uuid) == 0 then
					LLENEMY_Ext_UpgradeInfo_Build(uuid)
				end
			end
		end
	end
end