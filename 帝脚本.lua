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

local Tab = Window:Tab({Title = "👤 | 玩家", Icon = "star"})

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

Tab:Section({Title = "⚡️ | 玩家:体力设置"})

    Tab:Slider({
        Title = "体力上限设置",
        Min = 5,
        Max = 500,
        Rounding = 100,
        Value = 5,
        Callback = function(Value)
local Sprinting = game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting
local stamina = require(Sprinting)
stamina.MaxStamina = Value
stamina.StaminaLossDisabled = false
        end
    })

    Tab:Toggle({
        Title = "无限体力",
        Desc = "",
        Value = false,
        Callback = function(Value)
       _G.InfStamina = Value
       if Value then
           spawn(function()
               while _G.InfStamina do
                   local success, staminaModule = pcall(function()
                       return require(game.ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting"))
                   end)
                   if success and staminaModule then
                       staminaModule.MaxStamina = 696969
                       staminaModule.Stamina = 696969
                       if staminaModule.__staminaChangedEvent then
                           staminaModule.__staminaChangedEvent:Fire(staminaModule.Stamina)
                       end
                   end
                   wait(0.1)
               end
           end)
       end
        end
    })

Tab:Section({Title = "🧰 | 自动:发电机"})

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