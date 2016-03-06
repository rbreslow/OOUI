UIResponder = {}
UIResponder.prototype = {}
UIResponder.__index = UIResponder.prototype

setmetatable(UIResponder, {
    --- Constructs a new UIResponder
    -- @return UIResponder instance
    __call = function(self)
        local instance = setmetatable({
            enabled = true
        }, self)

        instance:_SetupHooks()

        return instance
    end
})

--[[ PRIVATE: ]]

--- Sets up hooks for UIResponder
function UIResponder.prototype:_SetupHooks()
    hook.Add("GUIMousePressed", tostring(self), function(mouseCode, aimVector)
        if self.enabled then
            self:MousePressed(gui.MousePos())
        end
    end)

    hook.Add("GUIMouseReleased", tostring(self), function(mouseCode, aimVector)
        if self.enabled then
            self:MouseReleased(gui.MousePos())
        end
    end)

    hook.Add("Think", tostring(self), function()
        if self.enabled then
            self:Think()
        end
    end)
end

--[[ PUBLIC: ]]

--- (Abstract) Called when mouse press detected
-- @param x The 2D x coordinate
-- @param y The 2D y coordinate
function UIResponder.prototype:MousePressed(x, y)
end

--- (Abstract) Called when mouse release detected
-- @param x The 2D x coordinate
-- @param y The 2D y coordinate
function UIResponder.prototype:MouseReleased(x, y)
end

--- (Abstract) Called every frame
function UIResponder.prototype:Think()
end

