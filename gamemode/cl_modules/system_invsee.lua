concommand.Add("perp_invsee", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    local InvseePanel = vgui.Create( "perp2_invsee" )
    InvseePanel:MakePopup()
    net.Start("perp_invsee_init")
    net.WriteString(args[1] or "")
    net.SendToServer()
    net.Receive("perp_invsee_init", function()
        local otherinv = net.ReadTable()
        local othersteamid = net.ReadString()
        if IsValid(InvseePanel) and IsValid(player.GetBySteamID(othersteamid)) and istable(otherinv) then
            InvseePanel:InitOtherInventory(otherinv, othersteamid)
        end
    end)
    net.Receive("perp_invsee_update", function()
        if not IsValid(InvseePanel) then return end
        local slot = net.ReadInt(16)
        local info = net.ReadTable()
        local type = net.ReadString()
        InvseePanel:UpdateSlot(type, slot, info)
    end)
end)