--[[
    VX.Club UI Library — macOS-Inspired Roblox UI
    Themes: Dark / White / Gradient Themes / Liquid Glass
    Gradients: Blue, Red, Purple, Teal, Orange, Pink, Emerald, Sunset, Ocean, Neon, Frost, Lime, Rose, Indigo, Amber
    
    Author: VX.Club
    Version: 3.0.0

    CHANGELOG v3:
    - Gradients are now FULL THEMES (not just notification colors)
    - Complete theme system: ALL elements update on theme change
    - Liquid Glass mode (Apple-style frosted translucent glass)
    - Fixed: all cards/sections/elements properly update colors
]]

local VXClub = {}
VXClub.__index = VXClub

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ================================================================
-- THEME & GRADIENT DEFINITIONS
-- ================================================================

local Themes = {
    Dark = {
        Name = "Dark",
        WindowBackground = Color3.fromRGB(30, 30, 30),
        TitleBar = Color3.fromRGB(38, 38, 38),
        SidebarBackground = Color3.fromRGB(25, 25, 25),
        SidebarTabHover = Color3.fromRGB(50, 50, 50),
        SidebarTabActive = Color3.fromRGB(55, 55, 55),
        ContentBackground = Color3.fromRGB(30, 30, 30),
        SectionBackground = Color3.fromRGB(38, 38, 40),
        SectionBorder = Color3.fromRGB(55, 55, 58),
        ElementBackground = Color3.fromRGB(48, 48, 52),
        ElementBackgroundHover = Color3.fromRGB(58, 58, 62),
        ElementBorder = Color3.fromRGB(65, 65, 70),
        TextPrimary = Color3.fromRGB(240, 240, 245),
        TextSecondary = Color3.fromRGB(155, 155, 165),
        TextMuted = Color3.fromRGB(100, 100, 110),
        Accent = Color3.fromRGB(60, 130, 246),
        AccentHover = Color3.fromRGB(80, 145, 255),
        AccentDark = Color3.fromRGB(40, 100, 200),
        ToggleOn = Color3.fromRGB(60, 130, 246),
        ToggleOff = Color3.fromRGB(70, 70, 75),
        SliderTrack = Color3.fromRGB(50, 50, 55),
        SliderFill = Color3.fromRGB(60, 130, 246),
        InputBackground = Color3.fromRGB(22, 22, 25),
        InputBorder = Color3.fromRGB(60, 60, 65),
        InputFocusBorder = Color3.fromRGB(60, 130, 246),
        DropdownBackground = Color3.fromRGB(35, 35, 38),
        DropdownItemHover = Color3.fromRGB(50, 50, 55),
        NotificationBackground = Color3.fromRGB(35, 35, 40),
        NotificationBorder = Color3.fromRGB(55, 55, 60),
        DialogOverlay = Color3.fromRGB(0, 0, 0),
        DialogOverlayTransparency = 0.4,
        DialogBackground = Color3.fromRGB(40, 40, 45),
        DividerColor = Color3.fromRGB(50, 50, 55),
        ScrollbarColor = Color3.fromRGB(80, 80, 85),
        Shadow = Color3.fromRGB(0, 0, 0),
        ShadowTransparency = 0.6,
        TrafficClose = Color3.fromRGB(255, 95, 87),
        TrafficMinimize = Color3.fromRGB(255, 189, 46),
        TrafficMaximize = Color3.fromRGB(39, 201, 63),
    },
    White = {
        Name = "White",
        WindowBackground = Color3.fromRGB(246, 246, 248),
        TitleBar = Color3.fromRGB(236, 236, 240),
        SidebarBackground = Color3.fromRGB(240, 240, 244),
        SidebarTabHover = Color3.fromRGB(225, 225, 230),
        SidebarTabActive = Color3.fromRGB(215, 215, 222),
        ContentBackground = Color3.fromRGB(246, 246, 248),
        SectionBackground = Color3.fromRGB(255, 255, 255),
        SectionBorder = Color3.fromRGB(218, 218, 225),
        ElementBackground = Color3.fromRGB(240, 240, 244),
        ElementBackgroundHover = Color3.fromRGB(230, 230, 236),
        ElementBorder = Color3.fromRGB(210, 210, 218),
        TextPrimary = Color3.fromRGB(28, 28, 35),
        TextSecondary = Color3.fromRGB(100, 100, 112),
        TextMuted = Color3.fromRGB(150, 150, 160),
        Accent = Color3.fromRGB(0, 122, 255),
        AccentHover = Color3.fromRGB(0, 100, 220),
        AccentDark = Color3.fromRGB(0, 80, 180),
        ToggleOn = Color3.fromRGB(0, 122, 255),
        ToggleOff = Color3.fromRGB(200, 200, 208),
        SliderTrack = Color3.fromRGB(215, 215, 222),
        SliderFill = Color3.fromRGB(0, 122, 255),
        InputBackground = Color3.fromRGB(255, 255, 255),
        InputBorder = Color3.fromRGB(210, 210, 218),
        InputFocusBorder = Color3.fromRGB(0, 122, 255),
        DropdownBackground = Color3.fromRGB(255, 255, 255),
        DropdownItemHover = Color3.fromRGB(235, 235, 242),
        NotificationBackground = Color3.fromRGB(255, 255, 255),
        NotificationBorder = Color3.fromRGB(218, 218, 225),
        DialogOverlay = Color3.fromRGB(0, 0, 0),
        DialogOverlayTransparency = 0.5,
        DialogBackground = Color3.fromRGB(255, 255, 255),
        DividerColor = Color3.fromRGB(218, 218, 225),
        ScrollbarColor = Color3.fromRGB(180, 180, 190),
        Shadow = Color3.fromRGB(0, 0, 0),
        ShadowTransparency = 0.85,
        TrafficClose = Color3.fromRGB(255, 95, 87),
        TrafficMinimize = Color3.fromRGB(255, 189, 46),
        TrafficMaximize = Color3.fromRGB(39, 201, 63),
    }
}

local Gradients = {
    Blue     = { Start = Color3.fromRGB(59, 130, 246),  End = Color3.fromRGB(37, 99, 235) },
    Red      = { Start = Color3.fromRGB(239, 68, 68),   End = Color3.fromRGB(220, 38, 38) },
    Purple   = { Start = Color3.fromRGB(147, 51, 234),  End = Color3.fromRGB(126, 34, 206) },
    Teal     = { Start = Color3.fromRGB(20, 184, 166),  End = Color3.fromRGB(13, 148, 136) },
    Orange   = { Start = Color3.fromRGB(249, 115, 22),  End = Color3.fromRGB(234, 88, 12) },
    Pink     = { Start = Color3.fromRGB(236, 72, 153),  End = Color3.fromRGB(219, 39, 119) },
    Emerald  = { Start = Color3.fromRGB(16, 185, 129),  End = Color3.fromRGB(5, 150, 105) },
    Sunset   = { Start = Color3.fromRGB(251, 146, 60),  End = Color3.fromRGB(236, 72, 153) },
    Ocean    = { Start = Color3.fromRGB(6, 182, 212),   End = Color3.fromRGB(59, 130, 246) },
    Neon     = { Start = Color3.fromRGB(168, 85, 247),  End = Color3.fromRGB(236, 72, 153) },
    Frost    = { Start = Color3.fromRGB(99, 179, 237),  End = Color3.fromRGB(190, 227, 248) },
    Lime     = { Start = Color3.fromRGB(132, 204, 22),  End = Color3.fromRGB(34, 197, 94) },
    Rose     = { Start = Color3.fromRGB(244, 63, 94),   End = Color3.fromRGB(251, 113, 133) },
    Indigo   = { Start = Color3.fromRGB(79, 70, 229),   End = Color3.fromRGB(99, 102, 241) },
    Amber    = { Start = Color3.fromRGB(245, 158, 11),  End = Color3.fromRGB(252, 211, 77) },
}

-- Helper: lerp a color toward white/black to make lighter/darker variants
local function lerpColor(c1, c2, alpha)
    return Color3.new(
        c1.R + (c2.R - c1.R) * alpha,
        c1.G + (c2.G - c1.G) * alpha,
        c1.B + (c2.B - c1.B) * alpha
    )
end

-- Build gradient-based themes dynamically (Dark base + gradient tint)
local function buildGradientTheme(gradName, grad)
    local base = Themes.Dark
    local tint = lerpColor(grad.Start, grad.End, 0.5) -- midpoint
    local darkTint = lerpColor(tint, Color3.fromRGB(0, 0, 0), 0.85) -- very dark version
    local medTint = lerpColor(tint, Color3.fromRGB(0, 0, 0), 0.7)
    local lightTint = lerpColor(tint, Color3.fromRGB(0, 0, 0), 0.55)

    return {
        Name = gradName,
        IsGradientTheme = true,
        GradientName = gradName,
        WindowBackground = lerpColor(Color3.fromRGB(22, 22, 26), tint, 0.08),
        TitleBar = lerpColor(Color3.fromRGB(30, 30, 34), tint, 0.1),
        SidebarBackground = lerpColor(Color3.fromRGB(18, 18, 22), tint, 0.06),
        SidebarTabHover = lerpColor(Color3.fromRGB(45, 45, 50), tint, 0.12),
        SidebarTabActive = lerpColor(Color3.fromRGB(50, 50, 56), tint, 0.15),
        ContentBackground = lerpColor(Color3.fromRGB(22, 22, 26), tint, 0.08),
        SectionBackground = lerpColor(Color3.fromRGB(32, 32, 36), tint, 0.1),
        SectionBorder = lerpColor(Color3.fromRGB(50, 50, 56), tint, 0.18),
        ElementBackground = lerpColor(Color3.fromRGB(42, 42, 48), tint, 0.12),
        ElementBackgroundHover = lerpColor(Color3.fromRGB(55, 55, 60), tint, 0.15),
        ElementBorder = lerpColor(Color3.fromRGB(60, 60, 68), tint, 0.2),
        TextPrimary = Color3.fromRGB(240, 240, 245),
        TextSecondary = Color3.fromRGB(160, 160, 175),
        TextMuted = Color3.fromRGB(110, 110, 125),
        Accent = grad.Start,
        AccentHover = lerpColor(grad.Start, Color3.fromRGB(255, 255, 255), 0.15),
        AccentDark = lerpColor(grad.Start, Color3.fromRGB(0, 0, 0), 0.3),
        ToggleOn = grad.Start,
        ToggleOff = lerpColor(Color3.fromRGB(65, 65, 72), tint, 0.1),
        SliderTrack = lerpColor(Color3.fromRGB(45, 45, 50), tint, 0.1),
        SliderFill = grad.Start,
        InputBackground = lerpColor(Color3.fromRGB(18, 18, 22), tint, 0.06),
        InputBorder = lerpColor(Color3.fromRGB(55, 55, 62), tint, 0.15),
        InputFocusBorder = grad.Start,
        DropdownBackground = lerpColor(Color3.fromRGB(28, 28, 32), tint, 0.08),
        DropdownItemHover = lerpColor(Color3.fromRGB(45, 45, 50), tint, 0.15),
        NotificationBackground = lerpColor(Color3.fromRGB(30, 30, 35), tint, 0.1),
        NotificationBorder = lerpColor(Color3.fromRGB(50, 50, 58), tint, 0.18),
        DialogOverlay = Color3.fromRGB(0, 0, 0),
        DialogOverlayTransparency = 0.4,
        DialogBackground = lerpColor(Color3.fromRGB(35, 35, 40), tint, 0.1),
        DividerColor = lerpColor(Color3.fromRGB(48, 48, 55), tint, 0.15),
        ScrollbarColor = lerpColor(Color3.fromRGB(75, 75, 82), tint, 0.2),
        Shadow = Color3.fromRGB(0, 0, 0),
        ShadowTransparency = 0.55,
        TrafficClose = Color3.fromRGB(255, 95, 87),
        TrafficMinimize = Color3.fromRGB(255, 189, 46),
        TrafficMaximize = Color3.fromRGB(39, 201, 63),
        GradientStart = grad.Start,
        GradientEnd = grad.End,
    }
