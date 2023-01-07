--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


SWEP.PrintName = "Mechanic Wrench"
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Author = "G-Force"
SWEP.Instructions = "Left Click: Fix a car"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

function SWEP:PrimaryAttack() return false end
function SWEP:SecondaryAttack() return false end