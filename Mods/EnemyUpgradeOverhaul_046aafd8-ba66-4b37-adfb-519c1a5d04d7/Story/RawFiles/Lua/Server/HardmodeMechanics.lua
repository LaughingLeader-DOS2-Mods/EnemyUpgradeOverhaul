function HM_RollAdditionalUpgrades(char)
	local vars = Settings.Global.Variables
	local min = vars.Hardmode_MinBonusRolls.Value or 1
	local max = vars.Hardmode_MaxBonusRolls.Value or 4
	local bonusRolls = Ext.Random(min, max)
	if bonusRolls > 0 then
		for i=bonusRolls,1,-1 do
			Osi.LLENEMY_Upgrades_RollForUpgrades(char)
			--Ext.Print("Rolling bonus roll: " .. tostring(i) .. " | " .. char)
		end
	end
end