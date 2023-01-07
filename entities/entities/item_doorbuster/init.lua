--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/Items/car_battery01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.Damage = math.random( 90, 500 )

	local UniqueName = tostring( math.random( 5000 ) )
	--radar.AddAlertTeam( UniqueName, { TEAM_FIREMAN, TEAM_MAYOR, TEAM_PARAMEDIC, TEAM_SWAT, TEAM_FBI, TEAM_CHIEF }, self:GetPos(), "Illegal Explosive", Color( 255, 0, 0, 200 ) )
	--timer.Simple( 60, function() radar.RemoveAlert(UniqueName) end)

	for i = 1, 20 do
		timer.Simple( i, function() self:Beep(100) end)
	end

	timer.Simple( 21, function() self:Beep(110) end)
	timer.Simple( 22, function() self:Beep(120) end)
	timer.Simple( 23, function() self:Beep(130) end)
	timer.Simple( 24, function() self:Beep(140) end)
	timer.Simple( 25, function() self:Beep(150) end)
	timer.Simple( 26, function() self:Beep(160) end)
	timer.Simple( 27, function() self:Beep(170) end)
	timer.Simple( 28, function() self:Beep(180) end)
	timer.Simple( 29, function() self:Beep(190) end)
	timer.Simple( 29.2, function() self:Beep(190) end)
	timer.Simple( 29.4, function() self:Beep(190) end)
	timer.Simple( 30, function() self:DestroyDoors() end)
	  
	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:Wake()
	end
end

function ENT:Beep( i )
	if not IsValid( self ) then return end
	
	self:EmitSound( "buttons/button17.wav", 100, i or 100 )
end

function ENT:DestroyDoors()
	if not IsValid( self ) then return end
	
	for k, door in pairs( ents.FindInSphere( self:GetPos(), 64 ) ) do
		--if door:IsVehicle() then door:DisableVehicle() end

		if door:IsDoor() then
			if IsValid( door ) and ( door:GetClass() == "prop_door_rotating" or door:GetClass() == "func_door_rotating" or door:GetClass() == "func_door" ) then
				door:Fire( "unlock", "", 0 )
				door:Fire( "open", "", 0 )
			end

			if IsValid( door ) and door:GetClass() == "prop_door_rotating" then
				door:EmitSound( Sound( "physics/wood/wood_box_impact_hard3.wav" ) )

				local pos = door:GetPos()
				local ang = door:GetAngles()
				local model = door:GetModel()
				local skin = door:GetSkin()
					
				door:SetNotSolid( true )
				door:SetNoDraw( true )
				
				local function ResetDoor( door, fakedoor )
					if not IsValid( door ) then return end
					door:SetNotSolid( false )
					door:SetNoDraw( false )
					door.NodDraw = false
					if not IsValid( fakedoor ) then return end
					fakedoor:Remove()
				end
				
				local norm = ( pos - self:GetPos() ):GetNormalized()
				local push = 10000 * norm

				if not door.NoDraw then
					local ent = ents.Create( "prop_physics_multiplayer" )
						ent:SetPos( pos )
						ent:SetAngles( ang )
						ent:SetModel( model )
						if skin then
							ent:SetSkin( skin )
						end
						ent:Spawn()
					
					door.NoDraw = true
					timer.Simple(.2, function() ent:SetVelocity(push) end)					
					timer.Simple(.2, function() ent:GetPhysicsObject():ApplyForceCenter(push) end)
																
					timer.Simple( 300, function() ResetDoor(door, ent) end)
				end
			end
		end
	end

	util.ScreenShake( self:GetPos(), 15, 15, 3, 2000 )  
	util.BlastDamage( self, IsValid( self.ItemOwner ) and self.ItemOwner or self, self:GetPos(), 1500, self.Damage )
	self:EmitExplodeEffect()
	self:Remove()
end

function ENT:EmitExplodeEffect()
	if not IsValid( self ) then return end
	
	self:EmitSound( "ambient/explosions/explode_" .. math.random(4) .. ".wav" )
	self:EmitSound( "ambient/explosions/explode_" .. math.random(4) .. ".wav" )
	self:EmitSound( "ambient/explosions/explode_" .. math.random(4) .. ".wav" )
	
	local effectdata = EffectData()
		effectdata:SetStart( self:GetPos() )
		effectdata:SetOrigin( self:GetPos() )
		effectdata:SetScale( 1 )
		util.Effect( "effect_doorbuster", effectdata )
end