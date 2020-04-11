local ATTEMPTS_MAX = 40

local ignored_skills = {
	Cone_EnemyCorrosiveSpray_Beetle = true,
	Cone_EnemyFlamebreath_Salamander = true,
	Cone_EnemyGroundSmash_Statue = true,
	Cone_EnemyGroundSmash_Troll = true,
	Cone_EnemySilencingStare_Bat = true,
	Cone_EnemySilencingStare_LowVolume = true,
	Cone_EnemySilencingStare_Wolf = true,
	Cone_Enemy_WaterSpit_Troll = true,
	Jump_EnemyVoidGlide = true,
	Jump_EnemyCurseDive = true,
	Jump_EnemyCurseDive_Braccus = true,
	Jump_EnemyCurseDive_Kraken = true,
	Jump_EnemyPhoenixDive_Shambling = true,
	Jump_EnemyPhoenixDive_Shambling_Boss = true,
	Jump_EnemySpiderBurrow = true,
	Jump_EnemyTacticalRetreat_Frog = true,
	Jump_EnemyTacticalRetreat_Mordus = true,
	MultiStrike_EnemyVault_ArenaChampion = true,
	ProjectileStrike_EnemyMeteorShower_CombatMeteorScript = true,
	ProjectileStrike_EnemyMeteorShower_Windego = true,
	Projectile_ChainHeal_Horrorsleep = true,
	Projectile_EnemyBeetleDart = true,
	Projectile_EnemyBeetleDart_Poison = true,
	Projectile_EnemyBloodSpit_Explo = true,
	Projectile_EnemyBloodSpit_Heart = true,
	Projectile_EnemyChainHeal_Mothertree = true,
	Projectile_EnemyChainLightning_Lucian = true,
	Projectile_EnemyDustBlast_Scarecrow = true,
	Projectile_EnemyEarthShard_Knockdown = true,
	Projectile_EnemyEarthShard_Scarecrow = true,
	Projectile_EnemyEarthShard_Scarecrow_Single = true,
	Projectile_EnemyFireball_Cursed_Insect = true,
	Projectile_EnemyFireball_Witch = true,
	Projectile_EnemyFlare_Beetle = true,
	Projectile_EnemyFlight_Ooze = true,
	Projectile_EnemyFlight_Ooze_Fire = true,
	Projectile_EnemyFlight_Ooze_Poison = true,
	Projectile_EnemyFlight_Wolf = true,
	Projectile_EnemyFrog_Air = true,
	Projectile_EnemyInfectiousBlood_Bat = true,
	Projectile_EnemyLightningBolt_Frog = true,
	Projectile_EnemyMessengerOwl = true,
	Projectile_EnemyPoisonball_Acid = true,
	Projectile_EnemyPoisonball_Troll = true,
	Projectile_EnemyTotemAir = true,
	Projectile_EnemyTotemBlood = true,
	Projectile_EnemyTotemBone = true,
	Projectile_EnemyTotemFire = true,
	Projectile_EnemyTotemOil = true,
	Projectile_EnemyTotemPoison = true,
	Projectile_EnemyTotemWater = true,
	Projectile_EnemyTotemWood = true,
	Projectile_EnemyVWPoisonBall = true,
	Projectile_TotemKillingSpell = true,
	Projectile_TurretBallistaShot_LadyVengeance = true,
	Quake_EnemyEarthquake_Bear = true,
	Rain_EnemyBlood_Windego = true,
	Rain_EnemyRain_Short = true,
	Rain_EnemyWater_Blessed = true,
	Rush_EnemyBatteringRam_Demons = true,
	Rush_EnemyTurtleBatteringRam = true,
	Shout_ChainPull = true,
	Shout_EnemyBoneCage_Dog = true,
	Shout_EnemyChameleonSkin_PurgedDaughter = true,
	Shout_EnemyContamination_Shambling = true,
	Shout_EnemyFear_Scarecrow = true,
	Shout_EnemyFear_Wolf = true,
	Shout_EnemyIgnition_Troll = true,
	Shout_EnemyInspire = true,
	Storm_EnemyLightning_MotherTree = true,
	Summon_EnemyBoneTroll = true,
	Summon_EnemyBoneTroll_Dog = true,
	Summon_EnemyBoneTroll_Mini = true,
	Summon_EnemyDemon_Doctor = true,
	Summon_EnemyDog_Doctor = true,
	Summon_EnemyHeart_Doctor = true,
	Summon_EnemyShamblingMound_Caster = true,
	Summon_EnemyShamblingMound_Melee = true,
	Summon_EnemyShamblingMound_Ranger = true,
	Summon_EnemySkeleton_Archer = true,
	Summon_EnemySkeleton_Archer_Dog = true,
	Summon_EnemySkeleton_Regular = true,
	Summon_EnemySkeleton_Strong = true,
	Summon_EnemySkeleton_Weak = true,
	Summon_EnemyTotemFromSurface = false,
	Summon_EnemyTotem_Blood = true,
	Summon_EnemyTotem_Fire_Witch = true,
	Summon_EnemyTotem_Poison = true,
	Summon_EnemyZombie_Blood = true,
	Target_Debug_KillCommand = true,
	Target_EnemyBless_Alexandar = true,
	Target_EnemyBless_Lucian = true,
	Target_EnemyBloatedCorpse_Dog = true,
	Target_EnemyBloodBubble_Heart = true,
	Target_EnemyCleanseWounds_Troll = true,
	Target_EnemyCorpseExplosion_Bat = true,
	Target_EnemyCorpseExplosion_Heart = true,
	Target_EnemyCorrosiveTouch_Dog = true,
	Target_EnemyCorrosiveTouch_Heart = true,
	Target_EnemyCorruptedBlade_Gheist = true,
	Target_EnemyCripplingBlow_Shambling = true,
	Target_EnemyCripplingBlow_Shambling_Boss = true,
	Target_EnemyCripplingBlow_Wolf = true,
	Target_EnemyCurse_Werewolf = true,
	Target_EnemyCurse_Witch = true,
	Target_EnemyDeathWish_Dog = true,
	Target_EnemyDecayingTouch_Heart = true,
	Target_EnemyDeepDwellerShacklesOfPain = true,
	Target_EnemyDemonicConsume = true,
	Target_EnemyDemonicMadness_Heart = true,
	Target_EnemyEnrage_Wolf = true,
	Target_EnemyFortify_Shambling = true,
	Target_EnemyGagOrder_Gheist = true,
	Target_EnemyHaste_Wolf = true,
	Target_EnemyMosquitoSwarm_Special = true,
	Target_EnemyOverpower_Shambling = true,
	Target_EnemyOverpower_Werewolf = true,
	Target_EnemyRestoration_Horrorsleep = true,
	Target_EnemyResurrect_Alan = true,
	Target_EnemyResurrect_Alexandar = true,
	Target_EnemyShacklesOfPain_LowVolume = true,
	Target_EnemyTargetedFireSurface_Lucian = true,
	Target_EnemyTerrifyingCruelty_Gheist = true,
	Target_EnemyVacuumTouch_Heart = true,
	Target_EnemyVacuum_SilentMonk = true,
	Target_EnemyWormTremor_MotherTree = true,
	Target_NULLSKILL = true,
	Teleportation_EnemyFeatherFallSelf_Lucian = true,
	Teleportation_EnemyFeatherFallSelf_SkeletonMage = true,
	Teleportation_EnemyFreeFall_Werewolf = true,
	Teleportation_EnemyInsectBurrow = true,
	Teleportation_EnemyMagisterTorturerTeleport = true,
	Teleportation_EnemyNetherswap_Heart	 = true,
	Teleportation_EnemyResurrect_Alan = true,
	Teleportation_EnemyResurrect_Alexandar = true,
	Teleportation_EnemyResurrect_Chicken = true,
	Teleportation_EnemyResurrect_Shambling = true,
	Teleportation_EnemyResurrect_Werewolf = true,
	Teleportation_ResurrectScroll = true,
	Teleportation_StoryModeFreeResurrect = true,
	Cone_EnemyDragonBreath = true,
	Cone_EnemyDragonBreath_Ice = true,
	Cone_EnemyDragonBreath_Air = true,
	Cone_EnemyGroundSmash_Dragon = true,
	Jump_DragonDive = true,
	Projectile_DragonFlight = true,
	Projectile_DragonFlight_Newt = true,
	Projectile_EnemyDragon_Air = true,
	Shout_EnemyDragonWhirlwind = true,
	Target_EnemyTerrify_Dragon = true,
	Shout_EnemyVileBurst = true, -- Kills the caster. Bad!,
	--Target_BanishSummon = true,
	-- Summoning Rework
	Summon_EnemySoulWolf = true,
	Summon_EnemyBear = true,
	Summon_EnemyCrawlingTrunk_Melee = true,
	Summon_EnemyBoneTroll_BoneWalker = true,
	Summon_EnemyBoneHand__BoneWalker = true,
}

