local Plrs = game:GetService("Players") -- 玩家服务
local Run = game:GetService("RunService") -- 运行服务
local CoreGui = game:GetService("CoreGui") -- 核心GUI
local StartGui = game:GetService("StarterGui") -- 初始GUI
local Teams = game:GetService("Teams") -- 队伍服务
local UserInput = game:GetService("UserInputService") -- 用户输入服务
local Light = game:GetService("Lighting") -- 光照服务
local HTTP = game:GetService("HttpService") -- HTTP服务
local RepStor = game:GetService("ReplicatedStorage") -- 复制存储

-- 获取相机函数（防止某些游戏重命名玩家相机）
function GetCamera()
    return workspace:FindFirstChildOfClass("Camera")
end

-- 创建ESP和Chams的文件夹
local ChamsFolder = Instance.new("Folder", CoreGui)
ChamsFolder.Name = "Chams"
local PlayerChams = Instance.new("Folder", ChamsFolder)
PlayerChams.Name = "PlayerChams"
local ItemChams = Instance.new("Folder", ChamsFolder)
ItemChams.Name = "ItemChams"

local ESPFolder = Instance.new("Folder", CoreGui)
ESPFolder.Name = "ESP Stuff"
local PlayerESP = Instance.new("Folder", ESPFolder)
PlayerESP.Name = "PlayerESP"
local ItemESP = Instance.new("Folder", ESPFolder)
ItemESP.Name = "ItemESP"

-- 本地玩家信息
local MyPlr = Plrs.LocalPlayer
local MyChar = MyPlr.Character
local MyMouse = MyPlr:GetMouse()
local MyCam = GetCamera()
if MyCam == nil then
    error("无法找到相机！")
    return
end

-- 追踪线设置
local Tracers = Instance.new("Folder", MyCam)
Tracers.Name = "Tracers"
local TracerData = { }
local TracerMT = setmetatable(TracerData, {
    __newindex = function(tab, index, val)
        rawset(tab, index, val)
    end
})

-- 移除字符串中的空格
function RemoveSpacesFromString(Str)
    local newstr = ""
    for i = 1, #Str do
        if Str:sub(i, i) ~= " " then
            newstr = newstr .. Str:sub(i, i)
        end
    end
    return newstr
end

-- 克隆表格
function CloneTable(T)
    local temp = { }
    for i,v in next, T do
        if type(v) == "table" then
            temp[i] = CloneTable(v)
        else
            temp[i] = v 
        end
    end
    return temp
end

-- 主要设置
local Bullshit = {
    ESPEnabled = false, -- ESP开关
    CHAMSEnabled = false, -- 透视开关
    TracersEnabled = false, -- 追踪线开关
    DebugInfo = false, -- 调试信息开关
    OutlinesEnabled = false, -- 轮廓开关
    FullbrightEnabled = false, -- 全亮开关
    CrosshairEnabled = false, -- 准星开关
    AimbotEnabled = false, -- 自瞄开关
    Aimbot = false, -- 自瞄状态
    TracersLength = 500, -- 追踪线最大长度(不要超过2048)
    ESPLength = 10000, -- ESP显示距离
    CHAMSLength = 500, -- 透视显示距离
    PlaceTracersUnderCharacter = false, -- 追踪线是否在角色下方
    FreeForAll = false, -- 混战模式(无队伍的游戏)
    AutoFire = false, -- 自动开火
    MobChams = false, -- NPC透视
    MobESP = false, -- NPC ESP
    AimbotKey = "Enum.UserInputType.MouseButton2", -- 自瞄按键(暂未使用)
    Colors = {
        Enemy = Color3.new(1, 0, 0), -- 敌人颜色(红)
        Ally = Color3.new(0, 1, 0), -- 队友颜色(绿)
        Friend = Color3.new(1, 1, 0), -- 朋友颜色(黄)
        Neutral = Color3.new(1, 1, 1), -- 中立颜色(白)
        Crosshair = Color3.new(1, 0, 0), -- 准星颜色
        ColorOverride = nil, -- 颜色覆盖(所有玩家使用相同颜色)
    },

    -- 以下内容请勿修改
    ClosestEnemy = nil, -- 最近的敌人
    CharAddedEvent = { }, -- 角色添加事件
    OutlinedParts = { }, -- 轮廓部分
    WorkspaceChildAddedEvent = nil, -- 工作区子项添加事件
    LightingEvent = nil, -- 光照事件
    AmbientBackup = Light.Ambient, -- 环境光备份
    ColorShiftBotBackup = Light.ColorShift_Bottom, -- 底部颜色偏移备份
    ColorShiftTopBackup = Light.ColorShift_Top, -- 顶部颜色偏移备份
    FPSAverage = { }, -- FPS平均值
    Blacklist = { }, -- 黑名单
    FriendList = { }, -- 好友列表
    CameraModeBackup = MyPlr.CameraMode, -- 相机模式备份
    GameSpecificCrap = { }, -- 游戏特定设置
    Mob_ESP_CHAMS_Ran_Once = false, -- NPC ESP/Chams是否运行过一次
}

