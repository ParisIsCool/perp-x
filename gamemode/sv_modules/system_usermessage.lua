--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local umsgOld = umsg.Start
local pooled_strings = {}

function umsg.Start( name, players )
	if type( players ) == "Player" and not IsValid( players ) then -- Prevent NULL entity spam.
		local debugger = debug.getinfo( 2 )
		return Error( "%s:%s", debugger.source, debugger.linedefined )
	end

	if not pooled_strings[ name ] then
		pooled_strings[ name ] = true
		umsg.PoolString( name )
	end

	umsgOld( name, players )
end