local ignored_skillwords = {
	"Arrow",
	"Burrow",
	"CakeBomber",
	"Debug",
	"Drillworm",
	"Dummy",
	"EnemyStaffOfMagus",
	"SilentMonk",
	"Hound",
	"Invulnerability",
	"LLENEMY",
	"Projectile_Grenade_",
	"Projectile_Incarnate",
	"QUEST",
	"Quest",
	"SourceVampirism",
	"Suicide",
	"TEST",
	"Talent",
	"Trap",
	"Turret",
	"_Adrama",
	"_Alan",
	"Explosion",
	"_Item_",
	"_Kraken_",
	"_LLMIME_",
	"_LeaderLib_",
	"_Newt",
	"_Ooze",
	"_Puppet",
	"_Status_",
}

local redirected_skills = {
	Rain_Oil = "Rain_LLENEMY_EnemyOil"
}

EnemyUpgradeOverhaul.IgnoredSkills = ignored_skills
EnemyUpgradeOverhaul.IgnoredWords = ignored_skillwords

---@class SkillEntry
local SkillEntry = {
	id = "",
	requirement = "None",
	sp = 0,
	tier = "None"
}

SkillEntry.__index = SkillEntry

function SkillEntry:Create(id, requirement, sp, tier)
    local this =
    {
		id = id,
		requirement = requirement,
		sp = sp,
		tier = tier
	}
	setmetatable(this, self)
    return this
