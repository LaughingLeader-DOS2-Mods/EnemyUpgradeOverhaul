
---@class VoidwokenSpawn
local VoidwokenSpawn = {
	Template = "",
	Templates = {},
	Weight = 0,
	DefaultWeight = 0
}
VoidwokenSpawn.__index = VoidwokenSpawn

---@param weight number
---@return VoidwokenSpawn
function VoidwokenSpawn:Create(weight, ...)
    local this =
    {
		Templates = {...},
		Weight = weight,
		DefaultWeight = weight
	}
	if #this.Templates > 0 then
		this.Template = this.Templates[1]
	end
	setmetatable(this, self)
    return this
end

---@return string
function VoidwokenSpawn:GetTemplate()
    if #self.Templates > 1 then
		return LeaderLib.Common.GetRandomTableEntry(self.Templates)
	end
    return self.Template
end

---@class VoidwokenSpawnGroup
local VoidwokenSpawnGroup = {
	Entries = {},
	MinPoints = 0
}
VoidwokenSpawnGroup.__index = VoidwokenSpawn

---@param minPoints integer
---@return VoidwokenSpawnGroup
function VoidwokenSpawnGroup:Create(minPoints, ...)
    local this =
    {
		MinPoints = minPoints,
		Entries = {...}
	}
	setmetatable(this, self)
    return this
end

--[[ 
LLENEMY_Animals_Bear_A_Voidwoken_09b17320-6a1b-4807-bd30-fb2a6e053c5a
LLENEMY_Animals_Beetle_A_Fire_891f32c0-bf75-4226-bf45-170ae71e8c00
LLENEMY_Animals_Beetle_A_Green_7fd9eed0-e2c7-480b-9f0a-0a430c94b92f
LLENEMY_Animals_Boar_A_Void_A_0ed3acfc-103d-4709-96b6-582e859910f1
LLENEMY_Animals_Deer_A_Void_A_c82646f0-9275-4bba-8e9b-efa06cd8ee5f
LLENEMY_Animals_Frog_Merman_A_f23a5de6-0169-42b2-84f8-8d87d39a6f3a
LLENEMY_Animals_Frog_Merman_A_Giant_e110341a-14cd-4ade-a3e9-3ac25669637b
LLENEMY_Animals_Salamander_A_Poison_6795cd59-bcc6-4a21-ab30-351ce5ab910b
LLENEMY_Animals_Salamander_A_Voidwoken_0c5243c0-1ea3-47e0-abc1-6c511baa83f0
LLENEMY_Animals_Turtle_A_Voidwoken_a0234f61-d011-42d6-a4ba-3b6010b87ccc
LLENEMY_Creatures_GiantInsect_A_NoWings_e8508e93-22f1-435f-ac3a-a4262627e66f
LLENEMY_Creatures_GiantInsect_A_Wings_502f6533-80b0-4369-ab63-67750f322d6d
LLENEMY_Creatures_GiantInsect_B_NoWings_fe624b7f-5deb-4136-af2b-f4b68f2ad684
LLENEMY_Creatures_GiantInsect_B_Wings_c9eb4ccf-0a0f-4304-a0b8-078873762538
LLENEMY_Creatures_GiantInsect_C_NoWings_d32073f4-a6f7-4b42-a752-7fb632e8e5e0
LLENEMY_Creatures_GiantInsect_C_Wings_8e6cc2c7-d7a9-4023-985d-da6ad032ea82
LLENEMY_Creatures_Molespitter_A_25ce90bd-788d-4f1e-b1a0-6c0f7286a939
LLENEMY_Creatures_Molespitter_B_c66817c1-1344-46d3-9e1d-03b10bf37038
LLENEMY_Creatures_Molespitter_C_08e58643-5d12-4d16-9abb-59ae95ed4e14
LLENEMY_Creatures_Nightmare_Werewolf_A_6d57af19-aebf-4893-b0c3-3d96f140ae2f
LLENEMY_Creatures_Statue_A_Voidwoken_abd8c14d-599e-48e2-bc29-4a42c40a5940
LLENEMY_Creatures_Statue_A_Voidwoken_B_02dc4dfd-7b8b-4fd3-82c7-90dcee5f833c
LLENEMY_Creatures_VampireBat_A_83fc3623-0382-4550-8bd7-888a568dac22
LLENEMY_Creatures_VampireBat_B_ceb0deeb-6313-4ccf-8fdb-ea80eab22066
LLENEMY_Creatures_Voidwoken_Alan_A_Boss_d615894f-6cc1-4eae-9c6c-ffacf00f89bd
LLENEMY_Creatures_Voidwoken_Caster_790ae435-697e-41d7-bcc4-efca7cc62371
LLENEMY_Creatures_Voidwoken_Caster_Ice_62a548ef-b432-4e05-b23e-1ccc9aaa490d
LLENEMY_Creatures_Voidwoken_Drillworm_A_Hatchling_ABC_c1a13a24-8b5c-408c-b2bf-18d965c166d0
LLENEMY_Creatures_Voidwoken_Drillworm_A_Hatchling_B_2577ec50-887c-41de-b5bc-702207679fde
LLENEMY_Creatures_Voidwoken_GiantInsect_Dominator_A_6c6e07e6-6455-4599-b33d-888ec8aafc12
LLENEMY_Creatures_Voidwoken_Grunt_A_8a0003b6-9109-4ea1-afc4-3f130e8b1079
LLENEMY_Creatures_Voidwoken_Grunt_A_Ice_e073b24e-041a-4166-950d-95a429ae3409
LLENEMY_Creatures_Voidwoken_Merman_A_3b414508-4ce6-475b-94cd-b389fc7f3bc1
LLENEMY_Creatures_Voidwoken_Spider_A_b20e320c-e2e3-40b0-8265-aff00e5ea7b1
LLENEMY_Creatures_Voidwoken_Spider_A_Poison_b0dea499-ee1f-42dc-bef9-8590ec3b2385
LLENEMY_Creatures_Voidwoken_Troll_A_a4b68f95-5d9f-4e25-95d9-6a957b2f8e37
LLENEMY_Creatures_Voidwoken_Troll_A_Ice_cc49f9c2-a5b9-4282-9808-b749fd0aa874
LLENEMY_Creatures_Demon_Hound_A_48351665-a3cf-4fea-a501-a14c15e6a46e
LLENEMY_Creatures_Demons_Worm_A_eaea8ce8-b795-433e-93c4-92597bb3f10a
LLENEMY_Quest_CoS_SeptaNemesis_Animals_Crab_A_Giant_cf3daf72-7f6c-49c4-bd4f-3459fd6c7c8b
]]

