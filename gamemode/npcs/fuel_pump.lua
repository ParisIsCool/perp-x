--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local NPC = {};

NPC.Name = "Fuel Pump";
NPC.ID = 200;

NPC.Model = Model("models/props_wasteland/gaspump001a.mdl");

NPC.Invisible = true; // Used for ATM Machines, Casino Tables, etc.

NPC.Location, NPC.Angles = {}, {}

NPC.PosAngle = {}
NPC.PosAngle ['rp_southside'] = { 
	{pos=Vector(-5854,645,-32),ang=Angle(5,88,0)},
	{pos=Vector(-6046,645,-32),ang=Angle(3,91,0)},
	{pos=Vector(-6049,699,-32),ang=Angle(5,-89,0)},
	{pos=Vector(-5857,699,-32),ang=Angle(7,-91,0)},
	{pos=Vector(385,13201,128),ang=Angle(0,91,0)},
	{pos=Vector(577,13205,128),ang=Angle(1,88,0)},
	{pos=Vector(575,13261,128),ang=Angle(0,-91,0)},
	{pos=Vector(384,13261,128),ang=Angle(1,-89,0)},
}

//Pump Locations

NPC.Location['rp_florida_v2'] = {

--City BP
Vector( 4068, -999, 144 ),
Vector( 3996, -999, 144 ),
Vector( 3996, -584, 144 ), 
Vector( 4068, -584, 144 ), 
Vector( 3996, -169, 144 ), 
Vector( 4068, -169, 144 ), 

--Country BP
Vector( -3700, 7005, 144.00100708008 ),
Vector( -3628, 7005, 144.00100708008 ),
Vector( -3628, 7420, 144.00100708008 ),
Vector( -3700, 7420, 144.00100708008 ),
Vector( -3628, 7837, 144.00100708008 ),
Vector( -3700, 7837, 144.00100708008 ),

}
NPC.Angles['rp_florida_v2'] = {

--City BP
Angle(0, 90, 0),
Angle(0, 90, 0),
Angle(0, 90, 0),
Angle(0, 90, 0),
Angle(0, 90, 0),
Angle(0, 90, 0),

--Country BP
Angle( 0, 270, 0),
Angle( 0, 270, 0),
Angle( 0, 270, 0),
Angle( 0, 270, 0),
Angle( 0, 270, 0),
Angle( 0, 270, 0),

}

NPC.Location['rp_chaos_city_v33x_03'] = {
--Inner City Pumps
	Vector( 4178, 132, -1869 ),
	Vector( 4096, 132, -1869 ),
	Vector( 4178, 427, -1869 ),
	Vector( 4096, 427, -1869 ),
	Vector( 4178, 722, -1869 ),
	Vector( 4096, 722, -1869 ),
--Outer City Pumps
	Vector( -7233, 5370, -1482 ),
	Vector( -7233, 5079, -1482 ),
	Vector( -7467, 5081, -1482 ),
	Vector( -7467, 5371, -1482 ),
	Vector( -8165, 5370, -1482 ),
	Vector( -8165, 5079, -1482 ),
	Vector( -8398, 5370, -1482 ),
	Vector( -8398, 5079, -1482 ),
}

NPC.Angles['rp_chaos_city_v33x_03'] = {
	Angle( 0, 90, 0),
	Angle( 0, 90, 0),
	Angle( 0, 90, 0),
	Angle( 0, 90, 0),
	Angle( 0, 90, 0),
	Angle( 0, 90, 0),
	--Outer City Pumps
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
	Angle( 0, 0, 0),
}

--Todo make this look better (seriously who ever did this is a bad man)
NPC.Location['rp_evocity2_v3p'] = {Vector(-7493.466796875, 1766.5318603516, 146.03125), Vector(-7410.216796875, 1768.4152832031, 146.03125), Vector(-7149.8203125, 1238.4271240234, 146.03125)}
NPC.Angles['rp_evocity2_v3p'] = {Angle(0, 90, 0), Angle(0, 90, 0), Angle(0, 0, 0)}