end

-- Register gradient themes
for name, grad in pairs(Gradients) do
    Themes[name] = buildGradientTheme(name, grad)
end

-- ================================================================
-- UTILITY FUNCTIONS
-- ================================================================

local Utilities = {}

function Utilities.Create(instanceType, properties)
    local inst = Instance.new(instanceType)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            inst[prop] = value
        end
    end
    if properties.Parent then
        inst.Parent = properties.Parent
    end
    return inst
end

function Utilities.Tween(instance, tweenInfo, properties)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function Utilities.AddCorner(parent, radius)
    return Utilities.Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent = parent
    })
end

function Utilities.AddStroke(parent, color, thickness, transparency)
    return Utilities.Create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent
    })
end

function Utilities.AddPadding(parent, top, right, bottom, left)
    return Utilities.Create("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingRight = UDim.new(0, right or top or 0),
        PaddingBottom = UDim.new(0, bottom or top or 0),
        PaddingLeft = UDim.new(0, left or right or top or 0),
        Parent = parent
    })
end

function Utilities.AddListLayout(parent, padding, direction, hAlign, vAlign, sortOrder)
    return Utilities.Create("UIListLayout", {
        Padding = UDim.new(0, padding or 6),
        FillDirection = direction or Enum.FillDirection.Vertical,
        HorizontalAlignment = hAlign or Enum.HorizontalAlignment.Left,
        VerticalAlignment = vAlign or Enum.VerticalAlignment.Top,
        SortOrder = sortOrder or Enum.SortOrder.LayoutOrder,
        Parent = parent
    })
end

function Utilities.AddGradient(parent, startColor, endColor, rotation)
    return Utilities.Create("UIGradient", {
        Color = ColorSequence.new(startColor, endColor),
        Rotation = rotation or 45,
        Parent = parent
    })
end

function Utilities.RemoveGradients(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("UIGradient") then
            child:Destroy()
        end
    end
end

function Utilities.AddShadow(parent, color, transparency, size)
    return Utilities.Create("ImageLabel", {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 4),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, size or 30, 1, size or 30),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = color or Color3.fromRGB(0, 0, 0),
        ImageTransparency = transparency or 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = parent
    })
end

function Utilities.MakeRipple(parent, position, color)
    local ripple = Utilities.Create("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, position.X - parent.AbsolutePosition.X, 0, position.Y - parent.AbsolutePosition.Y),
        Size = UDim2.fromOffset(0, 0),
        BackgroundColor3 = color or Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        ZIndex = parent.ZIndex + 5,
        Parent = parent
    })
    Utilities.AddCorner(ripple, 9999)

    local maxSize = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2.5
    Utilities.Tween(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(maxSize, maxSize),
        BackgroundTransparency = 1
    }).Completed:Connect(function()
        ripple:Destroy()
    end)
end

local smoothTween = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local fastTween = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local springTween = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- ================================================================
-- LIBRARY CORE
-- ================================================================

local ActiveWindows = {}
local SaveFolder = "VXClub"

function VXClub:SetFolder(folder)
    SaveFolder = folder
end

function VXClub:GetThemes()
    return Themes
end

function VXClub:GetGradients()
    return Gradients
end

function VXClub:GetThemeNames()
    local names = {"Dark", "White"}
    for name in pairs(Gradients) do
        table.insert(names, name)
    end
    table.sort(names, function(a, b)
        if a == "Dark" then return true end
        if b == "Dark" then return false end
        if a == "White" then return true end
        if b == "White" then return false end
        return a < b
    end)
    return names
end

