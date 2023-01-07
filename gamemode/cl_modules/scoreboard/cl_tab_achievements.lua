module( "PulsarScoreboard", package.seeall )

RegisterTab( "Achievements", 4, "ScoreboardAchievements" )

surface.CreateFont( "ScoreboardAchiTitle", { font = "Roboto Condensed", size = 24, weight = 200 } )
surface.CreateFont( "ScoreboardAchiDesc", { font = "Roboto Light", size = 20, weight = 200 } )

// ================ ACHIEVEMENTS

ACHIEVEMENTS = {}
ACHIEVEMENTS.Height = MinBodyHeight + 300

function ACHIEVEMENTS:Init()

	self:SetTall( MinBodyHeight )

	self.Panel = vgui.Create("DPropertySheet", self)
	local Panel = self.Panel
	Panel.Paint = function(w,h)
		--draw.RoundedBox(1, 0, 0, Panel:GetWide(), Panel:GetTall(), Color(66,66,66,200))
	end

	local classes = {}
	
	for k, v in pairs(ACHIEVEMENT_DATABASE) do
		classes[v.Class] = true
	end
	
	for class, v in pairs(classes) do

		local Panel = vgui.Create("DPanel", self)
		Panel.Paint = function(w,h)
			--draw.RoundedBox(1, 0, 0, Panel:GetWide(), Panel:GetTall(), Color(66,66,66,200))
		end

		self.Panel:AddSheet(class, Panel)

		Panel.ScrollPanel = vgui.Create("DScrollPanel", Panel)
		Panel.ScrollPanel.Paint = function(w,h)
			draw.RoundedBox(1, 0, 0, Panel.ScrollPanel:GetWide(), Panel.ScrollPanel:GetTall(), Color(22,22,22,200))
		end
		
		Panel.layout = vgui.Create("DListLayout", Panel.ScrollPanel)
		
		local GradientUp = Material( "gui/gradient_up" )
		local confirm

		Panel.Achievements = {}
		for k, v in pairs(ACHIEVEMENT_DATABASE) do

			if class != v.Class then continue end

			Panel.Achievements[k] = vgui.Create("DPanel", Panel.layout)
			Panel.Achievements[k]:SetText("")
			Panel.Achievements[k].Paint = function()

				local w,h = Panel.Achievements[k]:GetSize()

				draw.RoundedBox(0, 0, 0, w, h, Color( 30, 30, 30, 200 ))

				surface.SetDrawColor( 20,20,20,200 )
				surface.SetMaterial( GradientUp )
				surface.DrawTexturedRect( 0, 0, w, h )
		
				draw.SimpleText(v.Title , "ScoreboardAchiTitle", 75, (h/4), Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				draw.SimpleText(v.Desc , "ScoreboardAchiDesc", 75, (h/4)*2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				if isnumber(v.Reward) then
					draw.SimpleText("Reward: $" .. string.Comma(v.Reward) , "ScoreboardAchiDesc", 75, (h/4)*3, Color(255,255,255,75), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end


				draw.SimpleText("STATUS", "ScoreboardAchiDesc", w-25, (h/4)*1, Color(255,255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

				if v.Bool then
					local status = "INCOMPLETE"
					local color = Color(176, 84, 84)
					if LocalPlayer()["PERP_Achivements"] and LocalPlayer()["PERP_Achivements"][v.Index] and LocalPlayer()["PERP_Achivements"][v.Index] >= 1 then
						status = "COMPLETE"
						color = Color(87, 176, 84)
					end
					draw.SimpleText(status, "ScoreboardAchiDesc", w-25, (h/4)*3, color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				elseif isnumber(v.Goal) then
					local status = tostring(LocalPlayer()["PERP_Achivements"][v.Index] or "0") .. " out of " .. tostring(v.Goal)
					local color = Color(255, 255, 255)
					if LocalPlayer()["PERP_Achivements"] and LocalPlayer()["PERP_Achivements"][v.Index] and LocalPlayer()["PERP_Achivements"][v.Index] >= v.Goal then
						status = "COMPLETE"
						color = Color(87, 176, 84)
					end
					draw.SimpleText(status, "ScoreboardAchiDesc", w-25, (h/4)*3, color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					--draw.SimpleText(tostring(LocalPlayer()["PERP_Achivements"][v.Index] or "0") .. " out of " .. tostring(v.Goal), "ScoreboardAchiDesc", w-25, (h/4)*3, color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
				
				surface.SetDrawColor( 255,255,255,255 )
				surface.SetMaterial( v.Material )
				surface.DrawTexturedRect( 5, 5, 64, 64 )
		
			end
		
		end

	end

	self:InvalidateLayout()

end

function ACHIEVEMENTS:PerformLayout(w, h)
	
	self.Panel:SetSize(self:GetWide(),self:GetTall())
	self.Panel:SetPos((self:GetWide()*0.5)-(self.Panel:GetWide()/2),(self:GetTall()*0.5)-(self.Panel:GetTall()/2))

	for k, v in pairs(self.Panel:GetItems()) do
		v.Panel:SetSize(self.Panel:GetWide(),self.Panel:GetTall())
		--v.Panel:SetPos((self.Panel:GetWide()*0.5)-(v:GetWide()/2),(self.Panel:GetTall()*0.5)-(v:GetTall()/2))

		v.Panel.ScrollPanel:SetSize(v.Panel:GetWide()-20,v.Panel:GetTall()-35)
		v.Panel.ScrollPanel:SetPos(0,0)
	
		v.Panel.layout:SetSize(v.Panel.ScrollPanel:GetWide(), 74)
		v.Panel.layout:SetPos(0, 0)
		
		for k, ach in pairs(v.Panel.Achievements) do
			ach:SetSize(v.Panel.layout:GetWide(), v.Panel.layout:GetTall())
		end


	end

end


vgui.Register( "ScoreboardAchievements", ACHIEVEMENTS )