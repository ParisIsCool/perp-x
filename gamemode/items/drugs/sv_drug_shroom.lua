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

ITEM.ID 					= 78
ITEM.Reference 				= "drug_shroom"

ITEM.Name 					= '"Magic" Mushrooms'
ITEM.Description 			= "I wouldn't eat these by themselves... Use to eat. Drop to plant."

ITEM.Weight 				= 10
ITEM.Cost					= 100

ITEM.MaxStack 				= 100

ITEM.InventoryModel 		= Model( "models/fungi/sta_skyboxshroom1.mdl" )
ITEM.WorldModel 			= Model( "models/fungi/sta_skyboxshroom1.mdl" )

ITEM.ModelCamPos 			= Vector( 16, 30, 20 )
ITEM.ModelLookAt 			= Vector( 0, 0, 14 )
ITEM.ModelFOV 				= 70

ITEM.RestrictedSelling	 	= true

if SERVER then
	function ITEM.OnUse( Player )
		umsg.Start( "shroomie", Player ) umsg.End()

		return true
	end

	function ITEM.OnDrop( Player )
		if GAMEMODE.Restarting then return Player:Notify( "This function cannot be completed, the server is pending a restart." ) end
		if Player:Team() ~= TEAM_CITIZEN then return Player:Notify( "You must be a citizen to drop this." ) end

		local Trace = Player:GetEyeTrace()
		if Trace.HitPos:Distance( Player:GetPos() ) > 200 then return end
		
		local NumShroomsAlready = 0
		for _, v in pairs( ents.FindByClass( "ent_shroom" ) ) do
			if v.Spawner and v.Spawner.SteamID == Player:SteamID() then
				NumShroomsAlready = NumShroomsAlready + 1
			end
		end
		
		local iCanHave = 10
		if Player:IsVIP() then
			iCanHave = iCanHave * 2
		end
		
		if NumShroomsAlready >= iCanHave then
			return Player:Notify( "It looks like the soil can't handle any more vegitation." )
		end
		
		if Trace.HitWorld and Trace.MatType == MAT_DIRT then
			local Shroom = ents.Create( "ent_shroom" )
			Shroom:SetPos( Trace.HitPos )
			Shroom:Spawn()
			Shroom:DrawShadow( false )
			Shroom.Spawner = { Entity = Player, SteamID = Player:SteamID(), Name = Player:Nick(), RPName = Player:GetRPName() }
			
			Player:TakeItemByID( 78, 1 )
			
			return false
		else
			return Player:Notify( "You must plant these in soil!" )
		end
		
		return false
	end
end

GAMEMODE:RegisterItem( ITEM )