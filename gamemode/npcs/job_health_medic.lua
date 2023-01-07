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

NPC.Name = "Medic"
NPC.ID = 29

NPC.Model = Model("models/preytech/perp/players/npcs/perp_medic.mdl")
NPC.Invisible = false -- Used for ATM Machines, Casino Tables, etc.

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(7493,5420,-55),ang=Angle(0,-90,0)},
}

NPC.Location ['rp_florida_v2'] = {Vector( 6564.96875, 608.27856445312, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.42802608013153, -0.035921111702919, 0)}

NPC.Location['rp_evocity2_v3p'] = Vector(-2775.548828125, 724.41619873047, 76.031242370605)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, -100, 0)

NPC.Location['rp_evocity_v33x'] = {
	Vector(-3786, -7049, 198),
	Vector(-9603, 9199, 72),
	Vector(-10321, 9542, 72),
}

NPC.Angles['rp_evocity_v33x'] = {
	Angle(0, 180, 0),
	Angle(0, 90, 0),
	Angle(0, -90, 0),
}

NPC.Location['rp_evocity_v4b1'] = {
	Vector(-3786, -7049, 198),
	Vector(-9603, 9199, 72),
	Vector(-10321, 9542, 72),
}

NPC.Angles['rp_evocity_v4b1'] = {
	Angle(0, 180, 0),
	Angle(0, 90, 0),
	Angle(0, -90, 0),
}

NPC.Location ['rp_rockford_v1b'] = { Vector(-75.968750, -5980.748535, 69.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, 178.560135, 0 ) }

NPC.Location ['rp_rockford_v1b'] = { Vector(-75.968750, -5980.748535, 69.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, 178.560135, 0 ) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-75.968750, -5980.748535, 69.031250) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(2.640021, 178.560135, 0 ) }

--Vector( -6784.03125, 6298.896484375, 292.03125 ), Angle( 0.15513274073601, -0.74621593952179, 0)

NPC.Location['rp_paralake_city_v3'] = Vector( -6784.03125, 6298.896484375, 292.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 8074.6372070312, -648.96875, -1742.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -90, 0 ) }

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

-- This is always local player.
function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Hello, I'm a General Practitioner (Medic).\n\nWhat can I do for you?" )

	GAMEMODE.DialogPanel:AddDialog( "I've broken my legs... by falling", NPC.FixLegs )
	GAMEMODE.DialogPanel:AddDialog( "I require some bandages (Heal)", NPC.Heal )
	GAMEMODE.DialogPanel:AddDialog( "I'm fine thanks", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.FixLegs()
	if LocalPlayer():IsGovernmentOfficial() and LocalPlayer().Crippled == true then
		--if LocalPlayer().Crippled == true then
			RunConsoleCommand( "perp_fixlegs" )

			GAMEMODE.DialogPanel:SetDialog( "Ok I'll see what I can do...\n\n(30 minutes later: I've fixed your legs, don't go breaking them again.)\n\nYou're free to go." )

			GAMEMODE.DialogPanel:AddDialog( "Thanks, doc!", LEAVE_DIALOG )

			GAMEMODE.DialogPanel:Show()
		--[[else
			GAMEMODE.DialogPanel:SetDialog( "Doesn't appear that your legs are broken." )
			
			GAMEMODE.DialogPanel:AddDialog( "Oh, ok... ", LEAVE_DIALOG )
			
			GAMEMODE.DialogPanel:Show()
		end]]
	elseif LocalPlayer():GetCash() >= 600 then
		--if LocalPlayer().Crippled == true then
			RunConsoleCommand( "perp_fixlegs" )

			GAMEMODE.DialogPanel:SetDialog( "Ok I'll see what I can do...\n\n(30 minutes later: I've fixed your legs, don't go breaking them again.)\n\nThat'll be $600." )

			GAMEMODE.DialogPanel:AddDialog( "Thanks, doc!", LEAVE_DIALOG )

			GAMEMODE.DialogPanel:Show()
		--[[else
			GAMEMODE.DialogPanel:SetDialog( "Doesn't appear that your legs are broken." )
			
			GAMEMODE.DialogPanel:AddDialog( "Oh, ok... ", LEAVE_DIALOG )
			
			GAMEMODE.DialogPanel:Show()
		end]]--
	else
		GAMEMODE.DialogPanel:SetDialog( "Looks like you can't afford this, try going to an ATM, you need $600." )

		GAMEMODE.DialogPanel:AddDialog( "Oh, ok...", LEAVE_DIALOG )

		GAMEMODE.DialogPanel:Show()
	end
end

function NPC.Heal()
	if LocalPlayer():IsGovernmentOfficial() then
		RunConsoleCommand( "perp_heal" )

		GAMEMODE.DialogPanel:SetDialog( "It looks like you're bleeding...\n\n(30 minutes later: I've patched up your wounds, you should be good as new.)\n\nYou're free to go." )

		GAMEMODE.DialogPanel:AddDialog( "Thanks, doc!", LEAVE_DIALOG )

		GAMEMODE.DialogPanel:Show()
	elseif LocalPlayer():GetCash() >= 300 then
		if LocalPlayer():Health() == 100 then
			GAMEMODE.DialogPanel:SetDialog( "You're fine..." )

			GAMEMODE.DialogPanel:AddDialog( "If you say so.", LEAVE_DIALOG )

			GAMEMODE.DialogPanel:Show()

			return
		end

		RunConsoleCommand( "perp_heal" )

		GAMEMODE.DialogPanel:SetDialog( "It looks like you're bleeding...\n\n(30 minutes later: I've patched up your wounds, you should be good as new.)\n\nThat'll be $300." )

		GAMEMODE.DialogPanel:AddDialog( "Thanks, doc!", LEAVE_DIALOG )

		GAMEMODE.DialogPanel:Show()
	else
		GAMEMODE.DialogPanel:SetDialog( "Looks like you can't afford this, try going to an ATM, you need $300." )

		GAMEMODE.DialogPanel:AddDialog( "Oh, ok...", LEAVE_DIALOG )

		GAMEMODE.DialogPanel:Show()
	end
end

GAMEMODE:LoadNPC( NPC )
