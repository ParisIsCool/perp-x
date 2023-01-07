include( "shared.lua" )

CreateMaterial( "whiteglowpresents", "VertexLitGeneric", {
	["$basetexture"] = "color/white",
	["$model"] = 1,
	["$translucent"] = 1,
	["$vertexalpha"] = 1,
	["$vertexcolor"] = 1
  } )

net.Receive("collectableset", function()
    local ent = net.ReadEntity()
    ent.InvisFound = true
    ent:EmitSound("collectablepickup.mp3")
end)

  
function ENT:Draw()

    if LocalPlayer():HasCollectable(self:GetNWString("Collectable"),self:GetNWInt("CollectableNum")) then return end

    if self.InvisFound then return end

    self:SetAngles(Angle(45,CurTime()*30,0))
    self.RealPos = self.LastRealPos or self:GetPos()
    local Added = Vector(0,0,(math.sin(CurTime()*3)*3) + 15)
    self:SetPos( self.RealPos + Added )
    self.LastRealPos = self.RealPos

    self:SetMaterial("!whiteglowpresents")
	self:SetColor(color_white)
	self:DrawModel()
	self:SetMaterial("")
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(255,255,255,100+(150*math.abs(math.sin(CurTime()*4)))))
	self:DrawModel()

	self:DrawModel()
end