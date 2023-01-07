include( "shared.lua" )

function ENT:Initialize()
    self.bowcolor = Vector(math.Rand(0,1),math.Rand(0,1),math.Rand(0,1))
    --self.OGPos = self:GetPos()
    --self.LoopinSound = self:StartLoopingSound("collectable.wav")
end

CreateMaterial( "whiteglowpresents", "VertexLitGeneric", {
	["$basetexture"] = "color/white",
	["$model"] = 1,
	["$translucent"] = 1,
	["$vertexalpha"] = 1,
	["$vertexcolor"] = 1
  } )


net.Receive("xmascollectableset", function()
    local ent = net.ReadEntity()
    ent.InvisFound = true
    ent:EmitSound("collectablepickup.mp3")
end)

  
function ENT:Draw()

    if LocalPlayer():HasCollectable(self:GetNWString("Collectable"),self:GetNWInt("CollectableNum")) then return end

    if self.InvisFound then return end

    self:SetAngles(Angle(0,CurTime()*30,0))
    self.RealPos = self.LastRealPos or self:GetPos()
    local Added = Vector(0,0,(math.sin(CurTime()*3)*3) + 8)
    self:SetPos( self.RealPos + Added )
    self.LastRealPos = self.RealPos
    
    CreateMaterial("SGNNewMaterial55", "VertexLitGeneric", {
        ["$basetexture"] = "models/debug/debugwhite",
        ["$surfaceprop"] = "metal"
    }):SetVector("$color2", self.bowcolor)

    self:SetSubMaterial(1,"!SGNNewMaterial55")
    self:SetSubMaterial(2,"!SGNNewMaterial55")

    self:SetMaterial("!whiteglowpresents")
	self:SetColor(color_white)
	self:DrawModel()
	self:SetMaterial("")
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(255,255,255,100+(150*math.abs(math.sin(CurTime()*4)))))
	self:DrawModel()

	self:DrawModel()
end