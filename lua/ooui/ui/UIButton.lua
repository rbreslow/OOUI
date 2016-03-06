surface.CreateFont("UIButton.Default", {
    font = "Roboto",
    size = 24,
    weight = 900
})

UIButton = {}
UIButton.prototype = {}
UIButton.__index = UIButton.prototype

setmetatable(UIButton, {
    --- Constructs a new UIButton
    -- @param self Instance
    -- @param title Title for button
    -- @return UIButton instance
    __call = function(self, title)
        local obj = UIView()

        obj.title = title or "UIButton"
        obj._isDown = false

        return setmetatable(obj, self)
    end
})

-- Inherit UIView's prototype
setmetatable(UIButton.prototype, {__index = UIView.prototype})

--[[ PRIVATE: ]]

function UIButton.prototype:_Render()
    local w, h = self.w, self.h

    local gradTop = OOUI.theme.mButtonGradientTopUnfocused
    local gradBot = OOUI.theme.mButtonGradientBotUnfocused

    if self._isDown then
        gradTop = OOUI.theme.mButtonGradientTopPushed
        gradBot = OOUI.theme.mButtonGradientBotPushed
    elseif self._isHovered then
        gradTop = OOUI.theme.mButtonGradientTopFocused
        gradBot = OOUI.theme.mButtonGradientBotFocused
    end

    -- Bottom border light
    draw.RoundedBox(OOUI.theme.mButtonCornerRadius, 0, h / 2, w, h / 2, OOUI.theme.mBorderLight)

    -- Border dark
    draw.RoundedBox(OOUI.theme.mButtonCornerRadius, 0, 0, w, h - 2, OOUI.theme.mBorderDark)

    -- Top border light
    draw.RoundedBox(OOUI.theme.mButtonCornerRadius +1, 2, 2, w - 4, h / 2, OOUI.theme.mBorderLight)

    -- Background gradient
    draw.GradientBox(2, 3, w - 4, h - 8, 1, gradTop, gradBot)

    -- Button text
    surface.SetFont("UIButton.Default")
    local fWidth, fHeight = surface.GetTextSize(self.title)
    draw.SimpleText(self.title, "UIButton.Default", w / 2 - fWidth / 2, h / 2 - fHeight / 2, OOUI.theme.mTextColorShadow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(self.title, "UIButton.Default", w / 2 - fWidth / 2, h / 2 - fHeight / 2 + 2, OOUI.theme.mTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

--[[ PUBLIC: ]]

--- Called when button is pressed
function UIButton.prototype:Pressed()
end

function UIButton.prototype:MousePressedInside()
    self._isDown = true
end

function UIButton.prototype:MouseReleased(x, y)
    UIView.prototype.MouseReleased(self, x, y)

    if self._isDown then
        self:Pressed()
        self._isDown = false
    end
end

function UIButton.prototype:Think()
    UIView.prototype.Think(self)

    if self._isHovered then
        self:SetCursor("hand")
        return
    end

    self:SetCursor("arrow")
end