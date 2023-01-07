--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local PANEL = {}
local PlayerVoicePanels = {}

function PANEL:Init()
	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 8, 0, 0, 0 )
	self.LabelName:SetTextColor( Color( 255, 255, 255, 255 ) )

	--self.ModelPanel = vgui.Create("DModelPanel", self )
	--self.ModelPanel:Dock( LEFT )
	--self.ModelPanel:SetSize( 32, 32 )
	//self.Avatar = vgui.Create( "AvatarImage", self )
	//self.Avatar:Dock( LEFT );
	//self.Avatar:SetSize( 32, 32 )

	self.Color = color_transparent

	self:SetSize( 250, 32 + 8 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( BOTTOM )
end

function PANEL:Setup( ply )
	self.ply = ply
	if LocalPlayer():IsAdmin() then
		self.LabelName:SetText( ply:GetRPName() .. ' [' .. ply:Nick() .. ']')
	else
		self.LabelName:SetText( ply:GetRPName() )
	end
	--[[self.ModelPanel:SetModel( ply:GetModel() )
	self.ModelPanel.Entity:SetSkin(ply:GetSkin())
	for k, v in pairs(ply:GetBodyGroups()) do
		self.ModelPanel.Entity:SetBodygroup(v.id,ply:GetBodygroup(v.id))
	end
	self.ModelPanel.Entity:SetRenderMode(2)
	self.ModelPanel.LayoutEntity = function(Entity) end
	self.ModelPanel:SetFOV(25)
	self.ModelPanel:SetCamPos(Vector(35, 0, 65))
	self.ModelPanel:SetLookAt(Vector(0,0,65))
	//self.Avatar:SetPlayer( ply )]]
	
	self.Color = team.GetColor( ply:Team() )
	
	self:InvalidateLayout()
end

local GradientRight = Material("paris/gradient_right.png")
local drawRoundedBox = draw.RoundedBox
function PANEL:Paint( w, h )
	if not IsValid( self.ply ) then return end
	--drawRoundedBox( 0, 0, 0, w, h, Color( 0, self.ply:VoiceVolume() * 255, 0, 240 ) )
	surface.SetDrawColor( 22, 22, 22, 255 )
	surface.SetMaterial( GradientRight )
	surface.DrawTexturedRect( 0, 0, w, h ) 

	surface.SetDrawColor( 201, 182, 112, 255 )
	surface.SetMaterial( GradientRight )
	surface.DrawTexturedRect( 0, 0, w, 1 ) 

	draw.RoundedBox( 0, 0, 0, 1, h, Color( 201, 182, 112, 255 ) )

	surface.SetDrawColor( 201, 182, 112, 255 )
	surface.SetMaterial( GradientRight )
	surface.DrawTexturedRect( 0, h-1, w, 1 ) 
end

function PANEL:Think()
	if self.fadeAnim then
		self.fadeAnim:Run()
	end
end

function PANEL:FadeOut( anim, delta, data )
	if anim.Finished then
		if IsValid( PlayerVoicePanels[ self.ply ] ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end

		return
	end
			
	self:SetAlpha( 255 - ( 255 * delta ) )
	// Player models look like shit with alpha turned down :(
	--self.ModelPanel:SetColor(Color(255, 255, 255, 255 - ( 255 * delta )))
end

derma.DefineControl( "VoiceNotify", "", PANEL, "DPanel" )

local static_Start = Sound( "PERP2.5/cradio_start.mp3" )
local static_Stop = Sound( "PERP2.5/cradio_close.mp3" )

hook.Add( "Think", "thinkRadioStatic", function()
	if GAMEMODE.PlayStatic then
		if not GAMEMODE.StaticNoise then
			GAMEMODE.StaticNoise = CreateSound( LocalPlayer(), Sound( "PERP2.5/cradio_static.mp3" ) )
		end
		
		if not GAMEMODE.NextStaticPlay or GAMEMODE.NextStaticPlay < CurTime() then
			GAMEMODE.NextStaticPlay = CurTime() + SoundDuration( "PERP2.5/cradio_static.mp3" ) - .1
			GAMEMODE.StaticNoise:Stop()
			GAMEMODE.StaticNoise:Play()
		end
	elseif GAMEMODE.NextStaticPlay then
		GAMEMODE.NextStaticPlay = nil
		GAMEMODE.StaticNoise:Stop()
	end
end )

function GM:PlayerStartVoice( ply ) 
	if ply:GetPos():Distance( LocalPlayer():GetPos() ) > ChatRadius_Local + 50 and ply:Team() ~= TEAM_CITIZEN and ply:Team() ~= TEAM_MAYOR and ply:GetRPName() ~= GAMEMODE.Call_Player then
		GAMEMODE.PlayStatic = true
		ply.PlayingStaticFor = true
		
		surface.PlaySound( static_Start )
	end

	if not IsValid( g_VoicePanelList ) then return end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )


	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return

	end

	if not IsValid( ply ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ ply ] = pnl
end
	
function GM:PlayerEndVoice( ply ) 
	if IsValid( PlayerVoicePanels[ ply ] ) then

		if PlayerVoicePanels[ ply ].fadeAnim then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 2 )

	end
	
	if ply.PlayingStaticFor then
		ply.PlayingStaticFor = nil
		surface.PlaySound( static_Stop )
	end
	
	if not GAMEMODE.PlayStatic then return end
	
	local shouldPlayStatic = false
	for k, v in pairs( player.GetAll() ) do
		if v.PlayingStaticFor then
			shouldPlayStatic = true
		end
	end
	
	GAMEMODE.PlayStatic = shouldPlayStatic
end

local function VoiceClean()
	for k, v in pairs( PlayerVoicePanels ) do
		if not IsValid( k ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	end
end

timer.Create( "VoiceClean", 10, 0, VoiceClean )

local function CreateVoiceVGUI()
	if IsValid( g_VoicePanelList ) then g_VoicePanelList:Remove() end
	g_VoicePanelList = vgui.Create( "DPanel" )

	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( ScrW() - 300, 100 )
	g_VoicePanelList:SetSize( 250, ScrH() - 320 )
	g_VoicePanelList:SetDrawBackground( false )
end

hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )