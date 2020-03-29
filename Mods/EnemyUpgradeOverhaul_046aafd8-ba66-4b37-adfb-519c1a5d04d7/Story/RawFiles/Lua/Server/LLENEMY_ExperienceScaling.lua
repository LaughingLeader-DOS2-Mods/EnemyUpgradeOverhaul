function LLENEMY_Ext_SetExperienceScaling(bstr)
	Ext.BroadcastMessage("LLENEMY_SetExperienceScaling", bstr, nil)
end

local function FlattenTable(tbl)
	local result = { }
		
	local function flatten(tbl)
		for _, v in ipairs(tbl) do
			if type(v) == "table" then
				flatten(v)
			else
				table.insert(result, v)
			end
		end
	end
	
	flatten(tbl)
	return result
end

local function BuildPartyStructure()
	local players = FlattenTable(Osi.DB_IsPlayer:Get(nil))
	local partyLeaders = {}
	local highestLevel = 1

	Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:BuildPartyStructure] Players: (".. LeaderLib.Common.Dump(players) ..").")

	local tableEmpty = true
	for i,v in pairs(players) do
		local level = CharacterGetLevel(v)
		if level > highestLevel then highestLevel = level end
		if tableEmpty then
			Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:BuildPartyStructure] partyLeaders count is 0. Adding to table. ("..v..")")
			partyLeaders[v] = {}
			tableEmpty = false
		else
			for leader,members in pairs(partyLeaders) do
				if v ~= leader then
					if CharacterIsInPartyWith(leader, v) == 1 then
						Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:BuildPartyStructure] (".. v ..") is in a party with ("..leader..")?")
						members[#members+1] = v
					else
						Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:BuildPartyStructure] (".. v ..") is not in a party with ("..leader..")?")
						partyLeaders[v] = {}
					end
				end
			end
		end
	end
	Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:BuildPartyStructure] Party leader structure: (".. LeaderLib.Common.Dump(partyLeaders) ..").")
	return partyLeaders,highestLevel
end

function LLENEMY_Ext_GrantExperience(char)
	local stats = nil
	local character = Ext.GetCharacter(char)
	if character ~= nil then
		stats = character.Stats.Name
	end
	if stats == nil then stats = GetStatString(char) end
	if stats ~= nil then
		local gain = NRD_StatGetInt(stats, "Gain")
		if gain > 0 then
			Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:LLENEMY_Ext_GrantExperience] Granting experience to all players scaled by (" .. tostring(gain) ..") gain. ")
			local partyStructure,highestLevel = BuildPartyStructure()
			for leader,members in pairs(partyStructure) do
				PartyAddExperience(leader, 1, highestLevel, gain)
				Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:LLENEMY_Ext_GrantExperience] Granting xp to party of (" .. tostring(leader) ..") scaled to level ("..tostring(highestLevel).."). ")
			end
		else
			if Ext.IsDeveloperMode() then
				Ext.Print("[LLENEMY:Server:LLENEMY_ExperienceScaling.lua:LLENEMY_Ext_GrantExperience] Skipping experience for (" .. tostring(char) ..") since Gain is 0. ")
			end
		end
	end
end