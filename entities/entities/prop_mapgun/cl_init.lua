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

CreateMaterial( "whiteglowguns", "VertexLitGeneric", {
	["$basetexture"] = "color/white",
	["$model"] = 1,
	["$translucent"] = 1,
	["$vertexalpha"] = 1,
	["$vertexcolor"] = 1
  } )

function ENT:Draw()
	self:SetMaterial("!whiteglowguns")
	self:SetColor(color_white)
	self:DrawModel()
	self:SetMaterial("")
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(Color(255,255,255,200+(50*math.abs(math.sin(CurTime()*4)))))
	self:DrawModel()
end