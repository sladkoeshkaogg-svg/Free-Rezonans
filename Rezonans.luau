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
    FontFace = "BuilderSans",
})

local Tabs = {
    Defence = Window:AddTab("Defence", "house"),
    Visuals = Window:AddTab("Visuals", "human"),
    Grabs = Window:AddTab("Grabs", "hand"),
    Security = Window:AddTab("Security", "shield"),
    Target = Window:AddTab("Target", "crosshair"),
    Blobmen = Window:AddTab("Blobmen", "robot"),
    UISettings = Window:AddTab("UI Settings", "toys"),
}

--371289731289073021783617124638974629876237846239847697868741897462879462874628746189764879246879246987246827468127468274612789462897461289746284762874
--8778687
