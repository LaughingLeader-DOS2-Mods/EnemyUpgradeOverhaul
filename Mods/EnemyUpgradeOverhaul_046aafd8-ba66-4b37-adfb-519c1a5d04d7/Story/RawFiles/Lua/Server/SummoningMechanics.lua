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
			-- Prioritize ground surfaces
			for surfaceCheck,status in pairs(surfaceNames) do
				if string.find(surface, surfaceCheck) then
					ApplyStatus(summon, status, -1.0, 0, owner)
					return true
				end
			end
			-- Fallback to cloud checks
			for surfaceCheck,status in pairs(surfaceNames) do
				if string.find(cloud, surfaceCheck) then
					ApplyStatus(summon, status, -1.0, 0, owner)
					return true
				end
			end
		end
	end
	return false
end

function SetIncarnateSurfaceBuff(summon, owner)
	ApplyStatus(summon, "LLENEMY_INF_RANGED", -1.0, 0, owner)
	ApplyStatus(summon, "LLENEMY_INF_POWER", -1.0, 0, owner)
	if IsTagged(owner, "LLENEMY_Duplicant") == 1 then
		ApplyStatus(summon, "INF_SHADOW", -1.0, 0, owner)
	end
	ApplyIncarnateElementalBuff(summon, owner)
end

function ModifySummoningAbility(uuid)
	-- For allowing them to summon an Incarnate Champion
	if CharacterGetAbility(uuid, "Summoning") < 10 and (IsBoss(uuid) == 1 or CharacterGetLevel(uuid) >= 12) then
		CharacterAddAbility(uuid, "Summoning", 4)
	end
end

--Mods.EnemyUpgradeOverhaul.SummonAutomaton("08348b3a-bded-4811-92ce-f127aa4310e0")
--Mods.EnemyUpgradeOverhaul.SummonAutomaton(CharacterGetHostCharacter())
function SummonAutomaton(uuid)
	if HasActiveStatus(uuid, "LLENEMY_SUMMONING_CAP_INCREASE") == 0 then
		ApplyStatus(uuid, "LLENEMY_SUMMONING_CAP_INCREASE", 54.0, 0, uuid)
	end
	local x,y,z = GetPosition(uuid)
	local combatid = CombatGetIDForCharacter(uuid)
	if combatid ~= nil then
		local combatEntries = Osi.DB_CombatCharacters:Get(nil,combatid)
		local randomEntry = LeaderLib.Common.GetRandomTableEntry(combatEntries)
		if randomEntry ~= nil then
			x,y,z = GetPosition(randomEntry[1])
			x,y,z = FindValidPosition(x,y,z, 12.0, uuid)
		end
	end
	local handle = NRD_CreateStorm(uuid, "Storm_LLENEMY_SpawnAutomaton", x,y,z)
	NRD_GameActionSetLifeTime(handle, 48.0)
	--local sx,sy,sz = GetPosition(uuid)
	--GameHelpers.ShootProjectile(uuid, {x,y,z}, "ProjectileStrike_LLENEMY_SummonAutomaton", false, {sx,sy,sz})
end

function SummonSetFaction(uuid)
	local character = Ext.GetCharacter(uuid)
	if character ~= nil and character.HasOwner and character.OwnerHandle ~= nil then
		local owner = Ext.GetCharacter(character.OwnerHandle)
		if owner ~= nil then
			SetFaction(character, GetFaction(owner.MyGuid))
		end
	end
end