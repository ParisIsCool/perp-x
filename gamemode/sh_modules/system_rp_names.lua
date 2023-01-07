--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

INVALID_RP_NAMES = {"penis", "fuck", "cunt", "ass", "nigger", "dick", "bluewaffle", "anal", "rape", "faggot", "fag ", " fag", "shit", "cock", "nigga", "fucker", "blackman", "bendover", "mcclusterfuck", "Nik Ker", "pussy", "mother", "minecraft", "letsplays", "quality", "content", "hue janus", "gaming", "puta doe", "kill", "kill me", "wtf", "dip shit", "fisterbottom", "tits" }

function GM.IsValidPartialName ( name )
	if string.len(name) < 3 then return false end
	if string.len(name) >= 16 then return false end

	local name = string.lower(name)

	local numDashes = 0
	for i = 1, string.len(name) do
		local validLetter = false
		local curChar = string.sub(name, i, i)

		if (curChar == "-") then
			numDashes = numDashes + 1

			if (numDashes > 1) then
				return false
			end
		end

		for k, v in pairs(VALID_NAME_CHARACTERS) do
			if (curChar == v) then
				validLetter = true
				break
			end
		end

		if (!validLetter) then
			return false
		end
	end

	return true
end

function GM.IsValidName ( first, last, skipFirstLast )
	local first = string.lower(first)
	local last = string.lower(last)

	if (!skipFirstLast) then
		if (!GAMEMODE.IsValidPartialName(first)) then return false end
		if (!GAMEMODE.IsValidPartialName(last)) then return false end
	end

	if first == "john" and last == "doe" then return false end

	return true
end
