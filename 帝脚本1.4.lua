local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Popup({
    Title = "欢迎使用EM_HUB",
    Icon = "sparkles",
    Content = "欢迎使用帝脚本！",
    Buttons = {
        {
            Title = "进入脚本",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() 
                print("进入脚本")
                -- 主窗口
                createMainWindow()
            end
        }
    }
})

function createMainWindow()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = Character:WaitForChild("HumanoidRootPart")
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local Window = WindUI:CreateWindow({
        Title = "EM_HUB<font color='#00FF00'>1.4</font>",
        Icon = "rbxassetid://4483362748",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者:小北",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Light",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://131066281260487"
    })
    
    local TimeTag = Window:Tag({
        Title = "00:00",
        Color = Color3.fromHex("#30ff6a")
    })
    
    local hue = 0
    task.spawn(function()
        while true do
            local now = os.date("*t")
            local hours = string.format("%02d", now.hour)
            local minutes = string.format("%02d", now.min)
            
            hue = (hue + 0.01) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            
            TimeTag:SetTitle(hours .. ":" .. minutes)
            --TimeTag:SetColor(color)

            task.wait(0.06)
        end
    end)
    
    Window:Tag({
        Title = "v1.4",
        Color = Color3.fromHex("#30ff6a")
    })

    Window:EditOpenButton({
        Title = "帝脚本中心",
        Icon = "crown",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 2,
        Color = ColorSequence.new(
            Color3.fromHex("FF0F7B"), 
            Color3.fromHex("F89B29")
        ),
        Draggable = true,
    })
    
    Window:EditOpenButton({
        StrokeColor = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),     -- 红色
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)), -- 橙色
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)), -- 黄色
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),   -- 绿色
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),   -- 蓝色
            ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))    -- 紫色
        }),
        StrokeThickness = 3,  
    })
    
    local MainTab = Window:Tab({
        Title = "主页",
        Icon = "zap",
        Locked = false,
    })
    
    MainTab:Paragraph({
        Title = "欢迎使用EM_HUB",
        Desc = "QQ群:1060123066",
        Image = "rbxassetid://128052899764125",
        ImageSize = 42,
        Thumbnail = "rbxassetid://98991054648205",
        ThumbnailSize = 120
    })
    
    MainTab:Paragraph({
        Title = "感谢牢汤.WM.风之子.的支持",
        Desc = "当前服务器ID: " .. game.PlaceId, 
    })
    
    local executorName = "未知"
    if type(identifyexecutor) == "function" then
        executorName = identifyexecutor() or "未知"
    end
    
    MainTab:Paragraph({
        Title = "您的注入器",
        Desc = ": " .. executorName, 
    })
    
    local GeneralTab = Window:Tab({
        Title = "通用",
        Icon = "zap",
        Locked = false,
    })
    
    GeneralTab:Slider({
        Title = "移速",
        Value = {
            Min = 16,
            Max = 400,
            Default = 16,
        },
        Increment = 1,
        Callback = function(value)
            if game.Players.LocalPlayer.Character then
                local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = value
                end
            end
        end
    })

    GeneralTab:Slider({
        Title = "跳跃",
        Value = {
            Min = 50,
            Max = 200,
            Default = 50,
        },
        Increment = 1,
        Callback = function(value)
            if game.Players.LocalPlayer.Character then
                local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = value
                end
            end
        end
    })

    GeneralTab:Slider({
        Title = "重力",
        Value = {
            Min = 0.1,
            Max = 500.0,
            Default = 196.2,
        },
        Step = 0.1,
        Callback = function(value)
            game.Workspace.Gravity = value
        end
    })

    local originalAmbient
    GeneralTab:Toggle({
        Title = "夜视",
        Value = false,
        Callback = function(state)
            if state then
                originalAmbient = game.Lighting.Ambient
                game.Lighting.Ambient = Color3.new(1, 1, 1)  
            else
                game.Lighting.Ambient = originalAmbient or Color3.new(0, 0, 0)
            end
        end
    })

    local Noclip = false
    local NoclipConnection
    GeneralTab:Toggle({
        Title = "穿墙",
        Value = false,
        Callback = function(state)
            if state then
                Noclip = true
                if NoclipConnection then
                    NoclipConnection:Disconnect()
                end
                NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
                    if Noclip and game.Players.LocalPlayer.Character then
                        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                Noclip = false
                if NoclipConnection then
                    NoclipConnection:Disconnect()
                    NoclipConnection = nil
                end
            end
        end
    })

    GeneralTab:Button({
        Title = "点击传送工具",
        Callback = function()
            local mouse = game.Players.LocalPlayer:GetMouse() 
            local tool = Instance.new("Tool") 
            tool.RequiresHandle = false 
            tool.Name = "点击传送" 
            tool.Activated:Connect(function() 
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
                end
            end) 
            tool.Parent = game.Players.LocalPlayer.Backpack
        end
    })

    GeneralTab:Button({
        Title = "肘击",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt', true))()
        end
    })

    GeneralTab:Button({
        Title = "无敌少侠飞行",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()
        end
    })

    GeneralTab:Button({
        Title = "egor假延迟",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/GBmWn4eZ", true))()
        end
    })

    GeneralTab:Button({
        Title = "玩家实时数据",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%AE%9E%E6%97%B6%E6%95%B0%E6%8D%AE.txt", true))()
        end
    })

    GeneralTab:Button({
        Title = "飞行v3",
        Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay907692/Jay/8b94c47bd5969608438fa1ee57f34b1350789caa/飞行脚本", true))()
        end
    })

