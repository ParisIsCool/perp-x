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

ITEM.ID 					= 71
ITEM.Reference 				= "item_explosives"

ITEM.Name 					= "Explosives"
ITEM.Description 			= "Blow up shit or break open doors with this.\nCops will be alerted upon this being planted!!"

ITEM.Weight 				= 5
ITEM.Cost 					= 5000

ITEM.MaxStack 				= 25

ITEM.InventoryModel 		= Model( "models/Items/car_battery01.mdl" )
ITEM.WorldModel 			= Model( "models/Items/car_battery01.mdl" )

ITEM.ModelCamPos			= Vector( 0, 0, 30 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

ITEM.RestrictedSelling	 	= true

if SERVER then
	function ITEM.OnUse( Player )
		
		--if LocalPlayer():Team() ~= TEAM_CITIZEN then return LocalPlayer():Notify( "Only Citizens can use this!" ) end
		if Player:Team() ~= TEAM_CITIZEN then return Player:Notify( "Only Citizens can use this!" ) end
	
		local vStart = Player:GetShootPos()
		local vForward = Player:GetAimVector()
		local trace = {}
			trace.start = vStart
			trace.endpos = vStart + ( vForward * 100 )
			trace.filter = Player
		
		local tr = util.TraceLine( trace )
		
		local NewProp = ents.Create( "item_doorbuster" )
			NewProp:SetPos( tr.HitPos + Vector( 0, 0, 32 ) )
			NewProp.ItemSpawner = Player
			NewProp:Spawn()

		Log( Format( "%s(%s) planted a bomb at %s", Player:Nick(), Player:GetRPName(), Player:GetZoneName() ), Color( 255, 0, 0 ) )

		GAMEMODE:LogToAdmins("Misc",{
			text = Player:GetRPName() .. " ["..Player:SteamID().."] planted a bomb at " .. Player:GetZoneName(),
			position = NewProp:GetPos(),
			planter = Player:SteamID(),
			location = Player:GetZoneName(),
		})
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )