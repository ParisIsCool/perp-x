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

function GM.Select_Face ( )
	local Models = {}
	
	local sexID = LocalPlayer():GetSex()
	
	local curModelReference = 1

	local W, H = 400, 380
	
	AccountCreationScreen = vgui.Create("DFrame")
	AccountCreationScreen:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	AccountCreationScreen:SetSize(W, H)
	AccountCreationScreen:SetTitle("Character Facial")
	AccountCreationScreen:SetVisible(true)
	AccountCreationScreen:SetDraggable(false)
	AccountCreationScreen:ShowCloseButton(true)
	AccountCreationScreen:MakePopup()
	AccountCreationScreen:SetAlpha(GAMEMODE.GetGUIAlpha())
	
	local PanelSize = W - 10
	local UsCash = vgui.Create("DPanelList", AccountCreationScreen)
	UsCash:EnableHorizontal(false)
	UsCash:EnableVerticalScrollbar(true)
	UsCash:StretchToParent(5, 30, 5, 5)
	UsCash:SetPadding(5)
	
	local ModelPanel = vgui.Create('DModelPanel', AccountCreationScreen)
	ModelPanel:SetPos(5, 30)
	ModelPanel:SetSize(W - 20, H-130)
	ModelPanel:SetFOV(50)
	ModelPanel:SetCamPos(Vector(25, 0, 65))
	local campos = Vector(20, 0, 65)
    local camposinf = Vector(25, 0, 65)
	function ModelPanel:LayoutEntity( ent )
		campos = LerpVector( 25 * FrameTime(), campos, camposinf )
        self:SetCamPos(campos)
        if input.IsMouseDown(MOUSE_LEFT) then
            local x,y = self:LocalCursorPos()
            if y < 0 or y > self:GetTall() then return end
            if x < 0 or x > self:GetWide() then return end
            local deg = ((math.Clamp(x, 0, ModelPanel:GetWide()))/ModelPanel:GetWide())*180
            local deg2 = (((math.Clamp(y, 0, ModelPanel:GetTall()))/ModelPanel:GetTall())*-90) + 90
            camposinf = Vector(25*math.sin(deg*(math.pi/180)),25*math.cos(deg*(math.pi/180)), 55+(20*math.cos(deg2*(math.pi/180))))
            -- soh cah toa
        end
		self.Entity:SetEyeTarget(campos)
    end
	
	if (sexID == SEX_MALE) then
		ModelPanel:SetLookAt(CAM_LOOK_AT[SEX_MALE] - Vector(0,0,1))
	else
		ModelPanel:SetLookAt(CAM_LOOK_AT[SEX_FEMALE] - Vector(0,0,1))
	end
	
	ModelPanel:SetModel(LocalPlayer():GetModel())
	ModelPanel.Entity:SetSkin(LocalPlayer():GetSkin())
	local ourModel = LocalPlayer():GetModel()
	local ourSkin = LocalPlayer():GetSkin()
	local skinsAvailable = ModelPanel.Entity:SkinCount()
	for k, v in pairs(LocalPlayer():GetBodyGroups()) do
		ModelPanel.Entity:SetBodygroup(v.id,LocalPlayer():GetBodygroup(v.id))
	end
	local function SetNewFace(num,skin)
		ourModel = JOB_DATABASE[TEAM_CITIZEN].Playermodels[sexID][num]
		ModelPanel:SetModel(ourModel)
		ModelPanel.Entity:SetSkin(skin)
		skinsAvailable = ModelPanel.Entity:SkinCount()
		for k, v in pairs(LocalPlayer():GetBodyGroups()) do
			ModelPanel.Entity:SetBodygroup(v.id,LocalPlayer():GetBodygroup(v.id))
		end
	end
	
	local r110 = (W - 25) * .5
	local LeftButton = vgui.Create("DButton", AccountCreationScreen)
	LeftButton:SetPos(10, H - 80)
	LeftButton:SetSize(r110, 20)
	LeftButton:SetText("<")
	
	function LeftButton:DoClick ( )
		ourSkin = ourSkin - 1
		if (ourSkin < 0) then
			ourSkin = skinsAvailable
		end

		SetNewFace(curModelReference,ourSkin)
	end
		
	local RightButton = vgui.Create("DButton", AccountCreationScreen)
	RightButton:SetPos(15 + r110, H - 80)
	RightButton:SetSize(r110, 20)
	RightButton:SetText(">")
		
	function RightButton:DoClick ( )
		ourSkin = ourSkin + 1
		if (ourSkin > skinsAvailable) then
			ourSkin = 0
		end
			
		SetNewFace(curModelReference,ourSkin)
	end

	local LeftButton = vgui.Create("DButton", AccountCreationScreen)
	LeftButton:SetPos(10, H - 55)
	LeftButton:SetSize(r110, 20)
	LeftButton:SetText("<")
	
	function LeftButton:DoClick ( )
		curModelReference = curModelReference - 1
		if (curModelReference < 1) then
			curModelReference = #JOB_DATABASE[TEAM_CITIZEN].Playermodels[sexID]
		end
		
		ourSkin = 0
		SetNewFace(curModelReference,0)
	end
		
	local RightButton = vgui.Create("DButton", AccountCreationScreen)
	RightButton:SetPos(15 + r110, H - 55)
	RightButton:SetSize(r110, 20)
	RightButton:SetText(">")
		
	function RightButton:DoClick ( )
		curModelReference = curModelReference + 1
		if (curModelReference > #JOB_DATABASE[TEAM_CITIZEN].Playermodels[sexID]) then
			curModelReference = 1
		end
			
		ourSkin = 0
		SetNewFace(curModelReference,0)
	end
	
	local SubmitButton = vgui.Create("DButton", AccountCreationScreen)
	SubmitButton:SetPos(10, H - 30)
	SubmitButton:SetSize(W - 20, 20)
	SubmitButton:SetText("Confirm")
		
	function SubmitButton:DoClick ( )
		AccountCreationScreen:Remove()
			
		RunConsoleCommand("perp_cf", curModelReference, ourSkin)
	end
end
