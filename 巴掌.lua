
local autoAttackEnabled = false
local attackDelay = 1

local function AttackAllPlayers()
    if not autoAttackEnabled then return end
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Torso") then
            game:GetService("ReplicatedStorage").b:FireServer(player.Character.Torso)
        end
    end
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "巴掌模拟器",
    Content = "已开启",
    Duration = 5,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local hum = Character.HumanoidRootPart
local PlayerGui = LocalPlayer.PlayerGui

local Window = WindUI:CreateWindow({
    Title = "北极星脚本",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "巴掌模拟器",
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
    ScrollBarEnabled = true,
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
    Title = "功能",
    Opened = true,
})

Main = MainSection:Tab({ Title = "主", Icon = "Sword" })

Main:Button({
    Title = "获取全部徽章手套",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CelerityRBLX/Roblox/refs/heads/main/Slap%20Battles/Obtain%20All%20Badge%20Gloves.lua"))()
    end
})

Main:Toggle({
    Title = "自动攻击",
    Value = false,
    Callback = function(value)
        autoAttackEnabled = value
        if value then
            spawn(function()
                while autoAttackEnabled do
                    AttackAllPlayers()
                    task.wait(attackDelay)
                end
            end)
        end
    end
})