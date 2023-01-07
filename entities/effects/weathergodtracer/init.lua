--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

EFFECT.Mat = Material( "effects/tool_tracer" )

function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()
	
	self.Alpha = 255
end

function EFFECT:Think()
	self.Alpha = self.Alpha - FrameTime() * 128
	
	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	if self.Alpha < 0 then return false end
	return true
end

function EFFECT:Render()
	if self.Alpha < 1 then return end

	self.Length = ( self.StartPos - self.EndPos ):Length()
		
	render.SetMaterial( self.Mat )
	local texcoord = math.Rand( 0, 1 )

	for i = 1, 6 do
		render.DrawBeam( self.StartPos, 					-- Start
					 self.EndPos,							-- End
					 80,									-- Width
					 texcoord,								-- Start tex coord
					 texcoord + self.Length / 128,			-- End tex coord
					 Color( 255, 255, 255, self.Alpha ) )	-- Color (optional)
	end
end

function EFFECT:Render() return end