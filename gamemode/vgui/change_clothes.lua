surface.CreateFont("ChangeClothesFont", {
	font = "Roboto",
	size = 20,
})

function GM.Select_Clothes ( )

	local Changed = {}

	local W, H = 700, 600
	
	AccountCreationScreen = vgui.Create("DFrame")
	AccountCreationScreen:SetSize(W, H)
	AccountCreationScreen:SetTitle("Character Clothes")
	AccountCreationScreen:SetVisible(true)
	AccountCreationScreen:Center()
	AccountCreationScreen:SetDraggable(false)
	AccountCreationScreen:ShowCloseButton(true)
	AccountCreationScreen:MakePopup()
	AccountCreationScreen:SetAlpha(GAMEMODE.GetGUIAlpha())
	
	local ModelPanel = vgui.Create('DModelPanel', AccountCreationScreen)
	ModelPanel:SetPos(W/2 + 10, 30)
	ModelPanel:SetSize(W/2 - 20, H-30)
	ModelPanel:SetFOV(40)
	ModelPanel:SetModel(LocalPlayer():GetModel())
	local campos = Vector(25,0,65)
    local camposinf = Vector(70,0,40)
	function ModelPanel:LayoutEntity( ent )
		campos = LerpVector( 25 * FrameTime(), campos, camposinf )
        self:SetCamPos(campos)
        if input.IsMouseDown(MOUSE_LEFT) then
            local x,y = self:LocalCursorPos()
            if y < 0 or y > self:GetTall() then return end
            if x < 0 or x > self:GetWide() then return end
            local deg = ((math.Clamp(x, 0, ModelPanel:GetWide()))/ModelPanel:GetWide())*180
            local deg2 = (((math.Clamp(y, 0, ModelPanel:GetTall()))/ModelPanel:GetTall())*-90) + 90
            camposinf = Vector(70*math.sin(deg*(math.pi/180)),70*math.cos(deg*(math.pi/180)), 70*math.cos(deg2*(math.pi/180)))
            -- soh cah toa
            self.Entity:SetEyeTarget(camposinf)
        end
    end

	local i = 0
	local tab = JOB_DATABASE[LocalPlayer():Team()].Bodygroups[LocalPlayer():GetSex()] or {}
	local spot = (H/2) - (((table.Count(tab)+1)*50)/2)
	for k, v in pairs(tab) do
		local Choice = vgui.Create("DPanel", AccountCreationScreen)
		Choice:SetSize(340,40)
		Choice:SetPos(30,spot + ((Choice:GetTall()+10)*i))
		local selected = 1
		local function SetBodygroup(id,value)
			Changed[id] = value
			ModelPanel.Entity:SetBodygroup(id,value)
		end
		function Choice:Paint(w,h)
			local col = Color(255,255,255,(50 + (255*math.abs(math.sin(CurTime()*4))))*0.05)
			draw.RoundedBox(0, 0, 0, w, 1, col)
			draw.RoundedBox(0, 0, h-1, w, 1, col)
			draw.RoundedBox(0, 0, 0, 1, h, col)
			draw.RoundedBox(0, w-1, 0, 1, h, col)
			draw.SimpleText(k, "ChangeClothesFont", 10, Choice:GetTall()/2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(v.Submodels[selected][2], "ChangeClothesFont", Choice:GetWide()-110, Choice:GetTall()/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		local Right = vgui.Create("paris_Button", Choice)
		Right:SetSize(40,40)
		Right:SetText(">")
		Right:SetPos(Choice:GetWide()-Right:GetWide())
		function Right:DoClick()
			selected = selected + 1
			if selected > #v.Submodels then
				selected = 1
			end
			SetBodygroup(v.ID,v.Submodels[selected][1])
		end
		local Left = vgui.Create("paris_Button", Choice)
		Left:SetSize(40,40)
		Left:SetText("<")
		Left:SetPos(Choice:GetWide()-(Left:GetWide()*2)-(60*2)-20)
		function Left:DoClick()
			selected = selected - 1
			if selected < 1 then
				selected = #v.Submodels
			end
			SetBodygroup(v.ID,v.Submodels[selected][1])
		end
		i = i + 1
	end
	
	local iSeq = ModelPanel.Entity:LookupSequence('walk_all')
	ModelPanel.Entity:ResetSequence(iSeq)
	
	local Finish = vgui.Create("DButton", AccountCreationScreen)
	Finish:SetSize(340,40)
	Finish:SetText("Finish ($1,000)")
	Finish:SetPos(30,spot + ((40+10)*i))
	function Finish:DoClick()
		AccountCreationScreen:Remove()
		net.Start("perp_cc") net.WriteTable(Changed) net.SendToServer()
	end

end
