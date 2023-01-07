--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

include( "shared.lua" )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"

function SWEP:PrimaryAttack()
	local trEntity = self.Owner:GetEyeTrace().Entity
	if IsValid( trEntity ) and trEntity:IsVehicle() and trEntity:GetPos():Distance( self.Owner:GetPos() ) < 200 and trEntity.Owner then
		if trEntity.Owner:IsGovernmentOfficial() then
			return self.Owner:ChatPrint( "Can't ticket government or job workers." )
		end

		if trEntity.Disabled then
			return self.Owner:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?")
		end
		
		if not trEntity.Owner:HasItem( "item_parkingticket" ) then
			self:EmitSound( "ambient/materials/footsteps_glass2.wav" )
			self.Owner:ChatPrint( "Traffic ticket given to " .. trEntity.Owner:GetRPName() )

			Log( Format( "%s(%s) ticketed %s(%s)'s car at %s", self.Owner:Nick(), self.Owner:GetRPName(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity:GetZoneName() ), Color( 255, 0, 0 ) )

			local Log = Format( "%s(%s)<%s> ticketed %s(%s)<%s>'s car at %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), trEntity.Owner:Nick(), trEntity.Owner:GetRPName(), trEntity.Owner:SteamID(), trEntity:GetZoneName() )
			GAMEMODE:Log( "cartickets", Log )
			
			trEntity.Owner:GiveItem( 103, 1 )
			trEntity.Owner:EmitSound( "ambient/materials/footsteps_glass2.wav" )
			
			umsg.Start( "perp_ticket", trEntity.Owner )
				umsg.String( self.Owner:GetRPName() )
				umsg.String( self.Owner:SteamID() )
			umsg.End()
		else
			self.Owner:ChatPrint( "This person has already recieved a ticket." )
		end
	end
	
	self:SetNextPrimaryFire( CurTime() + 6 )
end