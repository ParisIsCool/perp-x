--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local NPC = {}

NPC.Name = "Katie's Facials"
NPC.ID = 8

NPC.Model = Model( "models/humans/clanof06/male_02.mdl" )
NPC.Skin = 7
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}


NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-2220,10539,128),ang=Angle(0,90,0)},
}


NPC.Location ['rp_florida_v2'] = {Vector( 10846.532226562, 3608.1867675781, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.29584628343582, 90.36009979248, 0)}

NPC.Location ['rp_rockford_v1b'] = Vector(1970.031250, 3901.968750, 550.031250)
NPC.Angles ['rp_rockford_v1b'] = Angle(0, 145.253265, 0.000000)

NPC.Location['rp_evocity2_v3p'] = Vector(-2527.0334472656, -2544.9301757813, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, -90, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -5017, -6431, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 86, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( -5017, -6431, 72 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 86, 0 )

NPC.Location['rp_paralake_city_v3'] = {
	Vector( -11451.288085938, -12663.96875, 292.03125 ),
	Vector( 4111.96875, 12631.126953125, 80.03125 ),
}

NPC.Angles['rp_paralake_city_v3'] = {
	Angle(0, -90, 0),
	Angle(0, 0, 0),
}

NPC.Location ['rp_rockford_v2b'] = Vector(1970.031250, 3901.968750, 550.031250)
NPC.Angles ['rp_rockford_v2b'] = Angle(-3.404596, 145.253265, 0.000000)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 5918.806640625, -1652.0413818359, -1868.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, 90, 0 ) }

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog( "You look like you could use a facial. Have a seat!" )

		GAMEMODE.DialogPanel:AddDialog( "Er... Okay... How much will this cost?", NPC.Cost )
		GAMEMODE.DialogPanel:AddDialog( "What are you trying to say?", NPC.Lolz )
		GAMEMODE.DialogPanel:AddDialog( "No thank you.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "I don't think any ammount of facials can fix that.\n\n(You must be a citizen to use this feature.)" )

		GAMEMODE.DialogPanel:AddDialog( "Oh... Okay...", LEAVE_DIALOG )
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.Lolz()
	GAMEMODE.DialogPanel:SetDialog( "Oh nothing, nothing! So how about it, want a facial?" )

	GAMEMODE.DialogPanel:AddDialog( "How much is this gonna cost me?", NPC.Cost )
	GAMEMODE.DialogPanel:AddDialog( "No thank you.", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.Cost()
	GAMEMODE.DialogPanel:SetDialog( "We'll give you a complete facial for only $" ..  util.FormatNumber( GAMEMODE.FacialPrice ) .. ". Is that a good deal, or what?" )

	GAMEMODE.DialogPanel:AddDialog( "Alright, let's do it!", NPC.DoIt )
	GAMEMODE.DialogPanel:AddDialog( "That seems a little expensive... Nevermind.", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.DoIt()
	if LocalPlayer():GetCash() >= GAMEMODE.FacialPrice then
		LEAVE_DIALOG()
		GAMEMODE.Select_Face()
	else
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but it appears you can't afford my services... Come back when you have a few dollars to spare." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, fine.", LEAVE_DIALOG )
	end
end

GAMEMODE:LoadNPC( NPC )
