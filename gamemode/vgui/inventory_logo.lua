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
--local unOccupied = Material("paris/predatorinventory.png")
local unOccupied = Material("paris/asocinventory.png")
--local unOccupied = surface.GetTextureID("pulsareffect/inventory/inv_logo_vg")
--local unOccupied = surface.GetTextureID("perp2/inventory/inv_background_voltage")
--local unOccupied = surface.GetTextureID("pulsareffect/inventory/inv_logo")

function PANEL:Init ( )
	self:SetVisible(true)

	self.NextChangeVisi = CurTime()
	self.ourAlpha = 255

	self.ModelPanel = vgui.Create('DModelPanel', self)
	--[[self.ModelPanel:SetFOV(40)
	self.ModelPanel:SetCamPos(Vector(130, 0, 52))
	self.ModelPanel:SetLookAt(Vector(0,0,52))]]
	--[[local ply = LocalPlayer()
	self.ModelPanel:SetModel(ply:GetModel())
	--self.ModelPanel:SetModel("models/player/mossman.mdl")
	--self.ModelPanel:SetEntity(ply)
	self.ModelPanel:SetAnimated(true)
	self.ModelPanel:GetEntity():SetSequence(10)
	self.ModelPanel:GetEntity().AutomaticFrameAdvance = true
	function self.ModelPanel:LayoutEntity( Entity )
		if ( self.bAnimated ) then
			self:RunAnimation()
		end
		Entity:SetSequence(ply:GetSequenceName(ply:GetSequence()))
		if Entity:GetModel() != ply:GetModel() then Entity:SetModel(ply:GetModel()) end
		for k,v in pairs(Entity:GetBodyGroups()) do 
			if Entity:GetBodygroup(k) != ply:GetBodygroup(k) then
				Entity:SetBodygroup(k,ply:GetBodygroup(k))
			end
		end
		if Entity:GetSkin() != ply:GetSkin() then Entity:SetSkin(ply:GetSkin()) end
	end]]
end

function PANEL:PerformLayout ( )
	if IsValid(self.ModelPanel) then
		self.ModelPanel:SetSize(self:GetSize())
		self.ModelPanel:SetPos(0,0)
	end
end

function PANEL:Paint( w, h )
	--[[local eyepos = self.ModelPanel.Entity:GetBonePosition(self.ModelPanel.Entity:LookupBone("ValveBiped.Bip01_Head1") or 1)
	self.ModelPanel:SetLookAt(eyepos+Vector(0, 0, -10))
	self.ModelPanel:SetCamPos(eyepos+Vector(130, 0, -10))]]
	if (self.NextChangeVisi <= CurTime()) then
		self.NextChangeVisi = CurTime() + (1 / 200)

		if (self.itemTable) then
			self.ourAlpha =  math.Clamp(self.ourAlpha - (transitionSpeed * .2), 200, 255)
		else
			self.ourAlpha =  math.Clamp(self.ourAlpha + (transitionSpeed * .2), 200, 255)
		end
	end

	surface.SetMaterial(unOccupied)
	local oa = math.Clamp(self.ourAlpha, 200, 255)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())

	surface.SetDrawColor(255, 255, 255, oa)
	surface.DrawTexturedRect(1, self:GetTall()*0.25, self:GetWide() - 2, self:GetTall()*0.5 - 2)
end

function PANEL:SetDisplay ( itemTable )
	self.itemTable = itemTable

	if (self.itemTable) then
		if self.ModelPanel then
			self.ModelPanel:Remove()
			self.ModelPanel = nil
		end

		self.ModelPanel = vgui.Create("DModelPanel", self)
		function self.ModelPanel:LayoutEntity ( ) end

		self.ModelPanel:SetPos(3, 3)
		self.ModelPanel:SetSize(self:GetWide() - 6, self:GetTall() - 6)

		self.ModelPanel:SetModel(self.itemTable.InventoryModel)

		self.ModelPanel:SetCamPos(self.itemTable.ModelCamPos)
		self.ModelPanel:SetLookAt(self.itemTable.ModelLookAt)
		self.ModelPanel:SetFOV(self.itemTable.ModelFOV)

		if(self.ModelPanel.Entity) then
			local iSeq = self.ModelPanel.Entity:LookupSequence('ragdoll')
			self.ModelPanel.Entity:ResetSequence(iSeq)
		end
	elseif (self.ModelPanel) then
		self.ModelPanel:Remove()
		self.ModelPanel = nil
	end
end

vgui.Register("perp2_inventory_logo", PANEL)
