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

NPC.Name = "ATM Machine"
NPC.ID = 2

NPC.Invisible = false

if game.GetMap() == "rp_southside" then
	NPC.Model = Model( "models/unioncity2/props_unioncity/atm_machine.mdl" )
else
	NPC.Model = Model( "models/props_unique/atm01.mdl" )
end


NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-1950,2665,-103),ang=Angle(0,-90,0)},
	{pos=Vector(-1848,2665,-103),ang=Angle(0,-90,0)},
	{pos=Vector(-1748,2665,-103),ang=Angle(0,-90,0)},
	{pos=Vector(-7640,1753,-31),ang=Angle(0,0,0)},
	{pos=Vector(-1862,10522,128),ang=Angle(0,90,0)},
	{pos=Vector(4176,8420,136),ang=Angle(0,90,0)},
	{pos=Vector(-6177,1435,-23),ang=Angle(0,-90,0)}

}

NPC.Location, NPC.Angles = {}, {}

NPC.Location ['rp_florida_v2'] = {

Vector( 7815.8720703125, -3752.1887207031, 136.03125 ), --Garry's Mall
Vector( -1112.03125, -5380.3159179688, 136.03125 ), --Club / Lounge
Vector( -1112.03125, -6824.2392578125, 136.03125 ), --Theater
Vector( -1112.03125, -6378.1870117188, 136.03125 ), --Theater
Vector( 4783.96875, -140.81451416016, 136.03125 ), --City BP
Vector( 4247.96875, -8414.662109375, 168.03125 ), --Harbor View Hotel
Vector( 10696.03125, 3984.830078125, 136.03125 ), --Clothing Store
Vector( -1828.9901123047, 4692.03125, 136.03125 ), --Car Dealer
Vector( -4215.96875, 8553.048828125, 136.03125 ), --Country BP
Vector( 3104.03125, -6494.4116210938, 136.03125 ), --Bank
Vector( 3104.0986328125, -6421.96484375, 136.03125 ), --Bank
Vector( 4478.8266601562, -6135.96875, 136.03125 ), --Outside Bank
Vector( 4352.1079101562, -6135.9990234375, 136.03125 ), --Outside Bank
Vector( 4219.9936523438, -6135.9990234375, 136.03125 ), --Outside Bank
Vector( 712, -2639, 136.29899597168 ), --McDonalds
Vector( 712, -2873, 136.29899597168 ), --McDonalds


}
NPC.Angles ['rp_florida_v2'] = {

Angle( 0, -90, 0), --Garry's Mall
Angle( 0, 180, 0), --Club / Lounge
Angle( 0, 180, 0), --Theater
Angle( 0, 180, 0), --Theater
Angle( 0, 180, 0), --City BP
Angle( 0, 180, 0), --Harbor View Hotel
Angle( 0, 0, 0), --Clothing Store
Angle( 0, 90, 0), --Car Dealer
Angle( 0, 0, 0), --Country BP
Angle( 0, 0, 0), --Bank
Angle( 0, 0, 0), --Bank
Angle( 0, 90, 0), --Outside Bank
Angle( 0, 90, 0), --Outside Bank
Angle( 0, 90, 0), --Outside Bank
Angle( 0, -90, 0), --McDonalds
Angle( 0, 90, 0), --McDonalds

}

NPC.Location ['rp_rockford_v1b'] =  {

				Vector( -5472, -5440, 64), //city hall
				Vector( -5472, -5536, 64), // cityhall
				Vector( -5472, -5632, 64), //cityhall
				Vector(-2986.7192382813, -3405.1044921875, 33), //bank
				Vector( -2960, -3320, 1), //bank
				Vector( -3008, -3320, 1), //bank
				Vector( 1024, 3680, 544), //shell
				Vector( -928, 5336, 544), //subs711
				Vector( -14656, 2915, 392), //country711
				Vector( -3870.1, -599, 0.8), //Cardealer
}

NPC.Angles ['rp_rockford_v1b'] = {
				Angle(0, 0, 0), --cityhall
				Angle(0, 0, 0), --cityhall
				Angle(0, 0, 0), --cityhall
				Angle(0, 90, 0), -- bank
				Angle(0, 90, 0), -- bank
				Angle(0, 90, 0), -- bank
				Angle(0, 90, 0),-- shell
				Angle(0, 90, 0), --711
				Angle(0, -90, 0), --country subs
				Angle(0, 0, 0),-- cardealer
}

