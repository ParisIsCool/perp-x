--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function TimeToString( x )
	local r, years, months, weeks, days, hours, minutes, seconds
	r = x % 31536000
	years = ( x - r ) / 31536000
	r = x % 2628000
	months = ( x - r ) / 2628000
	r = x % 604800
	weeks = ( x - r ) / 604800
	r = x % 86400
	days = ( x - r ) / 86400
	r = x % 3600
	hours = ( x - r ) / 3600
	r = x % 60
	minutes = ( x - r ) / 60
	seconds = r

	local ret = ""

	if years == 1 then ret = ret .. years .. " year "
	elseif years > 1 then ret = ret .. years .. " years " end
	if months == 1 then ret = ret .. months .. " month "
	elseif months > 1 then ret = ret .. months .. " months " end
	if weeks == 1 then ret = ret .. weeks .. " week "
	elseif weeks > 1 then ret = ret .. weeks .. " weeks " end
	if days == 1 then ret = ret .. days .. " day "
	elseif days > 1 then ret = ret .. days .. " days " end
	if hours == 1 then ret = ret .. hours .. " hour "
	elseif hours > 1 then ret = ret .. hours .. " hours " end
	if minutes == 1 then ret = ret .. minutes .. " minute "
	elseif minutes > 1 then ret = ret .. minutes .. " minutes " end
	if seconds == 1 then ret = ret .. seconds .. " second "
	elseif seconds > 1 then ret = ret .. seconds .. " seconds " end

	return ret
end

function ScaleToWideScreen(size)
	return math.min(math.max( ScreenScale(size / 2.62467192), math.min(size, 14) ), size);
end;

function PLAYER:IsInvisible()
	return self:GetColor().a < 10
end

function PLAYER:HasGod()
	return self:GetNWBool("Godmode")
end

if SERVER then

	hook.Add("Think", "CheckIfGodmodeChange", function()
		for k, v in pairs(player.GetAll()) do
			if v.LastGod != v:HasGodMode() then
				v:SetNWBool("Godmode", v:HasGodMode() )
			end
			v.LastGod = v:HasGodMode()
		end
	end)

end

local botnames = {
	"WifeEmailer",
	"RealBonJovi",
	"StillLubedUp",
	"iSawUrButt",
	"realSlimShady",
	"XHelloKittyX",
	"SixStringJim",
	"MoonMan13",
	"DeadSea",
	"VanossGaming",
	"CasualBombSquad",
	"Henta1GOD420",
	"GayWife13",
	"radiohead4life",
	"urmomsbuttXD",
	"NukeDaWhales",
	"cumslayer1114",
	"honkHonk",
}

function PLAYER:Nick()
	if self:IsBot() then
		if not self.BotNumber then
			self.BotNumber = tonumber(string.Replace(self:Name(),"Bot",""))
		end
		return botnames[self.BotNumber] or self:Name()
	else
		return self:Name()
	end
end

phoneRingTones = {
	[1] = 	{"perp2.5/ringtones/badtouch",			"Bad Touch"},
	[2] = 	{"perp2.5/ringtones/beverlyhillscopt",	"Cops"},
	[3] = 	{"perp2.5/ringtones/brit",				"Brit"},
	[4] = 	{"perp2.5/ringtones/candymountain",		"Candy Mountain"},
	[5] = 	{"perp2.5/ringtones/cencounters",		"Close Encounters"},
	[6] = 	{"perp2.5/ringtones/classic",			"Classic"},
	[7] = 	{"perp2.5/ringtones/digital",			"Digital"},
	[8] = 	{"perp2.5/ringtones/djsmash",			"Djs Smash"},
	[9] = 	{"perp2.5/ringtones/dnb",				"DnB"},
	[10] = 	{"perp2.5/ringtones/doorbell",			"Doorbell"},
	[11] = 	{"perp2.5/ringtones/dubstep",			"Dubstep"},
	[12] = 	{"perp2.5/ringtones/fatguyinlittlec",	"Fat Guy in Little Car"},
	[13] = 	{"perp2.5/ringtones/golden_party",		"Golden Party"},
	[14] = 	{"perp2.5/ringtones/gold",				"Gold"},
	[15] = 	{"perp2.5/ringtones/helliitsyourcell",	"Hello, Cellphone"},
	[16] = 	{"perp2.5/ringtones/human",				"Human"},
	[17] = 	{"perp2.5/ringtones/infinity",			"Infinity"},
	[18] = 	{"perp2.5/ringtones/jam",				"Jam"},
	[19] = 	{"perp2.5/ringtones/justhadsex",		"Just had Sex"},
	[20] = 	{"perp2.5/ringtones/letgo",				"Let Go"},
	[21] = 	{"perp2.5/ringtones/mario",				"Mario"},
	[22] = 	{"perp2.5/ringtones/milkshake",			"Milkshake"},
	[23] = 	{"perp2.5/ringtones/moskau",			"Moskau"},
	[24] = 	{"perp2.5/ringtones/mybunghole",		"My Bunghole"},
	[25] = 	{"perp2.5/ringtones/mysterious",		"Mysterious"},
	[26] = 	{"perp2.5/ringtones/pendulum",			"Pendulum"},
	[27] = 	{"perp2.5/ringtones/pjanno",			"Pjanno"},
	[28] = 	{"perp2.5/ringtones/pokemonthemeson",	"Pokemon Theme Song"},
	[29] = 	{"perp2.5/ringtones/raindrops",			"Raindrops"},
	[30] = 	{"perp2.5/ringtones/rejectionrington",	"Rejection Ringtone"},
	[31] = 	{"perp2.5/ringtones/rightthere",		"Right There"},
	[32] = 	{"perp2.5/ringtones/rockymovietheme",	"Rocky Theme"},
	[33] = 	{"perp2.5/ringtones/santa",				"Santa"},
	[34] = 	{"perp2.5/ringtones/shutyourmouth",		"Shut your Mouth"},
	[35] = 	{"perp2.5/ringtones/tetris",			"Tetris"},
	[36] = 	{"perp2.5/ringtones/topguntheme",		"Topgun Theme"},
	[37] = 	{"perp2.5/ringtones/turnlightsoff",		"Turn Lights Off"},
	[38] = 	{"perp2.5/ringtones/yourmommascalling",	"Your Mommas Calling"},
}