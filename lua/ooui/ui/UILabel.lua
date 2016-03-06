UILabel = {}
UILabel.prototype = {}
UILabel.__index = UILabel.prototype

setmetatable(UILabel, {
    --- Constructs a new UILabel
    -- @param self Instance
    -- @param text Text to displays
    -- @param font Font to display text in
    -- @return UILabel instance
    __call = function(self, text, font)
        local obj = UIView()

        obj.text = text or "UILabel"
        obj.font = font or "OOUI.Default"

        return setmetatable(obj, self)
    end
})

-- Inherit UIView's prototype
setmetatable(UILabel.prototype, {__index = UIView.prototype})

--[[ PRIVATE: ]]

function UILabel.prototype:_Render()
    surface.SetFont(self.font)
    surface.SetTextColor(self.color or Color(255, 255, 255, 255))
    surface.SetTextPos(self.x, self.y)
    surface.DrawText(self.text)
end