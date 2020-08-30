function Duplication_CopyCP(source,dupe)
	local cp = GetVarInteger(source, "LLENEMY_ChallengePoints")
	SetVarInteger(dupe, "LLENEMY_ChallengePoints", cp)
	SetChallengePointsTag(dupe)
end

local CopyBoosts = {
	"Movement",
	"MovementSpeedBoost",
	"FireResistance",
	"EarthResistance",
	"WaterResistance",
	"AirResistance",
	"PoisonResistance",
	--"ShadowResistance",
	"PiercingResistance",
	"PhysicalResistance",
	--"CorrosiveResistance",
	--"MagicResistance",
	--"CustomResistance",
	"MaxResistance",
	"Sight",
	--"Hearing",
	"APMaximum",
	"APStart",
	"APRecovery",
	"CriticalChance",
	"Initiative",
	"Vitality",
	--"VitalityBoost",
	"MagicPoints",
	--"Armor",
	--"MagicArmor",
	"ArmorBoost",
	"MagicArmorBoost",
	"ArmorBoostGrowthPerLevel",
	"MagicArmorBoostGrowthPerLevel",
	"DamageBoost",
	"DamageBoostGrowthPerLevel",
	"Accuracy",
	"Dodge",
	--"LifeSteal",
	"Weight",
	--"ChanceToHitBoost",
	--"RangeBoost",
	--"APCostBoost",
	--"SPCostBoost",
	"MaxSummons",
	--"BonusWeaponDamageMultiplier",
}

local PrintDebug = LeaderLib.PrintDebug

local function GetArmorScale(base, level)
	local vitalityBoost = Game.Math.GetVitalityBoostByLevel(level)
	local armorScaling = (vitalityBoost * ((Ext.ExtraData.AttributeBaseValue + level * Ext.ExtraData.ExpectedConGrowthForArmorCalculation - Ext.ExtraData.AttributeBaseValue) *  Ext.ExtraData.VitalityBoostFromAttribute) + 1.0) * Ext.ExtraData.ArmorToVitalityRatio
	local scaledArmor = armorScaling * base / 100;
	return scaledArmor
end

local ArmorStats = {
	MaxArmor = "Armor",
	MaxMagicArmor = "MagicArmor"
}

local function CopyStats(source,dupe,baseStat)
	local sourceChar = Ext.GetCharacter(source)
	local targetChar = Ext.GetCharacter(dupe)

	local level = CharacterGetLevel(source)

	for stat,boost in pairs(ArmorStats) do
		local sourceVal = sourceChar.Stats[stat]
		local dupeVal = targetChar.Stats[stat]
		if sourceVal ~= dupeVal then
			local next = sourceVal - dupeVal
			NRD_CharacterSetPermanentBoostInt(dupe, boost, next)
			PrintDebug("Added", boost, "to", next, "for", dupe, "from", dupeVal,sourceVal)
		end
	end
	for i,stat in LeaderLib.Data.Attribute:Get() do
		local baseSource = CharacterGetBaseAttribute(source, stat)
		--NRD_PlayerSetBaseAttribute(dupe, stat, baseSource)
		local baseDupe = CharacterGetBaseAttribute(dupe, stat)
		if baseDupe ~= nil and baseSource ~= nil and baseDupe ~= baseSource then
			local next = baseSource - baseDupe
			CharacterAddAttribute(dupe, stat, next)
			PrintDebug("Added", stat, "to", next, "for", dupe, "from", baseDupe, baseSource)
		end
	end
	for i,stat in LeaderLib.Data.Ability:Get() do
		local baseSource = CharacterGetBaseAbility(source, stat)
		--NRD_PlayerSetBaseAbility(dupe, stat, baseSource)
		local baseDupe = CharacterGetBaseAbility(dupe, stat)
		if baseDupe ~= nil and baseSource ~= nil and baseDupe ~= baseSource then
			local next = baseSource - baseDupe
			CharacterAddAbility(dupe, stat, next)
			PrintDebug("Added", stat, "to", next, "for", dupe, "from", baseDupe, baseSource)
		end
	end
	for i,boost in ipairs(CopyBoosts) do
		local baseSource = sourceChar.Stats[boost] or 0
		--local baseSource = NRD_CharacterGetPermanentBoostInt(source, boost)
		-- if baseSource == 0 then
		-- 	baseSource = Ext.StatGetAttribute(sourceChar.Stats.Name, boost) or 0
		-- 	if type(baseSource) == "string" then
		-- 		print(baseSource, boost)
		-- 		baseSource = tonumber(baseSource)
		-- 	end
		-- end
		--local baseDupe = NRD_CharacterGetPermanentBoostInt(dupe, boost)
		local baseDupe = targetChar.Stats[boost] or 0
		if baseSource ~= nil and baseDupe ~= nil and baseDupe ~= baseSource then
			local next = baseSource - baseDupe
			NRD_CharacterSetPermanentBoostInt(dupe, boost, next)
			PrintDebug("Added", boost, "to", next, "for", dupe, "from", baseDupe, baseSource)
		end
	end
	if ObjectGetFlag(source, "LLENEMY_LoneWolfBonusesApplied") == 1 then
		ObjectSetFlag(dupe, "LLENEMY_LoneWolfBonusesApplied", 0)
	end
	CharacterAddAttribute(dupe, "Dummy", 0)
