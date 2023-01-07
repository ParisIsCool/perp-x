--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function GM.ShowGarageModView()		
	local W, H = ScrW() * 0.6, ScrH() * 0.560
	
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( ScrW() * .5 - W * .5, ScrH() * .5 - H * .5 )
	DermaPanel:SetSize( W, H )
	DermaPanel:SetTitle( "Vehicle Modifications" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:SetAlpha( GAMEMODE.GetGUIAlpha() )

	local PanelList1 = vgui.Create( "DPanelList", DermaPanel )
	PanelList1:EnableHorizontal( false )
	PanelList1:EnableVerticalScrollbar( true )
	PanelList1:StretchToParent( 5, 30, 5, 5 )
	PanelList1:SetPadding( 5 )
	PanelList1:SetSpacing( 5 )
	
	local tbl = {}
	local tblDone = {}
	for _, v in pairs( VEHICLE_DATABASE ) do
		table.insert( tbl, v.Name )
	end
	table.sort( tbl )
	
	for k, v in ipairs( tbl ) do
		for t, c in pairs( VEHICLE_DATABASE ) do
			if c.Name == v and not tblDone[ c.ID ] then
				local table = c
				if table and not table.RequiredClass and LocalPlayer():HasVehicle( t ) then
					local NewMenu = vgui.Create( "perp2_vehicle_owned_details_mod", PanelList1 )
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