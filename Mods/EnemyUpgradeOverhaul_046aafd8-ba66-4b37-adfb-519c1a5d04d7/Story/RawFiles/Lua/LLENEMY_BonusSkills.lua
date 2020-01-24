---@class SkillGroup
local SkillGroup = {
	ability = "None",
	skills = {}
}

SkillGroup.__index = SkillGroup

function SkillGroup:Create(ability)
    local this =
    {
		ability = ability,
		skills = {}
	}
	setmetatable(this, self)
    return this
end

---Get a random skill from a SkillGroup, matching the preferred requirement.
---@param requirement string
---@return SkillEntry
function SkillGroup:GetRandom(requirement)
	local attempts = 0
	while attempts < (#self.skills*2) do
		local skill = LeaderLib.Common.GetRandomTableEntry(self.skills)
		if requirement == "None" or requirement == skill.requirement then
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
	sp = 0
}

SkillEntry.__index = SkillEntry

function SkillEntry:Create(id, requirement, sp)
    local this =
    {
		id = id,
		requirement = requirement,
		sp = sp
	}
	setmetatable(this, self)
    return this
end

local EnemySkills = {
	None = SkillGroup:Create("None"),
	WarriorLore = SkillGroup:Create("Warrior"),
	RangerLore = SkillGroup:Create("Ranger"),
	RogueLore = SkillGroup:Create("Rogue"),
	AirSpecialist = SkillGroup:Create("Air"),
	EarthSpecialist = SkillGroup:Create("Earth"),
	FireSpecialist = SkillGroup:Create("Fire"),
	WaterSpecialist = SkillGroup:Create("Water"),
	Necromancy = SkillGroup:Create("Death"),
	Polymorph = SkillGroup:Create("Polymorph"),
	Summoning = SkillGroup:Create("Summoning"),
	Sourcery = SkillGroup:Create("Source"),
}

local function GetSkillGroup(ability)
	for _,v in pairs(EnemySkills) do
		if v.ability == ability then return v end
	end
	return nil
end

local ignored_skills = {
	Target_ChickenResurrect = true,
	Target_FaceRipper = true,
	Shout_PolymorphIntoDwarf = true,
	Shout_PolymorphIntoElf = true,
	Shout_PolymorphIntoHuman = true,
	Shout_PolymorphIntoLizard = true,
	Shout_Undead_PolymorphIntoDwarf = true,
	Shout_Undead_PolymorphIntoElf = true,
	Shout_Undead_PolymorphIntoHuman = true,
	Shout_Undead_PolymorphIntoLizard = true,
	Shout_PlayDead = true,
	Projectile_EnemyFlight_Ooze = true,
	Projectile_EnemyFlight_Ooze_Fire = true,
	Projectile_EnemyFlight_Ooze_Poison = true,
	Projectile_EnemyFlight_Wolf = true,
	Projectile_EnemyInfectiousBlood_Bat = true,
}

local ignored_skillwords = {
	"Suicide",
	"Invulnerability",
	"Quest",
	"QUEST",
	"LLENEMY",
	"SourceVampirism",
	"_Kraken_",
	"Projectile_Incarnate",
	"Projectile_Grenade_",
	"EnemyStaffOfMagus",
	"_Alan",
	"_Adrama",
	"_Puppet",
	"_Ooze",
	"_Explosion",
	"EnemyHound",
	"Dummy",
	"_Newt",
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
		if (isenemy == "Yes" or string.find(skill, "Enemy")) and not IgnoreSkill(skill) then
			local ability = Ext.StatGetAttribute(skill, "Ability")
			local requirement = Ext.StatGetAttribute(skill, "Requirement")
			local sp = Ext.StatGetAttribute(skill, "Magic Cost")
			local skillgroup = GetSkillGroup(ability)
			if skillgroup ~= nil then
				skillgroup.skills[#skillgroup.skills+1] = SkillEntry:Create(skill, requirement, sp)
				Ext.Print("[LLENEMY_BonusSkills.lua] Added enemy skill '" .. tostring(skill) .. "' to group (".. skillgroup.ability .."). Requirement(".. tostring(requirement) ..") SP(".. tostring(sp) ..")")
			end
		end
	end
end

local function GetHighestAbility(enemy)
	local last_highest_ability = "None"
	local last_highest_val = 0
	for ability,skillgroup in pairs(EnemySkills) do
		if ability ~= "None" then
			local ability_val = CharacterGetAbility(enemy, tostring(ability))
			if ability_val > 0 and ability_val > last_highest_val then
				last_highest_ability = ability
				last_highest_val = ability_val
			end
		end
	end
	return last_highest_ability
end

local function GetWeaponRequirement(enemy)
	return "None"
end

function LLENEMY_Ext_AddBonusSkills(enemy,bonus_type)
	local remaining = 1
	local source_skill_allowed = bonus_type == "Source"
	if bonus_type == "Set" then
		remaining = 3
	end

	local preferred_ability = GetHighestAbility(enemy)
	local preferred_requirement = GetWeaponRequirement(enemy)
	local sp_max = CharacterGetMaxSourcePoints(enemy)

	Ext.Print("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' preferred Ability (".. tostring(preferred_ability) ..") Requirement (".. tostring(preferred_requirement) ..") Max SP ("..tostring(sp_max)..").")

	local skillgroup = EnemySkills[preferred_ability]
	local i = 0
	local attempts = 0
	while i < remaining do
		local skill = skillgroup:GetRandom(preferred_requirement)
		if skill ~= nil then
			if skill.sp > 0 and source_skill_allowed == true then
				source_skill_allowed = false
				Ext.Print("[LLENEMY_BonusSkills.lua] Adding *SOURCE* skill (".. tostring(skill.id) ..") to enemy '" .. tostring(enemy) .. "'.")
				CharacterAddSkill(enemy, skill.id, 0)
				i = i + 1
			end
			if skill.sp == 0 then
				Ext.Print("[LLENEMY_BonusSkills.lua] Adding skill (".. tostring(skill.id) ..") to enemy '" .. tostring(enemy) .. "'.")
				CharacterAddSkill(enemy, skill.id, 0)
			i = i + 1
			else
				Ext.Print("[LLENEMY_BonusSkills.lua] Skipping source skill for '" .. tostring(enemy) .. "'.")
				attempts = attempts + 1
			end
		else 
			attempts = attempts + 1
		end
		if attempts >= 10 then
			Ext.Print("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' hit the maximum amount of random attempts when getting a skill.")
			attempts = 0
			i = i + 1
		end
	end
end