--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

if SERVER then
	AddCSLuaFile( "shared.lua" )
end

if CLIENT then
	SWEP.PrintName 			= "Hand Cuffs"
	SWEP.Author 			= "Huntskikbut"
	SWEP.Instructions 		= "Left Click: Arrest\nRight Click: Unarrest"
	SWEP.Slot 				= 2
	SWEP.SlotPos 			= 1
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false

	function SWEP:GetViewModelPosition( Pos, Ang )
		Ang:RotateAroundAxis( Ang:Forward(), 90 )
		Pos = Pos + Ang:Forward() * 6
		Pos = Pos + Ang:Right() * 2

		return Pos, Ang
	end
end

SWEP.ViewModelFOV 			= 62
SWEP.ViewModelFlip 			= false
SWEP.AnimPrefix	 			= "rpg"

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 			= "none"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= 0
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.ViewModel 				= Model( "models/katharsmodels/handcuffs/handcuffs-1.mdl" )
SWEP.WorldModel 			= Model( "models/perp2/w_fists.mdl" )

function SWEP:Initialize()
	self:SetWeaponHoldType( "melee" )
end

function SWEP:PrimaryAttack()
	if not self.Owner:Team() == TEAM_POLICE or not self.Owner:Team() == TEAM_CHIEF or not self.Owner:Team() == TEAM_DETECTIVE or not self.Owner:Team() == TEAM_FBI then self:Remove() return end

	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

	local EyeTrace = self.Owner:GetEyeTrace()

	self.Weapon:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )

	if CLIENT then return end

	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	if Distance > 75 then return end

	local Victim = EyeTrace.Entity
	if not IsValid( Victim ) or not Victim:IsPlayer() then return end

	if Victim:IsGovernmentOfficial() then return self.Owner:Notify( "You cannot arrest Government Employees." ) end
	if Victim:IsTransitOfficial() then return self.Owner:Notify( "You cannot arrest Transit Employees." ) end

	if Victim.CurrentlyArrested then return self.Owner:Notify( "This person is already arrested." ) end

	Log( Format( "%s(%s) arrested %s(%s) at %s", self.Owner:Nick(), self.Owner:GetRPName(), Victim:Nick(), Victim:GetRPName(), Victim:GetZoneName() ), Color( 0, 191, 255 ) )

	local Log = Format( "%s(%s)<%s> arrested %s(%s)<%s> (Warrented: %s) at %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), Victim:Nick(), Victim:GetRPName(), Victim:SteamID(), Victim:IsWarrented() and "Yes" or "No", Victim:GetZoneName() )
	GAMEMODE:Log( "arrests", Log )

	hook.Call("HandcuffPerson", nil, self.Owner, Victim)

	self.Owner:Notify( "You have restrained " .. Victim:GetRPName() .. "! Take him to the jail to finish the job!" )
	self.Owner:Notify( "Max jail time is 10 minutes. Make sure to time your prisoners sentence" )
	Victim:Notify( "You have been restrained! Please cooperate with the officer or risk being banned." )
	Victim:Notify( "Max jail time is 10 minutes, report the government official if your jail time exceeds this." )

	if Victim:IsWarrented() then
		local Log = Format( "%s was rewarded $%i for arresting %s", self.Owner:Nick(), GAMEMODE.CopReward_Arrest or 250, Victim:Nick() )
		GAMEMODE:Log( "cashlog", Log, self.Owner:SteamID() )

		self.Owner:GiveCash( GAMEMODE.CopReward_Arrest, true )

		self.Owner:Notify( "You have been rewarded " .. ( GAMEMODE.CopReward_Arrest or 250 ) .. " for arresting a warranted convict." )
	end

	Victim:Arrest()
	Victim:SetNWBool("isPlayerArrested", true)
	Victim:SetGNWVar( "warrented", nil )

	self.CuffingRagdoll = false
	self.AttemptToCuff = TPlayer
	self.AttemptCuffStart = CurTime()
	local vm = self.Owner:GetViewModel();
	local DeploySeq, Time = vm:LookupSequence("Deploy")

	vm:SendViewModelMatchingSequence(DeploySeq)
	vm:SetPlaybackRate(2)
	//self:PlayCuffSound(.3)
	self.Owner:AddProgress( 34, 1 )
end

function SWEP:SecondaryAttack()
	if not self.Owner:Team() == TEAM_POLICE then self:Remove() return end

	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )

	local EyeTrace = self.Owner:GetEyeTrace()

	self.Weapon:EmitSound( "npc/vort/claw_swing" .. math.random( 1, 2 ) .. ".wav" )

	if CLIENT then return end

	local Distance = self.Owner:EyePos():Distance( EyeTrace.HitPos )
	if Distance > 75 then return end

	local Victim = EyeTrace.Entity
	if not IsValid( Victim ) or not Victim:IsPlayer() then return end

	if Victim:IsGovernmentOfficial() then return self.Owner:Notify( "You cannot release Government Employees." ) end
	
	if Victim:IsTransitOfficial() then return self.Owner:Notify( "You cannot release Transit Employees." ) end

	if not Victim.CurrentlyArrested then return self.Owner:Notify( "This person is not arrested." )  end

	Log( Format( "%s(%s) released %s(%s)", self.Owner:Nick(), self.Owner:GetRPName(), Victim:Nick(), Victim:GetRPName() ), Color( 0, 191, 255 ) )

	local Log = Format( "%s(%s)<%s> released %s(%s)<%s>'s at %s", self.Owner:Nick(), self.Owner:GetRPName(), self.Owner:SteamID(), Victim:Nick(), Victim:GetRPName(), Victim:SteamID(), Victim:GetZoneName() )
	GAMEMODE:Log( "released", Log )

	self.Owner:Notify( "You have released " .. Victim:GetRPName() .. "!")
	Victim:Notify( "You have been released!" )

	Victim:UnArrest()
	Victim:SetNWBool("isPlayerArrested", false)
end
