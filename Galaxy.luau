local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Создаем GUI программно
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.IgnoreGuiInset = true -- Делаем во весь экран, игнорируя верхнюю панель
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Черный фон
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.new(0, 0, 0)
background.BorderSizePixel = 0
background.Parent = screenGui

-- Текст Updating
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 60
textLabel.Text = "Updating"
textLabel.Parent = background

-- Анимация точек
task.spawn(function()
    local dots = ""
    local startTime = os.clock()
    
    while screenGui.Parent do
        local elapsed = os.clock() - startTime
        local count = math.floor(elapsed * 10) % 4 -- Быстрая смена (множитель 10)
        
        dots = string.rep(".", count)
        textLabel.Text = "Updating" .. dots
        
        RunService.RenderStepped:Wait()
    end
end)

-- Ждем 5 секунд и красиво выключаем
task.delay(5, function()
    local fadeInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    -- Плавно скрываем текст и фон
    local fadeTween = TweenService:Create(background, fadeInfo, {BackgroundTransparency = 1})
    local textFadeTween = TweenService:Create(textLabel, fadeInfo, {TextTransparency = 1})
    
    fadeTween:Play()
    textFadeTween:Play()
    
    fadeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)
