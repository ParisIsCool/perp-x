--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]
// credits Jetboom
function BetterScreenScale(size)
	return size * math.max(0.5, ScrH() / 1200)
end

function ScaleToWideScreen(size)
	return math.min(math.max( ScreenScale(size / 2.62467192), math.min(size, 14) ), size);
end;
-- PERP
surface.CreateFont("ScoreboardHeader", {
	size = BetterScreenScale(42),
	-- weight = 400,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
surface.CreateFont("ScoreboardDesc", {
	size = BetterScreenScale(25),
	-- weight = 400,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
surface.CreateFont("ScoreboardJobs", {
	size = BetterScreenScale(20),
	-- weight = 400,
	antialias = true,
	shadow = false,
	font = "Verdana"})
surface.CreateFont("ScoreboardPlayerInfo", {
	size = BetterScreenScale(24),
	-- weight = 400,
	antialias = true,
	shadow = false,
	font = "Verdana"})
surface.CreateFont("ScoreboardAdminButtons", {
	size = BetterScreenScale(20),
	-- weight = 400,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
surface.CreateFont("ScoreboardPlayerRow", {
	size = BetterScreenScale(27),
	-- weight = 400,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
		
surface.CreateFont("Default", {
	size = BetterScreenScale(20),
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
	

// Fonts
surface.CreateFont("perp2_IntroTextBig", {
	size = ScaleToWideScreen(70),
	weight = 100,
	antialias = true,
	shadow = false,
	font = "coalition"})
surface.CreateFont("perp2_IntroTextSmall", {
	size = ScaleToWideScreen(70),
	weight = 100,
	antialias = true,
	shadow = false,
	font = "coalition"})

surface.CreateFont("HudFont", {
	size = BetterScreenScale(8),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("DefaultLarge", {
	size = BetterScreenScale(16),
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("DefaultSmall", {
	size = BetterScreenScale(12),
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("ConsoleText", {
	size = BetterScreenScale(8),
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("Trebuchet20", {
	size = 20,
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("HUDNumber3", {
	size = 28,
	weight = 400,
	antialias = true,
	shadow = false,
	font = "Tahoma"})

surface.CreateFont("TVLargeFont", {
	size = 40,
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("GModNotify", {
	size = 15,
	weight = 600,
	antialias = true,
	shadow = false,
	font = "Verdana"})
surface.CreateFont("Font", {
	size = 15,
	weight = 50,
	antialias = true,
	shadow = false,
	font = "Arial"})
surface.CreateFont("CardFont", {
	size = ScreenScale(12),
	weight = 800,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("SkillsFont", {
	size = ScreenScale(8),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("GeneFont", {
	size = ScreenScale(10),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("PlayerNameFont", {
	size = 20,
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
--surface.CreateFont("PEChatFont", {
--	size = 14,
--	--size = BetterScreenScale(10)
--	weight = 1000,
--	antialias = true,
--	shadow = false,
--	font = "Tahoma"})
surface.CreateFont("perp2_TextHUDBig", {
	size = 20,
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("perp2_TextHUDSmall", {
	size = 14,
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Arial"})
surface.CreateFont("HintFont", {
	size = ScreenScale(8),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})

surface.CreateFont("MixturesInfoFont", {
	size = ScreenScale(6),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("MixturesWarningFont2", {
	size =  ScreenScale(8),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("MixturesWarningFont", {
	size = ScreenScale(10),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("PhoneFont", {
	size = ScreenScale(7),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("PhoneFontSmall", {
	size = ScreenScale(6),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("RealtorFont", {
	size = 30,
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Arial"})
surface.CreateFont("ForcedFont", {
	size = 13,
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})
surface.CreateFont("ScoreboardPlayerName", {
	size = 19,
	weight = 500,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
surface.CreateFont("ScoreboardPlayerNameBig", {
	size = 22,
	weight = 500,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
-- surface.CreateFont("ScoreboardHeader", {
	-- size = 32,
	-- weight = 500,
	-- antialias = true,
	-- shadow = false,
	-- font = "coolvetica"})
surface.CreateFont("ScoreboardSubtitle", {
	size = 22,
	weight = 500,
	antialias = true,
	shadow = false,
	font = "coolvetica"})
surface.CreateFont("SkillsFont", {
	size = ScreenScale(8),
	weight = 1000,
	antialias = true,
	shadow = false,
	font = "Tahoma"})