end

function Duplication_CopySourceStats(source,dupe,baseStat)
	local status,err = xpcall(CopyStats, debug.traceback, source, dupe, baseStat)
	if not status then
		print(err)
	end
end

function Duplication_CopyTalents(source,dupe)
	for i,talent in LeaderLib.Data.Talents:Get() do
		if CharacterHasTalent(source,talent) == 1 then
			NRD_CharacterSetPermanentBoostTalent(dupe, talent, 1)
		end
	end
end

function Duplication_CopyName(source,dupe)
	local handle,refStr = CharacterGetDisplayName(source)
	local characterName = Ext.GetTranslatedString(handle, refStr)
	local dupeNameBase = Ext.GetTranslatedString("h02023d82gc736g447fgaea3g327be0956688", "<font color='#BF5FFF'>[1] (Shadow)</font>")
	local dupeName = dupeNameBase:gsub("%[1%]", characterName)
	CharacterSetCustomName(dupe, dupeName)
end

local function StatusHasAura(status)
	local auraRadius = Ext.StatGetAttribute(status, "AuraRadius")
	return auraRadius ~= nil and auraRadius > 0
end

local IgnoredDuplicantStatuses = {
	LLENEMY_TALENT_RESISTDEAD = true,
	LLENEMY_TALENT_RESISTDEAD2 = true,
}

local function IgnoreStatus(dupe, status)
	if LeaderLib.Data.EngineStatus[status] == true then
		return true
	end
	if IgnoredDuplicantStatuses[status] == true then
		return true
	end
	if string.find(status, "LLENEMY_DUPE") or string.find(status, "QUEST") then
		return true
	end
	if not Osi.LLENEMY_Duplication_QRY_CanCopyStatus(dupe, status) then
		return true
	end
	return false
end

function Duplication_CopyStatus(source,dupe,status,handlestr)
	if not StatusHasAura(status) and not IgnoreStatus(status) and HasActiveStatus(dupe, status) == 0 then
		local handle = math.tointeger(handlestr)
		local duration = NRD_StatusGetReal(source, handle, "CurrentLifeTime")
		if duration ~= 0.0 then
			local statusSourceHandle = NRD_StatusGetGuidString(source, handle, "StatusSourceHandle")
			if statusSourceHandle == nil or statusSourceHandle == source then 
				statusSourceHandle = dupe
			end
			Osi.LLENEMY_Duplication_CopyStatus(source, dupe, status, duration, statusSourceHandle)
		end
	end
end

---@param source string
---@param sourceCharacter EsvCharacter
---@param dupe string
local function CopyStatuses(source, sourceCharacter, dupe)
	for i,status in pairs(sourceCharacter:GetStatusObjects()) do
		if status.CurrentLifeTime ~= 0
		and not IgnoreStatus(dupe, status.StatusId) 
		and not StatusHasAura(status.StatusId) 
		and HasActiveStatus(dupe, status.StatusId) == 0 then
			local statusSource = dupe
			if status.StatusSourceHandle ~= nil then
				local statusSourceObj = Ext.GetGameObject(status.StatusSourceHandle)
				if statusSourceObj ~= nil then
					statusSource = statusSourceObj.MyGuid
				end
			end
			Osi.LLENEMY_Duplication_CopyStatus(source, dupe, status.StatusId, status.CurrentLifeTime, statusSource)
		end
	end
end

