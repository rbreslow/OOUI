local window = UIWindow()
window.enabled = false
window.x, window.y = 50, 50
window.w, window.h = 512, 512

local button = UIButton("Close Window")
button.w, button.h = 200, 50
function button:Pressed()
    self:GetParent().enabled = false
    self.enabled = false
end

window:AddChild(button)

OOUI:RegisterTopLevelView(window)

concommand.Add("pop_window", function()
    window.enabled = true
end)