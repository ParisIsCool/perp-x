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

function ENT:Draw()
	local Owner = self:GetParent()

	if not IsValid( Owner ) or Owner == LocalPlayer() then
		self:DrawShadow( false )
		return false
	end

	if IsValid( Owner ) and Owner:IsAdmin() and ( Owner:GetColor().a < 10 ) then
		return false
	end

	if Owner:Team() == TEAM_SECRET_SERVICE  then
		return false
	end

	local Attachment = Owner:GetAttachment( Owner:LookupAttachment( "chest" ) )
	
	if (!Attachment) then return; end
	
	local Pos = Attachment.Pos
	local Ang = Attachment.Ang

	if not Owner:Crouching() then
		if Owner:GetVelocity():Length() > 20 then
			self:SetPos( Pos + 				Ang:Right() * -5 +
											Ang:Forward() * -5 +
											Ang:Up() * -5 )
		else
			self:SetPos( Pos + 				Ang:Right() * -5 +
											Ang:Forward() * -7 +
											Ang:Up() * -5 )
		end

		self:SetAngles( Ang + Angle( -60, 90, 0 ) )
	elseif Owner:Crouching() then
		local Forward = -4
		local Right = -5
		if Owner:GetVelocity():Length() > 20 then
			Forward = -5
			Right = 4
		end

		self:SetPos( Pos + 				Ang:Right() * Right +
										Ang:Forward() * Forward +
										Ang:Up() * -5 )
		self:SetAngles( Ang + Angle( -90, 40, 60 - Ang.r ) )
	end

	self:SetColor( Owner:GetColor() )
	self:DrawModel()
end

function ENT:Initialize() self:DrawShadow( false ) end
