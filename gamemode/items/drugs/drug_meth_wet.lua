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

ITEM.ID 					= 9
ITEM.Reference 				= "drug_meth_wet"

ITEM.Name 					= "Meth (Wet)"
ITEM.Description			= "This meth's all wet. You should probably dry it out somehow.\n\n(Place wet meth in item form next to a stove to dry. Let set until begins to boil.)"

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 100

ITEM.InventoryModel 		= Model( "models/props/water_bottle/perp2_bottle.mdl" )
ITEM.WorldModel 			= Model( "models/props/water_bottle/perp2_bottle.mdl" )

ITEM.ModelCamPos 			= Vector( 36, -6, 5 )
ITEM.ModelLookAt 			= Vector( 0, 0, 5 )
ITEM.ModelFOV 				= 70

ITEM.RestrictedSelling	 	= true

if SERVER then	
	function ITEM.OnDrop( Player, Trace )
		if GAMEMODE.Restarting then return Player:Notify( "This function cannot be completed, the server is pending a restart." ) end
		if Player:Team() ~= TEAM_CITIZEN then Player:Notify( "You must be a citizen to drop this." ) end

		local count = 0
		for _, v in pairs( ents.FindByClass( "ent_meth" ) ) do
			if v.Spawner and v.Spawner.SteamID == Player:SteamID() then
				count = count + 1
			end
		end
		
		local iCanHave = MAX_METH

		if count >= iCanHave then return Player:Notify( "You have hit the maximum number of spawned meth allowed." ) end

		local Meth = ents.Create( "ent_meth" )
			Meth:SetPos( Trace.HitPos )
		Meth:Spawn()

		Meth.Spawner = { Entity = Player, SteamID = Player:SteamID(), Name = Player:Nick(), RPName = Player:GetRPName() }

		Player:TakeItemByID( 9, 1 )

		return false
	end
end

GAMEMODE:RegisterItem( ITEM )