local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "你的服务器是凹凸世界",
    Content = "已开启",
    Duration = 5,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local hum = Character.HumanoidRootPart
local PlayerGui = LocalPlayer.PlayerGui

local Window = WindUI:CreateWindow({
    Title = " BJX",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "凹凸世界",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = false
    },
    SideBarWidth = 200,
    -- HideSearchBar = true,
    ScrollBarEnabled = true,
    -- Background = "rbxassetid://13511292247", -- rbxassetid only
})

Window:EditOpenButton({
    Title = "打开脚本",
    Icon = "star",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

MainSection = Window:Section({
    Title = "功能收起",
    Opened = true,
})

Main = MainSection:Tab({ Title = "主要", Icon = "swords" })

local AutoBallFarm = false

Main:Toggle({
    Title = "超快无限刷球",
    Default = false,
    Callback = function(Value)
        AutoBallFarm = Value
        if Value then
            task.spawn(function()
                while AutoBallFarm do
                    local number_1 = 2
                    local table_1 = { [1] = 1, [2] = 1, [3] = 19 }
                    local Target = game:GetService("ReplicatedStorage").Project.RemoteEvent.ControlMessageEvent
                    Target:FireServer(number_1, table_1)
                    wait()
                end
            end)
        end
    end
})

