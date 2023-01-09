GM.Adverts = {
	"Thanks for playing on aSocket's PERP X!",
	"Verify your discord for free Gold VIP/perks! Issue the command '/discord' to get started! aSocket.net/discord",
	"Issues, suggestions, or bugs? Come chat with us! aSocket.net/discord",
	"Need an admin? Ask for support using /report!",
    "You can add the 'aSocket' tag to your username for an income tax break!",
	"Check out the achievements in the tab menu!",
    "Looking to stay secure on the internet? Get started with aSocket VPN @ aSocket.net!",
	"Make sure to read the rules in the tab menu, or via perp.aSocket.net/rules!",
    "Gold VIP is free! Issue the command '/discord' to get started!",
    "PERP X - Modern Roleplay Experience by aSocket.net",
    "Join the community Discord @ aSocket.net/discord!",
    "You can use code 'PERP5' for 5% off of aSocket VPN @ aSocket.net!"
}
local pos = 1

timer.Create( "AdvertTimer", 120, 0, function()
	if not aSoc.discord.enabled then if string.find(GAMEMODE.Adverts[pos],'/discord') then pos = pos + 1 end end
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint(GAMEMODE.Adverts[pos])
	end
	pos = pos + 1
	if(pos > #GAMEMODE.Adverts) then
		pos = 1
	end
end )

timer.Create( "AlertPeopleOnUpTime", 3600, 0, function()
	local up_time = math.Round( RealTime() / 60 / 60 )

	PrintMessage( HUD_PRINTTALK, Format( "The server has been up for %i hour(s) without crashing!", up_time ) )
end )