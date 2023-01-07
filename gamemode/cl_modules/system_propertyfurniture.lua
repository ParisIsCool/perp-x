--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.FurnishedProperties = GM.FurnishedProperties or {}

-- perp_buy_furniture, this will add "purchased" furniture into a table
-- this will only be sent to the owner of a property.
usermessage.Hook( "perp_b_f", function( UMsg )
	local House 		= UMsg:ReadShort()
	local Furniture 	= UMsg:ReadString()

	GAMEMODE.FurnishedProperties[ House ] = GAMEMODE.FurnishedProperties[ House ] or {}
	table.insert( GAMEMODE.FurnishedProperties[ House ], Furniture )
end )

-- perp_buy_furniture_city, this will add purchased contraptions into the table above
-- couldn't use the usermessage above due to the city using "city" as its id...
usermessage.Hook( "perp_b_fc", function( UMsg )
	local Furniture = UMsg:ReadString()

	GAMEMODE.FurnishedProperties[ "City" ] = GAMEMODE.FurnishedProperties[ "City" ] or {}
	table.insert( GAMEMODE.FurnishedProperties[ "City" ], Furniture )
end )

-- perp_reset_furniture, this will clear out all "purchased" furniture
usermessage.Hook( "perp_r_f", function( UMsg ) GAMEMODE.FurnishedProperties[ UMsg:ReadShort() ] = {} end )

-- perp_rest_furniture_city, again this will clean only city, cant use above umsg because it uses ReadShort()
usermessage.Hook( "perp_r_fc", function( UMsg ) GAMEMODE.FurnishedProperties[ "City" ] = {} end )