local voidwokenGroups = {
	-- Easy
	VoidwokenSpawnGroup:Create(0,
		VoidwokenSpawn:Create(10, "LLENEMY_Creatures_Voidwoken_Drillworm_A_Hatchling_ABC_c1a13a24-8b5c-408c-b2bf-18d965c166d0", "LLENEMY_Creatures_Voidwoken_Drillworm_A_Hatchling_B_2577ec50-887c-41de-b5bc-702207679fde")),
	-- Somewhat Easy
	VoidwokenSpawnGroup:Create(8,
		VoidwokenSpawn:Create(4, "LLENEMY_Animals_Turtle_A_Voidwoken_a0234f61-d011-42d6-a4ba-3b6010b87ccc"),
		VoidwokenSpawn:Create(8, "LLENEMY_Animals_Boar_A_Void_A_0ed3acfc-103d-4709-96b6-582e859910f1"),
		VoidwokenSpawn:Create(8, "LLENEMY_Animals_Deer_A_Void_A_c82646f0-9275-4bba-8e9b-efa06cd8ee5f")
	),
	-- Easy Bugs
	VoidwokenSpawnGroup:Create(8,
		VoidwokenSpawn:Create(8, "LLENEMY_Animals_Beetle_A_Fire_891f32c0-bf75-4226-bf45-170ae71e8c00", "LLENEMY_Animals_Beetle_A_Green_7fd9eed0-e2c7-480b-9f0a-0a430c94b92f"),
		VoidwokenSpawn:Create(8, "LLENEMY_Animals_Boar_A_Void_A_0ed3acfc-103d-4709-96b6-582e859910f1")
	),
	-- Drillworms
	VoidwokenSpawnGroup:Create(14,
		VoidwokenSpawn:Create(3, "LLENEMY_Creatures_Voidwoken_Drillworm_A_b24d5c4c-8a5a-4cd7-8518-f4684509be66", "LLENEMY_Creatures_Voidwoken_Drillworm_B_8713b59d-a564-4b90-910c-e5c6a384c0d9"),
		VoidwokenSpawn:Create(8, "LLENEMY_Creatures_Demons_Worm_A_eaea8ce8-b795-433e-93c4-92597bb3f10a")),
	-- Other Animals
	VoidwokenSpawnGroup:Create(16,
		VoidwokenSpawn:Create(4, "LLENEMY_Creatures_Demon_Hound_A_48351665-a3cf-4fea-a501-a14c15e6a46e"),
		VoidwokenSpawn:Create(6, "LLENEMY_Creatures_Molespitter_A_25ce90bd-788d-4f1e-b1a0-6c0f7286a939", "LLENEMY_Creatures_Molespitter_B_c66817c1-1344-46d3-9e1d-03b10bf37038", "LLENEMY_Creatures_Molespitter_C_08e58643-5d12-4d16-9abb-59ae95ed4e14"),
		VoidwokenSpawn:Create(6, "LLENEMY_Animals_Bear_A_Voidwoken_09b17320-6a1b-4807-bd30-fb2a6e053c5a"),
		VoidwokenSpawn:Create(10, "LLENEMY_Animals_Frog_Merman_A_f23a5de6-0169-42b2-84f8-8d87d39a6f3a")),
	-- Bats
	VoidwokenSpawnGroup:Create(18,
		VoidwokenSpawn:Create(3, "LLENEMY_Creatures_VampireBat_A_83fc3623-0382-4550-8bd7-888a568dac22", "LLENEMY_Creatures_VampireBat_B_ceb0deeb-6313-4ccf-8fdb-ea80eab22066")
	),
	-- Giant Insects
	VoidwokenSpawnGroup:Create(20,
		VoidwokenSpawn:Create(7, "LLENEMY_Creatures_GiantInsect_A_NoWings_e8508e93-22f1-435f-ac3a-a4262627e66f", "LLENEMY_Creatures_GiantInsect_B_NoWings_fe624b7f-5deb-4136-af2b-f4b68f2ad684", "LLENEMY_Creatures_GiantInsect_C_NoWings_d32073f4-a6f7-4b42-a752-7fb632e8e5e0"),
		VoidwokenSpawn:Create(3, "LLENEMY_Creatures_GiantInsect_A_Wings_502f6533-80b0-4369-ab63-67750f322d6d", "LLENEMY_Creatures_GiantInsect_B_Wings_c9eb4ccf-0a0f-4304-a0b8-078873762538", "LLENEMY_Creatures_GiantInsect_C_Wings_8e6cc2c7-d7a9-4023-985d-da6ad032ea82"),
		VoidwokenSpawn:Create(6, "LLENEMY_Creatures_Voidwoken_Spider_A_b20e320c-e2e3-40b0-8265-aff00e5ea7b1", "LLENEMY_Creatures_Voidwoken_Spider_A_Poison_b0dea499-ee1f-42dc-bef9-8590ec3b2385")),
	-- Grunts etc
	VoidwokenSpawnGroup:Create(24,
		VoidwokenSpawn:Create(2, "LLENEMY_Creatures_Voidwoken_Caster_790ae435-697e-41d7-bcc4-efca7cc62371", "LLENEMY_Creatures_Voidwoken_Caster_Ice_62a548ef-b432-4e05-b23e-1ccc9aaa490d"),
		VoidwokenSpawn:Create(4, "LLENEMY_Creatures_Voidwoken_Grunt_A_8a0003b6-9109-4ea1-afc4-3f130e8b1079", "LLENEMY_Creatures_Voidwoken_Grunt_A_Ice_e073b24e-041a-4166-950d-95a429ae3409")
	),
	VoidwokenSpawnGroup:Create(28,
		VoidwokenSpawn:Create(4, "LLENEMY_Animals_Salamander_A_Voidwoken_0c5243c0-1ea3-47e0-abc1-6c511baa83f0", "LLENEMY_Animals_Salamander_A_Poison_6795cd59-bcc6-4a21-ab30-351ce5ab910b"),
		VoidwokenSpawn:Create(4, "LLENEMY_Animals_Frog_Merman_A_Giant_e110341a-14cd-4ade-a3e9-3ac25669637b")
	),
	-- Statues
	VoidwokenSpawnGroup:Create(34,
		VoidwokenSpawn:Create(1, "LLENEMY_Creatures_Voidwoken_GiantInsect_Dominator_A_6c6e07e6-6455-4599-b33d-888ec8aafc12"),
		VoidwokenSpawn:Create(3, "LLENEMY_Creatures_Statue_A_Voidwoken_abd8c14d-599e-48e2-bc29-4a42c40a5940", "LLENEMY_Creatures_Statue_A_Voidwoken_B_02dc4dfd-7b8b-4fd3-82c7-90dcee5f833c")
	),
	-- Tougher Enemies
	VoidwokenSpawnGroup:Create(40,
		VoidwokenSpawn:Create(1, "LLENEMY_Creatures_Voidwoken_Merman_A_3b414508-4ce6-475b-94cd-b389fc7f3bc1"),
		VoidwokenSpawn:Create(2, "LLENEMY_Creatures_Voidwoken_Troll_A_a4b68f95-5d9f-4e25-95d9-6a957b2f8e37", "LLENEMY_Creatures_Voidwoken_Troll_A_Ice_cc49f9c2-a5b9-4282-9808-b749fd0aa874")
	),
	VoidwokenSpawnGroup:Create(50,
		VoidwokenSpawn:Create(1, "LLENEMY_Quest_CoS_SeptaNemesis_Animals_Crab_A_Giant_cf3daf72-7f6c-49c4-bd4f-3459fd6c7c8b")),
	VoidwokenSpawnGroup:Create(60,
		VoidwokenSpawn:Create(1, "LLENEMY_Creatures_Voidwoken_Alan_A_Boss_d615894f-6cc1-4eae-9c6c-ffacf00f89bd")),
	VoidwokenSpawnGroup:Create(70,
		VoidwokenSpawn:Create(1, "LLENEMY_Creatures_Nightmare_Werewolf_A_6d57af19-aebf-4893-b0c3-3d96f140ae2f"))
}

