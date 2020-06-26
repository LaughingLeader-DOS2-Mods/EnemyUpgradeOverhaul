
function Duplication_CopySource(source,dupe)
	local sourceCharacter = Ext.GetCharacter(source)
	-- for i,slot in LeaderLib.Data.VisibleEquipmentSlots:Get() do
	-- 	local item = CharacterGetEquippedItem(source, slot)
	-- 	if item ~= nil then
	-- 		NRD_ItemCloneBegin(item)
	-- 		local clone = NRD_ItemClone()
	-- 		CharacterEquipItem(dupe, clone)
	-- 	end
	-- end
	Duplication_CopySourceStats(source, dupe, sourceCharacter.Stats.Name)
	Osi.LeaderLib_Helper_CopyTalents(dupe, source)
	Duplication_CopyName(source, dupe)
	Duplication_CopyCP(source, dupe)
	ClearGain(dupe)
	NRD_CharacterIterateSkills(source, "LLENEMY_Dupe_CopySkill")
	Osi.LLENEMY_Duplication_Internal_SetupDupe_StageTwo(source, dupe)

	-- ---@type EsvCharacter
	-- local sourceChar = Ext.GetCharacter(source)
	local dupeChar = Ext.GetCharacter(dupe)
	
	print("Dupe level| Source:",source, CharacterGetLevel(source), sourceCharacter.Stats.Level, sourceCharacter.Stats.Name, "Dupe:", dupe, CharacterGetLevel(dupe), dupeChar.Stats.Level, dupeChar.Stats.Name)

	for i,tag in pairs(sourceCharacter:GetTags()) do
		SetTag(dupe, tag)
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
	"ShadowResistance",
	"PiercingResistance",
	"PhysicalResistance",
	"CorrosiveResistance",
	"MagicResistance",
	"CustomResistance",
	"MaxResistance",
	"Sight",
	"Hearing",
	"APMaximum",
	"APStart",
	"APRecovery",
	"CriticalChance",
	"Initiative",
	"Vitality",
	"VitalityBoost",
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
	"LifeSteal",
	"Weight",
	"ChanceToHitBoost",
	"RangeBoost",
	"APCostBoost",
	"SPCostBoost",
	"MaxSummons",
	"BonusWeaponDamageMultiplier",
}

function Duplication_CopySourceStats(source,dupe,baseStat)
	--local sourceCharStat = Ext.GetCharacter(source).Stats.Name
	-- SetVarFixedString(dupe, "LLENEMY_Dupe_Stats", sourceCharStat)
	-- LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:Duplication_CopySourceStat] Copying stat " .. tostring(sourceCharStat) .." to dupe ("..dupe..").")
	-- SetStoryEvent(dupe, "LLENEMY_ApplyStats")
	for i,boost in ipairs(CopyBoosts) do
		local baseSource = Ext.StatGetAttribute(baseStat, boost)
		if baseSource ~= nil then
			local baseDupe = NRD_CharacterGetPermanentBoostInt(dupe, boost)
			if baseDupe < baseSource then
				local next = baseSource - baseDupe
				NRD_CharacterSetPermanentBoostInt(dupe, boost, next)
				print("Set", boost, "to", next, "for", dupe)
			end
		end
	end
	for i,stat in LeaderLib.Data.Attribute:Get() do
		local baseSource = CharacterGetBaseAttribute(source, stat)
		local baseDupe = CharacterGetBaseAttribute(dupe, stat)
		if baseDupe < baseSource then
			CharacterAddAttribute(dupe, stat, baseSource - baseDupe)
		end
	end
	for i,stat in LeaderLib.Data.Ability:Get() do
		local baseSource = CharacterGetBaseAbility(source, stat)
		local baseDupe = CharacterGetBaseAbility(dupe, stat)
		if baseDupe < baseSource then
			CharacterAddAbility(dupe, stat, baseSource - baseDupe)
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

function Duplication_CopyStatus(source,dupe,status,handlestr)
	if not StatusHasAura(status) and HasActiveStatus(dupe, status) == 0 then
		local handle = math.tointeger(handlestr)
		local duration = NRD_StatusGetReal(source, handle, "CurrentLifeTime")
		local statusSourceHandle = NRD_StatusGetGuidString(source, handle, "StatusSourceHandle")
		if statusSourceHandle == nil or statusSourceHandle == source then 
			statusSourceHandle = dupe
		end
		Osi.LLENEMY_Duplication_CopyStatus(source, dupe, status, duration, statusSourceHandle)
	end
end