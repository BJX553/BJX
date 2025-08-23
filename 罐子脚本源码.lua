local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu/FengYu/refs/heads/main/要出来了🥵", true))()
----------------------------------------------------------------------------------------------------------------------------------------
local window = library:new("殺脚本")--V8
----------------------------------------------------------------------------------------------------------------------------------------

local creds = window:Tab("关于", "6031097229")
    local bin = creds:section("信息", true)
    
    bin:Label("作者：风御")     

    local credits = creds:section("Ul设置", true)

credits:Toggle("脚本框架变小一点", "", false, function(state)
        if state then
        game:GetService("CoreGui")["frosty"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty"].Main.Style = "Custom"
        end
    end)
    
        credits:Button("扔出去",function()
            game:GetService("CoreGui")["frosty"]:Destroy()
    end)

local creds = window:Tab("通用",'6031097229')

local credits = creds:section("其他",true)
    credits:Textbox("快速跑步(推荐调2)", "tpwalking", "输入", function(king)
local tspeed = king
local hb = game:GetService("RunService").Heartbeat
local tpwalking = true
local player = game:GetService("Players")
local lplr = player.LocalPlayer
local chr = lplr.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
while tpwalking and hb:Wait() and chr and hum and hum.Parent do
  if hum.MoveDirection.Magnitude > 0 then
    if tspeed then
      chr:TranslateBy(hum.MoveDirection * tonumber(tspeed))
    else
      chr:TranslateBy(hum.MoveDirection)
    end
  end
end
end)
    
    credits:Slider('修改跳跃', 'JumpPowerSlider', 50, 50, 99999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)
    
    credits:Slider('修改重力', 'GravitySlider', 198, 198, 99999,false,function(Value)
    game.Workspace.Gravity = Value
end)
    
credits:Textbox("重力设置", "Gravity", "输入", function(Gravity)
  spawn(function() while task.wait() do game.Workspace.Gravity = Gravity end end)
end)
    
    credits:Slider('修改高度', 'Slider', 1, 1, 9999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
end)
    
    credits:Slider('相机焦距上限', 'ZOOOOOM OUT!',  128, 128, 200000,false, function(Value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = Value
end)
    
    credits:Slider('相机焦距【正常为70】', 'Sliderflag', 70, 0.1, 250, false, function(v)
        game.Workspace.CurrentCamera.FieldOfView = v
end)
    
    credits:Slider('健康值上限', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = Value
end)
    
    credits:Slider('玩家健康值', 'Sliderflag',  120, 120, 999999,false, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.Health = Value
end)
 
local credits = creds:section("通用脚本",true)
    
    credits:Toggle("Circle ESP", "ESP", false, function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end)
    
credits:Toggle("穿墙", "NoClip", false, function(NC)
  local Workspace = game:GetService("Workspace") local Players = game:GetService("Players") if NC then Clipon = true else Clipon = false end Stepped = game:GetService("RunService").Stepped:Connect(function() if not Clipon == false then for a, b in pairs(Workspace:GetChildren()) do if b.Name == Players.LocalPlayer.Name then for i, v in pairs(Workspace[Players.LocalPlayer.Name]:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end end else Stepped:Disconnect() end end)
    end)
    
credits:Toggle("自动互动", "Auto Interact", false, function(state)
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25) -- Adjust the wait time as needed
            end
        else
            autoInteract = false
        end
    end)
    
credits:Toggle("夜视脚本", "", false, function(state)
        if state then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end)
    
credits:Button("控制npc",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
end)
 
    credits:Button(
        "自杀脚本",
        function()
            game.Players.LocalPlayer.Character.Humanoid.Health=0
HumanDied = true
        end
    )    
    
credits:Button("翻跟斗",function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-super-awesome-backflip-31143"))()
end)
    
credits:Button("殺飞行",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FengY4/FengY4/refs/heads/main/%E6%AE%BA%E9%A3%9E%E8%A1%8C.lua"))()
end)
    
credits:Button("透视",function()  
    _G.FriendColor = Color3.fromRGB(0, 0, 255)
        local function ApplyESP(v)
       if v.Character and v.Character:FindFirstChildOfClass'Humanoid' then
           v.Character.Humanoid.NameDisplayDistance = 9e9
           v.Character.Humanoid.NameOcclusion = "NoOcclusion"
           v.Character.Humanoid.HealthDisplayDistance = 9e9
           v.Character.Humanoid.HealthDisplayType = "AlwaysOn"
           v.Character.Humanoid.Health = v.Character.Humanoid.Health -- triggers changed
       end
    end
    for i,v in pairs(game.Players:GetPlayers()) do
       ApplyESP(v)
       v.CharacterAdded:Connect(function()
           task.wait(0.33)
           ApplyESP(v)
       end)
    end
    
    game.Players.PlayerAdded:Connect(function(v)
       ApplyESP(v)
       v.CharacterAdded:Connect(function()
           task.wait(0.33)
           ApplyESP(v)
       end)
    end)
    
        local Players = game:GetService("Players"):GetChildren()
    local RunService = game:GetService("RunService")
    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    
    for i, v in pairs(Players) do
        repeat wait() until v.Character
        if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = v.Character
            highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlightClone.Name = "Highlight"
        end
    end
    
    game.Players.PlayerAdded:Connect(function(player)
        repeat wait() until player.Character
        if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
            local highlightClone = highlight:Clone()
            highlightClone.Adornee = player.Character
            highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
            highlightClone.Name = "Highlight"
        end
    end)
    
    game.Players.PlayerRemoving:Connect(function(playerRemoved)
        playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destroy()
    end)
    
    RunService.Heartbeat:Connect(function()
        for i, v in pairs(Players) do
            repeat wait() until v.Character
            if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = v.Character
                highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
                task.wait()
            end
    end
    end)
end)
    
credits:Button("获取念力工具",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/dbcy7SHF"))()
end)

credits:Button("聊天画画",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ocfi/_/refs/heads/main/a"))()
end)
    
credits:Button(
        "动态模糊",
        function()
            local camera = workspace.CurrentCamera
local blurAmount = 10
local blurAmplifier = 5
local lastVector = camera.CFrame.LookVector

local motionBlur = Instance.new("BlurEffect", camera)

local runService = game:GetService("RunService")

workspace.Changed:Connect(function(property)
 if property == "CurrentCamera" then
  print("Changed")
  local camera = workspace.CurrentCamera
  if motionBlur and motionBlur.Parent then
   motionBlur.Parent = camera
  else
   motionBlur = Instance.new("BlurEffect", camera)
  end
 end
end)

runService.Heartbeat:Connect(function()
 if not motionBlur or motionBlur.Parent == nil then
  motionBlur = Instance.new("BlurEffect", camera)
 end
 
 local magnitude = (camera.CFrame.LookVector - lastVector).magnitude
 motionBlur.Size = math.abs(magnitude)*blurAmount*blurAmplifier/2
 lastVector = camera.CFrame.LookVector
end)
        end
    )
    
credits:Button("无限跳",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
end)
    
credits:Button(
        "指令脚本",
        function()
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
        end
    )
    
credits:Button("玩家加入游戏提示",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)
    
credits:Button("fps显示",function()
loadstring(game:HttpGet("https://pastefy.app/d9j82YJr/raw",true))()
end)

credits:Button("偷物品",function()
    for i,v in pairs (game.Players:GetChildren()) do
wait()
for i,b in pairs (v.Backpack:GetChildren()) do
b.Parent = game.Players.LocalPlayer.Backpack
end
end
end)
    
credits:Button("死亡笔记",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)
    
credits:Button("飞檐走壁",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)
    
credits:Button("踏空行走",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)
    
local credits = creds:section("恶搞",true)
   
    credits:Button(
        "直升机",
        function()
            if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
spawn(function()
local speaker = game.Players.LocalPlayer
local Anim = Instance.new("Animation")
     Anim.AnimationId = "rbxassetid://27432686"
     local bruh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
bruh:Play()
bruh:AdjustSpeed(0)
speaker.Character.Animate.Disabled = true
local hi = Instance.new("Sound")
hi.Name = "Sound"
hi.SoundId = "http://www.roblox.com/asset/?id=165113352"
hi.Volume = 2
hi.Looped = true
hi.archivable = false
hi.Parent = game.Workspace
hi:Play()

local spinSpeed = 40
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)

end)
else
spawn(function()
local speaker = game.Players.LocalPlayer
local Anim = Instance.new("Animation")
     Anim.AnimationId = "rbxassetid://507776043"
     local bruh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
bruh:Play()
bruh:AdjustSpeed(0)
speaker.Character.Animate.Disabled = true
local hi = Instance.new("Sound")
hi.Name = "Sound"
hi.SoundId = "http://www.roblox.com/asset/?id=165113352"
hi.Volume = 2
hi.Looped = true
hi.archivable = false
hi.Parent = game.Workspace
hi:Play()

local spinSpeed = 40
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)


end)    
end
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local u = game.Players.LocalPlayer
local urchar = u.Character

task.spawn(function()


qUp = Mouse.KeyUp:Connect(function(KEY)
if KEY == 'q' then
urchar.Humanoid.HipHeight = urchar.Humanoid.HipHeight - 3
end
end)
eUp = Mouse.KeyUp:Connect(function(KEY)
if KEY == 'e' then
urchar.Humanoid.HipHeight = urchar.Humanoid.HipHeight + 3
end
end)


end)
        end
    )    
    
