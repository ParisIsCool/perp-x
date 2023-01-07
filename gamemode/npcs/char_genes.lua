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

NPC.Name = "Genetec"
NPC.ID = 15

NPC.Model = Model( "models/humans/Group01/male_04.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(7619,5420,-55),ang=Angle(0,-90,0)},
}


NPC.Location ['rp_florida_v2'] = {Vector( 6911.7377929688, 1308.0518798828, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( -0.36397188901901, 179.91600036621, 0)}

NPC.Location ['rp_rockford_v1b'] = { Vector(-75.968750, -5860.934570, 68.031250) }
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, 178.560181, 0.000000 ) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-75.968750, -5860.934570, 68.031250) }
NPC.Angles ['rp_rockford_v2b'] = { Angle(4.620021, 178.560181, 0.000000 ) }

NPC.Location['rp_evocity2_v3p'] = Vector(-2601.7006835938, 930.98937988281, 76.031242370605)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = {
	Vector( -9687, 9194, 72 ),
	Vector( -10454, 9542, 72 ),
}

NPC.Angles['rp_evocity_v33x'] = {
	Angle( 0, 90, 0 ),
	Angle( 0, -90, 0 ),
}

NPC.Location['rp_evocity_v4b1'] = {
	Vector( -9687, 9194, 72 ),
	Vector( -10454, 9542, 72 ),
}

NPC.Angles['rp_evocity_v4b1'] = {
	Angle( 0, 90, 0 ),
	Angle( 0, -90, 0 ),
}

NPC.Location['rp_paralake_city_v3'] = Vector( -6429.4716796875, 6541.6606445313, 292.03125 )
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 145, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 8164.412109375, -648.96875, -1742.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -90, 0 ) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "Welcome to GeneTech." )

	GAMEMODE.DialogPanel:AddDialog( "What do you guys do around here?", NPC.What )
	GAMEMODE.DialogPanel:AddDialog( "Bye", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.What()
	GAMEMODE.DialogPanel:SetDialog( "We manipulate your genes to allow you to choose what you'll be adept at. We can also insert specialized genes into your genome to allow you to be skilled in multiple fields." )

	GAMEMODE.DialogPanel:AddDialog( "Sounds expensive. How much are we talking?", NPC.Cost )
	GAMEMODE.DialogPanel:AddDialog( "I doubt I'm rich enough for this.", LEAVE_DIALOG )
end

function NPC.Cost()
	local cost = (((GAMEMODE.MaxGenes - 5) - (GAMEMODE.MaxGenes - LocalPlayer():GetNumGenes())) + 1) * GAMEMODE.NewGenePrice
	if LocalPlayer():IsVIP() then cost = (((GAMEMODE.MaxGenesVIP - 5) - (GAMEMODE.MaxGenesVIP - LocalPlayer():GetNumGenes())) + 1) * GAMEMODE.NewGenePrice end

	GAMEMODE.DialogPanel:SetDialog("Yes, it is quite expensive. This cutting-edge technology will cost you no less than $" ..  util.FormatNumber( GAMEMODE.GeneResetPrice ) .. " dollars to reset your genome, and $" ..  util.FormatNumber( cost ) .. " to insert new genes. Also, every time we insert new genes, it will get more difficult, raising the price.")

	GAMEMODE.DialogPanel:AddDialog("That's nothing! Let me manipulate my genome, please! (Reset your genes)", NPC.Reset)
	GAMEMODE.DialogPanel:AddDialog("That's nothing! Add some new genes to me, please! (Add more gene points)", NPC.Add)
	GAMEMODE.DialogPanel:AddDialog("<Whistle> I think I should leave now.", LEAVE_DIALOG)
end

function NPC.Add()
	local cost = ( ( ( GAMEMODE.MaxGenes - 5 ) - ( GAMEMODE.MaxGenes - LocalPlayer():GetNumGenes() ) ) + 1 ) * GAMEMODE.NewGenePrice
	if LocalPlayer():IsVIP() then cost = ( ( ( GAMEMODE.MaxGenesVIP - 5 ) - ( GAMEMODE.MaxGenesVIP - LocalPlayer():GetNumGenes() ) ) + 1 ) * GAMEMODE.NewGenePrice end

	if cost < 0 then -- LOL, no.
		GAMEMODE.DialogPanel:SetDialog( "Yeh, no." )
		GAMEMODE.DialogPanel:AddDialog( ":(", LEAVE_DIALOG )
		return
	end

	if LocalPlayer():GetBank() >= cost then
		if LocalPlayer():GetNumGenes() < GAMEMODE.MaxGenes or LocalPlayer():IsVIP() and LocalPlayer():GetNumGenes() < GAMEMODE.MaxGenesVIP then
			GAMEMODE.DialogPanel:SetDialog( "<5 Hours Later> There you go, sir. Enjoy your new mastery of any field desirable." )

			net.Start( "perp_s_b" ) net.SendToServer()

			GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )
		else
			GAMEMODE.DialogPanel:SetDialog( "Ahh, it appears our technicians cannot add any more genes, as we've already stuffed your genome to it's maximum. Sorry." )

			GAMEMODE.DialogPanel:AddDialog( "That's lame.", LEAVE_DIALOG )
		end
	else
		GAMEMODE.DialogPanel:SetDialog( "What do you mean that's nothing? You don't even have that much in your bank!\n\n(You can only pay for this out of your bank account.)" )

		GAMEMODE.DialogPanel:AddDialog( "Dang, you caught me.", LEAVE_DIALOG )
	end
end

function NPC.Reset()
	if LocalPlayer():GetBank() >= GAMEMODE.GeneResetPrice then
		GAMEMODE.DialogPanel:SetDialog( "<5 Hours Later> There you go, sir. Should be ready for you to choose your adeptness." )

		net.Start( "perp_s_r" ) net.SendToServer()

		GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "What do you mean that's nothing? You don't even have that much!\n\n(You can only pay for this out of your bank account.)" )

		GAMEMODE.DialogPanel:AddDialog( "Dang, you caught me.", LEAVE_DIALOG )
	end
end

GAMEMODE:LoadNPC( NPC )
