--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
//  Developed Listening To:  //
//      Cage The Beatles     //
///////////////////////////--]]

surface.CreateFont("ChooseCharTextHeader", {
  font = "Arial",
  weight = 0,
  size = 50,
  antialias = true,
})
surface.CreateFont("ChooseCharText", {
  font = "Arial",
  weight = 0,
  size = 30,
  antialias = true,
})

if not GAME_HAS_STARTED then
  -- lets make the screen black until this pops up.
  hook.Add("PostRenderVGUI", "BeginningBlackScreen", function()
    draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(17,17,17))
  end)
end

GAME_HAS_STARTED = true

local function ShowUserSelectionScreen(Users)
  if not LocalPlayer().IsVIP then -- function isnt initialized yet oops
    hook.Add("Think", "WaitTillVIP", function()
      if LocalPlayer().IsVIP then
        ShowUserSelectionScreen(Users)
        hook.Remove("Think", "WaitTillVIP")
      end
    end)
    return
  end
  GAMEMODE:RollCinematics()
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

  local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudGMod"] = true,
    ["CHudChat"] = true,
    ["NetGraph"] = true,
  }
  hook.Add( "HUDShouldDraw", "BackgroundBlurShit", function( name )
    if ( hide[ name ] ) then
      return false
    end
  end )
  GAMEMODE.DoNotDrawHUD = true
  if paris and paris.HUDSettings then
    paris.HUDSettings["DrawHUD"] = false
  end

  local Models = JOB_DATABASE[TEAM_CITIZEN].Playermodels
  local curGender = SEX_MALE
  local curFace = 1
  local Frame = vgui.Create("DFrame")
  Frame:SetSize(ScrW(), ScrH())
  Frame:Center()
  Frame:SetTitle("")
  Frame:SetVisible(true)
  Frame:SetDraggable(false)
  Frame:ShowCloseButton(false)
  Frame:MakePopup()
  function Frame:OnClose()
    GAMEMODE.DoNotDrawHUD = false
    GAMEMODE:StopCinematics()
    hook.Remove("PostDrawHUD", "BackgroundBlurShit")
    hook.Remove( "HUDShouldDraw", "BackgroundBlurShit")
    if paris and paris.HUDSettings then
      paris.HUDSettings["DrawHUD"] = true
    end
  end
  local GradientUp = Material( "gui/gradient_up" )
  local col = Color(22,22,22,150)
  function Frame:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,col)
  end

  local W, H = Frame:GetSize()

  local ModelGrid = vgui.Create( "DGrid", Frame )
  ModelGrid:SetPos( 0, 20 )
  ModelGrid:SetCols( 3 )
  ModelGrid:SetColWide( ScrW()/3 )
  ModelGrid:SetRowHeight( ScrH() )

  local function CreateCharacterBox(UserData,id)
    local ModelPanel = vgui.Create('DModelPanel')
    ModelGrid:AddItem(ModelPanel)
    ModelPanel:SetSize(ScrW()/3, ScrH())
    ModelPanel:SetPos(0,0)
    ModelPanel:SetFOV(40)
    if UserData.gender == SEX_FEMALE then
      ModelPanel:SetCamPos(Vector(50, 0, 60))
      ModelPanel:SetLookAt(Vector(0,0,60))
    else
      ModelPanel:SetCamPos(Vector(50, 0, 63))
      ModelPanel:SetLookAt(Vector(0,0,63))
    end
    function ModelPanel:LayoutEntity( ent )
      local x,y = self:LocalCursorPos()
      local roll = math.Clamp(((x / self:GetWide()) * 45) - (45/2),-45,45)
      local yaw = math.Clamp(((y / self:GetTall()) * -45) + (45/2),-45,45)
      self.Entity:ManipulateBoneAngles(self.Entity:LookupBone("ValveBiped.Bip01_Head1"), Angle(0,yaw,roll))

      self.Entity:SetEyeTarget(Angle(0,yaw,roll):Forward()*4 + Vector(0,0,65))
    end
    UserData.Model = util.JSONToTable(UserData.Model)
    if UserData.Model.gender then
      ModelPanel:SetModel(JOB_DATABASE[TEAM_CITIZEN].Playermodels[UserData.Model.gender][UserData.Model.face])
    else
      ModelPanel:SetModel(JOB_DATABASE[TEAM_CITIZEN].Playermodels[1][1])
    end
    for k, v in pairs(UserData.Model.clothes or {}) do
      ModelPanel:GetEntity():SetBodygroup(k,v)
    end
    ModelPanel:GetEntity():SetSkin(UserData.Model.skin or 0)
    ModelPanel.OGPaint = ModelPanel.Paint
    local RadGrad = Material("paris/radgrad4.png")
    local lerpy, lerpyinf = 0, 0
    local tbl = util.JSONToTable(UserData["Color"] or "")
    local col = Color(255,255,255)
    if tbl and istable(tbl) then
      col = Color(math.Clamp( tonumber( tbl[1] ), 0.01, 1 )*255, math.Clamp( tonumber( tbl[2] ), 0.01, 1 )*255, math.Clamp( tonumber( tbl[3] ), 0.01, 1 )*255)
    end
    function ModelPanel:Paint(w,h,a,b,c)
      surface.SetMaterial(RadGrad)
      surface.SetDrawColor(col.r,col.g,col.b,50*lerpy)
      surface.DrawTexturedRect(w*0.05,h*0.4,w*0.9,h*0.8)
      ModelPanel:OGPaint(w,h,a,b,c)
    end
    local bg = Color(35,35,35,200)
    local lighter = Color(100,100,100,100)
    function ModelPanel:PaintOver(w,h)
      if self:IsHovered() then lerpyinf = 1 else lerpyinf = 0 end
      lerpy = Lerp(FrameTime()*15, lerpy, lerpyinf)
      local x = 10
      local y = 30
      local h = h * 0.3
      draw.RoundedBoxEx(25,x,y,w-20,h*lerpy,bg,false,false,true,true)
      local y = y + 10
      local name = Color(255,255,255,255*lerpy)
      draw.RoundedBox(0,x,y,w-20,50*lerpy,lighter)
      draw.SimpleText(string.upper(UserData.Name), "ChooseCharTextHeader", w/2, y, name, TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
      local y = y + 70
      draw.DrawText("Playtime: " .. string.NiceTime(UserData.Timeplayed) .. "\n Cash: $" .. string.Comma(UserData.Cash) .. "\n Bank: $" .. string.Comma(UserData.Bank) .. "\n", "ChooseCharTextHeader", w/2, y, name, TEXT_ALIGN_CENTER)
    end
    function ModelPanel:DoClick()
      net.Start("perp_chooseuser") net.WriteInt(id,32) net.SendToServer()
      GAMEMODE.DoNotDrawHUD = false
      GAMEMODE:StopCinematics()
      hook.Remove("PostDrawHUD", "BackgroundBlurShit")
      hook.Remove( "HUDShouldDraw", "BackgroundBlurShit")
      if paris and paris.HUDSettings then
        paris.HUDSettings["DrawHUD"] = true
      end
      Frame:Remove()
      if UserData.Name != "John Doe" then
        GAMEMODE:ZoomInSpawn(true)
      end
    end
  end
  for k, v in pairs(Users) do
    CreateCharacterBox(v,k)
  end
  local AllowedNum = 1
  if LocalPlayer():IsVIP() then AllowedNum = 2 end
  if LocalPlayer():IsGoldVIP() then AllowedNum = 3 end
  for i=AllowedNum-#Users,1,-1 do
    local Panel = vgui.Create('DButton')
    Panel:SetText("")
    ModelGrid:AddItem(Panel)
    Panel:SetSize(ScrW()/3, ScrH())
    Panel:SetPos(0,0)
    local lerpy, lerpyinf = 0, 0
    local bg = Color(35,35,35,200)
    local lighter = Color(100,100,100,100)
    local add = Material("paris/add.png")
    function Panel:Paint(w,h)
      if self:IsHovered() then lerpyinf = 1 else lerpyinf = 0 end
      lerpy = Lerp(FrameTime()*15, lerpy, lerpyinf)
      draw.RoundedBoxEx(25,0,0,w,h,Color(35,35,35,200*lerpy))
      surface.SetDrawColor(255,255,255,200*lerpy)
      surface.SetMaterial(add)
      surface.DrawTexturedRect(w/2-32,h/2-32,64,64)
    end
    function Panel:DoClick()
      Derma_Query( "Are you sure you want to make a new character?", "Make New Character",
      "No...", function() end,
      "Yes!", function() net.Start("perp_createcharacter") 
        net.SendToServer() Frame:Remove() GAMEMODE.DoNotDrawHUD = false
        hook.Remove("PostDrawHUD", "BackgroundBlurShit")
        hook.Remove( "HUDShouldDraw", "BackgroundBlurShit") end )
    end
  end

end

net.Receive("perp_chooseuser", function() hook.Remove("PostRenderVGUI","BeginningBlackScreen") ShowUserSelectionScreen(net.ReadTable()) end)