function SetChallengePointsTag(uuid)
	local cp = GetVarInteger(uuid, "LLENEMY_ChallengePoints")
	if cp == nil or cp < 0 then cp = 0 end
	LeaderLib.PrintDebug("[EUO:UpgradeInfo.lua:SetChallengePointsTag] Character ("..uuid..") CP("..tostring(cp)..")")
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
		LeaderLib.PrintDebug("[EUO:UpgradeInfo.lua:RefreshInfoStatuses] Refreshed upgrade info on characters in combat.")
	end
end

local function GetHighestPartyLoremaster()
	local nextHighest = 0
	local players = Osi.DB_IsPlayer:Get(nil)
	for _,entry in pairs(players) do
		local uuid = entry[1]
		local character = Ext.GetCharacter(uuid)
		if character ~= nil then
			if character.Stats.Loremaster > nextHighest then
				nextHighest = character.Stats.Loremaster
			end
		end
	end
	return nextHighest
end

function SetHighestPartyLoremaster()
	HighestLoremaster = GetHighestPartyLoremaster()
	if Ext.GetGameState() == "Running" then
		Ext.BroadcastMessage("LLENEMY_SetHighestLoremaster", tostring(HighestLoremaster), nil)
		LeaderLib.PrintDebug("[EUO:SetHighestPartyLoremaster] Synced highest party loremaster.",HighestLoremaster)
	else
		TimerCancel("Timers_LLENEMY_SyncHighestLoremaster")
		TimerLaunch("Timers_LLENEMY_SyncHighestLoremaster", 500)
	end
end

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
			nextHighest = GetHighestPartyLoremaster()
		end
	else
		nextHighest = GetHighestPartyLoremaster()
	end

	if HighestLoremaster ~= nextHighest then
		HighestLoremaster = nextHighest
		if Ext.GetGameState() == "Running" then
			Ext.BroadcastMessage("LLENEMY_SetHighestLoremaster", tostring(HighestLoremaster), nil)
		else
			TimerCancel("Timers_LLENEMY_SyncHighestLoremaster")
			TimerLaunch("Timers_LLENEMY_SyncHighestLoremaster", 500)
		end
	end
end

local function CharacterBasePointsChanged(player, stat, lastVal, nextVal)
	if stat == "Loremaster" then
		SaveHighestLoremaster(player, stat, lastVal, nextVal)
	end
end
LeaderLib.RegisterListener("CharacterBasePointsChanged", CharacterBasePointsChanged)

-- event CharacterBaseAbilityChanged((CHARACTERGUID)_Character, (STRING)_Ability, (INTEGER)_OldBaseValue, (INTEGER)_NewBaseValue)
---@type character string
---@type ability string
---@type old integer
---@type new integer
local function OnCharacterBaseAbilityChanged(character, ability, old, new)
	if ability == "Loremaster" and CharacterIsPlayer(character) == 1 and CharacterIsSummon(character) == 0 and CharacterIsPartyFollower(character) == 0 then
		SaveHighestLoremaster(character, ability, old, new)
	end
end

Ext.RegisterOsirisListener("CharacterBaseAbilityChanged", 4, "after", OnCharacterBaseAbilityChanged)

Ext.RegisterOsirisListener("UserConnected", 3, "after", function(id, username, profileId)
	HighestLoremaster = GetHighestPartyLoremaster()
	if Ext.GetGameState() == "Running" and GetCurrentCharacter(id) ~= nil then
		Ext.PostMessageToUser(id, "LLENEMY_SetHighestLoremaster", tostring(HighestLoremaster))
	else
		TimerCancel("Timers_LLENEMY_SyncHighestLoremaster")
		TimerLaunch("Timers_LLENEMY_SyncHighestLoremaster", 500)
	end
end)