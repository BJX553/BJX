hookfunction(getnamecallmethod, function()
  return
end)
for i, v in pairs({request, loadstring, base64.decode}) do
  if isfunctionhooked(v) or not isfunctionhooked(getnamecallmethod) then
    return
  end
end
local HttpService = game:GetService("HttpService")
local Plr = game:GetService("Players")
local LP = Plr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientModule = require(LP:WaitForChild("PlayerScripts"):WaitForChild("Client"))
local EatRemote = ClientModule and ClientModule.Events and ClientModule.Events.RequestConsumeItem
getgenv().WS = LP.Character.Humanoid.WalkSpeed
return(function()
  local function GetAsset(v)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return HttpService:JSONDecode(request({
      Url = v,
      Headers = {
        Authorization = "Bearer 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"
      }
    }).Body).content:gsub('[^'..b..'=]', ''):gsub('.', function(x)
      if (x == '=') then return '' end
      local r,f='',(b:find(x)-1)
      for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
      return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
      if (#x ~= 8) then return '' end
      local c=0
      for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
      return string.char(c)
    end)
  end
  if HttpService:JSONDecode(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/ID/index.json?ref=main"))[LP.Name] == LP.UserId then
    local WindUI = loadstring(GetAsset("https://api.github.com/repos/AlienX-Script/AlienX/contents/AlienX_UI/Alienx_WindUI_5.0"))()
    local AlienX = {
      ["杀戮光环"] = false,
      ["自动砍树"] = false,
      ["自动进食"] = false,
      ["透视孩子"] = false,
      ["透视宝箱"] = false
    }
    local BL = {}
    local ClientModule = require(LP:WaitForChild("PlayerScripts"):WaitForChild("Client"))
    local EatRemote = ClientModule and ClientModule.Events and ClientModule.Events.RequestConsumeItem
    local function AddESP(part, txt1, txt2, enabled)
      local BG = part:FindFirstChild("BillboardGui")
      if not BG then
        local bg = Instance.new("BillboardGui")
        bg.Adornee = part
        bg.Parent = part
        bg.Size = UDim2.new(0, 100, 0, 100)
        bg.StudsOffset = Vector3.new(0, 3, 0)
        bg.AlwaysOnTop = true
        local TL = Instance.new("TextLabel", bg)
        TL.Text = txt1 .. "\n" .. txt2 .. "m"
        TL.Size = UDim2.new(1, 0, 0, 40)
        TL.Position = UDim2.new(0, 0, 0, 0)
        TL.BackgroundTransparency = 1
        TL.TextColor3 = Color3.new(1, 1, 1)
        TL.TextStrokeTransparency = 0.3
        TL.Font = Enum.Font.GothamBold
        TL.TextSize = 14
        local Img = Instance.new("ImageLabel", bg)
        Img.Position = UDim2.new(0, 20, 0, 40)
        Img.Size = UDim2.new(0, 60, 0, 60)
        Img.Image = part.Name:match("Chest") and "rbxassetid://18660563116" or ""
        Img.BackgroundTransparency = 1
      else
        local bg = BG
        bg.TextLabel.Text = txt1 .. "\n" .. txt2 .. "m"
        bg.Enabled = enabled
      end
    end
    local function Collect(thing)
      for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == thing then
          local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
          if part then
            part.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
          end
        end
      end
    end
    local function tryEatFood(food)
      if not EatRemote then warn("🚫 No EatRemote") return end
      if not ReplicatedStorage:FindFirstChild("TempStorage") then warn("🚫 No TempStorage") return end
      WindUI:Notify({Title = "AlienX", Content = "➡️ 正在尝试吃下" .. food.Name, Duration = 5})
      food.Parent = ReplicatedStorage.TempStorage
      local success, result = pcall(function()
        return EatRemote:InvokeServer(food)
      end)
      if success and result and result.Success then
        WindUI:Notify({Title = "AlienX", Content = "✅成功吃下 " .. food.Name, Duration = 5})
        return
       else
        WindUI:Notify({Title = "AlienX", Content = "❌️进食失败", Duration = 5})
        return
      end
    end
    local PlayerList = {}
    for a, b in next, Plr:GetPlayers() do
      table.insert(PlayerList, b.Name)
    end
    WindUI:Notify({Title = "AlienX", Content = "✅启动成功✅", Duration = 5})
            local Window = WindUI:CreateWindow({
            Title = "AlienX / 森林中的99夜",
            Icon = "rbxassetid://4483362748",
            IconThemed = true,
            Author = "AlienX",
            Folder = "CloudHub",
            Size = UDim2.fromOffset(300, 270),
            Transparent = true,
            Theme = "Dark",
            User = {Enabled = true, Callback = function() print("clicked") end, Anonymous = false},
            SideBarWidth = 200,
            ScrollBarEnabled = true,
        })

        Window:EditOpenButton({
            Title = "打开脚本",
            Icon = "monitor",
            CornerRadius = UDim.new(0,16),
            StrokeThickness = 4,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
                ColorSequenceKeypoint.new(0.16, Color3.fromHex("FF7F00")),
                ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
                ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
                ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
                ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
                ColorSequenceKeypoint.new(1, Color3.fromHex("9400D3"))
            }),
            Draggable = true,
        })

        local MainSection = Window:Section({Title = "主要", Opened = true})
        
        local function AddTab(a, b)
            return MainSection:Tab({Title = a, Icon = b})
        end
        
        function Btn(a, b, c)
            return a:Button({Title = b, Callback = c})
        end
        function Tg(a, b, c, d)
           return a:Toggle({Title = b, Image = "bird", Value = c, Callback = d})
        end
    function Sld(a, b, c, d, e, f)
           return a:Slider({Title = b, Step = 1, Value = {Min = c, Max = d, Default = e}, Callback = f})
        end
  
    A = AddTab("主要","rbxassetid://4483364237")
    B = AddTab("收集","rbxassetid://4400701828")
    C = AddTab("透视","rbxassetid://3610254229")
    D = AddTab("传送","rbxassetid://3944690667")
    E = AddTab("玩家","rbxassetid://4335480896")
    
    Window:SelectTab(1)

    Tg(A, "杀戮光环", false, function(t)
      AlienX["杀戮光环"] = t
    end)
    Tg(A, "自动砍树", false, function(t)
      AlienX["自动砍树"] = t
    end)
    Tg(A, "自动进食", false, function(t)
      AlienX["自动进食"] = t
    end)
    Tg(A, "瞬间互动", false, function(t)
      if t then
        if not connection then
          connection = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
            prompt.HoldDuration = 0
          end)
        end
       else
        if connection then
          connection:Disconnect()
        end
      end
    end)

    B:Paragraph({
      Title = "收集功能↓",
      Desc = "把地图里你想要的物品传送到自己的位置",
      Color = "Grey"
    })
    local BS1 = B:Section({Title = "⚔️武器装备", TextXAlignment = "Left", TextSize = 17})
    Btn(B, "左轮", function() Collect("Revolver") end)
    Btn(B, "步枪", function() Collect("Rifle") end)
    Btn(B, "左轮子弹", function() Collect("Revolver Ammo") end)
    Btn(B, "步枪子弹", function() Collect("Rifle Ammo") end)
    Btn(B, "皮革", function() Collect("Leather Body") end)
    Btn(B, "铁甲", function() Collect("Iron Body") end)
    Btn(B, "荆棘铠甲", function() Collect("Thorn Body") end)
    local BS2 = B:Section({Title = "🔨制作物品", TextXAlignment = "Left", TextSize = 17})
    Btn(B, "螺栓", function() Collect("Bolt") end)
    Btn(B, "金属薄板", function() Collect("Sheet Metal") end)
    Btn(B, "旧收音机", function() Collect("Old Radio") end)
    Btn(B, "损坏的电扇", function() Collect("Broken Fan") end)
    Btn(B, "损坏的微波炉", function() Collect("Broken Microwave") end)
    local BS3 = B:Section({Title = "🛢️燃料类型", TextXAlignment = "Left", TextSize = 17})
    Btn(B, "木头", function() Collect("Log") end)
    Btn(B, "椅子", function() Collect("Chair") end)
    Btn(B, "燃料罐", function() Collect("Fuel Canister") end)
    Btn(B, "油桶", function() Collect("Oil Barrel") end)
    Btn(B, "生物燃料", function() Collect("Biofuel") end)
    Btn(B, "煤", function() Collect("Coal") end)
    local BS4 = B:Section({Title = "🥬食物类型", TextXAlignment = "Left", TextSize = 17})
    Btn(B, "萝卜", function() Collect("Carrot") end)
    Btn(B, "浆果", function() Collect("Berry") end)
    Btn(B, "生食", function() Collect("Morsel") end)
    Btn(B, "生牛肉", function() Collect("Steak") end)
    Btn(B, "熟食", function() Collect("Cooked Morsel") end)
    Btn(B, "熟牛肉", function() Collect("Cooked Steak") end)
    local BS5 = B:Section({Title = "💉治疗物品", TextXAlignment = "Left", TextSize = 17})
    Btn(B, "急救包", function() Collect("MedKit") end)
    Btn(B, "绷带", function() Collect("Bandage") end)

    Tg(C, "走失的孩子", false, function(t)
      AlienX["透视孩子"] = t
    end)
    Tg(C, "宝箱", false, function(t)
      AlienX["透视宝箱"] = t
    end)

    local C_P = D:Dropdown({Title = "传送玩家", Values = PlayerList, Value = "", Callback = function(d)
        if Plr[d] and Plr[d].Character and Plr[d].Character:FindFirstChild("HumanoidRootPart") then
          LP.Character:PivotTo(Plr[d].Character.HumanoidRootPart.CFrame)
        end
      end})

    Sld(E, "移动速度", 0, 200, LP.Character.Humanoid.WalkSpeed, function(s)
      getgenv().WS = s
    end)
    Sld(E, "悬浮高度", 0, 200, LP.Character.Humanoid.HipHeight, function(s)
      LP.Character.Humanoid.HipHeight = s
    end)
    Tg(E, "玩家发光", false, function(t)
      if t then
        local light = Instance.new("PointLight", LP.Character.Head)
        light.Name = "light"
        light.Range = 9999999
        light.Brightness = 15
       else
        pcall(function()LP.Character.Head.light:remove()end)
      end
    end)

    Plr.PlayerAdded:Connect(function(a)
      PlayerList = {}
      for a, b in next, Plr:GetPlayers() do
        table.insert(PlayerList, b.Name)
      end
      task.wait(.1)
      C_P:Refresh(PlayerList)
    end)
    Plr.PlayerRemoving:Connect(function(a)
      PlayerList = {}
      for a, b in next, Plr:GetPlayers() do
        table.insert(PlayerList, b.Name)
      end
      task.wait(.1)
      C_P:Refresh(PlayerList)
    end)
    local last1, last2, last3 = 0, 0, 0
    game["Run Service"].Heartbeat:Connect(function()
      local Now = tick()
      if not LP.Character then return end
      if not LP.Character:FindFirstChild("HumanoidRootPart") then return end
      LP.Character.Humanoid.WalkSpeed = WS
      for a, b in next, workspace.Items:GetChildren() do
        if b:GetAttribute(tostring(LP.UserId) .. "Opened") then
          table.insert(BL, b)
          if b:FindFirstChild("BillboardGui") then
            b.BillboardGui:Destroy()
          end
        end
        if b.Name:match("Chest") and b:IsA("Model") and not table.find(BL, b) and b:FindFirstChild("Main") then
          AddESP(b, "宝箱", tostring(math.floor((LP.Character.HumanoidRootPart.Position - b.Main.Position).Magnitude)), AlienX["透视宝箱"])
        end
      end
      for a, b in next, workspace.Characters:GetChildren() do
        if b:GetAttribute("Lost") and b:GetAttribute("Lost") == false then
          table.insert(BL, b)
          if b:FindFirstChild("BillboardGui") then
            b.BillboardGui:Destroy()
          end
        end
        if table.find({"Lost Child", "Lost Child1", "Lost Child2", "Lost Child3", "Dino Kid", "kraken kid", "Squid kid", "Koala Kid", "koala Kid", "koala"}, b.Name) and b:FindFirstChild("HumanoidRootPart") and not table.find(BL, b) then
          AddESP(b, "孩子", tostring(math.floor((LP.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).Magnitude)), AlienX["透视孩子"])
        end
      end
      if LP.Character:FindFirstChild("ToolHandle") then
        local tool = LP.Character.ToolHandle.OriginalItem.Value
        if tool then
          if AlienX["杀戮光环"] and Now - last1 >= 0.7 then
            last1 = Now
            if not ({["Old Axe"] = true, ["Good Axe"] = true, ["Spear"] = true, ["Hatchet"] = true, ["Bone Club"] = true})[tool.Name] then return end
            for a, b in next, workspace.Characters:GetChildren() do
              if b:IsA("Model") and b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("HitRegisters") then
                if (LP.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).Magnitude <= 100 then
                  game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(b, tool, true, LP.Character.HumanoidRootPart.CFrame)
                end
              end
            end
          end
          if AlienX["自动砍树"] and Now - last2 >= 0.7 then
            last2 = Now
            if not ({["Old Axe"] = true, ["Stone Axe"] = true, ["Iron Axe"] = true})[tool.Name] then return end
            local function ChopTree(Path)
              for a, b in next, Path:GetChildren() do
                task.wait(.1)
                if b:IsA("Model") and ({["Small Tree"] = true, ["TreeBig1"] = true, ["TreeBig2"] = true, ["TreeBig3"] = true})[b.Name] and b:FindFirstChild("HitRegisters") then
                  local trunk = b:FindFirstChild("Trunk") or b:FindFirstChild("HumanoidRootPart") or b.PrimaryPart
                  if trunk then
                    if (LP.Character.HumanoidRootPart.Position - trunk.Position).Magnitude <= 100 then
                      game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(b, tool, true, LP.Character.HumanoidRootPart.CFrame)
                    end
                  end
                end
              end
            end
            ChopTree(workspace.Map.Foliage)
            ChopTree(workspace.Map.Landmarks)
          end
        end
          if AlienX["自动进食"] and Now - last3 >= 10 then
            last3 = Now
            local HRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if HRP then
              local foundFood = false
              for _, obj in pairs(workspace.Items:GetChildren()) do
                if obj:IsA("Model") and ({["Carrot"] = true, ["Berry"] = true, ["Morsel"] = false, ["Cooked Morsel"] = true, ["Steak"] = false, ["Cooked Steak"] = true})[obj.Name] then
                  local mainPart = obj:FindFirstChild("Handle") or obj.PrimaryPart
                  if mainPart and (mainPart.Position - HRP.Position).Magnitude < 25 then
                    foundFood = true
                    tryEatFood(obj)
                    break
                  end
                end
              end
              if not foundFood then
                WindUI:Notify({Title = "AlienX", Content = "🔍25米范围内无食物", Duration = 5})
              end
             else
              WindUI:Notify({Title = "AlienX", Content = "⏳等待玩家加载", Duration = 5})
            end
          end
      end
      task.wait(.1)
    end)
   else
    LP:Kick("环境异常，请稍后再试")
  end
end)()
