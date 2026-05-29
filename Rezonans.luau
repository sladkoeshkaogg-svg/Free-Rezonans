-- Resonanse V2.7 | FTAP111134442424234113123211243242344
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local targetNotifyConnections = {}

local Window = Library:CreateWindow({
    Title = "13639308986",
    Footer = "Project Resonanse V2.7 | FTAP",
    Icon = 13639308986,
    NotifySide = "Right",
    ShowCustomCursor = true,
  EnableCompacting = true,
  SidebarCompacted = true,
  CornerRadius = 15
})

ThemeManager:SetLibrary(Library)
ThemeManager:SetDefaultTheme({
    AccentColor = Color3.fromRGB(255, 215, 0),
    OutlineColor = Color3.fromRGB(80, 80, 80),
    FontFace = "BuilderSans",
})

local Tabs = {
    Defence = Window:AddTab("Defence", "house"),
    Visuals = Window:AddTab("Visuals", "​accessibility"),
    Grabs = Window:AddTab("Grabs", "hand"),
    Security = Window:AddTab("Security", "shield"),
    Target = Window:AddTab("Target", "crosshair"),
    Blobmen = Window:AddTab("Blobmen", "skull"),
    UISettings = Window:AddTab("UI Settings", "​shapes"),
}

-- Увеличить высоту текста в Obsidian на 1.2x
task.wait(0.3)
local function increaseTextSize(obj, multiplier)
    for _, child in ipairs(obj:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextSize = math.floor(child.TextSize * multiplier)
        end
    end
end
increaseTextSize(Window, 1.2)

-- FPS/MS Monitor
local fpsGui = CoreGui:FindFirstChild("GGOGFPSWindow")
if not fpsGui then
    fpsGui = Instance.new("ScreenGui")
    fpsGui.Name = "GGOGFPSWindow"
    fpsGui.ResetOnSpawn = false
    fpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fpsGui.Parent = CoreGui
end

local fpsFrame = fpsGui:FindFirstChild("FPSFrame")
if not fpsFrame then
    fpsFrame = Instance.new("Frame")
    fpsFrame.Name = "FPSFrame"
    fpsFrame.Size = UDim2.new(0, 200, 0, 27)
    fpsFrame.Position = UDim2.new(0.5, -100, 0.3, -20)
    fpsFrame.BackgroundColor3 = Color3.new(0.06, 0.06, 0.06)
    fpsFrame.BorderSizePixel = 0
    fpsFrame.ZIndex = 1000000
    fpsFrame.Active = true
    fpsFrame.Parent = fpsGui
    Instance.new("UICorner", fpsFrame).CornerRadius = UDim.new(0, 20)

    local fpsStroke = Instance.new("UIStroke")
    fpsStroke.Parent = fpsFrame
    fpsStroke.Color = Color3.new(1, 1, 1)
    fpsStroke.Transparency = 0.8
    fpsStroke.Thickness = 1
end

local fpsValue = fpsFrame:FindFirstChild("FPSValue")
if not fpsValue then
    fpsValue = Instance.new("TextLabel")
    fpsValue.Name = "FPSValue"
    fpsValue.Size = UDim2.new(1, -16, 1, -8)
    fpsValue.Position = UDim2.new(0, 8, 0, 4)
    fpsValue.BackgroundTransparency = 1
    fpsValue.Active = true
    fpsValue.Selectable = true
    fpsValue.Font = Enum.Font.GothamBold
    fpsValue.TextSize = 11
    fpsValue.TextColor3 = Color3.new(1, 1, 1)
    fpsValue.Text = "🌙 FPS: ... | MS: ..."
    fpsValue.TextXAlignment = Enum.TextXAlignment.Left
    fpsValue.TextYAlignment = Enum.TextYAlignment.Center
    fpsValue.Parent = fpsFrame
end

if not _G.GGOGFPSInitialized then
    _G.GGOGFPSInitialized = true

    local fpsDragging = false
    local fpsDragStart = Vector2.new(0, 0)
    local fpsStartPos = nil
    local fpsMouseOver = false

    fpsFrame.MouseEnter:Connect(function()
        fpsMouseOver = true
    end)
    fpsFrame.MouseLeave:Connect(function()
        fpsMouseOver = false
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if fpsMouseOver then
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                fpsDragging = true
                fpsDragStart = UserInputService:GetMouseLocation()
                fpsStartPos = fpsFrame.Position
            elseif input.UserInputType == Enum.UserInputType.Touch then
                fpsDragging = true
                fpsDragStart = input.Position
                fpsStartPos = fpsFrame.Position
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            fpsDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input, gameProcessed)
        if fpsDragging then
            local currentPos = Vector2.new(0, 0)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                currentPos = UserInputService:GetMouseLocation()
            elseif input.UserInputType == Enum.UserInputType.Touch then
                currentPos = input.Position
            else
                return
            end
            
            local delta = currentPos - fpsDragStart
            fpsFrame.Position = UDim2.new(fpsStartPos.X.Scale, fpsStartPos.X.Offset + delta.X, fpsStartPos.Y.Scale, fpsStartPos.Y.Offset + delta.Y)
        end
    end)

    local lastUpdate = tick()
    local frameCount = 0
    local lastFPS = 0
    local totalDelta = 0
    local lastMS = 0
    _G.GGOGFPSConnection = RunService.RenderStepped:Connect(function(deltaTime)
        frameCount = frameCount + 1
        totalDelta = totalDelta + deltaTime
        if tick() - lastUpdate >= 0.5 then
            lastFPS = math.floor(frameCount / (tick() - lastUpdate) + 0.5)
            lastMS = math.floor((totalDelta / frameCount) * 1000 + 0.5)
            fpsValue.Text = "🌙 FPS: " .. tostring(lastFPS) .. " | MS: " .. tostring(lastMS)
            lastUpdate = tick()
            frameCount = 0
            totalDelta = 0
        end
    end)
end

-- Уменьшить и сдвинуть Search в Obsidian
task.wait(0.5)
local SearchBar = Window:FindFirstChild("SearchBox", true) or Window:FindFirstChild("InputField", true)
if SearchBar then
    SearchBar.Size = UDim2.new(0, 120, 0, 32)
    SearchBar.Position = UDim2.new(1, -140, 0, 10)
end

--371289731289073021783617124638974629876237846239847697868741897462879462874628746189764879246879246987246827468127468274612789462897461289746284762874
--8778687
