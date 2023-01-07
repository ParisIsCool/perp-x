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

NPC.Name = "Road Services Store"
NPC.ID = 299

NPC.Model = Model( "models/humans/Group01/male_03.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.Location[ "rp_florida_v2" ] = {Vector( 1306.8006591797, -2793.7526855469, 136.03125 ),}
NPC.Angles[ "rp_florida_v2" ] = {Angle( 0, 0, 0)}

NPC.Location['rp_evocity2_v3p'] = Vector(-7703.1943359375, 1245.8392333984, 148.03125)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location['rp_evocity_v33x'] = Vector( -7495, -6607, 72 )
NPC.Angles['rp_evocity_v33x'] = Angle( 0, 90, 0 )

NPC.Location ['rp_rockford_v1b'] = Vector( -7219.2280273438, -471.67111206055, 8.0312271118164 )

NPC.Angles ['rp_rockford_v1b'] = Angle( 0, 90, 0 )

NPC.Location ['rp_rockford_v2b'] = Vector( -7219.2280273438, -471.67111206055, 8.0312271118164 )

NPC.Angles ['rp_rockford_v2b'] = Angle( 0, 90, 0 )

NPC.Location[ "rp_chaos_city_v33x_03" ] = Vector( -10251, 15005, -1482 )
NPC.Angles[ "rp_chaos_city_v33x_03" ] = Angle( 0, -180, 0 )

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    {pos=Vector(-3008,4101,-111), ang=Angle(0,180,0)},
}


function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()
  if LocalPlayer():Team() == TEAM_ROADSERVICE then
    GAMEMODE.OpenShop( 8 )
	else
		GAMEMODE.DialogPanel:SetDialog("Can I help you?")

		GAMEMODE.DialogPanel:AddDialog("Not that I know of...", LEAVE_DIALOG)

    GAMEMODE.DialogPanel:Show()
end
end

GAMEMODE:LoadNPC( NPC )
