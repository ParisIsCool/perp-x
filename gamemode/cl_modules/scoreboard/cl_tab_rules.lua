module( "PulsarScoreboard", package.seeall )

RegisterTab( "Rules", 3, "ScoreboardRules" )

// ================ RULES

RULES = {}
RULES.Height = MinBodyHeight + 350

function RULES:Init()

	CreateHTML( self, Web.Rules, MinBodyHeight )

	self:SetTall( self.Height )
	self:InvalidateLayout()

end

vgui.Register( "ScoreboardRules", RULES )