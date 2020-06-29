
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

---@type SkillEntry
Classes.SkillEntry = SkillEntry

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
	--LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua:GetRandomSkill] ---- Getting random skill from table count (".. tostring(#available_skills) ..") self.skills("..tostring(#self.skills)..") self.id("..tostring(#self.id)..").")
	--LeaderLib.PrintDebug("[LLENEMY_BonusSkills.lua:GetRandomSkill] ---- ("..tostring(LeaderLib.Common.Dump(available_skills))..").")
	return LeaderLib.Common.GetRandomTableEntry(available_skills)
end

---@type SkillGroup
Classes.SkillGroup = SkillGroup