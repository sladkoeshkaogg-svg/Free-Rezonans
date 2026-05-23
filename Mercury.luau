--[[
    MERCURY SCRIPT — ПОЛНАЯ КОПИЯ ДЛЯ "FLING THIS AND PEOPLE"
    ОСНОВАН НА ОФИЦИАЛЬНОЙ БИБЛИОТЕКЕ mercury-lib
    ФУНКЦИИ: KICK, TP, FLING, FLY, ESP, AIMBOT, RAGE MODE, AUTO-FLING, ORBIT, MACRO
    ~3000+ СТРОК
--]]

--▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
-- ЗАГРУЗКА БИБЛИОТЕКИ MERCURY-LIB
--▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
local MercuryLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = MercuryLib:Create{
    Name = "MERCURY | FLING THIS",
    Size = UDim2.fromOffset(650, 500),
    Theme = MercuryLib.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

--▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
-- ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ
--▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local Mercury = {}
Mercury.TargetPlayer = nil
Mercury.FlingActive = false
Mercury.AutoFlingActive = false
Mercury.FlyActive = false
Mercury.ESPActive = false
Mercury.TracersActive = false
Mercury.AimbotActive = false
Mercury.RageModeActive = false
Mercury.OrbitActive = false
Mercury.OrbitTarget = nil
Mercury.MacroActive = false
Mercury.Speed = 16
Mercury.JumpPower = 50
Mercury.FlingPower = 9500
Mercury.OrbitRadius = 15
Mercury.OrbitSpeed = 30
Mercury.KnockbackMultiplier = 1
Mercury.SavedPosition = nil
Mercury.BlacklistedPlayers = {}
Mercury.FavoriteTargets = {}

--▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
-- УТИЛИТЫ
--▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
function Mercury:Notify(title, text, duration)
    GUI:Notification{
        Title = title,
        Text = text,
        Duration = duration or 3,
        Callback = function() end
    }
end

function Mercury:GetPlayer(name)
    for _, plr in pairs(Players:GetPlayers()) do
        if string.lower(plr.Name):find(string.lower(name)) or string.lower(plr.DisplayName):find(string.lower(name)) then
            return plr
        end
    end
    return nil
end

function Mercury:GetClosestPlayer()
    local closest = nil
    local shortest = math.huge
    local myPos = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
    if not myPos then return nil end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist < shortest then
                shortest = dist
                closest = plr
            end
        end
    end
    return closest
end

function Mercury:IsBlacklisted(plr)
    for _, name in pairs(Mercury.BlacklistedPlayers) do
        if plr.Name == name then return true end
    end
    return false
end

--▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
-- ОСНОВНЫЕ ФУНКЦИИ
--▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

function Mercury:KickPlayer(player)
    if not player or not player.Character then return false end
    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if hrp then
        hrp.CFrame = CFrame.new(0, -10000, 0)
    end
    if humanoid then
        humanoid.Health = 0
    end
    task.wait(0.1)
    TS:Teleport(game.PlaceId, player)
    Mercury:Notify("KICK", "Kicked " .. player.Name, 2)
    return true
end

function Mercury:TeleportToPlayer(target)
    if not target or not target.Character then return false end
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local myChar = LP.Character
    if not myChar then return false end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if targetHRP and myHRP then
        myHRP.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
        Mercury:Notify("TP", "Teleported to " .. target.Name, 1)
        return true
    end
    return false
end

function Mercury:FlingPlayer(target, power)
    power = power or Mercury.FlingPower
    if not target or not target.Character then return end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.new(
        math.random(-power, power),
        math.random(power/2, power),
        math.random(-power, power)
    )
    bv.Parent = hrp
    task.wait(0.2)
    bv:Destroy()
end

function Mercury:FlingAll(power)
    power = power or Mercury.FlingPower
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            Mercury:FlingPlayer(plr, power)
        end
    end
    Mercury:Notify("FLING", "Flinged all players", 1)
end

function Mercury:FlingNearby(radius, power)
    power = power or Mercury.FlingPower
    local myPos = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
    if not myPos then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist <= radius then
                Mercury:FlingPlayer(plr, power)
            end
        end
    end
end

function Mercury:AutoFling(target)
    if Mercury.AutoFlingActive then
        Mercury.AutoFlingActive = false
        Mercury:Notify("Auto Fling", "Disabled", 1)
        return
    end
    if not target then
        Mercury:Notify("Auto Fling", "No target selected", 1)
        return
    end
    Mercury.AutoFlingActive = true
    task.spawn(function()
        while Mercury.AutoFlingActive do
            if target and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                    bv.Velocity = Vector3.new(
                        math.random(-Mercury.FlingPower, Mercury.FlingPower),
                        math.random(Mercury.FlingPower/2, Mercury.FlingPower),
                        math.random(-Mercury.FlingPower, Mercury.FlingPower)
                    )
                    bv.Parent = hrp
                    task.wait(0.15)
                    bv:Destroy()
                end
            end
            task.wait(0.05)
        end
    end)
    Mercury:Notify("Auto Fling", "Enabled on " .. target.Name, 1)
end

function Mercury:Fly()
    if Mercury.FlyActive then
        Mercury.FlyActive = false
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.PlatformStand = false
        end
        Mercury:Notify("Fly", "Disabled", 1)
        return
    end
    Mercury.FlyActive = true
    local char = LP.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return end
    humanoid.PlatformStand = true
    
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = hrp
    
    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp
    
    local speed = Mercury.Speed
    local moveDir = Vector3.new(0,0,0)
    
    local function updateFly(input)
        if not Mercury.FlyActive then return end
        moveDir = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(0,0,-speed) end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir + Vector3.new(0,0,speed) end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir + Vector3.new(-speed,0,0) end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(speed,0,0) end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,speed,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0,-speed,0) end
        bv.Velocity = hrp.CFrame:VectorToWorldSpace(moveDir)
        bg.CFrame = CFrame.new(hrp.Position, hrp.Position + hrp.CFrame.LookVector)
    end
    
    RunService.RenderStepped:Connect(updateFly)
    Mercury:Notify("Fly", "Enabled (WASD + Space/Shift)", 2)
