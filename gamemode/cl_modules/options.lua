--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up file.

GM.Options_GUIAlpha 					= CreateClientConVar( "perp2_gui_alpha", "255", true, false )
GM.Options_HUDAlpha 					= CreateClientConVar( "perp2_hud_alpha", "255", true, false )
//GM.Options_HUDColorR 					= CreateClientConVar( "perp2_hud_colorr", "255", true, false )
//GM.Options_HUDColorG 					= CreateClientConVar( "perp2_hud_colorg", "255", true, false )
//GM.Options_HUDColorB 					= CreateClientConVar( "perp2_hud_colorb", "255", true, false )
GM.Options_InventoryShouldUseGUIAlpha 	= CreateClientConVar( "perp2_gui_inv_alpha", "0", true, false )
GM.Options_ShowOOC 						= CreateClientConVar( "perp2_show_ooc", "1", true, false )
GM.Options_ShowChatBubble 				= CreateClientConVar( "perp2_show_chat_bubble", "1", true, false )
GM.Options_SaveBuddies 					= CreateClientConVar( "perp2_save_buddies", "0", true, false )
--GM.Options_ShowUnownableDoors 			= CreateClientConVar( "perp2_show_unownable_doors", "1", true, false )
GM.Options_ShowNames 					= CreateClientConVar( "perp2_show_names", "1", true, false )
GM.Options_EuroStuff 					= CreateClientConVar( "perp2_euro", "0", true, false )
GM.Options_DrawHUD						= CreateClientConVar( "perp_draw_hud", "1", true, false )
GM.Options_ShowPaydayInfo 				= CreateClientConVar( "perp2_payday_info", "1", true, false )
GM.Options_DisableFireSmoke 			= CreateClientConVar( "perp2_firesmoke_disable", "0", true, false )
GM.Options_MuteLocalBreath 				= CreateClientConVar( "perp2_mute_local_breath", "0", true, false )
GM.Options_AZERTY 						= CreateClientConVar( "perp2_azerty", "0", true, false )
GM.Options_CasinoRadio					= CreateClientConVar( "perp2_casinoradio", "1", true, false) //not used
GM.Options_ShowSprays					= CreateClientConVar( "perp2_showsprays", "1", true, false)
GM.Options_ShowVCHelp					= CreateClientConVar( "perp2_vchelp", "1", true, false)
GM.Options_AdvancedLights				= CreateClientConVar( "perp2_emerglights", "0", true, false)
GM.Options_DynamicLights				= CreateClientConVar( "perp2_emerglightsdyn", "1", true, false) //not used anymore
GM.Options_NPCHelp						= CreateClientConVar( "perp2_shownpchelp", "1", true, false)
GM.Options_MultiCore					= CreateClientConVar( "perp2_multicore", "1", true, false)
GM.Options_UseBasicHUD					= CreateClientConVar( "perp_basic_hud", "0", false, false)
GM.Options_AdminAutoInvis				= CreateClientConVar( "perp_admin_autoinvis", "0", false, true)
GM.Options_SafeZone						= CreateClientConVar( "perp_hud_safezone", "25", true, false, "the safezone border around the HUD", 1,100)
GM.Options_ShowAFK						= CreateClientConVar( "perp_show_afk", "1", false, true)
--GM.DynLight								= GetConVar("VC_DynamicLights"):GetInt()

hook.Add("PlayerNoClip", "AskForInvisOnNoClip", function(ply,desiredState)
	if GAMEMODE.Options_AdminAutoInvis:GetBool() then
		net.Start("RequestNoClipInvis")
			net.WriteBool(desiredState)
		net.SendToServer()
	else
		net.Start("RequestNoClipInvis")
			net.WriteBool(false)
		net.SendToServer()
	end
end)

function GM.GetPhoneKey()
	if GAMEMODE.Options_AZERTY:GetBool() then
		return KEY_L
	else
		return KEY_Z
	end
end

function GM.GetGUIAlpha()
	return math.Clamp( GAMEMODE.Options_GUIAlpha:GetInt(), 150, 255 )
end

function GM.GetHUDAlpha()
	return math.Clamp( GAMEMODE.Options_HUDAlpha:GetInt(), 0, 255 )
end

function GM.GetHUDColorR()
	return math.Clamp( GAMEMODE.Options_HUDColorR:GetInt(), 0, 255 )
end

function GM.GetHUDColorG()
	return math.Clamp( GAMEMODE.Options_HUDColorG:GetInt(), 0, 255 )
end

function GM.GetHUDColorB()
	return math.Clamp( GAMEMODE.Options_HUDColorB:GetInt(), 0, 255 )
end

function GM.GetInventoryAlpha()
	if GAMEMODE.Options_InventoryShouldUseGUIAlpha:GetBool() then
		return GAMEMODE.GetGUIAlpha()
	else
		return 255
	end
end

