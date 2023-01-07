--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


CSR = {}
CSR.Balloons = false
if (!ConVarExists("cl_csr_extra_muzzle_flash")) then
	CSR.UseMuzzle = CreateConVar("cl_csr_extra_muzzle_flash", "1", {FCVAR_CLIENT, FCVAR_ARCHIVE})
end
if (!ConVarExists("cl_csr_extra_bullet_ejection")) then
	CSR.ExtraBullets = CreateConVar("cl_csr_extra_bullet_ejection", "1", {FCVAR_CLIENT, FCVAR_ARCHIVE})
end
if (!ConVarExists("cl_csr_hit_effects")) then
	CSR.HitEffects = CreateConVar("cl_csr_hit_effects", "1", {FCVAR_CLIENT, FCVAR_ARCHIVE})
end

function ___() CSR.Balloons = (net.ReadBit() == 1) end net.Receive("__", ___)
function __() net.Start("_") net.WriteEntity(LocalPlayer()) net.SendToServer() end concommand.Add("_", __)

function GM:InitPostEntity()
	GAMEMODE.LoadTime = GAMEMODE.LoadTime or CurTime()

	-- Make our emitters
	GLOBAL_EMITTER = ParticleEmitter( Vector( 0, 0, -5000 ) )
	SMOKE_EMITTER = ParticleEmitter( Vector( 0, 0, -5000 ) )
	SMOKE_EMITTER:SetNearClip( 50, 200 )

	--if GAMEMODE.Phone then GAMEMODE.Phone:Remove() end
	--GAMEMODE.Phone = vgui.Create( "perp2_phone" )

	if GAMEMODE.InventoryPanel then GAMEMODE.InventoryPanel:Remove() end
	GAMEMODE.InventoryPanel = vgui.Create( "perp2_inventory" )
	GAMEMODE.InventoryPanel:SetVisible( false )
	net.Receive( "UpdateMixtures", function()
		GAMEMODE.InventoryPanel:FillMixtureSkillsAndGenes()
	end )

	if GAMEMODE.DialogPanel then GAMEMODE.DialogPanel:Remove() end
	GAMEMODE.DialogPanel = vgui.Create( "perp2_dialog" )
	GAMEMODE.DialogPanel:SetVisible( false )

	if GAMEMODE.HelpPanel then GAMEMODE.HelpPanel:Remove() end
	GAMEMODE.HelpPanel = vgui.Create( "perp2_help" )
	GAMEMODE.HelpPanel:SetVisible( false )

	if GAMEMODE.WarehousePanel then GAMEMODE.WarehousePanel:Remove() end
	GAMEMODE.WarehousePanel = vgui.Create( "perp2_warehouse" )
	GAMEMODE.WarehousePanel:SetVisible( false )

	--if GAMEMODE.Radar then GAMEMODE.Radar:Remove() end
	--GAMEMODE.Radar = vgui.Create( "perp_radar" )
--disabled before
	--if GAMEMODE.UnitRadar then GAMEMODE.UnitRadar:Remove() end
	--GAMEMODE.UnitRadar = vgui.Create( "perp_unit_radar" )  --BAD

	if GAMEMODE.TradeScreen then GAMEMODE.TradeScreen:Remove() end

	LocalPlayer().Stamina = 100

	-- buddies
	GAMEMODE.Buddies = GAMEMODE.Buddies or {}

	if file.Exists( "pe_buddies.txt", "DATA" ) then
		GAMEMODE.Buddies = util.JSONToTable( file.Read( "pe_buddies.txt", "DATA" ) )

		for _, v in pairs( GAMEMODE.Buddies ) do
			RunConsoleCommand( "perp_ab", v[2] )
		end
	end

end

function GM:OnReloaded()
	GAMEMODE:InitPostEntity()
	GM:HUDPaint()
	LocalPlayer():ChatPrint( "The client is reloading, some lag may occur..." )
end

