-- weapon_vape_custom.lua
-- Defines a Vape that changes accent to match player weapon color

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "Custom Vape"

SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB & Reload: Play Sounds\n\nChange your weapon (physgun) color to customize!"

SWEP.VapeAccentColor = Vector(-1,-1,-1)