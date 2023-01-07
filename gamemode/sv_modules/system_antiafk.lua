--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local blacklisted = {
	[IN_SCORE] = true,
	[IN_WALK] = true,
}

hook.Add( "KeyPress", "AntiAFKCheck", function( Player, key )
	if blacklisted[key] then return true end
	Player.lastAction = CurTime()
	if Player:GetNWBool("isAFK") then
		Player:SetNWBool("isAFK",false)
		GAMEMODE:AnnounceAFKStatus(Player)
	end
	timer.Create(Player:SteamID().."AFKCheck",900,1,function()
		if IsValid(Player) then
			Player:SetNWBool("isAFK",true)
			GAMEMODE:AnnounceAFKStatus(Player)
			--Player:LoadAccount(Player.PERPID,true)
			GAMEMODE:PlayerFullLoad(Player)
		end
	end)
end )