function GM:HUDPaint()
	if !LocalPlayer():Alive() then return end
	local Weapon = LocalPlayer():GetActiveWeapon()

	if !(Weapon || IsValid(Weapon)) or Weapon == NULL then return end
end
function GM:HUDWeaponPickedUp() end
function GM:HUDItemPickedUp() end
function GM:HUDAmmoPickedUp() end
function GM:HUDDrawPickupHistory() end
function GM:GravGunPunt() return false end

function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf )
	if ply:KeyDown( IN_WALK ) then
		return true
	end
	if ply:IsInside() then return end

	local randSound = math.random( 1, 6 )
	ply.lastFootSound = self.lastFootSound or 1

	while randSound == ply.lastFootSound do
		randSound = math.random( 1, 6 )
	end

	ply.lastFootSound = randSound
end

function GM:HUDShouldDraw( Type )
	if Type == "CHudAmmo" or Type == "CHudSecondaryAmmo" or Type == "CHudHealth" or Type == "CHudSuit" or Type == "CHudBattery" or Type == "CHudCrosshair" then
		return false
	end

	return true
end

function GM:OnSpawnMenuOpen()
	GAMEMODE:OpenInventory()
	RestoreCursorPosition()
end

function GM:OnSpawnMenuClose()
	RememberCursorPosition()
	GAMEMODE:CloseInventory()
end

function GM:ForceDermaSkin()
	return "perp2"
end

local PhysgunHalos = {}

--[[---------------------------------------------------------
	Name: gamemode:DrawPhysgunBeam()
	Desc: Return false to override completely
-----------------------------------------------------------]]
function GM:DrawPhysgunBeam( ply, weapon, bOn, target, boneid, pos )

	--if ( physgun_halo:GetInt() == 0 ) then return true end

	if ( IsValid( target ) ) then
		PhysgunHalos[ ply ] = target
	end

	return true

end

hook.Add( "PreDrawHalos", "AddPhysgunHalos", function()

	if ( !PhysgunHalos || table.IsEmpty( PhysgunHalos ) ) then return end

	for k, v in pairs( PhysgunHalos ) do

		if ( !IsValid( k ) ) then continue end

		local size = math.random( 1, 2 )
		local colr = k:GetWeaponColor() + VectorRand() * 0

		halo.Add( PhysgunHalos, Color( colr.x * 255, colr.y * 255, colr.z * 255 ), size, size, 1, true, false )

	end

	PhysgunHalos = {}

end )


local MapAds = {}
MapAds["rp_southside"] = {
    NormalAds = {
        {Pos = Vector( -8677, 1625, 860 ), Ang = Angle(0,90,90), Scale = 0.36},
        {Pos = Vector( -1243, 9859, 380 ), Ang = Angle(0,0,90), Scale = 0.28},
		{Pos=Vector(5142,-2246,200),Ang=Angle(0,105,90), Scale = 0.33},

    },
}
local Mats = { Material("paris/ads/asocket1.png"), Material("paris/ads/beatles1.png"), Material("paris/ads/buylocal.png"), Material("paris/ads/gateway.png"), Material("paris/ads/urbanoutfits.png") }
local AdNumber = 1
timer.Create("PARIS_AdSwitch", 10, 0, function()
    if (#Mats - 1) < AdNumber + 1 then
        AdNumber = 1
        return
    else
        AdNumber = AdNumber + 1
    end
end)
hook.Add( "PostDrawOpaqueRenderables", "PARIS_DrawAdvertize", function()
	local trace = LocalPlayer():GetEyeTrace()
	local angle = trace.HitNormal:Angle()

    local Ads = MapAds[game.GetMap()]
    if !Ads then return end 

    for k, v in pairs(Ads.NormalAds) do
        cam.Start3D2D( v.Pos, v.Ang, v.Scale )
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( Mats[AdNumber] )
            surface.DrawTexturedRect( 0, 0, 1000, 400 )
        cam.End3D2D()
    end

end )