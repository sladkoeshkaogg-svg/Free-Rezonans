-- Mercury.txt
-- Скрипт-реплика интерфейса Mercury, использует SolarisUI (Library1.lua).
-- Поместите как LocalScript в PlayerGui или выполните через executor.

local success, Library = pcall(function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/katnaa-debug/SolarisUI/refs/heads/main/Library1.lua"))()
end)
if not success or type(Library) ~= "table" then
	warn("Не удалось загрузить SolarisUI. Проверьте доступ к raw.githubusercontent.com и возможности executor'а.")
	return
end

-- Создаём окно в точном (визуальном) стиле: вкладки, скругления, иконки — только UI, без логики
local Funcs = Library:CreateWindow({
	Title = "Mercury",
	Theme = {
		Main = Color3.fromRGB(12, 12, 12),
		Second = Color3.fromRGB(22, 22, 22),
		Accent = Color3.fromRGB(220, 220, 220),
		ElementAccent = Color3.fromRGB(170, 85, 255),
		GradientStart = Color3.fromRGB(150, 150, 150),
		GradientEnd = Color3.fromRGB(255, 255, 255),
		Text = Color3.fromRGB(240, 240, 240),
		TextDark = Color3.fromRGB(120, 120, 120),
		Error = Color3.fromRGB(255, 100, 100),
		Transparency = 0,
		HudTransparency = 0,
		ImageTransparency = 0,
		Font = "Gotham",
		Background = ""
	},
	CornerRadius = 25,
})

-- Иконки из ассетов (не эмодзи)
local ICONS = {
	PLAYER = "rbxassetid://10884490076",
	PROTECTION = "rbxassetid://10884488899",
	TARGET = "rbxassetid://10884494953",
	BLOBMAN = "rbxassetid://10884491769",
	GRABS = "rbxassetid://10884496263",
	SERVER = "rbxassetid://7059346373",
	FUN = "rbxassetid://10884488899",
	UI = "rbxassetid://7059346373"
}

-- Создаём вкладки в порядке, как на скриншоте (без логики внутри элементов)
local PlayerTab = select(1, Funcs:CreateTab("PLAYER", true, ICONS.PLAYER))
local ProtectionTab = select(1, Funcs:CreateTab("PROTECTION", true, ICONS.PROTECTION))
local TargetTab, ActivateTarget = Funcs:CreateTab("TARGET", true, ICONS.TARGET)
local BlobTab = select(1, Funcs:CreateTab("BLOBMAN TARGET", true, ICONS.BLOBMAN))
local GrabsTab = select(1, Funcs:CreateTab("GRABS", true, ICONS.GRABS))
local ServerTab = select(1, Funcs:CreateTab("SERVER", true, ICONS.SERVER))
local FunTab = select(1, Funcs:CreateTab("FUN", true, ICONS.FUN))

-- Вкладки и блоки — только визуальные элементы (кнопки, переключатели, слайдеры)
do -- PLAYER
	local blockL = PlayerTab:CreateBlock({Name = "Player Info", Side = "Left"})
	blockL:CreateSection("Profile")
	blockL:CreateButton({Name = "Open Profile"})
	blockL:CreateToggle({Name = "Show HUD", Default = true})

	local blockR = PlayerTab:CreateBlock({Name = "Settings", Side = "Right"})
	blockR:CreateSection("Appearance")
	blockR:CreateDropdown({Name = "Preset Pose", Items = {"Default", "Pose A"}, Default = "Default"})
end

do -- PROTECTION
	local L = ProtectionTab:CreateBlock({Name = "Protection", Side = "Left"})
	L:CreateSection("Safety")
	L:CreateToggle({Name = "Anti-Cheat", Default = true})
	local R = ProtectionTab:CreateBlock({Name = "Tools", Side = "Right"})
	R:CreateButton({Name = "Open Logs"})
end

do -- TARGET (двухколонная как на картинке)
	local left = TargetTab:CreateBlock({Name = "LP Bring (pose)", Side = "Left"})
	left:CreateDropdown({Name = "Set Target: You Clone", Items = {"You Clone"}, Default = "You Clone"})
	left:CreateDropdown({Name = "Load Preset Pose - Default", Items = {"Default"}, Default = "Default"})
	left:CreateInput({Name = "New Pose Name", Default = "My Pose"})
	left:CreateButton({Name = "Save Current Pose Config"})
	left:CreateButton({Name = "Delete Selected Pose Config"})
	left:CreateDropdown({Name = "Select Limb - Torso", Items = {"Torso"}, Default = "Torso"})
	left:CreateToggle({Name = "Show Limb Axes (X,Y,Z)", Default = false})
	left:CreateToggle({Name = "Mirror Mode (Sync Left/Right)", Default = false})
	left:CreateSlider({Name = "Pos X (Red Line)", Min = -180, Max = 180, Default = 0})
	left:CreateSlider({Name = "Pos Y (Green Line) - HEIGHT", Min = -180, Max = 180, Default = 40})

	local right = TargetTab:CreateBlock({Name = "loop object", Side = "Right"})
	right:CreateSection("loop object")
	right:CreateButton({Name = "Loop Snowball"})
	right:CreateButton({Name = "Base loop"})
	right:CreateButton({Name = "loop banana"})
	right:CreateButton({Name = "loop paint"})
	right:CreateButton({Name = "loop basketball"})
	right:CreateButton({Name = "loop campfire (burn)"})
end

do -- BLOBMAN TARGET
	local L = BlobTab:CreateBlock({Name = "Blobman Target", Side = "Left"})
	L:CreateSection("Blobman")
	L:CreateButton({Name = "Add Blob Target"})
	local R = BlobTab:CreateBlock({Name = "Options", Side = "Right"})
	R:CreateToggle({Name = "Enable Blob Visuals", Default = true})
end

for _, tab in pairs({GrabsTab, ServerTab, FunTab}) do
	local l = tab:CreateBlock({Name = "Main", Side = "Left"})
	l:CreateSection("Controls")
	l:CreateButton({Name = "Action"})
	local r = tab:CreateBlock({Name = "More", Side = "Right"})
	r:CreateToggle({Name = "Enable Feature", Default = false})
end

-- UI Settings: (library already creates Settings tab; local duplicate removed)

-- Убираем прозрачность у фоновых фреймов и строк в созданном интерфейсе (делает элементы полностью непрозрачными)
local function RemoveTransparency()
	local CG = game:GetService("CoreGui")
	local Plrs = game:GetService("Players")
	local LP = Plrs.LocalPlayer
	local gui = CG:FindFirstChild("MainUI") or (LP and LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("MainUI"))
	if not gui then
		for i = 1, 10 do
			task.wait(0.1)
			gui = CG:FindFirstChild("MainUI") or (LP and LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("MainUI"))
			if gui then break end
		end
	end
	if not gui then return end
	for _, obj in ipairs(gui:GetDescendants()) do
		if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			pcall(function() obj.BackgroundTransparency = 0 end)
		end
		if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
			pcall(function() obj.ImageTransparency = 0 end)
		end
		if obj:IsA("UIStroke") then
			pcall(function() obj.Transparency = 0 end)
		end
	end
end

-- Активируем вкладку TARGET чтобы соответствовать скриншоту
pcall(function() ActivateTarget() end)
-- Отложенно убираем прозрачность, когда GUI создался и анимации прошли
task.spawn(function()
	task.wait(0.25)
	RemoveTransparency()
end)

print("Готово: Mercury UI (визуальная реплика) записана в этот файл.")

