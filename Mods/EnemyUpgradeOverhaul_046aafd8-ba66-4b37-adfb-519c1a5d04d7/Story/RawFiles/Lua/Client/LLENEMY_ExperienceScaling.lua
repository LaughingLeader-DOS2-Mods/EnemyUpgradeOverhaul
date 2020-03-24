EnemyUpgradeOverhaul.PlayerLevel = 1

local function LLENEMY_OnPlayerLevelSent(channel, levelstr)
	EnemyUpgradeOverhaul.PlayerLevel = math.tointeger(levelstr)
	Ext.Print("[LLENEMY_ExperienceScaling.lua:LLENEMY_OnPlayerLevelSent] Set player level to (".. levelstr ..") on clients.")
end

Ext.RegisterNetListener("LLENEMY_SetPlayerLevel", LLENEMY_OnPlayerLevelSent)

function LLENEMY_Ext_ScaleExperience(gain, characterLevel)
	local level = EnemyUpgradeOverhaul.PlayerLevel
	local levelCap = math.floor(LLENEMY_Ext_GetExtraDataValue("LevelCap", 35))
	if gain ~= nil and gain > 0 then
		local expMod = LLENEMY_Ext_GetExtraDataValue("LLENEMY_ExperienceModifier", 0.5)
		if expMod == nil then expMod = 0.5 end
		Ext.Print("[LLENEMY_ExperienceScaling.lua:LLENEMY_ExperienceScale] gain(" .. tostring(gain) .. ") level(" .. tostring(level) .. "/".. tostring(levelCap) ..") expMod(".. tostring(expMod) ..")")
		--local softLevelCap = Ext.ExtraData.SoftLevelCap
		if levelCap == nil or levelCap <= 0 then levelCap = 1 end
		if level >= levelCap then return 0 end

		local quadBaseActPart = level
		if level > 8 then quadBaseActPart = 8 end
		local quadraticActPart = level - quadBaseActPart;
		local actPartQuad = quadBaseActPart * (quadBaseActPart + 1)
		local actMod = 0.0
		if quadraticActPart > 0 then
			if quadraticActPart == 2 then
				actMod = 1.9320999;
			else
				actMod = 1.39 ^ quadraticActPart
				local x = (actPartQuad * actMod)
				-- round  x + 0.5 - (x + 0.5) % 1
				actPartQuad = x + 0.5 - (x + 0.5) % 1
			end
		end
		Ext.Print("	[LLENEMY_ExperienceScaling.lua:LLENEMY_ExperienceScale] quadBaseActPart(" .. tostring(quadBaseActPart) .. ") quadraticActPart(" .. tostring(quadraticActPart)..") actPartQuad(" .. tostring(actPartQuad)..") actMod(" .. tostring(actMod)..") actPartQuad(" .. tostring(actPartQuad)..")")
		local exp = math.floor(25 * (10 * gain * actPartQuad + 24) / 25)
		local result = math.ceil(exp * expMod)
		Ext.Print("[LLENEMY_ExperienceScaling.lua:LLENEMY_ExperienceScale] exp(".. tostring(exp) ..") => result(" .. tostring(result) .. ")")
		return result
	end
	return 0
end