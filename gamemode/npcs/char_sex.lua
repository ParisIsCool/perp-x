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

NPC.Name = "Dr. M. Ingebag"
NPC.ID = 10

NPC.Model = Model( "models/humans/Group01/male_04.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(7568,5420,-55),ang=Angle(0,-90,0)},
}


NPC.Location ['rp_florida_v2'] = {Vector( 6962.3676757812, 1154.96875, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.95606881380081, -89.435958862305, 0)}

NPC.Location ['rp_rockford_v1b'] = { Vector(500.031250, -6264.512695, 78.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(6.820020, -1.859877, 0.000000 ) }

--500.03125, -6217.8608398438, 64.03125 ), Angle( 2.3760013580322, -0.71688520908356, 0

NPC.Location ['rp_rockford_v2b'] = { Vector(500.03125, -6217.8608398438, 64.03125) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(2.3760013580322, -0.71688520908356, 0 ) }

NPC.Location['rp_evocity2_v3p'] = Vector(-2691.0522460938, 843.39984130859, 76.031257629395)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, -90, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -9859, 9370, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 0, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( -9859, 9370, 72 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 0, 0 )

NPC.Location['rp_paralake_city_v3'] = Vector( -6431.1328125, 6709.8041992188, 292.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle( 0, -140, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 9223.96875, -456.83981323242, -1742.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -90, 0 ) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog( "Hello. If you're sick of your private parts being what they are, or desire to sing in a different tone, you've come to the right place!" )

		GAMEMODE.DialogPanel:AddDialog( "Can you fix me doc? I want a sex change!", NPC.AreYouSure )
		GAMEMODE.DialogPanel:AddDialog( "Are you suggesting sex change?", NPC.What )
		GAMEMODE.DialogPanel:AddDialog( "I think I should go...", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "What sex are you, exactly?\n\n(You must be a citizen to use this feature.)" )

		GAMEMODE.DialogPanel:AddDialog( "What?", LEAVE_DIALOG )
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.What()
	GAMEMODE.DialogPanel:SetDialog( "Of course! It's all the rage nowadays." )

	GAMEMODE.DialogPanel:AddDialog( "Sounds intriguing... How much will this cost?", NPC.AreYouSure )
	GAMEMODE.DialogPanel:AddDialog( "I think I'll be leaving now...", LEAVE_DIALOG )
end

function NPC.AreYouSure()
	GAMEMODE.DialogPanel:SetDialog( "Well, seeing as the surgery is very intricate and long, we've been forced to up our price. We are now charging $" ..  util.FormatNumber( GAMEMODE.SexChangePrice ) .. " for the whole surgery." )

	if LocalPlayer():GetSex() == SEX_FEMALE then
		GAMEMODE.DialogPanel:AddDialog( "Make me a man!", NPC.LetsGo )
	else
		GAMEMODE.DialogPanel:AddDialog( "Make me a woman!", NPC.LetsGo )
	end

	GAMEMODE.DialogPanel:AddDialog( GAMEMODE.SexChangePrice .. " DOLLARS? ARE YOU CRAZY?", LEAVE_DIALOG )
end

function NPC.LetsGo()
	if LocalPlayer():GetCash() >= GAMEMODE.SexChangePrice then
		if LocalPlayer():GetSex() == SEX_FEMALE then
			GAMEMODE.DialogPanel:SetDialog( "Thanks for the money! Enjoy your new manly parts. You may want to go get a facial, though... No offense, of course." )
		else
			GAMEMODE.DialogPanel:SetDialog( "Thanks for the money! Enjoy your new girly parts. You may want to go get a facial, though... No offense, of course." )
		end

		RunConsoleCommand( "perp_cs" )

		GAMEMODE.DialogPanel:AddDialog( "Thanks, doc!", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "Sorry, but it appears you can't afford the surgery after all. Come back when you've got a little cash to spare!" )

		GAMEMODE.DialogPanel:AddDialog( "If only I had medical insurance...", LEAVE_DIALOG )
	end
end

GAMEMODE:LoadNPC( NPC )
