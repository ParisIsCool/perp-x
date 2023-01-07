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

local highestAlpha = 230
local lowestAlpha = 170

local unOccupied = surface.GetTextureID("perp2/inventory/inv_empty")

function PANEL:Init ( )
	self:SetVisible(true)
	self.NextChangeVisi = CurTime()
	self.ourAlpha = 230
	self.InvType = "local"
end

function PANEL:PerformLayout ( )
end

function PANEL:Think ( )
	local cursorIn = false
	local cx, cy = self:CursorPos()
	
	if (cx > 0 and cy > 0 and cx < self:GetWide() and cy < self:GetTall()) then
		cursorIn = true
	end
		
	if (cursorIn and !self.cursorIn) then
		self:OnCursorEntered_Real()
	elseif (!cursorIn and self.cursorIn) then
		self:OnCursorExited_Real()
	end
	
	if (self.NextChangeVisi <= CurTime()) then
		self.NextChangeVisi = CurTime() + (1 / 200)
		
		if ((self.cursorIn or self.SuperGlow) and self.ourAlpha > lowestAlpha) then
			self.ourAlpha = self.ourAlpha - 1
		elseif (!self.cursorIn and !self.SuperGlow and self.ourAlpha < highestAlpha) then
			self.ourAlpha = self.ourAlpha + 1
		end
	end
end

function PANEL:Paint( w, h )
	surface.SetTexture(unOccupied)
	
	local trueAlpha = self.ourAlpha
	if (self.SuperGlow) then
		trueAlpha = trueAlpha - (10 + math.sin(CurTime() * 4) * 40)
	end
	
	if (self.actualItem) then
		draw.SimpleText(self.actualItem.Quantity, "Default", 3, 1, Color(255, 255, 255, 255), 0, 0)
	end

	surface.SetDrawColor(0, 0, 0, trueAlpha)
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	
	if (self.IsShop and self.itemTable and self.itemTable.RestrictedSelling) then
		surface.SetDrawColor(255, 100, 100, trueAlpha)
	elseif (self.SelectedForTrade) then
		surface.SetDrawColor(170 + math.sin(CurTime() * 4) * 40, 170 + math.sin(CurTime() * 4) * 40, 255, trueAlpha)
	else
		surface.SetDrawColor(255, 255, 255, trueAlpha)
	end
	
	surface.DrawTexturedRect(1, 1, self:GetWide() - 2, self:GetTall() - 2)
end

function PANEL:SetCoordinates ( x, y )
	self.XPos = x
	self.YPos = y
	self.itemID = 2 + (y - 1) * INVENTORY_WIDTH + x
end

function PANEL:OnCursorEntered_Real ( )
	self.cursorIn = true
	
	if self.SuperGlow then return false end
	
	if (self:GetParent().Description and self.itemTable) then
		self:GetParent():SetDescription(self.itemTable)
	end
end

function PANEL:OnCursorExited_Real ( )
	self.cursorIn = false
	
	if (self:GetParent().Description) then
		self:GetParent():SetDescription(nil)
	end
end

function PANEL:GrabItem ( )
	if (GAMEMODE.PlayerItems[self.itemID]) then
		self.itemTable = ITEM_DATABASE[ GAMEMODE.PlayerItems[ self.itemID ].ID ]
		self.actualItem = GAMEMODE.PlayerItems[self.itemID]
		if not self.itemTable then return end
		
		if (!self.ModelPanel) then
			self.ModelPanel = vgui.Create('perp2_inventory_see_block_item', self:GetParent())
		end
		
		local x, y = self:GetPos()
		self.ModelPanel:SetPos(x + 1, y + 1)
		self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2)
		self.ModelPanel:SetItemTable(self.itemTable)
		self.ModelPanel.trueParent = self
	else
		self.itemTable = nil
		self.actualItem = nil
		
		if (self.ModelPanel) then
			self.ModelPanel:Remove()
			self.ModelPanel = nil
		end
	end
end

function PANEL:SetSuperGlow ( tf )
	self.SuperGlow = tf
end

vgui.Register("perp2_inventory_see_block", PANEL)











