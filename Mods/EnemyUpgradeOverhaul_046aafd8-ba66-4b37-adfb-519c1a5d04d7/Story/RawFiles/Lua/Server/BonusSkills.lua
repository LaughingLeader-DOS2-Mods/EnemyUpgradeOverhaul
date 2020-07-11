local ATTEMPTS_MAX = 40

local ignored_skills = Ext.Require("Server/BonusSkills/IgnoredSkills.lua")
local ignored_skillwords = Ext.Require("Server/BonusSkills/IgnoredSkillWords.lua")

local ignored_parents = {
	Target_SourceVampirism = true
}

local redirected_skills = {
	Rain_Oil = "Rain_LLENEMY_EnemyOil"
}

-- Has a mod already added to IgnoredSkills?
if IgnoredSkills ~= nil then
	for skill,b in pairs(IgnoredSkills) do
		ignored_skills[skill] = b
	end
end
IgnoredSkills = ignored_skills

if IgnoredWords ~= nil then
	for i,word in pairs(IgnoredWords) do
		table.insert(ignored_skillwords, word)
	end
end
IgnoredWords = ignored_skillwords

---@type SkillEntry
local SkillEntry = Classes.SkillEntry
---@type SkillGroup
local SkillGroup = Classes.SkillGroup

---@param ability string
---@return SkillGroup
local function GetSkillGroup(self, ability)
	for _,v in pairs(self) do
		if v.ability == ability then return v end
	end
	return nil
end

local function IgnoreSkill(skill)
	if IgnoredSkills[skill] == false then return false end
	if IgnoredSkills[skill] == true then return true end
	if string.sub(skill,1,1) == "_" then
		return true
	end
	local parent = Ext.StatGetAttribute(skill, "Using")
	if parent ~= nil and ignored_parents[parent] == true then
		return true
	end
	for _,word in pairs(ignored_skillwords) do
		if string.find(skill, word) then return true end
	end
	return false
end

local function IgnoreSkill_QRY(skill)
	if IgnoreSkill(skill) then
		return 1
	end
	return 0
end
Ext.NewQuery(IgnoreSkill_QRY, "LLENEMY_Ext_QRY_IgnoreSkill", "[in](STRING)_Skill, [out](INTEGER)_Ignored")

local AIFLAG_CANNOT_USE = 140689826905584

local function LLENEMY_ParentSkillIsInvalid(skill)
	local parent = Ext.StatGetAttribute(skill, "Using")
	if parent ~= nil then
		if Ext.StatGetAttribute(parent, "SkillType") == nil then
			Ext.Print("[LLENEMY_BonusSkills.lua] [*ERROR*] Parent skill for '" .. tostring(skill) .. "' does not exist! Skipping!")
			return true
		end
	end
	return false
end

---@param requirementsTable StatRequirement[]
---@return boolean
local function HasTagRequirement(requirementsTable)
	for i,v in pairs(requirementsTable) do
		if v.Requirement == "Tag" then
			return true
		end
	end
	return false
end

local function BuildEnemySkills()
	EnemySkills = {
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
			LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] Swapping skill '" .. tostring(skill) .. "' for '"..swapped_skill .. "'")
			skill = swapped_skill
		end
		local isenemy = Ext.StatGetAttribute(skill, "IsEnemySkill")
		local aiflags = Ext.StatGetAttribute(skill, "AIFlags")
		local ap = Ext.StatGetAttribute(skill, "ActionPoints")
		local cd = Ext.StatGetAttribute(skill, "Cooldown")

		if not IgnoreSkill(skill) then
			if aiflags ~= AIFLAG_CANNOT_USE and (isenemy == "Yes" and string.find(skill, "Enemy")) then
				if ap > 0 or cd > 0 then
					local b,invalidSkill = pcall(LLENEMY_ParentSkillIsInvalid, skill)
					if not b then invalidSkill = true end
					if not invalidSkill then
						local ability = Ext.StatGetAttribute(skill, "Ability")
						local requirement = Ext.StatGetAttribute(skill, "Requirement")
						local sp = Ext.StatGetAttribute(skill, "Magic Cost")
						if sp == nil then sp = 0 end
						local tier = Ext.StatGetAttribute(skill, "Tier")
						local skillgroup = GetSkillGroup(EnemySkills, ability)
						if skillgroup ~= nil then
							skillgroup:Add(SkillEntry:Create(skill, requirement, sp, tier))
							--LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] Added enemy skill '" .. tostring(skill) .. "' to group (".. skillgroup.ability .."). Requirement(".. tostring(requirement) ..") SP(".. tostring(sp) ..")")
							--LeaderLib.PrintDebug(tostring(skill))
						end
					else
						LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] Skill '" .. tostring(skill) .. "' is invalid? pcall (".. tostring(b) ..") invalidSkill(".. tostring(invalidSkill)..")")
					end
				end
			else
				if Ext.StatGetAttribute(skill, "ForGameMaster") == "Yes" and isenemy ~= "Yes" and Ext.StatGetAttribute(skill, "Memory Cost") > 0 then
					local tier = Ext.StatGetAttribute(skill, "Tier")
					if LeaderLib.Data.OriginalSkillTiers ~= nil and LeaderLib.Data.OriginalSkillTiers[skill] ~= nil then
						tier = LeaderLib.Data.OriginalSkillTiers[skill]
					end
					if tier ~= nil and tier ~= "" and tier ~= "None" then
						---@type StatRequirement[]
						local requirements = Ext.StatGetAttribute(skill, "Requirements")
						---@type StatRequirement[]
						local memorizationRequirements = Ext.StatGetAttribute(skill, "MemorizationRequirements")

						-- Skills with tag requirements tend to be special and shouldn't be randomly added
						if not HasTagRequirement(requirements) and not HasTagRequirement(memorizationRequirements) then
							local ability = Ext.StatGetAttribute(skill, "Ability")
							if ability ~= "" and ability ~= "None" then
								-- Poison skills being under the Earth Ability
								if ability == "Earth" then
									if string.find(skill, "Poison") or Ext.StatGetAttribute(skill, "DamageType") == "Poison" then
										ability = "Poison"
									end
								end
								if ItemCorruption.Boosts.BonusSkills[ability] == nil then
									ItemCorruption.Boosts.BonusSkills[ability] = {}
								end
								table.insert(ItemCorruption.Boosts.BonusSkills[ability], skill)
							end
						end
					end
				end
			end
		end
	end
