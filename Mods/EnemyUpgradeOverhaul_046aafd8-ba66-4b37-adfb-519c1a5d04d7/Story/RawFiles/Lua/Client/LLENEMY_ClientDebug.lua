local function LLENEMY_Debug_PrintTags(call, datastr)
	Ext.Print("[LLENEMY_ClientDebug.lua:PrintTags] Received data:\n"..tostring(datastr))
	local data = Ext.JsonParse(datastr)
	for i,entry in pairs(data) do
		local netid = entry[1]
		local character = Ext.GetCharacter(netid)
		if character ~= nil then
			Ext.Print("[LLENEMY_ClientDebug.lua:PrintTags] Tags for NetID("..tostring(netid)..") character.Stats.NetID("..tostring(character.Stats.NetID)..")")
			Ext.Print("==========================")
			Ext.Print(LeaderLib.Common.Dump(character:GetTags()))
			Ext.Print("==========================")
		else
			error("[LLENEMY_ClientDebug.lua:PrintTags] No character found for NetID ("..tostring(netid)..")!")
		end
	end
end

Ext.RegisterNetListener("LLENEMY_Debug_PrintTags", LLENEMY_Debug_PrintTags)