-- The other player


local PANEL = {}

local highestAlpha = 230
local lowestAlpha = 170

local unOccupied = surface.GetTextureID("perp2/inventory/inv_empty")

function PANEL:Init ( )
	self:SetVisible(true)
	self.NextChangeVisi = CurTime()
	self.ourAlpha = 230
	self.InvType = "other"
end

function PANEL:PerformLayout ( )
end

function PANEL:Think ( )
	local cursorIn = false
	local cx, cy = self:CursorPos()
	
	if (cx > 0 and cy > 0 and cx < self:GetWide() and cy < self:GetTall()) then
		cursorIn = true
	end
		
	if (cursorIn and !self.cursorIn) then
		self:OnCursorEntered_Real()
	elseif (!cursorIn and self.cursorIn) then
		self:OnCursorExited_Real()
	end
	
	if (self.NextChangeVisi <= CurTime()) then
		self.NextChangeVisi = CurTime() + (1 / 200)
		
		if ((self.cursorIn or self.SuperGlow) and self.ourAlpha > lowestAlpha) then
			self.ourAlpha = self.ourAlpha - 1
		elseif (!self.cursorIn and !self.SuperGlow and self.ourAlpha < highestAlpha) then
			self.ourAlpha = self.ourAlpha + 1
		end
	end
end

function PANEL:Paint( w, h )
	surface.SetTexture(unOccupied)
	
	local trueAlpha = self.ourAlpha
	if (self.SuperGlow) then
		trueAlpha = trueAlpha - (10 + math.sin(CurTime() * 4) * 40)
	end
	
	if (self.actualItem) then
		draw.SimpleText(self.actualItem.Quantity, "Default", 3, 1, Color(255, 255, 255, 255), 0, 0)
	end

	surface.SetDrawColor(0, 0, 0, trueAlpha)
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	
	if (self.IsShop and self.itemTable and self.itemTable.RestrictedSelling) then
		surface.SetDrawColor(255, 100, 100, trueAlpha)
	elseif (self.SelectedForTrade) then
		surface.SetDrawColor(170 + math.sin(CurTime() * 4) * 40, 170 + math.sin(CurTime() * 4) * 40, 255, trueAlpha)
	else
		surface.SetDrawColor(255, 255, 255, trueAlpha)
	end
	
	surface.DrawTexturedRect(1, 1, self:GetWide() - 2, self:GetTall() - 2)
end

function PANEL:SetCoordinates ( x, y )
	self.XPos = x
	self.YPos = y
	self.itemID = 2 + (y - 1) * INVENTORY_WIDTH + x
end

function PANEL:OnCursorEntered_Real ( )
	self.cursorIn = true
	
	if self.SuperGlow then return false end
	
	if (self:GetParent().Description and self.itemTable) then
		self:GetParent():SetDescription(self.itemTable)
	end
end

function PANEL:OnCursorExited_Real ( )
	self.cursorIn = false
	
	if (self:GetParent().Description) then
		self:GetParent():SetDescription(nil)
	end
end

function PANEL:GrabItem ( )
	if (self:GetParent().OtherInvItems[self.itemID]) then
		self.itemTable = ITEM_DATABASE[ self:GetParent().OtherInvItems[ self.itemID ].ID ]
		self.actualItem = self:GetParent().OtherInvItems[self.itemID]
		if not self.itemTable then return end
		
		if (!self.ModelPanel) then
			self.ModelPanel = vgui.Create('perp2_inventory_seeother_block_item', self:GetParent())
		end
		
		local x, y = self:GetPos()
		self.ModelPanel:SetPos(x + 1, y + 1)
		self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2)
		self.ModelPanel:SetItemTable(self.itemTable)
		self.ModelPanel.trueParent = self
	else
		self.itemTable = nil
		self.actualItem = nil
		
		if (self.ModelPanel) then
			self.ModelPanel:Remove()
			self.ModelPanel = nil
		end
	end
end

function PANEL:SetSuperGlow ( tf )
	self.SuperGlow = tf
end

vgui.Register("perp2_inventory_seeother_block", PANEL)