--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function GM:OpenInventory()
	if GAMEMODE.ShopPanel then
		GAMEMODE.ShopPanel:Remove()
		GAMEMODE.ShopPanel = nil
		gui.EnableScreenClicker( false )
		LocalPlayer():ClearForcedEyeAngles()
		
		return
	end
	
	GAMEMODE.InventoryPanel:SetVisible( true )
	gui.EnableScreenClicker( true )
end

function GM:CloseInventory()
	if GAMEMODE.ShopPanel then
		GAMEMODE.ShopPanel:Remove()
		GAMEMODE.ShopPanel = nil
		gui.EnableScreenClicker( false )
		LocalPlayer():ClearForcedEyeAngles()
		
		return
	end
	
	GAMEMODE.InventoryPanel:SetVisible( false )
	gui.EnableScreenClicker( false )
end

local VARTYPE_NONE 		= 0
local VARTYPE_ANGLE 	= 1
local VARTYPE_VECTOR 	= 2
local VARTYPE_BIT 		= 3
local VARTYPE_INT 		= 4
local VARTYPE_FLOAT		= 5
local VARTYPE_STRING	= 6
local VARTYPE_ENTITY 	= 7

local function GetNWType( Value )
	if Value == VARTYPE_ANGLE then
		return VARTYPE_ANGLE, net.ReadAngle
	elseif Value == VARTYPE_VECTOR then
		return VARTYPE_VECTOR, net.ReadVector
	elseif Value == VARTYPE_BIT then
		return VARTYPE_BIT, net.ReadBit
	elseif Value == VARTYPE_INT then
		return VARTYPE_INT, net.ReadInt
	elseif Value == VARTYPE_FLOAT then
		return VARTYPE_FLOAT, net.ReadFloat
	elseif Value == VARTYPE_STRING then
		return VARTYPE_STRING, net.ReadString
	elseif Value == VARTYPE_ENTITY then
		return VARTYPE_ENTITY, net.ReadEntity
	end
	
	return VARTYPE_NONE
end


GM.GlobalData = GM.GlobalData or {}

net.Receive( "perp_gnwvar", function( Length )

	local table = net.ReadTable()
	
	local EntIndex 	= tostring(table[3])

	GAMEMODE.GlobalData[ EntIndex ] = GAMEMODE.GlobalData[ EntIndex ] or {}
	GAMEMODE.GlobalData[ EntIndex ][ table[1] ] = table[2]

end )

function GetGNWVar( StringID, Default )
	return GAMEMODE.GlobalData[ "Global" ] and GAMEMODE.GlobalData[ "Global" ][ StringID ] or Default
end

function ENTITY:GetGNWVar( StringID, Default )
	local EntIndex = tostring( self:EntIndex() )

	return GAMEMODE.GlobalData[ EntIndex ] and GAMEMODE.GlobalData[ EntIndex ][ StringID ] or Default
end

net.Receive( "perp_gnwvar_flush", function( Length )
	GAMEMODE.GlobalData[ net.ReadString() ] = nil
end )

GM.PrivateData = GM.PrivateData or {}

net.Receive( "perp_pnwvar", function( Length )
	local table = net.ReadTable()

	GAMEMODE.PrivateData[ table[1] ] = table[2]
end )

function PLAYER:GetPNWVar( ID, Default )
	return GAMEMODE.PrivateData[ ID ] or Default
end

net.Receive( "restartin", function()
	local Restarting = net.ReadBool()
	local In = net.ReadInt(32)

	if not Restarting then
		GAMEMODE.RestartingIn = nil
	else
		GAMEMODE.RestartingIn = os.time() + In
	end
end )

net.Receive( "perp_payday", function()
	local TO_EARN = net.ReadInt(16)
	local TO_EARN_TEXT = net.ReadString()
	
	if not GAMEMODE.Options_ShowPaydayInfo:GetBool() then return end

	LocalPlayer():Notify( "You have received $" .. util.FormatNumber( TO_EARN ) .. " " .. TO_EARN_TEXT )
end )

net.Receive( "perp_buddies", function()
	if GAMEMODE.InventoryPanel:IsVisible() or GAMEMODE.ShopPanel then return end

	GAMEMODE.BuddyPanel = vgui.Create( "perp2_buddies" )
end )

