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

NPC.Name = "Bank Security"
NPC.ID = 1200

NPC.Model = Model("models/player/guard_pack/guard_09.mdl")

NPC.Location, NPC.Angles = {}, {} -- Legacy garbage bullshit
NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
    { pos=Vector(-732,2277,-103),ang=Angle(-2,121,0) },
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

function NPC.OnTalk()

	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Welcome to the Bank of Union City!\n\nHow can I help you?")

		GAMEMODE.DialogPanel:AddDialog("I'd like to become a bank security officer.", NPC.HireSecurity)
        GAMEMODE.DialogPanel:AddDialog("I'm going to rob the bank.", function() 
            GAMEMODE.DialogPanel:SetDialog("Yeah, okay pal. There's no way you're getting into the vault.")
            GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
        end )

		GAMEMODE.DialogPanel:AddDialog("I don't want to talk right now.", LEAVE_DIALOG)

    elseif LocalPlayer():Team() == TEAM_BANK_SECURITY then
        GAMEMODE.DialogPanel:SetDialog("Welcome back, officer - how can I help?")

        GAMEMODE.DialogPanel:AddDialog("I need more ammo!", function() 
            LEAVE_DIALOG()
            GAMEMODE:RequestJobAmmo()
        end)

        GAMEMODE.DialogPanel:AddDialog("I'm here to quit, actually.", function() 
        	LEAVE_DIALOG()

	        GAMEMODE:RequestJobLeave()
        end)
        GAMEMODE.DialogPanel:AddDialog("I just wanted to say thank you for the opportunity, sir.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hello, sir.")

		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.HireSecurity()

    -- Remove 'true' once we create job / team file.
	if ( GAMEMODE:IsTeamFull( TEAM_BANK_SECURITY ) ) then
		GAMEMODE.DialogPanel:SetDialog("Our team is currently full. Come back when there are more openings.\n\n(This class is full. Try again later.)")

        GAMEMODE.DialogPanel:AddDialog("Whatever.", LEAVE_DIALOG)
        GAMEMODE.DialogPanel:AddDialog("A shame really, I'm the best you'll find.", LEAVE_DIALOG)
        GAMEMODE.DialogPanel:AddDialog("Alright, thanks.", LEAVE_DIALOG)
	elseif LocalPlayer():IsWarrented() then
		GAMEMODE.DialogPanel:SetDialog("You're a wanted criminal - how can we trust you to protect money? (You have a warrant you must get rid of it before becoming bank security.)")

		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG)
	elseif LocalPlayer():HasBlacklist( "job", TEAM_BANK_SECURITY ) then
		GAMEMODE.DialogPanel:SetDialog( "I don't think I can trust you after what happened last time\n" .. Blacklist.Reason .. ( Blacklist.Expire == 0 and "\n(You are permanently blacklisted from this occupation.)" or "\n(You are currently blacklisted from this occupation. Expires on " .. ( GAMEMODE.Options_EuroStuff:GetBool() and os.date( "%B %d, 20%y at %H:%M", Blacklist.Expire ) or os.date( "%B %d, 20%y at %I:%M %p", Blacklist.Expire ) ) ) )

		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)

	elseif (LocalPlayer():GetTimePlayed() < JOB_DATABASE[TEAM_BANK_SECURITY].RequiredTime * 60 * 60 and !LocalPlayer():IsVIP()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. JOB_DATABASE[TEAM_BANK_SECURITY].RequiredTime .. " hours of play time or VIP to be a security officer.)")

		GAMEMODE.DialogPanel:AddDialog("Understandable.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be security officers. Legal mumbo-jumbo.")

		GAMEMODE.DialogPanel:AddDialog("Understandable.", LEAVE_DIALOG)
	elseif LocalPlayer():HasVehicleOut() then
		GAMEMODE.DialogPanel:SetDialog( "You need to put your vehicle into your garage before you can become a security officer." )

		GAMEMODE.DialogPanel:AddDialog( "Alright, I'll be back.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the team! Here's your uniform, weapons, and all that good stuff.")

		GAMEMODE:RequestJobJoin(TEAM_BANK_SECURITY)

		GAMEMODE.DialogPanel:AddDialog("<Continue>", function() 
            GAMEMODE.DialogPanel:SetDialog("Make sure nobody breaks in... we've been having a few issues with that.\n\nKeep an eye on the cameras in the back.")

            GAMEMODE.DialogPanel:AddDialog("<Continue>", function() 
                GAMEMODE.DialogPanel:SetDialog("Oh, there'll also be a truck with money you need to unload that'll come from time to time. Good Luck!")
                GAMEMODE.DialogPanel:AddDialog( "Uh, okay, thanks.", LEAVE_DIALOG )
            end)
        end)
	end
end


GAMEMODE:LoadNPC(NPC)