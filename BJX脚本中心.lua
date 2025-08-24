local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() 
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() 
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Revenant", true))()
Library.DefaultColor = Color3.fromRGB(255, 0, 0)

-- 创建播放声音的函数
local function playSound()
    local sound = Instance.new("Sound") 
    sound.SoundId = "rbxassetid://1237557124" 
    sound.Parent = game.Workspace 
    sound:Play()
    
    -- 播放结束后自动销毁
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

wait(0.25)
playSound()

Notification:Notify( 
    {Title = "更新状况:已读取OrionUI库", Description = " Q群~985228498"}, 
    {OutlineColor = Color3.fromRGB(255, 0, 0), Time = 10, Type = "image"}, 
    {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(0, 0, 255)} 
) 

wait(2)
playSound()

Notification:Notify( 
    {Title = "请认准作者:小北", Description = " 作者:小北 \n QQ号:1691710338"}, 
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 10, Type = "image"}, 
    {Image = "http://www.roblox.com/asset/?id=7733747106", ImageColor = Color3.fromRGB(255, 84, 84)} 
)

wait(1.5)
playSound()
Library:Notification({
    Text = "新北极星中心开发者:小北/神青",
    Duration = 6
})

wait(1.5)
playSound()
Library:Notification({
    Text = "Y&F-HUB = 半缝合🥳",
    Duration = 6
})

wait(1.5)
playSound()
Library:Notification({
    Text = "Orion UI提供者:神青☁️",
    Duration = 6
})
---
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/QQ-9-2-8-9-50173/refs/heads/main/Ul%E6%BA%90%E7%A0%81.lua"))()

local Window = redzlib:MakeWindow({
  Title = "北极星脚本中心",
  SubTitle = "BJX",
  SaveFolder = "Redz Config"
})

print("反挂机已开启")
Start = tick()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)

Window:AddMinimizeButton({
  Button = { Image = "rbxassetid://98541457845136", BackgroundTransparency = 0, Size = UDim2.fromOffset(60, 60), },
  Corner = { CornerRadius = UDim.new(0, 10) }
})

local MainTab = Window:MakeTab({"主功能", "cool"})

MainTab:AddButton({
    Title = "飞行",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/%E5%8C%97%E6%9E%81%E6%98%9F%E9%A3%9E%E8%A1%8C.Lua"))()
    end
})

