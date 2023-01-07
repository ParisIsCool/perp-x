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

local matLight = Material( "sprites/light_ignorez" )
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Initialize()
	if not self:GetParent() or not IsValid( self:GetParent() ) then return end
	self:SetNotSolid( true )
	self:DrawShadow( false )
	/*
	local vT = lookForVT( self:GetParent(), LocalPlayer() )
	self.vehicleTable = vT

	if not self.vehicleTable then return end
	
	if self.vehicleTable.SirenNoise then
		self.sirenNoise = CreateSound( self:GetParent(), self.vehicleTable.SirenNoise )
		self.sirenNoise_Duration = ( self.vehicleTable.SirenNoise_DurMod ) * .98
	end
	
	if self.vehicleTable.SirenNoise_Alt then
		self.sirenNoise_Alt = CreateSound( self:GetParent(), self.vehicleTable.SirenNoise_Alt )
		self.sirenNoise_Alt_Duration = ( self.vehicleTable.SirenNoise_Alt_DurMod ) * .98
	end
	
	if self.vehicleTable.SirenNoiseQ then
		self.sirenNoise_Q = CreateSound( self:GetParent(), self.vehicleTable.SirenNoiseQ )
		self.sirenNoise_Q_Duration = ( self.vehicleTable.SirenNoiseQ_DurMod ) * .98
	end
	*/
end

function ENT:Draw() 
--
--hook.Add("PostDrawTranslucentRenderables", "SirenPol", function()
	self.lastDraw = CurTime() + 0.05

	self:DrawTranslucent()
--end)
end

function ENT:Think()
	if not self:GetParent() or not IsValid( self:GetParent() ) then return end
	if not self.lastDraw or self.lastDraw < CurTime() then
		self:DrawTranslucent()
	end
end

