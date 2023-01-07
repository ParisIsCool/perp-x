--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

// CONFIG

local HUNGER = {
    LowEnergy = 0
}
  
// UTIL FUNCTIONS

local meta = FindMetaTable("Player")

function meta:GetHunger()
    return self:GetNWInt("Hunger")
end
 
function meta:GetSaturation()
    return self:GetNWInt("Saturation")
end
  
// DRAW HUD

surface.CreateFont( "HungerFont", {
    font = "CloseCaption_Bold", 
    size = 40,
    weight = 500
} )

local Hunger = 0
local HealthH = 0
local Saturation = 0
local function HungerHUD()
 
    draw.RoundedBox( 8, (ScrW()/2) - 155, 920, 310, 60, Color(18, 18, 18, 255) )
    draw.RoundedBox( 8, (ScrW()/2) - 150, 925, 300, 50, Color(43, 43, 44, 180) )
 
    Hunger = Lerp(FrameTime() * 5, Hunger, LocalPlayer():GetHunger() )
    Saturation = Lerp(FrameTime() * 5, Saturation, LocalPlayer():GetSaturation() )
    draw.RoundedBox( 8, (ScrW()/2) - 150, 925, Hunger * 3, 50, Color(248, 170, 74, 255 ) )
    draw.RoundedBox( 8, (ScrW()/2) - 150, 925, Saturation * 4, 50, Color(255, 195, 118, 255 ) )
    draw.SimpleTextOutlined(math.Round(Hunger), "HungerFont", (ScrW()/2) - 5, 947.5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 43, 43, 44))
 
    draw.RoundedBox( 8, (ScrW()/2) - 155, 820, 310, 60, Color(18, 18, 18, 255) )
    draw.RoundedBox( 8, (ScrW()/2) - 150, 825, 300, 50, Color(43, 43, 44, 180) )

    HealthH = Lerp(FrameTime() * 5, HealthH, LocalPlayer():Health() )
    draw.RoundedBox( 8, (ScrW()/2) - 150, 825, HealthH * 3, 50, Color(74, 248, 131, 255 ) )
    draw.SimpleTextOutlined(math.Round(HealthH), "HungerFont", (ScrW()/2) - 5, 847.5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 43, 43, 44))
    
end 

--hook.Add("HUDPaint", "HungerHUD", HungerHUD)

// Remove Sprinting when hungry.

hook.Add( "Tick", "LowEnergy", function() 
    if not IsValid(LocalPlayer()) then 
        return
    elseif (LocalPlayer():KeyPressed( IN_SPEED ) and LocalPlayer():GetHunger() <= HUNGER.LowEnergy ) then
        --LocalPlayer().Stamina = 0
        net.Start("setTired")
        net.SendToServer()
        LocalPlayer():Notify("You don't have enough energy to run. Find something to eat!")
        return false
    else
        -- Not sure how Stamina is called in PERP. This would be the place to initiate Stamina checks though.
    end

end )