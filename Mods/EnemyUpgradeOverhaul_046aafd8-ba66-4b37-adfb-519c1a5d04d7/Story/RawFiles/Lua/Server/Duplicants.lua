
function Duplication_CopySource(source,dupe)
	---@type EsvCharacter
	local sourceCharacter = Ext.GetCharacter(source)
	-- for i,slot in LeaderLib.Data.VisibleEquipmentSlots:Get() do
	-- 	local item = CharacterGetEquippedItem(source, slot)
	-- 	if item ~= nil then
	-- 		NRD_ItemCloneBegin(item)
	-- 		local clone = NRD_ItemClone()
	-- 		CharacterEquipItem(dupe, clone)
	-- 	end
	-- end
	pcall(Duplication_CopyTalents, source, dupe)
	pcall(Duplication_CopySourceStats, source, dupe, sourceCharacter.Stats.Name)
	Duplication_CopyName(source, dupe)
	Duplication_CopyCP(source, dupe)
	ClearGain(dupe)
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
end

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
	"Hearing",
	"APMaximum",
	"APStart",
	"APRecovery",
	"CriticalChance",
	"Initiative",
	"Vitality",
	--"VitalityBoost",
	"MagicPoints",
	"Armor",
	"MagicArmor",
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

function Duplication_CopySourceStats(source,dupe,baseStat)
	--local sourceCharStat = Ext.GetCharacter(source).Stats.Name
	-- SetVarFixedString(dupe, "LLENEMY_Dupe_Stats", sourceCharStat)
	-- LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:Duplication_CopySourceStat] Copying stat " .. tostring(sourceCharStat) .." to dupe ("..dupe..").")
	-- SetStoryEvent(dupe, "LLENEMY_ApplyStats")
	local dupeBaseStat = Ext.GetCharacter(dupe).Stats.Name
	for i,boost in ipairs(CopyBoosts) do
		local baseSource = Ext.StatGetAttribute(baseStat, boost)
		local baseDupe = Ext.StatGetAttribute(dupeBaseStat, boost)
		--local baseDupe = NRD_CharacterGetPermanentBoostInt(dupe, boost)
		if baseSource ~= nil and baseDupe ~= nil then
			if baseDupe < baseSource then
				local next = baseSource - baseDupe
				NRD_CharacterSetPermanentBoostInt(dupe, boost, next)
				--PrintDebug("Set", boost, "to", next, "for", dupe, "from", baseDupe)
			end
		end
	end
	for i,stat in LeaderLib.Data.Attribute:Get() do
		local baseSource = CharacterGetBaseAttribute(source, stat)
		local baseDupe = CharacterGetBaseAttribute(dupe, stat)
		if baseDupe ~= nil and baseSource ~= nil and baseDupe < baseSource then
			local next = baseSource - baseDupe
			CharacterAddAttribute(dupe, stat, next)
			--PrintDebug("Set", stat, "to", next, "for", dupe, "from", baseDupe)
		end
	end
	for i,stat in LeaderLib.Data.Ability:Get() do
		local baseSource = CharacterGetBaseAbility(source, stat)
		local baseDupe = CharacterGetBaseAbility(dupe, stat)
		if baseDupe ~= nil and baseSource ~= nil and baseDupe < baseSource then
			local next = baseSource - baseDupe
			CharacterAddAbility(dupe, stat, next)
			--PrintDebug("Set", stat, "to", next, "for", dupe, "from", baseDupe)
		end
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

local function IgnoreStatus(status)
	if LeaderLib.Data.EngineStatus[status] == true then
		return true
	end
	if IgnoredDuplicantStatuses[status] == true then
		return true
	end
	if string.find(status, "LLENEMY_DUPE") or string.find(status, "QUEST") then
		return true
	end
	return false
end

function Duplication_CopyStatus(source,dupe,status,handlestr)
	if not StatusHasAura(status) and not IgnoreStatus(status) and HasActiveStatus(dupe, status) == 0 then
		local handle = math.tointeger(handlestr)
		local duration = NRD_StatusGetReal(source, handle, "CurrentLifeTime")
		local statusSourceHandle = NRD_StatusGetGuidString(source, handle, "StatusSourceHandle")
		if statusSourceHandle == nil or statusSourceHandle == source then 
			statusSourceHandle = dupe
		end
		Osi.LLENEMY_Duplication_CopyStatus(source, dupe, status, duration, statusSourceHandle)
	end
end