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

local wantedX, wantedY = 5, 5

function PANEL:Init ( )
	self.ourItemSlots = {};
	
	for x = 1, wantedX do
		self.ourItemSlots[x] = {};
		
		for y = 1, wantedY do
			self.ourItemSlots[x][y] = vgui.Create("perp2_shop_store_block", self);
		end
	end
	
	self.Description = true;
	self:SetSkin("perp2")
end

function PANEL:PerformLayout ( )	
	local buffer = 3
	
	local xPer = (self:GetWide() - (buffer * (wantedX + 1))) / wantedX
	local yPer = (self:GetTall() - (buffer * (wantedY + 1))) / wantedY
		
	for x = 1, wantedX do		
		for y = 1, wantedY do
			self.ourItemSlots[x][y]:SetSize(xPer, yPer)
			self.ourItemSlots[x][y]:SetPos(buffer * x + xPer * (x - 1), buffer * y + yPer * (y - 1))
		end
	end
end

function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Frame", self, w, h)
end

function PANEL:PushItem ( itemTable )
	for y = 1, wantedY do		
		for x = 1, wantedX do
			if (!self.ourItemSlots[x][y].itemTable) then
				return self.ourItemSlots[x][y]:GrabItem(itemTable)
			end
		end
	end
end

function PANEL:SetDescription ( itemTable )
	self:GetParent():SetDescription(itemTable)
end

vgui.Register("perp2_shop_store", PANEL)