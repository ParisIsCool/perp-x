--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


GM.CurrentSpeedLimits = nil

if not GM.CurrentSpeedLimits then
    GM.CurrentSpeedLimits = {}
    for k, v in pairs(StreetBlocks or {}) do
        GM.CurrentSpeedLimits[k] = v.speed or 40
    end
end