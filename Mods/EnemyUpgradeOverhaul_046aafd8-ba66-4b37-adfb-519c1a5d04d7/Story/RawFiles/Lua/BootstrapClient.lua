Ext.Require("Shared/Init.lua")
Ext.Require("Client/DescriptionParams.lua")
local tooltipHandler = Ext.Require("Client/TooltipHandler.lua")

if Ext.IsDeveloperMode() then
	Ext.Require("Client/ClientDebug.lua")
end

local function LLENEMY_Client_ModuleLoading()
	LLENEMY_Shared_InitModuleLoading()
end

Ext.RegisterListener("ModuleLoading", LLENEMY_Client_ModuleLoading)
--Ext.RegisterListener("ModuleResume", LLENEMY_Client_ModuleResume)

Ext.RegisterListener("SessionLoaded", function()
	tooltipHandler.Init()
end)

Ext.RegisterNetListener("LLENEMY_SetHighestLoremaster", function(call, valStr)
	HighestLoremaster = math.tointeger(valStr)
	Ext.Print("[EnemyUpgradeOverhaul:LLENEMY_SetHighestLoremaster] Set highest loremaster value to ("..valStr..") on client.")
end)