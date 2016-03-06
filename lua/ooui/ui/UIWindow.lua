surface.CreateFont("UIWindow.Heading", {
    font = "Roboto",
    size = 24,
    weight = 900
})
surface.CreateFont("UIWindow.Heading.Blur", {
    font = "Roboto",
    size = 24,
    weight = 900,
    blursize = 4
})

UIWindow = {}
UIWindow.prototype = {}
UIWindow.__index = UIWindow.prototype

setmetatable(UIWindow, {
    --- Constructs a new UIWindow
    -- @param self Instance
    -- @param title Title of UIWindow
    -- @return UIWindow instance
    __call = function(self, title)
        local obj = UIView()

        obj.title = title or "UIWindow"
        obj._titleBarHeight = 30
        obj._dragging = {0, 0}

        return setmetatable(obj, self)
    end
})

-- Inherit UIView's prototype
setmetatable(UIWindow.prototype, {__index = UIView.prototype})

--[[ PRIVATE: ]]

function UIWindow.prototype:_Render(vmatrix)
    local w, h = self.w, self.h

    --[[ Fill ]]
    draw.RoundedBox(OOUI.theme.mWindowCornerRadius, 0, 0, w, h, (self:IsFocused() and OOUI.theme.mWindowFillFocused or OOUI.theme.mWindowFillUnfocused))

    --[[ Title Bar ]]
    -- Background gradient
    draw.GradientBox(0, 0, w, self._titleBarHeight, 1, OOUI.theme.mWindowHeaderGradientTop, OOUI.theme.mWindowHeaderGradientBot)

    -- Title text
    surface.SetFont("UIWindow.Heading.Blur")
    local fWidth, fHeight = surface.GetTextSize(self.title)
    draw.SimpleText(self.title, "UIWindow.Heading.Blur",6, self._titleBarHeight / 2 - fHeight / 2 + 2, OOUI.theme.mDropShadow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(self.title, "UIWindow.Heading", 6, self._titleBarHeight / 2 - fHeight / 2, (self:IsFocused() and OOUI.theme.mWindowTitleFocused or OOUI.theme.mWindowTitleUnfocused), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    -- Border top
    surface.SetDrawColor(OOUI.theme.mWindowHeaderSepTop)
    surface.DrawLine(0, 0, w, 0)

    -- Border Bottom
    surface.SetDrawColor(OOUI.theme.mWindowHeaderSepBot)
    surface.DrawRect(0, self._titleBarHeight - 2, w, 2)

    -- Draw everything else below title bar
    vmatrix:Translate(Vector(0, self._titleBarHeight))
end

--[[ PUBLIC: ]]

function UIWindow.prototype:MousePressedInside(x, y)
    if y < self.y + self._titleBarHeight then
        self._dragging[1] = x - self.x
        self._dragging[2] = y - self.y
    end
end

function UIWindow.prototype:MouseReleased(x, y)
    UIView.prototype.MouseReleased(self, x, y)

    self._dragging = {0, 0}
end

function UIWindow.prototype:Think()
    UIView.prototype.Think(self)

    if not (self._dragging[1] == 0 and self._dragging[2] == 0) then
        self.x = math.Clamp(gui.MouseX() - self._dragging[1], 0, ScrW() - self.w)
        self.y = math.Clamp(gui.MouseY() - self._dragging[2], 0, ScrH() - self.h)
    end

    if self._isHovered and gui.MouseY() < self.y + self._titleBarHeight then
        self:SetCursor("sizeall")
        return
    end

    self:SetCursor("arrow")
end

