local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/QQ-9-2-8-9-50173/refs/heads/main/Ul%E6%BA%90%E7%A0%81.lua"))()

local Window = redzlib:MakeWindow({
    Title = "北极星脚本",
    SubTitle = "极速传奇",
    SaveFolder = "Redz Config"
})

local function addRainbowTitleToLocalPlayer(player, titleText)
    local function addTitleToCharacter(character)
        local head = character:FindFirstChild("Head") or character:WaitForChild("Head")
        local old = head:FindFirstChild("PlayerTitle")
        if old then old:Destroy() end
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "PlayerTitle"
        billboardGui.Adornee = head
        billboardGui.Size = UDim2.new(4, 0, 1, 0)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.MaxDistance = 1000
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = titleText
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextWrapped = true
        textLabel.Parent = billboardGui
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = Color3.new(1, 1, 1)
        stroke.Parent = textLabel
        local gradient = Instance.new("UIGradient")
        gradient.Rotation = 90
        gradient.Parent = textLabel
        
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            local time = tick() * 0.5
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHSV(time % 1, 1, 1)),
                ColorSequenceKeypoint.new(0.2, Color3.fromHSV((time + 0.2) % 1, 1, 1)),
                ColorSequenceKeypoint.new(0.4, Color3.fromHSV((time + 0.4) % 1, 1, 1)),
                ColorSequenceKeypoint.new(0.6, Color3.fromHSV((time + 0.6) % 1, 1, 1)),
                ColorSequenceKeypoint.new(0.8, Color3.fromHSV((time + 0.8) % 1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(time % 1, 1, 1))
            })
        end)
        local destroyTimer = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            if not billboardGui:IsDescendantOf(game) then
                destroyTimer:Disconnect()
                if connection then connection:Disconnect() end
                return
            end
            
            if (os.clock() - (billboardGui:GetAttribute("CreationTime") or os.clock())) >= 10 then
                billboardGui:Destroy()
                destroyTimer:Disconnect()
                if connection then connection:Disconnect() end
            end
        end)
        
        billboardGui:SetAttribute("CreationTime", os.clock())
        
        billboardGui.AncestryChanged:Connect(function()
            if not billboardGui:IsDescendantOf(game) then
                if connection then connection:Disconnect() end
                if destroyTimer then destroyTimer:Disconnect() end
            end
        end)
        
        billboardGui.Parent = head
    end
    
    local character = player.Character or player.CharacterAdded:Wait()
    addTitleToCharacter(character)
    player.CharacterAdded:Connect(addTitleToCharacter)
end

addRainbowTitleToLocalPlayer(game.Players.LocalPlayer, "北极星脚本 用户")
-- Anti-AFK
print("反挂机已开启")
local Start = tick()
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- UI Elements
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://98541457845136", BackgroundTransparency = 0, Size = UDim2.fromOffset(60, 60), },
    Corner = { CornerRadius = UDim.new(0, 10) }
})

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://4925128366"
sound.Parent = game.Workspace
sound:Play()

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local autoOrb = false
local autoGem = false
local autoHoop = false
local autoRebirth = false
local autoOpen = false
local autoEvolve = false
local autoRace = false
local PetGlitch = false

local PlayerWalkSpeed = false
local PlayerJumpPower = false

local plyr = game.Players.LocalPlayer
local chr = plyr.Character
local rootPart = chr.HumanoidRootPart

local currentPlace
local selectedMap
local selectedCrystal

local MainGame = 3101667897
local SpeedDesert = 3276265788
local OuterSpace = 3232996272

function TeleportTO(placeCFrame)
    if chr then
        rootPart.CFrame = placeCFrame;
    end
end

getgenv().cs = true 
getgenv().xc = true
getgenv().hs = true
getgenv().gl = true
getgenv().autocs = true
getgenv().sbsA = true
getgenv().sbsB = true
getgenv().sbsC = true
getgenv().sbsD = true
getgenv().egg1 = true
getgenv().egg2 = true
getgenv().egg3 = true
getgenv().egg4 = true
getgenv().egg5 = true
getgenv().egg6 = true
getgenv().egg7 = true
getgenv().egg8 = true
getgenv().egg9 = true
getgenv().egg10 = true

function AutoRace()
    spawn(function()
        if game.placeId == MainGame then
            while autoRace do
                game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                TeleportTO(game.workspace.raceMaps.Grassland.finishPart.CFrame)
                task.wait(0.1)
                TeleportTO(game.workspace.raceMaps.Magma.finishPart.CFrame)
                task.wait(0.1)
                TeleportTO(game.workspace.raceMaps.Desert.finishPart.CFrame)
                wait(0.3)
            end
        elseif game.placeId == SpeedDesert then
            while autoRace do
                game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                TeleportTO(game.workspace.raceMaps.Speedway.finishPart.CFrame)
                wait(0.2)
            end
        elseif game.placeId == OuterSpace then
            while autoRace do
                game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
                TeleportTO(game.workspace.raceMaps.Starway.finishPart.CFrame)
                wait(0.2)
            end
        end
    end)
end