NPC.Location['rp_evocity_v33x'] = {Vector(-6533, -6583, 70), Vector(-6460, -6583, 70), Vector(-6460, -6286, 70), Vector(-6533, -6286, 64), Vector(-6530, -5996, 64), Vector(-6463, -5996, 64), Vector(10741, 13291, 64), Vector(10973, 13290, 64), Vector(10975, 13574, 64), Vector(10738, 13567, 64), Vector(10042, 13569, 64), Vector(9811, 13564, 64), Vector(9806, 13297, 64), Vector(10042, 13289, 64)};
NPC.Angles['rp_evocity_v33x'] = {Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)};

NPC.Location['rp_evocity_v4b1'] = {Vector(-6533, -6583, 70), Vector(-6460, -6583, 70), Vector(-6460, -6286, 70), Vector(-6533, -6286, 64), Vector(-6530, -5996, 64), Vector(-6463, -5996, 64), Vector(10741, 13291, 64), Vector(10973, 13290, 64), Vector(10975, 13574, 64), Vector(10738, 13567, 64), Vector(10042, 13569, 64), Vector(9811, 13564, 64), Vector(9806, 13297, 64), Vector(10042, 13289, 64)};
NPC.Angles['rp_evocity_v4b1'] = {Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, -90, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)};

NPC.Location ['rp_rockford_v1b'] = {
	Vector( 278, 3786, 550),
	Vector( 278, 4118, 550),
	Vector( -13910, 2806, 400),
	Vector( -13910, 2474, 400)
}

NPC.Angles ['rp_rockford_v1b'] = {
	Angle(0, 0, 0),
	Angle(0, 0, 0),
	Angle(0, 0, 0),
	Angle(0, 0, 0)
}

NPC.Location ['rp_rockford_v2b'] = {
Vector( 288, 3786, 555.75),
Vector( 288, 4118, 555.75),
Vector( -13910, 2806, 400),
Vector( -13910, 2474, 400)

}

NPC.Angles ['rp_rockford_v2b'] = {
Angle(0, 0, 0),
Angle(0, 0, 0),
Angle(0, 0, 0),
Angle(0, 0, 0)

}

NPC.Location ['rp_paralake_city_v3'] = {
	Vector( -8680.42578125, -7955.96875, 296.03125 ),
	Vector( -8852.4296875, -7943.96875, 296.03125 ),
	Vector( -9025.8388671875, -7955.96875, 296.03125 ),
	Vector( -9025.8388671875, -7996.03125, 296.03125 ),
	Vector( -8680.42578125, -7996.5244140625, 296.03125 ),
	Vector( -8852.4296875, -8008.1904296875, 296.03125 ),
	Vector( -6780.8432617188, 1820.03125, 296.03125 ),
	Vector( -6613.6313476563, 1832.03125, 296.03125 ),
	Vector( -6444.5971679688, 1820.03125, 296.03125 ),
	Vector( -6444.5971679688, 1779.96875, 296.03125 ),
	Vector( -6613.6313476563, 1767.96875, 296.03125 ),
	Vector( -6780.8432617188, 1779.96875, 296.03125 ),
	Vector( -12076.03125, 10965.87890625, 68.03125 ),
	Vector( -12088.03125, 10806.420898438, 68.03125 ),
	Vector( -12023.96875, 10799.391601563, 68.03125 ),
	Vector( -12076.03125, 10635, 68.03125 ),
}

NPC.Angles ['rp_paralake_city_v3'] = {
	Angle(0, 90, 0),
	Angle(0, 90, 0),
	Angle(0, 90, 0),
	Angle(0, -90, 0),
	Angle(0, -90, 0),
	Angle(0, -90, 0),
	Angle(0, 90, 0),
	Angle(0, 90, 0),
	Angle(0, 90, 0),
	Angle(0, -90, 0),
	Angle(0, -90, 0),
	Angle(0, -90, 0),
	Angle(0, -180, 0),
	Angle(0, 0, 0),
	Angle(0, 0, 0),
	Angle(0, -180, 0),
	Angle(0, 180, 0),
	Angle(0, 0, 0),
}


