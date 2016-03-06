OOUI = OOUI or {}

surface.CreateFont("OOUI.Default", {
    font = "Roboto",
    size = 24
})

-- https://github.com/wjakob/nanogui/blob/master/src/theme.cpp
OOUI.theme = {
    mStandardFontSize                 = 16,
    mButtonFontSize                   = 20,
    mTextBoxFontSize                  = 20,
    mWindowCornerRadius               = 2,
    mWindowHeaderHeight               = 30,
    mWindowDropShadowSize             = 10,
    mButtonCornerRadius               = 2,

    mDropShadow                       = Color(0, 0, 0, 128),
    mTransparent                      = Color(0, 0, 0, 0),
    mBorderDark                       = Color(29, 29, 29, 255),
    mBorderLight                      = Color(92, 92, 92, 255),
    mBorderMedium                     = Color(35, 35, 35, 255),
    mTextColor                        = Color(255, 255, 255, 160),
    mDisabledTextColor                = Color(255, 255, 255, 80),
    mTextColorShadow                  = Color(0, 0, 0, 160),
    mIconColor                        = Color(255, 255, 255, 160),

    mButtonGradientTopFocused         = Color(64, 64, 64, 255),
    mButtonGradientBotFocused         = Color(48, 48, 48, 255),
    mButtonGradientTopUnfocused       = Color(74, 74, 74, 255),
    mButtonGradientBotUnfocused       = Color(58, 58, 58, 255),
    mButtonGradientTopPushed          = Color(41, 41, 41, 255),
    mButtonGradientBotPushed          = Color(29, 29, 29, 255),

    --[[ Window-related ]]
    mWindowFillUnfocused              = Color(43, 43, 43, 230),
    mWindowFillFocused                = Color(45, 45, 45, 230),
    mWindowTitleUnfocused             = Color(220, 220, 220, 160),
    mWindowTitleFocused               = Color(255, 255, 255, 190),

    mWindowHeaderGradientTop          = Color(64, 64, 64, 255),
    mWindowHeaderGradientBot          = Color(48, 48, 48, 255),
    mWindowHeaderSepTop               = Color(92, 92, 92, 255),
    mWindowHeaderSepBot               = Color(29, 29, 29, 255),

    mWindowPopup                      = Color(50, 50, 50, 255),
    mWindowPopupTransparent           = Color(50, 50, 50, 0)
}

-- https://facepunch.com/showthread.php?t=1051898
function draw.GradientBox(x, y, w, h, al, ...)
    local g_grds, g_wgrd, g_sz

    g_grds = {...}
    al = math.Clamp(math.floor(al), 0, 1)
    if(al == 1) then
        local t = w
        w, h = h, t
    end
    g_wgrd = w / (#g_grds - 1)
    local n
    for i = 1, w do
        for c = 1, #g_grds do
            n = c
            if(i <= g_wgrd * c) then break end
        end
        g_sz = i - (g_wgrd * (n - 1))
        surface.SetDrawColor(
            Lerp(g_sz/g_wgrd, g_grds[n].r, g_grds[n + 1].r),
            Lerp(g_sz/g_wgrd, g_grds[n].g, g_grds[n + 1].g),
            Lerp(g_sz/g_wgrd, g_grds[n].b, g_grds[n + 1].b),
            Lerp(g_sz/g_wgrd, g_grds[n].a, g_grds[n + 1].a))
        if(al == 1) then surface.DrawRect(x, y + i, h, 1)
        else surface.DrawRect(x + i, y, 1, h) end
    end
end

--[[
    Class Hierarchy:

     |- UIRenderer

     |- UIResponder
        |- UIView
            |- UIWindow
            |- UILabel
            |- UIImage
            |- UIButton
]]

include("UIRenderer.lua")

OOUI.renderer = UIRenderer()

function OOUI:RegisterTopLevelView(view)
    self.renderer:Add(view)
end

include("ui/UIResponder.lua")
include("ui/UIView.lua")
include("ui/UIWindow.lua")
include("ui/UILabel.lua")
include("ui/UIImage.lua")
include("ui/UIButton.lua")