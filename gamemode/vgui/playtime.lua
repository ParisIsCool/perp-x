
surface.CreateFont("Playtime_Font_Large", {
    font = "Roboto Thin",
    size = 40,
    weight, 400,
})

surface.CreateFont("Playtime_Font_Small", {
    font = "Roboto Thin",
    size = 25,
    weight, 400,
})


concommand.Add("playtime", function()

    local Panel = vgui.Create("DFrame")
    Panel:SetTitle("Player Time")
    Panel:SetSize(350,180)
    Panel:Center()
    Panel:MakePopup()
    function Panel:Paint()
        --LocalPlayer():GetTimePlayed()
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(22,22,22,255))
        local timedata = string.FormattedTime( LocalPlayer():GetTimePlayed() )
        local days = math.floor(timedata.h/24)
        local hours = timedata.h - (days*24)
        draw.SimpleText(LocalPlayer():GetRPName(), "Playtime_Font_Large", 20, 50, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        local ds = "s"
        if days == 1 then ds = "" end 
        local hs = "s"
        if hours == 1 then hs = "" end 
        local ms = "s"
        if timedata.m == 1 then ms = "" end 
        draw.SimpleText( days .. " day" .. ds .. ", " .. hours .. " hour" .. hs .. ", " .. timedata.m .. " minute" .. ms  , "Playtime_Font_Small", 20, 100, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

end)