--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

hook.Add( "GravGunPickupAllowed", "UnweldWeed", function( Player, Ent )
	Ent = Player:GetEyeTrace().Entity -- Apparently it sets Entity as the parent? :S

	if not IsValid( Ent ) then return end

	if Ent.weld and Ent:GetClass() == "ent_weed" or Ent:GetClass() == "ent_cocaine" or Ent:GetClass() == "prop_sign" then
		if Ent:GetClass() == "prop_sign" && !(Ent.Owner == Player) then return end
		constraint.RemoveConstraints( Ent, "Weld" )
		Ent.weld = nil
	end
end )