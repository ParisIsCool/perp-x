--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- TODO: Clean up

local PANEL = {}

surface.CreateFont("mayor_tabfont", {
	font = "Roboto Medium",
	size = 16,
	antialias=true
})

local paydaynext = nextPayDay or 0
net.Receive("nextpaydaysoon", function()
	nextPayDay = CurTime() + 120
	paydaynext = nextPayDay
end)

function PANEL:Init()
	self:ShowCloseButton( true )
	self:SetSize(700,500)
	self:Center()
	self:MakePopup()
	self:SetSizable(true)
	self:SetDraggable(true)
	self:SetMinWidth(300)
	self:SetMinHeight(300)
	self:SetTitle("Mayor Controls")

	-- tab system
	local sheet = vgui.Create( "DPropertySheet", self )
	sheet:Dock( FILL )

	local function AddSlider(text,p,x,y,w,h,min,max,default,onchange)
		local b = vgui.Create("DNumSlider",p)
		b:SetSize(w,h)
		b:SetPos(x,y)
		b:SetText(text)
		b:SetMin(min)
		b:SetMax(max)
		b:SetDecimals(0)
		b:SetValue(default)
		function b:OnValueChanged(v) onchange(math.floor(v)) end
	end



	// OVERVIEW << << < < <

	local Overview = vgui.Create( "DPanel", sheet )
	local colorbg = Color(22,22,22,100)
	local accentcolor = Color(27,110,34)
	local accentcolorred = Color(110,27,27)
	function Overview:Paint(w,h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg )

		// TOP RIGHT
		local rat
		if GAMEMODE.CityBudget_LastExpenses != 0 then
			rat = (GAMEMODE.CityBudget_LastIncome-(GAMEMODE.CityBudget_LastExpenses*-1))/(GAMEMODE.CityBudget_LastExpenses*-1)
		else
			rat = 0
		end
		draw.SimpleText("Profit Ratio ("..math.Round(rat*100).."%)","mayor_tabfont",w-100,100,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.NoTexture()
		draw.Arc(w-100,100,75,12,0,360,8,color_white)
		if rat > 0 then
			draw.Arc(w-100,100,74,10,90,90+(360*rat),1,accentcolor)
		else
			draw.Arc(w-100,100,74,10,90+(360*rat),90,1,accentcolorred)
		end

		local diff = math.Clamp(paydaynext-CurTime(),-121,1000)
		draw.SimpleText("Next Payday (" .. math.Round(diff) ..  "s)","mayor_tabfont",w-275,100,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.NoTexture()
		draw.Arc(w-275,100,75,12,0,360,8,color_white)
		draw.Arc(w-275,100,74,10,90,90+(360*(diff/120)),1,accentcolor)


		// RIGHT
		draw.SimpleText("City Budget: " .. "$"..string.Comma(GAMEMODE.CityBudget),"mayor_tabfont",w-25,190,color_white,TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
		draw.SimpleText("Last Period Expenses: " .. "$"..string.Comma(GAMEMODE.CityBudget_LastExpenses),"mayor_tabfont",w-25,210,color_white,TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)
		draw.SimpleText("Last Period Income: " .. "$"..string.Comma(GAMEMODE.CityBudget_LastIncome),"mayor_tabfont",w-25,230,color_white,TEXT_ALIGN_RIGHT,TEXT_ALIGN_TOP)

		// LEFT SIDE
		draw.RoundedBox( 0, 25, 25, (w/2)-50, h-50, colorbg )
		local n = 0
		for k, v in pairs(JOB_DATABASE) do
			if n%2==0 then
				draw.RoundedBox( 0, 45, 50+(n*16), (w/2)-95, 16, colorbg )
			else
				draw.RoundedBox( 0, 45, 50+(n*16), (w/2)-95, 16, accentcolor )
			end
			draw.SimpleText((v.NamePlural or (v.Name.."s")) ..": "..#team.GetPlayers(k),"mayor_tabfont",50,50+(n*16),color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
			n=n+1
		end
	end
	--text,p,x,y,w,h,min,max,default,onchange
	local w,h = 674,430
	AddSlider("Sales Tax",Overview,(w/2)+25,(h-200)+(30*1),(w/2)-50,30,0,50,GAMEMODE.GetTaxRate_Sales(),function(value) RunConsoleCommand("perp_m_t_s",math.Round(value)) end)
	AddSlider("Income Tax",Overview,(w/2)+25,(h-200)+(30*2),(w/2)-50,30,0,50,GAMEMODE.GetTaxRate_Income(),function(value) RunConsoleCommand("perp_m_t_i",math.Round(value)) end)
	AddSlider("Parking Ticket Fee",Overview,(w/2)+25,(h-200)+(30*3),(w/2)-50,30,10,750,GetGNWVar( "ticket_price" ),function(value) RunConsoleCommand("perp_m_ticket_p",math.Round(value)) end)
	AddSlider("Inner City Speed Limit",Overview,(w/2)+25,(h-200)+(30*4),(w/2)-50,30,10,100,GetGNWVar( "innercity_speedlimit_i" ),function(value) RunConsoleCommand("perp_m_sl_i",math.Round(value)) end)
	AddSlider("Outer City Speed Limit",Overview,(w/2)+25,(h-200)+(30*5),(w/2)-50,30,10,100,GetGNWVar( "innercity_speedlimit_o" ),function(value) RunConsoleCommand("perp_m_sl_o",math.Round(value)) end)
	sheet:AddSheet( "Overview", Overview, "icon16/application_home.png" )


	// WAGES << << < < <

	local Wages = vgui.Create( "DPanel", sheet )
	Wages:SetSize(650, 400)
	local WagesSP = aSoc.DarkScrollPanel(Wages)
	WagesSP:SetSize(Wages:GetWide()*0.9, Wages:GetTall()*0.8)
	WagesSP:SetPos(Wages:GetWide()*0.05, Wages:GetTall()*0.05)
	local WagesL = vgui.Create("DListLayout", WagesSP)
	WagesL:SetSize(WagesSP:GetSize())
	local colorbg = Color(22,22,22,100)
	local accentcolor = Color(27,110,34)
	local accentcolorred = Color(110,27,27)
	function WagesL:Paint(w,h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg )
	end
	local n=1
	local NewWages = {}
	for k, v in pairs(GAMEMODE.JobWages) do
		AddSlider(JOB_DATABASE[k].Name .. " wage:",WagesL,50,(50*n)+50,300,50,10,v+200,v,function(panel,value)
			NewWages[k] = value
		end)
		n=n+1
	end
	local saveandannounce = vgui.Create("paris_Button",Wages)
	saveandannounce:SetSize(200,30)
	saveandannounce:SetPos(50,Wages:GetTall()*0.9)
	saveandannounce:SetText("Save & Announce Changes")
	function saveandannounce:DoClick()
		net.Start("mayor_announceandsavewages")
		net.WriteTable(NewWages)
		net.SendToServer()
	end
	sheet:AddSheet( "Wages", Wages, "icon16/money.png" )


	// JOBINFO << << < < <

	local JobInfo = vgui.Create( "DPanel", sheet )
	JobInfo:SetSize(650, 400)
	local JobInfoSP = aSoc.DarkScrollPanel(JobInfo)
	JobInfoSP:SetSize(JobInfo:GetWide()*0.9, JobInfo:GetTall()*0.8)
	JobInfoSP:SetPos(JobInfo:GetWide()*0.05, JobInfo:GetTall()*0.05)
	local JobInfoL = vgui.Create("DListLayout", JobInfoSP)
	JobInfoL:SetSize(JobInfoSP:GetSize())
	local colorbg = Color(22,22,22,100)
	local accentcolor = Color(27,110,34)
	local accentcolorred = Color(110,27,27)
	function JobInfoL:Paint(w,h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg )
	end
	local n=1
	local NewMaxes = {}
	for k, v in pairs(GAMEMODE.MaxJobs) do
		local jb = JOB_DATABASE[k]
		if not jb then continue end
		local max = jb.MaxPlayers
		if max == true then continue end
		AddSlider("Max " .. (jb.NamePlural or (jb.Name.."s")) .. ": ",JobInfoL,50,(50*n)+50,300,50,0,jb.MaxPlayers or 1,v,function(panel,value)
			NewMaxes[k] = value
		end)
		n=n+1
	end
	local saveandannounce = vgui.Create("paris_Button",JobInfo)
	saveandannounce:SetSize(200,30)
	saveandannounce:SetPos(50,JobInfo:GetTall()*0.9)
	saveandannounce:SetText("Save & Announce Changes")
	function saveandannounce:DoClick()
		net.Start("mayor_announceandsavejobsmaxes")
		net.WriteTable(NewMaxes)
		net.SendToServer()
	end
	sheet:AddSheet( "Job Info", JobInfo, "icon16/book_open.png" )

	// Max Vehicles << << < < <

	local MaxV = vgui.Create( "DPanel", sheet )
	MaxV:SetSize(650, 400)
	local MaxVSP = aSoc.DarkScrollPanel(MaxV)
	MaxVSP:SetSize(MaxV:GetWide()*0.9, MaxV:GetTall()*0.8)
	MaxVSP:SetPos(MaxV:GetWide()*0.05, MaxV:GetTall()*0.05)
	local MaxVL = vgui.Create("DListLayout", MaxVSP)
	MaxVL:SetSize(MaxVSP:GetSize())
	local colorbg = Color(22,22,22,100)
	local accentcolor = Color(27,110,34)
	local accentcolorred = Color(110,27,27)
	function MaxVL:Paint(w,h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg )
	end
	local n=1
	local NewMaxes = {}
	for k, v in pairs(GAMEMODE.MaxVehicles) do
		local jb = JOB_DATABASE[k]
		if not jb then continue end
		local max = jb.MaxVehicles
		if max == true then continue end
		AddSlider("Max " .. (jb.NamePlural or (jb.Name.."s")) .. " vehicles: ",MaxVL,50,(50*n)+50,300,50,0,jb.MaxVehicles or 1,v,function(panel,value)
			NewMaxes[k] = value
		end)
		n=n+1
	end
	local saveandannounce = vgui.Create("paris_Button",MaxV)
	saveandannounce:SetSize(200,30)
	saveandannounce:SetPos(50,MaxV:GetTall()*0.9)
	saveandannounce:SetText("Save & Announce Changes")
	function saveandannounce:DoClick()
		net.Start("mayor_announceandsavevehiclemaxes")
		net.WriteTable(NewMaxes)
		net.SendToServer()
	end
	sheet:AddSheet( "Max Vehicles", MaxV, "icon16/lorry.png" )

	// Demotions << << < < <

	local Demotions = vgui.Create( "DPanel", sheet )
	Demotions:SetSize(650, 400)
	local DemotionsSP = aSoc.DarkScrollPanel(Demotions)
	DemotionsSP:SetSize(Demotions:GetWide()*0.9, Demotions:GetTall()*0.9)
	DemotionsSP:SetPos(Demotions:GetWide()*0.05, Demotions:GetTall()*0.05)
	local DemotionsL = vgui.Create("DListLayout", DemotionsSP)
	DemotionsL:SetSize(DemotionsSP:GetSize())
	local colorbg = Color(22,22,22,100)
	local accentcolor = Color(27,110,34)
	local accentcolorred = Color(110,27,27)
	function DemotionsL:Paint(w,h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg )
	end
	local n=1
	for k, v in pairs(player.GetAll()) do
		if v:Team() == TEAM_CITIZEN then continue end
		local jb = JOB_DATABASE[v:Team()]
		local ply = vgui.Create("paris_Button",DemotionsL)
		ply:SetSize(400,30)
		ply:SetPos(0, 35*(n))
		local m = n
		function ply:PaintOver(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(201, 182, 112,30*(m%2)))
			if not IsValid(v) then return end
			draw.SimpleTextOutlined(v:GetRPName(), "DermaDefaultBold", 20, 15, color_white, TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 1, color_black)
			draw.SimpleTextOutlined(jb.Name, "DermaDefaultBold", 300, 15, color_white, TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 1, color_black)
		end
		ply:SetText("")
		function ply:DoClick()
			if not IsValid(v) then return end
			Derma_Query( "Are you sure you want to do demote " .. v:GetRPName() .. "?", "Demote Player",
			"No...", function() end,
			"Yes, I'm sure.", function()
				surface.PlaySound("yourefired.mp3")
				ply:Remove()
				net.Start("mayor_fire")
				net.WriteEntity(v)
				net.SendToServer()
			end )
		end
		n=n+1
	end
	sheet:AddSheet( "Demotions", Demotions, "icon16/delete.png" )

	// Warrants << << < < <

	local Warrants = vgui.Create( "DPanel", sheet )
	Warrants:SetSize(650, 400)
	local WarrantsSP = aSoc.DarkScrollPanel(Warrants)
	WarrantsSP:SetSize(Warrants:GetWide()*0.9, Warrants:GetTall()*0.9)
	WarrantsSP:SetPos(Warrants:GetWide()*0.05, Warrants:GetTall()*0.05)
	local WarrantsL = vgui.Create("DListLayout", WarrantsSP)
	WarrantsL:SetSize(WarrantsSP:GetSize())
	local colorbg = Color(22,22,22,100)
	local accentcolor = Color(27,110,34)
	local accentcolorred = Color(110,27,27)
	function WarrantsL:Paint(w,h)
		draw.RoundedBox( 0, 0, 0, w, h, colorbg )
	end
	local n=1
	for k, v in pairs(player.GetAll()) do
		if v:Team() != TEAM_CITIZEN then continue end
		local jb = JOB_DATABASE[v:Team()]
		local ply = vgui.Create("paris_Button",WarrantsL)
		ply:SetSize(400,30)
		ply:SetPos(0, 35*(n))
		local m = n
		function ply:PaintOver(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(201, 182, 112,30*(m%2)))
			if not IsValid(v) then return end
			draw.SimpleTextOutlined(v:GetRPName(), "DermaDefaultBold", 20, 15, color_white, TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER, 1, color_black)
		end
		ply:SetText("")
		function ply:DoClick()
			if not IsValid(v) then return end
			Derma_Query( "Are you sure you want to do warrant " .. v:GetRPName() .. "?", "Warrant Player",
			"No...", function() end,
			"Yes, I'm sure.", function()
				ply:Remove()
				RunConsoleCommand("perp_g_w", v:UniqueID(), "Illegal Activities.")
			end )
		end
		n=n+1
	end
	sheet:AddSheet( "Warrants", Warrants, "icon16/flag_red.png" )

	// Laws << << < < <

	local Laws = vgui.Create( "DPanel", sheet )
	Laws:SetSize(650, 400)
	local LawsText = vgui.Create("paris_TextEntry",Laws)
	LawsText:SetSize(600,325)
	LawsText:SetPos(25,25)
	LawsText:SetMultiline( true )
	LawsText:SetText(GAMEMODE.MayorLaws or "")
	local saveandannounce = vgui.Create("paris_Button",Laws)
	saveandannounce:SetSize(600,30)
	saveandannounce:SetPos(25,350)
	saveandannounce:SetText("Save & Announce Changes")
	function saveandannounce:DoClick()
		net.Start("mayor_announcenewlaws")
		net.WriteString(LawsText:GetValue())
		net.SendToServer()
	end
	sheet:AddSheet( "Laws", Laws, "icon16/gun.png" )

end

function PANEL:ThinkOver( )

end

function PANEL:OverPerformLayout()

end

vgui.Register("perp2_mayor_tab", PANEL, "paris_Frame")