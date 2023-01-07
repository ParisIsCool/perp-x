--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include( "shared.lua" )

SWEP.PrintName = "Admin Keys"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Author = "G-Force"
SWEP.Instructions = "Left Click: Lock Door, Right Click: Unlock Door"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

--file.Write("npc_walkerroutes_rp_southside.json", util.TableToJSON(mapgridTEST,true))
mapgrid = mapgrid or {}

local selected
local target
function SWEP:PrimaryAttack()
    local closest, dist
    local pos = LocalPlayer():GetEyeTrace().HitPos
    for k, v in pairs(mapgrid) do
        local d = pos:Distance(v[1])
        if d < (dist or 99999) then
            closest = k
            dist = d
        end
    end
    if (dist or 201) < 200 then
        if not mapgrid[selected][2] then mapgrid[selected][2] = {} end
        if table.HasValue(mapgrid[selected][2],closest) then return end
        table.insert(mapgrid[selected][2],closest)
        if not mapgrid[closest][2] then mapgrid[closest][2] = {} end
        if table.HasValue(mapgrid[closest][2],selected) then return end
        table.insert(mapgrid[closest][2],selected)
        return
    end
    table.insert(mapgrid,{pos})
    return true 
end
function SWEP:SecondaryAttack()
    local closest, dist
    local pos = LocalPlayer():GetEyeTrace().HitPos
    for k, v in pairs(mapgrid) do
        local d = pos:Distance(v[1])
        if d < (dist or 99999) then
            closest = k
            dist = d
        end
    end
    if dist < 300 then
        if input.IsKeyDown(KEY_LSHIFT) then
            if not mapgrid[selected][2] then mapgrid[selected][2] = {} end
            if table.HasValue(mapgrid[selected][2],closest) then return end
            table.insert(mapgrid[selected][2],closest)
            if not mapgrid[closest][2] then mapgrid[closest][2] = {} end
            if table.HasValue(mapgrid[closest][2],selected) then return end
            table.insert(mapgrid[closest][2],selected)
        else
            if selected == closest then
                target = closest
            end
            selected = closest
        end
    end
    return true 
end
function SWEP:Reload()
    local closest, dist
    local pos = LocalPlayer():GetEyeTrace().HitPos
    for k, v in pairs(mapgrid) do
        local d = pos:Distance(v[1])
        if d < (dist or 99999) then
            closest = k
            dist = d
        end
    end
    if (dist or 201) < 200 then
        mapgrid[closest] = nil
        for k, v in pairs(mapgrid) do
            for _, ass in pairs(v[2] or {}) do
                if ass == closest then
                    v[2][_] = nil
                end
            end
        end
    end
    return true 
end