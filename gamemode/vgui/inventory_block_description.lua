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

transitionSpeed = 50

function PANEL:Init ( )
	self:SetVisible(true)
	
	self.NextChangeVisi = CurTime()
	self.ourAlpha = 255
end

function PANEL:PerformLayout ( )
	
end

surface.CreateFont( "DefaultSmallPE", { font = "Verdana", size = 13, weight = 1000, antialias = true, additive = false } )
surface.CreateFont( "Trebuchet20", { font = "Trebuchet MS", size = 20, weight = 900, antialias = true, additive = false } )

function PANEL:Paint()
	transitionSpeed = FrameTime() * 1500
	
	if (self.NextChangeVisi <= CurTime()) then
		self.NextChangeVisi = CurTime() + (1 / 200)
		
		if (self.goDown) then
			if (self.ourAlpha > 0) then
				self.ourAlpha =  math.Clamp(self.ourAlpha - transitionSpeed, 0, 255)
			else
				self.goDown = nil
				self.itemTable = self.nextTable
			end
		elseif (!self.goDown and self.ourAlpha < 255) then
			self.ourAlpha = math.Clamp(self.ourAlpha + transitionSpeed, 0, 255)
		end
	end

	surface.SetDrawColor(22, 22, 22, 255)
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	
	--[[surface.SetDrawColor(54, 54, 54, 255)
	surface.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2)]]
	
	surface.SetFont("Default")
	local dw, dh = surface.GetTextSize("Whatev ")
	
	if (self.itemTable) then
		draw.SimpleText(self.itemTable.Name, "Trebuchet20", self:GetWide() * .5, ScreenScale(5), Color(255, 255, 255, self.ourAlpha), 1, 1)
		local w, h = surface.GetTextSize(self.itemTable.Name)
		
		local explodedResults = string.Explode("\n", self.itemTable.Description)
		local curY = ScreenScale(8) + h
		
		local cost = self.itemTable.Cost
		cost = math.Round( cost + (cost * GAMEMODE.GetTaxRate_Sales()) )
		
		draw.SimpleText("Buy Price: $" .. util.FormatNumber( cost ) .. " (" .. GAMEMODE.GetTaxRate_Sales_Text() .. " sales tax)", "DefaultSmallPE", self:GetWide() * .5, curY, Color(255, 255, 255, self.ourAlpha), 1, 1)
		draw.SimpleText("Sell Price: $" .. util.FormatNumber( math.Round(self.itemTable.Cost * .5) ), "DefaultSmallPE", self:GetWide() * .5, curY + dh, Color(255, 255, 255, self.ourAlpha), 1, 1)
		curY = curY + dh * 3
				
		for k, v in pairs(explodedResults) do
			local splitResults = cutLength(v, self:GetWide() - 20, "Default")
			
			for _, txt in pairs(splitResults) do
				draw.SimpleText(txt, "Default", ScreenScale(3), curY, Color(255, 255, 255, self.ourAlpha), 0, 1)
				
				curY = curY + dh
			end
		end
	elseif (GAMEMODE.DraggingSomething) then
		draw.SimpleText("Release the left mouse button to drop the item into the selected slot.", "DefaultSmallPE", self:GetWide() * .5, ScreenScale(5), Color(255, 255, 255, self.ourAlpha), 1, 1)
	else
		draw.SimpleText("Scroll over an item to see it's description.", "DefaultSmallPE", self:GetWide() * .5, ScreenScale(5), Color(255, 255, 255, self.ourAlpha), 1, 1)
		
		if (self.ShopMenu) then
			draw.SimpleText("Left click to sell or buy an item.", "DefaultSmallPE", self:GetWide() * .5, ScreenScale(5) + dh, Color(255, 255, 255, self.ourAlpha), 1, 1)
			draw.SimpleText("Right click to sell or buy 5 items at a time.", "DefaultSmallPE", self:GetWide() * .5, ScreenScale(5) + dh * 2, Color(255, 255, 255, self.ourAlpha), 1, 1)
			draw.SimpleText("Press Q to exit shop.", "DefaultSmallPE", self:GetWide() * .5, self:GetTall() - ScreenScale(5), Color(255, 255, 255, self.ourAlpha), 1, 1)
		end
	end
end

function PANEL:SetDescription ( itemTable )
	if self.nextTable ~= itemTable then
		self.goDown = true
		self.nextTable = itemTable
	end
end

vgui.Register("perp2_inventory_block_description", PANEL)