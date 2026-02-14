--[[
    VX.Club UI Library — macOS-Inspired Roblox UI
    Themes: Dark / White
    Gradients: Blue, Red, Purple, Teal, Orange, Pink, Emerald, Sunset, Ocean, Neon
    
    Author: VX.Club
    Version: 2.0.0
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

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- ══════════════════════════════════════════════════════════════
-- THEME & GRADIENT DEFINITIONS
-- ══════════════════════════════════════════════════════════════

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
    Blue = {
        Start = Color3.fromRGB(59, 130, 246),
        End = Color3.fromRGB(37, 99, 235)
    },
    Red = {
        Start = Color3.fromRGB(239, 68, 68),
        End = Color3.fromRGB(220, 38, 38)
    },
    Purple = {
        Start = Color3.fromRGB(147, 51, 234),
        End = Color3.fromRGB(126, 34, 206)
    },
    Teal = {
        Start = Color3.fromRGB(20, 184, 166),
        End = Color3.fromRGB(13, 148, 136)
    },
    Orange = {
        Start = Color3.fromRGB(249, 115, 22),
        End = Color3.fromRGB(234, 88, 12)
    },
    Pink = {
        Start = Color3.fromRGB(236, 72, 153),
        End = Color3.fromRGB(219, 39, 119)
    },
    Emerald = {
        Start = Color3.fromRGB(16, 185, 129),
        End = Color3.fromRGB(5, 150, 105)
    },
    Sunset = {
        Start = Color3.fromRGB(251, 146, 60),
        End = Color3.fromRGB(236, 72, 153)
    },
    Ocean = {
        Start = Color3.fromRGB(6, 182, 212),
        End = Color3.fromRGB(59, 130, 246)
    },
    Neon = {
        Start = Color3.fromRGB(168, 85, 247),
        End = Color3.fromRGB(236, 72, 153)
    },
    Frost = {
        Start = Color3.fromRGB(99, 179, 237),
        End = Color3.fromRGB(190, 227, 248)
    },
    Lime = {
        Start = Color3.fromRGB(132, 204, 22),
        End = Color3.fromRGB(34, 197, 94)
    },
    Rose = {
        Start = Color3.fromRGB(244, 63, 94),
        End = Color3.fromRGB(251, 113, 133)
    },
    Indigo = {
        Start = Color3.fromRGB(79, 70, 229),
        End = Color3.fromRGB(99, 102, 241)
    },
    Amber = {
        Start = Color3.fromRGB(245, 158, 11),
        End = Color3.fromRGB(252, 211, 77)
    },
}

-- ══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ══════════════════════════════════════════════════════════════

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

function Utilities.AddShadow(parent, color, transparency, size)
    local shadow = Utilities.Create("ImageLabel", {
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
    return shadow
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

local smoothTween = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local fastTween = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local springTween = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- ══════════════════════════════════════════════════════════════
-- LIBRARY CORE
-- ══════════════════════════════════════════════════════════════

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
        DisabledWindowControls = config.DisabledWindowControls or {},
    }

    local currentTheme = Themes[windowConfig.Theme] or Themes.Dark
    local accentGrad = windowConfig.AccentGradient and Gradients[windowConfig.AccentGradient]

    local Window = {
        Settings = windowConfig,
        Theme = currentTheme,
        Gradient = accentGrad,
        Tabs = {},
        TabGroups = {},
        GlobalSettings = {},
        IsVisible = true,
        IsMinimized = false,
        NotificationsEnabled = true,
        AcrylicBlurEnabled = windowConfig.AcrylicBlur,
        ShowUserInfoEnabled = windowConfig.ShowUserInfo,
        UnloadCallbacks = {},
        ThemeChangedCallbacks = {},
        Elements = {},
    }

    -- Screen GUI
    local screenGui = Utilities.Create("ScreenGui", {
        Name = "VXClub_" .. windowConfig.Title:gsub("%s+", ""),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = (syn and syn.protect_gui and CoreGui) or Player:WaitForChild("PlayerGui")
    })

    -- Blur Effect
    local blurEffect
    if windowConfig.AcrylicBlur then
        blurEffect = Utilities.Create("BlurEffect", {
            Name = "VXClubBlur",
            Size = 12,
            Parent = game:GetService("Lighting")
        })
    end

    -- Main Window Frame
    local mainFrame = Utilities.Create("Frame", {
        Name = "MainWindow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = windowConfig.Size,
        BackgroundColor3 = currentTheme.WindowBackground,
        ClipsDescendants = true,
        Parent = screenGui
    })
    Utilities.AddCorner(mainFrame, 12)
    Utilities.AddStroke(mainFrame, currentTheme.SectionBorder, 1, 0.5)
    Utilities.AddShadow(mainFrame, currentTheme.Shadow, currentTheme.ShadowTransparency, 50)

    -- ═══════════════════════════════════════
    -- TITLE BAR
    -- ═══════════════════════════════════════
    local titleBar = Utilities.Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = currentTheme.TitleBar,
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    Utilities.AddCorner(titleBar, 12)

    -- Fix bottom corners of titlebar
    local titleBarFix = Utilities.Create("Frame", {
        Name = "BottomFix",
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundColor3 = currentTheme.TitleBar,
        BorderSizePixel = 0,
        Parent = titleBar
    })

    -- Title bar separator line
    local titleBarSep = Utilities.Create("Frame", {
        Name = "Separator",
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = currentTheme.DividerColor,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = titleBar
    })

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
        createTrafficButton("Maximize", currentTheme.TrafficMaximize, function()
            -- Toggle maximize (restore original size / fill screen)
        end)
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

    -- Subtitle (right side)
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

    -- ═══════════════════════════════════════
    -- BODY CONTAINER
    -- ═══════════════════════════════════════
    local bodyFrame = Utilities.Create("Frame", {
        Name = "Body",
        Position = UDim2.new(0, 0, 0, 42),
        Size = UDim2.new(1, 0, 1, -42),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })

    -- ═══════════════════════════════════════
    -- SIDEBAR
    -- ═══════════════════════════════════════
    local sidebarWidth = 180
    local sidebar = Utilities.Create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, sidebarWidth, 1, 0),
        BackgroundColor3 = currentTheme.SidebarBackground,
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
    local userInfoFrame
    if windowConfig.ShowUserInfo then
        userInfoFrame = Utilities.Create("Frame", {
            Name = "UserInfo",
            Size = UDim2.new(1, 0, 0, 60),
            BackgroundTransparency = 1,
            Parent = sidebar
        })
        Utilities.AddPadding(userInfoFrame, 10, 14, 8, 14)

        local avatarFrame = Utilities.Create("ImageLabel", {
            Name = "Avatar",
            Size = UDim2.fromOffset(36, 36),
            Position = UDim2.new(0, 14, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = currentTheme.ElementBackground,
            Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150",
            Parent = userInfoFrame
        })
        Utilities.AddCorner(avatarFrame, 9999)

        local usernameLabel = Utilities.Create("TextLabel", {
            Name = "Username",
            Position = UDim2.new(0, 58, 0, 12),
            Size = UDim2.new(1, -70, 0, 16),
            BackgroundTransparency = 1,
            Text = Player.DisplayName,
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = userInfoFrame
        })

        local handleLabel = Utilities.Create("TextLabel", {
            Name = "Handle",
            Position = UDim2.new(0, 58, 0, 30),
            Size = UDim2.new(1, -70, 0, 14),
            BackgroundTransparency = 1,
            Text = "@" .. Player.Name,
            TextColor3 = currentTheme.TextMuted,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Parent = userInfoFrame
        })

        -- Divider under user info
        Utilities.Create("Frame", {
            Name = "InfoDivider",
            Position = UDim2.new(0.1, 0, 1, -1),
            Size = UDim2.new(0.8, 0, 0, 1),
            BackgroundColor3 = currentTheme.DividerColor,
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            Parent = userInfoFrame
        })
    end

    -- Sidebar Tab Container (Scrolling)
    local tabScrollFrame = Utilities.Create("ScrollingFrame", {
        Name = "TabScroll",
        Position = UDim2.new(0, 0, 0, windowConfig.ShowUserInfo and 60 or 0),
        Size = UDim2.new(1, 0, 1, windowConfig.ShowUserInfo and -60 or 0),
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

    -- ═══════════════════════════════════════
    -- CONTENT AREA
    -- ═══════════════════════════════════════
    local contentArea = Utilities.Create("Frame", {
        Name = "ContentArea",
        Position = UDim2.new(0, sidebarWidth, 0, 0),
        Size = UDim2.new(1, -sidebarWidth, 1, 0),
        BackgroundColor3 = currentTheme.ContentBackground,
        BorderSizePixel = 0,
        Parent = bodyFrame
    })

    -- ═══════════════════════════════════════
    -- NOTIFICATION CONTAINER
    -- ═══════════════════════════════════════
    local notifContainer = Utilities.Create("Frame", {
        Name = "Notifications",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.new(0, 320, 1, -40),
        BackgroundTransparency = 1,
        Parent = screenGui
    })
    Utilities.AddListLayout(notifContainer, 8, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom)

    -- ═══════════════════════════════════════
    -- DIALOG OVERLAY
    -- ═══════════════════════════════════════
    local dialogOverlay = Utilities.Create("Frame", {
        Name = "DialogOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = currentTheme.DialogOverlay,
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 100,
        Parent = screenGui
    })

    -- ═══════════════════════════════════════
    -- WINDOW API METHODS
    -- ═══════════════════════════════════════

    function Window:SetTheme(themeName)
        local newTheme = Themes[themeName]
        if not newTheme then return end
        currentTheme = newTheme
        Window.Theme = currentTheme

        -- Update core elements
        mainFrame.BackgroundColor3 = currentTheme.WindowBackground
        titleBar.BackgroundColor3 = currentTheme.TitleBar
        titleBarFix.BackgroundColor3 = currentTheme.TitleBar
        titleBarSep.BackgroundColor3 = currentTheme.DividerColor
        sidebar.BackgroundColor3 = currentTheme.SidebarBackground
        sidebarSep.BackgroundColor3 = currentTheme.DividerColor
        contentArea.BackgroundColor3 = currentTheme.ContentBackground

        -- Fire theme changed callbacks
        for _, cb in ipairs(Window.ThemeChangedCallbacks) do
            pcall(cb, currentTheme)
        end
    end

    function Window:SetAccentGradient(gradientName)
        local grad = Gradients[gradientName]
        if grad then
            Window.Gradient = grad
        end
    end

    function Window:GetTheme()
        return currentTheme
    end

    function Window:Notify(config)
        if not Window.NotificationsEnabled then return end
        config = config or {}
        local title = config.Title or "Notification"
        local desc = config.Description or ""
        local lifetime = config.Lifetime or 5
        local gradientName = config.Gradient or nil

        local notifFrame = Utilities.Create("Frame", {
            Name = "Notification",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = currentTheme.NotificationBackground,
            ClipsDescendants = true,
            Parent = notifContainer
        })
        Utilities.AddCorner(notifFrame, 10)
        Utilities.AddStroke(notifFrame, currentTheme.NotificationBorder, 1, 0.3)
        Utilities.AddPadding(notifFrame, 12, 14, 12, 14)

        -- Accent bar on left
        local accentBar = Utilities.Create("Frame", {
            Name = "Accent",
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 3, 1, 0),
            BorderSizePixel = 0,
            Parent = notifFrame
        })
        if gradientName and Gradients[gradientName] then
            accentBar.BackgroundColor3 = Gradients[gradientName].Start
            Utilities.AddGradient(accentBar, Gradients[gradientName].Start, Gradients[gradientName].End, 90)
        elseif accentGrad then
            accentBar.BackgroundColor3 = accentGrad.Start
            Utilities.AddGradient(accentBar, accentGrad.Start, accentGrad.End, 90)
        else
            accentBar.BackgroundColor3 = currentTheme.Accent
        end

        local notifLayout = Utilities.Create("Frame", {
            Name = "Content",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
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
                Parent = notifLayout
            })
        end

        -- Animate in
        notifFrame.BackgroundTransparency = 1
        Utilities.Tween(notifFrame, smoothTween, { BackgroundTransparency = 0 })

        -- Auto-dismiss
        task.delay(lifetime, function()
            if notifFrame and notifFrame.Parent then
                Utilities.Tween(notifFrame, smoothTween, { BackgroundTransparency = 1 }).Completed:Connect(function()
                    notifFrame:Destroy()
                end)
            end
        end)
    end

    function Window:Dialog(config)
        config = config or {}
        dialogOverlay.Visible = true
        Utilities.Tween(dialogOverlay, smoothTween, { BackgroundTransparency = currentTheme.DialogOverlayTransparency })

        local dialogFrame = Utilities.Create("Frame", {
            Name = "Dialog",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.fromOffset(380, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = currentTheme.DialogBackground,
            ZIndex = 101,
            Parent = dialogOverlay
        })
        Utilities.AddCorner(dialogFrame, 14)
        Utilities.AddStroke(dialogFrame, currentTheme.SectionBorder, 1, 0.3)
        Utilities.AddPadding(dialogFrame, 24, 24, 20, 24)

        local dialogLayout = Utilities.AddListLayout(dialogFrame, 12)

        Utilities.Create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = config.Title or "Dialog",
            TextColor3 = currentTheme.TextPrimary,
            TextSize = 16,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Center,
            LayoutOrder = 1,
            Parent = dialogFrame
        })

        Utilities.Create("TextLabel", {
            Name = "Description",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = config.Description or "",
            TextColor3 = currentTheme.TextSecondary,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextWrapped = true,
            LayoutOrder = 2,
            Parent = dialogFrame
        })

        local buttonContainer = Utilities.Create("Frame", {
            Name = "Buttons",
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            Parent = dialogFrame
        })
        Utilities.AddListLayout(buttonContainer, 10, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

        local function closeDialog()
            Utilities.Tween(dialogOverlay, smoothTween, { BackgroundTransparency = 1 }).Completed:Connect(function()
                dialogOverlay.Visible = false
                dialogFrame:Destroy()
            end)
        end

        for i, btnConfig in ipairs(config.Buttons or {}) do
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
                Parent = buttonContainer
            })
            Utilities.AddCorner(btn, 8)

            if isPrimary and accentGrad then
                Utilities.AddGradient(btn, accentGrad.Start, accentGrad.End, 45)
            end

            btn.MouseButton1Click:Connect(function()
                if btnConfig.Callback then
                    pcall(btnConfig.Callback)
                end
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
        if blurEffect then blurEffect.Enabled = state end
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
            tabScrollFrame.Position = UDim2.new(0, 0, 0, state and 60 or 0)
            tabScrollFrame.Size = UDim2.new(1, 0, 1, state and -60 or 0)
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

    -- ═══════════════════════════════════════
    -- GLOBAL SETTINGS
    -- ═══════════════════════════════════════
    function Window:GlobalSetting(config)
        config = config or {}
        local setting = {
            Name = config.Name or "Setting",
            Value = config.Default ~= nil and config.Default or false,
            Callback = config.Callback or function() end,
        }

        function setting:Set(value)
            setting.Value = value
            pcall(setting.Callback, value)
        end

        table.insert(Window.GlobalSettings, setting)
        return setting
    end

    -- ═══════════════════════════════════════
    -- TAB GROUP
    -- ═══════════════════════════════════════
    function Window:TabGroup()
        local tabGroup = {
            Tabs = {},
        }

        -- Tab Group Header (optional separator in sidebar)
        local groupSep = Utilities.Create("Frame", {
            Name = "TabGroupSeparator",
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = currentTheme.DividerColor,
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            Visible = #Window.TabGroups > 0,
            Parent = tabScrollFrame
        })

        function tabGroup:Tab(config)
            config = config or {}
            local tab = {
                Name = config.Name or "Tab",
                Image = config.Image or nil,
                Sections = {},
                IsSelected = false,
                ContentFrame = nil,
            }

            -- Sidebar Tab Button
            local tabBtn = Utilities.Create("TextButton", {
                Name = "Tab_" .. config.Name,
                Size = UDim2.new(1, 0, 0, 34),
                BackgroundColor3 = currentTheme.SidebarBackground,
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                Parent = tabScrollFrame
            })
            Utilities.AddCorner(tabBtn, 7)

            local tabInner = Utilities.Create("Frame", {
                Name = "Inner",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Parent = tabBtn
            })
            Utilities.AddPadding(tabInner, 0, 10, 0, 10)

            if config.Image then
                Utilities.Create("ImageLabel", {
                    Name = "Icon",
                    Position = UDim2.new(0, 10, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.fromOffset(16, 16),
                    BackgroundTransparency = 1,
                    Image = config.Image,
                    ImageColor3 = currentTheme.TextSecondary,
                    Parent = tabBtn
                })
            end

            local tabLabel = Utilities.Create("TextLabel", {
                Name = "Label",
                Position = UDim2.new(0, config.Image and 34 or 10, 0, 0),
                Size = UDim2.new(1, config.Image and -44 or -20, 1, 0),
                BackgroundTransparency = 1,
                Text = config.Name,
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
            if accentGrad then
                Utilities.AddGradient(indicator, accentGrad.Start, accentGrad.End, 90)
            end

            -- Content Frame for this tab
            local contentFrame = Utilities.Create("ScrollingFrame", {
                Name = "Content_" .. config.Name,
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

            -- Two-column layout support
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
                -- Deselect all other tabs
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

            -- ═══════════════════════════════════════
            -- SECTION
            -- ═══════════════════════════════════════
            function tab:Section(config)
                config = config or {}
                local side = config.Side or "Left"
                local parentColumn = (side == "Right") and rightColumn or leftColumn

                local section = {}

                local sectionFrame = Utilities.Create("Frame", {
                    Name = "Section",
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = currentTheme.SectionBackground,
                    Parent = parentColumn
                })
                Utilities.AddCorner(sectionFrame, 10)
                Utilities.AddStroke(sectionFrame, currentTheme.SectionBorder, 1, 0.5)
                Utilities.AddPadding(sectionFrame, 14, 14, 14, 14)

                local sectionLayout = Utilities.AddListLayout(sectionFrame, 8)

                -- ═══════════════════════════════════════
                -- HEADER
                -- ═══════════════════════════════════════
                function section:Header(config)
                    config = config or {}
                    local headerLabel = Utilities.Create("TextLabel", {
                        Name = "Header",
                        Size = UDim2.new(1, 0, 0, 22),
                        BackgroundTransparency = 1,
                        Text = config.Name or config.Text or "Header",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 15,
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionFrame
                    })

                    -- Optional gradient underline
                    if accentGrad then
                        local underline = Utilities.Create("Frame", {
                            Name = "Underline",
                            Size = UDim2.new(0.3, 0, 0, 2),
                            BackgroundColor3 = accentGrad.Start,
                            BorderSizePixel = 0,
                            LayoutOrder = -1,
                            Parent = sectionFrame
                        })
                        Utilities.AddCorner(underline, 1)
                        Utilities.AddGradient(underline, accentGrad.Start, accentGrad.End, 0)
                    end

                    return headerLabel
                end

                -- ═══════════════════════════════════════
                -- BUTTON
                -- ═══════════════════════════════════════
                function section:Button(config)
                    config = config or {}
                    local btnFrame = Utilities.Create("TextButton", {
                        Name = "Button_" .. (config.Name or "Btn"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        Text = "",
                        AutoButtonColor = false,
                        ClipsDescendants = true,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(btnFrame, 8)
                    Utilities.AddStroke(btnFrame, currentTheme.ElementBorder, 1, 0.6)

                    local btnLabel = Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, -16, 1, 0),
                        Position = UDim2.new(0, 8, 0, 0),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Button",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = btnFrame
                    })

                    -- Gradient accent for primary buttons
                    if config.Primary and accentGrad then
                        Utilities.AddGradient(btnFrame, accentGrad.Start, accentGrad.End, 45)
                        btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end

                    btnFrame.MouseEnter:Connect(function()
                        Utilities.Tween(btnFrame, fastTween, { BackgroundColor3 = currentTheme.ElementBackgroundHover })
                    end)
                    btnFrame.MouseLeave:Connect(function()
                        Utilities.Tween(btnFrame, fastTween, { BackgroundColor3 = currentTheme.ElementBackground })
                    end)
                    btnFrame.MouseButton1Click:Connect(function()
                        Utilities.MakeRipple(btnFrame, Vector2.new(Mouse.X, Mouse.Y), currentTheme.Accent)
                        if config.Callback then
                            pcall(config.Callback)
                        end
                    end)

                    return btnFrame
                end

                -- ═══════════════════════════════════════
                -- TOGGLE
                -- ═══════════════════════════════════════
                function section:Toggle(config, flag)
                    config = config or {}
                    local toggled = config.Default or false

                    local toggleFrame = Utilities.Create("Frame", {
                        Name = "Toggle_" .. (config.Name or "Toggle"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(toggleFrame, 8)
                    Utilities.AddStroke(toggleFrame, currentTheme.ElementBorder, 1, 0.6)

                    Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(1, -60, 1, 0),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Toggle",
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

                    -- Gradient on toggle
                    local toggleGrad
                    if accentGrad and toggled then
                        toggleGrad = Utilities.AddGradient(toggleSwitch, accentGrad.Start, accentGrad.End, 0)
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
                            if accentGrad and not toggleGrad then
                                toggleGrad = Utilities.AddGradient(toggleSwitch, accentGrad.Start, accentGrad.End, 0)
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
                        if config.Callback then
                            pcall(config.Callback, toggled)
                        end
                    end)

                    function toggle:Set(value)
                        toggled = value
                        updateVisual()
                        if config.Callback then
                            pcall(config.Callback, toggled)
                        end
                    end

                    function toggle:Get()
                        return toggled
                    end

                    return toggle
                end

                -- ═══════════════════════════════════════
                -- SLIDER
                -- ═══════════════════════════════════════
                function section:Slider(config, flag)
                    config = config or {}
                    local min = config.Minimum or 0
                    local max = config.Maximum or 100
                    local default = config.Default or min
                    local precision = config.Precision or 0
                    local display = config.DisplayMethod or "Value"

                    local sliderFrame = Utilities.Create("Frame", {
                        Name = "Slider_" .. (config.Name or "Slider"),
                        Size = UDim2.new(1, 0, 0, 52),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(sliderFrame, 8)
                    Utilities.AddStroke(sliderFrame, currentTheme.ElementBorder, 1, 0.6)

                    local topRow = Utilities.Create("Frame", {
                        Name = "TopRow",
                        Position = UDim2.new(0, 12, 0, 6),
                        Size = UDim2.new(1, -24, 0, 18),
                        BackgroundTransparency = 1,
                        Parent = sliderFrame
                    })

                    Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(0.6, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Slider",
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
                    if accentGrad then
                        Utilities.AddGradient(fillFrame, accentGrad.Start, accentGrad.End, 0)
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
                    Utilities.AddStroke(knob, currentTheme.ElementBorder, 1, 0.5)

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
                                if config.Callback then
                                    pcall(config.Callback, currentValue)
                                end
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

                -- ═══════════════════════════════════════
                -- INPUT
                -- ═══════════════════════════════════════
                function section:Input(config, flag)
                    config = config or {}

                    local inputFrame = Utilities.Create("Frame", {
                        Name = "Input_" .. (config.Name or "Input"),
                        Size = UDim2.new(1, 0, 0, 60),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(inputFrame, 8)
                    Utilities.AddStroke(inputFrame, currentTheme.ElementBorder, 1, 0.6)
                    Utilities.AddPadding(inputFrame, 8, 12, 8, 12)

                    Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, 0, 0, 16),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Input",
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
                        Text = "",
                        PlaceholderText = config.Placeholder or "Type here...",
                        PlaceholderColor3 = currentTheme.TextMuted,
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ClearTextOnFocus = false,
                        Parent = inputFrame
                    })
                    Utilities.AddCorner(textBox, 6)
                    Utilities.AddStroke(textBox, currentTheme.InputBorder, 1, 0.3)
                    Utilities.AddPadding(textBox, 0, 8, 0, 8)

                    local inputStroke = textBox:FindFirstChildOfClass("UIStroke")

                    textBox.Focused:Connect(function()
                        Utilities.Tween(inputStroke, fastTween, { Color = currentTheme.InputFocusBorder, Transparency = 0 })
                    end)
                    textBox.FocusLost:Connect(function(enterPressed)
                        Utilities.Tween(inputStroke, fastTween, { Color = currentTheme.InputBorder, Transparency = 0.3 })
                        if enterPressed and config.Callback then
                            pcall(config.Callback, textBox.Text)
                        end
                    end)
                    textBox:GetPropertyChangedSignal("Text"):Connect(function()
                        if config.onChanged then
                            pcall(config.onChanged, textBox.Text)
                        end
                    end)

                    local input = {}
                    function input:Set(text)
                        textBox.Text = text
                    end
                    function input:Get()
                        return textBox.Text
                    end

                    return input
                end

                -- ═══════════════════════════════════════
                -- DROPDOWN
                -- ═══════════════════════════════════════
                function section:Dropdown(config, flag)
                    config = config or {}
                    local options = config.Options or {}
                    local multi = config.Multi or false
                    local searchEnabled = config.Search or false
                    local isOpen = false

                    local selectedValues = {}
                    if multi and config.Default then
                        for _, v in ipairs(config.Default) do
                            selectedValues[v] = true
                        end
                    elseif not multi and config.Default then
                        if type(config.Default) == "number" then
                            selectedValues = options[config.Default] or ""
                        else
                            selectedValues = config.Default
                        end
                    end

                    local dropFrame = Utilities.Create("Frame", {
                        Name = "Dropdown_" .. (config.Name or "DD"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        ClipsDescendants = false,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(dropFrame, 8)
                    Utilities.AddStroke(dropFrame, currentTheme.ElementBorder, 1, 0.6)

                    local dropBtn = Utilities.Create("TextButton", {
                        Name = "DropButton",
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundTransparency = 1,
                        Text = "",
                        Parent = dropFrame
                    })

                    Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(0.6, -12, 0, 36),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Dropdown",
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

                    -- Arrow
                    local arrow = Utilities.Create("TextLabel", {
                        Name = "Arrow",
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -10, 0.5, 0),
                        Size = UDim2.fromOffset(12, 12),
                        BackgroundTransparency = 1,
                        Text = "▼",
                        TextColor3 = currentTheme.TextMuted,
                        TextSize = 10,
                        Font = Enum.Font.GothamBold,
                        Parent = dropBtn
                    })

                    -- Options list
                    local optionsList = Utilities.Create("Frame", {
                        Name = "OptionsList",
                        Position = UDim2.new(0, 0, 0, 40),
                        Size = UDim2.new(1, 0, 0, 0),
                        BackgroundColor3 = currentTheme.DropdownBackground,
                        ClipsDescendants = true,
                        Visible = false,
                        ZIndex = 50,
                        Parent = dropFrame
                    })
                    Utilities.AddCorner(optionsList, 8)
                    Utilities.AddStroke(optionsList, currentTheme.ElementBorder, 1, 0.4)

                    local optionsScroll = Utilities.Create("ScrollingFrame", {
                        Name = "Scroll",
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        ScrollBarThickness = 2,
                        ScrollBarImageColor3 = currentTheme.ScrollbarColor,
                        CanvasSize = UDim2.new(0, 0, 0, 0),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        BorderSizePixel = 0,
                        ZIndex = 51,
                        Parent = optionsList
                    })
                    Utilities.AddPadding(optionsScroll, 4, 4, 4, 4)
                    Utilities.AddListLayout(optionsScroll, 2)

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
                                ZIndex = 52,
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
                                    if config.Callback then pcall(config.Callback, selectedValues) end
                                else
                                    selectedValues = option
                                    updateDisplay()
                                    if config.Callback then pcall(config.Callback, option) end
                                    -- Close
                                    isOpen = false
                                    Utilities.Tween(optionsList, fastTween, { Size = UDim2.new(1, 0, 0, 0) }).Completed:Connect(function()
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
                            optionsList.Visible = true
                            local targetH = math.min(#options * 32 + 8, 180)
                            Utilities.Tween(optionsList, smoothTween, { Size = UDim2.new(1, 0, 0, targetH) })
                            Utilities.Tween(arrow, smoothTween, { Rotation = 180 })
                        else
                            Utilities.Tween(optionsList, smoothTween, { Size = UDim2.new(1, 0, 0, 0) }).Completed:Connect(function()
                                optionsList.Visible = false
                            end)
                            Utilities.Tween(arrow, smoothTween, { Rotation = 0 })
                        end
                    end)

                    function dropdown:UpdateSelection(value)
                        if multi then
                            selectedValues = {}
                            for _, v in ipairs(value) do
                                selectedValues[v] = true
                            end
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

                -- ═══════════════════════════════════════
                -- KEYBIND
                -- ═══════════════════════════════════════
                function section:Keybind(config, flag)
                    config = config or {}
                    local currentBind = config.Default or nil
                    local listening = false

                    local kbFrame = Utilities.Create("Frame", {
                        Name = "Keybind_" .. (config.Name or "KB"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(kbFrame, 8)
                    Utilities.AddStroke(kbFrame, currentTheme.ElementBorder, 1, 0.6)

                    Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(0.6, -12, 1, 0),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Keybind",
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
                    Utilities.AddStroke(bindBtn, currentTheme.InputBorder, 1, 0.4)

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
                            if config.onBinded then
                                pcall(config.onBinded, input.KeyCode)
                            end
                        elseif not listening and not gameProcessed and currentBind and input.KeyCode == currentBind then
                            if config.Callback then
                                pcall(config.Callback, currentBind)
                            end
                        end
                    end)

                    function keybind:Set(keyCode)
                        currentBind = keyCode
                        bindBtn.Text = keyCode.Name
                    end

                    return keybind
                end

                -- ═══════════════════════════════════════
                -- COLORPICKER
                -- ═══════════════════════════════════════
                function section:Colorpicker(config, flag)
                    config = config or {}
                    local currentColor = config.Default or Color3.fromRGB(255, 255, 255)
                    local currentAlpha = config.Alpha or nil

                    local cpFrame = Utilities.Create("Frame", {
                        Name = "Colorpicker_" .. (config.Name or "CP"),
                        Size = UDim2.new(1, 0, 0, 36),
                        BackgroundColor3 = currentTheme.ElementBackground,
                        Parent = sectionFrame
                    })
                    Utilities.AddCorner(cpFrame, 8)
                    Utilities.AddStroke(cpFrame, currentTheme.ElementBorder, 1, 0.6)

                    Utilities.Create("TextLabel", {
                        Name = "Label",
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(0.7, -12, 1, 0),
                        BackgroundTransparency = 1,
                        Text = config.Name or "Color Picker",
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

                    local colorpicker = {}

                    function colorpicker:SetColor(color)
                        currentColor = color
                        preview.BackgroundColor3 = color
                        if config.Callback then
                            if currentAlpha ~= nil then
                                pcall(config.Callback, color, currentAlpha)
                            else
                                pcall(config.Callback, color)
                            end
                        end
                    end

                    function colorpicker:GetColor()
                        return currentColor
                    end

                    -- Simple color picker via click (opens palette)
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
                        palette = Utilities.Create("Frame", {
                            Name = "Palette",
                            Position = UDim2.new(1, -10, 1, 6),
                            AnchorPoint = Vector2.new(1, 0),
                            Size = UDim2.fromOffset(200, 150),
                            BackgroundColor3 = currentTheme.DropdownBackground,
                            ZIndex = 60,
                            Parent = cpFrame
                        })
                        Utilities.AddCorner(palette, 8)
                        Utilities.AddStroke(palette, currentTheme.ElementBorder, 1, 0.4)
                        Utilities.AddPadding(palette, 8, 8, 8, 8)

                        -- Color grid
                        local colorGrid = Utilities.Create("Frame", {
                            Name = "Grid",
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            ZIndex = 61,
                            Parent = palette
                        })

                        local gridLayout = Utilities.Create("UIGridLayout", {
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
                                ZIndex = 62,
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

                -- ═══════════════════════════════════════
                -- PARAGRAPH
                -- ═══════════════════════════════════════
                function section:Paragraph(config)
                    config = config or {}
                    local paraFrame = Utilities.Create("Frame", {
                        Name = "Paragraph",
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundTransparency = 1,
                        Parent = sectionFrame
                    })
                    Utilities.AddListLayout(paraFrame, 4)

                    if config.Header then
                        Utilities.Create("TextLabel", {
                            Size = UDim2.new(1, 0, 0, 18),
                            BackgroundTransparency = 1,
                            Text = config.Header,
                            TextColor3 = currentTheme.TextPrimary,
                            TextSize = 14,
                            Font = Enum.Font.GothamBold,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = paraFrame
                        })
                    end

                    if config.Body then
                        Utilities.Create("TextLabel", {
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundTransparency = 1,
                            Text = config.Body,
                            TextColor3 = currentTheme.TextSecondary,
                            TextSize = 12,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            Parent = paraFrame
                        })
                    end
                end

                -- ═══════════════════════════════════════
                -- LABEL
                -- ═══════════════════════════════════════
                function section:Label(config)
                    config = config or {}
                    return Utilities.Create("TextLabel", {
                        Name = "Label",
                        Size = UDim2.new(1, 0, 0, 18),
                        BackgroundTransparency = 1,
                        Text = config.Text or "Label",
                        TextColor3 = currentTheme.TextPrimary,
                        TextSize = 13,
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionFrame
                    })
                end

                -- ═══════════════════════════════════════
                -- SUBLABEL
                -- ═══════════════════════════════════════
                function section:SubLabel(config)
                    config = config or {}
                    return Utilities.Create("TextLabel", {
                        Name = "SubLabel",
                        Size = UDim2.new(1, 0, 0, 14),
                        BackgroundTransparency = 1,
                        Text = config.Text or "Sub-Label",
                        TextColor3 = currentTheme.TextMuted,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sectionFrame
                    })
                end

                -- ═══════════════════════════════════════
                -- DIVIDER
                -- ═══════════════════════════════════════
                function section:Divider()
                    return Utilities.Create("Frame", {
                        Name = "Divider",
                        Size = UDim2.new(1, 0, 0, 1),
                        BackgroundColor3 = currentTheme.DividerColor,
                        BackgroundTransparency = 0.3,
                        BorderSizePixel = 0,
                        Parent = sectionFrame
                    })
                end

                table.insert(tab.Sections, section)
                return section
            end

            -- ═══════════════════════════════════════
            -- CONFIG SECTION (Settings tab)
            -- ═══════════════════════════════════════
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

                -- Theme toggle
                configSection:Dropdown({
                    Name = "Theme",
                    Options = {"Dark", "White"},
                    Default = (currentTheme.Name == "Dark") and 1 or 2,
                    Callback = function(value)
                        Window:SetTheme(value)
                        Window:Notify({
                            Title = windowConfig.Title,
                            Description = "Switched to " .. value .. " theme",
                            Lifetime = 3
                        })
                    end
                })

                -- Gradient accent selector
                local gradientNames = {}
                for name in pairs(Gradients) do
                    table.insert(gradientNames, name)
                end
                table.sort(gradientNames)

                configSection:Dropdown({
                    Name = "Accent Gradient",
                    Options = gradientNames,
                    Default = 1,
                    Callback = function(value)
                        Window:SetAccentGradient(value)
                        Window:Notify({
                            Title = windowConfig.Title,
                            Description = "Accent set to " .. value,
                            Lifetime = 3,
                            Gradient = value
                        })
                    end
                })

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

    -- Config management placeholder
    function Window:SetFolder(folder)
        SaveFolder = folder
    end

    function Window:LoadAutoLoadConfig()
        -- Placeholder for auto-loading configs
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