VoidwokenGroups = voidwokenGroups

local function GetTotalPointsForRegion(source)
	local region = GetRegion(source)
	local pointsDB = Osi.DB_LLENEMY_HardMode_SourcePointsUsed:Get(region, nil)
	if pointsDB ~= nil and #pointsDB > 0 then
		local points = pointsDB[1][2]
		if points ~= nil then
			return points
		end
	end
	return 0
end

local totalResets = 0

function SpawnVoidwoken(source,totalPoints,skipSpawning)
	local totalPointsUsed = 0
	if totalPoints ~= nil then
		totalPointsUsed = totalPoints
	else
		local b,p = pcall(GetTotalPointsForRegion, source)
		if b then
			totalPointsUsed = p
		end
	end
	local voidwokenTemplates = {}
	for _,group in pairs(voidwokenGroups) do
		if totalPointsUsed >= group.MinPoints then
			for i=0,#group.Entries do
				table.insert(voidwokenTemplates, group.Entries[i])
			end
		end
	end

	if #voidwokenTemplates > 0 then
		LeaderLib.PrintDebug("Voidwoken Templates for SP("..tostring(totalPointsUsed).."): " .. LeaderLib.Common.Dump(voidwokenTemplates))
		local totalWeight = 0
		for i=1,#voidwokenTemplates do
			local entry = voidwokenTemplates[i]
			if entry.Weight > 0 then
				entry.Weight = entry.Weight + 1
			end
			totalWeight = totalWeight + entry.Weight
		end

		local rand = Ext.Random() * totalWeight
		local entry = nil
		voidwokenTemplates = LeaderLib.Common.ShuffleTable(voidwokenTemplates)
		for i,v in pairs(voidwokenTemplates) do
			--print(rand, v.Weight)
			if rand < v.Weight then
				entry = v
				v.Weight = 0
				break
			else
				rand = rand - v.Weight
			end
		end
		if entry ~= nil then
			LeaderLib.PrintDebug("Picked random entry: " .. entry.Template .. " | " ..tostring(rand) .. " / " .. tostring(totalWeight))
			if skipSpawning ~= true then
				totalResets = 0
				local x,y,z = GetPosition(source)
				local combatid = CombatGetIDForCharacter(source)
				if combatid ~= nil and combatid >= 0 then
					local combatEntries = Osi.DB_CombatCharacters:Get(nil,combatid)
					local randomEntry = LeaderLib.Common.GetRandomTableEntry(combatEntries)
					if randomEntry ~= nil then
						x,y,z = GetPosition(randomEntry[1])
					end
				end

				local voidwoken = CharacterCreateAtPosition(x, y, z, entry:GetTemplate(), 1)
				SetTag(voidwoken, "LLENEMY_DuplicationBlocked")
				ClearGain(voidwoken)
				SetFaction(voidwoken, "Evil NPC")
				CharacterLevelUpTo(voidwoken, CharacterGetLevel(source))
				TeleportToRandomPosition(voidwoken, 12.0, "")
				CharacterCharacterSetEvent(source, voidwoken, "LLENEMY_VoidwokenSpawned")
				if ObjectExists(voidwoken) == 0 then
					LeaderLib.PrintDebug("[LLENEMY_VoidwokenSpawning.lua:LLENEMY_SpawnVoidwoken] Failed to spawn voidwoken at (",x,y,z,")")
				else
					x,y,z = GetPosition(voidwoken)
					PlayEffectAtPosition("RS3_FX_GP_ScriptedEvent_FJ_Worm_Voidwoken_Spawning_01", x,y,z)
				end
			end
		elseif totalResets < 30 then
			totalResets = totalResets + 1
			LeaderLib.PrintDebug("[LLENEMY_VoidwokenSpawning.lua:LLENEMY_SpawnVoidwoken] No entry picked! Resetting.")
			for i,v in pairs(voidwokenTemplates) do
				v.Weight = v.DefaultWeight
			end
			SpawnVoidwoken(source, totalPointsUsed, skipSpawning)
		end
	end
