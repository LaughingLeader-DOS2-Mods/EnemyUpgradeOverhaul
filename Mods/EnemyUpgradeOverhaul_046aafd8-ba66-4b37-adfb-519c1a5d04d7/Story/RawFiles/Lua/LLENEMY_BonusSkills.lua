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

---Get a random skill from a SkillGroup, matching the preferred requirement.
---@param requirement string
---@return SkillEntry
function SkillGroup:GetRandom(enemy, requirement)
	local attempts = 0
	local max = #self.skills*2
	while attempts < (#self.skills*2) do
		local skill = LeaderLib.Common.GetRandomTableEntry(self.skills)
		if CharacterHasSkill(enemy, skill) ~= 1 and (requirement == "None" or requirement == skill.requirement or attempts >= max-1) then
			return skill
		end
		attempts = attempts + 1
	end
	return nil
end

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

local EnemySkills = {}
EnemySkills[#EnemySkills+1] = SkillGroup:Create("None", "None")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("WarriorLore", "Warrior")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("RangerLore", "Ranger")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("RogueLore", "Rogue")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("AirSpecialist", "Air")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("EarthSpecialist", "Earth")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("FireSpecialist", "Fire")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("WaterSpecialist", "Water")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("Necromancy", "Death")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("Polymorph", "Polymorph")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("Summoning", "Summoning")
EnemySkills[#EnemySkills+1] = SkillGroup:Create("Sourcery", "Source")

local function GetSkillGroup(ability)
	for _,v in pairs(EnemySkills) do
		if v.ability == ability then return v end
	end
	return nil
end

local ignored_skills = {
	Cone_EnemyCorrosiveSpray_Beetle = true,
	Cone_EnemyFlamebreath_Salamander = true,
	Cone_EnemyGroundSmash_Dragon = true,
	Cone_EnemyGroundSmash_Statue = true,
	Cone_EnemyGroundSmash_Troll = true,
	Cone_EnemySilencingStare_Bat = true,
	Cone_EnemySilencingStare_LowVolume = true,
	Cone_EnemySilencingStare_Wolf = true,
	Cone_Enemy_WaterSpit_Troll = true,
	Jump_EnemyCurseDive_Braccus = true,
	Jump_EnemyCurseDive_Kraken = true,
	Jump_EnemyPhoenixDive_Shambling = true,
	Jump_EnemyPhoenixDive_Shambling_Boss = true,
	Jump_EnemyTacticalRetreat_Frog = true,
	Jump_EnemyTacticalRetreat_Mordus = true,
	MultiStrike_EnemyVault_ArenaChampion = true,
	ProjectileStrike_EnemyMeteorShower_CombatMeteorScript = true,
	ProjectileStrike_EnemyMeteorShower_Windego = true,
	Projectile_ChainHeal_Horrorsleep = true,
	Projectile_EnemyBeetleDart_Poison = true,
	Projectile_EnemyBloodSpit_Explo = true,
	Projectile_EnemyBloodSpit_Heart = true,
	Projectile_EnemyChainHeal_Mothertree = true,
	Projectile_EnemyChainLightning_Lucian = true,
	Projectile_EnemyDragon_Air = true,
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
	Projectile_EnemyPoisonball_Acid = true,
	Projectile_EnemyPoisonball_Troll = true,
	Projectile_TurretBallistaShot_LadyVengeance = true,
	Quake_EnemyEarthquake_Bear = true,
	Rain_EnemyBlood_Windego = true,
	Rain_EnemyRain_Short = true,
	Rain_EnemyWater_Blessed = true,
	Rush_EnemyBatteringRam_Demons = true,
	Shout_EnemyBoneCage_Dog = true,
	Shout_EnemyChameleonSkin_PurgedDaughter = true,
	Shout_EnemyContamination_Shambling = true,
	Shout_EnemyFear_Scarecrow = true,
	Shout_EnemyFear_Wolf = true,
	Shout_EnemyIgnition_Troll = true,
	Storm_EnemyLightning_MotherTree = true,
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
	Target_EnemyTerrify_Dragon = true,
	Target_EnemyTerrifyingCruelty_Gheist = true,
	Target_EnemyVacuumTouch_Heart = true,
	Target_EnemyVacuum_SilentMonk = true,
	Target_EnemyWormTremor_MotherTree = true,
	Teleportation_EnemyFeatherFallSelf_Lucian = true,
	Teleportation_EnemyFeatherFallSelf_SkeletonMage = true,
	Teleportation_EnemyFreeFall_Werewolf = true,
	Teleportation_EnemyNetherswap_Heart	 = true,
	Teleportation_EnemyResurrect_Alan = true,
	Teleportation_EnemyResurrect_Alexandar = true,
	Teleportation_EnemyResurrect_Chicken = true,
	Teleportation_EnemyResurrect_Shambling = true,
	Teleportation_EnemyResurrect_Werewolf = true,
	Teleportation_ResurrectScroll = true,
	Teleportation_StoryModeFreeResurrect = true,
	Target_NULLSKILL = true,
	Shout_ChainPull = true,
	Projectile_TotemKillingSpell = true,
	Teleportation_EnemyInsectBurrow = true,
	Teleportation_EnemyMagisterTorturerTeleport = true,
	Target_EnemyDeepDwellerShacklesOfPain = true,
}

local ignored_skillwords = {
	"Debug",
	"Dummy",
	"EnemyHound",
	"EnemyStaffOfMagus",
	"Invulnerability",
	"LLENEMY",
	"Projectile_Grenade_",
	"Projectile_Incarnate",
	"QUEST",
	"Quest",
	"SourceVampirism",
	"Suicide",
	"Talent",
	"_Adrama",
	"_Alan",
	"_Explosion",
	"_Item_",
	"_Kraken_",
	"_LeaderLib_",
	"_Newt",
	"_Ooze",
	"_Puppet",
	"_Status_",
	"_LLMIME_",
	"Trap",
	"TEST",
	"Turret",
	"Arrow",
}

local function IgnoreSkill(skill)
	if ignored_skills[skill] == true then return true end
	if string.sub(skill,1,1) == "_" then
		return true
	end
	for _,word in pairs(ignored_skillwords) do
		if string.find(skill, word) then return true end
	end
	return false
end

function LLENEMY_Ext_BuildEnemySkills()
	local skills = Ext.GetStatEntries("SkillData")
	for k,skill in pairs(skills) do
		local isenemy = Ext.StatGetAttribute(skill, "IsEnemySkill")
		if (isenemy == "Yes" and string.find(skill, "Enemy")) and not IgnoreSkill(skill) then
			local ap = Ext.StatGetAttribute(skill, "ActionPoints")
			local cd = Ext.StatGetAttribute(skill, "Cooldown")
			
			if ap > 0 or cd > 0 then
				local ability = Ext.StatGetAttribute(skill, "Ability")
				local requirement = Ext.StatGetAttribute(skill, "Requirement")
				local sp = Ext.StatGetAttribute(skill, "Magic Cost")
				local tier = Ext.StatGetAttribute(skill, "Tier")
				local skillgroup = GetSkillGroup(ability)
				if skillgroup ~= nil then
					skillgroup.skills[#skillgroup.skills+1] = SkillEntry:Create(skill, requirement, sp, tier)
					--Ext.Print("[LLENEMY_BonusSkills.lua] Added enemy skill '" .. tostring(skill) .. "' to group (".. skillgroup.ability .."). Requirement(".. tostring(requirement) ..") SP(".. tostring(sp) ..")")
					Ext.Print(tostring(skill))
				end
			end
		end
	end
end

local function GetHighestAbility(enemy)
	local last_highest_ability = "None"
	local last_highest_val = 0
	for _,skillgroup in pairs(EnemySkills) do
		if skillgroup.id ~= "None" then
			local ability_val = CharacterGetAbility(enemy, tostring(skillgroup.id))
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

local function GetPreferredSkillGroup(ability,requirement)
	if ability ~= "None" then
		for k,v in pairs(EnemySkills) do
			if v.id == ability then return v end
		end
	else
		local attempts = 0
		while attempts < 20 do
			local rantable = LeaderLib.Common.GetRandomTableEntry(EnemySkills)
			if rantable ~= nil then
				local ranskill = LeaderLib.Common.GetRandomTableEntry(rantable.skills)
				if ranskill.requirement == "None" then
					return rantable
				end
				if type(requirement) == "string" and ranskill.requirement == requirement then
					Ext.Print("[LLENEMY_BonusSkills.lua:GetPreferredSkillGroup] ---- Matched skill (" .. tostring(ranskill.id) .. ") to requirement ("..requirement..") for group ("..rantable.id..")")
					return rantable
				elseif type(requirement) == "table" then
					for k,v in pairs(requirement) do
						if v == ranskill.requirement then
							Ext.Print("[LLENEMY_BonusSkills.lua:GetPreferredSkillGroup] ---- Matched skill (" .. tostring(ranskill.id) .. ") to requirement ("..v..") for group ("..rantable.id..")")
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
	local remaining = tostring(remainingstr)
	local source_skills_remaining = tostring(source_skills_remainingstr)
	local preferred_ability = GetHighestAbility(enemy)
	local preferred_requirement = GetWeaponRequirement(enemy)
	local sp_max = CharacterGetMaxSourcePoints(enemy)

	Ext.Print("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' preferred Ability (".. tostring(preferred_ability) ..") Requirement (".. tostring(LeaderLib.Common.Dump(preferred_requirement)) ..") Max SP ("..tostring(sp_max)..").")

	local skillgroup = GetPreferredSkillGroup(preferred_ability, preferred_requirement)
	if skillgroup == nil then
		Ext.Print("[LLENEMY_BonusSkills.lua] -- Can't get a skillgroup for Enemy '" .. tostring(enemy) .. "'. Skipping.")
		return false
	end
	local attempts = 0
	while remaining > 0 do
		local skill = skillgroup:GetRandom(enemy, preferred_requirement)
		if skill ~= nil then
			if skill.sp > 0 and source_skills_remaining > 0 then
				Ext.Print("[LLENEMY_BonusSkills.lua] -- Adding *SOURCE* skill (".. tostring(skill.id) ..") to enemy '" .. tostring(enemy) .. "'.")
				CharacterAddSkill(enemy, skill.id, 0)
				source_skills_remaining = source_skills_remaining - 1
				remaining = remaining - 1
			end
			if skill.sp == 0 then
				Ext.Print("[LLENEMY_BonusSkills.lua] -- Adding skill (".. tostring(skill.id) ..") to enemy '" .. tostring(enemy) .. "'.")
				CharacterAddSkill(enemy, skill.id, 0)
				remaining = remaining - 1
			else
				Ext.Print("[LLENEMY_BonusSkills.lua] -- Skipping source skill for '" .. tostring(enemy) .. "'.")
				attempts = attempts + 1
			end
		else 
			attempts = attempts + 1
		end
		if attempts >= 30 then
			Ext.Print("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' hit the maximum amount of random attempts when getting a skill from group ("..skillgroup.id..").")
			attempts = 0
			remaining = 0
		end
	end
end