function VXClub:Window(config)
    config = config or {}
    local windowConfig = {
        Title = config.Title or "VX.Club",
        Subtitle = config.Subtitle or "",
        Size = config.Size or UDim2.fromOffset(900, 580),
        Theme = config.Theme or "Dark",
        AccentGradient = config.AccentGradient or nil,
        DragStyle = config.DragStyle or 1,
        ShowUserInfo = config.ShowUserInfo ~= false,
        Keybind = config.Keybind or Enum.KeyCode.RightControl,
        AcrylicBlur = config.AcrylicBlur ~= false,
        LiquidGlass = config.LiquidGlass or false,
        DisabledWindowControls = config.DisabledWindowControls or {},
    }

    local currentTheme = Themes[windowConfig.Theme] or Themes.Dark
    local currentAccentGrad = windowConfig.AccentGradient and Gradients[windowConfig.AccentGradient] or nil
    local liquidGlassEnabled = windowConfig.LiquidGlass

    -- If theme is a gradient theme, use its gradient
    if currentTheme.IsGradientTheme then
        currentAccentGrad = { Start = currentTheme.GradientStart, End = currentTheme.GradientEnd }
    end

    -- Track all UI elements for theme updates
    local registeredElements = {}

    local function registerElement(element, updateFn)
        table.insert(registeredElements, { element = element, update = updateFn })
    end

    local Window = {
        Settings = windowConfig,
        Theme = currentTheme,
        Gradient = currentAccentGrad,
        Tabs = {},
        TabGroups = {},
        GlobalSettings = {},
        IsVisible = true,
        IsMinimized = false,
        NotificationsEnabled = true,
        AcrylicBlurEnabled = windowConfig.AcrylicBlur,
        LiquidGlassEnabled = liquidGlassEnabled,
        ShowUserInfoEnabled = windowConfig.ShowUserInfo,
        UnloadCallbacks = {},
        ThemeChangedCallbacks = {},
        Elements = {},
    }

    -- ================================================================
    -- LIQUID GLASS TRANSPARENCY VALUES
    -- ================================================================
    local GLASS = {
        Window = 0.15,
        TitleBar = 0.25,
        Sidebar = 0.2,
        Section = 0.3,
        Element = 0.35,
        Notification = 0.25,
        Dialog = 0.2,
        Dropdown = 0.2,
        Input = 0.3,
    }

    local function getTransparency(key)
        if liquidGlassEnabled then
            return GLASS[key] or 0.25
        end
        return 0
    end

    -- ================================================================
    -- SCREEN GUI
    -- ================================================================
    local screenGui = Utilities.Create("ScreenGui", {
        Name = "VXClub_" .. windowConfig.Title:gsub("%s+", ""),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = (syn and syn.protect_gui and CoreGui) or Player:WaitForChild("PlayerGui")
    })

    -- Blur Effect
    local blurEffect
    if windowConfig.AcrylicBlur or liquidGlassEnabled then
        blurEffect = Utilities.Create("BlurEffect", {
            Name = "VXClubBlur",
            Size = liquidGlassEnabled and 20 or 12,
            Parent = Lighting
        })
    end

    -- ================================================================
    -- MAIN WINDOW FRAME
    -- ================================================================
    local mainFrame = Utilities.Create("Frame", {
        Name = "MainWindow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = windowConfig.Size,
        BackgroundColor3 = currentTheme.WindowBackground,
        BackgroundTransparency = getTransparency("Window"),
        ClipsDescendants = true,
        Parent = screenGui
    })
    Utilities.AddCorner(mainFrame, 12)
    local mainStroke = Utilities.AddStroke(mainFrame, currentTheme.SectionBorder, 1, 0.5)
    Utilities.AddShadow(mainFrame, currentTheme.Shadow, currentTheme.ShadowTransparency, 50)

    -- ================================================================
    -- TITLE BAR
    -- ================================================================
    local titleBar = Utilities.Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = currentTheme.TitleBar,
        BackgroundTransparency = getTransparency("TitleBar"),
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    Utilities.AddCorner(titleBar, 12)

    local titleBarFix = Utilities.Create("Frame", {
        Name = "BottomFix",
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundColor3 = currentTheme.TitleBar,
        BackgroundTransparency = getTransparency("TitleBar"),
        BorderSizePixel = 0,
        Parent = titleBar
    })

    local titleBarSep = Utilities.Create("Frame", {
        Name = "Separator",
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = currentTheme.DividerColor,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = titleBar
    })

    -- Gradient accent line at top of title bar for gradient themes
    local titleGradientLine
    if currentAccentGrad then
        titleGradientLine = Utilities.Create("Frame", {
            Name = "GradientLine",
            Size = UDim2.new(1, 0, 0, 2),
            BackgroundColor3 = currentAccentGrad.Start,
            BorderSizePixel = 0,
            Parent = titleBar
        })
        Utilities.AddGradient(titleGradientLine, currentAccentGrad.Start, currentAccentGrad.End, 0)
    end

    -- Traffic Light Buttons
    local trafficContainer = Utilities.Create("Frame", {
        Name = "TrafficLights",
        Position = UDim2.new(0, 14, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.fromOffset(68, 14),
        BackgroundTransparency = 1,
        Parent = titleBar
    })
    Utilities.AddListLayout(trafficContainer, 8, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

    local function createTrafficButton(name, color, callback)
        local btn = Utilities.Create("TextButton", {
            Name = name,
            Size = UDim2.fromOffset(14, 14),
            BackgroundColor3 = color,
            Text = "",
            AutoButtonColor = false,
            Parent = trafficContainer
        })
        Utilities.AddCorner(btn, 9999)
        Utilities.AddStroke(btn, Color3.fromRGB(0, 0, 0), 1, 0.85)

        btn.MouseEnter:Connect(function()
            Utilities.Tween(btn, fastTween, { Size = UDim2.fromOffset(15, 15) })
        end)
        btn.MouseLeave:Connect(function()
            Utilities.Tween(btn, fastTween, { Size = UDim2.fromOffset(14, 14) })
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local disabled = {}
    for _, v in ipairs(windowConfig.DisabledWindowControls) do
        disabled[v] = true
    end

    if not disabled["Close"] then
        createTrafficButton("Close", currentTheme.TrafficClose, function()
            Window:Unload()
        end)
    end
    if not disabled["Minimize"] then
        createTrafficButton("Minimize", currentTheme.TrafficMinimize, function()
            Window:Minimize()
        end)
    end
    if not disabled["Maximize"] then
        createTrafficButton("Maximize", currentTheme.TrafficMaximize, function() end)
    end

    -- Title Text
    local titleLabel = Utilities.Create("TextLabel", {
        Name = "Title",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = windowConfig.Title,
        TextColor3 = currentTheme.TextPrimary,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })

    if windowConfig.Subtitle ~= "" then
        local subtitleLabel = Utilities.Create("TextLabel", {
            Name = "Subtitle",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = windowConfig.Title .. "  |  " .. windowConfig.Subtitle,
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            Parent = titleBar
        })
        titleLabel:Destroy()
        titleLabel = subtitleLabel
    end

    -- Dragging
    local dragging, dragInput, dragStart, startPos
    if windowConfig.DragStyle == 1 then
        titleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = mainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        titleBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    -- ================================================================
    -- BODY CONTAINER
    -- ================================================================
    local bodyFrame = Utilities.Create("Frame", {
        Name = "Body",
        Position = UDim2.new(0, 0, 0, 42),
        Size = UDim2.new(1, 0, 1, -42),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })

    -- ================================================================
    -- SIDEBAR
    -- ================================================================
    local sidebarWidth = 180
    local sidebar = Utilities.Create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, sidebarWidth, 1, 0),
        BackgroundColor3 = currentTheme.SidebarBackground,
        BackgroundTransparency = getTransparency("Sidebar"),
        BorderSizePixel = 0,
        Parent = bodyFrame
    })

    local sidebarSep = Utilities.Create("Frame", {
        Name = "Separator",
        Position = UDim2.new(1, -1, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = currentTheme.DividerColor,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = sidebar
    })

    -- User Info Panel
    local userInfoFrame, usernameLabel, handleLabel
    if windowConfig.ShowUserInfo then
        userInfoFrame = Utilities.Create("Frame", {
            Name = "UserInfo",
            Size = UDim2.new(1, 0, 0, 70),
            BackgroundTransparency = 1,
            Parent = sidebar
        })

        local avatarFrame = Utilities.Create("ImageLabel", {
            Name = "Avatar",
            Size = UDim2.fromOffset(36, 36),
            Position = UDim2.new(0, 14, 0, 10),
            AnchorPoint = Vector2.new(0, 0),
            BackgroundColor3 = currentTheme.ElementBackground,
            Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150",
            Parent = userInfoFrame
        })
        Utilities.AddCorner(avatarFrame, 9999)

        usernameLabel = Utilities.Create("TextLabel", {
            Name = "Username",
            Position = UDim2.new(0, 58, 0, 10),
            Size = UDim2.new(1, -72, 0, 18),
            BackgroundTransparency = 1,
            Text = Player.DisplayName,
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = userInfoFrame
        })

        handleLabel = Utilities.Create("TextLabel", {
            Name = "Handle",
            Position = UDim2.new(0, 58, 0, 30),
            Size = UDim2.new(1, -72, 0, 16),
            BackgroundTransparency = 1,
            Text = "@" .. Player.Name,
            TextColor3 = currentTheme.TextMuted,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = userInfoFrame
        })

        local infoDivider = Utilities.Create("Frame", {
            Name = "InfoDivider",
            Position = UDim2.new(0.1, 0, 1, -1),
            Size = UDim2.new(0.8, 0, 0, 1),
            BackgroundColor3 = currentTheme.DividerColor,
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            Parent = userInfoFrame
        })

        registerElement(infoDivider, function(t)
            infoDivider.BackgroundColor3 = t.DividerColor
        end)
    end

    -- Sidebar Tab Container
    local tabScrollFrame = Utilities.Create("ScrollingFrame", {
        Name = "TabScroll",
        Position = UDim2.new(0, 0, 0, windowConfig.ShowUserInfo and 70 or 0),
        Size = UDim2.new(1, 0, 1, windowConfig.ShowUserInfo and -70 or 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = currentTheme.ScrollbarColor,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        Parent = sidebar
    })
    Utilities.AddPadding(tabScrollFrame, 8, 10, 8, 10)
    Utilities.AddListLayout(tabScrollFrame, 2)

    -- ================================================================
    -- CONTENT AREA
    -- ================================================================
    local contentArea = Utilities.Create("Frame", {
        Name = "ContentArea",
        Position = UDim2.new(0, sidebarWidth, 0, 0),
        Size = UDim2.new(1, -sidebarWidth, 1, 0),
        BackgroundColor3 = currentTheme.ContentBackground,
        BackgroundTransparency = getTransparency("Window"),
        BorderSizePixel = 0,
        Parent = bodyFrame
    })

    -- ================================================================
    -- NOTIFICATION CONTAINER
    -- ================================================================
    local notifContainer = Utilities.Create("Frame", {
        Name = "Notifications",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.new(0, 320, 1, -40),
        BackgroundTransparency = 1,
        ZIndex = 90,
        Parent = screenGui
    })
    Utilities.AddListLayout(notifContainer, 8, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom)

    -- ================================================================
    -- DIALOG OVERLAY
    -- ================================================================
    local dialogOverlay = Utilities.Create("Frame", {
        Name = "DialogOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = currentTheme.DialogOverlay,
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 100,
        Parent = screenGui
    })

    -- ================================================================
    -- FULL THEME UPDATE SYSTEM
    -- ================================================================

    local function applyAccentGradientToElement(element, gradStart, gradEnd, rotation)
        Utilities.RemoveGradients(element)
        if gradStart and gradEnd then
            Utilities.AddGradient(element, gradStart, gradEnd, rotation or 0)
        end
    end

    function Window:SetTheme(themeName)
        local newTheme = Themes[themeName]
        if not newTheme then return end
        currentTheme = newTheme
        Window.Theme = currentTheme

        -- Update gradient
        if currentTheme.IsGradientTheme then
            currentAccentGrad = { Start = currentTheme.GradientStart, End = currentTheme.GradientEnd }
        else
            currentAccentGrad = nil
        end
        Window.Gradient = currentAccentGrad

        -- Update core elements
        mainFrame.BackgroundColor3 = currentTheme.WindowBackground
        mainFrame.BackgroundTransparency = getTransparency("Window")
        mainStroke.Color = currentTheme.SectionBorder
        titleBar.BackgroundColor3 = currentTheme.TitleBar
        titleBar.BackgroundTransparency = getTransparency("TitleBar")
        titleBarFix.BackgroundColor3 = currentTheme.TitleBar
        titleBarFix.BackgroundTransparency = getTransparency("TitleBar")
        titleBarSep.BackgroundColor3 = currentTheme.DividerColor
        titleLabel.TextColor3 = currentTheme.TextPrimary
        sidebar.BackgroundColor3 = currentTheme.SidebarBackground
        sidebar.BackgroundTransparency = getTransparency("Sidebar")
        sidebarSep.BackgroundColor3 = currentTheme.DividerColor
        contentArea.BackgroundColor3 = currentTheme.ContentBackground
        contentArea.BackgroundTransparency = getTransparency("Window")
        tabScrollFrame.ScrollBarImageColor3 = currentTheme.ScrollbarColor

        -- Update title gradient line
        if titleGradientLine then
            titleGradientLine:Destroy()
            titleGradientLine = nil
        end
        if currentAccentGrad then
            titleGradientLine = Utilities.Create("Frame", {
                Name = "GradientLine",
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = currentAccentGrad.Start,
                BorderSizePixel = 0,
                Parent = titleBar
            })
            Utilities.AddGradient(titleGradientLine, currentAccentGrad.Start, currentAccentGrad.End, 0)
        end

        -- Update user info
        if usernameLabel then usernameLabel.TextColor3 = currentTheme.TextPrimary end
        if handleLabel then handleLabel.TextColor3 = currentTheme.TextMuted end

        -- Update all registered elements
        for _, reg in ipairs(registeredElements) do
            if reg.element and reg.element.Parent then
                pcall(reg.update, currentTheme, currentAccentGrad)
            end
        end

        -- Fire callbacks
        for _, cb in ipairs(Window.ThemeChangedCallbacks) do
            pcall(cb, currentTheme)
        end
    end

    function Window:SetAccentGradient(gradientName)
        -- If we have a gradient theme for it, just switch to that theme
        if Themes[gradientName] then
            Window:SetTheme(gradientName)
        else
            local grad = Gradients[gradientName]
            if grad then
                currentAccentGrad = grad
                Window.Gradient = grad
            end
        end
    end

    function Window:GetTheme()
        return currentTheme
    end

    function Window:GetAccentGradient()
        return currentAccentGrad
    end

    -- ================================================================
    -- LIQUID GLASS TOGGLE
    -- ================================================================
    function Window:SetLiquidGlass(state)
        liquidGlassEnabled = state
        Window.LiquidGlassEnabled = state

        -- Update blur
        if blurEffect then
            blurEffect.Size = state and 20 or 12
            blurEffect.Enabled = state or Window.AcrylicBlurEnabled
        elseif state then
            blurEffect = Utilities.Create("BlurEffect", {
                Name = "VXClubBlur",
                Size = 20,
                Parent = Lighting
            })
        end

        -- Re-apply theme to update all transparencies
        Window:SetTheme(currentTheme.Name)
    end

    function Window:GetLiquidGlass()
        return liquidGlassEnabled
    end

    -- ================================================================
    -- NOTIFICATIONS
    -- ================================================================
    function Window:Notify(notifConfig)
        if not Window.NotificationsEnabled then return end
        notifConfig = notifConfig or {}
        local title = notifConfig.Title or "Notification"
        local desc = notifConfig.Description or ""
        local lifetime = notifConfig.Lifetime or 5
        local gradientName = notifConfig.Gradient or nil

        local notifFrame = Utilities.Create("Frame", {
            Name = "Notification",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = currentTheme.NotificationBackground,
            BackgroundTransparency = getTransparency("Notification"),
            ClipsDescendants = true,
            ZIndex = 91,
            Parent = notifContainer
        })
        Utilities.AddCorner(notifFrame, 10)
        Utilities.AddStroke(notifFrame, currentTheme.NotificationBorder, 1, 0.3)

        -- Accent bar on left
        local accentBar = Utilities.Create("Frame", {
            Name = "Accent",
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 4, 1, 0),
            BorderSizePixel = 0,
            ZIndex = 92,
            Parent = notifFrame
        })
        Utilities.AddCorner(accentBar, 2)
        if gradientName and Gradients[gradientName] then
            accentBar.BackgroundColor3 = Gradients[gradientName].Start
            Utilities.AddGradient(accentBar, Gradients[gradientName].Start, Gradients[gradientName].End, 90)
        elseif currentAccentGrad then
            accentBar.BackgroundColor3 = currentAccentGrad.Start
            Utilities.AddGradient(accentBar, currentAccentGrad.Start, currentAccentGrad.End, 90)
        else
            accentBar.BackgroundColor3 = currentTheme.Accent
        end

        local notifLayout = Utilities.Create("Frame", {
            Name = "Content",
            Position = UDim2.new(0, 16, 0, 12),
            Size = UDim2.new(1, -28, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ZIndex = 91,
            Parent = notifFrame
        })
        Utilities.AddListLayout(notifLayout, 4)

        Utilities.Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, 0, 0, 16),
            BackgroundTransparency = 1,
            Text = title,
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 91,
            Parent = notifLayout
        })

        if desc ~= "" then
            Utilities.Create("TextLabel", {
                Name = "Description",
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = desc,
                TextColor3 = currentTheme.TextSecondary,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                ZIndex = 91,
                Parent = notifLayout
            })
        end

        Utilities.Create("Frame", {
            Name = "BottomPad",
            Size = UDim2.new(1, 0, 0, 12),
            BackgroundTransparency = 1,
            Parent = notifLayout
        })

        notifFrame.BackgroundTransparency = 1
        Utilities.Tween(notifFrame, smoothTween, { BackgroundTransparency = getTransparency("Notification") })

        task.delay(lifetime, function()
            if notifFrame and notifFrame.Parent then
                Utilities.Tween(notifFrame, smoothTween, { BackgroundTransparency = 1 }).Completed:Connect(function()
                    notifFrame:Destroy()
                end)
            end
        end)
    end

    -- ================================================================
    -- DIALOG
    -- ================================================================
    function Window:Dialog(dialogConfig)
        dialogConfig = dialogConfig or {}
        dialogOverlay.Visible = true
        Utilities.Tween(dialogOverlay, smoothTween, { BackgroundTransparency = currentTheme.DialogOverlayTransparency })

        local dialogFrame = Utilities.Create("Frame", {
            Name = "Dialog",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.fromOffset(380, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = currentTheme.DialogBackground,
            BackgroundTransparency = getTransparency("Dialog"),
            ZIndex = 101,
            Parent = dialogOverlay
        })
        Utilities.AddCorner(dialogFrame, 14)
        Utilities.AddStroke(dialogFrame, currentTheme.SectionBorder, 1, 0.3)
        Utilities.AddPadding(dialogFrame, 24, 24, 20, 24)
        Utilities.AddListLayout(dialogFrame, 12)

        Utilities.Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = dialogConfig.Title or "Dialog",
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Center,
            LayoutOrder = 1,
            ZIndex = 102,
            Parent = dialogFrame
        })

        Utilities.Create("TextLabel", {
            Name = "Description",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = dialogConfig.Description or "",
            TextColor3 = currentTheme.TextSecondary,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextWrapped = true,
            LayoutOrder = 2,
            ZIndex = 102,
            Parent = dialogFrame
        })

        local buttonContainer = Utilities.Create("Frame", {
            Name = "Buttons",
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            ZIndex = 102,
            Parent = dialogFrame
        })
        Utilities.AddListLayout(buttonContainer, 10, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

        local function closeDialog()
            Utilities.Tween(dialogOverlay, smoothTween, { BackgroundTransparency = 1 }).Completed:Connect(function()
                dialogOverlay.Visible = false
                dialogFrame:Destroy()
            end)
        end

        for i, btnConfig in ipairs(dialogConfig.Buttons or {}) do
            local isPrimary = (i == 1)
            local btn = Utilities.Create("TextButton", {
                Name = btnConfig.Name or "Button",
                Size = UDim2.fromOffset(130, 34),
                BackgroundColor3 = isPrimary and currentTheme.Accent or currentTheme.ElementBackground,
                Text = btnConfig.Name or "Button",
                TextColor3 = isPrimary and Color3.fromRGB(255, 255, 255) or currentTheme.TextPrimary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                AutoButtonColor = false,
                ZIndex = 103,
                Parent = buttonContainer
            })
            Utilities.AddCorner(btn, 8)

            if isPrimary and currentAccentGrad then
                Utilities.AddGradient(btn, currentAccentGrad.Start, currentAccentGrad.End, 45)
            end

            btn.MouseButton1Click:Connect(function()
                if btnConfig.Callback then pcall(btnConfig.Callback) end
                closeDialog()
            end)
            btn.MouseEnter:Connect(function()
                Utilities.Tween(btn, fastTween, {
                    BackgroundColor3 = isPrimary and currentTheme.AccentHover or currentTheme.ElementBackgroundHover
                })
            end)
            btn.MouseLeave:Connect(function()
                Utilities.Tween(btn, fastTween, {
                    BackgroundColor3 = isPrimary and currentTheme.Accent or currentTheme.ElementBackground
                })
            end)
        end
    end

    -- ================================================================
    -- WINDOW CONTROLS
    -- ================================================================
    function Window:Minimize()
        Window.IsMinimized = not Window.IsMinimized
        if Window.IsMinimized then
            Utilities.Tween(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(windowConfig.Size.X.Offset, 42)
            })
        else
            Utilities.Tween(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = windowConfig.Size
            })
        end
    end

    function Window:Toggle()
        Window.IsVisible = not Window.IsVisible
        if Window.IsVisible then
            screenGui.Enabled = true
            Utilities.Tween(mainFrame, springTween, { Size = windowConfig.Size })
            mainFrame.Visible = true
            if blurEffect then blurEffect.Enabled = true end
        else
            Utilities.Tween(mainFrame, smoothTween, { Size = UDim2.fromOffset(windowConfig.Size.X.Offset, 0) }).Completed:Connect(function()
                mainFrame.Visible = false
            end)
            if blurEffect then blurEffect.Enabled = false end
        end
    end

    function Window:Unload()
        for _, cb in ipairs(Window.UnloadCallbacks) do
            pcall(cb)
        end
        if blurEffect then blurEffect:Destroy() end
        screenGui:Destroy()
    end

    function Window.onUnloaded(callback)
        table.insert(Window.UnloadCallbacks, callback)
    end

    function Window.onThemeChanged(callback)
        table.insert(Window.ThemeChangedCallbacks, callback)
    end

    function Window:SetAcrylicBlurState(state)
        Window.AcrylicBlurEnabled = state
        if blurEffect then blurEffect.Enabled = state or liquidGlassEnabled end
    end

    function Window:GetAcrylicBlurState()
        return Window.AcrylicBlurEnabled
    end

    function Window:SetNotificationsState(state)
        Window.NotificationsEnabled = state
    end

    function Window:GetNotificationsState()
        return Window.NotificationsEnabled
    end

    function Window:SetUserInfoState(state)
        Window.ShowUserInfoEnabled = state
        if userInfoFrame then
            userInfoFrame.Visible = state
            tabScrollFrame.Position = UDim2.new(0, 0, 0, state and 70 or 0)
            tabScrollFrame.Size = UDim2.new(1, 0, 1, state and -70 or 0)
        end
    end

    function Window:GetUserInfoState()
        return Window.ShowUserInfoEnabled
    end

    -- Keybind toggle
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == windowConfig.Keybind then
            Window:Toggle()
        end
    end)

    -- ================================================================
    -- GLOBAL SETTINGS
    -- ================================================================
    function Window:GlobalSetting(gsConfig)
        gsConfig = gsConfig or {}
        local setting = {
            Name = gsConfig.Name or "Setting",
            Value = gsConfig.Default ~= nil and gsConfig.Default or false,
            Callback = gsConfig.Callback or function() end,
        }
        function setting:Set(value)
            setting.Value = value
            pcall(setting.Callback, value)
        end
        table.insert(Window.GlobalSettings, setting)
        return setting
    end

    -- ================================================================
    -- TAB GROUP
    -- ================================================================
    function Window:TabGroup()
        local tabGroup = {
            Tabs = {},
        }

        local groupSep = Utilities.Create("Frame", {
            Name = "TabGroupSeparator",
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = currentTheme.DividerColor,
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            Visible = #Window.TabGroups > 0,
            Parent = tabScrollFrame
        })
        registerElement(groupSep, function(t)
            groupSep.BackgroundColor3 = t.DividerColor
        end)

        function tabGroup:Tab(tabConfig)
            tabConfig = tabConfig or {}
            local tab = {
                Name = tabConfig.Name or "Tab",
                Image = tabConfig.Image or nil,
                Sections = {},
                IsSelected = false,
                ContentFrame = nil,
            }

            -- Sidebar Tab Button
            local tabBtn = Utilities.Create("TextButton", {
                Name = "Tab_" .. tabConfig.Name,
                Size = UDim2.new(1, 0, 0, 34),
                BackgroundColor3 = currentTheme.SidebarBackground,
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                Parent = tabScrollFrame
            })
            Utilities.AddCorner(tabBtn, 7)

            if tabConfig.Image then
                local tabIcon = Utilities.Create("ImageLabel", {
                    Name = "Icon",
                    Position = UDim2.new(0, 10, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.fromOffset(16, 16),
                    BackgroundTransparency = 1,
                    Image = tabConfig.Image,
                    ImageColor3 = currentTheme.TextSecondary,
                    Parent = tabBtn
                })
                registerElement(tabIcon, function(t)
                    if not tab.IsSelected then
                        tabIcon.ImageColor3 = t.TextSecondary
                    else
                        tabIcon.ImageColor3 = t.TextPrimary
                    end
                end)
            end

            local tabLabel = Utilities.Create("TextLabel", {
                Name = "Label",
                Position = UDim2.new(0, tabConfig.Image and 34 or 10, 0, 0),
                Size = UDim2.new(1, tabConfig.Image and -44 or -20, 1, 0),
                BackgroundTransparency = 1,
                Text = tabConfig.Name,
                TextColor3 = currentTheme.TextSecondary,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = tabBtn
            })

            -- Accent indicator bar
            local indicator = Utilities.Create("Frame", {
                Name = "Indicator",
                Position = UDim2.new(0, 0, 0.15, 0),
                Size = UDim2.new(0, 3, 0.7, 0),
                BackgroundColor3 = currentTheme.Accent,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Parent = tabBtn
            })
            Utilities.AddCorner(indicator, 2)

            registerElement(indicator, function(t, grad)
                indicator.BackgroundColor3 = t.Accent
                Utilities.RemoveGradients(indicator)
                if grad then
                    Utilities.AddGradient(indicator, grad.Start, grad.End, 90)
                end
            end)

            registerElement(tabBtn, function(t)
                if tab.IsSelected then
                    tabBtn.BackgroundColor3 = t.SidebarTabActive
                    tabLabel.TextColor3 = t.TextPrimary
                else
                    tabLabel.TextColor3 = t.TextSecondary
                end
            end)

            -- Content Frame for this tab
            local contentFrame = Utilities.Create("ScrollingFrame", {
                Name = "Content_" .. tabConfig.Name,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ScrollBarThickness = 3,
                ScrollBarImageColor3 = currentTheme.ScrollbarColor,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Visible = false,
                BorderSizePixel = 0,
                Parent = contentArea
            })
            Utilities.AddPadding(contentFrame, 16, 20, 16, 20)

            registerElement(contentFrame, function(t)
                contentFrame.ScrollBarImageColor3 = t.ScrollbarColor
            end)

            -- Two-column layout
            local leftColumn = Utilities.Create("Frame", {
                Name = "LeftColumn",
                Size = UDim2.new(0.5, -6, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent = contentFrame
            })
            Utilities.AddListLayout(leftColumn, 12)

            local rightColumn = Utilities.Create("Frame", {
                Name = "RightColumn",
                Position = UDim2.new(0.5, 6, 0, 0),
                Size = UDim2.new(0.5, -6, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Parent = contentFrame
            })
            Utilities.AddListLayout(rightColumn, 12)

            tab.ContentFrame = contentFrame

            -- Select / Deselect
            function tab:Select()
                for _, otherTab in ipairs(tabGroup.Tabs) do
                    if otherTab ~= tab then
                        otherTab:Deselect()
                    end
                end
                tab.IsSelected = true
                contentFrame.Visible = true
                Utilities.Tween(tabBtn, fastTween, { BackgroundTransparency = 0, BackgroundColor3 = currentTheme.SidebarTabActive })
                Utilities.Tween(tabLabel, fastTween, { TextColor3 = currentTheme.TextPrimary })
                Utilities.Tween(indicator, fastTween, { BackgroundTransparency = 0 })
                if tabBtn:FindFirstChild("Icon") then
                    Utilities.Tween(tabBtn.Icon, fastTween, { ImageColor3 = currentTheme.TextPrimary })
                end
            end

            function tab:Deselect()
                tab.IsSelected = false
                contentFrame.Visible = false
                Utilities.Tween(tabBtn, fastTween, { BackgroundTransparency = 1 })
                Utilities.Tween(tabLabel, fastTween, { TextColor3 = currentTheme.TextSecondary })
                Utilities.Tween(indicator, fastTween, { BackgroundTransparency = 1 })
                if tabBtn:FindFirstChild("Icon") then
                    Utilities.Tween(tabBtn.Icon, fastTween, { ImageColor3 = currentTheme.TextSecondary })
                end
            end

            tabBtn.MouseEnter:Connect(function()
                if not tab.IsSelected then
                    Utilities.Tween(tabBtn, fastTween, { BackgroundTransparency = 0.3, BackgroundColor3 = currentTheme.SidebarTabHover })
                end
            end)
            tabBtn.MouseLeave:Connect(function()
                if not tab.IsSelected then
                    Utilities.Tween(tabBtn, fastTween, { BackgroundTransparency = 1 })
                end
            end)
            tabBtn.MouseButton1Click:Connect(function()
                tab:Select()
            end)

            -- ================================================================
            -- SECTION
            -- ================================================================
            function tab:Section(sectionConfig)
                sectionConfig = sectionConfig or {}
                local side = sectionConfig.Side or "Left"
                local parentColumn = (side == "Right") and rightColumn or leftColumn

                local section = {}

                local sectionFrame = Utilities.Create("Frame", {
                    Name = "Section",
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = currentTheme.SectionBackground,
                    BackgroundTransparency = getTransparency("Section"),
                    Parent = parentColumn
                })
                Utilities.AddCorner(sectionFrame, 10)
                local secStroke = Utilities.AddStroke(sectionFrame, currentTheme.SectionBorder, 1, 0.5)
                Utilities.AddPadding(sectionFrame, 14, 14, 14, 14)
                Utilities.AddListLayout(sectionFrame, 8)

                registerElement(sectionFrame, function(t)
                    sectionFrame.BackgroundColor3 = t.SectionBackground
                    sectionFrame.BackgroundTransparency = getTransparency("Section")
                    secStroke.Color = t.SectionBorder
                end)

                -- ========== HEADER ==========
                function section:Header(headerConfig)
                    headerConfig = headerConfig or {}
                    local headerLabel = Utilities.Create("TextLabel", {
                        Name = "Header",
                        Size = UDim2.new(1, 0, 0, 22),
                        BackgroundTransparency = 1,
                        Text = headerConfig.Name or headerConfig.Text or "Header",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 15,
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionFrame
                    })
                    registerElement(headerLabel, function(t)
                        headerLabel.TextColor3 = t.TextPrimary
                    end)

                    -- Gradient underline
                    local underline = Utilities.Create("Frame", {
                        Name = "Underline",
                        Size = UDim2.new(0.3, 0, 0, 2),
                        BackgroundColor3 = currentTheme.Accent,
                        BorderSizePixel = 0,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(underline, 1)
                    if currentAccentGrad then
                        Utilities.AddGradient(underline, currentAccentGrad.Start, currentAccentGrad.End, 0)
                    end
                    registerElement(underline, function(t, grad)
                        underline.BackgroundColor3 = t.Accent
                        Utilities.RemoveGradients(underline)
                        if grad then
                            Utilities.AddGradient(underline, grad.Start, grad.End, 0)
                        end
                    end)

                    return headerLabel
                end

                -- ========== BUTTON ==========
                function section:Button(btnConfig)
                    btnConfig = btnConfig or {}
                    local btnFrame = Utilities.Create("TextButton", {
                        Name = "Button_" .. (btnConfig.Name or "Btn"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        Text = "",
                        AutoButtonColor = false,
                        ClipsDescendants = true,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(btnFrame, 8)
                    local btnStroke = Utilities.AddStroke(btnFrame, currentTheme.ElementBorder, 1, 0.6)

                    local btnLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, -16, 1, 0),
                        Position = UDim2.new(0, 8, 0, 0),
                        BackgroundTransparency = 1,
                        Text = btnConfig.Name or "Button",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = btnFrame
                    })

                    if btnConfig.Primary then
                        btnFrame.BackgroundColor3 = currentTheme.Accent
                        btnFrame.BackgroundTransparency = 0
                        btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        if currentAccentGrad then
                            Utilities.AddGradient(btnFrame, currentAccentGrad.Start, currentAccentGrad.End, 45)
                        end
                    end

                    registerElement(btnFrame, function(t, grad)
                        btnStroke.Color = t.ElementBorder
                        if btnConfig.Primary then
                            btnFrame.BackgroundColor3 = t.Accent
                            btnFrame.BackgroundTransparency = 0
                            btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Utilities.RemoveGradients(btnFrame)
                            if grad then
                                Utilities.AddGradient(btnFrame, grad.Start, grad.End, 45)
                            end
                        else
                            btnFrame.BackgroundColor3 = t.ElementBackground
                            btnFrame.BackgroundTransparency = getTransparency("Element")
                            btnLabel.TextColor3 = t.TextPrimary
                        end
                    end)

                    btnFrame.MouseEnter:Connect(function()
                        if not btnConfig.Primary then
                            Utilities.Tween(btnFrame, fastTween, { BackgroundColor3 = currentTheme.ElementBackgroundHover })
                        end
                    end)
                    btnFrame.MouseLeave:Connect(function()
                        if not btnConfig.Primary then
                            Utilities.Tween(btnFrame, fastTween, { BackgroundColor3 = currentTheme.ElementBackground })
                        end
                    end)
                    btnFrame.MouseButton1Click:Connect(function()
                        Utilities.MakeRipple(btnFrame, Vector2.new(Mouse.X, Mouse.Y), currentTheme.Accent)
                        if btnConfig.Callback then pcall(btnConfig.Callback) end
                    end)

                    return btnFrame
                end

                -- ========== TOGGLE ==========
                function section:Toggle(toggleConfig, flag)
                    toggleConfig = toggleConfig or {}
                    local toggled = toggleConfig.Default or false

                    local toggleFrame = Utilities.Create("Frame", {
                        Name = "Toggle_" .. (toggleConfig.Name or "Toggle"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(toggleFrame, 8)
                    local tglStroke = Utilities.AddStroke(toggleFrame, currentTheme.ElementBorder, 1, 0.6)

                    local tglLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(1, -60, 1, 0),
                        BackgroundTransparency = 1,
                        Text = toggleConfig.Name or "Toggle",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = toggleFrame
                    })

                    local toggleSwitch = Utilities.Create("Frame", {
                        Name = "Switch",
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -10, 0.5, 0),
                        Size = UDim2.fromOffset(40, 22),
                        BackgroundColor3 = toggled and currentTheme.ToggleOn or currentTheme.ToggleOff,
                        Parent = toggleFrame
                    })
                    Utilities.AddCorner(toggleSwitch, 11)

                    local toggleGrad
                    if currentAccentGrad and toggled then
                        toggleGrad = Utilities.AddGradient(toggleSwitch, currentAccentGrad.Start, currentAccentGrad.End, 0)
                    end

                    local toggleKnob = Utilities.Create("Frame", {
                        Name = "Knob",
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = toggled and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                        Size = UDim2.fromOffset(18, 18),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = toggleSwitch
                    })
                    Utilities.AddCorner(toggleKnob, 9999)

                    local toggleBtn = Utilities.Create("TextButton", {
                        Name = "Clickable",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = "",
                        Parent = toggleFrame
                    })

                    local toggle = {}

                    local function updateVisual()
                        if toggled then
                            Utilities.Tween(toggleSwitch, smoothTween, { BackgroundColor3 = currentTheme.ToggleOn })
                            Utilities.Tween(toggleKnob, springTween, { Position = UDim2.new(1, -20, 0.5, 0) })
                            if currentAccentGrad and not toggleGrad then
                                toggleGrad = Utilities.AddGradient(toggleSwitch, currentAccentGrad.Start, currentAccentGrad.End, 0)
                            end
                        else
                            Utilities.Tween(toggleSwitch, smoothTween, { BackgroundColor3 = currentTheme.ToggleOff })
                            Utilities.Tween(toggleKnob, springTween, { Position = UDim2.new(0, 2, 0.5, 0) })
                            if toggleGrad then
                                toggleGrad:Destroy()
                                toggleGrad = nil
                            end
                        end
                    end

                    toggleBtn.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        updateVisual()
                        if toggleConfig.Callback then pcall(toggleConfig.Callback, toggled) end
                    end)

                    registerElement(toggleFrame, function(t, grad)
                        toggleFrame.BackgroundColor3 = t.ElementBackground
                        toggleFrame.BackgroundTransparency = getTransparency("Element")
                        tglStroke.Color = t.ElementBorder
                        tglLabel.TextColor3 = t.TextPrimary
                        -- Re-apply toggle gradient
                        if toggled then
                            toggleSwitch.BackgroundColor3 = t.ToggleOn
                            if toggleGrad then toggleGrad:Destroy() end
                            toggleGrad = nil
                            if grad then
                                toggleGrad = Utilities.AddGradient(toggleSwitch, grad.Start, grad.End, 0)
                            end
                        else
                            toggleSwitch.BackgroundColor3 = t.ToggleOff
                            if toggleGrad then toggleGrad:Destroy() toggleGrad = nil end
                        end
                    end)

                    function toggle:Set(value)
                        toggled = value
                        updateVisual()
                        if toggleConfig.Callback then pcall(toggleConfig.Callback, toggled) end
                    end

                    function toggle:Get()
                        return toggled
                    end

                    return toggle
                end

                -- ========== SLIDER ==========
                function section:Slider(sliderConfig, flag)
                    sliderConfig = sliderConfig or {}
                    local min = sliderConfig.Minimum or 0
                    local max = sliderConfig.Maximum or 100
                    local default = sliderConfig.Default or min
                    local precision = sliderConfig.Precision or 0
                    local display = sliderConfig.DisplayMethod or "Value"

                    local sliderFrame = Utilities.Create("Frame", {
                        Name = "Slider_" .. (sliderConfig.Name or "Slider"),
                        Size = UDim2.new(1, 0, 0, 52),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(sliderFrame, 8)
                    local slrStroke = Utilities.AddStroke(sliderFrame, currentTheme.ElementBorder, 1, 0.6)

                    local topRow = Utilities.Create("Frame", {
                        Name = "TopRow",
                        Position = UDim2.new(0, 12, 0, 6),
                        Size = UDim2.new(1, -24, 0, 18),
                        BackgroundTransparency = 1,
                        Parent = sliderFrame
                    })

                    local slrLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(0.6, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = sliderConfig.Name or "Slider",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = topRow
                    })

                    local valueLabel = Utilities.Create("TextLabel", {
                        Name = "Value",
                        Size = UDim2.new(0.4, 0, 1, 0),
                        Position = UDim2.new(0.6, 0, 0, 0),
                        BackgroundTransparency = 1,
                        Text = "",
                        TextColor3 = currentTheme.TextSecondary,
                        TextSize = 12,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Parent = topRow
                    })

                    local trackFrame = Utilities.Create("Frame", {
                        Name = "Track",
                        Position = UDim2.new(0, 12, 0, 32),
                        Size = UDim2.new(1, -24, 0, 6),
                        BackgroundColor3 = currentTheme.SliderTrack,
                        Parent = sliderFrame
                    })
                    Utilities.AddCorner(trackFrame, 3)

                    local fillFrame = Utilities.Create("Frame", {
                        Name = "Fill",
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundColor3 = currentTheme.SliderFill,
                        Parent = trackFrame
                    })
                    Utilities.AddCorner(fillFrame, 3)
                    if currentAccentGrad then
                        Utilities.AddGradient(fillFrame, currentAccentGrad.Start, currentAccentGrad.End, 0)
                    end

                    local knob = Utilities.Create("Frame", {
                        Name = "Knob",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0, 0, 0.5, 0),
                        Size = UDim2.fromOffset(14, 14),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        ZIndex = 5,
                        Parent = trackFrame
                    })
                    Utilities.AddCorner(knob, 9999)
                    local knobStroke = Utilities.AddStroke(knob, currentTheme.ElementBorder, 1, 0.5)

                    registerElement(sliderFrame, function(t, grad)
                        sliderFrame.BackgroundColor3 = t.ElementBackground
                        sliderFrame.BackgroundTransparency = getTransparency("Element")
                        slrStroke.Color = t.ElementBorder
                        slrLabel.TextColor3 = t.TextPrimary
                        valueLabel.TextColor3 = t.TextSecondary
                        trackFrame.BackgroundColor3 = t.SliderTrack
                        fillFrame.BackgroundColor3 = t.SliderFill
                        knobStroke.Color = t.ElementBorder
                        Utilities.RemoveGradients(fillFrame)
                        if grad then
                            Utilities.AddGradient(fillFrame, grad.Start, grad.End, 0)
                        end
                    end)

                    local slider = {}
                    local currentValue = default

                    local function formatValue(val)
                        if display == "Percent" then
                            return math.floor(((val - min) / (max - min)) * 100 + 0.5) .. "%"
                        else
                            if precision == 0 then
                                return tostring(math.floor(val + 0.5))
                            else
                                return string.format("%." .. precision .. "f", val)
                            end
                        end
                    end

                    local function updateSlider(value)
                        value = math.clamp(value, min, max)
                        if precision == 0 then
                            value = math.floor(value + 0.5)
                        else
                            local mult = 10 ^ precision
                            value = math.floor(value * mult + 0.5) / mult
                        end
                        currentValue = value
                        local pct = (value - min) / (max - min)
                        fillFrame.Size = UDim2.new(pct, 0, 1, 0)
                        knob.Position = UDim2.new(pct, 0, 0.5, 0)
                        valueLabel.Text = formatValue(value)
                    end

                    updateSlider(default)

                    local sliding = false
                    local sliderBtn = Utilities.Create("TextButton", {
                        Name = "SliderClickArea",
                        Size = UDim2.new(1, 0, 1, 10),
                        Position = UDim2.new(0, 0, 0, -5),
                        BackgroundTransparency = 1,
                        Text = "",
                        Parent = trackFrame
                    })

                    sliderBtn.MouseButton1Down:Connect(function()
                        sliding = true
                    end)

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if sliding then
                                sliding = false
                                if sliderConfig.Callback then pcall(sliderConfig.Callback, currentValue) end
                            end
                        end
                    end)

                    RunService.RenderStepped:Connect(function()
                        if sliding then
                            local mouseX = Mouse.X
                            local trackStart = trackFrame.AbsolutePosition.X
                            local trackWidth = trackFrame.AbsoluteSize.X
                            local pct = math.clamp((mouseX - trackStart) / trackWidth, 0, 1)
                            local value = min + (max - min) * pct
                            updateSlider(value)
                        end
                    end)

                    function slider:Set(value)
                        updateSlider(value)
                    end
                    function slider:Get()
                        return currentValue
                    end

                    return slider
                end

                -- ========== INPUT ==========
                function section:Input(inputConfig, flag)
                    inputConfig = inputConfig or {}

                    local inputFrame = Utilities.Create("Frame", {
                        Name = "Input_" .. (inputConfig.Name or "Input"),
                        Size = UDim2.new(1, 0, 0, 60),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(inputFrame, 8)
                    local inpStroke = Utilities.AddStroke(inputFrame, currentTheme.ElementBorder, 1, 0.6)
                    Utilities.AddPadding(inputFrame, 8, 12, 8, 12)

                    local inpLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        Text = inputConfig.Name or "Input",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = inputFrame
                    })

                    local textBox = Utilities.Create("TextBox", {
                        Name = "TextBox",
                        Position = UDim2.new(0, 12, 0, 30),
                        Size = UDim2.new(1, -24, 0, 24),
                        BackgroundColor3 = currentTheme.InputBackground,
                        BackgroundTransparency = getTransparency("Input"),
                        Text = "",
                        PlaceholderText = inputConfig.Placeholder or "Type here...",
                        PlaceholderColor3 = currentTheme.TextMuted,
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ClearTextOnFocus = false,
                        Parent = inputFrame
                    })
                    Utilities.AddCorner(textBox, 6)
                    local tbStroke = Utilities.AddStroke(textBox, currentTheme.InputBorder, 1, 0.3)
                    Utilities.AddPadding(textBox, 0, 8, 0, 8)

                    registerElement(inputFrame, function(t)
                        inputFrame.BackgroundColor3 = t.ElementBackground
                        inputFrame.BackgroundTransparency = getTransparency("Element")
                        inpStroke.Color = t.ElementBorder
                        inpLabel.TextColor3 = t.TextPrimary
                        textBox.BackgroundColor3 = t.InputBackground
                        textBox.BackgroundTransparency = getTransparency("Input")
                        textBox.TextColor3 = t.TextPrimary
                        textBox.PlaceholderColor3 = t.TextMuted
                        tbStroke.Color = t.InputBorder
                    end)

                    textBox.Focused:Connect(function()
                        Utilities.Tween(tbStroke, fastTween, { Color = currentTheme.InputFocusBorder, Transparency = 0 })
                    end)
                    textBox.FocusLost:Connect(function(enterPressed)
                        Utilities.Tween(tbStroke, fastTween, { Color = currentTheme.InputBorder, Transparency = 0.3 })
                        if enterPressed and inputConfig.Callback then pcall(inputConfig.Callback, textBox.Text) end
                    end)
                    textBox:GetPropertyChangedSignal("Text"):Connect(function()
                        if inputConfig.onChanged then pcall(inputConfig.onChanged, textBox.Text) end
                    end)

                    local input = {}
                    function input:Set(text) textBox.Text = text end
                    function input:Get() return textBox.Text end
                    return input
                end

                -- ========== DROPDOWN ==========
                function section:Dropdown(dropConfig, flag)
                    dropConfig = dropConfig or {}
                    local options = dropConfig.Options or {}
                    local multi = dropConfig.Multi or false
                    local isOpen = false

                    local selectedValues = {}
                    if multi and dropConfig.Default then
                        for _, v in ipairs(dropConfig.Default) do
                            selectedValues[v] = true
                        end
                    elseif not multi and dropConfig.Default then
                        if type(dropConfig.Default) == "number" then
                            selectedValues = options[dropConfig.Default] or ""
                        else
                            selectedValues = dropConfig.Default
                        end
                    end

                    local dropFrame = Utilities.Create("Frame", {
                        Name = "Dropdown_" .. (dropConfig.Name or "DD"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        ClipsDescendants = false,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(dropFrame, 8)
                    local ddStroke = Utilities.AddStroke(dropFrame, currentTheme.ElementBorder, 1, 0.6)

                    local dropBtn = Utilities.Create("TextButton", {
                        Name = "DropButton",
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundTransparency = 1,
                        Text = "",
                        Parent = dropFrame
                    })

                    local ddLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(0.6, -12, 0, 36),
                        BackgroundTransparency = 1,
                        Text = dropConfig.Name or "Dropdown",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = dropBtn
                    })

                    local displayLabel = Utilities.Create("TextLabel", {
                        Name = "Display",
                        Position = UDim2.new(0.4, 0, 0, 0),
                        Size = UDim2.new(0.6, -30, 0, 36),
                        BackgroundTransparency = 1,
                        Text = multi and "None" or (type(selectedValues) == "string" and selectedValues or "Select..."),
                        TextColor3 = currentTheme.TextSecondary,
                        TextSize = 12,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Parent = dropBtn
                    })

                    local arrow = Utilities.Create("TextLabel", {
                        Name = "Arrow",
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -10, 0.5, 0),
                        Size = UDim2.fromOffset(12, 12),
                        BackgroundTransparency = 1,
                        Text = "\226\150\188",
                        TextColor3 = currentTheme.TextMuted,
                        TextSize = 10,
                        Font = Enum.Font.GothamBold,
                        Parent = dropBtn
                    })

                    -- Options list on screenGui
                    local optionsList = Utilities.Create("Frame", {
                        Name = "OptionsList",
                        Size = UDim2.fromOffset(0, 0),
                        BackgroundColor3 = currentTheme.DropdownBackground,
                        BackgroundTransparency = getTransparency("Dropdown"),
                        ClipsDescendants = true,
                        Visible = false,
                        ZIndex = 80,
                        Parent = screenGui
                    })
                    Utilities.AddCorner(optionsList, 8)
                    local olStroke = Utilities.AddStroke(optionsList, currentTheme.ElementBorder, 1, 0.4)
                    Utilities.AddShadow(optionsList, currentTheme.Shadow, 0.5, 20)

                    local optionsScroll = Utilities.Create("ScrollingFrame", {
                        Name = "Scroll",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        ScrollBarThickness = 2,
                        ScrollBarImageColor3 = currentTheme.ScrollbarColor,
                        CanvasSize = UDim2.new(0, 0, 0, 0),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        BorderSizePixel = 0,
                        ZIndex = 81,
                        Parent = optionsList
                    })
                    Utilities.AddPadding(optionsScroll, 4, 4, 4, 4)
                    Utilities.AddListLayout(optionsScroll, 2)

                    local function positionDropdown()
                        local absPos = dropFrame.AbsolutePosition
                        local absSize = dropFrame.AbsoluteSize
                        optionsList.Position = UDim2.fromOffset(absPos.X, absPos.Y + absSize.Y + 4)
                        optionsList.Size = UDim2.fromOffset(absSize.X, 0)
                    end

                    registerElement(dropFrame, function(t)
                        dropFrame.BackgroundColor3 = t.ElementBackground
                        dropFrame.BackgroundTransparency = getTransparency("Element")
                        ddStroke.Color = t.ElementBorder
                        ddLabel.TextColor3 = t.TextPrimary
                        displayLabel.TextColor3 = t.TextSecondary
                        arrow.TextColor3 = t.TextMuted
                        optionsList.BackgroundColor3 = t.DropdownBackground
                        optionsList.BackgroundTransparency = getTransparency("Dropdown")
                        olStroke.Color = t.ElementBorder
                        optionsScroll.ScrollBarImageColor3 = t.ScrollbarColor
                    end)

                    local dropdown = {}

                    local function updateDisplay()
                        if multi then
                            local selected = {}
                            for k, v in pairs(selectedValues) do
                                if v then table.insert(selected, k) end
                            end
                            displayLabel.Text = #selected > 0 and table.concat(selected, ", ") or "None"
                        else
                            displayLabel.Text = tostring(selectedValues) ~= "" and tostring(selectedValues) or "Select..."
                        end
                    end

                    local function buildOptions()
                        for _, child in ipairs(optionsScroll:GetChildren()) do
                            if child:IsA("TextButton") then child:Destroy() end
                        end

                        for _, option in ipairs(options) do
                            local optBtn = Utilities.Create("TextButton", {
                                Name = "Opt_" .. option,
                                Size = UDim2.new(1, 0, 0, 30),
                                BackgroundColor3 = currentTheme.DropdownBackground,
                                BackgroundTransparency = 0.5,
                                Text = option,
                                TextColor3 = currentTheme.TextPrimary,
                                TextSize = 12,
                                Font = Enum.Font.Gotham,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                AutoButtonColor = false,
                                ZIndex = 82,
                                Parent = optionsScroll
                            })
                            Utilities.AddCorner(optBtn, 6)
                            Utilities.AddPadding(optBtn, 0, 10, 0, 10)

                            optBtn.MouseEnter:Connect(function()
                                Utilities.Tween(optBtn, fastTween, { BackgroundColor3 = currentTheme.DropdownItemHover, BackgroundTransparency = 0 })
                            end)
                            optBtn.MouseLeave:Connect(function()
                                Utilities.Tween(optBtn, fastTween, { BackgroundColor3 = currentTheme.DropdownBackground, BackgroundTransparency = 0.5 })
                            end)

                            optBtn.MouseButton1Click:Connect(function()
                                if multi then
                                    selectedValues[option] = not selectedValues[option]
                                    if not selectedValues[option] then selectedValues[option] = nil end
                                    updateDisplay()
                                    if dropConfig.Callback then pcall(dropConfig.Callback, selectedValues) end
                                else
                                    selectedValues = option
                                    updateDisplay()
                                    if dropConfig.Callback then pcall(dropConfig.Callback, option) end
                                    isOpen = false
                                    local absWidth = dropFrame.AbsoluteSize.X
                                    Utilities.Tween(optionsList, fastTween, { Size = UDim2.fromOffset(absWidth, 0) }).Completed:Connect(function()
                                        optionsList.Visible = false
                                    end)
                                    Utilities.Tween(arrow, fastTween, { Rotation = 0 })
                                end
                            end)
                        end
                    end

                    buildOptions()
                    updateDisplay()

                    dropBtn.MouseButton1Click:Connect(function()
                        isOpen = not isOpen
                        if isOpen then
                            positionDropdown()
                            optionsList.Visible = true
                            local targetH = math.min(#options * 32 + 8, 180)
                            local absWidth = dropFrame.AbsoluteSize.X
                            Utilities.Tween(optionsList, smoothTween, { Size = UDim2.fromOffset(absWidth, targetH) })
                            Utilities.Tween(arrow, smoothTween, { Rotation = 180 })
                        else
                            local absWidth = dropFrame.AbsoluteSize.X
                            Utilities.Tween(optionsList, smoothTween, { Size = UDim2.fromOffset(absWidth, 0) }).Completed:Connect(function()
                                optionsList.Visible = false
                            end)
                            Utilities.Tween(arrow, smoothTween, { Rotation = 0 })
                        end
                    end)

                    function dropdown:UpdateSelection(value)
                        if multi then
                            selectedValues = {}
                            for _, v in ipairs(value) do selectedValues[v] = true end
                        else
                            selectedValues = value
                        end
                        updateDisplay()
                    end

                    function dropdown:Refresh(newOptions)
                        options = newOptions
                        buildOptions()
                    end

                    return dropdown
                end

                -- ========== KEYBIND ==========
                function section:Keybind(kbConfig, flag)
                    kbConfig = kbConfig or {}
                    local currentBind = kbConfig.Default or nil
                    local listening = false

                    local kbFrame = Utilities.Create("Frame", {
                        Name = "Keybind_" .. (kbConfig.Name or "KB"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(kbFrame, 8)
                    local kbStroke = Utilities.AddStroke(kbFrame, currentTheme.ElementBorder, 1, 0.6)

                    local kbLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(0.6, -12, 1, 0),
                        BackgroundTransparency = 1,
                        Text = kbConfig.Name or "Keybind",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = kbFrame
                    })

                    local bindBtn = Utilities.Create("TextButton", {
                        Name = "BindBtn",
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -10, 0.5, 0),
                        Size = UDim2.fromOffset(80, 24),
                        BackgroundColor3 = currentTheme.InputBackground,
                        Text = currentBind and currentBind.Name or "None",
                        TextColor3 = currentTheme.TextSecondary,
                        TextSize = 11,
                        Font = Enum.Font.GothamMedium,
                        AutoButtonColor = false,
                        Parent = kbFrame
                    })
                    Utilities.AddCorner(bindBtn, 6)
                    local bindStroke = Utilities.AddStroke(bindBtn, currentTheme.InputBorder, 1, 0.4)

                    registerElement(kbFrame, function(t)
                        kbFrame.BackgroundColor3 = t.ElementBackground
                        kbFrame.BackgroundTransparency = getTransparency("Element")
                        kbStroke.Color = t.ElementBorder
                        kbLabel.TextColor3 = t.TextPrimary
                        bindBtn.BackgroundColor3 = t.InputBackground
                        bindBtn.TextColor3 = t.TextSecondary
                        bindStroke.Color = t.InputBorder
                    end)

                    local keybind = {}

                    bindBtn.MouseButton1Click:Connect(function()
                        listening = true
                        bindBtn.Text = "..."
                        Utilities.Tween(bindBtn, fastTween, { BackgroundColor3 = currentTheme.Accent })
                        bindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end)

                    UserInputService.InputBegan:Connect(function(input, gameProcessed)
                        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                            listening = false
                            currentBind = input.KeyCode
                            bindBtn.Text = input.KeyCode.Name
                            Utilities.Tween(bindBtn, fastTween, { BackgroundColor3 = currentTheme.InputBackground })
                            bindBtn.TextColor3 = currentTheme.TextSecondary
                            if kbConfig.onBinded then pcall(kbConfig.onBinded, input.KeyCode) end
                        elseif not listening and not gameProcessed and currentBind and input.KeyCode == currentBind then
                            if kbConfig.Callback then pcall(kbConfig.Callback, currentBind) end
                        end
                    end)

                    function keybind:Set(keyCode)
                        currentBind = keyCode
                        bindBtn.Text = keyCode.Name
                    end

                    return keybind
                end

                -- ========== COLORPICKER ==========
                function section:Colorpicker(cpConfig, flag)
                    cpConfig = cpConfig or {}
                    local currentColor = cpConfig.Default or Color3.fromRGB(255, 255, 255)
                    local currentAlpha = cpConfig.Alpha or nil

                    local cpFrame = Utilities.Create("Frame", {
                        Name = "Colorpicker_" .. (cpConfig.Name or "CP"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        BackgroundTransparency = getTransparency("Element"),
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(cpFrame, 8)
                    local cpStroke = Utilities.AddStroke(cpFrame, currentTheme.ElementBorder, 1, 0.6)

                    local cpLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(0.7, -12, 1, 0),
                        BackgroundTransparency = 1,
                        Text = cpConfig.Name or "Color Picker",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = cpFrame
                    })

                    local preview = Utilities.Create("Frame", {
                        Name = "Preview",
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -10, 0.5, 0),
                        Size = UDim2.fromOffset(30, 20),
                        BackgroundColor3 = currentColor,
                        Parent = cpFrame
                    })
                    Utilities.AddCorner(preview, 5)
                    Utilities.AddStroke(preview, currentTheme.ElementBorder, 1, 0.5)

                    registerElement(cpFrame, function(t)
                        cpFrame.BackgroundColor3 = t.ElementBackground
                        cpFrame.BackgroundTransparency = getTransparency("Element")
                        cpStroke.Color = t.ElementBorder
                        cpLabel.TextColor3 = t.TextPrimary
                    end)

                    local colorpicker = {}

                    function colorpicker:SetColor(color)
                        currentColor = color
                        preview.BackgroundColor3 = color
                        if cpConfig.Callback then
                            if currentAlpha ~= nil then
                                pcall(cpConfig.Callback, color, currentAlpha)
                            else
                                pcall(cpConfig.Callback, color)
                            end
                        end
                    end

                    function colorpicker:GetColor()
                        return currentColor
                    end

                    local previewBtn = Utilities.Create("TextButton", {
                        Name = "Click",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = "",
                        Parent = preview
                    })

                    local paletteOpen = false
                    local palette

                    previewBtn.MouseButton1Click:Connect(function()
                        if paletteOpen and palette then
                            palette:Destroy()
                            paletteOpen = false
                            return
                        end

                        paletteOpen = true
                        local previewAbsPos = preview.AbsolutePosition
                        local previewAbsSize = preview.AbsoluteSize
                        palette = Utilities.Create("Frame", {
                            Name = "Palette",
                            Position = UDim2.fromOffset(previewAbsPos.X + previewAbsSize.X - 200, previewAbsPos.Y + previewAbsSize.Y + 6),
                            Size = UDim2.fromOffset(200, 150),
                            BackgroundColor3 = currentTheme.DropdownBackground,
                            BackgroundTransparency = getTransparency("Dropdown"),
                            ZIndex = 80,
                            Parent = screenGui
                        })
                        Utilities.AddCorner(palette, 8)
                        Utilities.AddStroke(palette, currentTheme.ElementBorder, 1, 0.4)
                        Utilities.AddPadding(palette, 8, 8, 8, 8)

                        local colorGrid = Utilities.Create("Frame", {
                            Name = "Grid",
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            ZIndex = 81,
                            Parent = palette
                        })

                        Utilities.Create("UIGridLayout", {
                            CellPadding = UDim2.fromOffset(4, 4),
                            CellSize = UDim2.fromOffset(22, 22),
                            FillDirection = Enum.FillDirection.Horizontal,
                            Parent = colorGrid
                        })

                        local presetColors = {
                            Color3.fromRGB(255, 59, 48), Color3.fromRGB(255, 149, 0), Color3.fromRGB(255, 204, 0),
                            Color3.fromRGB(52, 199, 89), Color3.fromRGB(0, 199, 190), Color3.fromRGB(48, 176, 199),
                            Color3.fromRGB(50, 173, 230), Color3.fromRGB(0, 122, 255), Color3.fromRGB(88, 86, 214),
                            Color3.fromRGB(175, 82, 222), Color3.fromRGB(255, 45, 85), Color3.fromRGB(162, 132, 94),
                            Color3.fromRGB(142, 142, 147), Color3.fromRGB(174, 174, 178), Color3.fromRGB(199, 199, 204),
                            Color3.fromRGB(209, 209, 214), Color3.fromRGB(229, 229, 234), Color3.fromRGB(242, 242, 247),
                            Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0),
                        }

                        for _, col in ipairs(presetColors) do
                            local colorBtn = Utilities.Create("TextButton", {
                                Size = UDim2.fromOffset(22, 22),
                                BackgroundColor3 = col,
                                Text = "",
                                AutoButtonColor = false,
                                ZIndex = 82,
                                Parent = colorGrid
                            })
                            Utilities.AddCorner(colorBtn, 5)
                            colorBtn.MouseButton1Click:Connect(function()
                                colorpicker:SetColor(col)
                                palette:Destroy()
                                paletteOpen = false
                            end)
                        end
                    end)

                    return colorpicker
                end

                -- ========== PARAGRAPH ==========
                function section:Paragraph(paraConfig)
                    paraConfig = paraConfig or {}
                    local paraFrame = Utilities.Create("Frame", {
                        Name = "Paragraph",
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundTransparency = 1,
                        Parent = sectionFrame
                    })
                    Utilities.AddListLayout(paraFrame, 4)

                    if paraConfig.Header then
                        local ph = Utilities.Create("TextLabel", {
                            Size = UDim2.new(1, 0, 0, 18),
                            BackgroundTransparency = 1,
                            Text = paraConfig.Header,
                            TextColor3 = currentTheme.TextPrimary,
                            TextSize = 14,
                            Font = Enum.Font.GothamBold,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = paraFrame
                        })
                        registerElement(ph, function(t) ph.TextColor3 = t.TextPrimary end)
                    end

                    if paraConfig.Body then
                        local pb = Utilities.Create("TextLabel", {
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundTransparency = 1,
                            Text = paraConfig.Body,
                            TextColor3 = currentTheme.TextSecondary,
                            TextSize = 12,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            Parent = paraFrame
                        })
                        registerElement(pb, function(t) pb.TextColor3 = t.TextSecondary end)
                    end
                end

                -- ========== LABEL ==========
                function section:Label(labelConfig)
                    labelConfig = labelConfig or {}
                    local lbl = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, 0, 0, 18),
                        BackgroundTransparency = 1,
                        Text = labelConfig.Text or "Label",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionFrame
                    })
                    registerElement(lbl, function(t) lbl.TextColor3 = t.TextPrimary end)
                    return lbl
                end

                -- ========== SUBLABEL ==========
                function section:SubLabel(subConfig)
                    subConfig = subConfig or {}
                    local sl = Utilities.Create("TextLabel", {
                        Name = "SubLabel",
                        Size = UDim2.new(1, 0, 0, 14),
                        BackgroundTransparency = 1,
                        Text = subConfig.Text or "Sub-Label",
                        TextColor3 = currentTheme.TextMuted,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionFrame
                    })
                    registerElement(sl, function(t) sl.TextColor3 = t.TextMuted end)
                    return sl
                end

                -- ========== DIVIDER ==========
                function section:Divider()
                    local div = Utilities.Create("Frame", {
                        Name = "Divider",
                        Size = UDim2.new(1, 0, 0, 1),
                        BackgroundColor3 = currentTheme.DividerColor,
                        BackgroundTransparency = 0.3,
                        BorderSizePixel = 0,
                        Parent = sectionFrame
                    })
                    registerElement(div, function(t) div.BackgroundColor3 = t.DividerColor end)
                    return div
                end

                table.insert(tab.Sections, section)
                return section
            end

            -- ================================================================
            -- CONFIG SECTION (Settings tab)
            -- ================================================================
            function tab:InsertConfigSection(side)
                local configSection = tab:Section({ Side = side or "Left" })
                configSection:Header({ Name = "Configuration" })

                configSection:Button({
                    Name = "Save Config",
                    Primary = true,
                    Callback = function()
                        Window:Notify({
                            Title = windowConfig.Title,
                            Description = "Configuration saved!",
                            Lifetime = 3,
                            Gradient = "Emerald"
                        })
                    end,
                })

                configSection:Button({
                    Name = "Load Config",
                    Callback = function()
                        Window:Notify({
                            Title = windowConfig.Title,
                            Description = "Configuration loaded!",
                            Lifetime = 3,
                            Gradient = "Blue"
                        })
                    end,
                })

                configSection:Divider()

                -- Theme selector (Dark, White, + all gradient themes)
                local themeNames = VXClub:GetThemeNames()

                configSection:Dropdown({
                    Name = "Theme",
                    Options = themeNames,
                    Default = currentTheme.Name,
                    Callback = function(value)
                        Window:SetTheme(value)
                        Window:Notify({
                            Title = windowConfig.Title,
                            Description = "Switched to " .. value .. " theme",
                            Lifetime = 3,
                            Gradient = Gradients[value] and value or nil
                        })
                    end
                })

                -- Liquid Glass toggle
                configSection:Toggle({
                    Name = "Liquid Glass",
                    Default = liquidGlassEnabled,
                    Callback = function(value)
                        Window:SetLiquidGlass(value)
                        Window:Notify({
                            Title = windowConfig.Title,
                            Description = (value and "Enabled" or "Disabled") .. " Liquid Glass",
                            Lifetime = 3,
                            Gradient = "Frost"
                        })
                    end,
                })

                configSection:Divider()

                -- Global settings toggles
                for _, gs in ipairs(Window.GlobalSettings) do
                    configSection:Toggle({
                        Name = gs.Name,
                        Default = gs.Value,
                        Callback = function(value)
                            gs:Set(value)
                        end,
                    })
                end

                return configSection
            end

            table.insert(tabGroup.Tabs, tab)
            table.insert(Window.Tabs, tab)
            return tab
        end

        table.insert(Window.TabGroups, tabGroup)
        return tabGroup
    end

    -- Config management
    function Window:SetFolder(folder)
        SaveFolder = folder
    end

    function Window:LoadAutoLoadConfig()
        -- Placeholder
    end

    table.insert(ActiveWindows, Window)
    return Window
end

function VXClub:LoadAutoLoadConfig()
    -- Placeholder
end

function VXClub:Destroy()
    for _, w in ipairs(ActiveWindows) do
        w:Unload()
    end
    ActiveWindows = {}
end

return VXClub
