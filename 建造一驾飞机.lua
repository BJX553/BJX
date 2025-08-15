local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 自己改
local Window = Rayfield:CreateWindow({
    Name = "建造一架飞机",
    LoadingTitle = "正在加载 建造一架飞机",
    LoadingSubtitle = "由 AlexPT 提供",
    ShowText = "按 K 键显示/隐藏界面",
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.K,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "ScriptsRBXComSettings"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("主菜单", "server")
MainTab:CreateSection("主要功能")

-- 默认发射距离
local launchDistance = 20000

-- 自定义发射距离输入框
MainTab:CreateInput({
    Name = "发射距离",
    PlaceholderText = "输入数字 (例如 2000)",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        local num = tonumber(input)
        if num then
            launchDistance = num
        else
            Rayfield:Notify({
                Title = "输入无效",
                Content = "请输入有效的数字",
                Duration = 4,
                Image = "alert-triangle"
            })
        end
    end,
})

-- 发射的按钮
MainTab:CreateButton({
    Name = "按设定距离发射",
    Callback = function()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local player = Players.LocalPlayer

        local launchRemote = ReplicatedStorage
            :WaitForChild('Remotes')
            :WaitForChild('LaunchEvents')
            :WaitForChild('Launch')
        launchRemote:FireServer()
        task.wait(2)

        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass('Humanoid')
        local seat = humanoid and humanoid.SeatPart

        if seat then
            local forwardVector = seat.CFrame.LookVector
            local targetCFrame = seat.CFrame + forwardVector * launchDistance

            seat.CFrame = targetCFrame

            local rootPart = character.PrimaryPart or character:FindFirstChild('HumanoidRootPart')
            if rootPart then
                character:SetPrimaryPartCFrame(targetCFrame)
            end
        end
    end,
})

-- 重新加入游戏
MainTab:CreateButton({
    Name = "重新加入游戏",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        TeleportService:Teleport(game.PlaceId, player)
    end,
})