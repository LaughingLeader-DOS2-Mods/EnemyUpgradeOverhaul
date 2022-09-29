function HM_RollAdditionalUpgrades(char)
	local vars = Settings.Global.Variables
	local min = vars.Hardmode_MinBonusRolls.Value or Ext.ExtraData["LLENEMY_Hardmode_DefaultBonusRolls_Min"] or 1
	local max = vars.Hardmode_MaxBonusRolls.Value or Ext.ExtraData["LLENEMY_Hardmode_DefaultBonusRolls_Max"] or 4
	local bonusRolls = Ext.Utils.Random(min, max)
	if bonusRolls > 0 then
		for i=bonusRolls,1,-1 do
			Osi.LLENEMY_Upgrades_RollForUpgrades(char)
		end
	end
end