NPC.Location ['rp_rockford_v2b'] =  {

				Vector( -5472, -5440, 64 ),								--Town Hall--
				Vector( -5472, -5536, 64 ), 							--Town Hall--
				Vector( -5472, -5632, 64 ), 							--Town Hall--
				Vector( -2986.7192382813, -3405.1044921875, 33 ), 		--Bank--
				Vector( -2987.4284667969, -3471.4501953125, 33 ), 		--Bank--
				Vector( -3008, -3320, 10 ), 							--Bank--
				Vector( 1024, 3680, 544 ), 								--City Shell--
				Vector( -1061.3933105469, 5336.03125, 576.03125 ), 		--Tavern--
				Vector( -14656, 2915, 392 ), 							--Country Shell--
				Vector( -3870.1, -599, 0.8 ), 							--Car Dealer--
				Vector( -1008, 2200, 544 ), 							--Cinema--
				Vector( -1168, 2200, 544 ), 							--Cinema--
				Vector( -1136, 3864, 544 ), 							--RTA--
				Vector( -1216, 3864, 544 ), 							--RTA--
				Vector( 2170.2060546875, 1771.96875, 544.03125 ), 		--Casino--


}

NPC.Angles ['rp_rockford_v2b'] = {
				Angle( 0, 0, 0 ), 										--Town Hall--
				Angle( 0, 0, 0 ), 										--Town Hall--
				Angle( 0, 0, 0 ),										--Town Hall--
				Angle( 0, 0, 0 ), 										--Bank--
				Angle( 0, 0, 0 ), 										--Bank--
				Angle( 0, 90, 0 ), 										--Bank--
				Angle( 0, 90, 0 ),										--City Shell--
				Angle( 0, 90, 0 ), 										--Tavern--
				Angle( 0, -90, 0 ), 									--Country Shell--
				Angle( 0, -90, 0 ),										--Car Dealer--
				Angle( 0, 90, 0 ), 										--Cinema--
				Angle( 0, 90, 0 ),										--Cinema--
				Angle( 0, 90, 0 ), 										--RTA--
				Angle( 0, 90, 0 ), 										--RTA--
				Angle( 0.46179580688477, -89.961318969727, 0),			--Casino--

}

NPC.Location['rp_evocity2_v3p'] = {
	Vector(185, -1608, 75),
	Vector(7974, 6090, 70),
	Vector(-59.735126495361, 2933, 76),
	Vector(1676.0991210938, -36, 140.03125),
	Vector(-7525.0141601563, 1150.48046875, 148.03125),
	Vector(7717.2314453125, 12800, 72.03125),
}

NPC.Angles['rp_evocity2_v3p'] = {
	Angle(0, -180, 0),
	Angle(0, 0, 0),
	Angle(0, -90, 0),
	Angle(0, 90, 0),
	Angle(0, 90, 0),
	Angle(0, -90, 0),
}

NPC.Location['rp_evocity_v33x'] = {
	Vector( -6915, -9669, 70 ), 	-- nexus
	Vector( -7023, -11701, 72 ), 	-- behind nexus
	Vector( -7073, -7892, 72 ), 	-- bank atm
	Vector( -4831, -4840, 200 ), 	-- tides
	Vector( 4575, -3789, 64 ), 		-- painter
	Vector( -9862, 9435, 72 ), 		-- hospital
	Vector( -7368, -6164, 72 ), 	-- chings shop
	Vector( 10278, 13477, 66 ), 	-- suburbs
	Vector( 684, 4620, 68 ),		-- industrial
	Vector( -3975, -6534, 198 ),	-- casino
}

NPC.Angles['rp_evocity_v33x'] = {
	Angle( 0, 90, 0 ), 		-- nexus
	Angle( 0, -90, 0 ), 	-- behind nexus
	Angle( 0, 0, 0 ), 		-- bank atm
	Angle( 0, 90, 0 ), 		-- tides
	Angle( 0, -180, 0 ),	-- painter
	Angle( 0, 0, 0 ), 		-- hospital
	Angle( 0, -180, 0 ),	-- chings shop
	Angle( 0, 0, 0 ), 		-- suburbs
	Angle( 0, 90, 0 ), 		-- industrial
	Angle( 0, 0, 0 ),		-- casino
}

NPC.Location['rp_evocity_v4b1'] = {
	Vector( -6915, -9669, 70 ), 	-- nexus
	Vector( -7023, -11701, 72 ), 	-- behind nexus
	Vector( -7073, -7892, 72 ), 	-- bank atm
	Vector( -4831, -4840, 200 ), 	-- tides
	Vector( 4575, -3789, 64 ), 		-- painter
	Vector( -9862, 9435, 72 ), 		-- hospital
	Vector( -7368, -6164, 72 ), 	-- chings shop
	Vector( 10278, 13477, 66 ), 	-- suburbs
	Vector( 684, 4620, 68 ),		-- industrial
	Vector( -3975, -6534, 198 ),	-- casino
}

NPC.Angles['rp_evocity_v4b1'] = {
	Angle( 0, 90, 0 ), 		-- nexus
	Angle( 0, -90, 0 ), 	-- behind nexus
	Angle( 0, 0, 0 ), 		-- bank atm
	Angle( 0, 90, 0 ), 		-- tides
	Angle( 0, -180, 0 ),	-- painter
	Angle( 0, 0, 0 ), 		-- hospital
	Angle( 0, -180, 0 ),	-- chings shop
	Angle( 0, 0, 0 ), 		-- suburbs
	Angle( 0, 90, 0 ), 		-- industrial
	Angle( 0, 0, 0 ),		-- casino
}


NPC.Location['rp_paralake_city_v3'] = {
	Vector( -4864.03125, 4664.8388671875, 288.03125 ),	-- bank
	Vector( -4864.03125, 4552.2158203125, 288.03125 ), 	-- bank 2
	Vector( -4864.2036132813, 4433.6181640625, 288.03125 ), 	-- bank 3
	Vector( -6810.1962890625, 1311.96875, 292.03125 ), 	-- gas near bank
	Vector( -9719.96875, 3733.5227050781, 304.03125 ), 		-- skyscraper
	Vector( -5127.9086914063, 11268.024414063, 416.03125 ),	-- city hall

}

NPC.Angles['rp_paralake_city_v3'] = {
	Angle( 0, 180, 0 ), 		-- bank 1
	Angle( 0, 180, 0 ), 	-- bank 2
	Angle( 0, 180, 0 ), 		-- bank atm 3
	Angle( 0, -90, 0 ), 		-- gas near bank
	Angle( 0, 0, 0 ),	-- sky
	Angle( 0, 0, 0 ), 		-- city hall
}

NPC.Location[ "rp_chaos_city_v33x_03" ] = {
	Vector( 3953, -4887, -1870 ), -- NEXUS
	Vector( 8389, -875, -1743 ), -- HOSPITAL
	Vector( 5361, 809, -1869 ), -- GENERAL STORE
	Vector( 1625, -2545, -1817 ), -- BANK
	Vector( 1598, -3983, -1869 ), -- NICE APARTMENTS
	Vector( 1441, -6056, -1869 ), -- CAR DEALER
	Vector( 1783, 11051, -1869 ), -- BURGER KING
	Vector( -10765, -697, -2008 ), -- TIDES
	Vector( 3353, 888, -1869 ), -- GAS STATION, CITY
	Vector( -7705, 5188, -1482 ), -- GAS STATION, INDUSTRIAL
}

NPC.Angles[ "rp_chaos_city_v33x_03" ] = {
	Angle( 0, 90, 0 ), -- NEXUS
	Angle( 0, 180, 0 ), -- HOSPITAL
	Angle( 0, 0, 0 ), -- GENERAL STORE
	Angle( 0, 90, 0 ), -- BANK
	Angle( 0, -90, 0 ), -- NICE APARTMENTS
	Angle( 0, 0, 0 ), -- CAR DEALER
	Angle( 0, -90, 0 ), -- BURGER KING
	Angle( 0, 180, 0 ), -- TIDES
	Angle( 0, 180, 0 ), -- GAS STATION, CITY
	Angle( 0, 180, 0 ), -- GAS STATION, INDUSTRIAL
}

NPC.NoBBox = true

function NPC:RunBehaviour(NPCEnt)
    return NPC_FAKE(NPCEnt)
end

function NPC.OnTalk()
	GAMEMODE.DialogPanel:SetDialog( "What would you like to do?" )
	NPC.MakeDialogButtons()
	GAMEMODE.DialogPanel:Show()
end

function NPC.MakeDialogButtons( )
	GAMEMODE.DialogPanel:AddDialog("Check Balance", NPC.CheckBalanceDialogue)
	GAMEMODE.DialogPanel:AddDialog("Deposit", NPC.DepositDialogue)
	GAMEMODE.DialogPanel:AddDialog("Withdraw", NPC.WithdrawDialogue)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end

function NPC.CheckBalanceDialogue()
	GAMEMODE.DialogPanel:SetDialog( "Current checking account balance: $" .. util.FormatNumber( LocalPlayer():GetBank() ) .. "\n\nWhat would you like to do?" )
	NPC.MakeDialogButtons()
end

function NPC.Deposit( amount )
	if (amount <= 0) then
		GAMEMODE.DialogPanel:SetDialog("A deposit must be a positive integer.\n\nWhat would you like to do?");
	elseif (LocalPlayer():GetCash() >= amount) then
		net.Start("BankDeposit") net.WriteInt(amount,32) net.SendToServer()
		
		GAMEMODE.DialogPanel:SetDialog("Deposited " .. DollarSign() .. amount .. ".\n\nWhat would you like to do?");
	else
		GAMEMODE.DialogPanel:SetDialog("You do not have enough cash to deposit " .. DollarSign() .. amount .. ".\n\nWhat would you like to do?");
	end
	
	NPC.MakeDialogButtons();
end

function NPC.Deposit_Custom( )
	ShowBankWindow("ATM - Deposit", "Amount To Deposit", "Deposit", NPC.Deposit)
end

-- // Deposit Functions
function NPC.DepositDialogue ( )
	GAMEMODE.DialogPanel:SetDialog("How much would you like to deposit?");
	if (LocalPlayer():GetCash() >= 100) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "100", NPC.Deposit_100) end
	if (LocalPlayer():GetCash() >= 1000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "1000", NPC.Deposit_1000) end
	if (LocalPlayer():GetCash() >= 5000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "5000", NPC.Deposit_5000) end
	

	if (LocalPlayer():GetCash() >= 1) then 
		GAMEMODE.DialogPanel:AddDialog("Deposit All", NPC.Deposit_All) 
		GAMEMODE.DialogPanel:AddDialog("Different Amount", NPC.Deposit_Custom)
	end
	
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end

function NPC.Deposit_100 ( ) NPC.Deposit(100); end
function NPC.Deposit_1000 ( ) NPC.Deposit(1000); end
function NPC.Deposit_5000 ( ) NPC.Deposit(5000); end
function NPC.Deposit_All ( ) NPC.Deposit(LocalPlayer():GetCash()); end

// Withdraw Functions
function NPC.WithdrawDialogue ( )
	GAMEMODE.DialogPanel:SetDialog("How much would you like to withdraw?");
	
	local canHoldMore = MAX_CASH - LocalPlayer():GetCash();
	
	if (LocalPlayer():GetBank() >= 100 && canHoldMore >= 100) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "100", NPC.Withdraw_100) end
	if (LocalPlayer():GetBank() >= 1000 && canHoldMore >= 1000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "1000", NPC.Withdraw_1000) end
	if (LocalPlayer():GetBank() >= 5000 && canHoldMore >= 5000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "5000", NPC.Withdraw_5000) end
	
	local wouldShow = math.Clamp(LocalPlayer():GetBank(), 0, canHoldMore);
	if (wouldShow != 0 && wouldShow != 100 && wouldShow != 1000 && wouldShow != 5000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. wouldShow, NPC.Withdraw_Max) end
	
	GAMEMODE.DialogPanel:AddDialog("Different Amount", NPC.Withdraw_Custom)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end

function NPC.Withdraw ( amount )
	if (amount <= 0) then
		GAMEMODE.DialogPanel:SetDialog("A withdraw must be a positive integer.\n\nWhat would you like to do?");
	elseif (LocalPlayer():GetBank() >= amount) then
		if (LocalPlayer():GetCash() + amount > MAX_CASH) then
			GAMEMODE.DialogPanel:SetDialog("You can only hold a maximum of " .. DollarSign() .. MAX_CASH .. ".\n\nWhat would you like to do?");
		else
			net.Start("BankWithdraw") net.WriteInt(amount,32) net.SendToServer()
			
			GAMEMODE.DialogPanel:SetDialog("Withdrew " .. DollarSign() .. amount .. ".\n\nWhat would you like to do?");
		end
	else
		GAMEMODE.DialogPanel:SetDialog("You do not have enough money in your bank account to withdraw " .. DollarSign() .. ammount .. ".\n\nWhat would you like to do?");
	end
	
	NPC.MakeDialogButtons();
end

function NPC.Withdraw_100 ( ) NPC.Withdraw(100); end
function NPC.Withdraw_1000 ( ) NPC.Withdraw(1000); end
function NPC.Withdraw_5000 ( ) NPC.Withdraw(5000); end
function NPC.Withdraw_Max ( ) NPC.Withdraw(math.Clamp(LocalPlayer():GetBank(), 0, MAX_CASH - LocalPlayer():GetCash())); end

function NPC.Withdraw_Custom( )
	ShowBankWindow("ATM - Withdraw", "Amount To Withdraw", "Withdraw", NPC.Withdraw)
end

GAMEMODE:LoadNPC( NPC )
