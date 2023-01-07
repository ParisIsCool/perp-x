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

surface.CreateFont( "InventorySeeFont", {
	font	= "Roboto Thin",
	size	= 20,
	weight	= 0
} )

function PANEL:Init ( )

	self.CloseButton = vgui.Create("DButton", self)
	self.CloseButton:SetText("Close")
	self.CloseButton.DoClick = function()
		self:Remove()
	end

	GAMEMODE.InventoryBlocksSee = {}
	GAMEMODE.InventoryBlocksSee_Linear = {}
	
	for x = 1, INVENTORY_WIDTH do
		GAMEMODE.InventoryBlocksSee[x] = {}
		
		for y = 1, INVENTORY_HEIGHT do
			GAMEMODE.InventoryBlocksSee[x][y] = vgui.Create("perp2_inventory_see_block", self)
			GAMEMODE.InventoryBlocksSee[x][y]:SetCoordinates(x, y)
			GAMEMODE.InventoryBlocksSee_Linear[GAMEMODE.InventoryBlocksSee[x][y].itemID] = GAMEMODE.InventoryBlocksSee[x][y]
		end
	end

	function self:InitOtherInventory(otherInv,steamid)
		GAMEMODE.InventoryBlocksSeeOther = {}
		GAMEMODE.InventoryBlocksSeeOther_Linear = {}
		self.OtherInvItems = otherInv
		
		for x = 1, INVENTORY_WIDTH do
			GAMEMODE.InventoryBlocksSeeOther[x] = {}
			
			for y = 1, INVENTORY_HEIGHT do
				GAMEMODE.InventoryBlocksSeeOther[x][y] = vgui.Create("perp2_inventory_seeother_block", self)
				GAMEMODE.InventoryBlocksSeeOther[x][y]:SetCoordinates(x, y)
				GAMEMODE.InventoryBlocksSeeOther_Linear[GAMEMODE.InventoryBlocksSeeOther[x][y].itemID] = GAMEMODE.InventoryBlocksSeeOther[x][y]
			end
		end
	end

	self.ChoosePlayer = vgui.Create("DPanel", self)
	self.ChoosePlayer.Paint = function(w,h)
		draw.RoundedBox(5, 0, 0, self.ChoosePlayer:GetWide(), self.ChoosePlayer:GetTall(), Color(66,66,66,200))
	end

	self.ChoosePlayer.ScrollPanel = vgui.Create("DScrollPanel", self.ChoosePlayer)
	self.ChoosePlayer.ScrollPanel.Paint = function(w,h)
		draw.RoundedBox(5, 0, 0, self.ChoosePlayer.ScrollPanel:GetWide(), self.ChoosePlayer.ScrollPanel:GetTall(), Color(66,66,66,200))
	end

	self.ChoosePlayer.layout = vgui.Create("DListLayout", self.ChoosePlayer.ScrollPanel)

	local GradientUp = Material( "gui/gradient_up" )

	self.ChoosePlayer.PlayerBlock = {}
	for k, v in pairs(player.GetHumans()) do
		self.ChoosePlayer.PlayerBlock[k] = vgui.Create("DButton", self.ChoosePlayer.layout)
		self.ChoosePlayer.PlayerBlock[k]:SetText("")
		self.ChoosePlayer.PlayerBlock[k].Paint = function()
			if self.ChoosePlayer.PlayerBlock[k]:IsHovered() then
				draw.RoundedBox(0, 0, 0, self.ChoosePlayer.PlayerBlock[k]:GetWide(), self.ChoosePlayer.PlayerBlock[k]:GetTall(), Color( 255, 255, 255, 20 * math.abs(math.sin(CurTime()*3)) ))
				draw.RoundedBox(0, 0, 0, self.ChoosePlayer.PlayerBlock[k]:GetWide(), self.ChoosePlayer.PlayerBlock[k]:GetTall(), Color( 30, 30, 30, 200 ))
			else
				draw.RoundedBox(0, 0, 0, self.ChoosePlayer.PlayerBlock[k]:GetWide(), self.ChoosePlayer.PlayerBlock[k]:GetTall(), Color( 30, 30, 30, 200 ))
			end
			surface.SetDrawColor( 20,20,20,200 )
			surface.SetMaterial( GradientUp )
			surface.DrawTexturedRect( 0, 0, self.ChoosePlayer.PlayerBlock[k]:GetWide(), self.ChoosePlayer.PlayerBlock[k]:GetTall() )

			draw.SimpleText("Name: " .. v:Nick() , "InventorySeeFont", 10, self.ChoosePlayer.PlayerBlock[k]:GetTall()/2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		self.ChoosePlayer.PlayerBlock[k].DoClick = function()
			self.ChoosePlayer:Hide()
			net.Start("perp_invsee_init")
			net.WriteString(v:SteamID())
			net.SendToServer()
			net.Receive("perp_invsee_init", function()
				local otherinv = net.ReadTable()
				local othersteamid = net.ReadString()
				if IsValid(self) and IsValid(player.GetBySteamID(othersteamid)) and istable(otherinv) then
					self:InitOtherInventory(otherinv, othersteamid)
					self.OtherSteamID = othersteamid
				end
			end)
			net.Receive("perp_invsee_update", function()
				if not IsValid(self) then return end
				local slot = net.ReadInt(16)
				local info = net.ReadTable()
				local type = net.ReadString()
				self:UpdateSlot(type, slot, info)
			end)
		end
	end
	
	--Bla
	self:SetAlpha(GAMEMODE.GetInventoryAlpha())
end

function PANEL:GetHoveredItemSlot ( )
	for k, v in pairs(GAMEMODE.InventoryBlocksSee_Linear) do
		if (v.cursorIn) then
			return v, "other"
		end
	end
	for k, v in pairs(GAMEMODE.InventoryBlocksSeeOther_Linear) do
		if (v.cursorIn) then
			return v, "local"
		end
	end
	
	return nil
end

function PANEL:PerformLayout ( )	
	local MaxW = ScrW() * .55
	local MaxH = (ScrW() * (10 / 16)) * .88
	self:SetPos((ScrW() * .5) - (MaxW * .5), (ScrH() * .5) - (MaxH * .5))
	self:SetSize(MaxW, MaxH)
	
	local bufferSize = 3
	local availableWidth = self:GetWide() - 2 - ((INVENTORY_WIDTH + 1) * bufferSize)
	local sizeOfBlock = availableWidth / INVENTORY_WIDTH
	
	for x = 1, INVENTORY_WIDTH do
		for y = 1, INVENTORY_HEIGHT do		
			local ox, oy = self:GetSize()
			GAMEMODE.InventoryBlocksSee[x][y]:SetPos(1 + (x * bufferSize) + ((x - 1) * sizeOfBlock), self:GetTall() - 1 - ((INVENTORY_HEIGHT - (y - 1)) * (bufferSize + sizeOfBlock)))
			GAMEMODE.InventoryBlocksSee[x][y]:SetSize(sizeOfBlock, sizeOfBlock)
			GAMEMODE.InventoryBlocksSee[x][y]:GrabItem()
		end
	end

	local size = (self:GetWide() - 1 - bufferSize * 3) * .5
	local w, h = (size - bufferSize) * .5, self:GetTall() - (2 + bufferSize * 2.5 + INVENTORY_HEIGHT * (bufferSize + sizeOfBlock) + size * .5)

	self.CloseButton:SetPos(5, bufferSize + 1)
	self.CloseButton:SetSize(self:GetWide()-5, h*0.08)

	self.ChoosePlayer:SetSize(self:GetWide()*0.8,self:GetTall()*0.45)
	self.ChoosePlayer:SetPos(self:GetWide()*0.1,self:GetTall()*0.05)

	self.ChoosePlayer.ScrollPanel:SetSize(self.ChoosePlayer:GetWide()*0.9,self.ChoosePlayer:GetTall()*0.9)
	self.ChoosePlayer.ScrollPanel:SetPos(self.ChoosePlayer:GetWide()*0.05,self.ChoosePlayer:GetTall()*0.05)

	self.ChoosePlayer.layout:SetSize(self.ChoosePlayer.ScrollPanel:GetWide(), self.ChoosePlayer.ScrollPanel:GetTall() / 10)
	self.ChoosePlayer.layout:SetPos(0, 0)

	for k, v in pairs(self.ChoosePlayer.PlayerBlock) do
		v:SetSize(self.ChoosePlayer.layout:GetWide(), self.ChoosePlayer.layout:GetTall())
	end
	

	for x = 1, INVENTORY_WIDTH do
		for y = 1, INVENTORY_HEIGHT do		
			local ox, oy = self:GetSize()
			if ( not GAMEMODE.InventoryBlocksSeeOther ) or ( not IsValid(GAMEMODE.InventoryBlocksSeeOther[x][y]) ) then break end
			GAMEMODE.InventoryBlocksSeeOther[x][y]:SetPos(1 + (x * bufferSize) + ((x - 1) * sizeOfBlock), self:GetTall() - ((INVENTORY_HEIGHT*sizeOfBlock) + ((INVENTORY_HEIGHT - (y - 2)) * (bufferSize + sizeOfBlock))))
			GAMEMODE.InventoryBlocksSeeOther[x][y]:SetSize(sizeOfBlock, sizeOfBlock)
			GAMEMODE.InventoryBlocksSeeOther[x][y]:GrabItem()
		end
	end

end

function PANEL:GetLocalBlockBySlot(slot)
	for x = 1, INVENTORY_WIDTH do
		for y = 1, INVENTORY_HEIGHT do		
			if ( not GAMEMODE.InventoryBlocksSee ) or ( not IsValid(GAMEMODE.InventoryBlocksSee[x][y]) ) then break end
			if GAMEMODE.InventoryBlocksSee[x][y].itemID == slot then return GAMEMODE.InventoryBlocksSee[x][y] end
		end
	end
end

function PANEL:GetOtherBlockBySlot(slot)
	for x = 1, INVENTORY_WIDTH do
		for y = 1, INVENTORY_HEIGHT do		
			if ( not GAMEMODE.InventoryBlocksSeeOther ) or ( not IsValid(GAMEMODE.InventoryBlocksSeeOther[x][y]) ) then break end
			if GAMEMODE.InventoryBlocksSeeOther[x][y].itemID == slot then 
				return GAMEMODE.InventoryBlocksSeeOther[x][y] 
			end
		end
	end
end

function PANEL:UpdateSlot(type, slot, info)
	if type == "other" then
		if info.ID then
			self.OtherInvItems[ slot ] = info
			if IsValid(self:GetOtherBlockBySlot(slot)) then
				self:GetOtherBlockBySlot(slot):GrabItem()
			end
		else
			self.OtherInvItems[ slot ] = nil
			if IsValid(self:GetOtherBlockBySlot(slot)) then
				self:GetOtherBlockBySlot(slot):GrabItem()
			end
		end
	else
		if info.ID then
			if IsValid(self:GetLocalBlockBySlot(slot)) then
				self:GetLocalBlockBySlot(slot):GrabItem()
			end
		else
			if IsValid(self:GetLocalBlockBySlot(slot)) then
				self:GetLocalBlockBySlot(slot):GrabItem()
			end
		end
	end
end

function PANEL:Paint( w, h )
	derma.SkinHook( "Paint", "Frame", self, w, h )
end

vgui.Register("perp2_invsee", PANEL)