function AutoHoop()
    spawn(function()
        while autoHoop and plyr do
            for _, v in pairs(game.Workspace.Hoops:GetChildren()) do
                v.CFrame = rootPart.CFrame
            end
            wait()
        end
    end)
end

--卡宠
function cs()
    while getgenv().cs == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
        wait()
    end
end

function xc()
    while getgenv().xc == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
        wait()
    end
end

function hs()
    while getgenv().hs == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        wait()
    end
end

function gl()
    while getgenv().gl == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
        wait()
    end
end

function sbsA()
    while getgenv().sbsA == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        wait()
    end
end

function sbsB()
    while getgenv().sbsB == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
        wait()
    end
end

function sbsC()
    while getgenv().sbsC == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
        wait()
    end
end

function sbsD()
    while getgenv().sbsD == true do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
        wait()
    end
end

function autocs()
    while getgenv().autocs == true do
        game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
        wait()
    end
end

function egg1()
    while getgenv().egg1 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Red Crystal")
    end
end

function egg2()
    while getgenv().egg2 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Blue Orb")
    end
end

function egg3()
    while getgenv().egg3 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Yellow Crystal")
    end
end

function egg4()
    while getgenv().egg4 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Lightning Crystal")
    end
end

function egg5()
    while getgenv().egg5 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Snow Crystal")
    end
end

function egg6()
    while getgenv().egg6 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Lava Crystal")
    end
end

function egg7()
    while getgenv().egg7 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Lightning Crystal")
    end
end

function egg8()
    while getgenv().egg8 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Desert Crystal")
    end
end

function egg9()
    while getgenv().egg9 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Electro Crystal")
    end
end

function egg10()
    while getgenv().egg10 == true do
        wait(0.1)
        game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", "Electro Legends Crystal")
    end
end

local MainTab = Window:MakeTab({"辅助", "cool"})
MainTab:AddToggle({
    Title = "速度 (开/关)",
    Default = false,
    Callback = function(v)
        if v == true then
            sudu = game:GetService("RunService").Heartbeat:Connect(function()
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                    if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                    end
                end
            end)
        elseif not v and sudu then
            sudu:Disconnect()
            sudu = nil
        end
    end
})

MainTab:AddSlider({
    Title = "速度设置",
    Description = "拉条",
    Default = 1,
    Min = 1,
    Max = 1000,
    Callback = function(v)
        Speed = v
    end
})

MainTab:AddButton({
    Title = "无限跳跃",
    Callback = function()
        game:GetService("UserInputService").JumpRequest:connect(function()
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")		
        end)
    end
})

MainTab:AddButton({
    Title = "北极星飞行",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/%E5%8C%97%E6%9E%81%E6%98%9F%E9%A3%9E%E8%A1%8C.Lua"))()
    end
})


local MainTab = Window:MakeTab({"卡宠", "cool"})

-- UI Elements
MainTab:AddToggle({
    Title = "城市",
    Default = false,
    Callback = function(Value)
        getgenv().cs = Value
        if Value then
            task.spawn(cs)
        end
    end
})

MainTab:AddToggle({
    Title = "雪城",
    Default = false,
    Callback = function(Value)
        getgenv().xc = Value
        if Value then
            task.spawn(xc)
        end
    end
})

MainTab:AddToggle({
    Title = "火山",
    Default = false,
    Callback = function(Value)
        getgenv().hs = Value
        if Value then
            task.spawn(hs)
        end
    end
})

MainTab:AddToggle({
    Title = "公路",
    Default = false,
    Callback = function(Value)
        getgenv().gl = Value
        if Value then
            task.spawn(gl)
        end
    end
})

local MainTab = Window:MakeTab({"刷宝石", "cool"})

MainTab:AddToggle({
    Title = "城市宝石",
    Default = false,
    Callback = function(Value)
        getgenv().sbsA = Value
        if Value then
            task.spawn(sbsA)
        end
    end
})

MainTab:AddToggle({
    Title = "雪城宝石",
    Default = false,
    Callback = function(Value)
        getgenv().sbsB = Value
        if Value then
            task.spawn(sbsB)
        end
    end
})

MainTab:AddToggle({
    Title = "火山宝石",
    Default = false,
    Callback = function(Value)
        getgenv().sbsC = Value
        if Value then
            task.spawn(sbsC)
        end
    end
})

MainTab:AddToggle({
    Title = "公路宝石",
    Default = false,
    Callback = function(Value)
        getgenv().sbsD = Value
        if Value then
            task.spawn(sbsD)
        end
    end
})

local MainTab = Window:MakeTab({"重生类", "cool"})

MainTab:AddToggle({
    Title = "自动重生",
    Default = false,
    Callback = function(Value)
        getgenv().autocs = Value
        if Value then
            task.spawn(autocs)
        end
    end
})

MainTab:AddToggle({
    Title = "自动刷圈",
    Default = false,
    Callback = function(Value)
        autoHoop = Value
        if Value then
            AutoHoop()
        end
    end
})

for _, v in pairs(game.ReplicatedStorage.chestRewards:GetChildren()) do
    game.ReplicatedStorage.rEvents.checkChestRemote:InvokeServer(v.Name)