MainTab:AddButton({
    Title = "指令脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

MainTab:AddButton({
    Title = "自瞄加自追『自制』",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/BJX553/BJX/blob/main/%E8%87%AA%E7%9E%84%E8%BF%BD.lua"))()
    end
})

MainTab:AddButton({
    Title = "通用ESP",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP"))()
    end
})

MainTab:AddButton({
    Title = "阿尔宙斯飞行",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/5zJu3hfN"))()
    end
})

MainTab:AddButton({
    Title = "爬墙",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
    end
})

MainTab:AddButton({
    Title = "甩飞",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/dFsFLk3C"))()
    end
})

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

MainTab:AddToggle({
    Title = "夜视模式",  -- 添加一个标题
    Callback = function(state)
        if state then
            game.Lighting.Ambient = Color3.new(1, 1, 1)  -- 开启夜视，设置环境光为白色
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)   -- 关闭夜视，恢复为黑色
        end
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
    Title = "踏空行走",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float"))()
    end
})

MainTab:AddButton({
    Title = "最强透视",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/uw2P2fbY"))()
    end
})

MainTab:AddButton({
    Title = "玩家加入提示",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
    end
})

MainTab:AddButton({
    Title = "死亡笔记",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
    end
})

MainTab:AddButton({
    Title = "电脑键盘",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()
    end
})

MainTab:AddButton({
    Title = "反挂机V1",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
    end
})

MainTab:AddToggle({
    Title = '人物穿墙',
    Default = false,
    Callback = function(Value)
        if Value then
            -- 开启逻辑
            Noclip = true
            Stepped = game:GetService('RunService').Stepped:Connect(function()
                if Noclip and game.Players.LocalPlayer.Character then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            -- 关闭逻辑（三重保障）
            Noclip = false
            if game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            if Stepped then
                Stepped:Disconnect()
                Stepped = nil
            end
        end
    end
})

local MainTab = Window:MakeTab({"『透视』", "cool"})

MainTab:AddButton({
    Title = "透视『较多，未汉化中』",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/Roblox%20ESP.lua"))()
    end
})



local MainTab = Window:MakeTab({"战争大亨", "cool"})

MainTab:AddButton({
    Title = "战争-中文",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8.lua"))()
    end
})

local MainTab = Window:MakeTab({"音乐", "cool"})

MainTab:AddButton({
    Title = "自定义音乐",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/beta/main/music.lua"))()
    end
})

MainTab:AddButton({
    Title = "音乐轰炸",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/%E8%BD%B0%E7%82%B8.lua"))()
    end
})

local MainTab = Window:MakeTab({"娱乐", "cool"})

MainTab:AddButton({
    Title = "灵魂出窍",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ahK5jRxM"))()
    end
})

local MainTab = Window:MakeTab({"注入器", "cool"})

MainTab:AddButton({
    Title = "阿尔宙斯",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E9%98%BF%E5%B0%94%E5%AE%99%E6%96%AFX%20V3.0.lua"))()
    end
})

MainTab:AddButton({
    Title = "fl",
    Callback = function()
        loadstring(game:HttpGet("https://shz.al/wmyndGxRyd8SN4D3iXTAB3NR"))()
    end
})

MainTab:AddButton({
    Title = "忍者",
    Callback = function()
        loadstring(game:HttpGet("https://shz.al/y47yrfmjZNzRKkWnYPsBT7Zt"))()
    end
})

MainTab:AddButton({
    Title = "codex",
    Callback = function()
        loadstring(game:HttpGet("https://shz.al/hCpNTpZ78Tys43N3EzDnd6HE"))()
    end
})

local MainTab = Window:MakeTab({"汽车经销大亨", "cool"})


MainTab:AddButton({
    Title = "刷星星",
    Callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/LIMITED!-Car-Dealership-Tycoon-Moon-Team-16181"))()
    end
})

MainTab:AddButton({
    Title = "1/脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IExpIoit/Script/main/Car%20Dealership%20Tycoon.lua"))()
    end
})

MainTab:AddButton({
    Title = "2/脚本",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/5o594Q0i/raw"))()
    end
})

MainTab:AddButton({
    Title = "3/脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/03sAlt/BlueLockSeason2/main/README.md"))()
    end
})

local MainTab = Window:MakeTab({"伐木大亨二", "cool"})

MainTab:AddButton({
    Title = "北极星伐木脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/%E4%BC%90%E6%9C%A8%E8%84%9A%E6%9C%AC.Lua"))()
    end
})

MainTab:AddButton({
    Title = "灯塔",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1464.8, 356.3, 3257.2)
    end
})

MainTab:AddButton({
    Title = "小鸟斧头",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4813.1, 33.5, -978.8)
    end
})

MainTab:AddButton({
    Title = "合成鲨鱼斧",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(330.259735, 45.7998505, 1943.30823, 0.972010553, -8.07546598e-08, 0.234937176, 7.63610259e-08, 1, 2.77986647e-08, -0.234937176, -9.08055142e-09, 0.972010553)
    end
})

MainTab:AddButton({
    Title = "黄金木洞穴",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1080, -5, -942)
    end
})

MainTab:AddButton({
    Title = "滑雪小屋",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1244, 59, 2290)
    end
})

MainTab:AddButton({
    Title = "小绿盒",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1667, 349, 1474)
    end
})

MainTab:AddButton({
    Title = "怪人",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1071, 16, 1141)
    end
})

