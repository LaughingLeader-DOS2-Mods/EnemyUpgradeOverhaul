local recruiter = "S_GLO_LV_HenchmenRecruiter_ed64ea06-9060-4b29-88dd-623ab008fae6"

local positionData = {
	TUT_Tutorial_A = {
		Position = {74.445205688476563, 0.0, -304.47232055664063},
		Rotation = {0.98655122518539429, 0.16345222294330597},
	}
}

function SetupRecruiter(region)
	local data = positionData[region]
	if data ~= nil then
		local host = CharacterGetHostCharacter()
		TeleportTo(recruiter, host, "LLENEMY_HM_RecruiterTeleportedToLevel", 1, 0, 1)
		TeleportToPosition(recruiter, data.Position[1], data.Position[2], data.Position[3], "LLENEMY_HM_RecruiterTeleportedToPosition", 1, 0)
		GameHelpers.Math.SetRotation(recruiter, data.Rotation[1], data.Rotation[2])
	end
end