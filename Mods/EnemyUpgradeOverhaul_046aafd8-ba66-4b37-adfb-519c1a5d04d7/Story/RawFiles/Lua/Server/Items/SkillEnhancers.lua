--local RegisterSkillListener = LeaderLib.RegisterSkillListener
---@type SKILL_STATE
local SKILL_STATE = LeaderLib.SKILL_STATE

---@param skill string
---@param char string
---@param state SKILL_STATE PREPARE|USED|CAST|HIT
---@param skillData SkillEventData
LeaderLib.RegisterSkillListener("Rain_Water", function(skill, char, state, skillData)
	if state == SKILL_STATE.CAST then
		if ObjectGetFlag(char, "LLENEMY_ShadowBonus_ShockingRain_Enabled") == 1 then
			local target = skillData.TargetPositions[1] or skillData.TargetObjects[1]
			local x,y,z = 0
			if type(target) == "string" then
				x,y,z = GetPosition(target)
			else
				x,y,z = table.unpack(target)
			end
			local handle = NRD_CreateStorm(char, "Storm_LLENEMY_ShadowBonus_LightningStorm", x, y, z)
			NRD_GameActionSetLifeTime(handle, 12.0)
		end
	end
end)