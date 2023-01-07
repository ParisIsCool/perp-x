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

local function ShowUserCreationScreen ( )

  GAMEMODE:RollCinematics()
  //GAMEMODE:StopIntro()
  hook.Add("PostDrawHUD", "BackgroundBlurShit", function()
    -- background complete blur
    local x, y = 0,0

    local Fraction = 2.2

    local matBlurScreen = Material( "pp/blurscreen" )
    surface.SetMaterial( matBlurScreen )
    surface.SetDrawColor( 255, 255, 255, 255 )

    for i=0.33, 1, 0.33 do
      matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
      matBlurScreen:Recompute()
      if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
      surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
    end
    draw.RoundedBox(0, 0, 0, ScrW(), 100, Color(22,22,22,100))
    draw.RoundedBox(0, 0, ScrH()-100, ScrW(), 100, Color(22,22,22,200))
  end)


  local Models = JOB_DATABASE[TEAM_CITIZEN].Playermodels
  local curGender = SEX_MALE
  local curFace = 1
  local AccountCreationScreen = vgui.Create("paris_Frame")
  AccountCreationScreen:SetSize(650, 600)
  AccountCreationScreen:Center()
  AccountCreationScreen:SetTitle("Character Creation")
  AccountCreationScreen:SetVisible(true)
  AccountCreationScreen:SetDraggable(false)
  AccountCreationScreen:ShowCloseButton(false)
  AccountCreationScreen:MakePopup()
  AccountCreationScreen:SetAlpha(GAMEMODE.GetGUIAlpha())

  local defaultclothes = {[1] = 3, [2] = 5}

  local W, H = AccountCreationScreen:GetSize()

  local ModelGrid = vgui.Create( "DGrid", AccountCreationScreen )
  ModelGrid:SetPos( 10, 30 )
  ModelGrid:SetCols( 3 )
  ModelGrid:SetColWide( 110 )
  ModelGrid:SetRowHeight( 110 )

  local ourModel = Models[curGender][curFace]
  local selected
  local HappyGuy
  local function CreateCharacterBox(sex, face, model)
    local ModelPanel = vgui.Create('DModelPanel')
    ModelGrid:AddItem(ModelPanel)
    --ModelPanel:SetPos(5, 30)
    ModelPanel.sex = sex
    ModelPanel.face = face
    ModelPanel.model = model
    ModelPanel:SetSize(100, 100)
    ModelPanel:SetPos(5,5)
    ModelPanel:SetFOV(30)
    if sex == SEX_FEMALE then
      ModelPanel:SetCamPos(Vector(40, -20, 60))
      ModelPanel:SetLookAt(Vector(0,0,60))
    else
      ModelPanel:SetCamPos(Vector(40, -20, 63))
      ModelPanel:SetLookAt(Vector(0,0,63))
    end
    function ModelPanel:LayoutEntity( Entity )  end
    ModelPanel:SetModel(model)
    for k, v in pairs(defaultclothes) do
      ModelPanel:GetEntity():SetBodygroup(k,v)
    end
    local orig_col = Color(244,244,244,255)
    local highlight_col = Color(88, 233, 95,255)
    local col
    function ModelPanel:PaintOver(w,h)
      if selected == self then
        col = highlight_col
      else
        col = orig_col
      end
      draw.RoundedBox(0, 0, 0, w, 2, col)
      draw.RoundedBox(0, 0, 0, 2, h, col)
      draw.RoundedBox(0, w-2, 0, 2, h, col)
      draw.RoundedBox(0, 0, h-2, w, 2, col)
    end
    function ModelPanel:DoClick()
      selected = self
      curGender = sex
      curFace = face
      ourModel = model
      HappyGuy:SetModel(model)
      for k, v in pairs(defaultclothes) do
        HappyGuy:GetEntity():SetBodygroup(k,v)
      end
    end
  end

  for k, v in pairs(JOB_DATABASE[TEAM_CITIZEN].Playermodels[SEX_MALE]) do
    CreateCharacterBox(SEX_MALE,k, v)
  end
  for k, v in pairs(JOB_DATABASE[TEAM_CITIZEN].Playermodels[SEX_FEMALE]) do
    CreateCharacterBox(SEX_FEMALE,k, v)
  end

  local CharacterInfo = vgui.Create("DPanelList", AccountCreationScreen)
  CharacterInfo:EnableHorizontal(false)
  CharacterInfo:EnableVerticalScrollbar(true)
  CharacterInfo:StretchToParent(350, 30, 5, 5)
  CharacterInfo:SetPadding(5)

  HappyGuy = vgui.Create('DModelPanel',CharacterInfo)
  HappyGuy:SetSize(CharacterInfo:GetWide()-10,350)
  --HappyGuy:SetPos(5,CharacterInfo:GetTall()-305)
  HappyGuy:SetModel(ourModel)
  HappyGuy:SetFOV(60)
  HappyGuy:SetCamPos(Vector(70, 0, 40))
  HappyGuy:SetLookAt(Vector(0,0,40))
  for k, v in pairs(defaultclothes) do
		HappyGuy:GetEntity():SetBodygroup(k,v)
	end
  function HappyGuy:LayoutEntity( Entity )  end
  HappyGuy.OGPaint = HappyGuy.Paint
  local col = Color(33,33,33,255)
  local col_bright = Color(244,244,244,255)
  local modifyy = 46
  function HappyGuy:Paint(w,h,a,b,c)
    draw.RoundedBox(0, 0, modifyy, w, h-modifyy, col_bright)
    draw.RoundedBox(0, 2, 2+modifyy, w-4, h-4-modifyy, col)
    HappyGuy:OGPaint(w,h,a,b,c)
  end

  local UserNamel = vgui.Create("DLabel", CharacterInfo)
  UserNamel:SetPos(80, 30)
  UserNamel:SetSize(100, 20)
  UserNamel:SetText("Character's First Name:")
  CharacterInfo:AddItem(UserNamel)
  
  UserName = vgui.Create("paris_TextEntry", CharacterInfo)
  UserName:SetPos(80, 30)
  UserName:SetSize(100, 30)
  UserName:SetText("John")
  UserName:SetTabPosition(1)
  CharacterInfo:AddItem(UserName)
  
  local UserNamel = vgui.Create("DLabel", CharacterInfo)
  UserNamel:SetPos(80, 30)
  UserNamel:SetSize(100, 20)
  UserNamel:SetText("")
  CharacterInfo:AddItem(UserNamel)
  
  local UserNamel = vgui.Create("DLabel", CharacterInfo)
  UserNamel:SetPos(80, 30)
  UserNamel:SetSize(100, 20)
  UserNamel:SetText("Character's Last Name:")
  CharacterInfo:AddItem(UserNamel)
  
  UserPass = vgui.Create("paris_TextEntry", CharacterInfo)
  UserPass:SetPos(80, 30)
  UserPass:SetSize(100, 30)
  UserPass:SetText("Doe")
  UserPass:SetTabPosition(2)
  CharacterInfo:AddItem(UserPass)
  
  local UserNamel = vgui.Create("DLabel", CharacterInfo)
  UserNamel:SetPos(80, 30)
  UserNamel:SetSize(100, 20)
  UserNamel:SetText("")
  CharacterInfo:AddItem(UserNamel)
  
  local SubmitButton = vgui.Create("DButton", CharacterInfo)
  SubmitButton:SetPos(80, 30)
  SubmitButton:SetSize(100, 20)
  SubmitButton:SetText("Create User")
  
  CharacterInfo:AddItem(SubmitButton)

  CharacterInfo:AddItem(HappyGuy)
  
  local function MonitorColors ( wantReturn )
    if not IsValid(UserName) then return end
    local firstName = UserName:GetValue()
    local lastName = UserPass:GetValue()

    local anyInvalid = false
    
    if not GAMEMODE.IsValidPartialName(firstName) then
      UserName:SetTextColor(Color(255, 0, 0, 255))
      anyInvalid = true
    else
      UserName:SetTextColor(Color(0, 0, 0, 255))
    end

    if not GAMEMODE.IsValidPartialName(lastName) then
      UserPass:SetTextColor(Color(255, 0, 0, 255))
      anyInvalid = true
    else
      UserPass:SetTextColor(Color(0, 0, 0, 255))
    end
    
    if (not GAMEMODE.IsValidName(firstName, lastName, true)) then
      UserPass:SetTextColor(Color(255, 0, 0, 255))
      UserName:SetTextColor(Color(255, 0, 0, 255))
      anyInvalid = true
    end
    
    if (anyInvalid) then
      SubmitButton:SetEnabled(false)
    else
      SubmitButton:SetEnabled(true)
    end
    
    if (wantReturn) then
      return not anyInvalid
    end
  end
  hook.Add('Think', 'MonColors', MonitorColors)
  function SubmitButton:DoClick ( )
    if (!MonitorColors(true)) then
      LocalPlayer():Notify("Please fix any fields that may have errors.")
      return
    end
    
    hook.Remove("Think", 'MonColors')
    AccountCreationScreen:Remove()
    
    local modelinfo = {
      curGender,
      curFace,
      defaultclothes,
      0,
    }

    RunConsoleCommand("perp_nc", util.TableToJSON(modelinfo), UserName:GetValue(), UserPass:GetValue())

    GAMEMODE:StopCinematics()
    GAMEMODE:RollIntro()
    hook.Remove("PostDrawHUD", "BackgroundBlurShit")

  end
end

net.Receive("perp_newchar", ShowUserCreationScreen)