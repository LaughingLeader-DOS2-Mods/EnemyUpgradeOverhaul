
function LLENEMY_ShadowItem_OnEquipped(char, item)
	for tag,entry in pairs(ItemCorruption.BonusTags) do
		if IsTagged(item, tag) == 1 then
			LeaderLib_ToggleScripts_EnableScriptForObject(char, entry.Flag, "EnemyUpgradeOverhaul", 1)
		end
	end
end

function LLENEMY_ShadowItem_OnUnEquipped(char, item)
	local removedTags = {}
	for tag,entry in pairs(ItemCorruption.BonusTags) do
		if IsTagged(item, tag) == 1 then
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