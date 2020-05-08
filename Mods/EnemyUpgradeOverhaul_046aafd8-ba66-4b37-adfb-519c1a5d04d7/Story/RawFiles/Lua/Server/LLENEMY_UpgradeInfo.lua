function SetChallengePointsTag(uuid)
	local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
	if cp == nil or cp < 0 then cp = 0 end
	LeaderLib.PrintDebug("[LLENEMY_UpgradeInfo.lua:SetChallengePointsTag] Character ("..uuid..") CP("..tostring(cp)..")")
	for k,tbl in pairs(ChallengePointsText) do
		if cp >= tbl.Min and cp <= tbl.Max then
			SetTag(uuid, tbl.Tag)
			UpgradeInfo_ApplyInfoStatus(uuid,true)
		else
			ClearTag(uuid, tbl.Tag)
		end
	end
end

local function HasUpgrades(uuid)
	for key,group in pairs(UpgradeData) do
		for status,infoText in pairs(group) do
			if HasActiveStatus(uuid, status) == 1 then
				return true
			end
		end
	end
	return false
end

function UpgradeInfo_ApplyInfoStatus(uuid,force)
	local hasUpgrades = HasUpgrades(uuid)
	if hasUpgrades or force == true then
		ApplyStatus(uuid, "LLENEMY_UPGRADE_INFO", -1.0, 1, uuid)
	elseif hasUpgrades == false then
		RemoveStatus(uuid, "LLENEMY_UPGRADE_INFO")
	end
end

function UpgradeInfo_RefreshInfoStatuses()
	local combatCharacters = Osi.DB_CombatCharacters:Get(nil,nil)
	if #combatCharacters > 0 then
		for i,entry in pairs(combatCharacters) do
			local uuid = entry[1]
			if HasActiveStatus(uuid, "LLENEMY_UPGRADE_INFO") == 1 then
				--local handle = NRD_StatusGetHandle(uuid, "LLENEMY_UPGRADE_INFO")
				--NRD_StatusSetReal(uuid, handle, "LifeTime", 24.0)
				--NRD_StatusSetReal(uuid, handle, "CurrentLifeTime", 24.0)
				--NRD_StatusSetReal(uuid, handle, "LifeTime", -1.0)
				--NRD_StatusSetReal(uuid, handle, "CurrentLifeTime", -1.0)
				ApplyStatus(uuid, "LLENEMY_UPGRADE_INFO", -1.0, 1, uuid)
			end
		end
		LeaderLib.PrintDebug("[LLENEMY_UpgradeInfo.lua:RefreshInfoStatuses] Refreshed upgrade info on characters in combat.")
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

function UpgradeInfo_SendHighestLoremaster(highest)
	local highestStr = tostring(highest)
	Ext.BroadcastMessage("LLENEMY_SetHighestLoremaster", highestStr, nil)
	LeaderLib.PrintDebug("[LLENEMY_UpgradeInfo.lua:SaveHighestLoremaster] Sending Loremaster value to clients ("..highestStr..")")
	UpgradeInfo_RefreshInfoStatuses()
end

local function TimerFinished(event, ...)
	--Ext.Print("TimerFinished: ", event, LeaderLib.Common.Dump({...}))
	if event == "Timers_LLENEMY_SendHighestLoremaster" then
		UpgradeInfo_SendHighestLoremaster(HighestLoremaster)
	end
	if event == "Timers_LLENEMY_AddNegativeItemBoosts" then
		local params = {...}
		local item = params[1]
		local totalBoosts = GetVarInteger(item, "LLENEMY_ItemCorruption_TotalBoosts")
		local stat = NRD_ItemGetStatsId(item)
		local statType = NRD_StatGetType(stat)
		local level = 1
		local baseStat,rarity,level,seed = NRD_ItemGetGenerationParams(item)
		if level == nil then
			level = NRD_ItemGetInt(item, "LevelOverride")
			if level == 0 or level == nil then
				level = CharacterGetLevel(CharacterGetHostCharacter())
			end
		end
		for k=0,totalBoosts,1 do
			ItemCorruption.AddRandomNegativeBoost(item, stat, statType, level)
		end
		Ext.Print("=============================================")
		Ext.Print("Cloned Item Stats:"..item)
		Ext.Print("=============================================")
		ItemCorruption.DebugItemStats(item)
		Ext.Print("=============================================")
	end
end
LeaderLib.RegisterListener("TimerFinished", TimerFinished)

-- Loremaster
local function SaveHighestLoremaster(player, stat, lastVal, nextVal)
	local nextHighest = HighestLoremaster
	if player ~= nil then
		if nextVal >= nextHighest then
			local lore = CharacterGetAbility(player, "Loremaster")
			if lore >= HighestLoremaster then
				nextHighest = lore
			end
		elseif nextVal < lastVal then
			nextHighest = CheckPartyLoremaster()
		end
	else
		nextHighest = CheckPartyLoremaster()
	end

	if HighestLoremaster ~= nextHighest then
		StoreHighestLoremaster(nextHighest)
	end
end

local function CharacterBasePointsChanged(player, stat, lastVal, nextVal)
	if stat == "Loremaster" then
		SaveHighestLoremaster(player, stat, lastVal, nextVal)
	end
end
LeaderLib.RegisterListener("CharacterBasePointsChanged", CharacterBasePointsChanged)

function StoreHighestLoremaster(nextHighest)
	HighestLoremaster = nextHighest
	Osi.LLENEMY_UpgradeInfo_StoreLoremaster(HighestLoremaster)
	LeaderLib.PrintDebug("[LLENEMY_UpgradeInfo.lua:SaveHighestLoremaster] Highest Loremaster is now ("..tostring(HighestLoremaster)..")")
	LeaderLib.StartTimer("Timers_LLENEMY_SendHighestLoremaster", 500)
end