function Duplication_CopySource(source,dupe)
	---@type EsvCharacter
	local sourceCharacter = Ext.GetCharacter(source)
	local b,err = xpcall(CopyStatuses, debug.traceback, source, sourceCharacter, dupe)
	if not b then
		print(err)
	end
	Duplication_CopySourceStats(source, dupe, sourceCharacter.Stats.Name)
	pcall(Duplication_CopyTalents, source, dupe)
	Duplication_CopyName(source, dupe)
	Duplication_CopyCP(source, dupe)
	ClearGain(dupe)

	ApplyStatus(dupe, "LEADERLIB_RECALC", 0.0, 1, dupe)

	---@type string[]
	local skills = sourceCharacter:GetSkills()
	if skills ~= nil and #skills > 0 then
		for i,skill in pairs(skills) do
			CharacterAddSkill(dupe, skill, 0)
			---@type EsvSkillInfo
			--local skillInfo = sourceCharacter:GetSkillInfo(skill)
		end
	else
		NRD_CharacterIterateSkills(source, "LLENEMY_Dupe_CopySkill")
	end
	Osi.LLENEMY_Duplication_Internal_SetupDupe_StageTwo(source, dupe)

	-- ---@type EsvCharacter
	-- local sourceChar = Ext.GetCharacter(source)
	local dupeChar = Ext.GetCharacter(dupe)
	
	--LeaderLib.PrintDebug("Dupe level| Source:",source, CharacterGetLevel(source), sourceCharacter.Stats.Level, sourceCharacter.Stats.Name, "Dupe:", dupe, CharacterGetLevel(dupe), dupeChar.Stats.Level, dupeChar.Stats.Name)

	for i,tag in pairs(sourceCharacter:GetTags()) do
		SetTag(dupe, tag)
	end

	local scale = sourceCharacter.Scale
	if scale ~= 1.0 then
		dupeChar:SetScale(scale)
	end

	NRD_CharacterSetStatInt(dupe, "CurrentArmor", sourceCharacter.Stats.CurrentArmor)
	NRD_CharacterSetStatInt(dupe, "CurrentMagicArmor", sourceCharacter.Stats.CurrentMagicArmor)
	NRD_CharacterSetStatInt(dupe, "CurrentVitality", sourceCharacter.Stats.CurrentVitality)

	print(sourceCharacter.Stats.CurrentVitality/sourceCharacter.Stats.MaxVitality)

	CharacterSetHitpointsPercentage(dupe, math.min(100.0, (sourceCharacter.Stats.CurrentVitality/sourceCharacter.Stats.MaxVitality)*100))

	CharacterSetDetached(dupe, 0)
	TeleportTo(dupe, source, "LLENEMY_DupeCharacterTeleported", 1, 1, 0)
	CharacterSetFollowCharacter(dupe, source)
	PlayEffect(dupe, "RS3_FX_GP_ScriptedEvent_Teleport_GenericSmoke_01")
	TeleportToRandomPosition(dupe, 3.0, "")

	--local sourceChar = Ext.GetCharacter(source).Stats
	--local targetChar = Ext.GetCharacter(dupe).Stats
	--print(string.format("Source(%s) MaxArmor(%i) BaseMaxArmor(%i) MaxMagicArmor(%i) BaseMaxMagicArmor(%i) CurrentArmor(%i) CurrentMagicArmor(%i)", source, sourceChar.MaxArmor, sourceChar.BaseMaxArmor, sourceChar.MaxMagicArmor, sourceChar.BaseMaxMagicArmor, sourceChar.CurrentArmor, sourceChar.CurrentMagicArmor))
	-- print(Ext.StatGetAttribute(sourceChar.Name, "Armor"), Ext.StatGetAttribute(sourceChar.Name, "MagicArmor"))
	-- for i,v in pairs(sourceChar.DynamicStats) do
	-- 	print(i, v.Armor)
	-- end
	--print(string.format("Dupe(%s) MaxArmor(%i) BaseMaxArmor(%i) MaxMagicArmor(%i) BaseMaxMagicArmor(%i) CurrentArmor(%i) CurrentMagicArmor(%i)", dupe, targetChar.MaxArmor, targetChar.BaseMaxArmor, targetChar.MaxMagicArmor, targetChar.BaseMaxMagicArmor, targetChar.CurrentArmor, targetChar.CurrentMagicArmor))
	--print(string.format("Dupe(%s) CurrentVitality(%i) MaxVitality(%i) BaseMaxVitality(%i)", dupe, targetChar.CurrentVitality, targetChar.MaxVitality, targetChar.BaseMaxVitality))
end