end

local MainTab = Window:MakeTab({"比赛类", "cool"})

MainTab:AddToggle({
    Title = "自动比赛",
    Default = false,
    Callback = function(Value)
        autoRace = Value
        if Value then
            AutoRace()
        end
    end
})

local Maps = {}
for _, v in pairs(game.workspace.raceMaps:GetChildren()) do
    table.insert(Maps, v.Name)
end

MainTab:AddDropdown({
    Title = "比赛终点传送",
    Values = Maps,
    Default = 1,
    Callback = function(Value)
        selectedMap = Value
    end
})

MainTab:AddButton({
    Title = "点击传送",
    Callback = function()
        TeleportTO(game.workspace.raceMaps[selectedMap].finishPart.CFrame)
    end
})

local MainTab = Window:MakeTab({"修改类", "cool"})

MainTab:AddSlider({
    Title = "修改经验值",
    Default = 0,
    Min = 0,
    Max = 999999999999999999999999999999999999999999999999999999999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.exp.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改等级",
    Default = 0,
    Min = 0,
    Max = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.level.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改比赛数",
    Default = 0,
    Min = 0,
    Max = 999999999999999999999999999999999999999999999999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Races.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改圈数",
    Default = 0,
    Min = 0,
    Max = 99999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Hoops.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改重生",
    Default = 0,
    Min = 0,
    Max = 999999999999999999999999999999999999999999999999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改步数",
    Default = 0,
    Min = 0,
    Max = 9999999999999999999999999999999999999999999999999999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.leaderstats.Steps.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改尾迹容量",
    Default = 0,
    Min = 0,
    Max = 100000000000,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.maxPetCapacity.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改宠物位数量",
    Default = 0,
    Min = 0,
    Max = 10000000000000,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.maxPetCapacity.Value = Value
    end
})

MainTab:AddSlider({
    Title = "修改宝石数量",
    Default = 0,
    Min = 0,
    Max = 9999999999999999999999999999999999999999999999999999999999999999999999999999999999,
    Rounding = 0,
    Callback = function(Value)
        game:GetService("Players").LocalPlayer.Gems.Value = Value
    end
})

MainTab:AddToggle({
    Title = "自动设置最大速度",
    Default = false,
    Callback = function(Value)
        if Value then 
            while true do 
                game:GetService("ReplicatedStorage").rEvents.changeSpeedJumpRemote:InvokeServer("changeSpeed", math.huge)
                wait() 
            end 
        end
    end
})

MainTab:AddToggle({
    Title = "自动设置最大跳跃",
    Default = false,
    Callback = function(Value)
        if Value then 
            while true do 
                game:GetService("ReplicatedStorage").rEvents.changeSpeedJumpRemote:InvokeServer("changeJump", math.huge)
                wait() 
            end 
        end
    end
})

local MainTab = Window:MakeTab({"买宠类", "cool"})

MainTab:AddToggle({
    Title = "红色水晶[300宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg1 = Value
        if Value then
            task.spawn(egg1)
        end
    end
})

MainTab:AddToggle({
    Title = "蓝色水晶[600宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg2 = Value
        if Value then
            task.spawn(egg2)
        end
    end
})

MainTab:AddToggle({
    Title = "黄色水晶[1.2K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg3 = Value
        if Value then
            task.spawn(egg3)
        end
    end
})

MainTab:AddToggle({
    Title = "绿色闪电水晶 [2.5K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg4 = Value
        if Value then
            task.spawn(egg4)
        end
    end
})

MainTab:AddToggle({
    Title = "雪花水晶[4K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg5 = Value
        if Value then
            task.spawn(egg5)
        end
    end
})

MainTab:AddToggle({
    Title = "熔岩水晶[8K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg6 = Value
        if Value then
            task.spawn(egg6)
        end
    end
})

MainTab:AddToggle({
    Title = "闪电水晶 [8K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg7 = Value
        if Value then
            task.spawn(egg7)
        end
    end
})

MainTab:AddToggle({
    Title = "沙漠水晶 [40K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg8 = Value
        if Value then
            task.spawn(egg8)
        end
    end
})

MainTab:AddToggle({
    Title = "电光水晶[50K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg9 = Value
        if Value then
            task.spawn(egg9)
        end
    end
})

MainTab:AddToggle({
    Title = "电光传奇水晶 [100K宝石]",
    Default = false,
    Callback = function(Value)
        getgenv().egg10 = Value
        if Value then
            task.spawn(egg10)
        end
    end
})

local MainTab = Window:MakeTab({"传送类", "cool"})

MainTab:AddButton({
    Title = "传送到城市",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2002.0133056640625, 1.2624330520629883, 985.2265625)
    end
})

MainTab:AddButton({
    Title = "传送到雪城",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9675.25, 59.63568115234375, 3783.50146484375)
    end
})

MainTab:AddButton({
    Title = "传送到火山",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11052.4189453125, 217.59571838378906, 4898.76416015625)
    end
})

MainTab:AddButton({
    Title = "传送到公路",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13095.255859375, 217.59567260742188, 5905.240234375)
    end
})
