--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.FurniturePurchased = GM.FurniturePurchased or {}

hook.Add( "PropertyOwnership", "CheckFurniture", function( HomeID, Player )
	Msg( "Cleaning property " .. PROPERTY_DATABASE[ HomeID ].Name .. "'s furniture.\n" )

	local FurniturePurchased = GAMEMODE.FurniturePurchased[ HomeID ]
	if FurniturePurchased then -- Delete all furniture
		for k, v in pairs( FurniturePurchased ) do
			if v.Entities then
				for k, v in pairs( v.Entities ) do
					if IsValid( k ) then
						k:Remove()
					end
				end
			end
		end

		GAMEMODE.FurniturePurchased[ HomeID ] = nil

		if IsValid( FurniturePurchased.Owner ) then
			umsg.Start( "perp_r_f", FurniturePurchased.Owner )
				umsg.Short( HomeID )
			umsg.End()
		end
	end
end )

hook.Add( "MayorQuit", "CheckMayorStuff", function( Player )
	local FurniturePurchased = GAMEMODE.FurniturePurchased[ "City" ]
	if FurniturePurchased then
		for k, v in pairs( FurniturePurchased ) do
			if v.Entities then
				for k, v in pairs( v.Entities ) do
					if IsValid( k ) then
						k:Remove()
					end
				end
			end
		end

		GAMEMODE.FurniturePurchased[ "City" ] = nil

		if IsValid( FurniturePurchased.Owner ) then
			umsg.Start( "perp_r_fc", FurniturePurchased.Owner ) umsg.End()
		end
	end
end )

concommand.Add( "perp_b_f", function( Player, Command, Args )
	if not Args[1] or not Args[2] then return end
	if not Player:NearNPC( 3 ) and not ( Args[1] == "City" and Player:IsMayor() ) then return end

	local Furniture, FurniturePurchased, House
	local FurnitureName = Args[2]

	if Args[1] == "City" and Player:IsMayor() then
		FurniturePurchased = GAMEMODE.FurniturePurchased[ "City" ] or {}
		if FurniturePurchased[ FurnitureName ] then return end

		Furniture = CityFurniture[ FurnitureName ]

		FurniturePurchased[ FurnitureName ] = {}
		FurniturePurchased[ FurnitureName ][ "Entities" ] = {}
	else
		House = PROPERTY_DATABASE[ tonumber( Args[1] ) ]
		if not House then return end

		local FurnitureBase = House.Furniture
		if not FurnitureBase then return end

		Furniture = FurnitureBase[ FurnitureName ]
		if not Furniture then return end

		FurniturePurchased = GAMEMODE.FurniturePurchased[ House.ID ] or {}
		if FurniturePurchased[ FurnitureName ] then return end

		FurniturePurchased[ FurnitureName ] = {}
		FurniturePurchased[ FurnitureName ][ "Entities" ] = {}
	end

	for k, v in pairs( Furniture ) do
		local Entity = ents.Create( "prop_physics" )
		if not IsValid( Entity ) then Error( "prop_physics is null, propertyfurniture.\n" ) end
		Entity:SetModel( v.Model )
		Entity:SetPos( v.Pos )
		Entity:SetAngles( v.Angle )

		Entity:Spawn()
		Entity:Activate()

		Entity.UnBreakable = true
		Entity.UnBurnable = true

		local Physics = Entity:GetPhysicsObject()
		if IsValid( Physics ) then
			Physics:EnableMotion( false )
		end

		FurniturePurchased[ FurnitureName ][ "Entities" ][ Entity ] = true
	end

	FurniturePurchased.Owner = Player

	if Args[1] == "City" then
		GAMEMODE.FurniturePurchased[ "City" ] = FurniturePurchased

		umsg.Start( "perp_b_fc" )
			umsg.String( FurnitureName )
		umsg.End()

		Player:Notify( Format( "You've successfully purchased %s package for %s.", FurnitureName, "the City" ) )
	else
		GAMEMODE.FurniturePurchased[ House.ID ] = FurniturePurchased

		umsg.Start( "perp_b_f" )
			umsg.Short( House.ID )
			umsg.String( FurnitureName )
		umsg.End()

		Player:Notify( Format( "You've successfully purchased %s package for %s.", FurnitureName, House.Name ) )
	end
end )