-- 保存设置
function SaveBullshitSettings()
    local temp = { }
    local succ, out = pcall(function()
        temp.TracersLength = Bullshit.TracersLength
        temp.ESPLength = Bullshit.ESPLength
        temp.CHAMSLength = Bullshit.CHAMSLength
        temp.PlaceTracersUnderCharacter = Bullshit.PlaceTracersUnderCharacter
        temp.FreeForAll = Bullshit.FreeForAll
        temp.AutoFire = Bullshit.AutoFire
        temp.AimbotKey = tostring(Bullshit.AimbotKey)
        temp.MobChams = Bullshit.MobChams
        temp.MobESP = Bullshit.MobESP
        temp.Colors = { }
        for i, v in next, Bullshit.Colors do
            temp.Colors[i] = tostring(v)
        end
        writefile("ProjectBullshit.txt", HTTP:JSONEncode(temp))
    end)
    if not succ then
        error(out)
    end
end

-- 加载设置
fuck = pcall(function()
    local temp = HTTP:JSONDecode(readfile("ProjectBullshit.txt"))
    if temp.MobChams ~= nil and temp.MobESP ~= nil then
        for i, v in next, temp do
            if i ~= "Colors" then
                Bullshit[i] = v
            end
        end
        for i, v in next, temp.Colors do
            local r, g, b = string.match(RemoveSpacesFromString(v), "(%d+),(%d+),(%d+)")
            r = tonumber(r)
            g = tonumber(g)
            b = tonumber(b)

            temp.Colors[i] = Color3.new(r, g, b)
        end
        Bullshit.Colors = temp.Colors
    else
        spawn(function()
            SaveBullshitSettings()
            local hint = Instance.new("Hint", CoreGui)
            hint.Text = "重大更新需要重置您的设置！抱歉！"
            wait(5)
            hint:Destroy()
        end)
    end

    Bullshit.AutoFire = false
end)

-- 加载黑名单
fuck2 = pcall(function()
    Bullshit.Blacklist = HTTP:JSONDecode(readfile("Blacklist.txt"))
end)

-- 加载好友列表
fuck3 = pcall(function()
    Bullshit.FriendList = HTTP:JSONDecode(readfile("Whitelist.txt"))
end)

-- 调试菜单
local DebugMenu = { }
DebugMenu["SC"] = Instance.new("ScreenGui", CoreGui)
DebugMenu["SC"].Name = "Debug"
DebugMenu["Main"] = Instance.new("Frame", DebugMenu["SC"])
DebugMenu["Main"].Name = "Debug Menu"
DebugMenu["Main"].Position = UDim2.new(0, 20, 1, -220)
DebugMenu["Main"].Size = UDim2.new(1, 0, 0, 200)
DebugMenu["Main"].BackgroundTransparency = 1
DebugMenu["Main"].Visible = false
if game.PlaceId == 606849621 then
    DebugMenu["Main"].Position = UDim2.new(0, 230, 1, -220)
