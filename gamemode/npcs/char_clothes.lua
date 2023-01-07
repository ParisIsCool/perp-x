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

NPC.Name = "Kat's Klothes Kloset"
NPC.ID = 9

NPC.Model = Model( "models/humans/clanof06/male_08.mdl" )
NPC.Skin = 5
NPC.BodyGroups = {
    [1] = 0,
    [2] = 2,
}

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-2180,10540,128),ang=Angle(-1,90,0)},
 }

NPC.Location ['rp_florida_v2'] = {Vector( 10743.201171875, 3611.251953125, 136.03125 )}
NPC.Angles ['rp_florida_v2'] = {Angle( 0.55998921394348, 90.359985351562, 0)}


NPC.Location ['rp_rockford_v1b'] = Vector(2013.968750, 3900.876709, 550.031250)
NPC.Angles ['rp_rockford_v1b'] = Angle(0, -0.700064, 0.000000)

NPC.Location['rp_evocity2_v3p'] = Vector(-2622.7822265625, -2547.2993164063, 76.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, -90, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -4950, -6431, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 88, 0 )

NPC.Location['rp_evocity_v4b1'] = Vector( -4950, -6431, 72 )
NPC.Angles['rp_evocity_v4b1'] = Angle( 0, 88, 0 )
--Vector( -11376.986328125, -12663.96875, 292.03125 ), Angle( -0.73273497819901, -90.595268249512, 0)
--Vector( -11451.288085938, -12663.96875, 292.03125 ), Angle( -0.072735026478767, -90.595268249512, 0)
--Vector( 4111.96875, 12708.676757813, 80.03125 ), Angle( 0.91726046800613, 1.0788419246674, 0)
--Vector( 4111.96875, 12631.126953125, 80.03125 ), Angle( 0.98326051235199, 2.3328418731689, 0)

NPC.Location['rp_paralake_city_v3'] = {
	Vector( -11376.986328125, -12663.96875, 292.03125 ),
	Vector( 4111.96875, 12708.676757813, 80.03125 ),
}

NPC.Angles['rp_paralake_city_v3'] = {
	Angle(0, -90, 0),
	Angle(0, 0, 0),
}

NPC.Location ['rp_rockford_v2b'] = Vector(2013.968750, 3900.876709, 550.031250)
NPC.Angles ['rp_rockford_v2b'] = Angle(4.620007, -0.700064, 0.000000)

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 5785.03125, -1652.517578125, -1868.96875 )}
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, 90, 0 ) }

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog( "Hey! Welcome to my store, what can I help you with?" )

		GAMEMODE.DialogPanel:AddDialog( "I'd like to see your stock, please.", NPC.DoIt )
		GAMEMODE.DialogPanel:AddDialog( "How much are your clothes?", NPC.Cost )
		GAMEMODE.DialogPanel:AddDialog( "I want to color my physgun.", NPC.ColorPhys )
		GAMEMODE.DialogPanel:AddDialog( "Nothing. Thanks anyways, though.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "You look fine in that uniform, why would you want new clothes?\n\n(You must be a citizen to use this feature.)" )

		GAMEMODE.DialogPanel:AddDialog( "I agree.", LEAVE_DIALOG )
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.Cost()
	GAMEMODE.DialogPanel:SetDialog( "To make things easier on everyone, we have managed to change all prices to be the same, right at $" ..  util.FormatNumber( GAMEMODE.ClothesPrice ) .. "." )

	GAMEMODE.DialogPanel:AddDialog( "I'd like to see your stock, please.", NPC.DoIt )
	GAMEMODE.DialogPanel:AddDialog( "That's outrageous!", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end

function NPC.DoIt()
	if LocalPlayer():GetCash() >= GAMEMODE.ClothesPrice then
		LEAVE_DIALOG()
		GAMEMODE.Select_Clothes()
	else
		GAMEMODE.DialogPanel:SetDialog( "Erm... you don't seem like the kind of person who can afford my designer clothes." )

		GAMEMODE.DialogPanel:AddDialog( "Well, that's unfriendly.", LEAVE_DIALOG )
	end
end

function NPC.ColorPhys()
	if ( LocalPlayer():IsGoldVIP() ) then
		if ( LocalPlayer():GetCash() < PHYSGUN_COLORPRICE ) then
			GAMEMODE.DialogPanel:SetDialog( "It costs $" .. PHYSGUN_COLORPRICE .. " to color your physgun. You don't have enough." )
			GAMEMODE.DialogPanel:AddDialog( "Damnit!", LEAVE_DIALOG )
		else
			GAMEMODE.DialogPanel:SetDialog( "Sure! That will cost you: $" .. PHYSGUN_COLORPRICE .. "." )
			GAMEMODE.DialogPanel:AddDialog( "Alright, get on with it!", function()
				LEAVE_DIALOG()
				GAMEMODE.SelectPhysColor()
			end )
			GAMEMODE.DialogPanel:AddDialog( "Nah, changed my mind", LEAVE_DIALOG )
		end
	else
		GAMEMODE.DialogPanel:SetDialog( "This feature is for Gold Members only." )
		GAMEMODE.DialogPanel:AddDialog( "Oh...", LEAVE_DIALOG )
	end
end


GAMEMODE:LoadNPC( NPC )