MainTab:AddButton({
    Title = "灵视宫殿",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1608, 195, 928)
    end
})

MainTab:AddButton({
    Title = "画廊",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5217, -166, 721)
    end
})

MainTab:AddButton({
    Title = "鲍勃的小店",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(292, 8, -2544)
    end
})

MainTab:AddButton({
    Title = "连锁逻辑店",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4615, 7, -794)
    end
})

MainTab:AddButton({
    Title = "雪山",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1487, 415, 3259)
    end
})

MainTab:AddButton({
    Title = "盒子车行",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(509, 3, -1458)
    end
})

MainTab:AddButton({
    Title = "家具店",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(486, 3, -1722)
    end
})

MainTab:AddButton({
    Title = "沼泽",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1216, 131, -822)
    end
})

MainTab:AddButton({
    Title = "火山",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1588, 623, 1069)
    end
})

MainTab:AddButton({
    Title = "洞穴",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3590, -177, 415)
    end
})

MainTab:AddButton({
    Title = "椰子岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2614, -4, -34)
    end
})

MainTab:AddButton({
    Title = "码头",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1136, 0, -206)
    end
})

MainTab:AddButton({
    Title = "桥",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(112, 37, -892)
    end
})

MainTab:AddButton({
    Title = "土地商店",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 3, -98)
    end
})

MainTab:AddButton({
    Title = "出生点",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(174, 10.5, 66)
    end
})

MainTab:AddButton({
    Title = "木板反斗城",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(270, 4, 60)
    end
})

local MainTab = Window:MakeTab({"俄亥俄州", "cool"})

MainTab:AddButton({
    Title = "俄亥俄州/北极星",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/xk%E4%BF%84%E4%BA%A5%E4%BF%84%E5%B7%9E.lua"))()
    end
})

local MainTab = Window:MakeTab({"doors", "cool"})

MainTab:AddButton({
    Title = "doors脚本/北极星",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/doors.lua"))()
    end
})

MainTab:AddButton({
    Title = "mspoint V3汉化【12月7日】",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuAnZang/XXscript/main/D00R5.txt"))()
    end
})

MainTab:AddButton({
    Title = "旧版NBD00R5无法使用",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/DocYogurt/D00R5/raw/main/Loader.lua"))()
    end
})

MainTab:AddButton({
    Title = "BobHUB",
    Callback = function()
        -- Add functionality here
    end
})

MainTab:AddButton({
    Title = "小云汉化",
    Callback = function()
        loadstring(game:HttpGet("https://www.githubusercontent.com/XiaoYunCN/2EntitySpawner/main/docs(orionlib).lua"))()
    end
})

MainTab:AddButton({
    Title = "变身",
    Callback = function()
        loadstring(game:HttpGet("https://www.githubusercontent.com/2ChronoAccelerator/Public-Scripts/main/Morphing/MorphScript.lua"))()
    end
})

local MainTab = Window:MakeTab({"一路向西", "cool"})

MainTab:AddButton({
    Title = "滚筒",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("Tumbleweed", false)
    end  
})

MainTab:AddButton({
    Title = "岩石溪",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("StoneCreek", false)
    end  
})

MainTab:AddButton({
    Title = "灰色山脊",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("Grayridge", false)
    end  
})

MainTab:AddButton({
    Title = "大矿洞",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("Quarry", false)
    end  
})

MainTab:AddButton({
    Title = "堡垒",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("FortCassidy", true)
    end  
})

MainTab:AddButton({
    Title = "阿瑟堡",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("FortArthur", true)
    end  
})

MainTab:AddButton({
    Title = "红色岩石营地",  
    Callback = function()  
        game:GetService("ReplicatedStorage").GeneralEvents.Spawn:FireServer("RedRocks", true)
    end  
})

local MainTab = Window:MakeTab({"格林威尔", "cool"})

