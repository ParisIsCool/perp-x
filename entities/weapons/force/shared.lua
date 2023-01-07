if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "The Force"
	SWEP.Slot = 3
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Predator Network"
SWEP.Instructions = "Left Click: Cast / Reel"

SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ObjectLimit = 5
--SWEP.ViewModel = Model(  "models/weapons/v_perpculars.mdl" )
--SWEP.WorldModel	= Model(  "models/perp2/w_fists.mdl" )

local function float( amp, freq )
    return amp * math.sin(freq * CurTime())
end

local function getKeyFromValue( tbl, val ) 
    for k, v in pairs( tbl ) do
        if v == val then return k end
    end
    return false
end

function SWEP:Initialize() self:SetWeaponHoldType("normal") end

function SWEP:PrimaryAttack() 
    -- Reset physics on release 

    local obj = self.Owner:GetEyeTrace().Entity
    if( IsValid( obj ) ) then 
        if( SERVER ) then
            local objTable = self.Owner:GetPNWVar( 'objects' ) or {}

            -- If object is already in table.
            if getKeyFromValue( objTable, obj ) then return end

            -- If objects are greater than set limit, remove first object.
            if #objTable >= self.ObjectLimit then table.remove( objTable, 1 ) end

            -- Insert new object. 
            table.insert( objTable, obj )
            self.Owner:SetPNWVar( 'objects', objTable )
            return
        end

        if( CLIENT ) then
            -- play sound
            return 
        end
    end 
end

--SWEP.SecondaryAttack = SWEP.PrimaryAttack

local color = Color( 255, 81, 81 )
hook.Add( "PreDrawHalos", "AddPropHalos", function()
    if LocalPlayer():GetActiveWeapon():GetClass() != "force" then return end
    local e = LocalPlayer():GetEyeTrace().Entity

    if not e:GetPhysicsObject() then return end

    if IsValid(e) then
        halo.Add( {e}, color, 5, 5, 2 )
    end
end )



function SWEP:Think( )
	if (SERVER) then 
        local objTable = self.Owner:GetPNWVar( 'objects' )

        if not objTable then return end
        for _, obj in ipairs( objTable ) do
            if not IsValid( obj ) then continue end

            local vec = obj:GetPos()
            obj:SetPos( Vector( vec.x, vec.y, float(1, 5) + vec.z ) )
        end

        local obj = self.Owner:GetEyeTrace().Entity

        -- Add some checking here. 
        if( not obj ) then return end
        if( self.Owner:KeyDown( IN_ATTACK ) ) then
            local obj = objTable[1] -- temp

            if not obj.disttoplayer then
                obj.disttoplayer = self.Owner:GetPos():Distance(obj:GetPos())
            end
            
            if not obj.lerpedVec then
                obj.lerpedVec = obj:GetPos()
            end

            local svec = self.Owner:EyePos()

            local influence = ((self.Owner:GetForward() * obj.disttoplayer) + self.Owner:EyePos()) - obj:OBBCenter()

            obj.lerpedVec = LerpVector( 0.5, obj.lerpedVec, influence )
            obj:SetPos( obj.lerpedVec )
        else
            for k, v in pairs(objTable) do
                v.disttoplayer = nil
            end
        end

    end
end

--[[function SWEP:Holster( )

end--]]


function SWEP:Reload () 
    local objTable = self.Owner:GetPNWVar( 'objects' )

    if( not objTable ) then return end

    if( SERVER ) then
        local e = self.Owner:GetEyeTrace().Entity
        if e:GetPhysicsObject() and e:GetPhysicsObject():IsMoveable() then 
            local obj = getKeyFromValue( objTable, e )

            if obj then
                table.remove( objTable, obj )
                self.Owner:SetPNWVar( 'objects', objTable )
            end
            return 
        else
            self.Owner:SetPNWVar( 'objects', nil )
        end
    end
end