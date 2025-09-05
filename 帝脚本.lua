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

    Tab:Toggle({
        Title = "自动发电机",
        Desc = "",
        Value = false,
        Callback = function(Value)
       ActiveAutoGenerator = Value task.spawn(function()
           while ActiveAutoGenerator do task.spawn(function()
             for _,Players in pairs(Game.Workspace.Map.Ingame:FindFirstChild("Map"):GetChildren()) do 
               if Players:isA("Model") and Players.name == "Generator"  then 
                 if Players:FindFirstChild("Remotes"):FindFirstChild("RE") then 
                    Players:FindFirstChild("Remotes"):FindFirstChild("RE"):FireServer() 
                 end
               end
             end
         end)
         task.wait(2.5)
       end 
   end)
        end
    })


local Tab = Window:Tab({Title = "📜 | 绘制", Icon = "star"})

Tab:Section({Title = "👁️ | 视觉:透视"})

    Tab:Toggle({
        Title = "绘制杀手和幸存者",
        Desc = "显示杀手/幸存者的角色和距离,健康",
        Value = true,
        Callback = function(Value)
               _G.EspPlayer = Value
       if not Value then
           for _, playerType in pairs(game.Workspace.Players:GetChildren()) do
               if playerType.Name == "Killers" or playerType.Name == "Survivors" then
                   for _, player in pairs(playerType:GetChildren()) do
                       CleanupESP(player, "player")
                   end
               end
           end
       else
           spawn(function()
               while _G.EspPlayer do
                   for _, playerType in pairs(game.Workspace.Players:GetChildren()) do
                       if playerType.Name == "Killers" and _G.ShowKillers then
                           for _, player in pairs(playerType:GetChildren()) do
                               if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player:FindFirstChild("Head") then
                                   if _G.EspHighlight then
                                       CreateHighlight(player, _G.ColorKiller)
                                   end
                                   
                                   local text = ""
                                   if _G.EspName then
                                       text = text .. player.Name
                                   end
                                   if _G.EspDistance then
                                       local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.HumanoidRootPart.Position).Magnitude
                                       text = text .. "\n距离: " .. math.floor(distance)
                                   end
                                   if _G.EspHealth then
                                       text = text .. "\n血量: " .. math.floor(player.Humanoid.Health)
                                   end
                                   
                                   if text ~= "" then
                                       CreateBillboard(player.Head, text, _G.ColorKiller)
                                   end
                               end
                           end
                       elseif playerType.Name == "Survivors" and _G.ShowSurvivors then
                           for _, player in pairs(playerType:GetChildren()) do
                               if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Humanoid") and player:FindFirstChild("Head") then
                                   if _G.EspHighlight then
                                       CreateHighlight(player, _G.ColorSurvivor)
                                   end
                                   
                                   local text = ""
                                   if _G.EspName then
                                       text = text .. player.Name
                                   end
                                   if _G.EspDistance then
                                       local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.HumanoidRootPart.Position).Magnitude
                                       text = text .. "\n距离: " .. math.floor(distance)
                                   end
                                   if _G.EspHealth then
                                       text = text .. "\n血量: " .. math.floor(player.Humanoid.Health)
                                   end
                                   
                                   if text ~= "" then
                                       CreateBillboard(player.Head, text, _G.ColorSurvivor)
                                   end
                               end
                           end
                       end
                   end
                   wait(0.5)
               end
           end)
       end
       end
    })

    Tab:Toggle({
        Title = "绘制发电机",
        Desc = "显示发电机的进度和距离",
        Value = true,
        Callback = function(Value)
       _G.EspGeneral = Value
       if not Value then
           if workspace.Map.Ingame:FindFirstChild("Map") then
               for _, generator in pairs(workspace.Map.Ingame.Map:GetChildren("Genrator")) do
                   if generator.Name == "Generator" then
                       CleanupESP(generator, "general")
                   end
               end
           end
       else
           spawn(function()
               while _G.EspGeneral do
                   if workspace.Map.Ingame:FindFirstChild("Map") then
                       for _, generator in pairs(workspace.Map.Ingame.Map:GetChildren()) do
                           if generator.Name == "Generator" and not generator:FindFirstChild("iskiddedfromneptz") then                               local progress = generator.Progress.Value
                               local color = progress == 100 and Color3.fromRGB(144, 238, 144) or _G.ColorGeneral
                               
                               if _G.EspHighlight then
                                   CreateHighlight(generator, color)
                               end
                               
                               local text = ""
                               if _G.EspName then
                                   text = text .. "发电机 (" .. progress .. "%)"
                               end
                               if _G.EspDistance then
                                   local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - generator.Position).Magnitude
                                   text = text .. "\n距离: " .. math.floor(distance)
                               end
                               
                               if text ~= "" then
                                   CreateBillboard(generator, text, color)
                               end
                           end
                       end
                   end
                   wait(0.5)
               end
           end)
       end
        end
    })
    
            Tab:Toggle({
        Title = "绘制陷阱",
        Desc = "高亮和文本显示陷阱",
        Value = true,
        Callback = function(Value)
        _G.EspTrap = Value
       if not Value then
           if workspace.Map.Ingame:FindFirstChild("Map") then
               for _, trap in pairs(workspace.Map.Ingame.Map:GetChildren("SubspaceTripmine")) do
                   if trap.Name == "SubspaceTripmine" then
                       CleanupESP(trap, "general")
                   end
               end
           end
       else
           spawn(function()
               while _G.EspTrap do
                   if workspace.Map.Ingame:FindFirstChild("Map") then
                       for _, trap in pairs(workspace.Map.Ingame.Map:GetChildren()) do
                           if trap.Name == "SubspaceTripmine" then
                               local progress = generator.Progress.Value
                               local color = progress == 100 and Color3.fromRGB(144, 238, 144) or _G.ColorTrap
                               
                               if _G.EspHighlight then
                                   CreateHighlight(trap, color)
                               end
                               
                               local text = ""
                               if _G.EspName then
                                   text = text .. "陷阱"
                               end
                               if _G.EspDistance then
                                   local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - trap.Position).Magnitude
                                   text = text .. "\n距离: " .. math.floor(distance)
                               end
                               
                               if text ~= "" then
                                   CreateBillboard(trap, text, color)
                               end
                           end
                       end
                   end
                   wait(0.5)
               end
           end)
       end
        end})
    
        Tab:Toggle({
        Title = "绘制物品",
        Desc = "如果没效果了就重新打开关闭!!!",
        Value = false,
        Callback = function(Value)
      if Value then
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local processedObjects = {}

local objectConfigs = {

    Medkit = {
        fillColor = Color3.fromRGB(0, 255, 0), 
        outlineColor = Color3.fromRGB(255, 255, 255),
        textSize = 13,
        text = "医疗包",
        textStrokeTransparency = 1,
        fillTransparency = 0.3
    },

    BloxyCola = {
        fillColor = Color3.fromRGB(0, 0, 255), 
        outlineColor = Color3.fromRGB(255, 255, 255),
        textSize = 13,
        text = "可乐",
        textStrokeTransparency = 1,
        fillTransparency = 0.3
    }
}

local dynamicConfig = {
    objectSuffix = "RespawnLocation",
    scanInterval = 3,
    fillColor = Color3.fromRGB(255, 255, 0), -- Yellow color
    outlineColor = Color3.fromRGB(255, 255, 255), -- White color
    textSize = 12,
    text = "重生点", 
    textStrokeTransparency = 1,
    fillTransparency = 0.5
}

local function createESPVisuals(instance, config)
   if processedObjects[instance] then return end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = instance
    highlight.OutlineColor = config.outlineColor
    highlight.FillColor = config.fillColor
    highlight.FillTransparency = config.fillTransparency
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = instance

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Parent = instance
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(0, 50, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboardGui
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0.9, 0, 0.9, 0)
    
    if config.objectSuffix then
        local playerName = instance.Name:sub(1, #instance.Name - #config.objectSuffix)
        textLabel.Text = playerName .. "'s " .. config.text
    else
        textLabel.Text = config.text
    end
    
    textLabel.TextScaled = false
    textLabel.TextSize = config.textSize
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = config.textStrokeTransparency
    textLabel.Font = Enum.Font.SourceSansBold
    
    processedObjects[instance] = true

    instance.AncestryChanged:Connect(function(child, newParent)
        if not newParent then
            if processedObjects[instance] then
                processedObjects[instance] = nil
            end
        end
    end)
end

local function findAndEspObjects()
    for _, descendant in pairs(Workspace:GetDescendants()) do
        local staticConfig = objectConfigs[descendant.Name]
        if staticConfig and descendant:IsA("Model") then
            createESPVisuals(descendant, staticConfig)
        end
        
        if descendant:IsA("BasePart") and descendant.Name:sub(-#dynamicConfig.objectSuffix) == dynamicConfig.objectSuffix then
            createESPVisuals(descendant, dynamicConfig)
        end
    end
end

    while true do
      findAndEspObjects()
      wait(dynamicConfig.scanInterval)
    end
end
        end
    })

    Tab:Section({Title = "⚙️ | 绘制设定(自定义)"})

    Tab:Toggle({
        Title = "显示杀手",
        Desc = "在绘制中显示杀手",
        Value = true,
        Callback = function(Value)
             _G.ShowKillers = Value
        end
    })
    Tab:Toggle({
        Title = "显示幸存者",
        Desc = "在绘制中显示幸存者",
        Value = true,
        Callback = function(Value)
             _G.ShowSurvivors = Value
        end
    })
    Tab:Toggle({
        Title = "启用高亮显示",
        Desc = "如果启用就会高亮显示杀手/发电机/幸存者",
        Value = true,
        Callback = function(Value)
             _G.EspHighlight = Value
        end
    })
    Tab:Toggle({
        Title = "显示角色",
        Desc = "显示杀手/幸存者的角色避免你不知道是什么角色",
        Value = true,
        Callback = function(Value)
             _G.EspName = Value
        end
    })
    Tab:Toggle({
        Title = "显示距离",
        Desc = "显示你距离杀手/发电机/幸存者的距离",
        Value = true,
        Callback = function(Value)
             _G.EspDistance = Value
        end
    })
    Tab:Toggle({
        Title = "显示血量",
        Desc = "显示杀手/幸存者的血量",
        Value = true,
        Callback = function(Value)
             _G.EspHealth = Value
        end
    })

    Tab:Textbox({
        Title = "设置绘制字体大小",
        Desc = "调整绘制健康/类型/血量的字体大小",
        Placeholder = "输入",
        Value = "15",
        ClearTextOnFocus = true,
        Callback = function(Value)
            _G.EspTextSize = Value
        end
    })
        
    local Tab = Window:Tab({Title = "✡️ | 自瞄/战斗", Icon = "star"})
    Tab:Section({Title = "🗡️ | 战斗:辅助脚本(提高生存几率)"})

    Tab:Button({
        Title = "飞行",
        Desc = "飞行功能",
        Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/UVAj0uWu"))()
end);

    Tab:Button({
        Title = "自动背刺 GUI",
        Desc = "两次自动背刺GUI (不是我做的)",
        Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BackstabToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 150, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 20
toggleButton.Text = "自动背刺: OFF"
toggleButton.Parent = screenGui

-- Range Label
local rangeLabel = Instance.new("TextLabel")
rangeLabel.Size = UDim2.new(0, 150, 0, 20)
rangeLabel.Position = UDim2.new(0, 10, 0, 55)
rangeLabel.BackgroundTransparency = 1
rangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
rangeLabel.Font = Enum.Font.SourceSans
rangeLabel.TextSize = 16
rangeLabel.Text = "范围:"
rangeLabel.Parent = screenGui

-- TextBox for Range Input
local rangeBox = Instance.new("TextBox")
rangeBox.Size = UDim2.new(0, 150, 0, 25)
rangeBox.Position = UDim2.new(0, 10, 0, 75)
rangeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
rangeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
rangeBox.Font = Enum.Font.SourceSans
rangeBox.TextSize = 16
rangeBox.PlaceholderText = "设置范围 (1 - 10)"
rangeBox.Text = "4"
rangeBox.ClearTextOnFocus = false
rangeBox.Parent = screenGui

-- Vars
local enabled = false
local cooldown = false
local lastTarget = nil
local range = 4
local daggerRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent")
local killerNames = { "Jason", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli" }
local killersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")

-- GUI toggle
toggleButton.MouseButton1Click:Connect(function()
	enabled = not enabled
	toggleButton.Text = "自动背刺: " .. (enabled and "ON" or "OFF")
	toggleButton.BackgroundColor3 = enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(30, 30, 30)
end)

-- TextBox Range Handling
rangeBox.FocusLost:Connect(function()
	local input = tonumber(rangeBox.Text)
	if input and input >= 1 and input <= 10 then
		range = input
	else
		rangeBox.Text = tostring(range) -- Revert to last valid value
	end
end)

-- Mode Toggle
local mode = "Behind"
local modeButton = Instance.new("TextButton")
modeButton.Size = UDim2.new(0, 150, 0, 25)
modeButton.Position = UDim2.new(0, 10, 0, 105)
modeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
modeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
modeButton.Font = Enum.Font.SourceSans
modeButton.TextSize = 16
modeButton.Text = "模式: idk"
modeButton.Parent = screenGui

modeButton.MouseButton1Click:Connect(function()
	if mode == "Behind" then
		mode = "Around"
	else
		mode = "Behind"
	end
	modeButton.Text = "模式: " .. mode
end)

-- Modified helper function
local function isBehindTarget(hrp, targetHRP)
	local distance = (hrp.Position - targetHRP.Position).Magnitude
	if distance > range then
		return false
	end
	
	if mode == "Around" then
		return true
	else
		local direction = -targetHRP.CFrame.LookVector
		local toPlayer = (hrp.Position - targetHRP.Position)
		return toPlayer:Dot(direction) > 0.5
	end
end

-- Main loop
RunService.Heartbeat:Connect(function()
	if not enabled or cooldown then return end

	local char = lp.Character
	if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
	local hrp = char.HumanoidRootPart

	for _, name in ipairs(killerNames) do
		local killer = killersFolder:FindFirstChild(name)
		if killer and killer:FindFirstChild("HumanoidRootPart") then
			local kHRP = killer.HumanoidRootPart

			if isBehindTarget(hrp, kHRP) and killer ~= lastTarget then
				cooldown = true
				lastTarget = killer

				-- Begin sum secs constant teleporting behind killer
				local start = tick()
				local didDagger = false

				local connection
				connection = RunService.Heartbeat:Connect(function()
					if not (char and char.Parent and kHRP and kHRP.Parent) then
						if connection then connection:Disconnect() end
						return
					end
					local elapsed = tick() - start
					if elapsed >= 0.5 then
						if connection then connection:Disconnect() end
						return
					end

					-- Constant TP behind killer
					local behindPos = kHRP.Position - (kHRP.CFrame.LookVector * 0.3)
					hrp.CFrame = CFrame.new(behindPos, behindPos + kHRP.CFrame.LookVector)

					-- Align look direction for sum sec (only once at the start)
					if not didDagger then
						didDagger = true

						-- Align to killer’s facing for sum sec
						local faceStart = tick()
						local faceConn
						faceConn = RunService.Heartbeat:Connect(function()
							if tick() - faceStart >= 0.7 or not kHRP or not kHRP.Parent then
								if faceConn then faceConn:Disconnect() end
								return
							end
							hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + kHRP.CFrame.LookVector)
						end)

						-- Dagger right after first TP and look
						daggerRemote:FireServer("UseActorAbility", "Dagger")
					end
				end)

				-- Wait and reset cooldown after leaving range
				task.delay(2, function()
					RunService.Heartbeat:Wait()
					while isBehindTarget(hrp, kHRP) do
						RunService.Heartbeat:Wait()
					end
					lastTarget = nil
					cooldown = false
				end)

				break
			end
		end
	end
end)
            Window:Notify({
                Title = "✅ | 开启",
                Desc = "不是我做的!!!",
                Time = 5
            })
        end
    })

    Tab:Button({
        Title = "自动背刺 V2 GUI",
        Desc = "不是我做的",
        Callback = function()
           local Players = game:GetService("Players") 
local ReplicatedStorage = game:GetService("ReplicatedStorage") 
local RunService = game:GetService("RunService") 
local lp = Players.LocalPlayer

-- GUI Setup 
local screenGui = Instance.new("ScreenGui") 
screenGui.Name = "BackstabToggleGui" 
screenGui.ResetOnSpawn = false 
screenGui.Parent = lp:WaitForChild("PlayerGui")

-- Toggle Button 
local toggleButton = Instance.new("TextButton") 
toggleButton.Size = UDim2.new(0, 150, 0, 40) 
toggleButton.Position = UDim2.new(0, 10, 0, 10) 
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) 
toggleButton.Font = Enum.Font.SourceSansBold 
toggleButton.TextSize = 20 
toggleButton.Text = "背刺: OFF" 
toggleButton.Parent = screenGui

-- Range Label 
local rangeLabel = Instance.new("TextLabel") 
rangeLabel.Size = UDim2.new(0, 150, 0, 20) 
rangeLabel.Position = UDim2.new(0, 10, 0, 55) 
rangeLabel.BackgroundTransparency = 1 
rangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
rangeLabel.Font = Enum.Font.SourceSans 
rangeLabel.TextSize = 16 
rangeLabel.Text = "Range:" 
rangeLabel.Parent = screenGui

-- TextBox for Range Input 
local rangeBox = Instance.new("TextBox") 
rangeBox.Size = UDim2.new(0, 150, 0, 25) 
rangeBox.Position = UDim2.new(0, 10, 0, 75) 
rangeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
rangeBox.TextColor3 = Color3.fromRGB(255, 255, 255) 
rangeBox.Font = Enum.Font.SourceSans 
rangeBox.TextSize = 16 
rangeBox.PlaceholderText = "输入范围" 
rangeBox.Text = "4" 
rangeBox.ClearTextOnFocus = false 
rangeBox.Parent = screenGui

-- Vars 
local enabled = false 
local cooldown = false 
local lastTarget = nil 
local range = 4 
local daggerRemote = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent") 
local killerNames = { "Jason", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli" } 
local killersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")

-- GUI toggle 
toggleButton.MouseButton1Click:Connect(function() 
    enabled = not enabled 
    toggleButton.Text = "背刺: " .. (enabled and "ON" or "OFF") 
    toggleButton.BackgroundColor3 = enabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(30, 30, 30) 
end)

-- TextBox Range Handling 
rangeBox.FocusLost:Connect(function() 
    local input = tonumber(rangeBox.Text) 
    if input and input >= 1 then 
        range = input 
    else 
        rangeBox.Text = tostring(range) 
    end 
end)

-- Mode Toggle 
local mode = "Behind" 
local modeButton = Instance.new("TextButton") 
modeButton.Size = UDim2.new(0, 150, 0, 25) 
modeButton.Position = UDim2.new(0, 10, 0, 105) 
modeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) 
modeButton.TextColor3 = Color3.fromRGB(255, 255, 255) 
modeButton.Font = Enum.Font.SourceSans 
modeButton.TextSize = 16 
modeButton.Text = "   " 
modeButton.Parent = screenGui

modeButton.MouseButton1Click:Connect(function() 
    if mode == "Behind" then 
        mode = "Around" 
    else 
        mode = "Behind" 
    end 
    modeButton.Text = "模式: " .. mode 
end)

-- Match Facing Toggle (only for Legit mode)
local matchFacing = false
local facingButton = Instance.new("TextButton")
facingButton.Size = UDim2.new(0, 150, 0, 25)
facingButton.Position = UDim2.new(0, 10, 0, 165) -- under Backstab Type button
facingButton.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
facingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
facingButton.Font = Enum.Font.SourceSans
facingButton.TextSize = 16
facingButton.Text = "自瞄: OFF"
facingButton.Visible = false -- hidden until Legit mode
facingButton.Parent = screenGui

facingButton.MouseButton1Click:Connect(function()
    matchFacing = not matchFacing
    facingButton.Text = "自瞄: " .. (matchFacing and "ON" or "OFF")
    facingButton.BackgroundColor3 = matchFacing and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(110, 110, 110)
end)

-- Attack type button (Normal / Counter)
local attackType = "Normal"
local attackButton = Instance.new("TextButton")
attackButton.Size = UDim2.new(0, 150, 0, 25)
attackButton.Position = UDim2.new(0, 10, 0, 135) -- under mode button
attackButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
attackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
attackButton.Font = Enum.Font.SourceSans
attackButton.TextSize = 16
attackButton.Text = "   "
attackButton.Parent = screenGui

attackButton.MouseButton1Click:Connect(function()
    if attackType == "Normal" then
        attackType = "Counter"
    elseif attackType == "Counter" then
        attackType = "Legit"
    elseif attackType == "Legit" then
        attackType = "Normal"
    end
    attackButton.Text = "背刺类型: " .. attackType

    -- Show Match Facing button only if Legit
    facingButton.Visible = (attackType == "Legit")
end)


-- Hide Button
local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 50, 0, 40)
hideButton.Position = UDim2.new(0, 165, 0, 10) -- right next to Backstab toggle
hideButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.Font = Enum.Font.SourceSansBold
hideButton.TextSize = 20
hideButton.Text = "-"
hideButton.Parent = screenGui

local guiHidden = false
local guiElements = {}

-- Store all GUI elements except toggle and hideButton
for _, obj in ipairs(screenGui:GetChildren()) do
	if obj ~= hideButton then
		table.insert(guiElements, obj)
	end
end

hideButton.MouseButton1Click:Connect(function()
	guiHidden = not guiHidden
	hideButton.Text = guiHidden and "+" or "-"

	for _, obj in ipairs(guiElements) do
		obj.Visible = not guiHidden
	end
end)


-- Animation IDs for Counter mode
local counterAnimIDs = {
	"126830014841198", "126355327951215", "121086746534252", "18885909645",
	"98456918873918", "105458270463374", "83829782357897", "125403313786645",
	"118298475669935", "82113744478546", "70371667919898", "99135633258223",
	"97167027849946", "109230267448394", "139835501033932", "126896426760253",
	"109667959938617", "126681776859538", "129976080405072", "121293883585738",
	"81639435858902", "137314737492715", "92173139187970"
}


-- Helpers
local function killerPlayingCounterAnim(killer)
    local humanoid = killer:FindFirstChildOfClass("Humanoid")
    if not humanoid or not humanoid:FindFirstChildOfClass("Animator") then return false end

    for _, track in ipairs(humanoid.Animator:GetPlayingAnimationTracks()) do
        if track.Animation and track.Animation.AnimationId then
            local animIdNum = track.Animation.AnimationId:match("%d+")
            for _, id in ipairs(counterAnimIDs) do
                if tostring(animIdNum) == id then
                    return true
                end
            end
        end
    end
    return false
end

local function isBehindTarget(hrp, targetHRP) 
    local distance = (hrp.Position - targetHRP.Position).Magnitude 
    if distance > range then return false end
    if mode == "Around" then 
        return true 
    else 
        local direction = -targetHRP.CFrame.LookVector 
        local toPlayer = (hrp.Position - targetHRP.Position) 
        return toPlayer:Dot(direction) > 0.5 
    end
end



-- keep daggerCooldownText up-to-date automatically
local function refreshDaggerRef()
	local mainui = lp:FindFirstChild("PlayerGui"):FindFirstChild("MainUI")
	if mainui and mainui:FindFirstChild("AbilityContainer") then
		local dagger = mainui.AbilityContainer:FindFirstChild("Dagger")
		if dagger and dagger:FindFirstChild("CooldownTime") then
			daggerCooldownText = dagger.CooldownTime
			return
		end
	end
	daggerCooldownText = nil
end

-- reconnect whenever relevant descendants change
lp.PlayerGui.DescendantAdded:Connect(refreshDaggerRef)
lp.PlayerGui.DescendantRemoving:Connect(function(obj)
	if obj == daggerCooldownText then
		daggerCooldownText = nil
	end
end)

refreshDaggerRef()

RunService.RenderStepped:Connect(function()
    if not daggerCooldownText or not daggerCooldownText.Parent then
        return
    end
    

    if tonumber(daggerCooldownText.Text) then
        return -- still on cooldown
    end

    if not enabled or cooldown then return end
    
	local char = lp.Character
	if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
	local hrp = char.HumanoidRootPart
	local stats = game:GetService("Stats")
	
	for _, name in ipairs(killerNames) do
		local killer = killersFolder:FindFirstChild(name)
		if killer and killer:FindFirstChild("HumanoidRootPart") then
			local kHRP = killer.HumanoidRootPart

            if attackType == "Legit" then
                local dist = (kHRP.Position - hrp.Position).Magnitude
                if dist <= range then
                    -- Optional facing alignment
                    if matchFacing then
                        hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + kHRP.CFrame.LookVector)
                    end
                    if mode == "Behind" then
                        local directionToTarget = (kHRP.Position - hrp.Position).Unit
                        local dot = hrp.CFrame.LookVector:Dot(directionToTarget)
                        if dot > 0.6 then -- target is in front
                            return
                        end
                    end
                    daggerRemote:FireServer("UseActorAbility", "Dagger")
                end
                return -- skip TP logic
            end

            if attackType == "Counter" and not killerPlayingCounterAnim(killer) then
            	continue
            end
			if isBehindTarget(hrp, kHRP) and killer ~= lastTarget then
				cooldown = true
				lastTarget = killer

				local start = tick()
				local didDagger = false
				local connection
				connection = RunService.Heartbeat:Connect(function()
					if not (char and char.Parent and kHRP and kHRP.Parent) then
						if connection then connection:Disconnect() end
						return
					end

					local elapsed = tick() - start
					if elapsed >= 0.5 then
						if connection then connection:Disconnect() end
						return
					end

					-- LIVE Ping + velocity prediction
					local ping = tonumber(stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")) or 50
					local pingSeconds = ping / 1000
					local killerVelocity = kHRP.Velocity
					local moveDir = killerVelocity.Magnitude > 0.1 and killerVelocity.Unit or Vector3.new()
					local pingOffset = moveDir * (pingSeconds * killerVelocity.Magnitude)
					local predictedPos = kHRP.Position + pingOffset

					-- Apply mode logic with improved "Around" handling
					local targetPos
					if mode == "Behind" then
						targetPos = predictedPos - (kHRP.CFrame.LookVector * 0.3)
					elseif mode == "Around" then
						local lookVec = kHRP.CFrame.LookVector
						local rightVec = kHRP.CFrame.RightVector
						local rel = (hrp.Position - kHRP.Position)
						local lateralSpeed = killerVelocity:Dot(rightVec)
						
						local baseOffset = (rel.Magnitude > 0.1) and rel.Unit * 0.3 or Vector3.new()
						local lateralOffset = rightVec * lateralSpeed * 0.3

						targetPos = predictedPos + baseOffset + lateralOffset
					end

					-- Constant live TP
					hrp.CFrame = CFrame.new(targetPos, targetPos + kHRP.CFrame.LookVector)

					-- Only dagger once
					if not didDagger then
						didDagger = true

						-- Keep aligning for 0.7s
						local faceStart = tick()
						local faceConn
						faceConn = RunService.Heartbeat:Connect(function()
							if tick() - faceStart >= 0.7 or not kHRP or not kHRP.Parent then
								if faceConn then faceConn:Disconnect() end
								return
							end
							-- Live align during window
							local livePing = tonumber(stats.Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")) or 50
							local livePingSeconds = livePing / 1000
							local liveVelocity = kHRP.Velocity
							local liveMoveDir = liveVelocity.Magnitude > 0.1 and liveVelocity.Unit or Vector3.new()
							local livePingOffset = liveMoveDir * (livePingSeconds * liveVelocity.Magnitude)
							local livePredictedPos = kHRP.Position + livePingOffset

							local liveTargetPos
							if mode == "Behind" then
								liveTargetPos = livePredictedPos - (kHRP.CFrame.LookVector * 0.3)
							elseif mode == "Around" then
								local lookVec = kHRP.CFrame.LookVector
								local rightVec = kHRP.CFrame.RightVector
								local liveRel = (hrp.Position - kHRP.Position)
								local liveLateralSpeed = liveVelocity:Dot(rightVec)
								
								local baseOffset = (liveRel.Magnitude > 0.1) and liveRel.Unit * 0.3 or Vector3.new()
								local lateralOffset = rightVec * liveLateralSpeed * 0.3

								liveTargetPos = livePredictedPos + baseOffset + lateralOffset
							end
							hrp.CFrame = CFrame.new(liveTargetPos, liveTargetPos + kHRP.CFrame.LookVector)
						end)

						daggerRemote:FireServer("UseActorAbility", "Dagger")
					end
				end)

				-- Reset cooldown when out of range
				task.delay(2, function()
					RunService.Heartbeat:Wait()
					while isBehindTarget(hrp, kHRP) do
						RunService.Heartbeat:Wait()
					end
					lastTarget = nil
					cooldown = false
				end)
				
				break
			end
		end
	end
end)
end})
    Tab:Button({
        Title = "自动躲避杀手攻击 GUI",
        Desc = "不靠谱的自动躲避杀手攻击 GUI (不是我做的)",
        Callback = function()
        local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local lp = Players.LocalPlayer

-- Killer animation IDs
local killerAnims = {
	"126830014841198", "126355327951215", "121086746534252", "18885909645",
	"98456918873918", "105458270463374", "83829782357897", "125403313786645",
	"118298475669935", "82113744478546", "70371667919898", "99135633258223",
	"97167027849946", "109230267448394", "139835501033932", "126896426760253",
	"109667959938617", "126681776859538", "129976080405072", "121293883585738"
}

-- UI Setup
local screenGui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
screenGui.Name = "UltraInstinctUI"
screenGui.ResetOnSpawn = false

local directions = {"左边", "右边", "前面", "后面", "随机"}
local currentDirection = 1
local ultraInstinctEnabled = false
local canDodge = true
local lastNotifTime = 0
local notifCooldown = 2

-- Animations
local dodgeAnims = {
	Left = "rbxassetid://17096325697",
	Right = "rbxassetid://17096327600",
	Forward = "rbxassetid://17096329187",
	Backward = "rbxassetid://17096330733",
}

-- Distance TextBox
local dodgeBox = Instance.new("TextBox", screenGui)
dodgeBox.Size = UDim2.new(0, 100, 0, 30)
dodgeBox.Position = UDim2.new(0, 20, 0, 20)
dodgeBox.Text = "7"
dodgeBox.ClearTextOnFocus = false
dodgeBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
dodgeBox.TextColor3 = Color3.new(1,1,1)
dodgeBox.PlaceholderText = "Dodge Dist"

-- Label
local distLabel = Instance.new("TextLabel", screenGui)
distLabel.Size = UDim2.new(0, 100, 0, 20)
distLabel.Position = UDim2.new(0, 20, 0, 0)
distLabel.Text = "自动躲避距离设置"
distLabel.BackgroundTransparency = 1
distLabel.TextColor3 = Color3.new(1,1,1)

-- Direction Label
local dirLabel = Instance.new("TextLabel", screenGui)
dirLabel.Size = UDim2.new(0, 120, 0, 30)
dirLabel.Position = UDim2.new(0, 20, 0, 60)
dirLabel.Text = "躲避类型: 左边"
dirLabel.BackgroundColor3 = Color3.fromRGB(45,45,45)
dirLabel.TextColor3 = Color3.new(1,1,1)

-- Switch Button
local switchBtn = Instance.new("TextButton", screenGui)
switchBtn.Size = UDim2.new(0, 100, 0, 30)
switchBtn.Position = UDim2.new(0, 20, 0, 100)
switchBtn.Text = "切换躲避模式"
switchBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
switchBtn.TextColor3 = Color3.new(1,1,1)

-- Toggle Button
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0, 20, 0, 140)
toggleBtn.Text = "自动躲避: OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
toggleBtn.TextColor3 = Color3.new(1,1,1)

-- HIDE BUTTON
local uiVisible = true
local hideBtn = Instance.new("TextButton", screenGui)
hideBtn.Size = UDim2.new(0, 60, 0, 25)
hideBtn.Position = UDim2.new(0, 130, 0, 20)
hideBtn.Text = "关闭"
hideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
hideBtn.TextColor3 = Color3.new(1,1,1)

hideBtn.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	for _, v in ipairs(screenGui:GetChildren()) do
		if v:IsA("GuiObject") and v ~= hideBtn then
			v.Visible = uiVisible
		end
	end
	hideBtn.Text = uiVisible and "关闭" or "打开"
end)

-- Button Logic
switchBtn.MouseButton1Click:Connect(function()
	currentDirection = (currentDirection % #directions) + 1
	dirLabel.Text = "自动躲避模式: " .. directions[currentDirection]
end)

toggleBtn.MouseButton1Click:Connect(function()
	ultraInstinctEnabled = not ultraInstinctEnabled
	toggleBtn.Text = "自动躲避: " .. (ultraInstinctEnabled and "ON" or "OFF")
	toggleBtn.BackgroundColor3 = ultraInstinctEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(80,0,0)
end)

-- Notify
local function notify(msg)
	pcall(function()
            Window:Notify({
                Title = "⌛️ | 开始加载",
                Desc = "内容过多...",
                Time = 5
            })
	end)
end
wait(4)
-- Dodge logic
local function playDodge()
	if not canDodge then return end
	canDodge = false

	local char = lp.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	local dir = directions[currentDirection]
	if dir == "Random" then
		local options = {"左边", "右边", "前面", "后面"}
		dir = options[math.random(1, #options)]
	end

	local distance = tonumber(dodgeBox.Text) or 7
	local offset = Vector3.new()
	if dir == "左边" then
		offset = -hrp.CFrame.RightVector * distance
	elseif dir == "右边" then
		offset = hrp.CFrame.RightVector * distance
	elseif dir == "前面" then
		offset = hrp.CFrame.LookVector * distance
	elseif dir == "后面" then
		offset = -hrp.CFrame.LookVector * distance
	end

	-- Play animation
	local anim = Instance.new("Animation")
	anim.AnimationId = dodgeAnims[dir]
	local track = hum:LoadAnimation(anim)
	track:Play()

	-- Move player
	char:PivotTo(CFrame.new(hrp.Position + offset))

	-- Reset cooldown
	task.delay(2, function()
		canDodge = true
	end)
end

-- Detection
RunService.Heartbeat:Connect(function()
	local char = lp.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local radius = 25

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (plr.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
			if dist <= radius then
				local hum = plr.Character:FindFirstChildOfClass("Humanoid")
				local animator = hum and hum:FindFirstChildOfClass("Animator")
				if animator then
					for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
						local animObj = track.Animation
						if animObj and animObj.AnimationId then
							local animId = tostring(animObj.AnimationId):match("%d+")
							if animId and table.find(killerAnims, animId) then
								if tick() - lastNotifTime >= notifCooldown then
									lastNotifTime = tick()
								end
								if ultraInstinctEnabled and canDodge then
									playDodge()
								end
								return
							end
						end
					end
				end
			end
		end
	end
end)

-- Restore GUI after respawn
lp.CharacterAdded:Connect(function()
	task.wait(1)
	screenGui.Parent = lp:WaitForChild("PlayerGui")
end)
            Window:Notify({
                Title = "✅ | 开启",
                Desc = "再说一次:不是我做的!!!",
                Time = 5
            })
        end
    })


Tab:Section({Title = "⚔️ | 瞄准:辅助瞄准"})

    Tab:Button({
        Title = "自瞄集成",
        Desc = "把好 几个角色的自瞄给和在里面了",
        Callback = function()
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local Workspace     = game:GetService("Workspace")
local LocalPlayer   = Players.LocalPlayer
local Character     = nil
local nextRandom    = 0
local spectatorDir  = nil
local didRotate     = false

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Blacklist

local function getCharacter()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	while not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") do
		char.ChildAdded:Wait()
	end
	return char
end

local function getRoleFolder(model)
	local pf = Workspace:FindFirstChild("Players")
	if not pf then return "Unknown" end
	for _, folder in ipairs(pf:GetChildren()) do
		if folder:IsA("Folder") then
			for _, m in ipairs(folder:GetChildren()) do
				if m == model then return folder.Name end
			end
		end
	end
	return "Unknown"
end

local function getNearestTarget(filter)
	local best, dist = nil, math.huge
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
			local m = pl.Character
			if filter(m) then
				local d = (m.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
				if d < dist then dist, best = d, m end
			end
		end
	end
	return best, dist
end

local function lerpFast(dir)
	local root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not root or dir.Magnitude == 0 then return end
	local cur = root.CFrame.LookVector
	local tgt = dir.Unit
	local lerped = cur:Lerp(tgt, 0.2)
	root.CFrame = CFrame.new(root.Position, root.Position + lerped)
	didRotate = true
end

local function lerpSpectator(dir)
	local root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not root or dir.Magnitude == 0 then return end
	local cur = root.CFrame.LookVector
	local tgt = dir.Unit
	local lerped = cur:Lerp(tgt, 0.05)
	root.CFrame = CFrame.new(root.Position, root.Position + lerped)
	didRotate = true
end

local function lerpMove(dir)
	local root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not root or dir.Magnitude == 0 then return end
	local cur = root.CFrame.LookVector
	local tgt = dir.Unit
	local lerped = cur:Lerp(tgt, 0.1)
	root.CFrame = CFrame.new(root.Position, root.Position + lerped)
	didRotate = true
end

local function canSee(targetPart)
	local root = Character.HumanoidRootPart
	rayParams.FilterDescendantsInstances = { Character }
	local ray = Workspace:Raycast(root.Position, targetPart.Position - root.Position, rayParams)
	return not ray or ray.Instance:IsDescendantOf(targetPart.Parent)
end

local function lookAtTarget(model)
	local root = Character and Character:FindFirstChild("HumanoidRootPart")
	if root and canSee(model.HumanoidRootPart) then
		lerpFast((model.HumanoidRootPart.Position - root.Position) * Vector3.new(1, 0, 1))
	end
end

local function lookAwayFrom(model)
	local root = Character and Character:FindFirstChild("HumanoidRootPart")
	if root and canSee(model.HumanoidRootPart) then
		lerpFast((root.Position - model.HumanoidRootPart.Position) * Vector3.new(1, 0, 1))
	end
end

local function randomDir()
	local a = math.random() * 2 * math.pi
	return Vector3.new(math.cos(a), 0, math.sin(a))
end

local function onStep()
	if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

	local hs = 0
	for _, c in ipairs(Character:GetChildren()) do
		if c:IsA("Humanoid") then hs += 1 end
	end
	if hs > 1 then return end

	local humanoid = Character:FindFirstChildOfClass("Humanoid")
	if humanoid then humanoid.AutoRotate = false end
	didRotate = false

	local modelName = Character.Name
	local role      = getRoleFolder(Character)

	if role == "Killers" then
		if (modelName == "1x1x1x1" or modelName == "John Doe") and humanoid and humanoid.MoveDirection.Magnitude == 0 then
			local nearest = getNearestTarget(function(m)
				return m.Parent and m.Parent.Name == "Survivors"
			end)
			if nearest then lookAtTarget(nearest) end
		else
			local lowest, lowHP = nil, math.huge
			for _, pl in ipairs(Players:GetPlayers()) do
				if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
					local model = pl.Character
					if model.Parent and model.Parent.Name == "Survivors" and model:FindFirstChild("Humanoid") then
						local hp = model.Humanoid.Health
						if hp < lowHP then
							lowHP = hp
							lowest = model
						end
					end
				end
			end
			if lowest then lookAtTarget(lowest) end
		end

	elseif role == "Survivors" then
		if modelName == "Elliot" then
			local tgt = getNearestTarget(function(m)
				return m.Parent.Name == "Survivors" and m:FindFirstChild("Humanoid") and m.Humanoid.Health < 75
			end)
			if tgt then lookAtTarget(tgt) end

		elseif modelName == "007n7" or modelName == "Noob" then
			local tgt, d = getNearestTarget(function(m) return m.Parent.Name == "Killers" end)
			if tgt and d <= 50 then lookAwayFrom(tgt) end

		else
			local tgt, d = getNearestTarget(function(m) return m.Parent.Name == "Killers" end)
			if tgt and d <= 20 then lookAtTarget(tgt) end
		end

	elseif role == "Spectating" then
		if humanoid and humanoid.MoveDirection.Magnitude == 0 then
			if os.clock() >= nextRandom then
				spectatorDir = randomDir()
				nextRandom = os.clock() + math.random(30,300)/100
			end
			if spectatorDir then lerpSpectator(spectatorDir) end
		end
	end

	if not didRotate and humanoid and humanoid.MoveDirection.Magnitude > 0 then
		lerpMove(humanoid.MoveDirection)
	end
end

local function setupChar()
	Character = getCharacter()
	local h = Character:FindFirstChildOfClass("Humanoid")
	if h then h.Died:Connect(function() Character = nil end) end
end

LocalPlayer.CharacterAdded:Connect(setupChar)
if LocalPlayer.Character then task.wait(1); setupChar() end
RunService.RenderStepped:Connect(onStep)
        end
    })
Window:Line()
    local Tab = Window:Tab({Title = "自动格挡和冲拳", Icon = "tag"}) do
      Tab:Section({Title = "咳以哟 | 自动格挡"})
    
        Tab:Toggle({
        Title = "自动格挡",
        Desc = "杀手靠近你之后会自动触发格挡",
        Value = false,
        Callback = function(Value)
        autoBlockOn = Value 
        end})
    
        Tab:Toggle({
        Title = "自动格挡声音",
        Desc = "自动格挡后会发出声音 不是FE",
        Value = false,
        Callback = function(state)
        autoBlockAudioOn = state
        end})
    
            Tab:Toggle({
        Title = "自动格挡范围",
        Desc = "启用滑块的自动格挡范围",
        Value = false,
        Callback = function(Value)
             strictRangeOn = Value
        end}) 
        local facingCheckEnabled = true

        Tab:Slider({
        Title = "格挡范围设置",
        Min = 5,
        Max = 25,
        Rounding = 16,
        Value = 1,
        Callback = function(Text)
           detectionRange = tonumber(Text) or detectionRange
        end})
    
            Tab:Toggle({
        Title = "自动格挡检测",
        Desc = "自动检测杀手想不想打你然后做出格挡",
        Value = false,
        Callback = function(Value)
          facingCheckEnabled = Value
        end})
    
        Tab:Dropdown({
        Title = "选择检测模式",
        List = {"loser 检测", "OP 检测"},
        Value = "loser 检测",
        Callback = function(Option)
          looseFacing = Option == "loser 检测" 
        end})
    
               Tab:Toggle({
        Title = "启用格挡预判",
        Desc = "自动预判杀手的行走方向",
        Value = false,
        Callback = function(Value)
          predictiveBlockOn = Value
        end})
        
            Tab:Slider({
        Title = "格挡预判范围设置",
        Min = 0,
        Max = 45,
        Rounding = 7,
        Value = 1,
        Callback = function(text)
             local num = tonumber(text)
          if num then
            detectionRange = num
          end
        end})
            
      Tab:Section({Title = "鹅多杀! | 冲拳辅助"})
    
            Tab:Toggle({
        Title = "自动冲拳",
        Desc = "解锁冲拳后会自动的向杀手冲拳",
        Value = false,
        Callback = function(Value)
            autoPunchOn = Value
        end})
        
                Tab:Toggle({
        Title = "冲拳自瞄",
        Desc = "冲拳时自动瞄准杀手 建议搭配自动冲拳使用",
        Value = false,
        Callback = function(Value)
            aimPunch = Value 
        end})
        
        Tab:Slider({
        Title = "自瞄预判范围",
        Min = 0,
        Max = 7,
        Rounding = 3,
        Value = 0.1,
        Callback = function(Value)
          predictionValue = Value
        end})
    
        Tab:Section({Title = "冲拳抽象功能"})
    
            Tab:Toggle({
        Title = "冲拳时旋转",
        Desc = "在出拳的时候旋转(可以增加攻击半径)",
        Value = false,
        Callback = function(Value)
          flingPunchOn = Value 
        end})
    
                Tab:Slider({
        Title = "冲拳旋转速度设置",
        Min = 1,
        Max = 100,
        Rounding = 1,
        Value = 1,
        Callback = function(Value)
          flingPower = Value
        end})
   end
   local Tab = Window:Tab({Title = "自定义格挡动画", Icon = "wrench"}) do
      Tab:Section({Title = "格挡动画设置"})
      Tab:Section({Title = "动画格式:1380708430168"})
          Tab:Textbox({
        Title = "输入Roblox动画资产ID",
        Desc = "输入一个有效的Roblox动画资产ID",
        Placeholder = "输入",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(text)
          customBlockAnimId = Text 
        end})
    
            Tab:Toggle({
        Title = "启用格挡动画",
        Desc = "启用自定义的格挡动画",
        Value = false,
        Callback = function(Value)
          customBlockEnabled = Value 
        end})
        
       Tab:Section({Title = "冲拳动画设置"})
        
       Tab:Textbox({
        Title = "输入Roblox动画资产ID",
        Desc = "输入一个有效的Roblox动画资产ID",
        Placeholder = "输入",
        Value = "",
        ClearTextOnFocus = false,
        Callback = function(Text)
          customPunchAnimId = Text 
        end})
    
            Tab:Toggle({
        Title = "启用冲拳动画",
        Desc = "启用自定义的冲拳动画",
        Value = false,
        Callback = function(Value)
          customPunchEnabled = Value  
        end})
  end
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Tag = {
    Color = "#FFFF00", 
    Chattag = "[CHANGED HUB VIP USER]" 
}

TextChatService.OnIncomingMessage = function(Message, ChatStyle)
    local MessageProperties = Instance.new("TextChatMessageProperties")
    local Player = Players:GetPlayerByUserId(Message.TextSource.UserId)
    if Player.Name == LocalPlayer.Name then
        MessageProperties.PrefixText = '<font color="' .. Tag.Color .. '">' .. Tag.Chattag .. '</font> ' .. Message.PrefixText
    end
    return MessageProperties
end
end




local function fireRemoteBlock()
local args = {"UseActorAbility", "Block"}
ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

local function isFacing(localRoot, targetRoot)
    if not facingCheckEnabled then
        return true
    end

    local dir = (localRoot.Position - targetRoot.Position).Unit
    local dot = targetRoot.CFrame.LookVector:Dot(dir)
    return looseFacing and dot > -0.3 or dot > 0
end

local function playCustomAnim(animId, isPunch)
    if not Humanoid then
        warn("Humanoid missing")
        return
    end

    if not animId or animId == "" then
        warn("No animation ID provided")
        return
    end

    local now = tick()
    local lastTime = isPunch and lastPunchTime or lastBlockTime
    if now - lastTime < 1 then
        return
    end

    -- Stop other known anims
    for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
        local animNum = tostring(track.Animation.AnimationId):match("%d+")
        if table.find(isPunch and punchAnimIds or blockAnimIds, animNum) then
            track:Stop()
        end
    end

    -- Create and load the animation
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. animId

    local success, track = pcall(function()
        return Humanoid:LoadAnimation(anim)
    end)

    if success and track then
        print("✅ Playing custom " .. (isPunch and "punch" or "block") .. " animation:", animId)
        track:Play()
        if isPunch then
            lastPunchTime = now
        else
            lastBlockTime = now
        end
    else
        warn("❌ Failed to load or play custom animation: " .. animId)
    end
end

-- Fling coroutine
coroutine.wrap(function()
    local hrp, c, vel, movel = nil, nil, nil, 0.1
    while true do
        RunService.Heartbeat:Wait()
        if hiddenfling then
            while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
                RunService.Heartbeat:Wait()
                c = lp.Character
                hrp = c and c:FindFirstChild("HumanoidRootPart")
            end
            if hiddenfling then
                vel = hrp.Velocity
                hrp.Velocity = vel * flingPower + Vector3.new(0, flingPower, 0)
                RunService.RenderStepped:Wait()
                hrp.Velocity = vel
                RunService.Stepped:Wait()
                hrp.Velocity = vel + Vector3.new(0, movel, 0)
                movel = movel * -1
            end
        end
    end
end)()


-- ===== Robust Sound Auto Block (replace your current Sound Auto Block) =====
local soundHooks = {}     -- [Sound] = {playedConn, propConn, destroyConn}
local soundBlockedUntil = {} -- [Sound] = timestamp when we can block again (throttle)

local function extractNumericSoundId(sound)
    if not sound or not sound.SoundId then return nil end
    local sid = tostring(sound.SoundId)

    -- Prefer numeric id if present
    local num = sid:match("%d+")
    if num then return num end

    -- Fallbacks (these won't match your numeric whitelist, but kept for completeness)
    local hash = sid:match("[&%?]hash=([^&]+)")
    if hash then return "&hash="..hash end
    local path = sid:match("rbxasset://sounds/.+")
    if path then return path end

    return nil
end

local function getSoundWorldPosition(sound)
    if not sound then return nil end
    if sound.Parent and sound.Parent:IsA("BasePart") then
        return sound.Parent.Position, sound.Parent
    end
    if sound.Parent and sound.Parent:IsA("Attachment") and sound.Parent.Parent and sound.Parent.Parent:IsA("BasePart") then
        return sound.Parent.Parent.Position, sound.Parent.Parent
    end
    -- deep search for any BasePart ancestor/descendant
    local found = sound.Parent and sound.Parent:FindFirstChildWhichIsA("BasePart", true)
    if found then
        return found.Position, found
    end
    return nil, nil
end

local function attemptBlockForSound(sound)
    if not autoBlockAudioOn then return end
    if not sound or not sound:IsA("Sound") then return end

    -- Only care when actually playing
    if not sound.IsPlaying then return end

    local id = extractNumericSoundId(sound)
    if not id or not autoBlockTriggerSounds[id] then return end

    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    -- Throttle one block per sound for a short window
    if soundBlockedUntil[sound] and tick() < soundBlockedUntil[sound] then
        return
    end

    local soundPos, soundPart = getSoundWorldPosition(sound)
    local shouldBlock = false
    local facingOK = true

    if soundPos then
        local dist = (myRoot.Position - soundPos).Magnitude
        if dist <= detectionRange then
            shouldBlock = true
            -- Only do facing check if we have a BasePart to use (soundPart)
            if facingCheckEnabled and soundPart and soundPart:IsA("BasePart") then
                facingOK = isFacing(myRoot, soundPart)
            end
        end
    else
        -- No position available -> block anyway (per your request)
        shouldBlock = true
        facingOK = true
    end

    if shouldBlock and facingOK then
        fireRemoteBlock()
        if customBlockEnabled and customBlockAnimId ~= "" then
            playCustomAnim(customBlockAnimId, false)
        end
        -- throttle: don't spam block for the same sound
        soundBlockedUntil[sound] = tick() + 1.2
    end
end

local function hookSound(sound)
    if not sound or not sound:IsA("Sound") then return end
    if soundHooks[sound] then return end -- already hooked

    local playedConn = sound.Played:Connect(function()
        -- handle immediate play
        pcall(attemptBlockForSound, sound)
    end)

    local propConn = sound:GetPropertyChangedSignal("IsPlaying"):Connect(function()
        if sound.IsPlaying then
            pcall(attemptBlockForSound, sound)
        end
    end)

    local destroyConn
    destroyConn = sound.Destroying:Connect(function()
        -- cleanup
        if playedConn and playedConn.Connected then playedConn:Disconnect() end
        if propConn and propConn.Connected then propConn:Disconnect() end
        if destroyConn and destroyConn.Connected then destroyConn:Disconnect() end
        soundHooks[sound] = nil
        soundBlockedUntil[sound] = nil
    end)

    soundHooks[sound] = {playedConn, propConn, destroyConn}

    -- If it's already playing right now, check it immediately
    if sound.IsPlaying then
        task.spawn(function() pcall(attemptBlockForSound, sound) end)
    end
end

-- Hook existing Sounds across the game (covers workspace, SoundService, Lighting, etc.)
for _, desc in ipairs(game:GetDescendants()) do
    if desc:IsA("Sound") then
        pcall(hookSound, desc)
    end
end

-- Hook any future Sounds
game.DescendantAdded:Connect(function(desc)
    if desc:IsA("Sound") then
        pcall(hookSound, desc)
    end
end)
-- ===== End Robust Sound Auto Block =====

-- Auto block + punch detection loop
RunService.RenderStepped:Connect(function()
    local myChar = lp.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    Humanoid = myChar:FindFirstChildOfClass("Humanoid")
        -- Auto Block: Trigger block if a valid animation is played by a killer
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local animTracks = hum and hum:FindFirstChildOfClass("Animator") and hum:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks()

            if hrp and myRoot and (hrp.Position - myRoot.Position).Magnitude <= detectionRange then
                for _, track in ipairs(animTracks or {}) do
                    local id = tostring(track.Animation.AnimationId):match("%d+")
                    if table.find(autoBlockTriggerAnims, id) then
                        if autoBlockOn and (not strictRangeOn or (hrp.Position - myRoot.Position).Magnitude <= detectionRange) then
                            if isFacing(myRoot, hrp) then
                                fireRemoteBlock()
                                if customBlockEnabled and customBlockAnimId ~= "" then
                                    playCustomAnim(customBlockAnimId, false)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- Detect if player is playing a block animation, and blockTP is enabled
    if blockTPEnabled and Humanoid and tick() - lastBlockTpTime >= 5 then
        for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
            local animId = tostring(track.Animation.AnimationId):match("%d+")
            if animId == "72722244508749" or animId == "96959123077498" then
                local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if myRoot then
                    local killers = {"c00lkidd", "Jason", "JohnDoe", "1x1x1x1", "Noli"}
                    for _, name in ipairs(killers) do
                        local killer = workspace:FindFirstChild("Players")
                            and workspace.Players:FindFirstChild("Killers")
                            and workspace.Players.Killers:FindFirstChild(name)

                        if killer and killer:FindFirstChild("HumanoidRootPart") then
                            lastBlockTpTime = tick()

                            task.spawn(function()
                                local startTime = tick()
                                while tick() - startTime < 0.5 do
                                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                                        local myRoot = lp.Character.HumanoidRootPart
                                        local targetHRP = killer.HumanoidRootPart
                                        local direction = targetHRP.CFrame.LookVector
                                        local tpPosition = targetHRP.Position + direction * 6
                                        myRoot.CFrame = CFrame.new(tpPosition)
                                    end
                                    task.wait()
                                end
                            end)

                            break
                        end
                    end
                end
                break
            end
        end
    end

    -- Predictive Auto Block: Check killer range and time
    if predictiveBlockOn and tick() > predictiveCooldown then
        local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
        local myChar = lp.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHum = myChar and myChar:FindFirstChild("Humanoid")

        if killersFolder and myHRP and myHum then
            local killerInRange = false

            for _, killer in ipairs(killersFolder:GetChildren()) do
                local hrp = killer:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    if dist <= detectionRange then
                        killerInRange = true
                        break
                    end
                end
            end

            -- Handle killer entering range
            if killerInRange then
                if not killerInRangeSince then
                    killerInRangeSince = tick()  -- Start the timer when the killer enters the range
                elseif tick() - killerInRangeSince >= edgeKillerDelay then
                    -- Block if the killer has stayed in range long enough
                    fireRemoteBlock()
                    predictiveCooldown = tick() + 2  -- Set cooldown to avoid blocking too quickly again
                    killerInRangeSince = nil  -- Reset the timer
                end
            else
                killerInRangeSince = nil  -- Reset timer if the killer leaves range
            end
        end
    end



    -- Auto Punch
    if autoPunchOn then
        local gui = PlayerGui:FindFirstChild("MainUI")
        local punchBtn = gui and gui:FindFirstChild("AbilityContainer") and gui.AbilityContainer:FindFirstChild("Punch")
        local charges = punchBtn and punchBtn:FindFirstChild("Charges")

        if charges and charges.Text == "1" then
            local killerNames = {"c00lkidd", "Jason", "JohnDoe", "1x1x1x1", "Noli"}
            for _, name in ipairs(killerNames) do
                local killer = workspace:FindFirstChild("Players")
                    and workspace.Players:FindFirstChild("Killers")
                    and workspace.Players.Killers:FindFirstChild(name)

                if killer and killer:FindFirstChild("HumanoidRootPart") then
                    local root = killer.HumanoidRootPart
                    local myChar = lp.Character
                    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    if root and myRoot and (root.Position - myRoot.Position).Magnitude <= 10 then

                        -- Aim Punch: Constant look at killer with prediction
                        if aimPunch then
                            local humanoid = myChar:FindFirstChild("Humanoid")
                            if humanoid then
                                humanoid.AutoRotate = false
                            end

                            task.spawn(function()
                                local start = tick()
                                while tick() - start < 2 do
                                    if myRoot and root and root.Parent then
                                        local predictedPos = root.Position + (root.CFrame.LookVector * predictionValue)
                                        myRoot.CFrame = CFrame.lookAt(myRoot.Position, predictedPos)
                                    end
                                    task.wait()
                                end
                                -- Reset movement after aim
                                if humanoid then
                                    humanoid.AutoRotate = true
                                end
                            end)
                        end

                        -- Trigger punch GUI button
                        for _, conn in ipairs(getconnections(punchBtn.MouseButton1Click)) do
                            pcall(function()
                                conn:Fire()
                            end)
                        end

                        -- Fling Punch: Constant TP 2 studs in front of killer for 1 second
                        if flingPunchOn then
                            hiddenfling = true
                            local targetHRP = root
                            task.spawn(function()
                                local start = tick()
                                while tick() - start < 1 do
                                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and targetHRP and targetHRP.Parent then
                                        local frontPos = targetHRP.Position + (targetHRP.CFrame.LookVector * 2)
                                        lp.Character.HumanoidRootPart.CFrame = CFrame.new(frontPos, targetHRP.Position)
                                    end
                                    task.wait()
                                end
                                hiddenfling = false
                            end)
                        end

                        -- Play custom punch animation if enabled
                        if customPunchEnabled and customPunchAnimId ~= "" then
                            playCustomAnim(customPunchAnimId, true)
                        end

                        break -- Only punch one killer per frame
                    end
                end
            end
        end
    end

end)

-- Cooldown tracking for each replacement type
local lastReplaceTime = {
    block = 0,
    punch = 0,
    charge = 0,
}

-- Continuous custom animation replacer (runs forever if toggled on)
task.spawn(function()
    while true do
        RunService.Heartbeat:Wait()

        local char = lp.Character
        if not char then continue end

        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if not animator then continue end

        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local animId = tostring(track.Animation.AnimationId):match("%d+")

            -- Block animation replacement
            if customBlockEnabled and customBlockAnimId ~= "" and table.find(blockAnimIds, animId) then
                if tick() - lastReplaceTime.block >= 3 then
                    lastReplaceTime.block = tick()
                    track:Stop()
                    local newAnim = Instance.new("Animation")
                    newAnim.AnimationId = "rbxassetid://" .. customBlockAnimId
                    local newTrack = animator:LoadAnimation(newAnim)
                    newTrack:Play()
                    break
                end
            end

            -- Punch animation replacement
            if customPunchEnabled and customPunchAnimId ~= "" and table.find(punchAnimIds, animId) then
                if tick() - lastReplaceTime.punch >= 3 then
                    lastReplaceTime.punch = tick()
                    track:Stop()
                    local newAnim = Instance.new("Animation")
                    newAnim.AnimationId = "rbxassetid://" .. customPunchAnimId
                    local newTrack = animator:LoadAnimation(newAnim)
                    newTrack:Play()
                    break
                end
            end

            -- Charge animation replacement
            if customChargeEnabled and customChargeAnimId ~= "" and table.find(chargeAnimIds, animId) then
                if tick() - lastReplaceTime.charge >= 3 then
                    lastReplaceTime.charge = tick()
                    track:Stop()
                    local newAnim = Instance.new("Animation")
                    newAnim.AnimationId = "rbxassetid://" .. customChargeAnimId
                    local newTrack = animator:LoadAnimation(newAnim)
                    newTrack:Play()
                    break
                end
            end
        end
    end
end)

-- Readd infinite stamina
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if infiniteStamina then
        enableInfiniteStamina()
    end
end)