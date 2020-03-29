EnemyUpgradeOverhaul.PlayerLevel = 1

local function LLENEMY_OnPlayerLevelSent(channel, levelstr)
	EnemyUpgradeOverhaul.PlayerLevel = math.tointeger(levelstr)
	Ext.Print("[LLENEMY_ExperienceScaling.lua:LLENEMY_OnPlayerLevelSent] Set player level to (".. levelstr ..") on clients.")
end

Ext.RegisterNetListener("LLENEMY_SetPlayerLevel", LLENEMY_OnPlayerLevelSent)

function LLENEMY_Ext_ScaleExperience(gain, level)
	--- Character death experience scaling is 0 so we can grant it with scripting instead.
	if EnemyUpgradeOverhaul.ScaleExperience == true then
		return 0
	else
		local levelCap = math.floor(LLENEMY_Ext_GetExtraDataValue("LevelCap", 35))
		if gain ~= nil and gain > 0 then
			Ext.Print("[LLENEMY_ExperienceScaling.lua:LLENEMY_ExperienceScale] gain(" .. tostring(gain) .. ") level(" .. tostring(level) .. "/".. tostring(levelCap) ..")")
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
			local xp = math.floor((10 * gain * actPartQuad + 24) / 25) * 25

			Ext.Print("	[LLENEMY_ExperienceScaling.lua:LLENEMY_ExperienceScale] quadBaseActPart(" .. tostring(quadBaseActPart) .. ") quadraticActPart(" .. tostring(quadraticActPart)..") actPartQuad(" .. tostring(actPartQuad)..") actMod(" .. tostring(actMod)..") actPartQuad(" .. tostring(actPartQuad)..")")
			Ext.Print("[LLENEMY_ExperienceScaling.lua:LLENEMY_ExperienceScale] xp(".. tostring(xp) ..")")
			return xp
		end
		return 0
	end
end