end

function SkillEntry:WithinLevelRange(level)
	local tier = self.tier
	if tier == "Starter" or tier == "" or tier == "None" then
		return true
	elseif tier == "Novice" and level >= 4 then
		return true
	elseif tier == "Adept" and level >= 9 then
		return true
	elseif tier == "Master" and level >= 16 then
		return true
	end
	return false
end

local function IgnoreSkillRequirement(requirement)
	if type(requirement) == "string" then
		if requirement == "" or requirement == "None" then
			return true
		end
	elseif type(requirement) == "table" then
		for _,v in pairs(requirement) do
			if v == "" or v == "None" or v == nil then
				return true
			end
		end
	end
	return requirement == nil
end

---@class SkillGroup
local SkillGroup = {
	id = "None",
	ability = "None",
	skills = {}
}

SkillGroup.__index = SkillGroup

function SkillGroup:Create(abilityname, skillability)
    local this =
    {
		id = abilityname,
		ability = skillability,
		skills = {}
	}
	setmetatable(this, self)
    return this
end

---@param skill SkillEntry
---@return SkillGroup
function SkillGroup:Add(skill)
	self.skills[#self.skills+1] = skill
	return self
end

---Get a random skill from a SkillGroup, matching the preferred requirement.
---@param requirement string
---@return SkillEntry
function SkillGroup:GetRandomSkill(enemy, requirement, level, sourceAllowed)
	local available_skills = {}
	
	for _,skill in pairs(self.skills) do
		if CharacterHasSkill(enemy, skill.id) ~= 1 and skill:WithinLevelRange(level) then
			if IgnoreSkillRequirement(requirement) or IgnoreSkillRequirement(skill.requirement) then
				if (skill.sp == 0 or sourceAllowed > 0) then 
					available_skills[#available_skills+1] = skill
				end
			else
				if type(requirement) == "string" then
					if requirement == skill.requirement then
						if (skill.sp == 0 or sourceAllowed > 0) then 
							available_skills[#available_skills+1] = skill
						end
					end
				elseif type(requirement) == "table" then
					for _,v in pairs(requirement) do
						if v == skill.requirement then
							if (skill.sp == 0 or sourceAllowed > 0) then 
								available_skills[#available_skills+1] = skill
							end
						end
					end
				end
			end
		end
	end
	--LeaderLib.Print("[LLENEMY_BonusSkills.lua:GetRandomSkill] ---- Getting random skill from table count (".. tostring(#available_skills) ..") self.skills("..tostring(#self.skills)..") self.id("..tostring(#self.id)..").")
	--LeaderLib.Print("[LLENEMY_BonusSkills.lua:GetRandomSkill] ---- ("..tostring(LeaderLib.Common.Dump(available_skills))..").")
	return LeaderLib.Common.GetRandomTableEntry(available_skills)
end

---@param ability string
---@return SkillGroup
local function GetSkillGroup(self, ability)
	for _,v in pairs(self) do
		if v.ability == ability then return v end
	end
	return nil
end

local function IgnoreSkill(skill)
	if ignored_skills[skill] == false then return false end
	if ignored_skills[skill] == true then return true end
	if string.sub(skill,1,1) == "_" then
		return true
	end
	for _,word in pairs(ignored_skillwords) do
		if string.find(skill, word) then return true end
	end
	return false
end

local AIFLAG_CANNOT_USE = 140689826905584

function LLENEMY_Ext_BuildEnemySkills()
	EnemyUpgradeOverhaul.EnemySkills = {
		SkillGroup:Create("None", "None"),
		SkillGroup:Create("WarriorLore", "Warrior"),
		SkillGroup:Create("RangerLore", "Ranger"),
		SkillGroup:Create("RogueLore", "Rogue"),
		SkillGroup:Create("AirSpecialist", "Air"),
		SkillGroup:Create("EarthSpecialist", "Earth"),
		SkillGroup:Create("FireSpecialist", "Fire"),
		SkillGroup:Create("WaterSpecialist", "Water"),
		SkillGroup:Create("Necromancy", "Death"),
		SkillGroup:Create("Polymorph", "Polymorph"),
		SkillGroup:Create("Summoning", "Summoning"),
		SkillGroup:Create("Sourcery", "Source"),
	}
	local skills = Ext.GetStatEntries("SkillData")
	for k,skill in pairs(skills) do
		if redirected_skills[skill] ~= nil then
			local swapped_skill = redirected_skills[skill]
			LeaderLib.Print("[LLENEMY_BonusSkills.lua] Swapping skill '" .. tostring(skill) .. "' for '"..swapped_skill .. "'")
			skill = swapped_skill
		end
		local isenemy = Ext.StatGetAttribute(skill, "IsEnemySkill")
		local aiflags = Ext.StatGetAttribute(skill, "AIFlags")
		if aiflags ~= AIFLAG_CANNOT_USE and (isenemy == "Yes" and string.find(skill, "Enemy")) and not IgnoreSkill(skill) then
			local ap = Ext.StatGetAttribute(skill, "ActionPoints")
			local cd = Ext.StatGetAttribute(skill, "Cooldown")
			
			if ap > 0 or cd > 0 then
				local ability = Ext.StatGetAttribute(skill, "Ability")
				local requirement = Ext.StatGetAttribute(skill, "Requirement")
				local sp = Ext.StatGetAttribute(skill, "Magic Cost")
				if sp == nil then sp = 0 end
				local tier = Ext.StatGetAttribute(skill, "Tier")
				local skillgroup = GetSkillGroup(EnemyUpgradeOverhaul.EnemySkills, ability)
				if skillgroup ~= nil then
					skillgroup:Add(SkillEntry:Create(skill, requirement, sp, tier))
					LeaderLib.Print("[LLENEMY_BonusSkills.lua] Added enemy skill '" .. tostring(skill) .. "' to group (".. skillgroup.ability .."). Requirement(".. tostring(requirement) ..") SP(".. tostring(sp) ..")")
					--LeaderLib.Print(tostring(skill))
				end
			end
		end
	end
end

local function GetHighestAbility(enemy)
	local last_highest_ability = "None"
	local last_highest_val = 0
	for _,skillgroup in pairs(EnemyUpgradeOverhaul.EnemySkills) do
		if skillgroup.id ~= "None" then
			local ability_val = CharacterGetAbility(enemy, tostring(skillgroup.id))
			---LeaderLib.Print("[LLENEMY_BonusSkills.lua:GetHighestAbility] ---- Ability (" .. tostring(skillgroup.id) .. ") = ("..tostring(ability_val)..")")
			if ability_val ~= nil and ability_val > 0 and ability_val > last_highest_val then
				last_highest_ability = skillgroup.id
				last_highest_val = ability_val
			end
		end
	end
	return last_highest_ability
end

local weapontype_requirements = {
	Sword = "MeleeWeapon",
	Club = "MeleeWeapon",
	Axe = "MeleeWeapon",
	Knife = {"DaggerWeapon", "MeleeWeapon"},
	Spear = "MeleeWeapon",
	Staff = {"StaffWeapon", "MeleeWeapon"},
	Bow = "RangedWeapon",
	Crossbow = "RangedWeapon",
	--Wand = {"MeleeWeapon"},
}

---@class WeaponRequirementFlag
local WeaponRequirementFlag = {
	flag = "",
	requirements = "None",
}

WeaponRequirementFlag.__index = WeaponRequirementFlag

function WeaponRequirementFlag:Create(flag, requirements)
    local this =
    {
		flag = flag,
		requirements = requirements
	}
	setmetatable(this, self)
    return this
end

local weapontype_requirements_flags = {}
weapontype_requirements_flags[#weapontype_requirements_flags+1] = WeaponRequirementFlag:Create("LeaderLib_SkillRequirement_DaggerWeapon", {"DaggerWeapon", "MeleeWeapon"})
weapontype_requirements_flags[#weapontype_requirements_flags+1] = WeaponRequirementFlag:Create("LeaderLib_SkillRequirement_StaffWeapon", {"StaffWeapon", "MeleeWeapon"})
weapontype_requirements_flags[#weapontype_requirements_flags+1] = WeaponRequirementFlag:Create("LeaderLib_SkillRequirement_MeleeWeapon", "MeleeWeapon")
weapontype_requirements_flags[#weapontype_requirements_flags+1] = WeaponRequirementFlag:Create("LeaderLib_SkillRequirement_RangedWeapon", "RangedWeapon")
--weapontype_requirements_flags[#weapontype_requirements_flags+1] = WeaponRequirementFlag:Create("LeaderLib_SkillRequirement_WandWeapon", "WandWeapon")


local function GetWeaponRequirement(enemy)
	for i,v in pairs(weapontype_requirements_flags) do
		if ObjectGetFlag(enemy, v.flag) == 1 then
			return v.requirements
		end
	end
	--[[ local weapon = CharacterGetEquippedWeapon(enemy)
	if weapon ~= nil then
		local stat = NRD_ItemGetStatsId(weapon)
		local weapontype = NRD_StatGetString(stat, "WeaponType")
		local req_entry = weapontype_requirements[weapontype]
		if req_entry ~= nil then
			return req_entry
		end
	end ]]
	return "None"
end

local function GetPreferredSkillGroup(ability,requirement,lastgroup)
	--LeaderLib.Print("EnemyUpgradeOverhaul.EnemySkills count: " .. tostring(#EnemyUpgradeOverhaul.EnemySkills) .. " | Looking for " .. ability)
	if ability ~= "None" and (lastgroup == nil or lastgroup ~= nil and lastgroup.id ~= ability) then
		for k,v in pairs(EnemyUpgradeOverhaul.EnemySkills) do
			if v.id == ability or v.ability == ability then return v end
		end
	else
		local attempts = 0
		while attempts < 20 do
			local rantable = LeaderLib.Common.GetRandomTableEntry(EnemyUpgradeOverhaul.EnemySkills)
			if rantable ~= nil then
				local ranskill = LeaderLib.Common.GetRandomTableEntry(rantable.skills)
				if ranskill.requirement == "None" then
					return rantable
				end
				if type(requirement) == "string" and ranskill.requirement == requirement then
					--LeaderLib.Print("[LLENEMY_BonusSkills.lua:GetPreferredSkillGroup] ---- Matched skill (" .. tostring(ranskill.id) .. ") to requirement ("..requirement..") for group ("..rantable.id..")")
					return rantable
				elseif type(requirement) == "table" then
					for k,v in pairs(requirement) do
						if v == ranskill.requirement then
							--LeaderLib.Print("[LLENEMY_BonusSkills.lua:GetPreferredSkillGroup] ---- Matched skill (" .. tostring(ranskill.id) .. ") to requirement ("..v..") for group ("..rantable.id..")")
							return rantable
						end
					end
				end
			end
			attempts = attempts + 1
		end
	end
	return nil
end

function LLENEMY_Ext_AddBonusSkills(enemy,remainingstr,source_skills_remainingstr)
	local remaining = math.max(tonumber(remainingstr), 1)
	local source_skills_remaining = math.max(tonumber(source_skills_remainingstr), 0)
	local preferred_ability = GetHighestAbility(enemy)
	local preferred_requirement = GetWeaponRequirement(enemy)
	--local sp_max = CharacterGetMaxSourcePoints(enemy)
	local level = CharacterGetLevel(enemy)

	LeaderLib.Print("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' preferred Ability (".. tostring(preferred_ability) ..") Requirement (".. tostring(LeaderLib.Common.Dump(preferred_requirement)) ..") Bonus Skills ("..tostring(remaining)..") Source Skills ("..tostring(source_skills_remaining)..").")
	local skillgroup = GetPreferredSkillGroup(preferred_ability, preferred_requirement, nil)
	if skillgroup == nil then
		LeaderLib.Print("[LLENEMY_BonusSkills.lua] -- Can't get a skillgroup for Enemy '" .. tostring(enemy) .. "'. Skipping.")
		return false
	end
	local attempts = 0
	while remaining > 0 and attempts < ATTEMPTS_MAX do
		local success = false
		local skill = skillgroup:GetRandomSkill(enemy, preferred_requirement, level, source_skills_remaining)
		if skill ~= nil then
			if skill.sp > 0 then
				source_skills_remaining = source_skills_remaining - 1
			end
			LeaderLib.Print("[LLENEMY_BonusSkills.lua] -- Adding skill (".. tostring(skill.id) ..") to enemy '" .. tostring(enemy) .. "'.")
			CharacterAddSkill(enemy, skill.id, 0)
			success = true
		end

		if success == true then
			remaining = remaining - 1
		--- Get another random skillgroup when no preference is set
			if remaining > 0 and preferred_ability == "None" then
				local nextskillgroup = GetPreferredSkillGroup(preferred_ability, preferred_requirement, skillgroup)
				if nextskillgroup ~= nil then
					skillgroup = nextskillgroup
				end
			end
		end

		attempts = attempts + 1
	end
	if attempts >= ATTEMPTS_MAX then
		LeaderLib.Print("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' hit the maximum amount of random attempts when getting a skill from group ("..skillgroup.id..").")
	end
end