credits:Button("撸管r6",function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)
    
credits:Button("撸管r15",function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)
    
credits:Button("演都不演了",function()
    local IMAGE_ID = "rbxassetid://73542239032835"
local IMAGE_RES = UDim2.fromOffset(200, 200)
local MOVE_SPEED = 250

----------------------------------------------------------

local DirX, DirY = 1, 1

local function CreateWithProperties(ClassName, Properties)
	local Object = Instance.new(ClassName)
	for Name, Value in Properties do
		Object[Name] = Value
	end
	return Object
end

local UI = CreateWithProperties("ScreenGui", {
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999,
	Parent = game.CoreGui
})

local Image: ImageLabel = CreateWithProperties("ImageLabel", {
	Size = IMAGE_RES,
	BorderSizePixel = 0,
	BackgroundTransparency = 1,
	Image = IMAGE_ID,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Parent = UI
})

local function GetDirection(Axis)
	return Image.Position[Axis].Offset + Image.Size[Axis].Offset / 2 > workspace.CurrentCamera.ViewportSize[Axis] and -1
		or Image.Position[Axis].Offset - Image.Size[Axis].Offset / 2 < 0 and 1
end --W function?

game:GetService("RunService").Heartbeat:Connect(function(Delta)
	DirX = GetDirection("X") or DirX
	DirY = GetDirection("Y") or DirY
	
	local MoveAmount = MOVE_SPEED * Delta
	Image.Position += UDim2.fromOffset(MoveAmount * DirX, MoveAmount * DirY)
end)
end)
  