end

local magicPointsVoidwokenChances = {
	[0] = 0,
	[1] = 2,
	[2] = 7,
	[3] = 15,
	[4] = 20,
	[5] = 25,
	[6] = 30
}

local pointsModC = 0
local pointsModD = 10.7
local pointsModB = 3.4

local function DetermineTotalSPModifier(total)
	return 1 - (((pointsModB - total * pointsModD) / (pointsModC * total + pointsModB)) / 100)
end

if Ext.IsDeveloperMode() then
	Ext.RegisterConsoleCommand("llenemy_totalspmod", function(cmd, totalstr)
		
	end)
end

--- Gets a chance threshold for spawning voidwoken, based on the source points cost of a skill.
---@param points integer
---@return integer
local function GetVoidwokenSpawnChanceRollThreshold(points, totalPointsUsed)
	if points >= #magicPointsVoidwokenChances then
		return 35
	else
		return math.min(35, math.ceil(magicPointsVoidwokenChances[points] * DetermineTotalSPModifier(totalPointsUsed)))
	end
end

if IgnoredSourceSkills == nil then
	IgnoredSourceSkills = {}
end

IgnoredSourceSkills["Target_Bless"] = {
	CombatOnly = true
}

IgnoredSourceSkills["Target_Curse"] = {
	CombatOnly = true
}

