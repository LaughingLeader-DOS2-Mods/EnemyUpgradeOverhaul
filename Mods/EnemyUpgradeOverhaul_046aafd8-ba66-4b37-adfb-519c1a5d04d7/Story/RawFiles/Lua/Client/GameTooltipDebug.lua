local originalFunc = Game.Tooltip.TooltipHooks.OnRequestTooltip

local function PrintArrayValue(ui, index, arrayName)
	local val = ui:GetValue(arrayName, "number", index)
	if val == nil then
		val = ui:GetValue(arrayName, "string", index)
		if val == nil then
			val = ui:GetValue(arrayName, "boolean", index)
		else
			val = "\""..val.."\""
		end
	end
	if val ~= nil then
		print(" ["..index.."] = ["..tostring(val).."]")
	end
end

local function PrintArray(ui, arrayName)
	print("==============")
	print(arrayName)
	print("==============")
	local i = 0
	while i < 300 do
		PrintArrayValue(ui, i, arrayName)
		i = i + 1
	end
	print("==============")
end

--- @param ui UIObject
function Game.Tooltip.TooltipHooks.OnRequestTooltip(self, ui, method, arg1, arg2, arg3, ...)
	print("TooltipHooks.OnRequestTooltip", ui, method, arg1, arg2, arg3, Common.Dump({...}))
	pcall(originalFunc, self, ui, method, arg1, arg2, arg3, ...)
end

local function traceCompareData(ui, ...)
	print("traceCompareData", Common.Dump({...}))
	PrintArray(ui, "equipTooltip_array")
end

Ext.RegisterListener("SessionLoaded", function()
	Ext.RegisterUINameInvokeListener("updateEquipTooltip", traceCompareData)
	Ext.RegisterUINameInvokeListener("updateEquipOffhandTooltip", traceCompareData)

	---@type UIObject
	local ui = Ext.GetBuiltinUI("Public/Game/GUI/partyInventory.swf")
	if ui ~= nil then
		Ext.RegisterUIInvokeListener(ui, "updateEquipTooltip", traceCompareData)
		Ext.RegisterUIInvokeListener(ui, "updateEquipOffhandTooltip", traceCompareData)
		Ext.RegisterUIInvokeListener(ui, "showTooltip", traceCompareData)
		Ext.RegisterUIInvokeListener(ui, "INV_SendTooltipRequest", traceCompareData)
		Ext.RegisterUIInvokeListener(ui, "INV_ShowCellTooltip", traceCompareData)
		Ext.RegisterUIInvokeListener(ui, "updateItemTooltip", traceCompareData)
		Ext.RegisterUIInvokeListener(ui, "updateItems", traceCompareData)
		print("Listening for updateEquipTooltip in partyInventory")
	end
end)