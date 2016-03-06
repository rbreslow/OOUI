UIView = {}
UIView.prototype = {}
UIView.__index = UIView.prototype

setmetatable(UIView, {
    --- Constructs a new UIView
    -- @param self Instance
    -- @return UIView instance
    __call = function(self)
        local obj = UIResponder()

        obj._parent = nil
        obj._children = {}

        obj.x = 0
        obj.y = 0

        obj.w = 0
        obj.h = 0

        obj._absoluteX = 0
        obj._absoluteY = 0
        obj._isHovered = false

        return setmetatable(obj, self)
    end
})

-- Inherit UIResponder's prototype
setmetatable(UIView.prototype, {__index = UIResponder.prototype})

--[[ PRIVATE: ]]

--- (Abstract) Called when UIView should render
function UIView.prototype:_Render()
end

--[[ PUBLIC: ]]

--- Set the instance's parent
-- @param parent UIView to parent
function UIView.prototype:SetParent(parent)
    parent:AddChild(self)
end

--- Get the instance's parent
-- @return parent
function UIView.prototype:GetParent()
    return self._parent
end

--- Is UIView a child
-- @return boolean
function UIView.prototype:HasParent()
    return not self._parent == nil and true or false
end

--- Set cursor image
-- @param cursor Cursor
function UIView.prototype:SetCursor(cursor)
    vgui.GetWorldPanel():SetCursor(cursor)
end

--- Add child to UIView
-- @param child
function UIView.prototype:AddChild(child)
    child._parent = self
    table.insert(self._children, child)
end

--- Does UIView have focus (unimplemented)
-- @return boolean
function UIView.prototype:IsFocused()
    return true
end

--- (Abstract) Called when mouse press inside detected
-- @param x The 2D x coordinate
-- @param y The 2D y coordinate
function UIView.prototype:MousePressedInside(x, y)
end

--- (Abstract) Called when mouse release inside detected
-- @param x The 2D x coordinate
-- @param y The 2D y coordinate
function UIView.prototype:MouseReleasedInside(x, y)
end

function UIView.prototype:MousePressed(x, y)
    if self:ContainsPoint(x, y) then
       self:MousePressedInside(x, y)
    end
end

function UIView.prototype:MouseReleased(x, y)
    if self:ContainsPoint(x, y) then
        self:MouseReleasedInside(x, y)
    end
end


function UIView.prototype:ContainsPoint(x, y)
    if (x >= self._absoluteX and x <= self._absoluteX + self.w) and (y >= self._absoluteY and y <= self._absoluteY + self.h) then
        return true
    else
        return false
    end
end

function UIView.prototype:Think()
    if self:ContainsPoint(gui.MousePos()) then
        self._isHovered = true
    else
        self._isHovered = false
    end
end

function UIView.prototype:Render(vmatrix)
    if not self.enabled then return end

    vmatrix = vmatrix or Matrix()
    vmatrix:Translate(Vector(self.x, self.y))

    local translation = vmatrix:GetTranslation()

    self._absoluteX = translation.x
    self._absoluteY = translation.y

    render.SetScissorRect(translation.x, translation.y, translation.x + self.w, translation.y + self.h, true)
        cam.PushModelMatrix(vmatrix)
                self:_Render(vmatrix)
        cam.PopModelMatrix()
    render.SetScissorRect(0, 0, 0, 0, false)

    for i=1, #self._children do
        self._children[i]:Render(vmatrix)
    end
end
