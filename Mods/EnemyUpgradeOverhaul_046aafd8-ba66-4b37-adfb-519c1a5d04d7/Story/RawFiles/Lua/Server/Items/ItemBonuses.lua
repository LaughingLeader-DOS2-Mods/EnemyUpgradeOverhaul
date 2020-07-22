
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
		local rollCooldown = math.tointeger(Ext.ExtraData["LLENEMY_ShadowTreasure_MadnessRollTurnCooldown"] or 2)
		local turnDuration = (Ext.ExtraData["LLENEMY_ShadowTreasure_MadnessTurnDuration"] or 2) * 6.0
		if chance >= 100 then
			ApplyStatus(char, "LLENEMY_SHADOWBONUS_MADNESS", turnDuration, 0, char)
			Osi.DB_LLENEMY_ItemBonuses_Temp_MadnessCooldown(char, rollCooldown)
		elseif Ext.Random(0, 100) <= chance then
			ApplyStatus(char, "LLENEMY_SHADOWBONUS_MADNESS", turnDuration, 0, char)
			Osi.DB_LLENEMY_ItemBonuses_Temp_MadnessCooldown(char, rollCooldown)
		end
	end
end

--- @param target string
--- @param source string
--- @param damage integer
--- @param handle integer
local function OnPrepareHit(target,source,damage,handle)
	if ObjectGetFlag(target, "LLENEMY_ShadowBonus_StunDefense_Enabled") == 1 then
		local damageReduction = Ext.ExtraData["LLENEMY_ShadowBonus_StunDefense_DamageReduction"] or 0.5
		if damageReduction > 0 then
			GameHelpers.ReduceDamage(target, source, handle, damageReduction, true)
		end
	end
end
LeaderLib.RegisterListener("OnPrepareHit", OnPrepareHit)

--- @param target string
--- @param source string
--- @param damage integer
--- @param handle integer
local function OnHit(target,source,damage,handle)

end
LeaderLib.RegisterListener("OnHit", OnHit)

local function OnTurnEndedOrLeftCombat(object, combatId)
	if ObjectGetFlag(object, "LLENEMY_ShadowBonus_DotCleanser_Enabled") == 1 then
		if ObjectIsCharacter(object) == 1 then
			local cleansed = {}
			local character = Ext.GetCharacter(object)
			for i,status in pairs(character:GetStatuses()()) do
				if Ext.StatGetAttribute(status, "StatusType") == "DAMAGE" then
					local weaponStat = Ext.StatGetAttribute(status, "DamageStats")
					if weaponStat ~= nil and Ext.StatGetAttribute(weaponStat, "DamageFromBase") > 0 then
						table.insert(cleansed, GameHelpers.GetStringKeyText(Ext.StatGetAttribute(status, "DisplayName"), status))
						RemoveStatus(object, status.StatusId)
					end
				end
			end
			if #cleansed > 0 then
				local statusText = GameHelpers.GetStringKeyText("LLENEMY_StatusText_Cleansed", "<font color='#73F6FF'>[1] Cleansed [2]</font>")
				local itemResponsible = CharacterFindTaggedItem(object, "LLENEMY_ShadowBonus_DotCleanser")
				local cleanseSource = ""
				if itemResponsible ~= nil then
					cleanseSource = Ext.GetItem(itemResponsible).DisplayName
				else
					cleanseSource = GameHelpers.GetStringKeyText("LLENEMY_ShadowBonus_DotCleanser", "Immune Boost")
				end
				statusText = statusText:gsub("%[1%]", cleanseSource):gsub("%[2%]", StringHelpers.Join(", ", cleansed))
				CharacterStatusText(character, statusText)
			end
		end
	end
end

if Ext.Version() >= 50 then
	Ext.RegisterOsirisListener("ObjectTurnEnded", 1, "after", OnTurnEndedOrLeftCombat)
	Ext.RegisterOsirisListener("ObjectLeftCombat", 2, "after", OnTurnEndedOrLeftCombat)
end