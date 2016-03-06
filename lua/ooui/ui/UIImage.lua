UIImage = {}
UIImage.prototype = {}
UIImage.__index = UIImage.prototype

setmetatable(UIImage, {
    --- Constructs a new UIImage
    -- @param self Instance
    -- @param path Path to material
    -- @param w Width of image
    -- @param h Height of image
    -- @return UIImage instance
    __call = function(self, path, w, h)
        local obj = UIView()

        obj._mat = Material(path)
        obj.w = w or obj.w
        obj.h = h or w or obj.h

        return setmetatable(obj, self)
    end
})

-- Inherit UIView's prototype
setmetatable(UIImage.prototype, {__index = UIView.prototype})

--[[ PRIVATE: ]]

function UIImage.prototype:_Render()
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(self._mat)
    surface.DrawTexturedRect(self.x, self.y, self.w, self.h)
end