end

-- Retroactively remove blacklisted skills if they were modified
LeaderLib.RegisterListener("Initialized", function()
	if EnemySkills ~= nil and #EnemySkills > 0 then
		for _,skillgroup in pairs(EnemySkills) do
			if skillgroup.Entries ~= nil then
				for i,skill in pairs(skillgroup.Entries) do
					if IgnoreSkill(skill) then
						table.remove(skillgroup.Entries, i)
					end
				end
			end
		end
	end
end)

local function GetHighestAbility(enemy)
	local last_highest_ability = "None"
	local last_highest_val = 0
	for _,skillgroup in pairs(EnemySkills) do
		if skillgroup.id ~= "None" then
			local ability_val = CharacterGetAbility(enemy, tostring(skillgroup.id))
			---LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua:GetHighestAbility] ---- Ability (" .. tostring(skillgroup.id) .. ") = ("..tostring(ability_val)..")")
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
	Rifle = {"RifleWeapon", "RangedWeapon"},
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
	--LeaderLib.PrintDebug("EnemySkills count: " .. tostring(#EnemySkills) .. " | Looking for " .. ability)
	if ability ~= "None" and (lastgroup == nil or lastgroup ~= nil and lastgroup.id ~= ability) then
		for k,v in pairs(EnemySkills) do
			if v.id == ability or v.ability == ability then return v end
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
					--LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua:GetPreferredSkillGroup] ---- Matched skill (" .. tostring(ranskill.id) .. ") to requirement ("..requirement..") for group ("..rantable.id..")")
					return rantable
				elseif type(requirement) == "table" then
					for k,v in pairs(requirement) do
						if v == ranskill.requirement then
							--LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua:GetPreferredSkillGroup] ---- Matched skill (" .. tostring(ranskill.id) .. ") to requirement ("..v..") for group ("..rantable.id..")")
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

function AddBonusSkills(enemy,remainingstr,source_skills_remainingstr)
	local remaining = math.max(tonumber(remainingstr), 1)
	local source_skills_remaining = math.max(tonumber(source_skills_remainingstr), 0)
	local preferred_ability = GetHighestAbility(enemy)
	local preferred_requirement = GetWeaponRequirement(enemy)
	--local sp_max = CharacterGetMaxSourcePoints(enemy)
	local level = CharacterGetLevel(enemy)

	LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' preferred Ability (".. tostring(preferred_ability) ..") Requirement (".. tostring(LeaderLib.Common.Dump(preferred_requirement)) ..") Bonus Skills ("..tostring(remaining)..") Source Skills ("..tostring(source_skills_remaining)..").")
	local skillgroup = GetPreferredSkillGroup(preferred_ability, preferred_requirement, nil)
	if skillgroup == nil then
		LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] -- Can't get a skillgroup for Enemy '" .. tostring(enemy) .. "'. Skipping.")
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
			LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] -- Adding skill (".. tostring(skill.id) ..") to enemy '" .. tostring(enemy) .. "'.")
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
		LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua] Enemy '" .. tostring(enemy) .. "' hit the maximum amount of random attempts when getting a skill from group ("..skillgroup.id..").")
	end
end

return {
	Init = BuildEnemySkills
}