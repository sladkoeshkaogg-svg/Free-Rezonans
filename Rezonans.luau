-- Resonanse V2.7 | FTAP
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
    Title = "Resonanse",
    Footer = "Project Resonanse V2.7 | FTAP",
    SidebarIcon = "rbxassetid://13639308986",    NotifySide = "Right",
    ShowCustomCursor = true,
	EnableCompacting = true,
	SidebarCompacted = true,
	CornerRadius = 15
})

ThemeManager:SetLibrary(Library)
ThemeManager:SetDefaultTheme({
    FontColor = Color3.fromRGB(245, 245, 245),
    MainColor = Color3.fromRGB(50, 50, 0),
    AccentColor = Color3.fromRGB(255, 215, 0),
    BackgroundColor = Color3.fromRGB(10, 10, 10),
    OutlineColor = Color3.fromRGB(100, 100, 0),
    FontFace = "BuilderSans",
})

local Tabs = {
    Defence = Window:AddTab("Defence", "home"),
    Visuals = Window:AddTab("Visuals", "human"),
    Grabs = Window:AddTab("Grabs", "hand"),
    Security = Window:AddTab("Security", "shield"),
    Target = Window:AddTab("Target", "crosshair"),
    Blobmen = Window:AddTab("Blobmen", "robot"),
    UISettings = Window:AddTab("UI Settings", "toys"),
}