net.Receive( "perp_help", function()
	if GAMEMODE.InventoryPanel:IsVisible() or GAMEMODE.ShopPanel then return end

	if IsValid( GAMEMODE.HelpPanel ) then
		GAMEMODE.HelpPanel:SetVisible( true )
		GAMEMODE.HelpPanel:MakePopup()
	else
		GAMEMODE.HelpPanel = vgui.Create( "perp2_help" )
	end
end )

net.Receive( "perp_org", function()
	if GAMEMODE.InventoryPanel:IsVisible() or GAMEMODE.ShopPanel then return end

	if LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.MayorPanel = vgui.Create( "perp2_mayor_tab" )
		--new
	elseif (LocalPlayer():Team() == TEAM_CHIEF) then
		GAMEMODE.ChiefPanel = vgui.Create("perp2_chief_tab");
	elseif (LocalPlayer():Team() == TEAM_FIRECHIEF) then
		GAMEMODE.ChiefPanel = vgui.Create("perp2_firechief_tab");	
				
	else
		GAMEMODE.OrgPanel = vgui.Create( "perp2_organization" )
	end
end )

net.Receive( "perp_rename", function()
	ShowRenamePanel( true )
end )

net.Receive( "perp_srod", function()
	local id = net.ReadInt(16)
	local str = net.ReadString()
	
	GAMEMODE.OrganizationData[id] = GAMEMODE.OrganizationData[id] or {}
	GAMEMODE.OrganizationData[id][1] = str
end )

net.Receive( "perp_rod", function()
	local id = net.ReadInt(16)
	local str = net.ReadString()
	local name = net.ReadString()
	local wereLeader = net.ReadBool()
	
	GAMEMODE.OrganizationData[ id ] = { str, "Loading...", name, wereLeader, {} }
end )

net.Receive( "perp_rod_mod", function()
	local id = net.ReadInt(16)
	local motd = net.ReadString()
	
	GAMEMODE.OrganizationData[ id ] = GAMEMODE.OrganizationData[ id ] or { str, "Loading...", name, wereLeader, {} }

	GAMEMODE.OrganizationData[ id ][2] = motd
end )

net.Receive( "perp_rod_m", function() 
	local id = net.ReadInt(16)
	local name = net.ReadString()
	local uid = net.ReadString()
	
	if not GAMEMODE.OrganizationData[ id ][5] then GAMEMODE.OrganizationData[ id ][5] = {} end
	table.insert( GAMEMODE.OrganizationData[ id ][5], { name, uid } )
end )

net.Receive( "perp_cleany_org", function()
	GAMEMODE.OrganizationData[ net.ReadInt(16) ][5] = nil
end )

net.Receive( "perp_rod_c", function()
	local id = net.ReadInt(16)
	local uid = net.ReadString()

	for k, v in pairs( GAMEMODE.OrganizationData[ id ][5] ) do
		if v[2] == uid then
			GAMEMODE.OrganizationData[ id ][5][ k ] = nil
			break
		end
	end
end )

net.Receive( "perp_invite", function()
	local name = net.ReadString()
	
	if GAMEMODE.InvitePanel then
		GAMEMODE.InvitePanel:Remove()
	end
	
	GAMEMODE.InvitePanel = vgui.Create( "perp2_invite" )
	GAMEMODE.InvitePanel:SetOrg( name )
end )

net.Receive( "perp_strip_main", function()
	for i = 1, 2 do
		if GAMEMODE.PlayerItems[ i ] then
			GAMEMODE.PlayerItems[ i ] = nil
			GAMEMODE.InventoryBlocks_Linear[ i ]:GrabItem()
		end
	end
end )

net.Receive( "perp_arrested", function()
	GAMEMODE.UnarrestTime = CurTime() + net.ReadInt(16)
end )

net.Receive( "perp_house_alarm", function()
	local Entity = net.ReadEntity()
	if not IsValid( Entity ) then return end
	
	Entity:EmitSound( "perp2.5/house_alarm_long.mp3" )
end )

net.Receive( "perp_bomb", function()
	local pos = net.ReadVector()
	
	local effectdata = EffectData()
		effectdata:SetOrigin( pos )
	util.Effect( "explosion_car", effectdata )
								
	local effectdata = EffectData()
		effectdata:SetOrigin( pos )
	util.Effect( "Explosion", effectdata, true, true )
end )

net.Receive( "perp_reset_stam", function()
	LocalPlayer().Stamina = 100
end )