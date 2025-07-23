--[[

    ScriptLife Key System Loader
    - Mobile + PC compatible
    - Random key per user
    - 24h key expiration
    - Rayfield GUI (Dark)
    - Linkvertise-ready
    - Discord tab
    - Made by ch6ns

]]

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local HttpService, osTime = game:GetService("HttpService"), os.time

local keyfile = "scriptlife_key.txt"
local expirefile = "scriptlife_expire.txt"

-- Key Check or Generate
local function getSavedKey()
    if isfile(keyfile) and isfile(expirefile) then
        local expireAt = tonumber(readfile(expirefile))
        if osTime() < expireAt then
            return readfile(keyfile)
        end
    end
    return nil
end

local function generateKey()
    local key = HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 16):upper()
    writefile(keyfile, key)
    writefile(expirefile, tostring(osTime() + 86400)) -- 24h
    return key
end

local userKey = getSavedKey() or generateKey()

-- GUI Window
local Window = Rayfield:CreateWindow({
    Name = "ScriptLife | Key System",
    LoadingTitle = "ScriptLife Hub",
    LoadingSubtitle = "Verifying user...",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = true,
        Invite = "839WVd7dbH",
        RememberJoins = false
    },
    KeySystem = false,
    ColorScheme = {
        Theme = "Dark"
    }
})

-- Key Tab
local KeyTab = Window:CreateTab("🔑 Key Access")

KeyTab:CreateParagraph({
    Title = "Your Key",
    Content = "Click '📋 Copy Key' → Complete Linkvertise → Paste key below."
})

KeyTab:CreateInput({
    Name = "Paste Key",
    PlaceholderText = "Enter your copied key",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        if input == userKey then
            Rayfield:Notify({
                Title = "✅ Success",
                Content = "Key valid. Loading Script...",
                Duration = 4
            })
            wait(1)
            -- Replace below with your actual script
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EEEFCMOBILE/Floppa-camlock/refs/heads/main/By%20rex"))()
        else
            Rayfield:Notify({
                Title = "❌ Invalid",
                Content = "Wrong key. Try again or restart script.",
                Duration = 4
            })
        end
    end
})

KeyTab:CreateButton({
    Name = "📋 Copy Key",
    Callback = function()
        setclipboard(userKey)
        Rayfield:Notify({
            Title = "Key Copied",
            Content = "Now go complete Linkvertise and paste the key back here!",
            Duration = 5
        })
        -- Optional: auto-open instructions or Linkvertise
        -- setclipboard("https://your.linkvertise.url")
    end
})

-- Discord Tab
Window:CreateTab("🌐 Discord"):CreateParagraph({
    Title = "Need Support?",
    Content = "Join our server:\ndiscord.gg/839WVd7dbH"
})
