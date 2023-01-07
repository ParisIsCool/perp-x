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

NPC.Name = "Realtor"
NPC.ID = 3

NPC.Model = Model( "models/humans/Group01/female_01.mdl" )

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-1067,2812,-103),ang=Angle(0,-90,0)},
}

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

--Before Robbery Update
function NPC.OnTalk()
	GAMEMODE.MakeRealtorScreen()
end

local weps = {"ak47", "deagle", "fiveseven", "glock", "shotgun", "uzi", "para", "m4a1", "mp5", "dual","mac10", "p90", "p228"}

function NPC.OnTalk()
	local bFound = false
	for k, v in pairs( weps ) do
		if LocalPlayer():GetActiveWeapon():GetClass():find( v ) then
			bFound = true
		end
	end

	if bFound then
		if LocalPlayer():Team() == TEAM_CITIZEN then
			GAMEMODE.DialogPanel:SetDialog("What the fuck, why are you pointing a gun at me!?!?" )

			GAMEMODE.DialogPanel:AddDialog( "HANDS UP! THIS IS A ROBBERY! GIVE ME ALL YOUR MONEY!", function()
				RunConsoleCommand( "vg_robrealtor" )
				LocalPlayer():ConCommand( "say /y HANDS UP! THIS IS A ROBBERY! GIVE ME ALL YOUR MONEY!" )
			end)
			GAMEMODE.DialogPanel:AddDialog( "Haha.. I just wanted to show you my gun. Cool eh?", LEAVE_DIALOG )

			GAMEMODE.DialogPanel:Show()
		else
			GAMEMODE.DialogPanel:SetDialog( "Why are you pointing a gun at me? I don't think your boss is gonna like this.." )

			GAMEMODE.DialogPanel:AddDialog( "Sorry, I just wanted to make sure it's still shiny.", LEAVE_DIALOG )

			GAMEMODE.DialogPanel:Show()

		end
	else
		GAMEMODE.MakeRealtorScreen()
	end
end

