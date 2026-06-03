local success, Library = pcall(function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/katnaa-debug/SolarisUI/refs/heads/main/Library1.lua"))()
end)
if not success or type(Library) ~= "table" then
	warn("Не удалось загрузить SolarisUI. Проверьте доступ к raw.githubusercontent.com и возможности executor'а.")
	return
end

local Funcs = Library:CreateWindow({
	Title = "Mercury",
	Theme = "Default",
	CornerRadius = 25,
})

local ICONS = {
    PLAYER = "7072706905",
    PROTECTION = "7072706289",
    TARGET = "7072706559",
    BLOBMAN = "7072706720",
    GRABS = "7072706843",
    SERVER = "7072706974",
}

local PlayerTab = select(1, Funcs:CreateTab("PLAYER", true, ICONS.PLAYER))
local ProtectionTab = select(1, Funcs:CreateTab("PROTECTION", true, ICONS.PROTECTION))
local TargetTab, ActivateTarget = Funcs:CreateTab("TARGET", true, ICONS.TARGET)
local BlobTab = select(1, Funcs:CreateTab("BLOBMAN TARGET", true, ICONS.BLOBMAN))
local GrabsTab = select(1, Funcs:CreateTab("GRABS", true, ICONS.GRABS))
local ServerTab = select(1, Funcs:CreateTab("SERVER", true, ICONS.SERVER))

do -- PLAYER (точная реплика вкладки)
	local movement = PlayerTab:CreateBlock({Name = "Movement", Side = "Left"})
	movement:CreateSection("Teleport")
	movement:CreateToggle({Name = "Loop Teleport", Default = false})
	movement:CreateDropdown({Name = "Teleport Location - Spawn", Items = {"Spawn", "Spawn Area", "Custom"}, Default = "Spawn"})
	movement:CreateButton({Name = "Teleport Once"})
	movement:CreateToggle({Name = "Teleport to Mouse (key - Z)", Default = false})

	movement:CreateSection("Speed")
	movement:CreateSlider({Name = "Speed Control", Min = 0, Max = 100, Default = 16})
	movement:CreateToggle({Name = "Enable Speed", Default = false})

	movement:CreateSection("Jump")
	movement:CreateSlider({Name = "Jump Power", Min = 10, Max = 200, Default = 50})
	movement:CreateToggle({Name = "Infinite Jump", Default = false})
	movement:CreateToggle({Name = "Noclip", Default = false})

	movement:CreateSection("Camera")
	movement:CreateToggle({Name = "Third Person", Default = false})

	local visuals = PlayerTab:CreateBlock({Name = "Visual & Animations", Side = "Right"})
	visuals:CreateSection("Visual & Animations")
	visuals:CreateButton({Name = "PCLD Color (open picker)"})
	visuals:CreateToggle({Name = "PCLD ESP", Default = false})
	visuals:CreateToggle({Name = "Anti kick ESP", Default = false})

	visuals:CreateSection("Animations")
	visuals:CreateToggle({Name = "Throwed Animation", Default = false})
	visuals:CreateToggle({Name = "Jerk Animation", Default = false})

	visuals:CreateSection("Walks")
	visuals:CreateToggle({Name = "Water Walk", Default = false})
	visuals:CreateToggle({Name = "Safe Pos (lock)", Default = false})

	visuals:CreateSection("Field of View")
	visuals:CreateSlider({Name = "FOV Value", Min = 30, Max = 120, Default = 70})
	visuals:CreateToggle({Name = "Enable Custom FOV", Default = false})
end