local creds = window:Tab("FE『能用』",'7733765398')

local credits = creds:section("功能",true)
    credits:Button("C00lgui",function()
    loadstring(game:GetObjects("rbxassetid://8127297852")[1].Source)()
end)
 
    credits:Button("FE传送",function()
    mouse = game.Players.LocalPlayer:GetMouse() tool = Instance.new("Tool") tool.RequiresHandle = false tool.Name = "[FE] TELEPORT TOOL" tool.Activated:connect(function() local pos = mouse.Hit+Vector3.new(0,2.5,0) pos = CFrame.new(pos.X,pos.Y,pos.Z) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end) tool.Parent = game.Players.LocalPlayer.Backpack
end)
    
    credits:Button("手枪『只是模型』",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Er5cfTr3"))()
end)
   
credits:Button("变天使",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/RaXbiByH"))()
end)
 
local creds = window:Tab("甩飞",'6031097229')

local credits = creds:section("甩飞功能",true)

credits:Button("旋转甩飞",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
end)
    
credits:Button("碰到就飞",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
end)
    
credits:Button("甩飞所有人",function()
loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)
   
credits:Button("铁拳",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)
    
credits:Button("输入名字起飞",function()
loadstring(game:HttpGet(('https://pastefy.app/9SmQXduA/raw'),true))()
end)
    
local creds = window:Tab("光影画质",'7733765398')
local credits = creds:section("功能", true)
credits:Button(
        "光影1",
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
        end
    )
   
   credits:Button(
        "光影2",
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
        end
    )
    
credits:Button(
        "光影3",
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
        end
    )

credits:Button(
        "画质光影",
        function()
            loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
        end
    )   
   
   credits:Button(
        "普通光影",
        function()
            loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
        end
    )
    
   credits:Button(
        "深色光影",
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
        end
    )
    
local creds = window:Tab("其他脚本",'6031097229')

local credits = creds:section("推荐脚本",true)

credits:Button("皮脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

credits:Button("叶脚本",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
end)

local creds = window:Tab("音乐",'6031097229')

local credits = creds:section("音乐播放",true)

credits:Button("防空警报", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://792323017"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    
credits:Button("义勇军进行曲", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1845918434"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    
    credits:Button("雨中流浪", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://1683110839393"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    credits:Button("米老鼠", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://8491769438"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    
    credits:Button("骨灰给你扬了", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://7691078503"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    
    credits:Button("齐天大圣", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://8195914641"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    
    credits:Button("卡车鸣笛", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3900067524"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    
    credits:Button("算命先生", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6086894326"
    sound.Parent = game.Workspace
    sound:Play()
    end)
    