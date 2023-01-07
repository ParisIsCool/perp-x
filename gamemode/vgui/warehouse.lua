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

function PANEL:Init()
	self:SetSize( ScrW() * .5, ScrH() * .5 )
	self:SetPos( ScrW() * .25, ScrH() * .25 )
	self:SetTitle( "Warehouse" )
	self:SetAlpha( GAMEMODE.GetGUIAlpha() )
	self:ShowCloseButton( true )
	self:SetDeleteOnClose( false )
	self:SetDraggable( false )
	
	self.ShouldBuild = false
	
	self.LabelItemList = vgui.Create( "DLabel", self )
	self.LabelItemList:SetPos( 5, 26 )
	self.LabelItemList:SetSize( self:GetWide() * 0.5, 30 )
	self.LabelItemList:SetText( "Items in warehouse.\nClick on an icon to take the item into your inventory." )
	self.LabelItemList:SetTextColor( Color( 255, 255, 255, 255 ) )
	
	self.LabelInv = vgui.Create( "DLabel", self )
	self.LabelInv:SetPos( self:GetWide() * 0.5 + 5, 26 )
	self.LabelInv:SetSize( self:GetWide() * 0.5, 30 )
	self.LabelInv:SetText( "Items in inventory.\nClick on an icon to put the item into the warehouse." )
	self.LabelInv:SetTextColor( Color( 255, 255, 255, 255 ) )
	
	self.ItemList = vgui.Create( "DPanelList", self )
	self.ItemList:StretchToParent( 5, 26 + 30, self:GetWide() * 0.5 + 2, 5 )
	self.ItemList:EnableHorizontal( true )
	self.ItemList:EnableVerticalScrollbar( true )
	self.ItemList:SetPadding( 4 )
	
	self.Inventory = vgui.Create( "DPanelList", self )
	self.Inventory:StretchToParent( self:GetWide() * 0.5 + 2, 26 + 30, 5, 5 )
	self.Inventory:EnableHorizontal( true )
	self.Inventory:EnableVerticalScrollbar( true )
end

function PANEL:Show()
	self:SetVisible( true )
	self:MakePopup()

	self.ShouldBuild = true
end

function PANEL:Build()
	self.ShouldBuild = true
end

function PANEL:Think()
	if self.ShouldBuild then
		self.ItemList:Clear()
		self.Inventory:Clear()
		
		for k, v in pairs( GAMEMODE.PlayerWarehouse ) do
			if v.amount > 0 then
				local spawnicon = vgui.Create( "SpawnIcon", self.ItemList )
				spawnicon:SetModel( ITEM_DATABASE[k].InventoryModel )
				spawnicon:SetToolTip( "Name: " .. ITEM_DATABASE[k].Name .. "\nAmount: " .. v.amount )
				spawnicon.OnMousePressed = function( self, mc )
					if mc == MOUSE_LEFT then
						net.Start( "perpx_wh_take") net.WriteInt(ITEM_DATABASE[k].ID,16) net.WriteInt(1,16) net.SendToServer()
					elseif mc == MOUSE_RIGHT then
						local Menu = DermaMenu()

						Menu:AddOption( "Withdraw 1", function() 
							net.Start( "perpx_wh_take") net.WriteInt(ITEM_DATABASE[k].ID,16) net.WriteInt(1,16) net.SendToServer()
						end )

						if v.amount >= 5 then
							Menu:AddOption( "Withdraw 5", function() 
								net.Start( "perpx_wh_take") net.WriteInt(ITEM_DATABASE[k].ID,16) net.WriteInt(5,16) net.SendToServer()
							end )
						end

						if v.amount >= 10 then
							Menu:AddOption( "Withdraw 10", function() 
								net.Start( "perpx_wh_take") net.WriteInt(ITEM_DATABASE[k].ID,16) net.WriteInt(10,16) net.SendToServer()
							end )
						end

						if v.amount > 1 then
							Menu:AddOption( "Withdraw all", function()
								net.Start( "perpx_wh_take") net.WriteInt(ITEM_DATABASE[k].ID,16) net.WriteInt(v.amount,16) net.SendToServer()
							end )
						end

						Menu:Open()
					end
				end
				spawnicon:InvalidateLayout()
				
				self.ItemList:AddItem( spawnicon )
			end
		end
		
		local PlayerItems = {}
		for _, v in pairs( GAMEMODE.PlayerItems ) do
			if PlayerItems[ v.ID ] then
				PlayerItems[ v.ID ] = PlayerItems[ v.ID ] + v.Quantity
			else
				PlayerItems[ v.ID ] = v.Quantity
			end
		end

		for k, v in pairs( PlayerItems ) do
			local spawnicon = vgui.Create( "SpawnIcon", self.ItemList )
			spawnicon:SetModel( ITEM_DATABASE[ k ].InventoryModel )
			spawnicon:SetToolTip( "Name: " .. ITEM_DATABASE[ k ].Name .. "\nAmount: " .. v )
			spawnicon.OnMousePressed = function( self, mc )
				if k == 103 then return end

				if mc == MOUSE_LEFT then
					net.Start( "perpx_wh_add") net.WriteInt(k,16) net.WriteInt(1,16) net.SendToServer()
				elseif mc == MOUSE_RIGHT  then
					local Menu = DermaMenu()

					Menu:AddOption( "Deposit 1", function() 
						net.Start( "perpx_wh_add") net.WriteInt(k,16) net.WriteInt(1,16) net.SendToServer()
					end )

					if v >= 5 then
						Menu:AddOption( "Deposit 5", function() 
							net.Start( "perpx_wh_add") net.WriteInt(k,16) net.WriteInt(5,16) net.SendToServer()
						end )
					end

					if v >= 10 then
						Menu:AddOption( "Deposit 10", function() 
							net.Start( "perpx_wh_add") net.WriteInt(k,16) net.WriteInt(10,16) net.SendToServer()
						end )
					end

					if v > 1 then
						Menu:AddOption( "Deposit all", function()
							net.Start( "perpx_wh_add") net.WriteInt(k,16) net.WriteInt(v,16) net.SendToServer()
						end )
					end

					Menu:Open()
				end
			end
			spawnicon:InvalidateLayout()
			
			self.Inventory:AddItem( spawnicon )
		end
		
		self.ShouldBuild = false
	end
end

vgui.Register( "perp2_warehouse", PANEL, "DFrame" )