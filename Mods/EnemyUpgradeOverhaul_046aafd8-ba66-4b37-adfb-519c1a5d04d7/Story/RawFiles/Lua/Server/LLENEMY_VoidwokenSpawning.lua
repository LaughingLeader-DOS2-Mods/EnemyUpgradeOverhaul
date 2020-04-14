
---@class VoidwokenSpawn
local VoidwokenSpawn = {
	Template = "",
	Weight = 0,
	DefaultWeight = 0
}
VoidwokenSpawn.__index = VoidwokenSpawn

---@param weight number
---@param template string
---@return VoidwokenSpawn
function VoidwokenSpawn:Create(weight, template)
    local this =
    {
		Template = template,
		Weight = weight,
		DefaultWeight = weight
	}
	setmetatable(this, self)
    return this
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

local voidwokenGroups = {
	-- Easy
	VoidwokenSpawnGroup:Create(0,
		VoidwokenSpawn:Create(10, "Creatures_Voidwoken_Drillworm_A_Hatchling_ABC_1c1ca5fc-19c1-4a52-af88-8ee346d72cfe"),
		VoidwokenSpawn:Create(10, "Creatures_Voidwoken_Drillworm_A_Hatchling_B_9b929973-72a8-4e06-9357-acfcf3278f5e")),
	-- Somewhat Easy
	VoidwokenSpawnGroup:Create(4,
		VoidwokenSpawn:Create(8, "Animals_Turtle_A_Voidwoken_df421d91-2be6-4388-b3d9-fa01d915f346")),
	-- Other Animals
	VoidwokenSpawnGroup:Create(7,
		VoidwokenSpawn:Create(4, "Creatures_Demon_Hound_A_0b385807-7de8-42e9-bda2-c9a7e76da496"),
		VoidwokenSpawn:Create(4, "Animals_Bear_A_Voidwoken_a0f68491-6af5-4190-9c45-c4559d29c08f")),
	-- Drillworms
	VoidwokenSpawnGroup:Create(9,
		VoidwokenSpawn:Create(3, "LLENEMY_Creatures_Voidwoken_Drillworm_A_b24d5c4c-8a5a-4cd7-8518-f4684509be66"),
		VoidwokenSpawn:Create(3, "LLENEMY_Creatures_Voidwoken_Drillworm_B_8713b59d-a564-4b90-910c-e5c6a384c0d9")),
	-- Bats
	VoidwokenSpawnGroup:Create(14,
		VoidwokenSpawn:Create(3, "Creatures_VampireBat_A_42b7dd91-52e2-40c9-97a7-e38410626d9f"),
		VoidwokenSpawn:Create(3, "Creatures_VampireBat_B_0fae6595-88c3-4e62-9ace-fc011a9bdbce")),	
	-- Giant Insects
	VoidwokenSpawnGroup:Create(12,
		VoidwokenSpawn:Create(7, "Creatures_GiantInsect_A_Wings_9f05d133-4220-4196-a337-80c1f444c6e7"),
		VoidwokenSpawn:Create(7, "Creatures_GiantInsect_B_Wings_43d2c6db-2a93-4204-b0a0-ee19537fe14f"),
		VoidwokenSpawn:Create(7, "Creatures_GiantInsect_C_Wings_5aa20d6e-e354-45c0-8433-a817674c7d98"),
		VoidwokenSpawn:Create(6, "Creatures_Voidwoken_Spider_A_e1e91da4-e8f7-41dc-9c1f-9ea77c5e62d8"),
		VoidwokenSpawn:Create(6, "Creatures_Voidwoken_Spider_A_Poison_2a6e2e75-004a-489e-8a25-7edab7a22603"),
		VoidwokenSpawn:Create(1, "Creatures_Voidwoken_GiantInsect_Dominator_A_187c09ee-edeb-4246-89bf-89aae0d77244")),
	-- Grunts etc
	VoidwokenSpawnGroup:Create(16,
		VoidwokenSpawn:Create(4, "Creatures_Voidwoken_Caster_aa02c121-3200-44ce-a9e9-d22c46ac848e"),
		VoidwokenSpawn:Create(4, "Creatures_Voidwoken_Caster_Ice_598c927b-7fb2-4244-a791-15668fefe715"),
		VoidwokenSpawn:Create(4, "Creatures_Voidwoken_Grunt_A_5c702815-5a42-43fd-83f8-f6a321803ebe"),
		VoidwokenSpawn:Create(4, "Creatures_Voidwoken_Grunt_A_Ice_6ce20f23-6b29-4f3e-9b10-81e1d0a1e799")),
	VoidwokenSpawnGroup:Create(18,
		VoidwokenSpawn:Create(4, "Animals_Salamander_A_Voidwoken_5c0f4a3b-1640-4925-8993-826452655435")),
	-- Statues
	VoidwokenSpawnGroup:Create(20,
		VoidwokenSpawn:Create(3, "Creatures_Statue_A_Voidwoken_9001799c-26c1-4551-8bf2-17df0ca9f6c3"),
		VoidwokenSpawn:Create(3, "Creatures_Statue_A_Voidwoken_B_6e948a1d-e0e4-4dcb-bb61-0392d79b6a10")),
	-- Tougher Enemies
	VoidwokenSpawnGroup:Create(24,
		VoidwokenSpawn:Create(1, "Creatures_Voidwoken_Merman_A_b84112a6-b3b7-476b-b5cc-1c9c5deb1ba1"),
		VoidwokenSpawn:Create(2, "Creatures_Voidwoken_Troll_A_e3727ad8-152c-4d2a-8c71-8093a5e68839"),
		VoidwokenSpawn:Create(2, "Creatures_Voidwoken_Troll_A_Ice_b7ebea68-d4bf-4b8b-bace-f400f2448c94")),
	VoidwokenSpawnGroup:Create(30,
		VoidwokenSpawn:Create(1, "Quest_CoS_SeptaNemesis_Animals_Crab_A_Giant_a360f2c5-92e4-426e-8856-d42d7ec6467f")),
	VoidwokenSpawnGroup:Create(40,
		VoidwokenSpawn:Create(1, "Creatures_Voidwoken_Alan_A_Boss_8d10d59e-2060-43d9-8345-3222e3b3c424"))
}

