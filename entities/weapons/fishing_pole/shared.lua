if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Fishing Pole"
	SWEP.Slot = 3
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Predator Network"
SWEP.Instructions = "Left Click: Cast / Right Click: Reel"

SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
--SWEP.Primary.Automatic = false
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

--SWEP.ViewModel = Model(  "models/weapons/v_perpculars.mdl" )
--SWEP.WorldModel	= Model(  "models/perp2/w_fists.mdl" )

-- Set movetype on prop grab.
-- Remove object from parent on remove. 
-- Reset bobber on death or add line of site check for removal?
-- self.Owner:OnTakeDamage if attacker == bobber return false?
-- Add models. 
-- Add sound effects.
-- Add in-game items.
-- Add potential cooking / selling of fish. 
-- Not give damage
-- Hook onto other items?

function SWEP:Initialize() 
    self:SetWeaponHoldType("normal") 
    self.Config = {
        BobberPickupRange = 60,
        FishingWaterLevel = 2,
        BobberWaterLevelCheckRate = 10,
        AttemptHookRate = 30,
        RainMultiplier = 2,
        hookable = {
            'ent_item',
            'ent_prop_item',
        }
    }
end

-- Set to meta function to access config. 
function SWEP:HookItem()
    -- Gives us room to increase or decrease loot tables if we add more items. 
    local lootTable = {
        ['fish'] = 5,
        ['junk'] = 5,
        ['none'] = 15 -- 15
    }

    -- Multiply chance of catching fish if it is raining. 
    if ( StormFox.IsRaining() ) then lootTable.fish = lootTable.fish * self.Config.RainMultiplier end

    local loot = {}
    for k, v in pairs( lootTable ) do
        for i = 1, v do 
            table.insert( loot, k )
        end
    end

    return loot[math.random( 1, #loot )]
end

function SWEP:PrimaryAttack() 

    if CLIENT then return end 

    self.ents = self.ents or {}
    local melon = ents.Create("prop_physics")
    table.insert(self.ents,melon)
    melon:SetModel( "models/props_junk/watermelon01.mdl" )
    melon:SetPos(self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 100)
    melon:Spawn()
    melon:GetPhysicsObject():AddVelocity( self.Owner:EyeAngles():Forward() * 1000 )

    --[[self.Reel = false

    -- If bobber is already out
    if( IsValid( self.bobber ) ) then 
        -- If bobber is further than rope length
        if ( self.Owner:GetPos():Distance(self.bobber:GetPos()) > 1000 ) then 
            -- If rope exists, remove
            if( self.Rope ) then self.Rope:Remove() end
            -- Remove bobber.
            self.bobber:Remove() 
        end
        return 
    end

    -- Otherwise, cast bobber.
    if ( SERVER ) then

        self.bobber = ents.Create("ent_bobber")
        self.bobber:SetPos(self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 100)
        self.bobber:Spawn()
        self.bobber:GetPhysicsObject():AddVelocity( self.Owner:EyeAngles():Forward() * 1000 )

        self.Rope = constraint.Rope( self.Owner, self.bobber, 0, 0, Vector( 0, 0, 0 ), Vector( 0, 0, 0 ), 0, 1000, 0, 1, "cable/cable2", false )

        -- Set reference to self for Touch function.
        local rod = self
        function self.bobber:Touch( entity )

            -- If something is already on the hook and you're catching something, return. 
            if ( rod.canCatch || rod.caught ) then return end

            -- Get entity bobber is touching's class.
            local class = entity:GetClass() 

            for _, v in ipairs( rod.Config.hookable ) do
                if ( class == v ) then 
                    print(entity:GetMoveType())
                    -- Set touching item's parent to bobber.
                    entity:SetParent( self, -1)

                    entity:SetMoveType( 6 )

                    -- Remove the old rope.
                    rod.Rope:Remove()

                    -- Create a new rope locking the position between the player and the bobber linked to the object. 
                    rod.Rope = constraint.Rope( rod.Owner, rod.bobber, 0, 0, Vector( 0, 0, 0 ), Vector( 0, 0, 0 ), rod.Owner:GetPos():Distance(rod.bobber:GetPos()), 0, 0, 1, "cable/cable2", false )
                    break
                end
            end
        end
        

        -- Check if bobber is mostly submerged every 10 seconds. 
        timer.Create( 'bobberDeployed' .. self.Owner:SteamID(), self.Config.BobberWaterLevelCheckRate, 0, function() -- 10
            -- If the bobber is not valid then delete this timer. 
            if( not IsValid( self.bobber ) ) then timer.Remove( 'bobberDeployed' .. self.Owner:SteamID() ) return end

            -- If bobber is mostly submerged
            if ( self.bobber:WaterLevel() >= self.Config.FishingWaterLevel ) then
                -- Remove water submersion check
                timer.Remove( 'bobberDeployed' .. self.Owner:SteamID() )
                
                -- Begin fishing and attempting to hook an item every 30 seconds.
                timer.Create( 'fishing' .. self.Owner:SteamID(), self.Config.AttemptHookRate, 0, function() -- 30
                    -- If the bobber is not valid then delete the fishing timer. 
                    if( not IsValid( self.bobber ) ) then timer.Remove( 'fishing' .. self.Owner:SteamID() ) return end

                    -- Hook an item. 
                    self.hooked = self:HookItem()

                    -- Temporary print
                    print( self.hooked )

                    -- If you did not hook anything, return.
                    if ( self.hooked == 'none' ) then return end

                    -- If you did hook something, set canCatch to true, create ripple and bounce effect. 
                    self.canCatch = true

                    -- Ripple Effect
                    local pos = self.bobber:GetPos()
                    local effectdata = EffectData()
                    effectdata:SetStart( pos )
                    effectdata:SetOrigin( pos )
                    effectdata:SetScale( 10 )
                    util.Effect( "watersplash", effectdata )

                    -- Bounce effect
                    self.bobber:GetPhysicsObject():AddVelocity( Vector( 0, 0, -20 ) )
                    timer.Simple( 0.25, function() self.bobber:GetPhysicsObject():AddVelocity( Vector( 0, 0, 10 ) ) end)

                    -- Create 2 second window to begin reel in and catch the item. 
                    timer.Simple( 2, function() self.canCatch = false end)

                end)
            end
        end )
    end]]
end

function SWEP:SecondaryAttack()

    for k, v in pairs(self.ents) do
        v:Remove()
    end
    
    -- Reference bobber, if not valid then return.
    --[[if not IsValid( self.bobber ) then return end 

    -- If reeling in, return. 
    if self.Reel then return end
    
    if ( SERVER ) then
        -- Set begin reel in to true. 
        self.Reel = true

        -- If the user pressed the reel in during the window of opportunity
        if ( self.canCatch ) then 
            -- Set caught to true ( as canCatch will be updated seconds later )
            self.caught = true 

            -- Remove timers. 
            if ( timer.Exists( 'bobberDeployed' .. self.Owner:SteamID() ) ) then timer.Remove( 'bobberDeployed' .. self.Owner:SteamID() ) end
            if ( timer.Exists( 'fishing' .. self.Owner:SteamID() ) ) then timer.Remove( 'fishing' .. self.Owner:SteamID() ) end
        end

        -- Begin reeling in.
        timer.Create( "Reel" .. self.Owner:SteamID(), 0.1, 0, function()

            -- Slowly lower the distance the rope should be to the player.
            self.RopeDist = self.Owner:GetPos():Distance(self.bobber:GetPos()) * 0.99

            -- Remove the old rope.
            self.Rope:Remove()

            -- Create a new rope at a smaller distance, moving thebobber closer. 
            self.Rope = constraint.Rope( self.Owner, self.bobber, 0, 0, Vector( 0, 0, 0 ), Vector( 0, 0, 0 ), self.RopeDist, 0, 0, 1, "cable/cable2", false )

            -- If the rope is within this distance of the player
            if( self.RopeDist <= self.Config.BobberPickupRange ) then

                -- Set reel in to false.
                self.Reel = false

                -- Remove object from parent. 
                for k, v in pairs( self.bobber:GetAttachments() ) do
                    
                end

                -- Remove rope / bobber.
                self.Rope:Remove()
                self.bobber:Remove()

                -- Remove reel in timer. 
                timer.Remove("Reel" .. self.Owner:SteamID())

                -- If player caught item
                if ( self.caught ) then

                    -- If for some reason caught is set to true but hook is not set, or set to none ( this shouldnt happen ), return.
                    if ( !self.hooked || self.hooked == 'none' ) then return end

                    -- Give Reward
                    -- Remove Bait

                    if ( self.hooked == "fish" ) then
                        self.Owner:Notify( "You caught a fish!")
                        self.Owner:GiveItem( 200, 1 )
                    end

                    -- Reset variables. 
                    self.caught, self.hooked = false, 'none'

                end
            end
        end)

    end]]

end

function SWEP:Think( )
	if (SERVER) then return end
end

--[[function SWEP:Holster( )

end--]]

function SWEP:Reload ( ) end
