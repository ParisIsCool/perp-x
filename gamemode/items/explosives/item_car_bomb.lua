--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local ITEM 					= {}

ITEM.ID 					= 41
ITEM.Reference 				= "item_car_bomb"

ITEM.Name 					= "Car Bomb"
ITEM.Description			= "Explodes when car is started."

ITEM.Weight 				= 5
ITEM.Cost					= 2000

ITEM.MaxStack 				= 5

ITEM.InventoryModel 		= Model( "models/weapons/w_c4_planted.mdl" )
ITEM.WorldModel 			= Model( "models/weapons/w_c4_planted.mdl" )

ITEM.ModelCamPos 			= Vector( 0, 0, 30 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )		
		local w = Player:GetEyeTrace()
		
		--if LocalPlayer():Team() ~= TEAM_CITIZEN then return LocalPlayer():Notify( "Only Citizens can use this!" ) end //NOT LOCALPLAYER!!! IDIOT
		if Player:Team() ~= TEAM_CITIZEN then return Player:Notify( "Only Citizens can use this!" ) end
		
		if not w.Entity or not IsValid( w.Entity ) or not w.Entity:IsVehicle() then
			return Player:Notify( "You must be aiming at a vehicle to use this item." )
		end
		
		if w.Entity:GetPos():Distance( Player:GetPos() ) > 200 then
			return Player:Notify("You must be aiming at a vehicle to use this item.")
		end

		if w.Entity.DemoVehicle then
			return Player:Notify( "You can't plant on a demo vehicle." )
		end
		
		if w.Entity.RiggedToExplode then
			return Player:Notify("That vehicle is already rigged with a car bomb.")
		end
		
		if w.Entity:GetDriver() and IsValid( w.Entity:GetDriver() ) then
			return Player:Notify( "The driver will see you if you do that!" )
		end
		
		local VehicleTable = w.Entity.vehicleTable
		
		Player:Notify( "Car bomb planted." )

		Log( Format( "%s(%s) planted a car bomb on %s(%s)'s %s at %s", Player:Nick(), Player:GetRPName(), w.Entity.Owner:Nick(), w.Entity.Owner:GetRPName(), VehicleTable.Name or "N/A", w.Entity:GetZoneName() ), Color( 255, 0, 0 ) )

		local Log = Format( "%s(%s)<%s> planted a car bomb on %s(%s)<%s>'s %s at %s", Player:Nick(), Player:GetRPName(), Player:SteamID(), w.Entity.Owner:Nick(), w.Entity.Owner:GetRPName(), VehicleTable.Name or "N/A", w.Entity.Owner:SteamID(), w.Entity:GetZoneName() )
		GAMEMODE:Log( "carbombs", Log )

		GAMEMODE:LogToAdmins("Misc",{
			text = Player:GetRPName() .. " ["..Player:SteamID().."] planted a car bomb on " .. w.Entity.Owner:GetRPName() .. " ["..w.Entity.Owner:SteamID().."] " .. VehicleTable.Name,
			position = w.Entity:GetPos(),
			planter = Player:SteamID(),
			victim = w.Entity.Owner:SteamID(),
			location = Player:GetZoneName(),
		})
		
		w.Entity.RiggedToExplode = true
		w.Entity.Rigger = Player
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )