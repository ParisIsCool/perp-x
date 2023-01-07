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

NPC.Name = "Druggy"
NPC.ID = 16

NPC.Model = Model("models/bala/gangboi.mdl")

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-6587,3870,-39),ang=Angle(1,179,0)},
	{pos=Vector(967,7136,24.5),ang=Angle(-4,84,0)},
}
NPC.NoTalkSequence = true

--Vector( 4782.0708007812, -12287.676757812, 136.0602722168 ), Angle( 0.55995792150497, -0.68365550041199, 0)
NPC.Location[ "rp_florida_v2" ] = {
	Vector( 4782.0708007812, -12287.676757812, 136.0602722168 ), --City Pier
	Vector( 7846.7236328125, 7099.630859375, 136.03125 ), --Sea Side
}
NPC.Angles[ "rp_florida_v2" ] = {
Angle( 0, 0, 0), --City Pier
Angle( 1.3519611358643, 88.522644042969, 0), --Sea Side
}

NPC.Location['rp_evocity2_v3p'] = Vector(4316.5717773438, 523.01116943359, 76)
NPC.Angles['rp_evocity2_v3p'] = Angle(0, 0, 0)

NPC.Location ['rp_rockford_v1b'] = { Vector( -7972.8305664063, -480.03125, 0.03125 ) }
NPC.Angles ['rp_rockford_v1b'] = { Angle( 0, -90, 0) }

NPC.Location ['rp_rockford_v2b'] = { Vector(-8015.968750, 1259.050903, 4.031250),
									 Vector( -731.04956054688, 6179.9926757812, 536.03125 ),
 }
NPC.Angles ['rp_rockford_v2b'] = { Angle(3.417070, 24.453682, 0.000000 ),
								   Angle( -0.10013638436794, -60.105136871338, 0),
 }
/*
NPC.Location['rp_evocity_v33x'] = {
	-- City Park
	//Vector(-9377, -9595, 74),
	-- Lake
	//Vector(-6778, 13644, 188),
	//Vector(-12208, 11832, 188),
	//Vector(1056, 4623, 68),

	Vector(-8116, -11812, 72),
}

NPC.Angles['rp_evocity_v33x'] = {
	-- City Park
	//Angle(0, 130, 0),
	-- Lake
	//Angle(0, 0, 0),
	Angle(0, -90, 0),
}
*/

NPC.Location['rp_evocity_v33x'] = Vector(-6469, -8583, 72)
NPC.Angles['rp_evocity_v33x'] = Angle(0, 90, 0)

NPC.Location['rp_evocity_v4b1'] = Vector(-6469, -8583, 72)
NPC.Angles['rp_evocity_v4b1'] = Angle(0, 90, 0)

NPC.Location['rp_paralake_city_v3'] = Vector( -4119.96875, 2037.7691650391, 292.0309753418 )
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 0, 0)

NPC.Location[ "rp_chaos_city_v33x_03" ] = Vector( 113, -5567, -1869 )
NPC.Angles[ "rp_chaos_city_v33x_03" ] = Angle( 0, -123, 0 )

NPC.ShowChatBubble = false

function NPC:RunBehaviour(NPCEnt)
	NPC_DRUGGY(NPCEnt)
end

local BUYING_ID, SELLING_ID, NEXT_THREAT = 0, 0, 0

usermessage.Hook( "perp_druggy", function( UMsg )
	BUYING_ID = UMsg:ReadShort()
	SELLING_ID = UMsg:ReadShort()
	NEXT_THREAT = UMsg:ReadShort()
end )

-- This is always local player.
function NPC.OnTalk()
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("< Glances Around >\n\nHey, wanna some dank?")

		GAMEMODE.DialogPanel:AddDialog("I got some product to sell...", NPC.BuyStuff)
		GAMEMODE.DialogPanel:AddDialog("Got anything good?", NPC.SellStuff)
		GAMEMODE.DialogPanel:AddDialog("Fuck off.", LEAVE_DIALOG)

		RunConsoleCommand( "perp_druggy" )
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.")

		GAMEMODE.DialogPanel:AddDialog("Err... Hello.", LEAVE_DIALOG)
	end

	GAMEMODE.DialogPanel:Show()
end

function NPC.BuyStuff()
	if BUYING_ID ~= 0 then
		GAMEMODE.DialogPanel:SetDialog("Yah, I got some spare cash. What are you trying to sell?")

		GAMEMODE.DialogPanel:AddDialog( "I made some meth the other day and I need to sell it.", NPC.BuyStuff_Meth )
		GAMEMODE.DialogPanel:AddDialog( "I have a lot of weed that needs a buyer.", NPC.BuyStuff_Weed )
		GAMEMODE.DialogPanel:AddDialog( "I wanna dump all this shroomy stuff.", NPC.BuyStuff_Shroom )
		GAMEMODE.DialogPanel:AddDialog( "I'm drowning in my cocaine please buy some.", NPC.BuyStuff_Cocaine )

		GAMEMODE.DialogPanel:AddDialog("Nevermind.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Naw, I don't have enough cash at the moment, sorry. Come back by later and we can work out a deal.")

		GAMEMODE.DialogPanel:AddDialog("Alright, I'll stop by later.", LEAVE_DIALOG)
	end
end

function NPC.BuyStuff_Meth( ID )
	if BUYING_ID == 10 then
		GAMEMODE.DialogPanel:SetDialog("Yah, I'll buy some of that. $" ..  util.FormatNumber( ITEM_DATABASE[10].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Meth_Confirm)
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.")

		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG)
	end
end

function NPC.BuyStuff_Meth_Confirm()
	RunConsoleCommand( "perp_sd_m" )

	local totalEarned = ITEM_DATABASE[10].Cost * LocalPlayer():GetItemCount(10)

	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your $" .. totalEarned .. ".")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)
end

function NPC.BuyStuff_Weed( ID )
	if BUYING_ID == 13 then
		GAMEMODE.DialogPanel:SetDialog("Yah, I'll buy some of that. $" ..  util.FormatNumber( ITEM_DATABASE[13].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Weed_Confirm)
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.")

		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG)
	end
end

function NPC.BuyStuff_Weed_Confirm()
	RunConsoleCommand("perp_sd_w")

	local totalEarned = ITEM_DATABASE[13].Cost * LocalPlayer():GetItemCount(13)

	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your $" .. util.FormatNumber( totalEarned ) .. ".")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)
end

function NPC.BuyStuff_Shroom( ID )
	if BUYING_ID == 78 then
		GAMEMODE.DialogPanel:SetDialog("Yah, I'll buy some of that. $" .. util.FormatNumber( ITEM_DATABASE[78].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Shroom_Confirm)
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.")

		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG)
	end
end

function NPC.BuyStuff_Shroom_Confirm()
	RunConsoleCommand("perp_sd_shroom")

	local totalEarned = ITEM_DATABASE[78].Cost * LocalPlayer():GetItemCount(78)

	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your $" .. totalEarned .. ".")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)
end

function NPC.BuyStuff_Cocaine( ID )
	if BUYING_ID == 69 then
		GAMEMODE.DialogPanel:SetDialog("Yah, I'll buy some of that. $" .. util.FormatNumber( ITEM_DATABASE[69].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Cocaine_Confirm)
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.")

		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG)
	end
end

function NPC.BuyStuff_Cocaine_Confirm()
	RunConsoleCommand("perp_sd_cocaine")

	local totalEarned = ITEM_DATABASE[69].Cost * LocalPlayer():GetItemCount(69)

	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your $" .. util.FormatNumber( totalEarned ) .. ".")
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG)
end

function NPC.SellStuff()
	if SELLING_ID == 14 then
		GAMEMODE.DialogPanel:SetDialog("Yah man, I got some seeds. You interested? $" .. util.FormatNumber( ITEM_DATABASE[14].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Yah, I'll take some.", NPC.SellStuff_Weed)
		GAMEMODE.DialogPanel:AddDialog("Jeez, why do you never sell what I want.", NPC.Threat)
		GAMEMODE.DialogPanel:AddDialog("Naw man, sorry.", LEAVE_DIALOG)
	elseif SELLING_ID == 78 then
		GAMEMODE.DialogPanel:SetDialog("Yah man, I got some shrooms. You interested? $" .. util.FormatNumber( ITEM_DATABASE[78].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Yah, I'll take some.", NPC.SellStuff_Shroom)
		GAMEMODE.DialogPanel:AddDialog("Jeez, why do you never sell what I want.", NPC.Threat)
		GAMEMODE.DialogPanel:AddDialog("Naw man, sorry.", LEAVE_DIALOG)
	elseif SELLING_ID == 68 then
		GAMEMODE.DialogPanel:SetDialog("Yah man, I got some cocaine. You interested? $" .. util.FormatNumber( ITEM_DATABASE[68].Cost ) .. " each.")

		GAMEMODE.DialogPanel:AddDialog("Yah, I'll take some.", NPC.SellStuff_Cocaine)
		GAMEMODE.DialogPanel:AddDialog("Jeez, why do you never sell what I want.", NPC.Threat)
		GAMEMODE.DialogPanel:AddDialog("Naw man, sorry.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry, I got nothing today. The people around here are druggies, I tell ya.")

		GAMEMODE.DialogPanel:AddDialog("You and your conspiracy theories...", LEAVE_DIALOG)
		GAMEMODE.DialogPanel:AddDialog("Jeez, why do you never sell what I want.", NPC.Threat)
		GAMEMODE.DialogPanel:AddDialog("Damnit, alright. I'll stop by later.", LEAVE_DIALOG)
	end
end

function NPC.SellStuff_Weed()
	GAMEMODE.DialogPanel:SetDialog( "How many do you need?" )

	GAMEMODE.DialogPanel:AddDialog( "One ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 1 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 1 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Two ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 2 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 2 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Three ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 3 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 3 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Four ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 4 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 4 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Five ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 5 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 5 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Ten ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 10 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 10 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Twenty ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 20 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 20 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Fifty ( $" .. util.FormatNumber( ITEM_DATABASE[14].Cost * 50 ) .. " )", function() NPC.SellStuff_Weed_Confirm( 50 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind", LEAVE_DIALOG )
end

function NPC.SellStuff_Shroom()
	GAMEMODE.DialogPanel:SetDialog( "How many do you need?" )

	GAMEMODE.DialogPanel:AddDialog( "One ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 1 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 1 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Two ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 2 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 2 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Three ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 3 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 3 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Four ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 4 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 4 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Five ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 5 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 5 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Ten ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 10 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 10 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Twenty ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 20 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 20 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Fifty ( $" .. util.FormatNumber( ITEM_DATABASE[78].Cost * 50 ) .. " )", function() NPC.SellStuff_Shroom_Confirm( 50 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind", LEAVE_DIALOG )
end

function NPC.SellStuff_Cocaine()
	GAMEMODE.DialogPanel:SetDialog( "How many do you need?" )

	GAMEMODE.DialogPanel:AddDialog( "One ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 1 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 1 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Two ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 2 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 2 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Three ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 3 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 3 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Four ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 4 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 4 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Five ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 5 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 5 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Ten ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 10 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 10 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Twenty ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 20 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 20 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Fifty ( $" .. util.FormatNumber( ITEM_DATABASE[68].Cost * 50 ) .. " )", function() NPC.SellStuff_Cocaine_Confirm( 50 ) end )
	GAMEMODE.DialogPanel:AddDialog( "Nevermind", LEAVE_DIALOG )
end

function NPC.SellStuff_Weed_Confirm( num )
	local totalCost = num * ITEM_DATABASE[14].Cost

	GAMEMODE.DialogPanel:SetDialog( "That'll be $" .. util.FormatNumber( totalCost ) .. "." )

	if LocalPlayer():GetCash() < totalCost then
		GAMEMODE.DialogPanel:AddDialog( "Ahh, I can't afford that.", LEAVE_DIALOG )
	elseif not LocalPlayer():CanHoldItem( 14, num ) then
		GAMEMODE.DialogPanel:AddDialog( "Nevermind, I don't think I can hold that many.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )

		RunConsoleCommand( "perp_bd_w", num )
	end
end

function NPC.SellStuff_Shroom_Confirm( num )
	local totalCost = num * ITEM_DATABASE[78].Cost

	GAMEMODE.DialogPanel:SetDialog( "That'll be $" .. util.FormatNumber( totalCost ) .. "." )

	if LocalPlayer():GetCash() < totalCost then
		GAMEMODE.DialogPanel:AddDialog( "Ahh, I can't afford that.", LEAVE_DIALOG )
	elseif not LocalPlayer():CanHoldItem( 78, num ) then
		GAMEMODE.DialogPanel:AddDialog( "Nevermind, I don't think I can hold that many.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )

		RunConsoleCommand( "perp_bd_shroom", num )
	end
end

function NPC.SellStuff_Cocaine_Confirm( num )
	local totalCost = num * ITEM_DATABASE[68].Cost

	GAMEMODE.DialogPanel:SetDialog( "That'll be $" .. util.FormatNumber( totalCost ) .. "." )

	if LocalPlayer():GetCash() < totalCost then
		GAMEMODE.DialogPanel:AddDialog( "Ahh, I can't afford that.", LEAVE_DIALOG )
	elseif not LocalPlayer():CanHoldItem( 68, num ) then
		GAMEMODE.DialogPanel:AddDialog( "Nevermind, I don't think I can hold that many.", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:AddDialog( "Thanks!", LEAVE_DIALOG )

		RunConsoleCommand( "perp_bd_cocaine", num )
	end
end

function NPC.Threat()
	if NEXT_THREAT < CurTime() then
		GAMEMODE.DialogPanel:SetDialog( "So.. you're telling me that I should sell something else? Well ...." )

		GAMEMODE.DialogPanel:AddDialog( "I'm telling you to sell me seeds. If you don't I'll fuck you over. You heard me?", function() NPC.ThreatFinish( 14 ) end )
		GAMEMODE.DialogPanel:AddDialog( "I'm telling you to sell me Shrooms. If you don't I'll fuck you over. You heard me?", function() NPC.ThreatFinish( 78 ) end )
		GAMEMODE.DialogPanel:AddDialog( "I'm telling you to gimme sum cocaine you fathead.", function() NPC.ThreatFinish( 68 ) end )
		GAMEMODE.DialogPanel:AddDialog( "No, I am just kidding..", LEAVE_DIALOG )
	else
		GAMEMODE.DialogPanel:SetDialog( "What? I am a professional and indeed, I don't always sell what you want. Now shut the hell up. Deal with it." )

		GAMEMODE.DialogPanel:AddDialog( "...", LEAVE_DIALOG )
	end
end

function NPC.ThreatFinish( iDrug )
	RunConsoleCommand( "perp_bd_thr", iDrug )

	GAMEMODE.DialogPanel:SetDialog("Yes yes fine fine.. Now calm down you idiot.")

	GAMEMODE.DialogPanel:AddDialog("Love you! <give kiss>", LEAVE_DIALOG)
	GAMEMODE.DialogPanel:AddDialog("FFFF.", LEAVE_DIALOG)
end

GAMEMODE:LoadNPC( NPC )
