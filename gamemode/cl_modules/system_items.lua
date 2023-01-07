--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

GM.PlayerItems = {}

net.Receive( "playerIsArrested", function()
	local data = net.ReadBool()
	
	LocalPlayer().isArrested = data
end )

function setItemSlot( SlotID, ItemID, ItemQuantity )
	GAMEMODE.PlayerItems[ SlotID ] = {}
	GAMEMODE.PlayerItems[ SlotID ].ID = ItemID
	GAMEMODE.PlayerItems[ SlotID ].Quantity = ItemQuantity

	GAMEMODE.InventoryBlocks_Linear = GAMEMODE.InventoryBlocks_Linear or {}
	GAMEMODE.InventoryBlocks_Linear[ SlotID ] = GAMEMODE.InventoryBlocks_Linear[ SlotID ] or {}
	GAMEMODE.InventoryBlocks_Linear[ SlotID ].GrabItem = GAMEMODE.InventoryBlocks_Linear[ SlotID ].GrabItem or {}
	
	GAMEMODE.InventoryBlocks_Linear[ SlotID ]:GrabItem()
end

local function removeItem( SlotID, Amount )
	GAMEMODE.PlayerItems[ SlotID ].Quantity = GAMEMODE.PlayerItems[ SlotID ].Quantity - Amount
			
	if GAMEMODE.PlayerItems[ SlotID ].Quantity <= 0 then
		local ItemTable = ITEM_DATABASE[ GAMEMODE.PlayerItems[ SlotID ].ID ]
	
		GAMEMODE.PlayerItems[ SlotID ] = nil
		GAMEMODE.InventoryBlocks_Linear[ SlotID ]:GrabItem()
	end
end

function GM.UseItem( SlotID )
	if LocalPlayer():InVehicle() then return end
	if not LocalPlayer():Alive() then return LocalPlayer():Notify( "You cannot manipulate items while dead." ) end
	--if GAMEMODE.UnarrestTime then return LocalPlayer():Notify( "You cannot manipulate items while you're arrested." ) end
	if LocalPlayer().isArrested then LocalPlayer():Notify( "You cannot manipulate items while you're arrested." ) return end

	local Item = GAMEMODE.PlayerItems[ SlotID ]
	
	if Item then
		local ItemTable = ITEM_DATABASE[ Item.ID ]

		if ItemTable.OnUse and not ItemTable.OnUse( SlotID ) then return end

		RunConsoleCommand( "perp_i_u", SlotID )
	end
end

function GM.DropItem( SlotID )	
	if LocalPlayer():InVehicle() then return end
	if not LocalPlayer():Alive() then return LocalPlayer():Notify( "You cannot manipulate items while dead." ) end
	--if GAMEMODE.UnarrestTime then return LocalPlayer():Notify( "You cannot manipulate items while you're arrested." ) end
	if isArrested then LocalPlayer():Notify( "You cannot manipulate items while you're arrested." ) return end

	local Item = GAMEMODE.PlayerItems[ SlotID ]

	if Item then
		local ItemTable = ITEM_DATABASE[ Item.ID ]

		if ItemTable.OnDrop and not ItemTable.OnDrop( SlotID ) then return end

		RunConsoleCommand( "perp_i_d", SlotID )
	end
end

-- Player Connection Initalization of Items
net.Receive( "perp_item_init", function()

	for k, v in pairs(GAMEMODE.InventoryBlocks_Linear) do
		v:GrabItem()
	end

	GAMEMODE.PlayerItems = {}

	local Items = net.ReadTable()
	
	for k, v in pairs(Items) do
		setItemSlot( v.SlotID, v.ItemID, v.ItemQuantity )
	end

end )

-- Player Item Server Editing
net.Receive( "perp_item_edit", function()

	local SlotID 		= net.ReadInt(16)
	local ItemID 		= net.ReadInt(16)
	local ItemQuantity 	= net.ReadInt(16)
	
	setItemSlot( SlotID, ItemID, ItemQuantity )

end )

-- Item Remove 1
local DropItemSound = Sound( "items/ammocrate_close.wav" )
net.Receive( "perp_item_rem1", function()
	local SlotID 		= net.ReadInt(16)
	local Quantity 		= net.ReadInt(16)
	local Drop 			= net.ReadBool()

	LocalPlayer():TakeItem( SlotID, Quantity )

	if Drop then surface.PlaySound( DropItemSound ) end
end )

-- Item Add
local NewItemSound = Sound( "items/ammocrate_open.wav" )
net.Receive( "perp2_item_add1", function()
	local ItemID 		= net.ReadInt(16)
	local ItemQuantity 	= net.ReadInt(16)
	
	if not LocalPlayer().GiveItem then return end
	LocalPlayer():GiveItem( ItemID, ItemQuantity )
	surface.PlaySound( NewItemSound )
end )

-- Remove Equiped
net.Receive( "perp_rem_eqp", function()
	local SlotID = net.ReadInt(16)

	GAMEMODE.PlayerItems[ SlotID ] = nil
	GAMEMODE.InventoryBlocks_Linear[ SlotID ]:GrabItem()
end )

local ThatDoesntGoThere = Sound( "buttons/button10.wav" )
local CashRegisterSound = Sound( "perp2.5/register.mp3" )
function GM.SellItem( SlotID, Amount )
	if not LocalPlayer():Alive() then LocalPlayer():Notify( "You cannot manipulate items while dead." ) return end

	local Item = GAMEMODE.PlayerItems[ SlotID ]
	if not Item then return end

	local ItemTable = ITEM_DATABASE[ Item.ID ]
	if not ItemTable then return end

	if ItemTable.RestrictedSelling then return end
	
	if LocalPlayer():GetItemCount( ItemTable.ID ) < Amount then
		surface.PlaySound( ThatDoesntGoThere )
		return LocalPlayer():Notify( "You don't have enough items to sell that many." )
	end

	surface.PlaySound( CashRegisterSound )
	
	RunConsoleCommand( "perp_i_s", SlotID, Amount )
end

function GM.BuyItem( ItemID, Amount )
	if not LocalPlayer():Alive() then return LocalPlayer():Notify( "You cannot manipulate items while dead." ) end

	local ItemTable = ITEM_DATABASE[ ItemID ]

	local Total = Amount * ItemTable.Cost
	Total = Total + ( Total * GAMEMODE.GetTaxRate_Sales() )

	if LocalPlayer():GetCash() < Total then
		surface.PlaySound( ThatDoesntGoThere )
		return LocalPlayer():Notify( "You don't have enough money." )
	end
	
	if not LocalPlayer():CanHoldItem( ItemTable.ID, Amount ) then
		surface.PlaySound( ThatDoesntGoThere )
		return LocalPlayer():Notify( "You don't have enough inventory room." )
	end

	RunConsoleCommand( "perp_i_b", ItemTable.ID, Amount ) 
end

-- Called from OnUse()
function GM.AttemptToEquip( SlotID )
	local Item = GAMEMODE.PlayerItems[ SlotID ]
	if not Item then return end

	local ItemTable = ITEM_DATABASE[ Item.ID ]
	if not ItemTable then return end

	if SlotID <= 2 then return end
	
	LocalPlayer():SwapItemPosition( SlotID, ItemTable.EquipZone )
end

usermessage.Hook( "perp_opensetitemforsaledialog", function( UMsg )
	local objToSell = UMsg:ReadEntity()
	local itemID = UMsg:ReadShort()
	
	local FramePurchase = vgui.Create( "DFrame" )
	FramePurchase:SetSize( 250, 225 )
	FramePurchase:SetTitle( "Put item for sale." )
	FramePurchase:Center()
	FramePurchase:MakePopup()

	FramePurchase.Title1 = vgui.Create("DLabel", FramePurchase )
	FramePurchase.Title1:SetSize( 240, 20 )
	FramePurchase.Title1:SetPos( 5, 30 )
	FramePurchase.Title1:SetText( "Item Name:" )

	FramePurchase.TitleEntry = vgui.Create( "DTextEntry", FramePurchase )
	FramePurchase.TitleEntry:SetSize( 240, 20 )
	FramePurchase.TitleEntry:SetPos(5, 50)
	FramePurchase.TitleEntry:SetText(ITEM_DATABASE[itemID].Name)
	
	FramePurchase.Label1 = vgui.Create( "DLabel", FramePurchase )
	FramePurchase.Label1:SetSize( 240, 20 )
	FramePurchase.Label1:SetPos( 5, 80 )
	FramePurchase.Label1:SetText( "Item Price: " )
	FramePurchase.Label1:SetTextColor( color_black )
	FramePurchase.Label1.Think = function()
		local iPrice = tonumber( FramePurchase.PriceEntry:GetValue() )
		if iPrice and iPrice > 10000000 then
			FramePurchase.Label1:SetTextColor( Color( 255, 0, 0, 255 ) )
		else
			FramePurchase.Label1:SetTextColor( Color( 255, 255, 255, 255 ) )
		end
	end
	
	FramePurchase.PriceEntry = vgui.Create( "DTextEntry", FramePurchase )
	FramePurchase.PriceEntry:SetSize( 240, 20 )
	FramePurchase.PriceEntry:SetPos( 5, 100 )
	FramePurchase.PriceEntry:SetText( ITEM_DATABASE[itemID].Cost )
	
	FramePurchase.Label2 = vgui.Create( "DLabel", FramePurchase )
	FramePurchase.Label2:SetPos( 5, 130 )
	FramePurchase.Label2:SetSize( 240, 20 )
	FramePurchase.Label2:SetText( "Item Description: (0 out of 100 chars)" )
	
	FramePurchase.DescriptionEntry = vgui.Create( "DTextEntry", FramePurchase )
	FramePurchase.DescriptionEntry:SetSize( 240, 40 )
	FramePurchase.DescriptionEntry:SetPos( 5, 150 )
	FramePurchase.DescriptionEntry:SetMultiline( true )
	FramePurchase.DescriptionEntry.Think = function()
		FramePurchase.Label2:SetText( "Item Description: (" .. string.len( FramePurchase.DescriptionEntry:GetValue() ) .. " out of 100 chars)" )
		if string.len( FramePurchase.DescriptionEntry:GetValue() ) > 100 then
			FramePurchase.Label2:SetTextColor( Color( 255, 0, 0, 255 ) )
		else
			FramePurchase.Label2:SetTextColor( Color( 255, 255, 255, 255 ) )
		end
	end
	
	FramePurchase.SellButton = vgui.Create( "DButton", FramePurchase )
	FramePurchase.SellButton:SetPos( 5, 200 )
	FramePurchase.SellButton:SetSize( 240, 20 )
	FramePurchase.SellButton:SetText( "Put item for sale." )
	FramePurchase.SellButton.DoClick = function()
		local iPrice = tonumber( FramePurchase.PriceEntry:GetValue() )
		local strDescription = FramePurchase.DescriptionEntry:GetValue()
		local Title = FramePurchase.TitleEntry:GetValue()
		
		if iPrice and strDescription then
			if strDescription:len() > 100 then
				return
			end

			if iPrice and iPrice > 10000 then
				return
			end
			
			RunConsoleCommand( "perp_buy_putitemforsale", objToSell:EntIndex(), iPrice, strDescription, Title)
			
			FramePurchase:Close()
		end
	end
end )

