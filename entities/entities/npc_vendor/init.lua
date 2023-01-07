--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )

function ENT:Initialize()
	if self.NoBBox then
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
	else
		self:SetSolid( SOLID_BBOX )
		self:PhysicsInit( SOLID_BBOX )
	end

	self:SetMoveType( MOVETYPE_NONE )
	self:DrawShadow( true )
	self:SetUseType( SIMPLE_USE )

end

function ENT:MakeChatBubble()
	self.Bubble = ents.Create( "npc_bubble" )
	self.Bubble:SetPos( self:GetPos() + Vector( 0, 0, 90 ) )
	self.Bubble:Spawn()
end

hook.Add( "KeyPress", "NPCUseKeyPress", function( objPl, key )
	if key == IN_USE then
		local TTable = {}
		TTable.start = objPl:GetShootPos()
		TTable.endpos = TTable.start + objPl:GetAimVector() * 150
		TTable.filter = objPl
		TTable.mask = MASK_OPAQUE_AND_NPCS
		
		local Tr = util.TraceLine( TTable )

		if IsValid( Tr.Entity ) and Tr.Entity:GetClass() == "npc_vendor" and Tr.Entity.NPCID then
			GAMEMODE.NPCUsed( objPl, Tr.Entity.NPCID, Tr.Entity )
			-- 105, 190 funne
			-- 123, 367, 370, 413, 418, 419, 420
			--homeless: 454 - 456
			--Tr.Entity.Seq = Tr.Entity.Seq or 414
			--Tr.Entity.Seq = Tr.Entity.Seq + 1
			local randomanims = {414}
			Tr.Entity.Seq = Tr.Entity.TalkSeq or randomanims[math.random(1,#randomanims)]
			--for k, v in pairs(player.GetAll()) do v:ChatPrint(Tr.Entity.Seq) end
			if not Tr.Entity.NoTalkSequence then
				Tr.Entity:SetSequence(Tr.Entity.Seq)
				timer.Simple(Tr.Entity:SequenceDuration()-0.3, function() Tr.Entity:SetSequence( Tr.Entity.Sequence or 1 ) end)
			end
		end
	end
end )

function ENT:Think()
	local near = ents.FindInSphere( self:GetPos(), 500 )
	local nearest, nearestdis = nil, 1/0
	for k, v in pairs(near) do
		if v:IsPlayer() then
			local dis = v:GetPos():DistToSqr(self:GetPos())
			if nearestdis > dis then
				nearestdis = dis
				nearest = v
			end
		end
	end
	if IsValid(nearest) then
		self:SetEyeTarget(nearest:EyePos())
	end
	if self.ToolTipMessage then
		local near = ents.FindInSphere( self:GetPos(), 120 )
		for k, v in pairs(near) do
			if v:IsPlayer() then
				if v:GetEyeTrace().Entity == self then
					v:SendToolTip(self.ToolTipMessage,2)
				end
			end
		end
	end
end