local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "吃掉世界",
    Content = "已开启",
    Duration = 5,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local hum = Character.HumanoidRootPart
local PlayerGui = LocalPlayer.PlayerGui

local Window = WindUI:CreateWindow({
    Title = "BJX",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "吃掉世界",
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
    Title = "打开UI",
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
    Title = "功能",
    Opened = true,
})

Main = MainSection:Tab({ Title = "自动", Icon = "Sword" })

local main = {
    AutoGrab = false,
    AutoEat = false,
    AutoThrow = false,
    AutoSell = false,
    AutoBox = false,
    AutoTele = false,
    AutoMap = false,
}

Main:Toggle({
    Title = "自动抓",
    Image = "bird",
    Value = main.AutoGrab,
    Callback = function(state)
        main.AutoGrab = state
        spawn(function()
            while main.AutoGrab and task.wait(2) do
                game:GetService("Players").LocalPlayer.Character.Events.Grab:FireServer(false,false,false)
            end
        end)
    end
})
Main:Toggle({
    Title = "自动吃",
    Image = "bird",
    Value = main.AutoEat,
    Callback = function(state)
        main.AutoEat = state
        spawn(function()
        while main.AutoEat and task.wait() do
        game:GetService("Players").LocalPlayer.Character.Events.Eat:FireServer()
        end
      end)
    end
}) 
Main:Toggle({
    Title = "自动扔",
    Image = "bird",
    Value = main.AutoThrow,
    Callback = function(state)
    main.AutoThrow = state
    spawn(function()
    while main.AutoThrow and task.wait() do
    game:GetService("Players").LocalPlayer.Character.Events.Throw:FireServer()
     end
    end)
   end
})
Main:Toggle({
    Title = "自动卖",
    Image = "bird",
    Value = main.AutoSell,
    Callback = function(state)
    main.AutoSell = state
    spawn(function()
    while main.AutoSell and task.wait() do
    game:GetService("Players").LocalPlayer.Character.Events.Sell:FireServer()
     end
    end)
   end
})
Main:Toggle({
     Title = "自动领箱子",
     Image = "bird",
     Value = main.AutoBox,
     Callback = function(state)
     main.AutoBox = state
     spawn(function()
     while main.AutoBox and task.wait() do
     game:GetService("ReplicatedStorage").Events.RewardEvent:FireServer(game:GetService("Players").LocalPlayer.TimedRewards.SmallReward)
       end
      end)
     end
})
