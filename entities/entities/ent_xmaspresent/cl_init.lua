include( "shared.lua" )

function ENT:Initialize()

end

function ENT:Draw()
    
    CreateMaterial("SGNNewMaterial55", "VertexLitGeneric", {
        ["$basetexture"] = "models/debug/debugwhite",
        ["$surfaceprop"] = "metal"
    }):SetVector("$color2", Vector(1.0,0.0,0.0))

    self:SetSubMaterial(1,"!SGNNewMaterial55")
    self:SetSubMaterial(2,"!SGNNewMaterial55")

	self:DrawModel()
end