function NPC:RunBehaviour(NPCEnt)
    return NPC_FAKE(NPCEnt)
end

local CurFuel = 0
local FuelMax = 10000

// This is always local player.
function NPC.OnTalk ( )
	local Vehicle = LocalPlayer():GetPNWVar( 'lastcar', NULL )

	if !(Vehicle && IsValid(Vehicle) && Vehicle:GetPos():Distance(LocalPlayer():GetPos()) <= 300) then
		GAMEMODE.DialogPanel:SetDialog("I don't have a car to refuel. (Retrive your car.)");

		GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG);

		GAMEMODE.DialogPanel:Show();

		return
	end

	CurFuel = Vehicle:GetGNWVar('Fuel', 0)

	GAMEMODE.DialogPanel:SetDialog("Welcome to the Fuel Station.");

	NPC.MakeDialogButtons();

	GAMEMODE.DialogPanel:Show();
end

function NPC.MakeDialogButtons ( )
	GAMEMODE.DialogPanel:AddDialog("Buy fuel", NPC.Deposit)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end


// Deposit Functions
function NPC.Deposit ( )
	GAMEMODE.DialogPanel:SetDialog("How much gas would you like to buy?");

	GAMEMODE.DialogPanel:AddDialog("Check your gas", NPC.CheckGas);
	GAMEMODE.DialogPanel:AddDialog("1/4 tank", NPC.Quarter);
	GAMEMODE.DialogPanel:AddDialog("1/2 tank", NPC.Half);
	GAMEMODE.DialogPanel:AddDialog("Fill it", NPC.FillIt);
end

function NPC.Gas ( amount )
	local Vehicle = LocalPlayer():GetPNWVar( 'lastcar', NULL )

	if (LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I should ask my boss about this.\n\n(Government vehicles do not require gas.)");
		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
		return;
	end
	if (!Vehicle || !IsValid(Vehicle) || Vehicle:GetPos():Distance(LocalPlayer():GetPos()) > 300) then
		GAMEMODE.DialogPanel:SetDialog("I probably should bring my car closer to the pump. (the car is too far away)");

		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
	else
		local CashToTake = math.Round(amount * .03)
		if (LocalPlayer():GetCash() >= CashToTake) then
			net.Start("perp_f_a") net.WriteInt(amount,32) net.SendToServer();

			GAMEMODE.DialogPanel:SetDialog("Thank you for your purchase.");

			GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG);
		else
			GAMEMODE.DialogPanel:SetDialog("I don't have that much money.");
			GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG);

		end
	end
end

function NPC.Quarter ( )
	if FuelMax - CurFuel < 2500 then
		local Total = FuelMax - CurFuel;
		NPC.Gas(Total);
	else
		NPC.Gas(2500);
	end
end

function NPC.Half ( )
	if FuelMax <= CurFuel then NPC.Gas(0); end
	if FuelMax - CurFuel < 5000 then
		NPC.Gas(math.Clamp(FuelMax - CurFuel, 0, 10000));
	else
		NPC.Gas(5000);
	end
 end

function NPC.FillIt ( ) NPC.Gas(math.Clamp(10000 - CurFuel, 0, 10000)); end


function NPC.CheckGas ( )
	if (LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("I should ask my boss about this.\n\n(Government vehicles do not require gas.)");
		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
		return;
	end

	PerFuel = math.Round(CurFuel / 100)
	GAMEMODE.DialogPanel:SetDialog("Current Fuel: " .. PerFuel .. "%\n\nWhat would you like to do?");

	NPC.MakeDialogButtons();
end

GAMEMODE:LoadNPC(NPC);
