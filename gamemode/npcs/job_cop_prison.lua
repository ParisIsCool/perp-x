//The npc for the prison
--[[
local NPC = {};

NPC.Name = "Prison";
//Check if this NPC.ID is already used!!!
NPC.ID = 52;

NPC.Model =  Model("models/preytech/perp/players/npcs/perp_cop.mdl")
NPC.Skin = 3;
NPC.bodygroups = {}
NPC.bodygroups[1] = 0;
NPC.bodygroups[2] = 0;
NPC.bodygroups[3] = 0;
NPC.bodygroups[4] = 1;
NPC.bodygroups[5] = 1;
NPC.bodygroups[6] = 0;
NPC.bodygroups[7] = 0;
NPC.bodygroups[8] = 0;
NPC.bodygroups[9] = 0;
NPC.bodygroups[10] = 0;
NPC.bodygroups[11] = 0;
NPC.bodygroups[12] = 0;

NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location, NPC.Angles = {}, {}

NPC.Location['rp_paralake_city_v3'] = Vector(-8372, 10351, -775);
NPC.Angles['rp_paralake_city_v3'] = Angle(0, 90, 0);

NPC.Location[ "rp_chaos_city_v33x_03" ] = { Vector( 3500.96484375, -4299.7885742188, -2372.96875 ) }
NPC.Angles[ "rp_chaos_city_v33x_03" ] = { Angle( 0, 0, 0 ) }

NPC.ShowChatBubble = "Normal";
NPC.Sequence = 8;

function NPC:RunBehaviour(NPCEnt)
    return NPC_IDLE(NPCEnt)
end

hook.Add("Initialize", "policejails", function()
	util.AddNetworkString("open_cell_door")
end)


// This is always local player.
function NPC.OnTalk ( )
	if(LocalPlayer():GetNetworkedBool("restrained", false)) then return; end
	if (LocalPlayer():Team() == TEAM_POLICE) or (LocalPlayer():Team() == TEAM_CHIEF) then
		GAMEMODE.DialogPanel:SetDialog("Do you need something? <TESTING MAY BUG OUT>");
		local amount = 0
		local arrestedperson = nil;
		for k,v in pairs(player.GetAll()) do
			if(v:GetPos():Distance(LocalPlayer():GetPos()) <= 300 && v:GetNetworkedBool("restrained", false)) then
				amount = amount + 1
				arrestedperson = v;
			end
		end
		if(amount == 1) then
			GAMEMODE.DialogPanel:AddDialog("Can you put this suspect into jail for me?", function() NPC.Jail(arrestedperson:SteamID()) end);
		elseif(amount > 1) then
			GAMEMODE.DialogPanel:AddDialog("Can you put one of those suspects into jail?", NPC.JailMultiple);
		end
		GAMEMODE.DialogPanel:AddDialog("Please open a cell door for me.", NPC.OpenDoor);
		GAMEMODE.DialogPanel:AddDialog("Just checking on you.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!");
		GAMEMODE.DialogPanel:AddDialog("Good day, officer.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		if(LocalPlayer():Team() == TEAM_CITIZEN && string.sub(LocalPlayer():GetActiveWeapon():GetClass(), 0, 16) == "weapon_perp_phys") then
			GAMEMODE.DialogPanel:SetDialog("Is that a gun?")
			GAMEMODE.DialogPanel:AddDialog("Yes, open the fucking jail", NPC.OpenAllDoors);
			GAMEMODE.DialogPanel:AddDialog("You saw nothing...", LEAVE_DIALOG);
			GAMEMODE.DialogPanel:Show()
		else
			if (LocalPlayer():GetNetworkedBool("warrent", false)) then
				GAMEMODE.DialogPanel:SetDialog("Are you turning yourself in? You'll receive a reduced sentence. (5 minutes)");
				GAMEMODE.DialogPanel:AddDialog("As a matter of fact, yes.", NPC.TurnIn);
				GAMEMODE.DialogPanel:AddDialog("Oh, shi-", NPC.CallBackup);
			else
				GAMEMODE.DialogPanel:SetDialog("Hello, sir.");
				GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
			end
		end
	else
		GAMEMODE.DialogPanel:SetDialog("Hello, sir.");
		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
	end

	GAMEMODE.DialogPanel:Show();
end

//function NPC.OnTalk ( )
//		GAMEMODE.DialogPanel:SetDialog("Hello, I'm not finished yet!!")
//		GAMEMODE.DialogPanel:AddDialog("test", NPC.OpenDoor);
//		GAMEMODE.DialogPanel:Show()
//end

function NPC.OpenAllDoors ()
	GAMEMODE.DialogPanel:SetDialog("Please don't kill me!");
	net.Start("PD_Jail_Gate")
	net.WriteInt(-1, 8)
	net.SendToServer()
	GAMEMODE.DialogPanel:AddDialog("We'll see about that.", LEAVE_DIALOG);
end


function NPC.OpenDoor (done)
	if(done) then
		GAMEMODE.DialogPanel:SetDialog("Is there another cell you want me to open for you?");
	else
		GAMEMODE.DialogPanel:SetDialog("Which cell do you want me to open for you?");
	end
	for i = 1, 8 do
		GAMEMODE.DialogPanel:AddDialog("Toggle cell door " .. i .. " please", function()
			net.Start("PD_Jail_Gate")
			net.WriteInt(i, 8)
			net.SendToServer()
			NPC.OpenDoor(true);
		end);
	end
	if(done) then
		GAMEMODE.DialogPanel:AddDialog("Thank you", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:AddDialog("Nevermind", LEAVE_DIALOG);
	end
end




function NPC.Jail (index)
	GAMEMODE.DialogPanel:SetDialog("And for how long?");
	GAMEMODE.DialogPanel:AddDialog("1 minute", function() NPC.TeleportToJail(1, index) end); --Remove 1 minute after testing phase
	GAMEMODE.DialogPanel:AddDialog("2 minutes", function() NPC.TeleportToJail(2, index) end);
	GAMEMODE.DialogPanel:AddDialog("3 minutes", function() NPC.TeleportToJail(3, index) end);
	GAMEMODE.DialogPanel:AddDialog("5 minutes", function() NPC.TeleportToJail(5, index) end);
	GAMEMODE.DialogPanel:AddDialog("7 minutes", function() NPC.TeleportToJail(7, index) end);
	GAMEMODE.DialogPanel:AddDialog("10 minutes", function() NPC.TeleportToJail(10, index) end);
	GAMEMODE.DialogPanel:AddDialog("Nevermind", LEAVE_DIALOG);
end

function NPC.JailMultiple ()
	GAMEMODE.DialogPanel:SetDialog("And whom do you want to jail?");
	local players = {}
	for k,v in pairs(player.GetAll()) do
		if(v:GetPos():Distance(LocalPlayer():GetPos()) <= 300 && v:GetNetworkedBool("restrained", false)) then
			table.insert(players, v)
		end
	end
	for k,v in pairs(players) do
		GAMEMODE.DialogPanel:AddDialog(v:GetRPName() .. " please.", function() NPC.Jail(v:SteamID()) end);
	end
	GAMEMODE.DialogPanel:AddDialog("Nevermind", LEAVE_DIALOG);
end

function NPC.TeleportToJail(minutes, index)
	if(index) then
		RunConsoleCommand("imprison_suspect", tostring(minutes), index)
	end
	LEAVE_DIALOG()
end

function NPC.TurnIn ( )
	GAMEMODE.DialogPanel:SetDialog("I'll just put these handcuffs on you and take you in.");
	GAMEMODE.DialogPanel:AddDialog("But... Fine...", function() NPC.TeleportToJail(5, LocalPlayer():SteamID()) end);
	return;
end

function NPC.CallBackup ( )
	LEAVE_DIALOG()
	return;
end

if(string.lower(game.GetMap()) != "rp_evocity_v33x") then
	GAMEMODE:LoadNPC(NPC);
end
]]--