do -- PROTECTION (replica from screenshot)
	local L = ProtectionTab:CreateBlock({Name = "Protection", Side = "Left"})
	L:CreateSection("Anti")
	L:CreateToggle({Name = "Anti Barrier (Noclip)", Default = false})
	L:CreateToggle({Name = "Anti Blobman", Default = false})
	L:CreateToggle({Name = "Anti Paint", Default = false})
	L:CreateToggle({Name = "Anti Explode", Default = false})
	L:CreateToggle({Name = "Anti Burn", Default = false})
	L:CreateToggle({Name = "Anti Loop (TP pink house)", Default = false})
	L:CreateToggle({Name = "Anti [falling ragdoll]", Default = false})
	L:CreateToggle({Name = "Anti Banana (Aura)", Default = false})
	L:CreateButton({Name = "Anti Banana (delete legs)"})

	L:CreateSection("Counter Attack Method")
	L:CreateDropdown({Name = "Select Method - Ownership", Items = {"Ownership", "Damage", "Teleport"}, Default = "Ownership"})
	L:CreateToggle({Name = "Enable Method", Default = false})

	L:CreateSection("Self Grab Blobman (Pink house)")
	L:CreateDropdown({Name = "Self Grab Method - Normal", Items = {"Normal", "Aggressive"}, Default = "Normal"})
	L:CreateToggle({Name = "Keep Blob in House", Default = false})
	L:CreateButton({Name = "Self Grab"})

	local R = ProtectionTab:CreateBlock({Name = "Options", Side = "Right"})
	R:CreateSection("Void Distance")
	R:CreateDropdown({Name = "Void Method - Base Void", Items = {"Base Void", "Extended Void"}, Default = "Base Void"})
	R:CreateToggle({Name = "Loop Void TP", Default = false})

	R:CreateSection("Anti All")
	R:CreateToggle({Name = "Circle Around Spawn", Default = false})
	R:CreateSlider({Name = "Radius", Min = 0, Max = 1000, Default = 1000})

	R:CreateSection("Destroyer Ragdoll object (fire)[Beta]")
	R:CreateToggle({Name = "Enable Destroyer", Default = false})
end

do -- TARGET
	local left = TargetTab:CreateBlock({Name = "Selection", Side = "Left"})
	left:CreateSection("Selection")
	left:CreateInput({Name = "Search Player"})
	left:CreateDropdown({Name = "Select Player", Items = {"Player1"}, Default = "Player1"})
	left:CreateButton({Name = "Select Target by Mouse"})
	
	left:CreateSection("Permanent Pallet")
	left:CreateDropdown({Name = "Ragdoll pallet", Items = {"Ragdoll"}, Default = "Ragdoll"})
	
	left:CreateSection("Removed")
	left:CreateToggle({Name = "Remove Anti Kick (Aura)", Default = false})
	left:CreateButton({Name = "Remove Gucci", Suffix = "Five"})
	left:CreateButton({Name = "Infinity Owner (only seat target)", Suffix = "Six"})
	left:CreateToggle({Name = "Steal Toys to Sit On", Default = false})
	left:CreateToggle({Name = "Auto Infinity Owner", Default = false})

	local right = TargetTab:CreateBlock({Name = "Select method kick", Side = "Right"})
	right:CreateSection("Select method kick")
	right:CreateDropdown({Name = "Kick Methods - Anti-Running Kick", Items = {"Anti-Running Kick"}, Default = "Anti-Running Kick"})
	right:CreateToggle({Name = "Enable Selected Kick", Default = false})
	
	right:CreateSection("Position selection")
	right:CreateSlider({Name = "X Position", Min = 0, Max = 100, Default = 6})
	right:CreateSlider({Name = "Y Position", Min = 0, Max = 100, Default = 10})
	right:CreateSlider({Name = "Z Position", Min = 0, Max = 100, Default = 0})
	
	right:CreateSection("Quick Kill")
	right:CreateButton({Name = "One Kill", Suffix = "Eight"})
	
	right:CreateSection("loop object")
	right:CreateToggle({Name = "loop object", Default = false})
	right:CreateToggle({Name = "loop banana", Default = false})
	right:CreateToggle({Name = "loop snowball", Default = false})
end

