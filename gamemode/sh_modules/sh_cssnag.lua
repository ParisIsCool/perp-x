--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local CSR = {}
 
if SERVER then
	util.AddNetworkString("CheckForCSS")
end

function CheckForCSS()
	local EnumNag = 0
	for k,v in pairs(engine.GetGames()) do
		if v.depot == 240 then
			if !v.owned then EnumNag = EnumNag + 1 end
			if !v.mounted then EnumNag = EnumNag + 2 end
			if !v.installed then EnumNag = EnumNag + 4 end
			break
		end
	end
	if EnumNag > 0 then CSSNag(EnumNag) end
end

if SERVER then
	if !ConVarExists("sv_csr_css_nag") then
		CSRNag = CreateConVar("sv_csr_css_nag", "1", {FCVAR_ARCHIVE})
	end
	
	function CSSNag(enum)
		if (!CSRNag:GetBool()) then return end
		local msg = ""
		if enum == 0 then
			msg = "You own css, it's installed and mounted, you're good."
		end
		if enum == 1 then
			msg = "You do not own CSS!" -- Shouldn't ever get this message?
		end
		if enum == 2 then
			msg = "You do not have CSS mounted!"
		end
		if enum == 3 then
			msg = "You do not own CSS!" -- Shouldn't ever get this message?
		end
		if enum == 4 then
			msg = "You do not have CSS installed!" -- Shouldn't ever get this message?
		end
		if enum == 5 then
			msg = "You do not own CSS!" -- Shouldn't ever get this message?
		end
		if enum == 6 then
			msg = "You do not have CSS installed and mounted!"
		end
		if enum == 7 then
			msg = "You do not own CSS!"
		end
		if string.Trim(msg) == "" then return end
		MsgN("[CSS] " .. msg .. " CSS weapons may not function properly!")
	end

	hook.Add("Initialize", "CheckForCSSInit", function() if (!CSRNag:GetBool()) then return end CheckForCSS() end)
	hook.Add("PlayerInitialSpawn", "CheckForCSSPIS", function(ply)
		if (!CSRNag:GetBool()) then return end
		net.Start("CheckForCSS")
			net.WriteTable({})
		net.Send(ply)
	end)
end

if CLIENT then

	function CSSNag(enum)

		local msg = ""
		if enum != 0 then
			msg = "You do not have CSS installed! Mount and/or purchase the game to get the full game content!"
		end

	end



	net.Receive("CheckForCSS", CheckForCSS)
end