MainTab:AddToggle({
    Title = "触碰地面",
    Default = false,
    Callback = function(value)
        TouchTheRoad = value
    end
})

MainTab:AddToggle({
    Title = "自动驾驶",
    Default = false,
    Callback = function(value)
        AutoForm = value
        if value and not AutoFormRunning then
            coroutine.resume(AutoFormFunc)
        end
    end
})

local MainTab = Window:MakeTab({"法宝模拟器", "cool"})

MainTab:AddButton({
    Title = "1=法宝",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Bd6R0GaC"))()
    end
})

MainTab:AddButton({
    Title = "2=法宝",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FreeRobloxScripts/anime-fighting/main/simulator"))()
    end
})

local MainTab = Window:MakeTab({"最坚强战场", "cool"})

MainTab:AddButton({
    Title = "SkibidCen",
    Callbock = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiCen/MainMenu/main/Code"))()
    end
})

MainTab:AddButton({
    Title = "Loader",
    Callbock = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VortexScripts/Project-Vortex-V9/main/Loader"))()
    end
})

MainTab:AddButton({
    Title = "TSBANIMS",
    Callbock = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/Mautiku/TSB-anim/main/TSBANIMS'), true))()
    end
})

local MainTab = Window:MakeTab({"僵尸起义", "cool"})

MainTab:AddButton({
    Title = "1/僵尸起义",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Unknownproooolucky/Unknown-Hub-X-Universal-Games/main/Games/Zombie-Uprising"))()
    end
})

local MainTab = Window:MakeTab({"监狱人生", "cool"})

MainTab:AddButton({
    Title = "单车",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zLe3e4BS"))()
    end    
})

MainTab:AddButton({
    Title = "kill全部人",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/kXjfpFPh"))()
    end    
})

MainTab:AddButton({
    Title = "变身死神",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/ewv9bbRp"))()
    end    
})

MainTab:AddButton({
    Title = "变身警察",
    Callback = function()
        workspace.Remote.TeamEvent:FireServer("Bright blue")
    end    
})

MainTab:AddButton({
    Title = "变身囚犯",
    Callback = function()
        workspace.Remote.TeamEvent:FireServer("Bright orange")
    end    
})

MainTab:AddButton({
    Title = "钢筋",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/7prijqYH"))()
    end    
})

MainTab:AddButton({
    Title = "手里剑",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/mSLiAZHk"))()
    end    
})

MainTab:AddButton({
    Title = "无敌",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/LdTVujTA"))()
    end    
})

MainTab:AddButton({
    Title = "食堂传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(921.0059204101562, 99.98993682861328, 2289.23095703125)
    end    
})

MainTab:AddButton({
    Title = "下水道传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.4256591796875, 78.69828033447266, 2416.18359375)
    end    
})

MainTab:AddButton({
    Title = "警车库传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(602.7301635742188, 98.20000457763672, 2503.56982421875)
    end    
})

MainTab:AddButton({
    Title = "院子传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(788.5759887695312, 97.99992370605469, 2455.056640625)
    end    
})

MainTab:AddButton({
    Title = "犯罪复活点传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-937.5891723632812, 93.09876251220703, 2063.031982421875)
    end    
})

MainTab:AddButton({
    Title = "监狱外面传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(760.6033325195312, 96.96992492675781, 2475.405029296875)
    end    
})

MainTab:AddButton({
    Title = "监狱内传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.2575073242188, 98.95999908447266, 2379.74169921875)
    end    
})

MainTab:AddButton({
    Title = "警卫室传送",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(847.7261352539062, 98.95999908447266, 2267.387451171875)
    end    
})

local MainTab = Window:MakeTab({"极速传奇", "cool"})

MainTab:AddButton({
    Title = "极速传奇-北极星",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E6%9E%81%E9%80%9F%E4%BC%A0%E5%A5%87.lua"))()
    end
})

