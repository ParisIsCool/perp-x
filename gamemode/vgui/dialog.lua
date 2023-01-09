--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

local PANEL = {}

function PANEL:Init ( )
	self.DialogButtons = {}
	self.DialogLabels = {}
	
	self.TextHolder = vgui.Create("DPanelList", self)
	self.TextHolder:EnableHorizontal(false)
	--self.TextHolder:EnableVerticalScrollbar(true)
	self.TextHolder:SetPadding(0)
	self.TextHolder:SetSpacing(-5)
	self.TextHolder:SetDrawBackground(false)
	
	self.DialogHolder = vgui.Create("DPanelList", self)
	self.DialogHolder:EnableHorizontal(false)
	self.DialogHolder:EnableVerticalScrollbar(true)
	self.DialogHolder:SetPadding(5)
	self.DialogHolder:SetSpacing(5)
	self.DialogHolder:SetDrawBackground(false)
	
	--self.FaceBackground = vgui.Create("DPanelList", self)
	
	self.ModelPanel = vgui.Create('DModelPanel', self)
	self.ModelPanel:SetFOV(40)
	self.ModelPanel:SetCamPos(Vector(40, 0, 62))
	self.ModelPanel:SetLookAt(Vector(0,0,62))
	function self.ModelPanel:LayoutEntity( Entity ) end
	
	self:SetAlpha(GAMEMODE.GetGUIAlpha())
end

function PANEL:PerformLayout ( )	
	surface.SetFont("default")
	_, self.TextHeight = surface.GetTextSize("blabla")

	local MaxW, MaxH = ScrW() * .4, ScrH() * .2
	self:SetPos(ScrW() * .5 - MaxW * .5, ScrH() - MaxH * 1.5)
	self:SetSize(MaxW, MaxH)
	
	--self.FaceBackground:SetPos(3, 3)
	--self.FaceBackground:SetSize(MaxH - 6, MaxH - 6)
	self.ModelPanel:SetPos(0, 0)
	self.ModelPanel:SetSize(MaxH, MaxH)

	self.DialogHolder:StretchToParent(MaxH, 6 + self.TextHeight * 4, 3, 3)
	self.TextHolder:SetPos(MaxH, 3)
	self.TextHolder:SetSize(self:GetWide() - 3 - MaxH, self.TextHeight * 4)
	
	for k, v in pairs(self.DialogLabels) do
		self.TextHolder:RemoveItem(v)
		v:Remove()
	end
	self.DialogLabels = {}
	
	if (self.Dialog) then
		local explodedResults = string.Explode("\n", self.Dialog)
			
		for k, v in pairs(explodedResults) do
			local splitResults = cutLength(v, self.TextHolder:GetWide() + 15, "Default")
				
			for _, txt in pairs(splitResults) do
				local newLabel = vgui.Create("DLabel", self.TextHolder)
				newLabel:SetText("  " .. txt)
				self.TextHolder:AddItem(newLabel)
				
				table.insert(self.DialogLabels, newLabel)
			end
		end
	end
end

local background = Material("paris/dialog3.png")
function PANEL:Paint( w, h )
	--derma.SkinHook( "Paint", "Frame", self, w, h ) 
	--[[draw.RoundedBox(0, 0, 0, w, h, Color(22,22,22,240))
	local bordercol = Color(0,0,0,100)
	draw.RoundedBox(0, 0, 0, w, 3, bordercol)
	draw.RoundedBox(0, 0, h-3, w, 3, bordercol)
	draw.RoundedBox(0, 0, 0, 3, h, bordercol)
	draw.RoundedBox(0, w-3, 0, 3, h, bordercol)]]
	self.Lerped = Lerp(FrameTime()*10,self.Lerped,1)
	surface.SetMaterial(background)
	surface.SetDrawColor(255,255,255,self.Lerped*255)
	DisableClipping(true)
	surface.DrawTexturedRect(w*-0.5,0,w*2,h)
	surface.SetDrawColor(255,255,255,self.Lerped*100)
	surface.DrawTexturedRect(w*-0.5,0,w*2,h)
	DisableClipping(false)
end

function PANEL:ClearDialog ( )
	for k, v in pairs(self.DialogButtons) do
		self.DialogHolder:RemoveItem(v)
		v:Remove()
	end
	
	self.DialogButtons = {}
end

function PANEL:AddDialog ( Text, DoAction )
	local newButton = vgui.Create("DButton", self)
	
	if DoAction == LEAVE_DIALOG then
		newButton:SetText(Text .. " <Leave>")
	else
		newButton:SetText(Text)
	end
	
	function newButton.DoClick ( )
		self:ClearDialog()
		DoAction()
	end

	--[[function newButton:Paint( )
		if self:IsHovered() then
			draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), Color(55,55,55,200))
			newButton:SetTextColor(Color(125, 227, 255))
		else
			draw.RoundedBox(5, 0, 0, self:GetWide(), self:GetTall(), Color(22,22,22,240))
			newButton:SetTextColor(Color(255,255,255))
		end
	end]]
	
	self.DialogHolder:AddItem(newButton)
	table.insert(self.DialogButtons, newButton)
end

function PANEL:AddPaintOption ( Text, Col, Col2, DoAction, Arg )
	local newButton = vgui.Create("perp2_vehicle_paint", self)

	newButton:DoSetup(Text, Col, Col2, DoAction, Arg)
	
	self.DialogHolder:AddItem(newButton)
	table.insert(self.DialogButtons, newButton)
end

function PANEL:SetDialog ( Text )
	self.Dialog = Text
	self:InvalidateLayout()
end

function PANEL:Show ( )
	--self.ModelPanel:SetLookAt(CAM_LOOK_AT[LocalPlayer():GetSex()])
	self.ModelPanel:SetModel(LocalPlayer():GetModel())
	self.ModelPanel.Entity:SetSkin(LocalPlayer():GetSkin())
	for k, v in pairs(LocalPlayer():GetBodyGroups()) do
		self.ModelPanel.Entity:SetBodygroup(v.id,LocalPlayer():GetBodygroup(v.id))
	end
	
	self:SetVisible(true)
	self:MakePopup()
	self.Lerped = 0
	function self.ModelPanel:DoClick()
		self.Entity:SetSequence("gesture_wave_original")
		--self.Entity:SetAngles(Angle(0,90,0))
		local sounds = {
			"vo/npc/%smale01/startle0%i.wav",
			"vo/npc/%smale01/startle0%i.wav",
			"vo/npc/%smale01/hi0%i.wav",
			"vo/npc/%smale01/hi0%i.wav",
		}
		if (LocalPlayer():GetSex() == SEX_FEMALE) then
			local r = math.random(1,#sounds)
			local s = string.format(sounds[r],"fe",math.random(1,2))
			self.Entity:EmitSound(s)
			LocalPlayer():EmitSound(s)
		else
			local r = math.random(1,#sounds)
			local s = string.format(sounds[r],"",math.random(1,2))
			self.Entity:EmitSound(s)
			LocalPlayer():EmitSound(s)
		end
		timer.Simple(0.2, function() self.Entity:SetSequence(2) end)
	end
end

function PANEL:Hide ( )
	self:SetVisible(false)
	self:ClearDialog()
end

vgui.Register("perp2_dialog", PANEL)