usermessage.Hook( "perp_openbuyitempanel", function( UMsg )
	local objToBuy = UMsg:ReadEntity()
	local strItem = UMsg:ReadString()
	local iPrice = UMsg:ReadLong()
	local strDescription = UMsg:ReadString()
	local owner = UMsg:ReadEntity()
	
	local FramePurchase = vgui.Create( "DFrame" )
	FramePurchase:SetSize( 250, 145 )
	FramePurchase:SetTitle( "Do you want to buy this item." )
	FramePurchase:Center()
	FramePurchase:MakePopup()
	
	FramePurchase.Label = vgui.Create( "DLabel", FramePurchase )
	FramePurchase.Label:SetSize( 240, 50 )
	FramePurchase.Label:SetPos( 5, 30 )
	FramePurchase.Label:SetWrap( true )
	FramePurchase.Label:SetText( "Description: " .. strDescription )
	
	FramePurchase.Label2 = vgui.Create( "DLabel", FramePurchase )
	FramePurchase.Label2:SetSize( 240, 20 )
	FramePurchase.Label2:SetPos( 5, 80 )
	FramePurchase.Label2:SetWrap( true )
	FramePurchase.Label2:SetText( "Item: " .. strItem )
	
	FramePurchase.Label3 = vgui.Create( "DLabel", FramePurchase )
	FramePurchase.Label3:SetSize( 240, 20 )
	FramePurchase.Label3:SetPos( 5, 100 )
	FramePurchase.Label3:SetWrap( true )
	FramePurchase.Label3:SetText( "Price: " .. iPrice )

	FramePurchase.BuyButton = vgui.Create( "DButton", FramePurchase )
	FramePurchase.BuyButton:SetSize( 240, 20 )
	FramePurchase.BuyButton:SetPos( 5, 120 )

	if LocalPlayer() == owner then
		FramePurchase.BuyButton:SetText( "Pick up item." )
	else
		FramePurchase.BuyButton:SetText( "Buy this item from seller." )
	end

	FramePurchase.BuyButton.DoClick = function()
		RunConsoleCommand( "perp_buy_forsaleitem", objToBuy:EntIndex() )
		FramePurchase:SetVisible( false )
	end
end )


HALO_ENTITIES_WHITE = HALO_ENTITIES_WHITE or {}

local rainbow = CreateClientConVar("perp_rainbowhalo", "0", true, false, "")

hook.Add("PreDrawHalos", "AddItemHalos", function()
	local col = Color(255,255,255)
	if rainbow:GetBool() then
		col = HSVToColor( CurTime() % 6 * 120, 1, 1 )
	end
	halo.Add( HALO_ENTITIES_WHITE, col, 5, 2, 2 )
end)

HALO_ENTITIES_DRUGS = HALO_ENTITIES_DRUGS or {}

hook.Add("PreDrawHalos", "AddDrugHalos", function()
	local fade = math.abs(math.sin(CurTime()*2))
	halo.Add( HALO_ENTITIES_DRUGS, Color( 201*fade, 182*fade, 112*fade ), 5, 5, 2 )
end)