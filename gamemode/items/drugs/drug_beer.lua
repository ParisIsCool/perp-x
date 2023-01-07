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

ITEM.ID 					= 26
ITEM.Reference 				= "drug_beer"

ITEM.Name 					= "Beer"
ITEM.Description			= "Drink your worries away."

ITEM.Weight 				= 5
ITEM.Cost					= 200

ITEM.MaxStack 				= 15

ITEM.InventoryModel 		= Model( "models/props_junk/garbage_glassbottle002a.mdl" )
ITEM.WorldModel 			= Model( "models/props_junk/garbage_glassbottle002a.mdl" )
ITEM.ModelCamPos 			= Vector( 20, 0, 0 )
ITEM.ModelLookAt 			= Vector( 0, 0, 0 )
ITEM.ModelFOV 				= 70

if SERVER then
	local function RemoveDrankBeer( Player )
		if IsValid( Player ) then
			Player.NumBeersDrank = ( Player.NumBeersDrank or 1 ) - 1
		end
	end
	
	util.AddNetworkString("perp_puke")
	function PLAYER:Puke()
	
		local Group = RecipientFilter()
		Group:AddPVS( self:EyePos())
		Group:AddPlayer( self )
	
		net.Start( "perp_puke" )
			net.WriteEntity(self)
		net.Send(Group)
	
		--self:AddProgress(30, 1)
	end
	
	-- TODO: Clean up this function
	function GAMEMODE:SetupMove( Player, Move )
		if Player:Alive() and Player.NumBeersDrank and Player.NumBeersDrank > 0 then
			if Player:InVehicle() then
				if math.sin( CurTime() / 2 ) < -.8 and ( not Player.LastMod or Player.LastMod ~= 1 ) then
					Player.LastMod = 1
					Player:ConCommand( "+moveright\n" )
				elseif math.sin( CurTime() / 2 ) > .8 and ( not Player.LastMod or Player.LastMod ~= 2 ) then
					Player:ConCommand( "+moveleft\n" )
					Player.LastMod = 2
				elseif !Player.LastMod or Player.LastMod ~= 3 then
					Player:ConCommand("-moveright;-moveleft\n")
					Player.LastMod = 3
				end
			else
				if Player.LastMod then
					Player:ConCommand( "-moveright;-moveleft\n" )
					Player.LastMod = nil
				end
				
				Move:SetMoveAngles( Move:GetMoveAngles() + Angle( 0, math.Clamp( math.sin( CurTime() * 2 ), -.75, .75 ) * math.Clamp( ( Player.NumBeersDrank * 20 ), 0, 60 ), 0 ) )
			end
		elseif Player.LastMod then
			Player:ConCommand( "-moveright;-moveleft\n" )
			Player.LastMod = nil
		end
	end
	
	timer.Create( "DrinkEffects", 10, 0, function()
		for _, v in pairs( player.GetAll() ) do
			if v:Alive() and v.NumBeersDrank and v.NumBeersDrank >= 2 then
				v.NextBarf = v.NextBarf or CurTime() + math.random( 5, 10 )
				
				if v.NextBarf < CurTime() then
					v.NextBarf = CurTime() + math.random( 20, 45 )
					
					v:Puke()
				end
			elseif v.NextBarf then
				v.NextBarf = nil
			end
		end
	end )

	function ITEM.OnUse( Player )
		Player:GiveItem( 27, 1 )

		Player.NumBeersDrank = ( Player.NumBeersDrank or 0 ) + 1
		timer.Simple( 60, function() RemoveDrankBeer( Player ) end )
		
		if Player.NumBeersDrank > 6 and math.random(1, 3) == 1 then
			Player:Notify("You have been hit with alcohol poisoning! I hope you get help soon!")
			Player:Kill()
		end
	
		return true
	end	
else
	hook.Add( "RenderScreenspaceEffects", "ITEM.MakeEffects_BEER", function()
		if not GAMEMODE.NumDrunk or GAMEMODE.NumDrunk == 0 then return end
 		DrawMotionBlur( math.Clamp( .04 - .005 * ( GAMEMODE.NumDrunk - 1 ), .01, .035 ), math.Clamp( GAMEMODE.NumDrunk * .2, .1, 1 ), 0)
	end )
	
	hook.Add( "PlayerDeath", "PlayerDeathBeer", function( Player )
		hook.Remove("RenderScreenspaceEffects", "ITEM.MakeEffects_BEER")
	end)
	
	net.Receive("perp_puke", function(len,Player)
		local ent = net.ReadEntity()
		if IsValid( ent ) then
			local effectdata = EffectData()
			effectdata:SetEntity( ent )
			util.Effect( "vomit", effectdata )
		end
	end )

	function ITEM.OnUse( SlotID )
		GAMEMODE.NumDrunk = ( GAMEMODE.NumDrunk or 0 ) + 1
		surface.PlaySound( "perp2.5/drinking.mp3" )
		timer.Simple( 60, function() GAMEMODE.NumDrunk = GAMEMODE.NumDrunk - 1 end )
		
		return true
	end
end

GAMEMODE:RegisterItem( ITEM )