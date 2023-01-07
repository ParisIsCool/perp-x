AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local moneyModels = {
    "models/player/spike/bag.mdl",
    "models/player/spike/briefcase.mdl",
    "models/player/spike/envelope.mdl",
    "models/player/spike/stack.mdl",
}

function ENT:Initialize()
	self:SetModel( moneyModels[math.random( 1, #moneyModels )] )
    self:SetNWInt("Worth", math.random(500, 2500))

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	self:GetPhysicsObject():Wake()

    self:SetNWBool( 'IsDirty', false )
    self:SetNWInt( 'DirtyTimer', 20*60 )
	
    self.IsStolen = false
end

function ENT:Use(activator, caller)
	if (!activator:IsPlayer()) then return end

    -- Allow cops to confiscate dirty money. 
    -- Add cleaned text once finished.

    if( self.IsStolen ) then
        -- If money is stolen and activated by Gov. or Bank Sec.
        if( activator:IsGovernmentOfficial() || activator:Team() == TEAM_BANK_SECURITY ) then
            activator:GiveBank( 50 )
            activator:Notify("You've been given $50 for compromising the stolen money.")
            self:Remove()
            return
        end

        -- If money is stolen, but too dirty. 
        if( timer.Exists( 'DirtyMoneyTimer-' .. self:EntIndex() ) ) then 
            activator:Notify("[" .. string.FormattedTime( self:GetNWInt( 'DirtyTimer' ), "%02i:%02i" ) .. "] This money is too hot to collect right now.")
            return 
        end

        -- If money is stolen, but not hot and activated by a citizen
        if ( activator:Team() == TEAM_CITIZEN ) then
            activator:GiveCash( self:GetNWInt("Worth") )
            activator:Notify("You've been given $" .. self:GetNWInt("Worth") .. " from collecting the money.")
            self:Remove()
            return
        else
            activator:Notify("Surely you wouldn't want to compromise your job by picking this up.")
            return
        end
    end

    if ( activator:Team() == TEAM_CITIZEN ) then
        self.IsStolen = true
        self:SetNWBool( 'IsDirty', true )
        timer.Create( 'DirtyMoneyTimer-' .. self:EntIndex(), 1, self:GetNWInt( 'DirtyTimer' ), function() 
            self:SetNWInt( 'DirtyTimer', self:GetNWInt( 'DirtyTimer' ) - 1 )
        end)
    end
end

function ENT:OnRemove()
    timer.Remove( 'DirtyMoneyTimer-' .. self:EntIndex() )
end

function ENT:StartTouch( Entity )
	if not IsValid( self.weld ) and Entity:GetClass() == "prop_vehicle_jeep" and Entity.vehicleTable and Entity.vehicleTable.Truck then
		self.weld = constraint.Weld( self, Entity, 0, 0, 0, true )

		local eff = EffectData()
		eff:SetOrigin( self:GetPos() )
		util.Effect( "ManhackSparks", eff )

		self:EmitSound( "physics/metal/sawblade_stick1.wav" )

		if self:IsPlayerHolding() then
			self:GetPhysicsObject():EnableMotion( false )

			timer.Simple( 0.5, function()
				if IsValid( self ) and IsValid( self:GetPhysicsObject() ) then
					self:GetPhysicsObject():EnableMotion( true )
				end
			end )
		end
	end
end