function ENT:DrawTranslucent()
	if not self:GetParent() or not IsValid( self:GetParent() ) then return end

	if not self.vehicleTable then self.vehicleTable = lookForVT( self:GetParent() ) end
	if not self.vehicleTable or not self.vehicleTable.SirenNoise then return end
	/*
	if self:GetParent():GetNWBool( "Siren" ) then -- siren
		if self.vehicleTable.SirenColors then
			if self.vehicleTable.SirenColors.FTRed1 then
				if self:GetParent():GetNWBool( "Siren Loud" ) then -- siren loud
					if self.sirenNoise and ( not self.LastSirenPlay or self.LastSirenPlay <= CurTime() ) then
						self.LastSirenPlay = CurTime() + ( self.sirenNoise_Duration or 0 )
						self.sirenNoise:Stop()
						self.sirenNoise:Play()
					end
					
					if self.sirenNoise_Q and ( not self.LastSirenPlayQ or self.LastSirenPlayQ <= CurTime() ) then
						self.LastSirenPlayQ = CurTime() + ( self.sirenNoise_Q_Duration or 0 )
						self.sirenNoise_Q:Stop()
						self.sirenNoise_Q:Play()
					end
					
					if self.sirenNoise_Alt and ( not self.LastSirenPlay_Alt or self.LastSirenPlay_Alt <= CurTime() ) then
						self.LastSirenPlay_Alt = CurTime() + ( self.sirenNoise_Alt_Duration or 0 )
						self.sirenNoise_Alt:Stop()
						self.sirenNoise_Alt:Play()
					end
				else
					if self.sirenNoise_Alt and self.LastSirenPlay_Alt then
						self.sirenNoise_Alt:Stop()
						self.LastSirenPlay_Alt = nil
					end
					
					if self.sirenNoise and ( not self.LastSirenPlay or self.LastSirenPlay <= CurTime() ) then
						self.LastSirenPlay = CurTime() + ( self.sirenNoise_Duration or 0 )
						self.sirenNoise:Stop()
						self.sirenNoise:Play()
					end
					
					if self.sirenNoise_Q and ( not self.LastSirenPlayQ or self.LastSirenPlayQ <= CurTime() ) then
						self.LastSirenPlayQ = CurTime() + ( self.sirenNoise_Q_Duration or 0 )
						self.sirenNoise_Q:Stop()
						self.sirenNoise_Q:Play()
					end
				end
			elseif self.vehicleTable.SirenColors.Blue then
				if self:GetParent():GetNWBool( "Siren Loud" ) then -- siren loud
					if self.sirenNoise and self.LastSirenPlay then
						self.sirenNoise:Stop()
						self.LastSirenPlay = nil
					end
					
					if self.sirenNoise_Alt and ( not self.LastSirenPlay_Alt or self.LastSirenPlay_Alt <= CurTime() ) then
						self.LastSirenPlay_Alt = CurTime() + ( self.sirenNoise_Alt_Duration or 0 )
						self.sirenNoise_Alt:Stop()
						self.sirenNoise_Alt:Play()
					end
				else
					if self.sirenNoise_Alt and self.LastSirenPlay_Alt then
						self.sirenNoise_Alt:Stop()
						self.LastSirenPlay_Alt = nil
					end
					
					if self.sirenNoise and ( not self.LastSirenPlay or self.LastSirenPlay <= CurTime() ) then
						self.LastSirenPlay = CurTime() + ( self.sirenNoise_Duration or 0 )
						self.sirenNoise:Stop()
						self.sirenNoise:Play()
					end
				end
			else
				if self:GetParent():GetNWBool( "Siren Loud" ) then -- siren loud
					if self.sirenNoise and self.LastSirenPlay then
						self.sirenNoise:Stop()
						self.LastSirenPlay = nil
					end
					
					if self.sirenNoise_Alt and ( not self.LastSirenPlay_Alt or self.LastSirenPlay_Alt <= CurTime() ) then
						self.LastSirenPlay_Alt = CurTime() + ( self.sirenNoise_Alt_Duration or 0 )
						self.sirenNoise_Alt:Stop()
						self.sirenNoise_Alt:Play()
					end
				else
					if self.sirenNoise_Alt and self.LastSirenPlay_Alt then
						self.sirenNoise_Alt:Stop()
						self.LastSirenPlay_Alt = nil
					end
					
					if self.sirenNoise and ( not self.LastSirenPlay or self.LastSirenPlay <= CurTime() ) then
						self.LastSirenPlay = CurTime() + ( self.sirenNoise_Duration or 0 )
						self.sirenNoise:Stop()
						self.sirenNoise:Play()
					end
				end
			end
		else
			if self:GetParent():GetNWBool( "Siren Loud" ) then -- siren loud
				if self.sirenNoise and self.LastSirenPlay then
					self.sirenNoise:Stop()
					self.LastSirenPlay = nil
				end
				
				if self.sirenNoise_Alt and ( not self.LastSirenPlay_Alt or self.LastSirenPlay_Alt <= CurTime() ) then
					self.LastSirenPlay_Alt = CurTime() + ( self.sirenNoise_Alt_Duration or 0 )
					self.sirenNoise_Alt:Stop()
					self.sirenNoise_Alt:Play()
				end
			else
				if self.sirenNoise_Alt and self.LastSirenPlay_Alt then
					self.sirenNoise_Alt:Stop()
					self.LastSirenPlay_Alt = nil
				end
				
				if self.sirenNoise and ( not self.LastSirenPlay or self.LastSirenPlay <= CurTime() ) then
					self.LastSirenPlay = CurTime() + ( self.sirenNoise_Duration or 0 )
					self.sirenNoise:Stop()
					self.sirenNoise:Play()
				end
			end
		end
	elseif self.LastSirenPlayQ and self.sirenNoise_Q then
		self.sirenNoise_Q:Stop()
		self.LastSirenPlayQ = nil
	elseif self.LastSirenPlay and self.sirenNoise then
		self.sirenNoise:Stop()
		self.LastSirenPlay = nil
	elseif self.LastSirenPlay_Alt and self.sirenNoise_Alt then
		self.sirenNoise_Alt:Stop()
		self.LastSirenPlay_Alt = nil
	end
	*/
end
