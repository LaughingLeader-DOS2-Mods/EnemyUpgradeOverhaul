local preResistanceDamage = {}

local resistancePenetrationTags = {}

for i,damageType in LeaderLib.Data.DamageTypes:Get() do
	if resistancePenetrationTags[damageType] == nil then
		resistancePenetrationTags[damageType] = {}
	end
	for amount=5,50,5 do
		local tag = string.format("LLENEMY_ResistancePenetration_%s$i", damageType,amount)
		table.insert(resistancePenetrationTags[damageType], {Tag=tag,Amount=amount})
	end
end

function SaveDamageAmountForResistancePenetration(target, source, damage, handle)
	local hasResistanceToDamage = false

	for i,damageType in LeaderLib.Data.DamageTypes:Get() do
		local resistance = NRD_CharacterGetComputedStat(target, LeaderLib.Data.DamageTypeToResistance[damageType], 0)
        local typeDamage = NRD_HitGetDamage(handle, damageType)
		if resistance > 0 and typeDamage ~= nil and typeDamage > 0 then
			if preResistanceDamage[target] == nil then
				preResistanceDamage[target] = {}
				preResistanceDamage[target].Count = 0
			end
			if preResistanceDamage[target][source] == nil then
				preResistanceDamage[target][source] = {}
				preResistanceDamage[target].Count = preResistanceDamage[target].Count + 1
			end
            preResistanceDamage[target][source][damageType] = typeDamage
            hasResistanceToDamage = true
        end
	end
	if hasResistanceToDamage then
		Osi.DB_LLENEMY_HasDamagePenetration(target,source)
	end
end

local function HasTagEquipped(target, tag)
	for _,slotName in Data.VisibleEquipmentSlots:Get() do
		local item = CharacterGetEquippedItem(target, slotName)
		if item ~= nil and IsTagged(item, tag) == 1 then
			return true
		end
	end
	return false
end

function ApplyResistancePenetration(target, source, damage, handle)
	local targetDamageTable = preResistanceDamage[target] or nil
	if targetDamageTable ~= nil then
		local damageTable = targetDamageTable[source] or nil

		if damageTable ~= nil then
			for damageType,preDamage in pairs(damageTable) do
				local currentDamage = NRD_HitStatusGetDamage(target, handle, damageType)
				local diff = preDamage - currentDamage
				
				if diff > 0 then
					local resistance = NRD_CharacterGetComputedStat(target, LeaderLib.Data.DamageTypeToResistance[damageType], 0)
					local penetrationAmount = 0

					local tags = resistancePenetrationTags[damageType]
					for i,tagEntry in pairs(tags) do
						if HasTagEquipped(source, tagEntry.Tag) then
							penetrationAmount = penetrationAmount + tagEntry.Amount
						end
					end

					penetrationAmount = math.min(penetrationAmount / 100, 1.0)
	
					if penetrationAmount > 0 then
						local nextDamage = preDamage - math.floor(preDamage * ((resistance / 100.0) * penetrationAmount))
						if nextDamage > 0 then
							NRD_HitStatusClearDamage(target, handle, damageType)
							NRD_HitStatusAddDamage(target, handle, damageType, nextDamage)
							Ext.Print("[EUO] Penetrated resistance for damage type", damageType)
							Ext.Print("[EUO] Resistance Amount:", resistance)
							Ext.Print("[EUO] Penetration Amount:", penetrationAmount)
							Ext.Print("[EUO] Pre Damage:", preDamage)
							Ext.Print("[EUO] Post Damage:", currentDamage)
							Ext.Print("[EUO] New Damage:", nextDamage)
							Ext.Print("[EUO] Target:", target)
							Ext.Print("[EUO] Source:", source)
						else
							NRD_HitStatusClearDamage(target, handle, damageType)
						end
					end
				end
			end

			preResistanceDamage[target][source] = nil
			preResistanceDamage[target].Count = preResistanceDamage[target].Count - 1
			if preResistanceDamage[target].Count == 0 then
				preResistanceDamage[target] = nil
			end
		end
	end
end