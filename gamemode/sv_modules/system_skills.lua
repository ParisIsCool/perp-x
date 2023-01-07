--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


/*************************************************
	"perp_gu"
	Job: Set genes
*************************************************/
util.AddNetworkString("perp_gu")
net.Receive( "perp_gu", function( len, Player )
	local skillID = net.ReadInt(16) or 0

	local Genes = Player:GetPNWVar( "Genes" )

	if skillID < 13 or skillID > 17 then return Player:CaughtCheating( "Trying to set Gene ID #" .. skillID .. " which is invalid.", EXPLOIT_THREAT ) end
	if Genes.FreeGenes == 0 then return Player:CaughtCheating( "Trying to set Genes ID: #" .. skillID .. " when having 0 genes left.", EXPLOIT_POSSIBLETHREAT ) end
	if Player:GetSkillLevel( skillID ) >= 5 then return Player:CaughtCheating( "Trying to set Gene ID #" .. skillID .. " over the limit.", EXPLOIT_POSSIBLETHREAT ) end
	
	local geneID = GAMEMODE.GetRealGeneID( skillID )
	if not geneID then return end
	Genes.Genes[geneID] = Genes.Genes[geneID] + 1
	Genes.FreeGenes = Genes.FreeGenes - 1
	Player:SetPNWVar( "Genes", Genes )
end )

/*************************************************
	"perp_s_r"
	Job: Reset Genes
*************************************************/
util.AddNetworkString("perp_s_r")
net.Receive( "perp_s_r", function( len, Player )
	if not Player:NearNPC( 15 ) then return Player:CaughtCheating( "Trying to reset their Genes without being near the NPC.", EXPLOIT_POSSIBLETHREAT ) end

	if GAMEMODE.GeneResetPrice > Player:GetBank() then return end

	local Genes = Player:GetPNWVar( "Genes" )

	if Player:GetNumGenes() < 5 or Player:GetNumGenes() > GAMEMODE.MaxGenesVIP then
		Genes.FreeGenes = 5
	else
		Genes.FreeGenes = Player:GetNumGenes()
	end

	Genes.Genes={[1]=0,[2]=2,[3]=0,[4]=0,[5]=0}

	Player:SetPNWVar( "Genes", Genes )

	local Log = Format( "%s reset their genes for $%s", Player:Nick(), util.FormatNumber( GAMEMODE.GeneResetPrice ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeBank( GAMEMODE.GeneResetPrice, true )

	Player:Notify( "You've reset your genes for $" .. util.FormatNumber( GAMEMODE.GeneResetPrice ) )
end )

/*************************************************
	"perp_s_b"
	Job: Buy Genes
*************************************************/
util.AddNetworkString("perp_s_b")
net.Receive( "perp_s_b", function( len, Player )
	if not Player:NearNPC( 15 ) then return Player:CaughtCheating( "Trying to buy Genes without being near the NPC.", EXPLOIT_POSSIBLETHREAT ) end

	-- Must clamp values :/
	local Genes = math.Clamp( Player:GetNumGenes(), 5, GAMEMODE.MaxGenesVIP )
	if not Player:IsVIP() and Genes >= GAMEMODE.MaxGenes then return Player:CaughtCheating( "Trying to buy more Genes then limit.", EXPLOIT_POSSIBLETHREAT ) end
	if Genes >= GAMEMODE.MaxGenesVIP then return Player:CaughtCheating( "Trying to buy more Genes then limit.", EXPLOIT_POSSIBLETHREAT ) end
	
	local cost = ( ( ( GAMEMODE.MaxGenes - 5 ) - ( GAMEMODE.MaxGenes - Genes ) ) + 1 ) * GAMEMODE.NewGenePrice
	if Player:IsVIP() then cost = ( ( ( GAMEMODE.MaxGenesVIP - 5 ) - ( GAMEMODE.MaxGenesVIP - Genes ) ) + 1 ) * GAMEMODE.NewGenePrice end
	
	if cost > Player:GetBank() then return end

	local Log = Format( "%s bought a gene for $%s", Player:Nick(), util.FormatNumber( cost ) )
	GAMEMODE:Log( "cashlog", Log, Player:SteamID() )

	Player:TakeBank( cost, true )
	
	local Genes = Player:GetPNWVar( "Genes" )
	Genes.FreeGenes = Genes.FreeGenes + 1
	Player:SetPNWVar( "Genes", Genes )

	Player:Notify( "You've bought an extra gene for $" .. util.FormatNumber( cost ) )
end )

function PLAYER:AchievedLevel( skillID, newLevel )
	-- Unlock Five-Seven
	if skillID == SKILL_PISTOL_MARK and newLevel >= 3 then
		self:UnlockMixture( 11 )
	end
	
	-- Unlock Desert Deagle
	if skillID == SKILL_PISTOL_MARK and newLevel >= 4 then
		self:UnlockMixture( 12 )
	end
	
	-- Unlock Shotgun
	if skillID == SKILL_PISTOL_MARK and newLevel >= 6 then
		self:UnlockMixture( 9 )
	end
	
	-- Unlock Uzi
	if skillID == SKILL_SHOTGUN_MARK and newLevel >= 4 then
		self:UnlockMixture( 8 )
	end
	
	-- Unlock mp5
	if skillID == SKILL_RIFLE_MARK and newLevel >= 5 then
		self:UnlockMixture( 88 )
	end
	
	-- Unlock AK47
	if skillID == SKILL_SMG_MARK and newLevel >= 4 then
		self:UnlockMixture( 4 )
	end
	
	-- Unlock M4A1
	if skillID == SKILL_RIFLE_MARK and newLevel >= 6 then
		self:UnlockMixture( 55 )
	end
	
	-- Unlock FN P90
	if skillID == SKILL_SMG_MARK and newLevel >= 6 then
		self:UnlockMixture( 70 )
	end
end