EnemyUpgradeOverhaul.VoidwokenGroups = voidwokenGroups

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

function LLENEMY_Ext_SpawnVoidwoken(source,testing,totalPoints)
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
		LeaderLib.Print("Voidwoken Templates for SP("..tostring(totalPointsUsed).."): " .. LeaderLib.Common.Dump(voidwokenTemplates))
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
			LeaderLib.Print("Picked random entry: " .. entry.Template .. " | " ..tostring(rand) .. " / " .. tostring(totalWeight))
			if testing ~= true then
				local x,y,z = GetPosition(source)
				local voidwoken = CharacterCreateAtPosition(x, y, z, entry.Template, 1)
				SetFaction(voidwoken, "Evil NPC")
				TeleportToRandomPosition(voidwoken, 16.0, "")
				LLENEMY_Ext_ClearGain(voidwoken)
				if ObjectExists(voidwoken) == 0 then
					LeaderLib.Print("[LLENEMY_VoidwokenSpawning.lua:LLENEMY_SpawnVoidwoken] Failed to spawn voidwoken at (",x,y,z,")")
				end
			end
		else
			LeaderLib.Print("[LLENEMY_VoidwokenSpawning.lua:LLENEMY_SpawnVoidwoken] No entry picked! Resetting.")
			for i,v in pairs(voidwokenTemplates) do
				v.Weight = v.DefaultWeight
			end
			LLENEMY_Ext_SpawnVoidwoken(source, testing)
		end
	end
end

local magicPointsVoidwokenChances = {
	[0] = 0,
	[1] = 10,
	[2] = 25,
	[3] = 40,
	[4] = 65,
	[5] = 75,
	[6] = 85,
}

local pointsModC = 0
local pointsModD = 10.7
local pointsModB = 3.4

local function DetermineTotalSPModifier(total)
	return 1 - (((pointsModB - total * pointsModD) / (pointsModC * total + pointsModB)) / 100)
end

--- Gets a chance threshold for spawning voidwoken, based on the source points cost of a skill.
---@param points integer
---@return integer
local function GetVoidwokenSpawnChanceRollThreshold(points, totalPointsUsed)
	if points >= #magicPointsVoidwokenChances then
		return 90
	else
		return math.max(90, math.ceil(magicPointsVoidwokenChances[points] * DetermineTotalSPModifier(totalPointsUsed)))
	end
end

local function TrySummonVoidwoken(char, skill, skilltype, skillelement)
	local magicCost = Ext.StatGetAttribute(skill, "Magic Cost")
	if magicCost > 0 then
		Osi.LLENEMY_HardMode_TrackTotalSourceUsed(magicCost)
		local totalPointsUsed = 0
		local b,p = pcall(GetTotalPointsForRegion, char)
		if b then
			totalPointsUsed = p
		end
		LeaderLib.Print("[LLENEMY_VoidwokenSpawning.lua:TrySummonVoidwoken] Character ("..char..") cast a source skill ("..skill..")["..tostring(magicCost).."].")
		local chance = GetVoidwokenSpawnChanceRollThreshold(magicCost, totalPointsUsed)
		local roll = Ext.Random(0,100)
		LeaderLib.Print("[LLENEMY_VoidwokenSpawning.lua:TrySummonVoidwoken] Roll: ["..tostring(roll).."/100 <= "..tostring(chance).."].")
		if roll <= chance then
			LLENEMY_Ext_SpawnVoidwoken(char)
		end
	end
end
Ext.NewCall(TrySummonVoidwoken, "LLENEMY_OnSkillCast_TrySummonVoidwoken", "(CHARACTERGUID)_Character, (STRING)_Skill, (STRING)_SkillType, (STRING)_SkillElement");