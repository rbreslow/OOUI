if CLIENT then
    include("ooui/OOUI.lua")
end

if SERVER then
    AddCSLuaFile("ooui/OOUI.lua")
    AddCSLuaFile("ooui/UIRenderer.lua")

    AddCSLuaFile("ooui/ui/UIButton.lua")
    AddCSLuaFile("ooui/ui/UIImage.lua")
    AddCSLuaFile("ooui/ui/UILabel.lua")
    AddCSLuaFile("ooui/ui/UIResponder.lua")
    AddCSLuaFile("ooui/ui/UIView.lua")
    AddCSLuaFile("ooui/ui/UIWindow.lua")
end