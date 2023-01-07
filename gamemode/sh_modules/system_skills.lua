--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

SKILLS_DATABASE = {}
SKILL_STAMINA = 1			SKILLS_DATABASE[1] = { SKILL_STAMINA, "Stamina" }
SKILL_CRAFTING = 2			SKILLS_DATABASE[2] = { SKILL_CRAFTING, "Crafting" }
SKILL_SWIMMING = 3			SKILLS_DATABASE[3] = { SKILL_SWIMMING, "Swimming" }
SKILL_DRIVING = 4			SKILLS_DATABASE[4] = { SKILL_DRIVING, "Driving" }									
SKILL_FIRST_AID = 5			SKILLS_DATABASE[5] = { SKILL_FIRST_AID, "First Aid" }								
SKILL_HARDINESS = 6			SKILLS_DATABASE[6] = { SKILL_HARDINESS, "Hardiness" }
SKILL_LOCK_PICKING = 7		SKILLS_DATABASE[7] = { SKILL_LOCK_PICKING, "Lock Picking" }							
SKILL_UNARMED_COMBAT = 8	SKILLS_DATABASE[8] = { SKILL_UNARMED_COMBAT, "Unarmed Combat" }						
SKILL_PISTOL_MARK = 9		SKILLS_DATABASE[9] = { SKILL_PISTOL_MARK, "Pistol Marksmanship" }					
SKILL_SMG_MARK = 10			SKILLS_DATABASE[10] = { SKILL_SMG_MARK, "Sub-Machine Gun Marksmanship" }				
SKILL_SHOTGUN_MARK = 11		SKILLS_DATABASE[11] = { SKILL_SHOTGUN_MARK, "Shotgun Marksmanship" }			
SKILL_RIFLE_MARK = 12		SKILLS_DATABASE[12] = { SKILL_RIFLE_MARK, "Rifle Marksmanship" }
SKILL_WOODWORKING = 18		SKILLS_DATABASE[13] = { SKILL_WOODWORKING, "Wood Working" }
SKILL_HEALING = 19			SKILLS_DATABASE[14] = { SKILL_HEALING, "Healing" }


local GunToSkill = {
	[SKILL_PISTOL_MARK] = {["khr_cz52"]=true, ["khr_cz75"]=true, ["khr_deagle"]=true, ["khr_gsh18"]=true, ["khr_m92fs"]=true, ["khr_makarov"]=true, ["khr_microdeagle"]=true, ["khr_mp443"]=true, ["khr_ots33"]=true, ["khr_p226"]=true, ["khr_p345"]=true, ["khr_ots33"]=true, ["khr_ruby"]=true, ["khr_rugermk3"]=true, ["khr_sr1m"]=true, ["khr_tokarev"]=true, ["cw_shrek_glock18c"]=true, ["cw_glock20"]=true, ["cw_deagle"]=true, ["cw_mr96"]=true, ["cw_fiveseven"]=true, ["cw_m1911"]=true, ["cw_p99"]=true, ["cw_makarov"]=true},
	[SKILL_SMG_MARK] = {["cw_mp5"]=true, ["cw_tr09_mp9"]=true, ["cw_mac11"]=true, ["cw_ump45"]=true, ["cw_mp5_kry"]=true, ["khr_fmg9"]=true,["khr_l2a3"]=true,["khr_mp40"]=true,["khr_mp5a4"]=true,["khr_mp5a5"]=true,["khr_p90"]=true,["khr_vector"]=true,["khr_veresk"]=true},
	[SKILL_SHOTGUN_MARK] = {["cw_m3super90"]=true, ["cw_m3super90_police"]=true, ["khr_m620"]=true,["khr_mp153"]=true,["khr_ns2000"]=true,["khr_toz194"]=true},
	[SKILL_RIFLE_MARK] = {["cw_l115"]=true,["cw_ar15"]=true,["cw_ak74"]=true,["cw_g3a3"]=true,["cw_ak12"]=true,["cw_ak47"]=true,["cw_g36c"]=true,["cw_l85a2"]=true,["cw_m14"]=true,["cw_scarh"]=true,["cw_shorty"]=true,["cw_vss"]=true,["khr_aek971"]=true,["khr_ak103"]=true,["khr_cz858"]=true,["khr_delisle"]=true,["khr_fnfal"]=true,["khr_m1carbine"]=true,["khr_m4a4"]=true,["khr_simsks"]=true,["khr_sks"]=true},
}