end
DebugMenu["Main"].Draggable = true
DebugMenu["Main"].Active = true

-- 调试菜单文本标签
DebugMenu["Position"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["Position"].BackgroundTransparency = 1
DebugMenu["Position"].Position = UDim2.new(0, 0, 0, 0)
DebugMenu["Position"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["Position"].Font = "Arcade"
DebugMenu["Position"].Text = ""
DebugMenu["Position"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["Position"].TextSize = 15
DebugMenu["Position"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["Position"].TextStrokeTransparency = 0.3
DebugMenu["Position"].TextXAlignment = "Left"

DebugMenu["FPS"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["FPS"].BackgroundTransparency = 1
DebugMenu["FPS"].Position = UDim2.new(0, 0, 0, 15)
DebugMenu["FPS"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["FPS"].Font = "Arcade"
DebugMenu["FPS"].Text = ""
DebugMenu["FPS"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["FPS"].TextSize = 15
DebugMenu["FPS"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["FPS"].TextStrokeTransparency = 0.3
DebugMenu["FPS"].TextXAlignment = "Left"

DebugMenu["PlayerSelected"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["PlayerSelected"].BackgroundTransparency = 1
DebugMenu["PlayerSelected"].Position = UDim2.new(0, 0, 0, 35)
DebugMenu["PlayerSelected"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["PlayerSelected"].Font = "Arcade"
DebugMenu["PlayerSelected"].Text = ""
DebugMenu["PlayerSelected"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["PlayerSelected"].TextSize = 15
DebugMenu["PlayerSelected"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["PlayerSelected"].TextStrokeTransparency = 0.3
DebugMenu["PlayerSelected"].TextXAlignment = "Left"

DebugMenu["PlayerTeam"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["PlayerTeam"].BackgroundTransparency = 1
DebugMenu["PlayerTeam"].Position = UDim2.new(0, 0, 0, 50)
DebugMenu["PlayerTeam"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["PlayerTeam"].Font = "Arcade"
DebugMenu["PlayerTeam"].Text = ""
DebugMenu["PlayerTeam"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["PlayerTeam"].TextSize = 15
DebugMenu["PlayerTeam"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["PlayerTeam"].TextStrokeTransparency = 0.3
DebugMenu["PlayerTeam"].TextXAlignment = "Left"

DebugMenu["PlayerHealth"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["PlayerHealth"].BackgroundTransparency = 1
DebugMenu["PlayerHealth"].Position = UDim2.new(0, 0, 0, 65)
DebugMenu["PlayerHealth"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["PlayerHealth"].Font = "Arcade"
DebugMenu["PlayerHealth"].Text = ""
DebugMenu["PlayerHealth"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["PlayerHealth"].TextSize = 15
DebugMenu["PlayerHealth"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["PlayerHealth"].TextStrokeTransparency = 0.3
DebugMenu["PlayerHealth"].TextXAlignment = "Left"

DebugMenu["PlayerPosition"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["PlayerPosition"].BackgroundTransparency = 1
DebugMenu["PlayerPosition"].Position = UDim2.new(0, 0, 0, 80)
DebugMenu["PlayerPosition"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["PlayerPosition"].Font = "Arcade"
DebugMenu["PlayerPosition"].Text = ""
DebugMenu["PlayerPosition"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["PlayerPosition"].TextSize = 15
DebugMenu["PlayerPosition"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["PlayerPosition"].TextStrokeTransparency = 0.3
DebugMenu["PlayerPosition"].TextXAlignment = "Left"

DebugMenu["BehindWall"] = Instance.new("TextLabel", DebugMenu["Main"])
DebugMenu["BehindWall"].BackgroundTransparency = 1
DebugMenu["BehindWall"].Position = UDim2.new(0, 0, 0, 95)
DebugMenu["BehindWall"].Size = UDim2.new(1, 0, 0, 15)
DebugMenu["BehindWall"].Font = "Arcade"
DebugMenu["BehindWall"].Text = ""
DebugMenu["BehindWall"].TextColor3 = Color3.new(1, 1, 1)
DebugMenu["BehindWall"].TextSize = 15
DebugMenu["BehindWall"].TextStrokeColor3 = Color3.new(0, 0, 0)
DebugMenu["BehindWall"].TextStrokeTransparency = 0.3
DebugMenu["BehindWall"].TextXAlignment = "Left"

local LastTick = tick()
local FPSTick = tick()

-- 如果没有队伍则设置为混战模式
if #Teams:GetChildren() <= 0 then
    Bullshit.FreeForAll = true
end

-- 限制追踪线长度
if Bullshit.TracersLength > 2048 then
    Bullshit.TracersLength = 2048
end

-- 限制透视距离
if Bullshit.CHAMSLength > 2048 then
    Bullshit.CHAMSLength = 2048
end

-- 获取队伍颜色
local wildrevolvertick = tick()
local wildrevolverteamdata = nil
function GetTeamColor(Plr)
    if Plr == nil then return nil end
    if not Plr:IsA("Player") then
        return nil
    end
    local PickedColor = Bullshit.Colors.Enemy
    
    if Plr ~= nil then
        -- 根据不同游戏设置不同的颜色逻辑
        -- 这里省略了具体的游戏判断逻辑...
        -- 主要逻辑是根据玩家队伍关系决定颜色
    end
    
    return PickedColor
end

-- 查找透视对象
function FindCham(Obj)
    for i, v in next, ItemChams:GetChildren() do
        if v.className == "ObjectValue" then
            if v.Value == Obj then
                return v.Parent
            end
        end
    end
    return nil
end

-- 查找ESP对象
function FindESP(Obj)
    for i, v in next, ItemESP:GetChildren() do
        if v.className == "ObjectValue" then
            if v.Value == Obj then
                return v.Parent
            end
        end
    end
    return nil
end

-- 获取对象的第一个部分
function GetFirstPart(Obj)
    for i, v in next, Obj:GetDescendants() do
        if v:IsA("BasePart") then
            return v
        end
    end
    return nil
end

-- 获取对象大小
function GetSizeOfObject(Obj)
    if Obj:IsA("BasePart") then
        return Obj.Size
    elseif Obj:IsA("Model") then
        return Obj:GetExtentsSize()
    end
end

-- 获取不在墙后的最近玩家
function GetClosestPlayerNotBehindWall()
    local Players = { }
    local CurrentClosePlayer = nil
    local SelectedPlr = nil

    for _, v in next, Plrs:GetPlayers() do
        if v ~= MyPlr and not Bullshit.Blacklist[v.Name] then
            local IsAlly = GetTeamColor(v)
            if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
                local GetChar = v.Character
                if MyChar and GetChar then
                    local MyHead, MyTor = MyChar:FindFirstChild("Head"), MyChar:FindFirstChild("HumanoidRootPart")
                    local GetHead, GetTor, GetHum = GetChar:FindFirstChild("Head"), GetChar:FindFirstChild("HumanoidRootPart"), GetChar:FindFirstChild("Humanoid")

                    if MyHead and MyTor and GetHead and GetTor and GetHum then
                        -- 根据不同游戏进行射线检测
                        local Ray = Ray.new(MyCam.CFrame.p, (GetHead.Position - MyCam.CFrame.p).unit * 2048)
                        local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
                        if part ~= nil then
                            if part:IsDescendantOf(GetChar) then
                                local Dist = (MyTor.Position - GetTor.Position).magnitude
                                Players[v] = Dist
                            end
                        end
                    end
                end
            end
        end
    end

    -- 找出最近的玩家
    for i, v in next, Players do
        if CurrentClosePlayer ~= nil then
            if v <= CurrentClosePlayer then
                CurrentClosePlayer = v
                SelectedPlr = i
            end
        else
            CurrentClosePlayer = v
            SelectedPlr = i
        end
    end
    
    return SelectedPlr
end

-- 获取最近的玩家
function GetClosestPlayer()
    local Players = { }
    local CurrentClosePlayer = nil
    local SelectedPlr = nil
    
    for _, v in next, Plrs:GetPlayers() do
        if v ~= MyPlr then
            local IsAlly = GetTeamColor(v)
            if IsAlly ~= Bullshit.Colors.Ally and IsAlly ~= Bullshit.Colors.Friend and IsAlly ~= Bullshit.Colors.Neutral then
                local GetChar = v.Character
                if MyChar and GetChar then
                    local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
                    local GetTor = GetChar:FindFirstChild("HumanoidRootPart")
                    local GetHum = GetChar:FindFirstChild("Humanoid")
                    if MyTor and GetTor and GetHum then
                        -- 根据不同游戏进行距离计算
                        local Dist = (MyTor.Position - GetTor.Position).magnitude
                        Players[v] = Dist
                    end
                end
            end
        end
    end
    
    -- 找出最近的玩家
    for i, v in next, Players do
        if CurrentClosePlayer ~= nil then
            if v <= CurrentClosePlayer then
                CurrentClosePlayer = v
                SelectedPlr = i
            end
        else
            CurrentClosePlayer = v
            SelectedPlr = i
        end
    end
    
    return SelectedPlr
end

-- 查找玩家
function FindPlayer(Txt)
    local ps = { }
    for _, v in next, Plrs:GetPlayers() do
        if string.lower(string.sub(v.Name, 1, string.len(Txt))) == string.lower(Txt) then
            table.insert(ps, v)
        end
    end

    if #ps == 1 then
        if ps[1] ~= MyPlr then
            return ps[1]
        else
            return nil
        end
    else
        return nil
    end
end

-- 更新ESP
function UpdateESP(Plr)
    if Plr ~= nil then
        local Find = PlayerESP:FindFirstChild("ESP Crap_" .. Plr.Name)
        if Find then
            local PickColor = GetTeamColor(Plr)
            Find.Frame.Names.TextColor3 = PickColor
            Find.Frame.Dist.TextColor3 = PickColor
            Find.Frame.Health.TextColor3 = PickColor
            
            local GetChar = Plr.Character
            if MyChar and GetChar then
                local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
                local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
                local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
                if Find2 and Find3 then
                    local pos = Find3.Position
                    local Dist = (Find2.Position - pos).magnitude
                    -- 根据距离和黑名单决定是否显示
                    if Dist > Bullshit.ESPLength or Bullshit.Blacklist[Plr.Name] then
                        Find.Frame.Names.Visible = false
                        Find.Frame.Dist.Visible = false
                        Find.Frame.Health.Visible = false
                        return
                    else
                        Find.Frame.Names.Visible = true
                        Find.Frame.Dist.Visible = true
                        Find.Frame.Health.Visible = true
                    end
                    -- 更新距离和生命值信息
                    Find.Frame.Dist.Text = "距离: " .. string.format("%.0f", Dist)
                    if Find4 then
                        Find.Frame.Health.Text = "生命值: " .. string.format("%.0f", Find4.Health)
                    else
                        Find.Frame.Health.Text = ""
                    end
                end
            end
        end
    end
end

-- 移除ESP
function RemoveESP(Obj)
    if Obj ~= nil then
        local IsPlr = Obj:IsA("Player")
        local UseFolder = ItemESP
        if IsPlr then UseFolder = PlayerESP end

        local FindESP = ((IsPlr) and UseFolder:FindFirstChild("ESP Crap_" .. Obj.Name)) or FindESP(Obj)
        if FindESP then
            FindESP:Destroy()
        end
    end
end

-- 创建ESP
function CreateESP(Obj)
    if Obj ~= nil then
        local IsPlr = Obj:IsA("Player")
        local UseFolder = ItemESP
        local GetChar = ((IsPlr) and Obj.Character) or Obj
        local Head = GetChar:FindFirstChild("Head")
        local t = tick()
        if IsPlr then UseFolder = PlayerESP end
        if Head == nil then
            repeat
                Head = GetChar:FindFirstChild("Head")
                wait()
            until Head ~= nil or (tick() - t) >= 10
        end
        if Head == nil then return end
        
        -- 创建ESP GUI元素
        local bb = Instance.new("BillboardGui")
        bb.Adornee = Head
        bb.ExtentsOffset = Vector3.new(0, 1, 0)
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(0, 5, 0, 5)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.Name = "ESP Crap_" .. Obj.Name
        bb.Parent = UseFolder
        
        local frame = Instance.new("Frame", bb)
        frame.ZIndex = 10
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(1, 0, 1, 0)
        
        local TxtName = Instance.new("TextLabel", frame)
        TxtName.Name = "Names"
        TxtName.ZIndex = 10
        TxtName.Text = Obj.Name
        TxtName.BackgroundTransparency = 1
        TxtName.Position = UDim2.new(0, 0, 0, -45)
        TxtName.Size = UDim2.new(1, 0, 10, 0)
        TxtName.Font = "SourceSansBold"
        TxtName.TextSize = 13
        TxtName.TextStrokeTransparency = 0.5

        -- 如果是玩家则添加距离和生命值显示
        local TxtDist = nil
        local TxtHealth = nil
        if IsPlr then
            TxtDist = Instance.new("TextLabel", frame)
            TxtDist.Name = "Dist"
            TxtDist.ZIndex = 10
            TxtDist.Text = ""
            TxtDist.BackgroundTransparency = 1
            TxtDist.Position = UDim2.new(0, 0, 0, -35)
            TxtDist.Size = UDim2.new(1, 0, 10, 0)
            TxtDist.Font = "SourceSansBold"
            TxtDist.TextSize = 13
            TxtDist.TextStrokeTransparency = 0.5

            TxtHealth = Instance.new("TextLabel", frame)
            TxtHealth.Name = "Health"
            TxtHealth.ZIndex = 10
            TxtHealth.Text = ""
            TxtHealth.BackgroundTransparency = 1
            TxtHealth.Position = UDim2.new(0, 0, 0, -25)
            TxtHealth.Size = UDim2.new(1, 0, 10, 0)
            TxtHealth.Font = "SourceSansBold"
            TxtHealth.TextSize = 13
            TxtHealth.TextStrokeTransparency = 0.5
        else
            local ObjVal = Instance.new("ObjectValue", bb)
            ObjVal.Value = Obj
        end
        
        -- 设置颜色
        local PickColor = GetTeamColor(Obj) or Bullshit.Colors.Neutral
        TxtName.TextColor3 = PickColor

        if IsPlr then
            TxtDist.TextColor3 = PickColor
            TxtHealth.TextColor3 = PickColor
        end
    end
end

-- 更新追踪线
function UpdateTracer(Plr)
    if Bullshit.TracersEnabled then
        if MyChar then
            local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
            local GetTor = TracerData[Plr.Name]
            if MyTor and GetTor ~= nil and GetTor.Parent ~= nil then
                local Dist = (MyTor.Position - GetTor.Position).magnitude
                if (Dist < Bullshit.TracersLength and not Bullshit.Blacklist[Plr.Name]) and not (MyChar:FindFirstChild("InVehicle") or GetTor.Parent:FindFirstChild("InVehicle")) then
                    if not Bullshit.PlaceTracersUnderCharacter then
                        -- 从屏幕中心绘制追踪线
                        local R = MyCam:ScreenPointToRay(MyCam.ViewportSize.X / 2, MyCam.ViewportSize.Y, 0)
                        Dist = (R.Origin - (GetTor.Position - Vector3.new(0, 3, 0))).magnitude
                        Tracers[Plr.Name].Transparency = 1
                        Tracers[Plr.Name].Size = Vector3.new(0.05, 0.05, Dist)
                        Tracers[Plr.Name].CFrame = CFrame.new(R.Origin, (GetTor.Position - Vector3.new(0, 4.5, 0))) * CFrame.new(0, 0, -Dist / 2)
                        Tracers[Plr.Name].BrickColor = BrickColor.new(GetTeamColor(Plr))
                        Tracers[Plr.Name].BoxHandleAdornment.Transparency = 0
                        Tracers[Plr.Name].BoxHandleAdornment.Size = Vector3.new(0.001, 0.001, Dist)
                        Tracers[Plr.Name].BoxHandleAdornment.Color3 = GetTeamColor(Plr)
                    else
                        -- 从角色下方绘制追踪线
                        Dist = (MyTor.Position - (GetTor.Position - Vector3.new(0, 3, 0))).magnitude
                        Tracers[Plr.Name].Transparency = 1
                        Tracers[Plr.Name].Size = Vector3.new(0.3, 0.3, Dist)
                        Tracers[Plr.Name].CFrame = CFrame.new(MyTor.Position - Vector3.new(0, 3, 0), (GetTor.Position - Vector3.new(0, 4.5, 0))) * CFrame.new(0, 0, -Dist / 2)
                        Tracers[Plr.Name].BrickColor = BrickColor.new(GetTeamColor(Plr))
                        Tracers[Plr.Name].BoxHandleAdornment.Transparency = 0
                        Tracers[Plr.Name].BoxHandleAdornment.Size = Vector3.new(0.05, 0.05, Dist)
                        Tracers[Plr.Name].BoxHandleAdornment.Color3 = GetTeamColor(Plr)
                    end
                else
                    -- 超出距离则隐藏追踪线
                    Tracers[Plr.Name].Transparency = 1
                    Tracers[Plr.Name].BoxHandleAdornment.Transparency = 1
                end
            end
        end
    end
end

-- 移除追踪线
function RemoveTracers(Plr)
    local Find = Tracers:FindFirstChild(Plr.Name)
    if Find then
        Find:Destroy()
    end
end

-- 创建追踪线
function CreateTracers(Plr)
    local Find = Tracers:FindFirstChild(Plr.Name)
    if not Find then
        local P = Instance.new("Part")
        P.Name = Plr.Name
        P.Material = "Neon"
        P.Transparency = 1
        P.Anchored = true
        P.Locked = true
        P.CanCollide = false
        local B = Instance.new("BoxHandleAdornment", P)
        B.Adornee = P
        B.Size = GetSizeOfObject(P)
        B.AlwaysOnTop = true
        B.ZIndex = 5
        B.Transparency = 0
        B.Color3 = GetTeamColor(Plr) or Bullshit.Colors.Neutral
        P.Parent = Tracers

        -- 创建协程持续更新追踪线
        coroutine.resume(coroutine.create(function()
            while Tracers:FindFirstChild(Plr.Name) do
                UpdateTracer(Plr)
                Run.RenderStepped:wait()
            end
        end))
    end
end

-- 更新透视效果
function UpdateChams(Obj)
    if Obj == nil then return end

    if Obj:IsA("Player") then
        local Find = PlayerChams:FindFirstChild(Obj.Name)
        local GetChar = Obj.Character

        local Trans = 0
        if GetChar and MyChar then
            local GetHead = GetChar:FindFirstChild("Head")
            local GetTor = GetChar:FindFirstChild("HumanoidRootPart")
            local MyHead = MyChar:FindFirstChild("Head")
            local MyTor = MyChar:FindFirstChild("HumanoidRootPart")
            if GetHead and GetTor and MyHead and MyTor then
                -- 根据距离和黑名单决定透明度
                if (MyTor.Position - GetTor.Position).magnitude > Bullshit.CHAMSLength or Bullshit.Blacklist[Obj.Name] then
                    Trans = 1
                else
                    -- 如果被墙挡住则半透明
                    local Ray = Ray.new(MyCam.CFrame.p, (GetTor.Position - MyCam.CFrame.p).unit * 2048)
                    local part = workspace:FindPartOnRayWithIgnoreList(Ray, {MyChar})
                    if part ~= nil then
                        if part:IsDescendantOf(GetChar) then
                            Trans = 0.9
                        else
                            Trans = 0
                        end
                    end
                end
            end
        end

        -- 更新透视颜色和透明度
        if Find then
            for i, v in next, Find:GetChildren() do
                if v.className ~= "ObjectValue" then
                    v.Color3 = GetTeamColor(Obj) or Bullshit.Colors.Neutral
                    v.Transparency = Trans
                end
            end
        end
    end
end

-- 移除透视效果
function RemoveChams(Obj)
    if Obj ~= nil then
        local IsPlr = Obj:IsA("Player")
        local UseFolder = ItemChams
        if IsPlr then UseFolder = PlayerChams end

        local FindC = UseFolder:FindFirstChild(tostring(Obj)) or FindCham(Obj)
        if FindC then
            FindC:Destroy()
        end
    end
end

-- 创建透视效果
function CreateChams(Obj)
    if Obj ~= nil then
        local IsPlr = Obj:IsA("Player")
        local UseFolder = ItemChams
        local Crap = nil
        local GetTor = nil
        local t = tick()
        if IsPlr then
            Obj = Obj.Character
            UseFolder = PlayerChams
        end
        if Obj == nil then return end
        GetTor = Obj:FindFirstChild("HumanoidRootPart") or Obj:WaitForChild("HumanoidRootPart")
        if IsPlr then Crap = Obj:GetChildren() else Crap = Obj:GetDescendants() end

        -- 查找或创建透视文件夹
        local FindC = ((IsPlr) and UseFolder:FindFirstChild(Obj.Name)) or FindCham(Obj)
        if not FindC then
            FindC = Instance.new("Folder", UseFolder)
            FindC.Name = Obj.Name
            local ObjVal = Instance.new("ObjectValue", FindC)
            ObjVal.Value = Obj
        end

        -- 为每个部分创建透视效果
        for _, P in next, Crap do
            if P:IsA("PVInstance") and P.Name ~= "HumanoidRootPart" then
                local Box = Instance.new("BoxHandleAdornment")
                Box.Size = GetSizeOfObject(P)
                Box.Name = "Cham"
                Box.Adornee = P
                Box.AlwaysOnTop = true
                Box.ZIndex = 5
                Box.Transparency = 0
                Box.Color3 = ((IsPlr) and GetTeamColor(Plrs:GetPlayerFromCharacter(Obj))) or Bullshit.Colors.Neutral
                Box.Parent = FindC
            end
        end
    end
end

-- 创建NPC的ESP和透视
function CreateMobESPChams()
    local mobspawn = { }

    -- 查找所有NPC
    for i, v in next, workspace:GetDescendants() do
        local hum = v:FindFirstChildOfClass("Humanoid")
        if hum and not Plrs:GetPlayerFromCharacter(hum.Parent) and FindCham(v) == nil and FindESP(v) == nil then
            mobspawn[tostring(v.Parent)] = v.Parent
            if Bullshit.CHAMSEnabled and Bullshit.MobChams then
                CreateChams(v)
            end
            if Bullshit.ESPEnabled and Bullshit.MobESP then
                CreateESP(v)
            end
        end
    end

    -- 为NPC添加