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

local Frame

local function GiveItemPanelCreate()
	Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.617, ScrH() * 0.5)
	Frame:Center()
	Frame:SetTitle("Please give me an item. *beg* *beg* *beg* *beg* *beg*")
	Frame:ShowCloseButton( false )

	Frame.List = vgui.Create("DPanelList", Frame)
	Frame.List:StretchToParent(5, 27, 5, 5)
	Frame.List:EnableVerticalScrollbar(true)
	Frame.List:EnableHorizontal(true)

	for k, v in pairs( ITEM_DATABASE ) do	
		local sub = vgui.Create( "DPanel" )
		sub:SetSize(89, 89)
		sub.Paint = function()
			surface.SetDrawColor(Color(100, 100, 100, 255))
			surface.DrawRect(2, 2, sub:GetWide() - 4, sub:GetTall() - 4)
			
			surface.SetTextColor(Color(255, 255, 255, 255))
			surface.SetFont( "Default" )
			local x, y = surface.GetTextSize(v.Name)
			
			surface.SetTextPos(5, 5)
			surface.DrawText(v.Name)
			
			draw.SimpleTextOutlined(v.ID, "DermaDefault", 1, sub:GetTall(), Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0,255))
		end
		
		sub.spawnicon = vgui.Create("SpawnIcon", sub)
		sub.spawnicon:SetModel(v.WorldModel)
		sub.spawnicon:SetPos(5, 20)
		sub.spawnicon.DoClick = function()
			RunConsoleCommand("perpx_giveitembeg", v.ID)
		end
		
		Frame.List:AddItem(sub)
	end
end

concommand.Add( "+giveitempanel", function()
	if not LocalPlayer():IsSuperAdmin() then return end

	if not Frame then GiveItemPanelCreate() end

	Frame:MakePopup()
	Frame:SetVisible( true )
end )

concommand.Add( "-giveitempanel", function()
	if not LocalPlayer():IsSuperAdmin() then return end
	Frame:SetVisible( false )
end )