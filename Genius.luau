local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Loops",
    Footer = "Welcome to Genesis",
    ToggleKeybind = "RightShift",
    Size = UDim2.fromOffset(980, 720),
    Theme = "Dark"
})

-- SIDEBAR TABS (КАК НА КАРТИНКЕ)

local Home = Window:AddTab("Loops", "home")
local Plus = Window:AddTab("Plus", "plus")
local Skull = Window:AddTab("Skull", "skull")
local Hand = Window:AddTab("Hand", "hand")
local User = Window:AddTab("User", "user")
local Layers = Window:AddTab("Layers", "layers")
local Grid = Window:AddTab("Grid", "grid")
local Smile = Window:AddTab("Smile", "smile")
local Keyboard = Window:AddTab("Keyboard", "keyboard")
local Radar = Window:AddTab("Radar", "radar")
local Settings = Window:AddTab("Settings", "settings")

-- MAIN TAB
local TargetSection = Home:AddSection("Target Interaction", "left")

TargetSection:AddDropdown({
    Name = "select player for kick",
    Options = {"NITRO", "Player1", "Player2"},
    Default = "NITRO",
    Callback = function() end
})

TargetSection:AddButton({
    Name = "refresh player list",
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Fling ( grab )",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Ragdoll Snowball",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Grab Troll (spam grab)",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Loop Kick (grab + blob)",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Loop Kick",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Blob kill",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "kick fast (grab + blob, with height)",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Fling",
    Default = false,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Target Tracer",
    Default = true,
    Callback = function() end
})

TargetSection:AddToggle({
    Name = "Remove Anti Kick",
    Default = true,
    Callback = function() end
})

-- LOWER LEFT
local KickLoop = Home:AddSection("kick grabs loop", "left")

KickLoop:AddToggle({
    Name = "Kick (spam grab)",
    Default = true,
    Callback = function() end
})

KickLoop:AddToggle({
    Name = "Ragdoll Target",
    Default = true,
    Callback = function() end
})

KickLoop:AddToggle({
    Name = "Kick (spam grab V2)",
    Default = false,
    Callback = function() end
})

-- RIGHT TOP
local Blobman = Home:AddSection("Blobman Settings", "right")

Blobman:AddToggle({
    Name = "Auto Sit Blobman",
    Default = false,
    Callback = function() end
})

Blobman:AddSlider({
    Name = "Blob Speed",
    Min = 0,
    Max = 100,
    Default = 16,
    Callback = function() end
})

Blobman:AddToggle({
    Name = "Blob Speed",
    Default = false,
    Callback = function() end
})

-- RIGHT MIDDLE
local Misc = Home:AddSection("Misc", "right")

Misc:AddTextbox({
    Name = "Custom Kick Height, for kick fast",
    Default = "19",
    PlaceholderText = "19",
    Callback = function() end
})

Misc:AddToggle({
    Name = "Destroy Gucci (sit)",
    Default = false,
    Callback = function() end
})

Misc:AddButton({
    Name = "bring",
    Callback = function() end
})

Misc:AddToggle({
    Name = "Remove Anti Input Lag",
    Default = false,
    Callback = function() end
})

Misc:AddToggle({
    Name = "Target Joined Notify",
    Default = false,
    Callback = function() end
})

-- RIGHT BOTTOM
local White = Home:AddSection("whitelist", "right")

White:AddDropdown({
    Name = "whitelist people",
    Options = {"---"},
    Default = "---",
    Callback = function() end
})

White:AddButton({
    Name = "refresh List",
    Callback = function() end
})

-- EMPTY TABS

local function FillEmpty(tab)
    local sec = tab:AddSection("Empty", "left")

    sec:AddParagraph({
        Title = "Placeholder",
        Description = "No functions."
    })

    sec:AddToggle({
        Name = "Example Toggle",
        Default = false,
        Callback = function() end
    })

    sec:AddButton({
        Name = "Example Button",
        Callback = function() end
    })
end

FillEmpty(Plus)
FillEmpty(Skull)
FillEmpty(Hand)
FillEmpty(User)
FillEmpty(Layers)
FillEmpty(Grid)
FillEmpty(Smile)
FillEmpty(Keyboard)
FillEmpty(Radar)
FillEmpty(Settings)
