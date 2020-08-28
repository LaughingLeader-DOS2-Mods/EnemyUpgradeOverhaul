local IncarnateBuffs = {
	INCARNATE_S = {
		FireCursed = "INF_NECROFIRE",
		FrozenBlessed = "INF_BLESSED_ICE",
		PoisonCursed = "INF_ACID",
		ElectrifiedCursed = "INF_CURSED_ELECTRIC",
		Electrified = "INF_ELECTRIC",
		Fire = "INF_FIRE",
		Poison = "INF_POISON",
		Oil = "INF_OIL",
		Blood = "INF_BLOOD",
		Water = "INF_WATER",
	},
	INCARNATE_G = {
		FireCursed = "INF_NECROFIRE_G",
		FrozenBlessed = "INF_BLESSED_ICE_G",
		PoisonCursed = "INF_ACID_G",
		ElectrifiedCursed = "INF_CURSED_ELECTRIC_G",
		Electrified = "INF_ELECTRIC_G",
		Fire = "INF_FIRE_G",
		Poison = "INF_POISON_G",
		Oil = "INF_OIL_G",
		Blood = "INF_BLOOD_G",
		Water = "INF_WATER_G",
	}
}

local function ApplyIncarnateElementalBuff(summon, owner)
	local surface = GetSurfaceGroundAt(summon) or "SurfaceNone"
	local cloud = GetSurfaceCloudAt(summon) or "SurfaceNone"
	if surface == "SurfaceNone" and cloud == "SurfaceNone" then
		return false
	end
	for tag,surfaceNames in pairs(IncarnateBuffs) do
		if IsTagged(summon, tag) == 1 then
			for surfaceCheck,status in pairs(surfaceNames) do
				if string.find(surface, surfaceCheck) or string.find(cloud, surfaceCheck) then
					ApplyStatus(summon, status, -1.0, 0, owner)
					return true
				end
			end
		end
	end
	return false
end

function SetIncarnateSurfaceBuff(summon, owner)
	ApplyStatus(summon, "INF_RANGED", -1.0, 0, owner)
	ApplyStatus(summon, "INF_POWER", -1.0, 0, owner)
	if IsTagged(owner, "LLENEMY_Duplicant") then
		ApplyStatus(summon, "INF_SHADOW", -1.0, 0, owner)
	end
	ApplyIncarnateElementalBuff(summon, owner)
end