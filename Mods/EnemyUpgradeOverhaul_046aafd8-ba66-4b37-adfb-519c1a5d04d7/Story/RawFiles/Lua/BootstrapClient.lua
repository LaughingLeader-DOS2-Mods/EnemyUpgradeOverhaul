Ext.Require("Shared/Init.lua")
Ext.Require("Client/DescriptionParams.lua")
Ext.Require("Client/ClientDebug.lua")
local tooltipHandler = Ext.Require("Client/TooltipHandler.lua")

local function LLENEMY_Client_ModuleLoading()
	LLENEMY_Shared_InitModuleLoading()
end

Ext.RegisterListener("ModuleLoading", LLENEMY_Client_ModuleLoading)
--Ext.RegisterListener("ModuleResume", LLENEMY_Client_ModuleResume)

local function LLENEMY_Client_SessionLoaded()
	--local ui = Ext.CreateUI("LLENEMY_Test_SecondHotbar", "Public/EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7/GUI/hotBar.swf", 99)
	--ui:Show()
	--ui:SetPosition(100, 300)
	--Ext.Print("================Created second hotbar?!=======================")
	tooltipHandler.Init()
end

Ext.RegisterListener("SessionLoaded", LLENEMY_Client_SessionLoaded)

Ext.RegisterNetListener("LLENEMY_SetHighestLoremaster", function(call, valStr)
	LeaderLib.PrintDebug("[LLENEMY_Shared.lua:LLENEMY_SetHighestLoremaster] Set highest loremaster value to ("..valStr..") on client.")
	HighestLoremaster = math.tointeger(valStr)
end)