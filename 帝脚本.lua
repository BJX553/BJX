local Main = "https://raw.githubusercontent.com/OAO-Kamu/I/refs/heads/main/A.lua"
--local Main = "https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"
local Copy = "https://raw.github.com/BloodLetters/Ash-Libs/main/source.lua"
local Ray = "https://sirius.menu/rayfield"
local Library = loadstring(game:HttpGet(Main))()
local GUI = loadstring(game:HttpGet(Copy))()
local Rayfield = loadstring(game:HttpGet(Ray))()
if _G.KAMU == "Kamu520" then
local UIP = "https://www.roblox.com/games/18687417158/NOLI-Forsaken"
_G.KAMU = true
else
local Window = Library:Window({
    Title = "EM HUB | Alpha.1.0",
    Desc = "作者: Q3E4,小北",
    Icon = 82795327169782,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "开/关"
    }
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local PlayerGui = lp:WaitForChild("PlayerGui")
local Humanoid, Animator
local autoBlockTriggerSounds = {
    ["102228729296384"] = true,
    ["140242176732868"] = true,
    ["112809109188560"] = true,
    ["136323728355613"] = true,
    ["115026634746636"] = true,
    ["84116622032112"] = true,
    ["108907358619313"] = true,
    ["127793641088496"] = true,
    ["86174610237192"] = true,
    ["95079963655241"] = true,
    ["101199185291628"] = true,
    ["119942598489800"] = true,
    ["84307400688050"] = true,
}

local autoBlockTriggerAnims = {
    "126830014841198", "126355327951215", "121086746534252", "18885909645",
    "98456918873918", "105458270463374", "83829782357897", "125403313786645",
    "118298475669935", "82113744478546", "70371667919898", "99135633258223",
    "97167027849946", "109230267448394", "139835501033932", "126896426760253",
    "109667959938617", "126681776859538", "129976080405072", "121293883585738",
    "81639435858902", "137314737492715",
    "92173139187970"
}

-- State Variables
local autoBlockOn = false
local autoBlockAudioOn = false
local strictRangeOn = false
local looseFacing = true
local detectionRange = 18

local predictiveBlockOn = false
local detectionRange = 10
local edgeKillerDelay = 3
local killerInRangeSince = nil
local predictiveCooldown = 0

local autoPunchOn = false
local flingPunchOn = false
local flingPower = 10000
local hiddenfling = false
local aimPunch = false

local customBlockEnabled = false
local customBlockAnimId = ""
local customPunchEnabled = false
local customPunchAnimId = ""

local infiniteStamina = false

local lastBlockTime = 0
local lastPunchTime = 0
local lastBlockTpTime = 0

local blockAnimIds = {
"72722244508749",
"96959123077498"
}
local punchAnimIds = {
"87259391926321"
}

local customChargeEnabled = false
local customChargeAnimId = ""
local chargeAnimIds = { "106014898528300" }

-- Infinite Stamina
local function enableInfiniteStamina()
    local success, StaminaModule = pcall(function()
        return require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
    end)
    if not success or not StaminaModule then return end

    StaminaModule.StaminaLossDisabled = true

    task.spawn(function()
        while infiniteStamina and StaminaModule do
            task.wait(0.1)
            StaminaModule.Stamina = StaminaModule.MaxStamina
            StaminaModule.StaminaChanged:Fire()
        end
    end)
end


local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(0, 140, 0, 0) -- adjust if needed
SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Name = "SidebarLine"
SidebarLine.Parent = game:GetService("CoreGui") -- Or Window.Gui if accessible
_G.AutoGeneral = false
_G.InfStamina = false
_G.SetSpeed = false
_G.SpeedWalk = 16
_G.EspGeneral = false
_G.EspPlayer = false
_G.EspTarp = false 
_G.EspHighlight = true
_G.EspName = true
_G.EspDistance = true
_G.EspHealth = true
_G.ColorGeneral = Color3.fromRGB(135, 206, 235)
_G.ColorKiller = Color3.fromRGB(255, 105, 105)
_G.ColorSurvivor = Color3.fromRGB(144, 238, 144)
_G.EspTextSize = 14
_G.ShowKillers = true
_G.ShowSurvivors = true
local function CleanupESP(parent, espType)
    for _, child in pairs(parent:GetChildren()) do
        if child.Name:find("ESP_") or child.Name:find("Esp_") then
            child:Destroy()
        end
    end
end

local function CreateHighlight(target, color)
    if target:FindFirstChild("ESP_Highlight") then
        target.ESP_Highlight.FillColor = color
        target.ESP_Highlight.OutlineColor = color
        return
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.6
    highlight.OutlineTransparency = 0.2
    highlight.Adornee = target
    highlight.Parent = target
end

local function CreateBillboard(target, text, color)
    if target:FindFirstChild("ESP_Billboard") then
        target.ESP_Billboard.TextLabel.Text = text
        target.ESP_Billboard.TextLabel.TextColor3 = color
        return
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = target
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Parent = target
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "TextLabel"
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Code
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextSize = _G.EspTextSize
    textLabel.TextColor3 = color
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.Text = text
    textLabel.Parent = billboard
end
       local function CreateEsp(Char,Color,Text,Parent)
            if Char then
              local NewHighlight = Instance.new("Highlight",Char)
                NewHighlight.OutlineColor = Color NewHighlight.FillColor = Color
          end
     end
           local function KeepEsp(Char)
                 if Char and Char:FindFirstChildOfClass("Highlight") then
                      Char:FindFirstChildOfClass("Highlight"):Destroy()
                end
           end

local function Notification(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 3,
        Image = 108632720139222
    })
end

local Tab = Window:Tab({Title = "👤 | 通用", Icon = "star"})

Tab:Section({Title = "移动速度设置"})

    Tab:Slider({
        Title = "很普通的滑块",
        Min = 1,
        Max = 1000,
        Rounding = 1,
        Value = 1,
        Callback = function(val)
           _G.KAMU = false
            _G.KAMU = val
        end
    })


        Tab:Slider({
        Title = "移动速度滑块",
        Min = 16,
        Max = 500,
        Rounding = 1,
        Value = 1,
        Callback = function(v)
        _G.SpeedWalk = v
        end
    })
        Tab:Toggle({
        Title = "确认移动速度",
        Desc = "确认上面滑块的移动速度",
        Value = false,
        Callback = function(v)
                   _G.SetSpeed = v
       if v then
           spawn(function()
               while _G.SetSpeed do
                   local player = game.Players.LocalPlayer
                   if player.Character and player.Character:FindFirstChild("Humanoid") then
                       player.Character.Humanoid.WalkSpeed = _G.SpeedWalk
                       player.Character.Humanoid:SetAttribute("BaseSpeed", _G.SpeedWalk)
                   end
                   wait(0.1)
               end
           end)
       end
        end
    })

Tab:Section({Title = "⚡  | 飞行设置"})

    Tab:Button({
    Title = "飞行V1",
    Desc = "⸝⸝ ᷇࿀ ᷆⸝⸝我要飞得更高～",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/UVAj0uWu"))()
    end
})
