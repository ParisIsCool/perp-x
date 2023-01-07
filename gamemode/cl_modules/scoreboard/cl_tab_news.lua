module( "PulsarScoreboard", package.seeall )

RegisterTab( "News", 2, "ScoreboardNews" )

surface.CreateFont( "ScoreboardNewsDesc", { font = "Roboto Light", size = 15, weight = 200 } )
surface.CreateFont( "ScoreboardNewsTitle", { font = "Roboto Bold", size = 21, weight = 200 } )

// ================ NEWS

NEWS = {}
NEWS.Height = MinBodyHeight

local Updates = {
	{
        title="Initial Release - v1.0", 
        logo = "paris/updates/predperplogo2.png", 
        stuff = {
            "/don't_indent_me/12/18/21",
            "/don't_indent_me/Over the course of the past ~year we have continuously modified and added content to this gamemode",
            "/don't_indent_me/purely for fun. Listed below is a brief overview of the major gamemode changes. I'm sure a lot more",
            "/don't_indent_me/undocumented changes will be found throughout your time playing on the server.",
            "\n",
            "/don't_indent_me/PERP X - A Modern Roleplay Experience. The latest & final iteration of Pulsar Effect Roleplay.",
            "\n",
            "Bank Security Job",
            {
                "Bank security is charged with protecting the bank from robberies, and delivering money.",
                "Every so often a truck arrives for the bank security to transport money to the vault",
                "Bank robberies are no longer scripted - individuals can steal the money entities from the vault.",
                "Once stolen, the money is considered 'dirty' for a period of time before being able to collect it.",
                "This provides an incentive to continue roleplaying following a successful bank heist."
            },
            "Hunger System",
            {
                "Regenerates health in intervals if hunger is above threshold.",
                "Regenerates health nearly instantly if saturation is present.",
                "Takes health to ~20HP if hunger is empty.",
                "Removes the ability to sprint if hunger is empty.",
                "Gain hunger and generation by choosing your food selection wisely.",
                "Removes the ability to heal quickly by spamming melons."
            },
            "Food Items Added",
            "Working Mayor System",
            {
                "Modify/Overlook City Funds",
                "Add Custom Laws",
                "Can use weapons"
            },
            "Overhauled All User Interfaces",
            "Modern Phone",
            "Minimap/Blips",
            {
                "Important locations are automatically marked.", 
                "Purchased real estate is shown on the map.", 
                "Life alerts are shown on the map.",
                "The map can be expanded by pressing 'M', or 'Shift + 'ESC'."
            },
            "Arrested Animation",
            "Handsup Animation",
            {
                "Type the command '/handsup', or bind the command 'handsup' to a key."
            },
            "Fixed Achievements",
            "Clothing Systen",
            "New Car Radio",
            "Presents hidden around the map",
            "Randomly spawn guns around the map",
            "Car modification animation/shop",
            "Fixed Chop Shop",
            "Santa's Gift Daily Wheel Spin",
            "Drug timer UI",
            "Discord Verification",
            "Free Gold VIP - type '/discord'",
            "Map Change",
            "Map changes from day to night automatically throughout the day",
            "Cinematic Introduction",
            "Spawn Animation",
            "New Weapon System",
            "Fixed Bugs",
            "Optimized Server",
            {"While the server runs much smoother - there is still lots to be done."},
            "Much more added, and to come.",
            "\n",
            "/don't_indent_me/We're always open to suggestions - come chat with us at aSocket.net/discord!",
            "\n",
            "\n"
	    }
    },

}

function NEWS:Init()

	self:SetTall( MinBodyHeight + 20 )

	self.Panel = vgui.Create("DPanel", self)
	local Panel = self.Panel

	Panel.ScrollPanel = vgui.Create("DScrollPanel", Panel)
	Panel.ScrollPanel.Paint = function(w,h)
		draw.RoundedBox(1, 0, 0, Panel.ScrollPanel:GetWide(), Panel.ScrollPanel:GetTall(), Color(22,22,22,200))
	end
	
	Panel.layout = vgui.Create("DListLayout", Panel.ScrollPanel)

	Panel.Updates = {}
	for k, v in pairs(Updates) do

		Panel.Updates[k] = vgui.Create("DPanel", Panel.layout)
		local p = Panel.Updates[k]
		local logoheight = 35
		if v.logo then
			p.logo = Material(v.logo)
			logoheight = 100
		end
		p.height = logoheight + 15 + 30
		local maxy = 15
		for k, thing in pairs(v.stuff) do if istable(thing) then for _, more in pairs(thing) do maxy = maxy + 20 end else maxy = maxy + 20 end end
		p.height = p.height + maxy
		p.Paint = function()
			draw.RoundedBox(0, 0, 0, p:GetWide(), 1, Color(77,77,77) )
			draw.SimpleText("" .. v.title, "ScoreboardNewsTitle", 75, 30 + logoheight, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			local y = 15
			for k, thing in pairs(v.stuff) do
				if istable(thing) then
					for _, more in pairs(thing) do
						y = y + 20
						draw.SimpleText("      -      " .. more, "ScoreboardNewsDesc", 75, 30 + logoheight+y, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					end
				else
					y = y + 20
                    -- due to how the system is created, I don't feel like modifying it to account for attributes per entry.
                    -- if this server ever grows and it is utilized, i will, but right now as it is checking for a table, and if presetn drawing each point, we'll just scuff it and store the data ina string lol
                    if thing == '\n' then
                        draw.SimpleText("", "ScoreboardNewsDesc", 75, 30 + logoheight+y, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    elseif thing:find("/don't_indent_me/") then
                        draw.SimpleText(thing:gsub("/don't_indent_me/", ""), "ScoreboardNewsDesc", 75, 30 + logoheight+y, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    else
					    draw.SimpleText("•      " .. thing, "ScoreboardNewsDesc", 75, 30 + logoheight+y, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                    end
				end
				if p.logo then
					surface.SetDrawColor(255, 255, 255, 255)
					surface.SetMaterial(p.logo)
					surface.DrawTexturedRect((self:GetWide()/2)-(p.logo:Width()/2), 15, p.logo:Width(), logoheight)
				elseif v.subtitle then
					draw.SimpleText(v.subtitle, "ScoreboardNewsTitle", p:GetWide()/2, (35/2) + 15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
		end

	end

	self:InvalidateLayout()

end

function NEWS:PerformLayout(w, h)
	
	self.Panel:SetSize(self:GetWide(),self:GetTall())
	self.Panel:SetPos((self:GetWide()*0.5)-(self.Panel:GetWide()/2),(self:GetTall()*0.5)-(self.Panel:GetTall()/2))

	self.Panel.ScrollPanel:SetSize(self.Panel:GetWide(),self.Panel:GetTall())
	self.Panel.ScrollPanel:SetPos(0,0)

	self.Panel.layout:SetSize(self.Panel.ScrollPanel:GetWide(), self.Panel.ScrollPanel:GetTall())
	self.Panel.layout:SetPos(0, 0)
	
	for k, v in pairs(self.Panel.Updates) do
		v:SetSize(self.Panel.layout:GetWide(),v.height)
	end

end


vgui.Register( "ScoreboardNews", NEWS )