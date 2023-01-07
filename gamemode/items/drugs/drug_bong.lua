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

ITEM.ID 					= 65
ITEM.Reference 				= "drug_bong"

ITEM.Name 					= '"Tobacco" Water Pipe'
ITEM.Description 			= "Disclaimer: For use with tobacco products only."

ITEM.Weight 				= 30
ITEM.Cost					= 500

ITEM.MaxStack 				= 1

ITEM.InventoryModel			= Model( "models/katharsmodels/contraband/waterpijp/waterpijp.mdl" )
ITEM.WorldModel 			= Model( "models/katharsmodels/contraband/waterpijp/waterpijp.mdl" )

ITEM.ModelCamPos			= Vector( 48, 0, 28 )
ITEM.ModelLookAt 			= Vector( -100, 0, 10 )
ITEM.ModelFOV 				= 70

if SERVER then
	function ITEM.OnUse( Player )	
		if not Player:HasItem( "drug_pot" ) then
			return false
		end

		if Player.GotHigh and Player.GotHigh + 120 >= CurTime() then return end
		Player.GotHigh = CurTime()
		
		Player:TakeItemByID( 13, 1 )
		Player:EmitSound( "perp2.5/smoke.mp3" )
		
		Player:GiveItem( 65, 1, true )

		umsg.Start( "perp_i_bong", Player ) umsg.End()
        
        Player:AddRP(50)
		Player:ReputationNotify( "+50 RP for doing drugs!" )
		
		return true
	end	

	function ITEM.OnDrop( Player, Trace )
		if Player:Team() ~= TEAM_CITIZEN then
			return Player:Notify( "You can not drop illegal items as a government official." )
		end

		return true
	end
else
	local TransitionTime = 6
	local TimeLasting = 60

	hook.Add( "RenderScreenspaceEffects", "ITEM.MakeEffects_Weed", function()
		if not GAMEMODE.WeedStart then return end
		
		local End = GAMEMODE.WeedStart + TimeLasting + TransitionTime * 2
		
		if End < CurTime() then return end

		local tab = {}
			tab[ "$pp_colour_addr" ] = 0
			tab[ "$pp_colour_addg" ] = 0
			tab[ "$pp_colour_addb" ] = 0
			tab[ "$pp_colour_mulr" ] = 0
			tab[ "$pp_colour_mulg" ] = 0
			tab[ "$pp_colour_mulb" ] = 0
		
		if End > CurTime() then
			if GAMEMODE.WeedStart + TransitionTime > CurTime() then
				local s = GAMEMODE.WeedStart
				local e = s + TransitionTime
				local c = CurTime()
				local pf = ( c - s ) / ( e - s )
				
				tab[ "$pp_colour_colour" ] =   1 - pf * 0.3
				tab[ "$pp_colour_brightness" ] = -pf * 0.11
				tab[ "$pp_colour_contrast" ] = 1 + pf * 1.62
				DrawMotionBlur( 0.03, pf * .77, 0 )
			elseif End - TransitionTime < CurTime() then
				local e = End
				local s = e - TransitionTime
				local c = CurTime()
				local pf = 1 - ( c - s ) / ( e - s )
				
				tab[ "$pp_colour_colour" ] = 1 - pf * 0.3
				tab[ "$pp_colour_brightness" ] = -pf * 0.11
				tab[ "$pp_colour_contrast" ] = 1 + pf * 1.62
				DrawMotionBlur( 0.03, pf * .77, 0 )
			else
				tab[ "$pp_colour_colour" ] = 0.77
				tab[ "$pp_colour_brightness" ] = -0.11
				tab[ "$pp_colour_contrast" ] = 2.62
				DrawMotionBlur( 0.03, .77, 0 )
			end
			
			DrawColorModify( tab ) 
		end
	end )
	
	hook.Add( "PlayerDeath", "PlayerDeathWeed", function( Player )
		hook.Remove( "RenderScreenspaceEffects", "ITEM.MakeEffects_Weed" )
	end)

	local GotHigh = 0
	function ITEM.OnUse( Player )	
		if GotHigh + 120 >= CurTime() then return LocalPlayer():Notify( "You recently got high, wait for a while..." ) end

		if not LocalPlayer():HasItem( "drug_pot" ) then
			LocalPlayer():Notify( "You need something to use with this." )
			return false
		end

		GotHigh = CurTime()
		
		return true
	end
	
	usermessage.Hook( "perp_i_bong", function()
		surface.PlaySound( "perp/bong.mp3" )

		timer.Simple( 3, function() GAMEMODE.WeedStart = CurTime() end )
	end )
end

GAMEMODE:RegisterItem( ITEM )