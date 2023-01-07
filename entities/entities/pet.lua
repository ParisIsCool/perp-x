AddCSLuaFile()

ENT.Base 		    = "base_nextbot"
ENT.Type            = "nextbot"

local petOwner
function ENT:SetpetVars( owner, args )

    petOwner = owner
end

local function IsOwner( ply )

if ply == petOwner then 
    return true
end
return false

end

local function petName()

    local first = math.random(1, 3)
    local last = math.random(1, 3)
    local letters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

    local FirstName = ""
    for i=1, first do 

        local nol = math.random(1, 2)

        if nol == 1 then
            FirstName = FirstName .. tostring(math.random(1, 9))
        elseif nol == 2 then
            local n = math.random(1, 26)
            FirstName = FirstName .. letters[n]
        end

    end

    local LastName = ""
    for i=1, last do 

        local nol = math.random(1, 2)

        if nol == 1 then
            LastName = LastName .. tostring(math.random(1, 9))
        elseif nol == 2 then
            local n = math.random(1, 26)
            LastName = LastName .. letters[n]
        end
        
    end

    return FirstName .. "-" .. LastName
end

function ENT:Initialize()

    self:SetHealth( 100 )
    self:SetModel( "models/tsbb/animals/rat.mdl" )
    --self:SetModel( "models/seagull.mdl" )

    self.StartleDist = 250
    self.WanderDist = 200

    if CLIENT then 
        self.petName = petName()
    end

end


if CLIENT then
    surface.CreateFont("petNameFont", {
        font = "Roboto Thin", 
        size = 60
    })

    function ENT:Draw()

        self:DrawModel()

        cam.Start3D2D(self:LocalToWorld(Vector( 0, 0, (math.sin(CurTime() * 2) * 5) + 25 )), self:GetAngles() + Angle(180, -90, -90), 0.2)
            draw.SimpleText(self.petName, "petNameFont", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()

        cam.Start3D2D(self:LocalToWorld(Vector( 0, 0, (math.sin(CurTime() * 2) * 5) + 25 )), self:GetAngles() + Angle(180, 90, -90), 0.2)
            draw.SimpleText(self.petName, "petNameFont", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()

    end

end

function ENT:PlayerNotNear()
    for k, v in pairs(ents.FindInSphere(self:GetPos(), self.StartleDist ) ) do
        if( v:IsPlayer() && IsOwner(v) ) then 
            return false
        end
    end
    return true
end

function ENT:OnKilled( dmgInfo )
    self:Remove()
    -- self:BecomeRagdoll( dmgInfo )
    
end

function ENT:RunBehaviour()
    while( true ) do
        if( self:PlayerNotNear() ) then
            self:EmitSound( "ambient/alarms/klaxon1.wav" )
            self:StartActivity( ACT_RUN )
            self.loco:SetDesiredSpeed( 100 )
            self:MoveToPos(petOwner:GetPos() + Vector( -50, -50, 0 ) )
            self:StartActivity( ACT_IDLE )
        else
            self:StartActivity( ACT_WALK )
            self.loco:SetDesiredSpeed( 100 )
            self:MoveToPos(self:GetPos() + Vector( math.Rand(-1, 1 ), math.Rand(-1, 1 ), 0 ) * self.WanderDist )
            self:StartActivity( ACT_IDLE )
        end
        coroutine.wait( 1 )
    end
end
list.Set( "NPC", "nextbot_custom", {
    Name = "pet", 
    Class = "pet",
    Category = "NextBot"

} )