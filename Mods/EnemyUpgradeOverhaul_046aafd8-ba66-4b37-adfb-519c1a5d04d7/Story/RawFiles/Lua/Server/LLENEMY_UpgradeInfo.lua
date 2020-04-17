function LLENEMY_Ext_SetChallengePointsTag(uuid)
	local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
	if cp == nil or cp < 0 then cp = 0 end
	LeaderLib.Print("[LLENEMY_UpgradeInfo.lua:LLENEMY_Ext_SetChallengePointsTag] Character ("..uuid..") CP("..tostring(cp)..")")
	for k,tbl in pairs(EnemyUpgradeOverhaul.ChallengePointsText) do
		if cp >= tbl.Min and cp <= tbl.Max then
			SetTag(uuid, tbl.Tag)
			LLENEMY_Ext_UpgradeInfo_ApplyInfoStatus(uuid)
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

local function CheckPartyLoremaster()
	local allPlayersHaveLowerValues = true
	local nextHighest = 0
	local players = Osi.DB_IsPlayer:Get(nil)
	for _,entry in pairs(players) do
		local uuid = entry[1]
		local lore = CharacterGetAbility(uuid, "Loremaster")
		if lore > nextHighest then
			nextHighest = lore
		end
	end
	return nextHighest
end

function LLENEMY_Ext_UpgradeInfo_SendHighestLoremaster(highest)
	local highestStr = tostring(highest)
	Ext.BroadcastMessage("LLENEMY_SetHighestLoremaster", highestStr, nil)
	LeaderLib.Print("[LLENEMY_UpgradeInfo.lua:SaveHighestLoremaster] Sending Loremaster value to clients ("..highestStr..")")
end

local function TimerFinished(event, ...)
	if event == "Timers_LLENEMY_SendHighestLoremaster" then
		LLENEMY_Ext_UpgradeInfo_SendHighestLoremaster(EnemyUpgradeOverhaul.HighestLoremaster)
	end
end
LeaderLib.RegisterListener("TimerFinished", TimerFinished)

-- Loremaster
local function SaveHighestLoremaster(player, stat, lastVal, nextVal)
	local nextHighest = EnemyUpgradeOverhaul.HighestLoremaster
	if player ~= nil then
		if stat == "Loremaster" then
			if nextVal >= nextHighest then
				local lore = CharacterGetAbility(player, "Loremaster")
				if lore >= EnemyUpgradeOverhaul.HighestLoremaster then
					nextHighest = lore
				end
			elseif nextVal < lastVal then
				nextHighest = CheckPartyLoremaster()
			end
		end
	else
		nextHighest = CheckPartyLoremaster()
	end

	if EnemyUpgradeOverhaul.HighestLoremaster ~= nextHighest then
		LLENEMY_Ext_StoreHighestLoremaster(nextHighest)
	end
end
LeaderLib.RegisterListener("CharacterBasePointsChanged", SaveHighestLoremaster)

function LLENEMY_Ext_StoreHighestLoremaster(nextHighest)
	EnemyUpgradeOverhaul.HighestLoremaster = nextHighest
	Osi.LLENEMY_UpgradeInfo_StoreLoremaster(EnemyUpgradeOverhaul.HighestLoremaster)
	LeaderLib.Print("[LLENEMY_UpgradeInfo.lua:SaveHighestLoremaster] Highest Loremaster is now ("..tostring(EnemyUpgradeOverhaul.HighestLoremaster)..")")
	LeaderLib_Ext_StartTimer("Timers_LLENEMY_SendHighestLoremaster", 100)
end