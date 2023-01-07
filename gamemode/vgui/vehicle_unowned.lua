--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function GM.ShowDealershipView()		
	local W, H = ScrW() * 0.6, ScrH() * 0.560
	
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( ScrW() * .5 - W * .5, ScrH() * .5 - H * .5 )
	DermaPanel:SetSize( W, H )
	DermaPanel:SetTitle( "Vehicle Dealership - Bank Balance: $" .. LocalPlayer():GetBank() )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:SetAlpha( GAMEMODE.GetGUIAlpha() )

	local PanelList1
	local function RemakePanelList()
		PanelList1 = vgui.Create( "DPanelList", DermaPanel )
		PanelList1:EnableHorizontal( false )
		PanelList1:EnableVerticalScrollbar( true )
		PanelList1:StretchToParent( 5, 60, 5, 5 )
		PanelList1:SetPadding( 5 )
		PanelList1:SetSpacing( 5 )
	end
	RemakePanelList()

	local Search = vgui.Create("DTextEntry", DermaPanel)
	Search:SetPlaceholderText("Search")
	Search:SetText("")
	Search:SetPos(5, 30)
	Search:SetSize(DermaPanel:GetWide()-10, 20)
	Search:SetUpdateOnType(true)
	function Search:OnValueChange()
		PanelList1:Remove()
		RemakePanelList()
		local tbl = {}
		local tblDone = {}
		for _, v in pairs( VEHICLE_DATABASE ) do
			table.insert( tbl, v.Cost )
		end
		table.sort( tbl )
		for k, v in ipairs( tbl ) do
			for t, c in pairs( VEHICLE_DATABASE ) do
				if c.Cost == v and not tblDone[ c.ID ] then
					local table = c
					if not table.RequiredClass and not LocalPlayer():HasVehicle( t ) then
						if string.find(string.lower(table.Name),string.lower(self:GetValue())) then
							local NewMenu = vgui.Create( "perp2_vehicle_unowned_details", PanelList1 )
							NewMenu:SetVehicle( table )
							PanelList1:AddItem( NewMenu )
						end
					end
					
					tblDone[ c.ID ] = true
					tbl[ k ] = nil
				end
			end
		end
	end
	
	local tbl = {}
	local tblDone = {}
	for _, v in pairs( VEHICLE_DATABASE ) do
		table.insert( tbl, v.Cost )
	end
	table.sort( tbl )
	
	for k, v in ipairs( tbl ) do
		for t, c in pairs( VEHICLE_DATABASE ) do
			if c.Cost == v and not tblDone[ c.ID ] then
				local table = c
				
				if not table.RequiredClass and not LocalPlayer():HasVehicle( t ) then
					local NewMenu = vgui.Create( "perp2_vehicle_unowned_details", PanelList1 )
					NewMenu:SetVehicle( table )
					PanelList1:AddItem( NewMenu )
				end
				
				tblDone[ c.ID ] = true
				tbl[ k ] = nil
			end
		end
	end

	DermaPanel:MakePopup()
end