local function SkillCanSummonVoidwoken(char, skill, skilltype, skillelement)
	if IgnoredSourceSkills[skill] ~= nil then
		local ignoreData = IgnoredSourceSkills[skill]
		if ignoreData == true then
			return false
		elseif CharacterIsInCombat(char) == 0 and type(ignoreData) == "table" and ignoreData.CombatOnly == true then
			return false
		end
	end
	local magicCost = Ext.StatGetAttribute(skill, "Magic Cost") or 0
	if magicCost > 0 then
		return magicCost
	end
	return false
end
Ext.NewQuery(SkillCanSummonVoidwoken, "LLENEMY_QRY_SkillCanSummonVoidwoken", "[in](CHARACTERGUID)_Character, [in](STRING)_Skill, [in](STRING)_SkillType, [in](STRING)_SkillElement, [out](INTEGER)_Bool");

local function TrySummonVoidwoken(char)
	local totalPointsUsed = 0
	local b,p = pcall(GetTotalPointsForRegion, char)
	if b then
		totalPointsUsed = p
	end
	local chance = GetVoidwokenSpawnChanceRollThreshold(magicCost, totalPointsUsed)
	local roll = Ext.Random(0,100)
	LeaderLib.PrintDebug("[LLENEMY_VoidwokenSpawning.lua:TrySummonVoidwoken] Roll: ["..tostring(roll).."/100 <= "..tostring(chance).."] TotalSP ("..tostring(totalPointsUsed)..").")
	if roll > 0 and roll <= chance then
		SpawnVoidwoken(char, totalPointsUsed)
	elseif roll == 0 then
		Osi.LLENEMY_HardMode_ReduceTotalSourceUsed(Ext.Random(1,3))
	end
end

local function GetSourceDegredation(gameHourSpeed, totalPoints)
	-- Speed is 300000 by default, i.e. 5 minutes
	local mult = gameHourSpeed / 300000
	local min = math.max(1, math.floor(2 * mult))
	local max = math.min(min * 2, (math.max(6, totalPoints / 2)))
	local ran = Ext.Random(min, max)
	LeaderLib.PrintDebug("[LLENEMY_VoidwokenSpawning.lua:GetSourceDegredation] SP degredation speed ("..tostring(min).."-"..tostring(max)..") => ("..tostring(ran)..") TotalSP("..tostring(totalPoints)..") gameHourSpeed("..tostring(gameHourSpeed)..").")
	return ran
end

GetSourceDegredation = GetSourceDegredation

Ext.NewQuery(GetSourceDegredation, "LLENEMY_Ext_QRY_GetSourceDegredation", "[in](INTEGER)_GameHourSpeed, [in](INTEGER)_TotalPoints, [out](INTEGER)_DegredationAmount")