--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Search Tool"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "PERP / Broski"
SWEP.Instructions = "Left Click: Search"

SWEP.Spawnable	= true
SWEP.UseHands	= true
SWEP.DrawAmmo	= false

SWEP.ViewModel	= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel	= ""

SWEP.ViewModelFOV	= 52

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

local SwingSound = Sound( "weapons/slam/throw.wav" )
local HitSound = Sound( "Flesh.ImpactHard" )
function SWEP:Initialize()

	self:SetWeaponHoldType("fist")
end
function SWEP:PreDrawViewModel( vm, wep, ply )


end
function SWEP:Think()
end


local FistGears = {};
local function AddGear ( Title, Desc, Job,  Func )
	table.insert(FistGears, {Title, Desc, Job,  Func});
end

/* tell admins */
function telladmins(whosearched,whogotsearched,found)
	local tosay = string.format("[Search Tool] %s searched %s and found %s",whosearched,whogotsearched,found);
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
		v:PrintMessage( HUD_PRINTCONSOLE, tosay );
		end
	end
end
/* for searching */ 
local illegal_items = {
	{ ent_name = "drug_shroom", display_name = "Shrooms" },
	{ ent_name = "drug_meth_wet", display_name = "Wet Meth" },
	{ ent_name = "drug_meth", display_name = "Meth" },
	{ ent_name = "drug_cocaine", display_name = "Cocaine"},
	{ ent_name = "drug_cocaine_wet", display_name = "Wet Cocaine" },
	{ ent_name = "drug_coca", display_name = "Cocaine Seeds" },
	{ ent_name = "drug_pot", display_name = "Marijuana" },
	{ ent_name =  "drug_pot_seeds", display_name = "Marijuana Seeds" },
	{ ent_name =  "weapon_perp_ak472", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_bluepolice", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_greyurban", display_name = "AK47" },
	{ ent_name =  "weapon_zomb_ak47", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_forestwoodland", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_wirecamo", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_bluedigital", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_mtndew", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_rederd1", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_white", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_greendigital", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_greynight", display_name = "AK47" },
	{ ent_name =  "cw_tr09_mp9", display_name = "Uzi" },
	{ ent_name =  "weapon_perp_weapon_m4a1", display_name = "M4" },
	{ ent_name =  "weapon_perp_mp5", display_name = "MP5" },
	{ ent_name =  "weapon_perp_ak47_yellowerd1", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_desert", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_greenforest", display_name = "AK47" },
	{ ent_name =  "weapon_perp_ak47_reddesert", display_name = "AK47" },
	{ ent_name =  "cw_glock20", display_name = "Glock" },

	};




local chanceToFindDrugs = 3; //1 in ___ chance
local showDrugName = true;


function SWEP:PrimaryAttack()	
/*
print("========");
for k,v in pairs( weapons.GetList() ) do 
if string.find(v.ClassName,"ak") or string.find(v.ClassName,"m4") or string.find(v.ClassName,"uzi") then
	print("	{ ent_name =  \""..v.ClassName.."\", display_name = \"AK47\" },");
	end
end 
print("========"); */
	if (!SERVER) then return end 

	local Trace = self.Owner:GetEyeTrace();
	local Distance = self.Owner:EyePos():Distance(Trace.HitPos);
		if Distance > 55 then return false; end
		if !Trace.Entity:IsPlayer() then return false; end
		if Trace.Entity:IsGovernmentOfficial() then return false; end
		self.Weapon:SetNextPrimaryFire(CurTime() + 30);
		local LastSearched = Trace.Entity.LastSearched or 0;
		if LastSearched + (5 * 60) > CurTime() then 
		self.Owner:Notify("This person has already been searched in the past 5 minutes")
		self.Owner:PrintMessage(HUD_PRINTTALK,"You must wait 30 seconds to search another person");
		return;
		end
			for k,v in pairs(illegal_items) do
				if math.random(0,chanceToFindDrugs) == 1 then
					//Check to see if we found anything
					if Trace.Entity:HasItem(v.ent_name) then
					foundSomething = true;
					telladmins(self.Owner:GetRPName() .. " ("..self.Owner:GetName()..")",Trace.Entity:GetRPName() .. " ("..Trace.Entity:GetName()..")",v.display_name);
					if showDrugName then 
						self.Owner:Notify("You found " .. v.display_name .. " on the person.")
						self.Owner:PrintMessage(HUD_PRINTTALK,"You found " .. v.display_name .. " on the person");
						Trace.Entity:Notify("The police found " .. v.display_name .. " on you.")
						Trace.Entity:PrintMessage(HUD_PRINTTALK,"The police found " .. v.display_name .. " on you.")

					else
						self.Owner:Notify("You found illegal drugs on the person.")
						self.Owner:PrintMessage(HUD_PRINTTALK,"You found illegal drugs on the person");
						Trace.Entity:Notify("The police found your illegal drugs.")
						Trace.Entity:PrintMessage(HUD_PRINTTALK,"The police found your illegal drugs.");

					end
					end
					
				end
				
			
			end
				//Tell the person they found nothing
			if !foundSomething then
				self.Owner:PrintMessage(HUD_PRINTTALK,"You found nothing on the person.");
				self.Owner:Notify("You found nothing on the person")
				Trace.Entity:Notify("The police found nothing on you")
				Trace.Entity:PrintMessage(HUD_PRINTTALK,"The police found nothing on you.");
				telladmins(self.Owner:GetRPName() .. " ("..self.Owner:GetName()..")",Trace.Entity:GetRPName() .. " ("..Trace.Entity:GetName()..")","nothing");
			end
			self.Owner:PrintMessage(HUD_PRINTTALK,"You must wait 30 seconds to search another person");
			Trace.Entity.LastSearched = CurTime();
			self.Weapon:SetNextPrimaryFire(CurTime() + 30);
			foundSomething = nil;
end


function SWEP:SecondaryAttack()	
		
end 

  
  



