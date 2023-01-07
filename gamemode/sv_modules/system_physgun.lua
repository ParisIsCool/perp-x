--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local function SetPhysColor( Player, args )
	local col = Vector( math.Clamp( tonumber( args[1] ), 0.01, 1 ), math.Clamp( tonumber( args[2] ), 0.01, 1 ), math.Clamp( tonumber( args[3] ), 0.01, 1 ) )
	Player.PhysColor = col
	Player:SetWeaponColor( col )
end

function GM.LoadPhysgun( Player )

	tmysql.query( Format( Query( "LOADPHYSCOLORS" ), Player.PERPID ), function ( data )

		if( data and data[1] and data[1]["physgun_col"] ) then

			local tbl = util.JSONToTable( data[1]["physgun_col"] )
			if( #tbl != 3 ) then return end


			SetPhysColor( Player, tbl )
		end
	end )

end

net.Receive( "perp_physcolor", function ( length, Player )
	if( !Player:IsGoldVIP() ) then return end
	if( Player:GetCash() < PHYSGUN_COLORPRICE ) then return end
	
	local tbl = net.ReadTable()
	if( #tbl != 3 ) then return end

	SetPhysColor( Player, tbl )

	Player:TakeCash( PHYSGUN_COLORPRICE )

	local newtab = { ( math.Round( tbl[1], 2 ) ), ( math.Round( tbl[2], 2 ) ), ( math.Round( tbl[3], 2 ) ) }
	local qstring = util.TableToJSON( newtab )
	tmysql.query( Format( Query( "SAVEPHYSCOLORS" ), qstring, Player.PERPID ) )
end)