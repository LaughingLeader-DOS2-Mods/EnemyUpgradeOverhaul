local function LLENEMY_RunServerCommand(call, command)
	Ext.Print("[LLENEMY_ServerMessages.lua:LLENEMY_RunServerCommand] Received message from client. Running command ("..tostring(command)..").")
	if command == Commands.CHECKLOREMASTER then
		TimerCancel("Timers_LLENEMY_CheckPartyLoremaster")
		TimerLaunch("Timers_LLENEMY_CheckPartyLoremaster", 1000)
	end
end

--Ext.RegisterNetListener("LLENEMY_RunServerCommand", LLENEMY_RunServerCommand)