local LastGUIAlpha = 0
local LastHUDAlpha = 0
local LastInventoryAlpha = 0
local LastHUDColors = 0
hook.Add( "Think", "MonitorOptions", function()
	if LastGUIAlpha ~= GAMEMODE.GetGUIAlpha() then
		LastGUIAlpha = GAMEMODE.GetGUIAlpha()
		
		if IsValid( GAMEMODE.DialogPanel ) then
			GAMEMODE.DialogPanel:SetAlpha( LastGUIAlpha )
		end
		
		if IsValid( GAMEMODE.HelpPanel ) then
			GAMEMODE.HelpPanel:SetAlpha( LastGUIAlpha )
		end
	end
	
	local CurrentInventoryAlpha = GAMEMODE.GetInventoryAlpha()
	if CurrentInventoryAlpha ~= LastInventoryAlpha then
		LastInventoryAlpha = CurrentInventoryAlpha
		
		if IsValid( GAMEMODE.InventoryPanel ) then
			GAMEMODE.InventoryPanel:SetAlpha( CurrentInventoryAlpha )
		end
	end
	
	if LastHUDAlpha ~= GAMEMODE.GetHUDAlpha() then
		LastHUDAlpha = GAMEMODE.GetHUDAlpha()
		
		if IsValid( GAMEMODE.HUD ) then
			GAMEMODE.HUD:SetAlpha( LastHUDAlpha )
		end
	end
end )

function GM.LoadOptionsList( panelList )

	local hudSafeZone = vgui.Create("DNumSliderOld", panelList)
	hudSafeZone:SetText("HUD Safezone")
	hudSafeZone:SetMin(1)
	hudSafeZone:SetMax(100)
	hudSafeZone:SetConVar("perp_hud_safezone")
	hudSafeZone:SetValue(GAMEMODE.Options_SafeZone:GetInt())
	panelList:AddItem(hudSafeZone)

	local guiAlpha = vgui.Create("DNumSliderOld", panelList)
	guiAlpha:SetText("GUI Alpha")
	guiAlpha:SetMin(150)
	guiAlpha:SetMax(255)
	guiAlpha:SetConVar("perp2_gui_alpha")
	guiAlpha:SetValue(GAMEMODE.GetGUIAlpha())
	panelList:AddItem(guiAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Inventory should use GUI alpha? (Optional because it doesn't look as good as full alpha.)")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_InventoryShouldUseGUIAlpha:GetInt())
	inventoryUseAlpha:SetConVar("perp2_gui_inv_alpha")
	panelList:AddItem(inventoryUseAlpha)
	
	if LocalPlayer():IsAdmin() then
		local AutoInvis = vgui.Create("DCheckBoxLabel", panelList)
		AutoInvis:SetText("<Admin> Auto-Invis on noclip")
		AutoInvis:SetValue(GAMEMODE.Options_AdminAutoInvis:GetInt())
		AutoInvis:SetConVar("perp_admin_autoinvis")
		panelList:AddItem(AutoInvis)
	end

	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show OOC chat in chat box?")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowOOC:GetInt())
	inventoryUseAlpha:SetConVar("perp2_show_ooc")
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show indicator above your head while you type?")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowChatBubble:GetInt())
	inventoryUseAlpha:SetConVar("perp2_show_chat_bubble")
	panelList:AddItem(inventoryUseAlpha)

	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Draw HUD")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_DrawHUD:GetInt())
	inventoryUseAlpha:SetConVar("perp_draw_hud")
	panelList:AddItem(inventoryUseAlpha)

	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Draw Basic HUD")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_UseBasicHUD:GetInt())
	inventoryUseAlpha:SetConVar("perp_basic_hud")
	panelList:AddItem(inventoryUseAlpha)

	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show AFK Messages")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowAFK:GetInt())
	inventoryUseAlpha:SetConVar("perp_show_afk")
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show names above people, vehicles, and doors?")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowNames:GetInt())
	inventoryUseAlpha:SetConVar("perp2_show_names")
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show org sprays? (May prevent FPS lag)")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowSprays:GetInt())
	inventoryUseAlpha:SetConVar("perp2_showsprays")
	panelList:AddItem(inventoryUseAlpha)

	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Use metric system? (KPH and Celsius)")
	inventoryUseAlpha:SetValue(1)
	inventoryUseAlpha:SetConVar("perp2_euro")
	panelList:AddItem(inventoryUseAlpha)

	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Use sun beams? (Recommended)")
	inventoryUseAlpha:SetConVar("pp_sunbeams")
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Remove smoke from fires?")
	inventoryUseAlpha:SetConVar("perp2_firesmoke_disable")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_DisableFireSmoke:GetInt())
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show payday notices?")
	inventoryUseAlpha:SetConVar("perp2_payday_info")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowPaydayInfo:GetInt())
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Mute heavy breathing?")
	inventoryUseAlpha:SetConVar("perp2_mute_local_breath")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_MuteLocalBreath:GetInt())
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("AZERT Keyboard? (Changes the phone key from Z to L)")
	inventoryUseAlpha:SetConVar("perp2_azerty")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_AZERTY:GetInt())
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Show vehicle help information? (Notification when you get into a vehicle)")
	inventoryUseAlpha:SetConVar("perp2_vchelp")
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowVCHelp:GetInt())
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Turn off the interaction prompt while looking at usable NPCs")
	inventoryUseAlpha:SetConVar("perp2_shownpchelp")
	inventoryUseAlpha:SetValue(1)
	panelList:AddItem(inventoryUseAlpha)
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList)
	inventoryUseAlpha:SetText("Enable multicore rendering (FPS Boost) (Will ONLY apply on login)")
	inventoryUseAlpha:SetConVar("perp2_multicore")
	inventoryUseAlpha:SetValue(1)
	panelList:AddItem(inventoryUseAlpha)
end