do -- BLOBMAN TARGET
	local left = BlobTab:CreateBlock({Name = "Selection", Side = "Left"})
	left:CreateSection("Selection")
	left:CreateInput({Name = "Search Player"})
	left:CreateDropdown({Name = "Select Target", Items = {"Target1"}, Default = "Target1"})
	left:CreateButton({Name = "Select Target by Mouse", Suffix = "M"})
	
	left:CreateSection("Helps & Esp")
	left:CreateButton({Name = "Keybinds"})
	left:CreateButton({Name = "Spawn [Blobman]", Suffix = "N"})
	left:CreateButton({Name = "TP - nearest [Blobman]", Suffix = "B"})
	
	left:CreateSection("ESP")
	left:CreateButton({Name = "ESP Color"})
	left:CreateToggle({Name = "ESP All Blobman", Default = false})
	left:CreateToggle({Name = "Blobman Name Tags", Default = false})
	left:CreateToggle({Name = "Ragdoll in Blob", Default = false})

	local right = BlobTab:CreateBlock({Name = "Select Kick Method (Blobman)", Side = "Right"})
	right:CreateSection("Select Kick Method (Blobman)")
	right:CreateDropdown({Name = "Kick Methods - Blob Kick", Items = {"Blob Kick"}, Default = "Blob Kick"})
	right:CreateToggle({Name = "Enable Selected Method", Default = false})
	
	right:CreateSection("Blobman Auras")
	right:CreateToggle({Name = "Kill Aura", Default = false})
	right:CreateToggle({Name = "Kick Aura", Default = false})
	right:CreateToggle({Name = "Lock Aura", Default = false})
end

do -- GRABS
	local left = GrabsTab:CreateBlock({Name = "Grab lock Selection", Side = "Left"})
	left:CreateSection("Grab lock Selection")
	left:CreateInput({Name = "Search Player"})
	left:CreateDropdown({Name = "Select Lock Target", Items = {"Target1"}, Default = "Target1"})
	left:CreateButton({Name = "lock Target - Mouse", Suffix = "V"})
	
	left:CreateSection("Grab Modifiers")
	left:CreateSlider({Name = "Throw Force", Min = 0, Max = 500, Default = 200})
	left:CreateToggle({Name = "Super Strength (RMB)", Default = false})
	left:CreateToggle({Name = "Massless Grab", Default = false})
	left:CreateSlider({Name = "Spin Speed", Min = 0, Max = 100, Default = 50})
	left:CreateToggle({Name = "Spin Grab", Default = false})
	left:CreateToggle({Name = "Noclip Grab", Default = false})
	
	left:CreateSection("Jitter Mode [Pallet]")
	left:CreateToggle({Name = "Enable Jitter Mode", Default = false})
	left:CreateButton({Name = "Magnet Key [Hold]", Suffix = "Q"})

	local right = GrabsTab:CreateBlock({Name = "Void Kill", Side = "Right"})
	right:CreateSection("Void Kill")
	right:CreateButton({Name = "Kill at void -150"})
	right:CreateSlider({Name = "Death Height", Min = -500, Max = 0, Default = -150})
	
	right:CreateSection("Grab Aim")
	right:CreateButton({Name = "Grab Aim Key", Suffix = "Q"})
	right:CreateToggle({Name = "Enable Lock", Default = false})
	
	right:CreateSection("Grab Attacks")
	right:CreateToggle({Name = "Kill Grab", Default = false})
	right:CreateToggle({Name = "Kick Grab", Default = false})
	right:CreateToggle({Name = "Ragdoll Grab", Default = false})
	
	right:CreateSection("Auras")
	right:CreateDropdown({Name = "Select Aura - Ragdoll", Items = {"Ragdoll"}, Default = "Ragdoll"})
	right:CreateToggle({Name = "Enable Aura", Default = false})
end

for _, tab in pairs({ServerTab}) do
	local l = tab:CreateBlock({Name = "Main", Side = "Left"})
	l:CreateSection("Controls")
	l:CreateButton({Name = "Action"})
	local r = tab:CreateBlock({Name = "More", Side = "Right"})
	r:CreateToggle({Name = "Enable Feature", Default = false})
end


pcall(function() ActivateTarget() end)

print("Готово: Mercury UI (визуальная реплика) записана в этот файл.")

