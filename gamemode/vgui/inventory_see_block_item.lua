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
	self:SetVisible(true)
	self.ModelPanel = vgui.Create("DModelPanel", self)
	
	function self.ModelPanel:LayoutEntity ( ) end
	function self.ModelPanel.OnMousePressed ( _, mc ) self:OnMousePressed(mc) end
	function self.ModelPanel.OnMouseReleased ( _, mc ) self:OnMouseReleased(mc) end
	
	self.DownTime = 0
end

function PANEL:PerformLayout ( )
	self.ModelPanel:InvalidateLayout()
	
	self.ModelPanel:SetPos(3, 3)
	self.ModelPanel:SetSize(self:GetWide() - 6, self:GetTall() - 6)
end

function PANEL:SetItemTable ( itemTable )	
	self.itemTable = itemTable
	
	self.ModelPanel:SetModel(itemTable.InventoryModel)
	
	self.ModelPanel:SetCamPos(itemTable.ModelCamPos)
	self.ModelPanel:SetLookAt(itemTable.ModelLookAt)
	self.ModelPanel:SetFOV(itemTable.ModelFOV)
	
	local iSeq = self.ModelPanel.Entity:LookupSequence('ragdoll')
	self.ModelPanel.Entity:ResetSequence(iSeq)
end

function PANEL:Think ( )
	if(self.ModelPanel and GAMEMODE.InventoryPanel) then
		self.ModelPanel:SetVisible(GAMEMODE.InventoryPanel.ButtonOpen == "inventory")
	end
	
	if (self.mouseDown) then
		if (!input.IsMouseDown(self.mouseCode)) then
			self:OnMouseReleased(MOUSE_LEFT)
			return
		end
		
		local mx, my = gui.MousePos()
		self:SetPos(mx + self.InitialOffset_X, my + self.InitialOffset_Y)
	end
end

local OnPress = Sound("UI/buttonclick.wav")
function PANEL:OnMousePressed ( MouseCode )	
	if (MouseCode == MOUSE_LEFT) then
		--surface.PlaySound(OnPress)
		
		self.mouseCode = MouseCode
		self.mouseDown = true
		
		local mx, my = gui.MousePos()
		local ox, oy = self:GetPos()
		
		self.InitialOffset_X, self.InitialOffset_Y = ox - mx, oy - my
		self.InitialPos_X, self.InitialPos_Y = self:GetPos()
		
		self.ModelPanel:MoveToFront()
		
		self.trueParent:SetSuperGlow(true)
		
		GAMEMODE.DraggingSomething = self
		
		if (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_MAIN) then
			--self:GetParent().MainWeaponEquip:SetSuperGlow(true)
		elseif (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_SIDE) then
			--self:GetParent().SideWeaponEquip:SetSuperGlow(true)
		end
		
		self.DownTime = CurTime()
	elseif (MouseCode == MOUSE_RIGHT) then
		--GAMEMODE.DropItem(self.trueParent.itemID)
	end
end

function PANEL:OnMouseReleased( MouseCode )
	if (MouseCode == MOUSE_LEFT) then
		self.mouseDown = nil
		
		if (self.InitialPos_X) then self:SetPos(self.InitialPos_X, self.InitialPos_Y) end
		self.trueParent:SetSuperGlow(false)
		
		GAMEMODE.DraggingSomething = nil
		
		if (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_MAIN) then
			--self:GetParent().MainWeaponEquip:SetSuperGlow(false)
		elseif (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_SIDE) then
			--self:GetParent().SideWeaponEquip:SetSuperGlow(false)
		end
		
		local realSlot, slotType = self:GetParent():GetHoveredItemSlot()
		
		if (CurTime() - self.DownTime < 1 and realSlot == self.trueParent) then
			--GAMEMODE.UseItem(self.trueParent.itemID)
		else
			if (realSlot and self.trueParent.itemID ~= realSlot.itemID) then
				if slotType == "other" then
					LocalPlayer():InvSeeSwapItemPosition(self.trueParent.itemID, realSlot.itemID, self.trueParent.InvType, realSlot.InvType, self:GetParent().OtherSteamID, self:GetParent().OtherInvItems )
				else
					LocalPlayer():InvSeeSwapItemPosition(self.trueParent.itemID, realSlot.itemID, self.trueParent.InvType, realSlot.InvType, self:GetParent().OtherSteamID, self:GetParent().OtherInvItems )
				end
			end
		end
	end
end

vgui.Register("perp2_inventory_see_block_item", PANEL)

















-- The other player


local PANEL = {}

