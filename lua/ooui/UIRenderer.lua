UIRenderer = {}
UIRenderer.prototype = {}
UIRenderer.__index = UIRenderer.prototype

setmetatable(UIRenderer, {
    --- Constructs a new UIRenderer
    -- @param self Instance
    -- @return UIRenderer instance
    __call = function(self)

        local instance = setmetatable({
            _UIViewList = {}
        }, self)

        instance:_SetupHooks()

        return instance
    end
})

--[[ PRIVATE: ]]

--- Sets up hooks for UIRenderer
function UIRenderer.prototype:_SetupHooks()
    hook.Add("DrawOverlay", tostring(self), function()
        self:Render()
    end)
end

--[[ PUBLIC: ]]

--- Add view to the rendering list
-- @param view
function UIRenderer.prototype:Add(view)
    table.insert(self._UIViewList, view)
end

--- Render all views
function UIRenderer.prototype:Render()
    for i=1, #self._UIViewList do
        self._UIViewList[i]:Render()
    end
end