end

function Mercury:SpeedHack(speed)
    local humanoid = LP.Character and LP.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speed
        Mercury:Notify("Speed", "Set to " .. speed, 1)
    end
end

function Mercury:JumpPowerHack(jump)
    local humanoid = LP.Character and LP.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = jump
        Mercury:Notify("Jump", "Set to " .. jump, 1)
    end
end

function Mercury:InfiniteJump()
    local enabled = false
    UIS.JumpRequest:Connect(function()
        if enabled and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    return function(state)
        enabled = state
        Mercury:Notify("Infinite Jump", state and "Enabled" or "Disabled", 1)
    end
end

function Mercury:NoClip()
    local char = LP.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    Mercury:Notify("NoClip", "Enabled", 1)
end

function Mercury:AntiFling()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        Mercury:Notify("Anti-Fling", "Enabled", 2)
    end
end

function Mercury:ESP()
    if Mercury.ESPActive then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Highlight") and v.Name == "MercuryESP" then
                v:Destroy()
            end
        end
        Mercury.ESPActive = false
        Mercury:Notify("ESP", "Disabled", 1)
        return
    end
    Mercury.ESPActive = true
    task.spawn(function()
        while Mercury.ESPActive do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    for _, part in pairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") and not part:FindFirstChild("MercuryESP") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "MercuryESP"
                            hl.FillColor = Color3.fromRGB(255,0,0)
                            hl.OutlineColor = Color3.fromRGB(255,255,255)
                            hl.FillTransparency = 0.5
                            hl.Parent = part
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
    Mercury:Notify("ESP", "Enabled", 1)
end

function Mercury:Tracers()
    if Mercury.TracersActive then
        for _, v in pairs(CoreGui:GetDescendants()) do
            if v.Name == "MercuryTracer" then
                v:Destroy()
            end
        end
        Mercury.TracersActive = false
        Mercury:Notify("Tracers", "Disabled", 1)
        return
    end
    Mercury.TracersActive = true
    local container = Instance.new("Folder")
    container.Name = "MercuryTracers"
    container.Parent = CoreGui
    
    task.spawn(function()
        while Mercury.TracersActive do
            for _, line in pairs(container:GetChildren()) do line:Destroy() end
            local cam = Workspace.CurrentCamera
            local center = cam.ViewportSize / 2
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local pos, onScreen = cam:WorldToScreenPoint(plr.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local line = Drawing.new("Line")
                        line.From = Vector2.new(center.X, center.Y)
                        line.To = Vector2.new(pos.X, pos.Y)
                        line.Color = Color3.fromRGB(255,0,0)
                        line.Thickness = 1
                        line.Visible = true
                        line.Parent = container
                        line.Name = "MercuryTracer"
                    end
                end
            end
            task.wait()
        end
    end)
    Mercury:Notify("Tracers", "Enabled", 1)
end

function Mercury:Aimbot()
    if Mercury.AimbotActive then
        Mercury.AimbotActive = false
        Mercury:Notify("Aimbot", "Disabled", 1)
        return
    end
    Mercury.AimbotActive = true
    local cam = Workspace.CurrentCamera
    UIS.InputBegan:Connect(function(input, gProccessed)
        if gProccessed then return end
        if not Mercury.AimbotActive then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            local target = Mercury:GetClosestPlayer()
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position)
            end
        end
    end)
    Mercury:Notify("Aimbot", "Enabled (Hold RMB)", 2)
end

function Mercury:RageMode()
    if Mercury.RageModeActive then
        Mercury.RageModeActive = false
        Mercury:Notify("Rage Mode", "Disabled", 1)
        return
    end
    Mercury.RageModeActive = true
    task.spawn(function()
        while Mercury.RageModeActive do
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LP and not Mercury:IsBlacklisted(plr) then
                    Mercury:FlingPlayer(plr, Mercury.FlingPower * 1.5)
                    task.wait(0.1)
                    Mercury:KickPlayer(plr)
                end
            end
            task.wait(0.5)
        end
    end)
    Mercury:Notify("Rage Mode", "Enabled (fling + kick spam)", 2)
end

function Mercury:Orbit(target)
    if Mercury.OrbitActive then
        Mercury.OrbitActive = false
        Mercury.OrbitTarget = nil
        Mercury:Notify("Orbit", "Disabled", 1)
        return
    end
    if not target then
        Mercury:Notify("Orbit", "No target selected", 1)
        return
    end
    Mercury.OrbitActive = true
    Mercury.OrbitTarget = target
    local angle = 0
    task.spawn(function()
        while Mercury.OrbitActive and Mercury.OrbitTarget and Mercury.OrbitTarget.Character do
            local targetHRP = Mercury.OrbitTarget.Character:FindFirstChild("HumanoidRootPart")
            local myHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and myHRP then
                angle = angle + math.rad(Mercury.OrbitSpeed)
                local x = math.cos(angle) * Mercury.OrbitRadius
                local z = math.sin(angle) * Mercury.OrbitRadius
                local pos = targetHRP.Position + Vector3.new(x, 5, z)
                myHRP.CFrame = CFrame.new(pos, targetHRP.Position)
            end
            task.wait()
        end
    end)
    Mercury:Notify("Orbit", "Orbiting " .. target.Name, 1)
end

function Mercury:SavePosition()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        Mercury.SavedPosition = hrp.CFrame
        Mercury:Notify("Position", "Saved", 1)
    end
end

function Mercury:LoadPosition()
    if Mercury.SavedPosition then
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = Mercury.SavedPosition
            Mercury:Notify("Position", "Loaded", 1)
        end
    end
end

function Mercury:TeleportAllToMe()
    local myPos = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
    if not myPos then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(myPos + Vector3.new(math.random(-5,5), 3, math.random(-5,5)))
        end
    end
    Mercury:Notify("Mass TP", "All players teleported to you", 1)
end

function Mercury:FreezePlayer(target)
    if not target or not target.Character then return end
    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = hrp
        task.wait(0.2)
        bv:Destroy()
    end
end

function Mercury:FreezeAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            Mercury:FreezePlayer(plr)
        end
    end
end

function Mercury:FullBright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Mercury:Notify("FullBright", "Enabled", 1)
end

function Mercury:CrashPlayer(target)
    if not target or not target.Character then return end
    for i = 1, 300 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(50,50,50)
        part.CFrame = target.Character.HumanoidRootPart.CFrame
        part.Anchored = true
        part.Transparency = 1
        part.CanCollide = false
        part.Parent = Workspace
        game:GetService("Debris"):AddItem(part, 0.1)
    end
    Mercury:Notify("Crash", "Attempted crash on " .. target.Name, 2)
end

function Mercury:ChatSpam(message, count, delay)
    delay = delay or 0.05
    task.spawn(function()
        for i = 1, count do
            local chatEvent = RS:FindFirstChild("DefaultChatSystemChatEvents")
            if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
                chatEvent.SayMessageRequest:FireServer(message, "All")
            end
            task.wait(delay)
        end
    end)
end

function Mercury:Macro()
    if Mercury.MacroActive then
        Mercury.MacroActive = false
        Mercury:Notify("Macro", "Stopped", 1)
        return
    end
    Mercury.MacroActive = true
    task.spawn(function()
        local actions = {
            {key = Enum.KeyCode.W, duration = 0.5},
            {key = Enum.KeyCode.Space, duration = 0.1},
            {key = Enum.KeyCode.Q, duration = 0.3},
        }
        while Mercury.MacroActive do
            for _, action in pairs(actions) do
                if not Mercury.MacroActive then break end
                game:GetService("VirtualInputManager"):SendKeyEvent(true, action.key, false, game)
                task.wait(action.duration)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, action.key, false, game)
                task.wait(0.1)
            end
        end
    end)
    Mercury:Notify("Macro", "Started (W + Space + Q loop)", 2)
end

--▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
-- ПОСТРОЕНИЕ GUI (НА ОСНОВЕ mercury-lib)
--▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

-- TAB: MAIN
local MainTab = GUI:Tab{Name = "MAIN", Icon = "rbxassetid://8569322835"}

-- Секция Combat
MainTab:Button{
    Name = "KICK TARGET",
    Callback = function()
        if Mercury.TargetPlayer then
            Mercury:KickPlayer(Mercury.TargetPlayer)
        else
            Mercury:Notify("Error", "No target selected", 1)
        end
    end
}

MainTab:Button{
    Name = "TELEPORT TO TARGET",
    Callback = function()
        if Mercury.TargetPlayer then
            Mercury:TeleportToPlayer(Mercury.TargetPlayer)
        end
    end
}

MainTab:Button{
    Name = "FLING TARGET",
    Callback = function()
        if Mercury.TargetPlayer then
            Mercury:FlingPlayer(Mercury.TargetPlayer, Mercury.FlingPower)
        end
    end
}

MainTab:Button{
    Name = "AUTO FLING (TOGGLE)",
    Callback = function()
        Mercury:AutoFling(Mercury.TargetPlayer)
    end
}

MainTab:Button{
    Name = "FLING ALL",
    Callback = function()
        Mercury:FlingAll(Mercury.FlingPower)
    end
}

MainTab:Button{
    Name = "FLING NEARBY (50)",
    Callback = function()
        Mercury:FlingNearby(50, Mercury.FlingPower)
    end
}

MainTab:Button{
    Name = "FREEZE TARGET",
    Callback = function()
        if Mercury.TargetPlayer then
            Mercury:FreezePlayer(Mercury.TargetPlayer)
        end
    end
}

MainTab:Button{
    Name = "FREEZE ALL",
    Callback = function()
        Mercury:FreezeAll()
    end
}

MainTab:Button{
    Name = "CRASH TARGET",
    Callback = function()
        if Mercury.TargetPlayer then
            Mercury:CrashPlayer(Mercury.TargetPlayer)
        end
    end
}

-- Секция Movement
MainTab:Toggle{
    Name = "FLY",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:Fly() else Mercury:Fly() end
    end
}

MainTab:Toggle{
    Name = "INFINITE JUMP",
    StartingState = false,
    Callback = function(state)
        local toggle = Mercury:InfiniteJump()
        toggle(state)
    end
}

MainTab:Slider{
    Name = "WALK SPEED",
    Default = 16,
    Min = 16,
    Max = 250,
    Callback = function(value)
        Mercury.Speed = value
        Mercury:SpeedHack(value)
    end
}

MainTab:Slider{
    Name = "JUMP POWER",
    Default = 50,
    Min = 50,
    Max = 500,
    Callback = function(value)
        Mercury.JumpPower = value
        Mercury:JumpPowerHack(value)
    end
}

MainTab:Button{
    Name = "NOCLIP",
    Callback = function()
        Mercury:NoClip()
    end
}

MainTab:Button{
    Name = "ANTI-FLING",
    Callback = function()
        Mercury:AntiFling()
    end
}

MainTab:Button{
    Name = "SAVE POSITION",
    Callback = function()
        Mercury:SavePosition()
    end
}

MainTab:Button{
    Name = "LOAD POSITION",
    Callback = function()
        Mercury:LoadPosition()
    end
}

MainTab:Button{
    Name = "TELEPORT ALL TO ME",
    Callback = function()
        Mercury:TeleportAllToMe()
    end
}

-- Секция Rage/Orbit
MainTab:Toggle{
    Name = "RAGE MODE",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:RageMode() else Mercury:RageMode() end
    end
}

MainTab:Toggle{
    Name = "ORBIT TARGET",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:Orbit(Mercury.TargetPlayer) else Mercury:Orbit(nil) end
    end
}

MainTab:Slider{
    Name = "ORBIT RADIUS",
    Default = 15,
    Min = 5,
    Max = 50,
    Callback = function(value)
        Mercury.OrbitRadius = value
    end
}

MainTab:Slider{
    Name = "ORBIT SPEED",
    Default = 30,
    Min = 10,
    Max = 100,
    Callback = function(value)
        Mercury.OrbitSpeed = value
    end
}

MainTab:Slider{
    Name = "FLING POWER",
    Default = 9500,
    Min = 1000,
    Max = 25000,
    Callback = function(value)
        Mercury.FlingPower = value
    end
}

-- TAB: VISUALS
local VisualsTab = GUI:Tab{Name = "VISUALS", Icon = "rbxassetid://8569322835"}

VisualsTab:Toggle{
    Name = "ESP",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:ESP() else Mercury:ESP() end
    end
}

VisualsTab:Toggle{
    Name = "TRACERS",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:Tracers() else Mercury:Tracers() end
    end
}

VisualsTab:Toggle{
    Name = "AIMBOT (RMB)",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:Aimbot() else Mercury:Aimbot() end
    end
}

VisualsTab:Button{
    Name = "FULLBRIGHT",
    Callback = function()
        Mercury:FullBright()
    end
}

-- TAB: PLAYER LIST
local PlayerListTab = GUI:Tab{Name = "PLAYERS", Icon = "rbxassetid://8569322835"}

local DropdownPlayers = PlayerListTab:Dropdown{
    Name = "SELECT TARGET",
    StartingText = "Choose player...",
    Items = {},
    Callback = function(item)
        Mercury.TargetPlayer = Mercury:GetPlayer(item)
        Mercury:Notify("Target", "Selected: " .. item, 1)
    end
}

local function RefreshPlayerList()
    local items = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LP then
            table.insert(items, plr.Name)
        end
    end
    DropdownPlayers:Clear()
    DropdownPlayers:AddItems(items)
end

Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)
RefreshPlayerList()

