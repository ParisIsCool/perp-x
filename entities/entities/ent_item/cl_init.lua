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

function ENT:Initialize ()
	self.aps = 5
	self.lastRot = CurTime()
	self.curRot = 0
end

surface.CreateFont( "ShopForSaleText", { font = "coolvetica", size = 80, weight = 500, antialias = true, additive = false } )

function ENT:Draw()

	if (self:GetGNWVar("ForSale", false)) then
		
		self.curRot = self.curRot + (self.aps * (CurTime() - self.lastRot))
		if (self.curRot > 360) then self.curRot = self.curRot - 360 end
		self.lastRot = CurTime()

		local price = self:GetGNWVar("Price", -1)
		local title = self:GetGNWVar("Title", "")
		
		local priceText = "$" .. price
		local priceColor = Color(255, 255, 255, 255)
		if (price < 1) then
			priceText = "Not For Sale"
			priceColor = Color(255, 150, 150, 255)
		elseif (LocalPlayer():GetCash() < price) then
			priceColor = Color(255, 150, 150, 255)
		end

		local min, max = self:GetModelBounds()
		
		cam.Start3D2D(self:LocalToWorld(self:GetNetworkedVector("maxs", Vector(0, 0, 0))) + Vector(0,0,max.z + 30 + (2*math.sin(CurTime()*3))), Angle(180, self.curRot, -90), .1)
                draw.DrawText(title, "ShopForSaleText", 0, -30, Color(255, 255, 255, 255), 1, 1)
                draw.DrawText(priceText, "ShopForSaleText", 0, 20, priceColor, 1, 1)
        cam.End3D2D()
		
		cam.Start3D2D(self:LocalToWorld(self:GetNetworkedVector("maxs", Vector(0, 0, 0))) + Vector(0,0,max.z + 30 + (2*math.sin(CurTime()*3))), Angle(180, self.curRot + 180, -90), .1)
                draw.DrawText(title, "ShopForSaleText", 0, -30, Color(255, 255, 255, 255), 1, 1)
                draw.DrawText(priceText, "ShopForSaleText", 0, 20, priceColor, 1, 1)
        cam.End3D2D()
		
		HALO_ENTITIES_WHITE[self] = nil

	else

		if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
			--self:DrawEntityOutline( 1.1 )
			HALO_ENTITIES_WHITE[self] = self
		else
			HALO_ENTITIES_WHITE[self] = nil
		end

	end

	self:DrawModel()
end

local matOutlineWhite 	= Material( "white_outline" )
local ScaleNormal		= Vector( 1, 1, 1 )
local ScaleOutline1		= ScaleNormal * 1
local ScaleOutline2		= ScaleNormal * 1.1
local matOutlineBlack 	= Material( "black_outline" )

function ENT:DrawEntityOutline( size )
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
		-- First Outline	
		local Mat = Matrix()
		Mat:Scale( ScaleOutline2 * size )
		self:EnableMatrix( "RenderMultiply", Mat )

		render.MaterialOverride( matOutlineBlack )
		self:DrawModel()

		-- Second Outline
		local Mat = Matrix()
		Mat:Scale( ScaleOutline1 * size )
		self:EnableMatrix( "RenderMultiply", Mat )

		render.MaterialOverride( matOutlineWhite )
		self:DrawModel()
		
		-- Revert everything back to how it should be
		render.MaterialOverride( nil )

		local Mat = Matrix()
		Mat:Scale( ScaleNormal )
		self:EnableMatrix( "RenderMultiply", Mat )
		
	render.SuppressEngineLighting( false )
	
	local Colour = self:GetColor()
	render.SetColorModulation( Colour.r / 255, Colour.g / 255, Colour.b / 255 )
end