function PANEL:Init ( )
	self:SetVisible(true)
	self.ModelPanel = vgui.Create("DModelPanel", self)
	
	function self.ModelPanel:LayoutEntity ( ) end
	function self.ModelPanel.OnMousePressed ( _, mc ) self:OnMousePressed(mc) end
	function self.ModelPanel.OnMouseReleased ( _, mc ) self:OnMouseReleased(mc) end
	
	self.DownTime = 0
end

function PANEL:PerformLayout ( )
	self.ModelPanel:InvalidateLayout()
	
	self.ModelPanel:SetPos(3, 3)
	self.ModelPanel:SetSize(self:GetWide() - 6, self:GetTall() - 6)
end

function PANEL:SetItemTable ( itemTable )	
	self.itemTable = itemTable
	
	self.ModelPanel:SetModel(itemTable.InventoryModel)
	
	self.ModelPanel:SetCamPos(itemTable.ModelCamPos)
	self.ModelPanel:SetLookAt(itemTable.ModelLookAt)
	self.ModelPanel:SetFOV(itemTable.ModelFOV)
	
	local iSeq = self.ModelPanel.Entity:LookupSequence('ragdoll')
	self.ModelPanel.Entity:ResetSequence(iSeq)
end

function PANEL:Think ( )
	if(self.ModelPanel and GAMEMODE.InventoryPanel) then
		self.ModelPanel:SetVisible(GAMEMODE.InventoryPanel.ButtonOpen == "inventory")
	end
	
	if (self.mouseDown) then
		if (!input.IsMouseDown(self.mouseCode)) then
			self:OnMouseReleased(MOUSE_LEFT)
			return
		end
		
		local mx, my = gui.MousePos()
		self:SetPos(mx + self.InitialOffset_X, my + self.InitialOffset_Y)
	end
end

local OnPress = Sound("UI/buttonclick.wav")
function PANEL:OnMousePressed ( MouseCode )	
	if (MouseCode == MOUSE_LEFT) then
		--surface.PlaySound(OnPress)
		
		self.mouseCode = MouseCode
		self.mouseDown = true
		
		local mx, my = gui.MousePos()
		local ox, oy = self:GetPos()
		
		self.InitialOffset_X, self.InitialOffset_Y = ox - mx, oy - my
		self.InitialPos_X, self.InitialPos_Y = self:GetPos()
		
		self.ModelPanel:MoveToFront()
		
		self.trueParent:SetSuperGlow(true)
		
		GAMEMODE.DraggingSomething = self
		
		if (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_MAIN) then
			--self:GetParent().MainWeaponEquip:SetSuperGlow(true)
		elseif (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_SIDE) then
			--self:GetParent().SideWeaponEquip:SetSuperGlow(true)
		end
		
		self.DownTime = CurTime()
	elseif (MouseCode == MOUSE_RIGHT) then
		--GAMEMODE.DropItem(self.trueParent.itemID)
	end
end

function PANEL:OnMouseReleased( MouseCode )
	if (MouseCode == MOUSE_LEFT) then
		self.mouseDown = nil
		
		if (self.InitialPos_X) then self:SetPos(self.InitialPos_X, self.InitialPos_Y) end
		self.trueParent:SetSuperGlow(false)
		
		GAMEMODE.DraggingSomething = nil
		
		if (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_MAIN) then
			--self:GetParent().MainWeaponEquip:SetSuperGlow(false)
		elseif (self.itemTable.EquipZone and self.itemTable.EquipZone == EQUIP_WEAPON_SIDE) then
			--self:GetParent().SideWeaponEquip:SetSuperGlow(false)
		end
		
		local realSlot, slotType = self:GetParent():GetHoveredItemSlot()
		
		if (CurTime() - self.DownTime < 1 and realSlot == self.trueParent) then
			--GAMEMODE.UseItem(self.trueParent.itemID)
		else
			if (realSlot and self.trueParent.itemID ~= realSlot.itemID) then
				if slotType == "other" then
					LocalPlayer():InvSeeSwapItemPosition(self.trueParent.itemID, realSlot.itemID, self.trueParent.InvType, realSlot.InvType, self:GetParent().OtherSteamID,self:GetParent().OtherInvItems)
				else
					LocalPlayer():InvSeeSwapItemPosition(self.trueParent.itemID, realSlot.itemID, self.trueParent.InvType, realSlot.InvType, self:GetParent().OtherSteamID,self:GetParent().OtherInvItems)
				end
			end
		end
	end
end

vgui.Register("perp2_inventory_seeother_block_item", PANEL)