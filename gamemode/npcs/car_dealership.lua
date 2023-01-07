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

NPC.Name = "Big Bill Hell's"
NPC.ID = 4

NPC.Model = Model( "models/humans/clanof06/male_06.mdl" )
NPC.Skin = 7
NPC.BodyGroups = {
    [1] = 0,
    [2] = 0,
}

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-7572,1595,-32),ang=Angle(0,-1,0)},
}

NPC.Location ['rp_florida_v2'] = {Vector( -2146.7294921875, 4747.9814453125, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0, 90, 0)}

NPC.Location ['rp_rockford_v1b'] = { Vector(-4167.510742, -678.959534, 14.031250) };
NPC.Angles ['rp_rockford_v1b'] = { Angle(0, -90.580109, 0.000000) };

NPC.Location ['rp_rockford_v2b'] = { Vector(-4167.510742, -678.959534, 14.031250) };
NPC.Angles ['rp_rockford_v2b'] = { Angle(2.639998, -90.580109, 0.000000) };

NPC.Location['rp_evocity2_v3p'] = Vector(1407.6276855469, -2055.3176269531, 240.03126525879)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector( 5002, -3550, 228 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 271, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( 5002, -3550, 228 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 271, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( 5002, -3550, 228 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 271, 0 )

NPC.Location['rp_paralake_city_v3'] = Vector(-9233.6689453125, -10910.18359375, 464.03125)
NPC.Angles['rp_paralake_city_v3'] = Angle(0, -90, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 1818.7543945312, -6152.4291992188, -1868.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, -180, 0 ) }


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog( "Welcome to Big Bill Hell's used car dealership! I'm Big Bill, how can I help you?" )

		GAMEMODE.DialogPanel:AddDialog( "Hey! I'm looking for a new car.", NPC.NewCar )
		GAMEMODE.DialogPanel:AddDialog( "Hello. I'd like to sell a car.", NPC.SellCar )
		GAMEMODE.DialogPanel:AddDialog( "I seemed to lost my car. Have you seen it around?", NPC.LostCar )
		GAMEMODE.DialogPanel:AddDialog( "You can't help me. Nobody can help me.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "I can't help you, you have to be a citizen to talk with me." )

		GAMEMODE.DialogPanel:AddDialog( "Oh, ok...", LEAVE_DIALOG )
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.NewCar()
	GAMEMODE.DialogPanel:SetDialog( "You've come to the right place! Let me show you around." )

	GAMEMODE.DialogPanel:AddDialog( "Alright, show me your stock.", NPC.ShowCars )
	GAMEMODE.DialogPanel:AddDialog( "Do you accept cash payments?", NPC.NoCash )
	GAMEMODE.DialogPanel:AddDialog( "Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG )
end

function NPC.SellCar()
	GAMEMODE.DialogPanel:SetDialog( "That's understandable, well I can assure a price for you." )

	GAMEMODE.DialogPanel:AddDialog( "Alright, tell me what their're worth!", NPC.ShowSellCars )
	GAMEMODE.DialogPanel:AddDialog( "Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG )
end

function NPC.ShowCars()
	GAMEMODE.ShowDealershipView()
	LEAVE_DIALOG()
end

function NPC.ShowSellCars()
	GAMEMODE.ShowSellView()
	LEAVE_DIALOG()
end

function NPC.NoCash()
	GAMEMODE.DialogPanel:SetDialog( "Sorry, we only accept direct bank transactions. Most people don't carry around enough money in their wallets, anyway." )

	GAMEMODE.DialogPanel:AddDialog( "Alright, show me your stock.", NPC.ShowCars )
	GAMEMODE.DialogPanel:AddDialog( "Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG )
end

function NPC.LostCar()
	GAMEMODE.DialogPanel:SetDialog( "I haven't seen it, but have you checked the parking garage?\n\n(You can claim your previously purchased vehicles at the parking garage.)" )

	GAMEMODE.DialogPanel:AddDialog( "Oh yah, I remember now! Thanks!", LEAVE_DIALOG )
end

GAMEMODE:LoadNPC( NPC )