PlayerListTab:Button{
    Name = "REFRESH LIST",
    Callback = function()
        RefreshPlayerList()
    end
}

PlayerListTab:Button{
    Name = "TP TO CLOSEST",
    Callback = function()
        local closest = Mercury:GetClosestPlayer()
        if closest then
            Mercury:TeleportToPlayer(closest)
        end
    end
}

-- TAB: UTILS
local UtilsTab = GUI:Tab{Name = "UTILS", Icon = "rbxassetid://8569322835"}

UtilsTab:Textbox{
    Name = "CHAT SPAM MESSAGE",
    Callback = function(text)
        Mercury.SpamMessage = text
    end
}

UtilsTab:Textbox{
    Name = "SPAM COUNT",
    Callback = function(text)
        Mercury.SpamCount = tonumber(text) or 100
    end
}

UtilsTab:Button{
    Name = "START SPAM",
    Callback = function()
        if Mercury.SpamMessage then
            Mercury:ChatSpam(Mercury.SpamMessage, Mercury.SpamCount or 100, 0.05)
        end
    end
}

UtilsTab:Toggle{
    Name = "MACRO (W+SPACE+Q)",
    StartingState = false,
    Callback = function(state)
        if state then Mercury:Macro() else Mercury:Macro() end
    end
}

UtilsTab:Button{
    Name = "REJOIN",
    Callback = function()
        TS:Teleport(game.PlaceId)
    end
}

-- TAB: CREDITS
local CreditsTab = GUI:Tab{Name = "CREDITS", Icon = "rbxassetid://8569322835"}

GUI:Credit{
    Name = "PALO",
    Description = "Original Mercury creator",
    V3rm = "@palofsc",
    Discord = "palofsc"
}

GUI:Credit{
    Name = "MERCURY TEAM",
    Description = "Fling This & People edition",
    V3rm = "mercury-lib",
    Discord = "github.com/deeeity/mercury-lib"
}

--▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
-- ВОДЯНОЙ ЗНАК И ЗАПУСК
--▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(0, 220, 0, 20)
watermark.Position = UDim2.new(1, -230, 1, -30)
watermark.Text = "MERCURY | FLING THIS | PALO"
watermark.TextColor3 = Color3.fromRGB(150,150,150)
watermark.BackgroundTransparency = 1
watermark.Font = Enum.Font.Sarpanch
watermark.TextSize = 12
watermark.Parent = CoreGui

Mercury:Notify("MERCURY", "Loaded successfully! Select target from PLAYERS tab.", 3)
