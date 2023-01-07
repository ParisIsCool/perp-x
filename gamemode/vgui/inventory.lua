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
	GAMEMODE.InventoryBlocks = {}
	GAMEMODE.InventoryBlocks_Linear = {}
	
	for x = 1, INVENTORY_WIDTH do
		GAMEMODE.InventoryBlocks[x] = {}
		
		for y = 1, INVENTORY_HEIGHT do
			GAMEMODE.InventoryBlocks[x][y] = vgui.Create("perp2_inventory_block", self)
			GAMEMODE.InventoryBlocks[x][y]:SetCoordinates(x, y)
			GAMEMODE.InventoryBlocks_Linear[GAMEMODE.InventoryBlocks[x][y].itemID] = GAMEMODE.InventoryBlocks[x][y]
		end
	end
	
	self.ButtonOpen = "inventory"
	
	self.InventoryButton = vgui.Create("DButton", self)
	self.InventoryButton:SetText("Inventory")
	self.InventoryButton.DoClick = function()
		--Show inv
		self.Header:SetVisible(true)
		self.MainWeaponEquip:SetVisible(true)
		self.SideWeaponEquip:SetVisible(true)
		self.Description:SetVisible(true)
		for x = 1, INVENTORY_WIDTH do
			for y = 1, INVENTORY_HEIGHT do
				GAMEMODE.InventoryBlocks[x][y]:SetVisible(true)
				if(GAMEMODE.InventoryBlocks[x][y].ModelPanel) then
					GAMEMODE.InventoryBlocks[x][y].ModelPanel:SetVisible(true)
				end
			end
		end
		if(self.MainWeaponEquip.ModelPanel) then
			self.MainWeaponEquip.ModelPanel:SetVisible(true)
		end
		if(self.SideWeaponEquip.ModelPanel) then
			self.SideWeaponEquip.ModelPanel:SetVisible(true)
		end
		
		self.Mixtures:SetVisible(false)
		self.Skills:SetVisible(false)
		self.Genetics:SetVisible(false)
		
		self.ButtonOpen = "inventory"
	end
	
	self.MixturesButton = vgui.Create("DButton", self)
	self.MixturesButton:SetText("Mixtures")
	self.MixturesButton.DoClick = function()
		--Hide inv
		self.Header:SetVisible(false)
		self.MainWeaponEquip:SetVisible(false)
		self.SideWeaponEquip:SetVisible(false)
		self.Description:SetVisible(false)
		for x = 1, INVENTORY_WIDTH do
			for y = 1, INVENTORY_HEIGHT do
				GAMEMODE.InventoryBlocks[x][y]:SetVisible(false)
				if(GAMEMODE.InventoryBlocks[x][y].ModelPanel) then
					GAMEMODE.InventoryBlocks[x][y].ModelPanel:SetVisible(false)
				end
			end
		end
		if(self.MainWeaponEquip.ModelPanel) then
			self.MainWeaponEquip.ModelPanel:SetVisible(false)
		end
		if(self.SideWeaponEquip.ModelPanel) then
			self.SideWeaponEquip.ModelPanel:SetVisible(false)
		end
		
		
		self.Mixtures:SetVisible(true)
		self.Skills:SetVisible(false)
		self.Genetics:SetVisible(false)
		
		self.ButtonOpen = "mixtures"
	end
	
	self.SkillsButton = vgui.Create("DButton", self)
	self.SkillsButton:SetText("Skills")
	self.SkillsButton.DoClick = function()
		--Hide inv
		self.Header:SetVisible(false)
		self.MainWeaponEquip:SetVisible(false)
		self.SideWeaponEquip:SetVisible(false)
		self.Description:SetVisible(false)
		for x = 1, INVENTORY_WIDTH do
			for y = 1, INVENTORY_HEIGHT do
				GAMEMODE.InventoryBlocks[x][y]:SetVisible(false)
				if(GAMEMODE.InventoryBlocks[x][y].ModelPanel) then
					GAMEMODE.InventoryBlocks[x][y].ModelPanel:SetVisible(false)
				end
			end
		end
		if(self.MainWeaponEquip.ModelPanel) then
			self.MainWeaponEquip.ModelPanel:SetVisible(false)
		end
		if(self.SideWeaponEquip.ModelPanel) then
			self.SideWeaponEquip.ModelPanel:SetVisible(false)
		end
		
		self.Mixtures:SetVisible(false)
		self.Skills:SetVisible(true)
		self.Genetics:SetVisible(false)
		
		self.ButtonOpen = "skills"
	end
	
	self.GeneticsButton = vgui.Create("DButton", self)
	self.GeneticsButton:SetText("Genetics")
	self.GeneticsButton.DoClick = function()
		--Hide inv
		self.Header:SetVisible(false)
		self.MainWeaponEquip:SetVisible(false)
		self.SideWeaponEquip:SetVisible(false)
		self.Description:SetVisible(false)
		for x = 1, INVENTORY_WIDTH do
			for y = 1, INVENTORY_HEIGHT do
				GAMEMODE.InventoryBlocks[x][y]:SetVisible(false)
				if(GAMEMODE.InventoryBlocks[x][y].ModelPanel) then
					GAMEMODE.InventoryBlocks[x][y].ModelPanel:SetVisible(false)
				end
			end
		end
		if(self.MainWeaponEquip.ModelPanel) then
			self.MainWeaponEquip.ModelPanel:SetVisible(false)
		end
		if(self.SideWeaponEquip.ModelPanel) then
			self.SideWeaponEquip.ModelPanel:SetVisible(false)
		end
		
		self.Mixtures:SetVisible(false)
		self.Skills:SetVisible(false)
		self.Genetics:SetVisible(true)
		
		self.ButtonOpen = "genetics"
	end

	self.Mixtures = vgui.Create("DPropertySheet", self)
	self.Mixtures.Tabs = {}	

	self.Skills = vgui.Create("DPanelList", self)
	self.Skills:EnableHorizontal(false)
	self.Skills:EnableVerticalScrollbar(true)
	self.Skills:SetPadding(5)
	self.Skills:SetPadding(5)
	self.Skills:SetSpacing(5)
	
	self.Genetics = vgui.Create("DPanelList", self)
	self.Genetics:EnableHorizontal(false)
	self.Genetics:EnableVerticalScrollbar(true)
	self.Genetics:SetPadding(5)
	self.Genetics:SetPadding(5)
	self.Genetics:SetSpacing(5)
	
	--Inventory
	self.Header = vgui.Create("perp2_inventory_logo", self)
	
	self.MainWeaponEquip = vgui.Create("perp2_inventory_block_equip", self)
	self.MainWeaponEquip:SetMain(true)
	GAMEMODE.InventoryBlocks_Linear[self.MainWeaponEquip.itemID] = self.MainWeaponEquip
	
	self.SideWeaponEquip = vgui.Create("perp2_inventory_block_equip", self)
	self.SideWeaponEquip:SetMain(false)
	GAMEMODE.InventoryBlocks_Linear[self.SideWeaponEquip.itemID] = self.SideWeaponEquip
	
	self.Description = vgui.Create("perp2_inventory_block_description", self)
	
	--Bla
	self:SetAlpha(GAMEMODE.GetInventoryAlpha())
	
	-- Have to load mixtures and items first.
	--timer.Simple( 1, function() 
		self:FillMixtureSkillsAndGenes()
	--end )
	self.InventoryButton.DoClick()
