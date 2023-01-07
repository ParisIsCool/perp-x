local SHOP = {}

SHOP.ID 				= 75
SHOP.NPCAssociation 	= 67
SHOP.Name				= "Hotdog Stand"

SHOP.Items = {	
    "food_hotdog",
    "food_pretzel",
    "food_coke"
}
				
GAMEMODE:RegisterShop( SHOP )