-- 完全汉化的Roblox ESP脚本核心框架
-- 注意：部分API名称必须保留英文以保证功能正常

-- ========== 基础服务 ==========
local 游戏服务 = game
local 玩家服务 = 游戏服务:GetService("Players")
local 运行服务 = 游戏服务:GetService("RunService")
local 核心界面 = 游戏服务:GetService("CoreGui")
local 光照服务 = 游戏服务:GetService("Lighting")
local 用户输入 = 游戏服务:GetService("UserInputService")

-- ========== 玩家数据 ==========
local 本地玩家 = 玩家服务.LocalPlayer
local 本地角色 = 本地玩家.Character or 本地玩家.CharacterAdded:Wait()
local 本地相机 = workspace.CurrentCamera

-- ========== 配置设置 ==========
local 配置 = {
    ESP功能 = false,
    透视功能 = false,
    追踪线功能 = false,
    调试信息 = false,
    
    最大距离 = {
        ESP = 1000,
        透视 = 500,
        追踪线 = 800
    },
    
    颜色设置 = {
        敌人 = Color3.fromRGB(255, 0, 0),    -- 红色
        队友 = Color3.fromRGB(0, 255, 0),    -- 绿色
        好友 = Color3.fromRGB(255, 255, 0),  -- 黄色
        中立 = Color3.fromRGB(255, 255, 255) -- 白色
    },
    
    黑名单 = {},
    好友列表 = {}
}

-- ========== 创建显示元素 ==========
local 透视容器 = Instance.new("Folder", 核心界面)
透视容器.Name = "透视效果"

local ESP容器 = Instance.new("Folder", 核心界面)
ESP容器.Name = "ESP效果"

-- ========== 核心功能函数 ==========
local function 创建ESP(目标)
    if not 目标 then return end
    
    local esp框架 = Instance.new("BillboardGui")
    esp框架.Name = "ESP_"..目标.Name
    esp框架.Adornee = 目标
    esp框架.Size = UDim2.new(0, 100, 0, 50)
    esp框架.StudsOffset = Vector3.new(0, 2, 0)
    esp框架.AlwaysOnTop = true
    
    local 名称标签 = Instance.new("TextLabel", esp框架)
    名称标签.Text = 目标.Name
    名称标签.Size = UDim2.new(1, 0, 0.5, 0)
    名称标签.Font = Enum.Font.SourceSansBold
    名称标签.TextSize = 14
    
    local 距离标签 = Instance.new("TextLabel", esp框架)
    距离标签.Position = UDim2.new(0, 0, 0.5, 0)
    距离标签.Size = UDim2.new(1, 0, 0.5, 0)
    距离标签.Font = Enum.Font.SourceSans
    
    esp框架.Parent = ESP容器
    return esp框架
end

local function 更新ESP显示()
    for _, 玩家 in ipairs(玩家服务:GetPlayers()) do
        if 玩家 ~= 本地玩家 and 玩家.Character then
            local 头部 = 玩家.Character:FindFirstChild("Head")
            if 头部 then
                local esp = ESP容器:FindFirstChild("ESP_"..玩家.Name) or 创建ESP(头部)
                
                -- 更新颜色和距离
                local 颜色 = 配置.颜色设置.中立
                if 配置.好友列表[玩家.Name] then
                    颜色 = 配置.颜色设置.好友
                elseif 玩家.Team ~= 本地玩家.Team then
                    颜色 = 配置.颜色设置.敌人
                else
                    颜色 = 配置.颜色设置.队友
                end
                
                esp.TextLabel.TextColor3 = 颜色
                local 距离 = (本地角色.HumanoidRootPart.Position - 玩家.Character.HumanoidRootPart.Position).Magnitude
                esp:FindFirstChild("TextLabel").Text = string.format("%s (%.1f米)", 玩家.Name, 距离)
                
                -- 距离超出时隐藏
                esp.Enabled = 距离 <= 配置.最大距离.ESP
            end
        end
    end
end

-- ========== 主循环 ==========
运行服务.RenderStepped:Connect(function()
    if 配置.ESP功能 then
        更新ESP显示()
    end
end)

-- ========== 用户界面 ==========
local 界面 = Instance.new("ScreenGui", 核心界面)
界面.Name = "ESP控制面板"

local 主面板 = Instance.new("Frame", 界面)
主面板.Size = UDim2.new(0, 200, 0, 300)
主面板.Position = UDim2.new(0.5, -100, 0.5, -150)

local function 创建按钮(名称, 位置, 回调)
    local 按钮 = Instance.new("TextButton", 主面板)
    按钮.Text = 名称
    按钮.Size = UDim2.new(0.8, 0, 0, 30)
    按钮.Position = UDim2.new(0.1, 0, 位置, 0)
    按钮.MouseButton1Click:Connect(回调)
    return 按钮
end

-- 创建控制按钮
创建按钮("开启/关闭ESP", 0.1, function()
    配置.ESP功能 = not 配置.ESP功能
    print("ESP功能:", 配置.ESP功能 and "开启" or "关闭")
end)

创建按钮("开启/关闭透视", 0.2, function()
    配置.透视功能 = not 配置.透视功能
    print("透视功能:", 配置.透视功能 and "开启" or "关闭")
end)

-- ========== 初始化 ==========
print("ESP脚本初始化完成")
print("按P键显示/隐藏控制面板")

用户输入.InputBegan:Connect(function(输入)
    if 输入.KeyCode == Enum.KeyCode.P then
        主面板.Visible = not 主面板.Visible
    end
end)