end

-- recreate the vgui... live with it.
function PANEL:FillMixtureSkillsAndGenes()
	local visible = self.Mixtures:IsVisible()
	if IsValid( self.Mixtures ) then self.Mixtures:Remove() end
	self.Mixtures = vgui.Create( "DPropertySheet", self )
	self.Mixtures:SetVisible( visible )
	self.Mixtures.Tabs = {}

	self.Skills:Clear( true )

	for k, v in pairs(SKILLS_DATABASE) do
		local What = vgui.Create("perp2_skill_bar", self.Skills):SetSkill(v[1])
		self.Skills:AddItem(What)
		What:PerformLayout()
	end

	self.Genetics:Clear( true )
	for k, v in pairs(GENES_DATABASE) do
		local What = vgui.Create("perp2_gene_bar", self.Genetics):SetSkill(v[1])
		self.Genetics:AddItem(What)
		What:PerformLayout()
	end

	local sortedMixturesTable = {}
	for k, v in pairs(MIXTURE_DATABASE) do
		if LocalPlayer():HasMixture( k ) then
			table.insert(sortedMixturesTable, v)
		end
	end
	
	table.sort( sortedMixturesTable, function ( a, b ) 
		if (!a) then return false end
		if (!b) then return true end
		
		local curPos = 1
		
		local lA = string.lower(a.Name)
		local lB = string.lower(b.Name)
		
		while true do
			local sA = string.sub(lA, curPos, curPos)
			local sB = string.sub(lB, curPos, curPos)
			
			if (sB == "") then
				return true
			elseif (sA == "") then
				return false
			end
		
			local boA = string.byte(sA)
			local boB = string.byte(sB)
			
			if (boA < boB) then
				return true
			elseif (boA > boB) then
				return false
			end
			
			curPos = curPos + 1
		end
	end )
	
	for k, v in pairs(sortedMixturesTable) do
		local strCat = v.Category or "Others"
		if(strCat) then
			if(not self.Mixtures.Tabs[strCat]) then
				self.Mixtures.Tabs[strCat] = vgui.Create("DPanelList")
				self.Mixtures.Tabs[strCat]:EnableHorizontal(false)
				self.Mixtures.Tabs[strCat]:EnableVerticalScrollbar(true)
				self.Mixtures.Tabs[strCat]:SetPadding(5)
				self.Mixtures.Tabs[strCat]:SetPadding(5)
				self.Mixtures.Tabs[strCat]:SetSpacing(5)
				self.Mixtures:AddSheet(strCat, self.Mixtures.Tabs[strCat])
				for k, v in pairs(MIXTURE_DATABASE) do
					if !LocalPlayer():HasMixture( k ) then
						--self.Mixtures.Tabs[strCat]:AddItem(vgui.Create('perp2_mixtures_warn', self.Mixtures))
						self.Mixtures.Tabs[strCat]:AddItem(vgui.Create('perp2_mixtures_tip', self.Mixtures))
						break
					end
				end
			end
		end
		
		local NewMixInfo = vgui.Create('perp2_mixtures_info', self.Mixtures.Tabs[strCat])
		self.Mixtures.Tabs[strCat]:AddItem(NewMixInfo)
		NewMixInfo:SetMixture(v)
	 end