function NPC.RealtorGiveMoney()
	GAMEMODE.DialogPanel:SetDialog( "Woa woa p-please don't kill me, um p-putting it in the bag.. p-p-please don't kill me!" )

	GAMEMODE.DialogPanel:AddDialog( "Ya better be glad you're alive!", LEAVE_DIALOG )
	GAMEMODE.DialogPanel:AddDialog( "I cook you for my dinner tomorrow!", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end
net.Receive( "venom_derp_realtor_givemoney", NPC.RealtorGiveMoney )

function NPC.RealtorNoMoney()
	GAMEMODE.DialogPanel:SetDialog( "Woa woa p-please don't kill me, I'm sorry, but someone else already robbed us recently! We have no money. P-p-please don't kill me!" )

	GAMEMODE.DialogPanel:AddDialog( "Oh.. OK I was just kidding anyways..", LEAVE_DIALOG )

	GAMEMODE.DialogPanel:Show()
end
net.Receive( "venom_derp_realtor_nomoney", NPC.RealtorNoMoney )

GAMEMODE:LoadNPC( NPC )

if SERVER then
	function RealtorRobberyTimerUpdate()
		SetGlobalInt( "perp_realtor_money", math.Clamp( GetGlobalInt( "perp_realtor_money" ) + 60, 1, 7200 ) )
	end
	timer.Create( "perp_realtor_money", 30, 0, RealtorRobberyTimerUpdate )

	local function Alarm( objNPC, time ) 
		if objNPC.AlarmSound then return end

		objNPC.AlarmSound = CreateSound( objNPC, "ambient/alarms/alarm1.wav" )
		objNPC.AlarmSound:Play()

		timer.Simple( time, function()
			if objNPC.AlarmSound then
				objNPC.AlarmSound:Stop()
				objNPC.AlarmSound = nil
			end
		end )
	end
	
	local isBeingRobbed = false
	util.AddNetworkString( "venom_derp_realtor_givemoney" )
	util.AddNetworkString( "venom_derp_realtor_nomoney" )
	local function RealtorRob( objPl, _, tblArgs )
		if objPl:Team() != TEAM_CITIZEN then return end
		if isBeingRobbed then
			net.Start( "venom_derp_realtor_nomoney" )
			net.Send( objPl )
			objPl:Notify( "[Bank Robbery Master] This Bank is already being robbed, get the fuck out!" )
			return 
		end
		
 		if ( #team.GetPlayers( TEAM_POLICE ) + #team.GetPlayers( TEAM_SWAT ) + #team.GetPlayers( TEAM_CHIEF ) + #team.GetPlayers( TEAM_FBI ) + #team.GetPlayers( TEAM_DETECTIVE ) ) < 2 then
			net.Start( "venom_derp_realtor_nomoney" )
			net.Send( objPl )
			objPl:Notify( "[Bank Robbery Master] Not enough cops on for you to rob the Bank." ) 
			return
		end

		local objNPC
		for k, v in pairs( ents.FindByClass( "npc_vendor" ) ) do
			if v.NPCID == 3 then
				objNPC = v
			end
		end
		
		if objNPC:GetPos():Distance( objPl:GetPos() ) > 1000 then 
			objPl:CaughtCheating( "Trying to rob the bank, while not being near the Bank." )
			return 
		end
		
		local bFound = false
		for k, v in pairs( weps ) do
			if IsValid( objPl:GetActiveWeapon() ) and objPl:GetActiveWeapon():GetClass():find( v ) then
				bFound = true
			end
		end

		if not bFound then return end
		
		local randomTime = math.random( 180, 300 ) //orig
		
		print("-------------------------")
		print("Bank robbery will take:")
		print(randomTime)
		print("-------------------------")

		if GetGlobalInt( "perp_realtor_money" ) >= 7200 then
			net.Start( "venom_derp_realtor_givemoney" )
			net.Send( objPl )

			Alarm( objNPC, randomTime )

			for k, v in pairs( team.GetPlayers( TEAM_POLICE ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for robbing the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_SWAT ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for robbing the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_CHIEF ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for robbing the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_FBI ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for robbing the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_DETECTIVE ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for robbing the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end

			objPl:SetVar( "venom_bank_robbery", true )

			objPl:Notify( "You've been warranted for robbing the Bank." )
			objPl:SetGNWVar( "warrented", true )
			objPl:Notify( "[Bank Robbery Master] Gotta stick it out for a few minutes, so we can get all the cash!" )
			objPl:Notify( "[Bank Robbery Master] Leaving the bank will cancel the robbery!" )
			
			for k, v in pairs( player.GetHumans() ) do
				if v:IsAdmin() then
					v:PrintMessage( HUD_PRINTCONSOLE, "[BANK ROBBERY] " .. objPl:Nick() .. " has began to rob the bank." )
				end
			end
			
			isBeingRobbed = true

			timer.Create( "VENOM_BankRobbery", randomTime, 1, function()
				local i = math.random( 10000, 50000 )

				timer.Remove( "VENOM_CheckBankRobbers" )
				
				objPl:GiveCashBankRobbery( i, false )
				objPl:Notify( "[Bank Robbery Master] You received $" .. i .. " from the Bank Robbery!" )
				objPl:Notify( "[Bank Robbery Master] It will take nearly an hour before the bank can be robbed again." )
				objPl:SetVar( "venom_bank_robbery", false )
				isBeingRobbed = false
				
				SetGlobalInt( "perp_realtor_money", 0 )
				
				if objNPC.AlarmSound then
					objNPC.AlarmSound:Stop()
					objNPC.AlarmSound = nil
				end
			end )
			
			timer.Create( "VENOM_CheckBankRobbers", 1, randomTime, function()
				local StillRobbingBank = false
				local entsBank = ents.FindInSphere( objNPC:GetPos(), 800 )
				for k, v in pairs( entsBank ) do
					if v:IsPlayer() and v:IsValid() and v:GetVar( "venom_bank_robbery" ) == true and v == objPl then
						StillRobbingBank = true
					end
				end
		
				if not StillRobbingBank then
					objPl:Notify( "[Bank Robbery Master] The Bank Robbery has failed, you exited too early!" )
					objPl:SetVar( "venom_bank_robbery", false )
					isBeingRobbed = false
					
					SetGlobalInt( "perp_realtor_money", 5400 )
					
					if timer.Exists( "VENOM_BankRobbery" ) then
						timer.Remove( "VENOM_BankRobbery" )
						timer.Remove( "VENOM_CheckBankRobbers" )
					end
				end
			end )
		else
			net.Start( "venom_derp_realtor_nomoney" )
			net.Send( objPl )

			for k, v in pairs( team.GetPlayers( TEAM_POLICE ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for attempting to rob the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_SWAT ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for attempting to rob the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_CHIEF ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for attempting to rob the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_FBI ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for attempting to rob the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( team.GetPlayers( TEAM_DETECTIVE ) ) do
				v:Notify( objPl:GetRPName() .. " has been warrented for attempting to rob the Bank." )
				v:PrintMessage( HUD_PRINTTALK, "[DISPATCH] WARNING, THE BANK IS BEING ROBBED. ALL AVAILABLE UNITS RESPOND." )
			end
			
			for k, v in pairs( player.GetHumans() ) do
				if v:IsAdmin() then
					v:PrintMessage( HUD_PRINTCONSOLE, "[BANK ROBBERY] " .. objPl:Nick() .. " has attempted to rob the bank." )
				end
			end

			objPl:Notify( "You've been warranted for attempting to rob the Bank." )
			objPl:SetGNWVar( "warrented", true )
			objPl:Notify( "[Bank Robbery Master] Theres not enough money to rob the bank! Get outta here quick!" ) //added to alert idiots that they are not actually robbing it...

			Alarm( objNPC, randomTime )
		end
	end
	concommand.Add( "vg_robrealtor", RealtorRob )
	
	local function BankRobberyInformation( ply, text )
		if !ply:IsSuperAdmin() then return end
		local moneyInTheRealtor = GetGlobalInt( "perp_realtor_money" )
		ply:PrintMessage( HUD_PRINTTALK, "[Bank Robbery | Administration Check] The Bank has $" .. moneyInTheRealtor .. " in the bank, it requires $7200 to be robbable." )
	end
	concommand.Add( "perp_bankrobberyinfo", BankRobberyInformation )
	
	local function BankRobberyMakeReady( ply, text )
		if !ply:IsOwner() then return print( "\n\n\n\n\n CHEATER!" .. LocalPlayer() .. "tried setting the bank to $7200! They are not the correct rank to do this!\n\n\n\n\n") end
		SetGlobalInt( "perp_realtor_money", 7200 )
		ply:PrintMessage( HUD_PRINTTALK, "[Bank Robbery | Administration Check] Bank was set to $7200. You can now rob it and get a reward!" )
		local moneyInTheRealtor = GetGlobalInt( "perp_realtor_money" )
		ply:PrintMessage( HUD_PRINTTALK, "[Bank Robbery | Administration Check] The bank now has $" .. moneyInTheRealtor )
	end
	concommand.Add( "perp_setbankready", BankRobberyMakeReady )
	
	local function BankRobberyMakeNotReady( ply, text )
		if !ply:IsOwner() then return print( "\n\n\n\n\n CHEATER!" .. LocalPlayer() .. "tried setting the bank to $7200! They are not the correct rank to do this!\n\n\n\n\n") end
		SetGlobalInt( "perp_realtor_money", 0 )
		ply:PrintMessage( HUD_PRINTTALK, "[Bank Robbery | Administration Check] Bank was set to $0." )
		local moneyInTheRealtor = GetGlobalInt( "perp_realtor_money" )
		ply:PrintMessage( HUD_PRINTTALK, "[Bank Robbery | Administration Check] The bank now has $" .. moneyInTheRealtor )
	end
	concommand.Add( "perp_setbanknotready", BankRobberyMakeNotReady )
end
