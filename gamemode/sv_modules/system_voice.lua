--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function PLAYER:CanHear( Speaking )
	local CanHear, ThreeD
	self.LastCalled = self.LastCalled or {}

	local LastCalled = self.LastCalled[ Speaking ]
	if LastCalled and LastCalled.Last + 0.5 > CurTime() then
		return LastCalled.CanHear, LastCalled.ThreeD
	end

	-- Spectating
	if IsValid( self.Spectating ) and self.Spectating:IsPlayer() and self.Spectating:GetPos():Distance( Speaking:GetPos() ) <= ChatRadius_Local then CanHear = true end

	-- Close Range
	if not CanHear and self:GetPos():Distance( Speaking:GetPos() ) <= ChatRadius_Local then CanHear = true ThreeD = true end

	-- Phone Connection
	if not CanHear and self.Calling and Speaking.Calling and self.Calling == Speaking and self.PickedUp then CanHear = true end

	-- Government Radio
	if not CanHear and self:IsGovernmentOfficial() and Speaking:IsGovernmentOfficial() and Speaking:GetGNWVar( "tradio", false ) and self:GetGNWVar( "tradio", false ) then CanHear = true end

	-- Cop with government radio on in close range
	if not CanHear and Speaking:IsGovernmentOfficial() and Speaking:GetGNWVar( "tradio", false ) then
		for _, v in pairs( player.GetHumans() ) do
			if v:GetPos():Distance( self:GetPos() ) < ChatRadius_Whisper and v:IsGovernmentOfficial() and v:GetGNWVar( "tradio", false ) then
				CanHear = true
				continue
			end
		end
	end

	self.LastCalled[ Speaking ] = { CanHear = CanHear, ThreeD = ThreeD, Last = CurTime() }
	return CanHear, ThreeD
end

function GM:PlayerCanHearPlayersVoice( Listening, Speaking )
	if not IsValid( Listening ) or not IsValid( Speaking ) then return end
	if Listening == Speaking then return end
	if not Speaking:Alive() then return end

	return Listening:CanHear( Speaking )
end

concommand.Add( "perp_tr", function( Player, Command, Args )
	if not IsValid( Player ) then return end
	if not Player:IsGovernmentOfficial() then return end
	
	if Player:GetGNWVar( "tradio", false ) then
		Player:SetGNWVar( "tradio", nil )
	else
		Player:SetGNWVar( "tradio", true )
	end
end )