local MainTab = Window:MakeTab({"忍者传奇", "cool"})

MainTab:AddButton({
    Title = "北极星忍者传奇",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/%F0%9F%87%A9%F0%9F%87%AA%E5%BF%8D%E8%80%85%E4%BC%A0%E5%A5%87%E8%84%9A%E6%9C%AC%F0%9F%87%A9%F0%9F%87%AA.Lua"))()
    end
})

local MainTab = Window:MakeTab({"破坏者谜团", "cool"})

MainTab:AddButton({
    Title = "透视身份",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Ihaveash0rtnamefordiscord/Releases/main/MurderMystery2HighlightESP"))()
    end
})

local MainTab = Window:MakeTab({"背上只因剑", "cool"})

MainTab:AddButton({
    Title = "脚本一",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/blox-hub-roblox/021bad62bbc6a0adc4ba4e625f9ad7df/raw/c89af6e1acf587d09e4ce4bc7510e7100e0c0065/swordWarrior.lua"))()
    end
})

local MainTab = Window:MakeTab({"自然灾害", "cool"})

MainTab:AddButton({
    Title = "指令",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/LoadstringUjHI6RQpz2o8"))()
    end
})

MainTab:AddButton({
    Title = "自然灾害~外网传",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/LoadstringUjHI6RQpz2o8"))()
    end
})

local MainTab = Window:MakeTab({"兵工厂", "cool"})

MainTab:AddButton({
    Title = "子弹追踪",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))()
    end
})

local MainTab = Window:MakeTab({"吃掉世界", "cool"})

MainTab:AddButton({
    Title = "吃掉世界-功能较全",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%90%83%E6%8E%89%E4%B8%96%E7%95%8C.lua"))()
    end
})

local MainTab = Window:MakeTab({"打屁股之战👋", "cool"})

MainTab:AddButton({
    Title = "巴掌",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%B7%B4%E6%8E%8C.lua"))()
    end
})

local MainTab = Window:MakeTab({"凹凸世界", "cool"})

MainTab:AddButton({
    Title = "世界",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%87%B9%E5%87%B8%E4%B8%96%E7%95%8C.lua"))()
    end
})

local MainTab = Window:MakeTab({"在超市生活一周", "cool"})

MainTab:AddButton({
    Title = "在超市生活一周~功能全",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%9C%A8%E8%B6%85%E5%B8%82%E7%94%9F%E6%B4%BB%E4%B8%80%E5%91%A8.lua"))()
    end
})

local MainTab = Window:MakeTab({"种植花园", "cool"})

MainTab:AddButton({
    Title = "功能一",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E8%8A%B1%E5%9B%AD.lua"))()
    end
})

local MainTab = Window:MakeTab({"元素力量大亨", "cool"})

MainTab:AddButton({
    Title = "功能一~中文功能较全",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%85%83%E7%B4%A0%E5%8A%9B%E9%87%8F%E5%A4%A7%E4%BA%A8.lua"))()
    end
})

local MainTab = Window:MakeTab({"『森林99天』", "cool"})

MainTab:AddButton({
    Title = "森林99~汉化",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/99night.lua"))()
    end
})

local MainTab = Window:MakeTab({"『制作一架飞机』", "cool"})

MainTab:AddButton({
    Title = "制作一架飞机~汉化功能较少",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BJX553/BJX/refs/heads/main/%E5%BB%BA%E9%80%A0%E4%B8%80%E9%A9%BE%E9%A3%9E%E6%9C%BA.lua"))()
    end
})

local MainTab = Window:MakeTab({"墨水游戏", "cool"})

MainTab:AddButton({
    Title = "墨水游戏~已汉化",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XOTRXONY/INKGAME/main/INKGAMEE.lua"))()
    end
})

MainTab:AddButton({
    Title = "墨水游戏~反作弊",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TuffGuys/TuffGuys/refs/heads/main/Loader"))()
    end
})