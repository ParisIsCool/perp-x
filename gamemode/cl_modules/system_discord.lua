local DiscordPanel 
local discordid
local ValidateButton
local Instruct
local current
local Failure
local Next
local Help

local step = 1
local steps = {
    'aSoc_registerSteam',
    'aSoc_verifyCode'
}

-- add discord link - asocket.net/discord (or auto open?)
function DrawDiscordLinkPanel( id )
    if IsValid( DiscordPanel ) then return end
    step = 1

    DiscordPanel = vgui.Create("DFrame")
    DiscordPanel:SetTitle("aSocket | Discord Verification")
    DiscordPanel:SetSize(500,400)
    DiscordPanel:Center()
    DiscordPanel:MakePopup()
    local asoclogo = Material("paris/asoclogo.png")
    local discordlogo = Material("paris/discordlogo2.png")
    local bccolor = Color(47,49,54)
    function DiscordPanel:Paint(w,h)
        draw.RoundedBox(0,0,0,w,h,bccolor)
    end
    function DiscordPanel:PaintOver(w,h)
        surface.SetMaterial(discordlogo)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect((w/2)-50,15,100,100)
    end

    Instruct = vgui.Create("asoc_Label", DiscordPanel)
    Instruct:SetPos(100, 105)
    Instruct:SetSize(300, 40)
    Instruct.Text = "Join our discord to gain Gold VIP!"

    ValidateButton = vgui.Create( "asoc_Button", DiscordPanel )
    ValidateButton:SetSize( 200, 40 )
    ValidateButton:SetPos( 150, 150 )
    ValidateButton:SetText( "" )
    ValidateButton.Text = "Join Discord"
    function ValidateButton:DoClick()
        gui.OpenURL("https://asocket.net/discord")
    end

    -- Finding Discord ID
    local function NextStep()

        Next:Remove()

        discordid = vgui.Create( "paris_TextEntry", DiscordPanel )
        discordid:SetPlaceholderText( "Discord ID" )
        discordid:SetSize(300,30 )
        discordid:SetPos( 100, 130 )

        ValidateButton:SetPos( 150, 190 )
        ValidateButton.Text = "Validate Discord"
        ValidateButton.DoClick = function() 
            discordid:SetEnabled( false )
            ValidateButton:SetEnabled( false )
            net.Start( steps[step] )
                net.WriteString( discordid:GetValue():gsub(" ", "") )
            net.SendToServer()
        end

        Instruct:SetPos( 100, 100)
        Instruct.Text = "Enter Discord ID:"

        Help = vgui.Create( "asoc_Button", DiscordPanel )
        Help:SetSize( 200, 30 )
        Help:SetPos( 150, 250 )
        Help:SetText("")
        Help.Text = "How to find Discord ID"
        function Help:DoClick()
            gui.OpenURL("http://perp.asocket.net/get-discord-id/")
        end

        current = vgui.Create("asoc_Label", DiscordPanel)
        current:SetPos(100, DiscordPanel:GetTall()-30)
        current:SetSize(300, 30)
        current.Text = "Current Discord ID: " .. tostring(id)

        DiscordPanel:Show()
    end

    Next = vgui.Create( "asoc_Button", DiscordPanel )
    Next:SetSize( 200, 40 )
    Next:SetPos( 150, 200 )
    Next:SetText( "" )
    Next.Text = "Next"
    function Next:DoClick()
        NextStep()
    end

end

net.Receive( "DiscordLinkPanel", function( len )   
    DrawDiscordLinkPanel( net.ReadString() )
end)

local function panelErr()
    if IsValid(Failure) then return end
    Failure = vgui.Create("asoc_Label", DiscordPanel)
    Failure:SetPos(100,160)
    Failure:SetSize(300,30)
    Failure:SetText("")
    Failure.Color = Color( 255, 70, 70 )
    Failure.Text = "An error occured, please try again."
end

local function resetPanel()
    discordid:SetEnabled( true )
    ValidateButton:SetEnabled( true )
    discordid:SetValue( "" )
end

net.Receive( "aSoc_steamRegistration_res", function()   
    if(net.ReadBool()) then
        if IsValid(Failure) then Failure:Remove() end
        Instruct.Text = "Enter verification code:"
        Help:Remove()
        current.Text = "Verifying Discord ID: " .. discordid:GetValue():gsub(" ", "")
        Help = vgui.Create( "asoc_Label", DiscordPanel )
        Help:SetSize( 200, 30 )
        Help:SetPos( 150, 250 )
        Help:SetText("")
        Help.Text = "Check your DMs!"
        resetPanel()
        step = step + 1
    else
        panelErr()
        resetPanel()
    end
end)

net.Receive('aSoc_verificationCode_res', function()
    if (net.ReadBool()) then
        DiscordPanel:Remove()
        LocalPlayer():ChatPrint( "Your discord has been verified successfully. Gold VIP has been applied!" )
    else
        panelErr()
        resetPanel()
    end
end)