end

function PANEL:GetHoveredItemSlot ( )
	for k, v in pairs(GAMEMODE.InventoryBlocks_Linear) do
		if (v.cursorIn) then
			return v
		end
	end
	
	return nil
end

function PANEL:PerformLayout ( )	
	local MaxW = ScrW() * .6
	local MaxH = (ScrW() * (10 / 16)) * .77
	self:SetPos((ScrW() * .5) - (MaxW * .5), (ScrH() * .5) - (MaxH * .5))
	self:SetSize(MaxW, MaxH)
	
	local bufferSize = 3
	local availableWidth = self:GetWide() - 2 - ((INVENTORY_WIDTH + 1) * bufferSize)
	local sizeOfBlock = availableWidth / INVENTORY_WIDTH
	
	for x = 1, INVENTORY_WIDTH do
		for y = 1, INVENTORY_HEIGHT do		
			local ox, oy = self:GetSize()
			GAMEMODE.InventoryBlocks[x][y]:SetPos(1 + (x * bufferSize) + ((x - 1) * sizeOfBlock), self:GetTall() - 1 - ((INVENTORY_HEIGHT - (y - 1)) * (bufferSize + sizeOfBlock)))
			GAMEMODE.InventoryBlocks[x][y]:SetSize(sizeOfBlock, sizeOfBlock)
			GAMEMODE.InventoryBlocks[x][y]:GrabItem()
		end
	end
	
	local size = (self:GetWide() - 1 - bufferSize * 3) * .5
	local w, h = (size - bufferSize) * .5, self:GetTall() - (2 + bufferSize * 2.5 + INVENTORY_HEIGHT * (bufferSize + sizeOfBlock) + size * .5)
	
	
	self.InventoryButton:SetPos(bufferSize + 1, bufferSize + 1)
	self.InventoryButton:SetSize(w, h * 0.25)
	
	self.MixturesButton:SetPos(bufferSize + 1 + w + 5, bufferSize + 1)
	self.MixturesButton:SetSize(w , h * 0.25)
	
	self.SkillsButton:SetPos(bufferSize + 6 + w * 2 + 5, bufferSize + 1)
	self.SkillsButton:SetSize(w, h * 0.25)
	
	self.GeneticsButton:SetPos(bufferSize + 6 + w * 3 + 10, bufferSize + 1)
	self.GeneticsButton:SetSize(w, h * 0.25)
	
	--Inv
	self.Header:SetPos(size + bufferSize * 1.5 + 3, bufferSize * 2 + 1 + h * 0.25)
	self.Header:SetSize(size, size * .5 - h * 0.25 - 5)
	
	self.MainWeaponEquip:SetPos(size + bufferSize * 1.5 + 3, bufferSize * 2 + size * .5)
	self.MainWeaponEquip:SetSize(w, h)
	self.MainWeaponEquip:GrabItem()
	
	self.SideWeaponEquip:SetPos(size + bufferSize * 2.5 + 3 + w, bufferSize * 2 + size * .5)
	self.SideWeaponEquip:SetSize(w, h)
	self.SideWeaponEquip:GrabItem()
	
	self.Description:SetPos(bufferSize + 1, bufferSize * 2 + 1 + h * 0.25)
	self.Description:SetSize(size, self:GetTall() - (bufferSize * 2 + INVENTORY_HEIGHT * (bufferSize + sizeOfBlock)) - h - bufferSize + h * 0.75)

	--mixtures
	self.Mixtures:SetPos(5, h * 0.25 + 10)
	self.Mixtures:SetSize(self:GetWide() - 10,  self:GetTall() - 15 - h * 0.25)
	--skills
	--self.Skills
	self.Skills:SetPos(5, h * 0.25 + 10)
	self.Skills:SetSize(self:GetWide() - 10,  self:GetTall() - 15 - h * 0.25)
	--gens
	--self.Genetics
	self.Genetics:SetPos(5, h * 0.25 + 10)
	self.Genetics:SetSize(self:GetWide() - 10,  self:GetTall() - 15 - h * 0.25)
end

function PANEL:SetDescription ( itemTable )
	self.Description:SetDescription(itemTable)
	self.Header:SetDisplay(itemTable)
end

function PANEL:Paint( w, h )
	derma.SkinHook( "Paint", "Frame", self, w, h )
end

vgui.Register("perp2_inventory", PANEL)

hook.Add("OnReloaded","RefreshInventory", function()
	if GAMEMODE.InventoryPanel and IsValid(GAMEMODE.InventoryPanel) then
		print("Refreshing Inventory")
		GAMEMODE.InventoryPanel:Remove() 
		GAMEMODE.InventoryPanel = vgui.Create( "perp2_inventory" )
		GAMEMODE.InventoryPanel:SetVisible( false )
		GAMEMODE.InventoryPanel:FillMixtureSkillsAndGenes()
	end
end)