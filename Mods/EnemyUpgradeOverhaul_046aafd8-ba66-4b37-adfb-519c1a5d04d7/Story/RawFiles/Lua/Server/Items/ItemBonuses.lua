
function ShadowItem_OnEquipped(char, item)
	for tag,entry in pairs(ItemCorruption.TagBoosts) do
		if not LeaderLib.StringHelpers.IsNullOrEmpty(entry.Flag) and IsTagged(item, tag) == 1 then
			LeaderLib_ToggleScripts_EnableScriptForObject(char, entry.Flag, "EnemyUpgradeOverhaul", 1)
		end
	end
end

function ShadowItem_OnUnEquipped(char, item)
	local removedTags = {}
	for tag,entry in pairs(ItemCorruption.TagBoosts) do
		if not LeaderLib.StringHelpers.IsNullOrEmpty(entry.Flag) and IsTagged(item, tag) == 1 then
			--LeaderLib_ToggleScripts_DisableScriptForObject(char, flag, "EnemyUpgradeOverhaul", 1)
			table.insert(removedTags, entry)
		end
	end
	for i,entry in pairs(removedTags) do
		local hasTaggedItem = false
		for i,slot in LeaderLib.Data.VisibleEquipmentSlots:Get() do
			local slotItem = CharacterGetEquippedItem(char, slot)
			if slotItem ~= nil and IsTagged(item, entry.Tag) == 1 then
				hasTaggedItem = true
				break
			end
		end
		if not hasTaggedItem then
			LeaderLib_ToggleScripts_DisableScriptForObject(char, entry.Flag, "EnemyUpgradeOverhaul", 1)
		end
	end
end

-- From the LLENEMY_ShadowBonus_Madness tag boost
function RollForMaddness(char)
	local chance = math.tointeger(Ext.ExtraData["LLENEMY_ShadowTreasure_MadnessChanceOnTurn"] or 20)
	if chance > 0 then
		local turnDuration = (Ext.ExtraData["LLENEMY_ShadowTreasure_MadnessTurnDuration"] or 2) * 6.0
		if chance >= 100 then
			ApplyStatus(char, "LLENEMY_SHADOWBONUS_MADNESS", turnDuration, 0, char)
		elseif Ext.Random(0, 100) <= chance then
			ApplyStatus(char, "LLENEMY_SHADOWBONUS_MADNESS", turnDuration, 0, char)
		end
	end
end