function HM_RollAdditionalUpgrades(char)
	local bonusRolls = Ext.Random(1,3) + 1
	for i=bonusRolls,0,-1 do
		Osi.LLENEMY_Upgrades_RollForUpgrades(char)
		--Ext.Print("Rolling bonus roll: " .. tostring(i) .. " | " .. char)
	end
end