--hook.Add("InitPostEntity","SkillsGunsYayWork", function()
	hook.Add( "EntityTakeDamage", "SkillGunsHappyYay", function( target, dmginfo )
		if ( (target:IsPlayer() or (target.IsBot and target:IsBot())) and dmginfo:IsBulletDamage() and IsValid(dmginfo:GetAttacker()) and IsValid(dmginfo:GetAttacker():GetActiveWeapon()) ) then
			local wep = dmginfo:GetAttacker():GetActiveWeapon()
			for k, v in pairs(GunToSkill) do
				if v[wep:GetClass()] then dmginfo:GetAttacker():GiveExperience(k,0.5) return end
			end
		end
	end )
--end)

GENES_DATABASE = {}
GENE_STRENGTH = 13			GENES_DATABASE[1] = { GENE_STRENGTH, "Strength" }
GENE_INTELLIGENCE = 14		GENES_DATABASE[2] = { GENE_INTELLIGENCE, "Intelligence" }
GENE_DEXTERITY = 15			GENES_DATABASE[3] = { GENE_DEXTERITY, "Dexterity" }
GENE_INFLUENCE = 16			GENES_DATABASE[4] = { GENE_INFLUENCE, "Influence" }
GENE_PERCEPTION = 17		GENES_DATABASE[5] = { GENE_PERCEPTION, "Perception" }

SKILL_CRAFTINESS = 2

GM.MaxSkillLevel = 2 ^ 14				
GM.MaxSkillLevel_Level = math.Clamp( math.floor( math.log( GM.MaxSkillLevel ) / math.log( 2 ) ) - 5, 1, 8 )

function GM.GetRealSkillID( SkillID )
	local realID = 0
	
	for k, v in pairs( SKILLS_DATABASE ) do
		if v[1] == SkillID then
			realID = k
		end
	end
	
	if realID == 0 then return end
	
	return realID
end

function PLAYER:GetExperience( SkillID )
	local realID = GAMEMODE.GetRealSkillID( SkillID )
	
	return self:GetPNWVar( "s_" .. realID, 0 )
end

function GM.GetRequiredExperience( Level )
	if Level <= 1 then return 0 end
	
	return 2 ^ ( Level + 5 )
end

function GM.IsSkill( SkillID )
	for _, v in pairs( SKILLS_DATABASE ) do
		if v[1] == SkillID then
			return true
		end
	end
	
	return false
end

function GM.IsGene( s ) return not GM.IsSkill( s ) end

function GM.GetRealGeneID( geneID )
	local realID = 0
	
	for k, v in pairs( GENES_DATABASE ) do
		if v[1] == geneID then
			realID = k
		end
	end
	
	return realID
end

function PLAYER:GetNumGenes()
	local Genes = self:GetPNWVar( "Genes" )
	
	local TotalGenes = 0
	for k, v in pairs(Genes.Genes) do TotalGenes = TotalGenes + v end
	
	return Genes.FreeGenes+TotalGenes
end

function PLAYER:GetSkillLevel( SkillID )
	if GAMEMODE.IsSkill( SkillID ) then
		return math.Clamp( math.floor( math.log( self:GetExperience( SkillID ) ) / math.log( 2 ) ) - 5, 1, GAMEMODE.MaxSkillLevel_Level )
	else
		return math.Clamp( self:GetPNWVar( "Genes" ).Genes[GAMEMODE.GetRealGeneID( SkillID )], 0, 5 )
	end
end	

if SERVER then return end

function GM.UpgradeGene( skillID )
	if LocalPlayer():GetPNWVar( "Genes" ).FreeGenes <= 0 then return end
	if LocalPlayer():GetSkillLevel( skillID ) == 5 then return end
	
	local geneID = GAMEMODE.GetRealGeneID( skillID )

	net.Start( "perp_gu" ) net.WriteInt( skillID, 16 ) net.SendToServer()
end

function GM.GetRealName( SkillID )
	if GAMEMODE.IsSkill( SkillID ) then
		return SKILLS_DATABASE[ GAMEMODE.GetRealSkillID( SkillID ) ][2]
	else
		return GENES_DATABASE[ GAMEMODE.GetRealGeneID( SkillID ) ][2]
	end
end