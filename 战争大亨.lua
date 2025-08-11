local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./main/%E9%9C%96%E6%BA%BA%E8%84%9A%E6%9C%ACUI.lua"))()
local win = library:new("战争大亨")
local HomeTab = win:Tab("基础功能","17901200092")
local PlayerTab = win:Tab("其他功能","7743876054")
local TpTab = win:Tab("传送功能","7743876054")
local GunMod = win:Tab("变态功能","7733752575")
local section = HomeTab:section("基地", true)
local section2 = HomeTab:section("自瞄", true)
local section3 = PlayerTab:section("功能", true)
local section6 = TpTab:section("传送", true)
local section7 = TpTab:section("大亨", true)
local section4 = GunMod:section("步枪/手枪", true)
local section5 = GunMod:section("火箭筒", true)

local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer
local PlayerName = LocalPlayer.Name
local vim = game:service("VirtualInputManager")
local TycoonName 

for _, tycoon in pairs(game:GetService("Workspace").Tycoon.Tycoons:GetChildren()) do
    if tycoon:FindFirstChild("Owner") and tostring(tycoon.Owner.Value) == PlayerName then
        TycoonName = tycoon.Name 
        warn('// 找到玩家大亨 '.. TycoonName)
        break
    end
end

local PlayerTycoon = game:GetService("Workspace").Tycoon.Tycoons[TycoonName]
if not PlayerTycoon then
    warn("// 未能找到玩家大亨，请确保您加载并拥有大亨！")
    return
end

getgenv().ButtonPressAmmount = 1
getgenv().WaitBeforeCollect = 0
getgenv().WaitAfterCollect = 0.6
getgenv().IgnoreRebirthButtons = false

local partsToIgnore = {
    "Javelin Giver", "AWP Giver", "Auto Collect Gamepass", "2x Cash Gamepass",
    "2x Health Armor", "Speedy Oil Extractor", "FAMAS Group Gun", "GTE Shirt",
    "10k Shield Health Gamepass", "Speedy Humvee", "AbramsX Tank", "Barrett M82 Giver",
    "Boxer CRV Giver", "Camo Customizer Giver", "Desert Eagle Giver", "Tactical JLTV Giver",
    "WW2 US Army Pack Giver", "Mi24 Helicopter", "Explosive Sniper Giver", "FAL Heavy Giver",
    "Boxer CRV", 'JLTV', "M1117 Guardian", "M142 HIMARS", "Pantsir S1", "A-10 Air Strike Giver",
    "Gunship", "Lazar 3 APC", "Barrett M82", "KA-52 Alligator", "Mi24 Hind", "UH-60 Black Hawk",
    "KA-52 Alligator", "Eurocopter Tiger", "AH-64 Apache", "Boxer CRV", "JLTV", "SURC",
    "Vietnam River Boat", "KSG 12 Giver", "PP19 Bizon Giver"
}

local RebirthButtons = {
    "Boats [3 Rebirths]", "Drone [5 Rebirths]", "Helicopters [3 Rebirths]", "Planes [7 Rebirths]",
    "Tank Unlock Rebirth 6", "Vietnam Unlock Rebirth 4", "WW2 [4 Rebirths]", 
    "Missile Silo Start", "Easter Egg [10 Rebirths]"
}

getgenv().TPSpeed = 3
getgenv().TPWalk = false
local flySpeed = 69
local function isNumber(str)
  if tonumber(str) ~= nil or str == 'inf' then
    return true
  end
end

section3:Toggle("速度开关", "", false, function(s)
getgenv().TPWalk = s
local hb = game:GetService("RunService").Heartbeat
local player = game:GetService("Players")
local lplr = player.LocalPlayer
local chr = lplr.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
while getgenv().TPWalk and hb:Wait() and chr and hum and hum.Parent do
  if hum.MoveDirection.Magnitude > 0 then
    if getgenv().TPSpeed and isNumber(getgenv().TPSpeed) then
      chr:TranslateBy(hum.MoveDirection * tonumber(getgenv().TPSpeed))
    else
      chr:TranslateBy(hum.MoveDirection)
    end
  end
end
end)

pcall(function()
local Signal1, Signal2

function mobilefly(speed)
	local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
	local character = game.Players.LocalPlayer.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end

	local bv = Instance.new("BodyVelocity")
	bv.Name = "VelocityHandler"
	bv.Parent = character.HumanoidRootPart
	bv.MaxForce = Vector3.new(0, 0, 0)
	bv.Velocity = Vector3.new(0, 0, 0)

	local bg = Instance.new("BodyGyro")
	bg.Name = "GyroHandler"
	bg.Parent = character.HumanoidRootPart
	bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bg.P = 1000
	bg.D = 50

	Signal1 = game.Players.LocalPlayer.CharacterAdded:Connect(function(NewChar)
		local bv = Instance.new("BodyVelocity")
		bv.Name = "VelocityHandler"
		bv.Parent = NewChar:WaitForChild("HumanoidRootPart")
		bv.MaxForce = Vector3.new(0, 0, 0)
		bv.Velocity = Vector3.new(0, 0, 0)

		local bg = Instance.new("BodyGyro")
		bg.Name = "GyroHandler"
		bg.Parent = NewChar:WaitForChild("HumanoidRootPart")
		bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.P = 1000
		bg.D = 50
	end)

	local camera = game.Workspace.CurrentCamera

	Signal2 = game:GetService("RunService").RenderStepped:Connect(function()
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if character and hrp and hrp:FindFirstChild("VelocityHandler") and hrp:FindFirstChild("GyroHandler") then
			hrp.VelocityHandler.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			hrp.GyroHandler.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			character.Humanoid.PlatformStand = true

			hrp.GyroHandler.CFrame = camera.CFrame
			local direction = controlModule:GetMoveVector()
			hrp.VelocityHandler.Velocity = Vector3.new()
			if direction.X ~= 0 then
				hrp.VelocityHandler.Velocity = hrp.VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * speed)
			end
			if direction.Z ~= 0 then
				hrp.VelocityHandler.Velocity = hrp.VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * speed)
			end
		end
	end)
end

function unmobilefly()
	local character = game.Players.LocalPlayer.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		local hrp = character.HumanoidRootPart
		if hrp:FindFirstChild("VelocityHandler") then hrp.VelocityHandler:Destroy() end
		if hrp:FindFirstChild("GyroHandler") then hrp.GyroHandler:Destroy() end
		character.Humanoid.PlatformStand = false
	end
	if Signal1 then Signal1:Disconnect() end
	if Signal2 then Signal2:Disconnect() end
end

function toggleFly(enable)
	if enable then
		mobilefly(100) 
	else
		unmobilefly()
	end
end
end)

section3:Toggle("飞行开关", "", false, function(bak)
	getgenv().fly = bak
	toggleFly(getgenv().fly)
end)

section:Toggle("自动刷钱", "", false, function(state)
    getgenv().auto = state
end)

section:Toggle("自动购买", "", false, function(asteca)
getgenv().autoTeleport = asteca
end)

section2:Toggle("子弹追踪", "", false, function(state)
    getgenv().SilentAimEnabled = state
end)

section2:Toggle("目标射线", "", false, function(state)
    getgenv().TracerESPEnabled = state
end)

section3:Toggle("自动闪光（直升机)", "", false, function(state)
local pl = {}
pl.rs = game:GetService("ReplicatedStorage")
pl.ws = game:GetService("Workspace")

    getgenv().toggle = state
    
    if getgenv().toggle then
        task.spawn(function()
            while getgenv().toggle do
                for _, nig in pairs(pl.ws:WaitForChild("Game Systems"):WaitForChild("Helicopter Workspace"):GetChildren()) do
                    if nig:IsA("Model") and nig:FindFirstChild("Misc") then
                        local fl = nig:FindFirstChild("Misc"):FindFirstChild("Turrets"):FindFirstChild("AH Weapons"):FindFirstChild("Flares")
                        local sp = nig:FindFirstChild("Misc"):FindFirstChild("Turrets"):FindFirstChild("SoundPart")
                        if fl and sp then
                            local args = {fl, nig, sp}
                            pl.rs:WaitForChild("RocketSystem"):WaitForChild("Events"):WaitForChild("FireFlare"):FireServer(unpack(args))
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

section3:Toggle("删除死亡镜头", "", false, function(kan)
getgenv().KillCamSkipEnabled = kan

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KillCamSkipEvent = ReplicatedStorage.Remotes:WaitForChild("KillCamSkipEvent")

local function startKillCamSkip()
    while getgenv().KillCamSkipEnabled do
        KillCamSkipEvent:FireServer()
        task.wait(0.4) 
    end
end

task.spawn(function()
    while true do
        if getgenv().KillCamSkipEnabled then
            startKillCamSkip()
        end
        task.wait(0.1)
    end
end)
end)

section3:Toggle("机枪防损坏", "", false, function(state)
getgenv().BlockCRAMHits = state

local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("BulletFireSystem"):WaitForChild("RegisterTurretHit")

local function isOwnVehicle(hitPart)
    if not hitPart then return false end

    local vehicleWorkspace = workspace:FindFirstChild("Game Systems"):FindFirstChild("Helicopter Workspace")
    if vehicleWorkspace and hitPart:IsDescendantOf(vehicleWorkspace) then
        return true
    end
    return false
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if getgenv().BlockCRAMHits and method == "FireServer" and self == remote then
        local turretPart = args[1] 
        local hitData = args[4] 
        local hitPart = hitData and hitData["hitPart"]
        if turretPart and tostring(turretPart):find("CRAM") and isOwnVehicle(hitPart) then
            return nil
        end
    end
    return oldNamecall(self, ...)
end))
end)

section6:Dropdown("基地传送", "", {"Alpha","Bravo","Charlie","Delta","Echo", "Foxtrot", "Golf","Hotel","Kilo", "Lima", "Omega", "Romeo","Sierra","Tango","Victor","Zulu"}, false, function(Value)
    game:GetService("Players").LocalPlayer.Character:MoveTo(workspace.Tycoon.TycoonFloor[Value].Position)
end)

section6:Button("传送自己的基地", function()
    game:GetService("Players").LocalPlayer.Character:MoveTo(workspace.Tycoon.Tycoons[game:GetService("Players").LocalPlayer.leaderstats.Team.Value].Essentials.Spawn.Position)
end)

section6:Button("传送旗帜", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Game Systems"].CapturePoint.Neon.CFrame
end)

section6:Button("传送油桶1", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Game Systems"].Warehouses["Dock Warehouse1"]["Oil Capture"]["Barrel Template"].PromptPart.CFrame
end)

section6:Button("传送油桶2", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Game Systems"].Warehouses["Oil Rig1"]["Oil Capture"]["Barrel Template"].PromptPart.CFrame
end)

section6:Button("传送油桶3", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Game Systems"].Warehouses["Oil Rig2"]["Oil Capture"]["Barrel Template"].PromptPart.CFrame
end)

section6:Button("传送油桶4", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Game Systems"].Warehouses["Oil Rig3"]["Oil Capture"]["Barrel Template"].PromptPart.CFrame
end)

section6:Button("自动开空投", function()
    for _,v in next,workspace["Game Systems"]:GetChildren() do
        if v.Name:find("Airdrop_") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.MainPart.CFrame
            fireproximityprompt(v.MainPart.AirDropPrompt)
        end
    end
end)

section7:Toggle("自动收集金钱", "", false, function(value)
    getgenv().autoCollect = value
    while getgenv().autoCollect and task.wait(1) do
        local cashCollectorPos = PlayerTycoon.Essentials.CashCollector.CFrame.Position + Vector3.new(0, 5, 0)
        local cashCollector2Pos = PlayerTycoon.Essentials.CashCollector2.CFrame.Position + Vector3.new(0, 5, 0)
        
        if PlayerTycoon.PurchasedObjects:FindFirstChild("Oil Drill 1") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cashCollectorPos)
            task.wait(0.5)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cashCollector2Pos)
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cashCollectorPos)
        end
    end
end)

section7:Toggle("自动建造", "", false, function(value)
    getgenv().AutoPlay = value
    while getgenv().AutoPlay do task.wait()
        if PlayerTycoon.CurrencyToCollect.Value == 0 then
            local oilDrill = PlayerTycoon.PurchasedObjects:FindFirstChild("Oil 1")
            if oilDrill and oilDrill:FindFirstChild("PromptDisplay") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(oilDrill.PromptDisplay.CFrame.Position)
                task.wait(0.5)
                vim:SendKeyEvent(true, 'E', false, game)
                task.wait(0.5)
                vim:SendKeyEvent(false, 'E', false, game)
            end
            task.wait(3)
        else
            task.wait(getgenv().WaitBeforeCollect)
            
            local cashCollectorPos = PlayerTycoon.Essentials.CashCollector.CFrame.Position + Vector3.new(0, 5, 0)
            if PlayerTycoon.PurchasedObjects:FindFirstChild("Oil Drill 1") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cashCollectorPos)
                task.wait(0.5)
                cashCollectorPos = PlayerTycoon.Essentials.CashCollector2.CFrame.Position + Vector3.new(0, 5, 0)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cashCollectorPos)
            else
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cashCollectorPos)
            end

            for i = 1, getgenv().ButtonPressAmmount do
                task.wait(0.5)
                local availableButtons = {}
                
                for _, model in pairs(PlayerTycoon.UnpurchasedButtons:GetChildren()) do
                    if model:IsA("Model") then
                        local part = model:FindFirstChild("Part")
                        if part then
                            local skip = false
                            
                            for _, name in pairs(partsToIgnore) do
                                if model.Name == name then
                                    skip = true
                                    break
                                end
                            end
                         
                            if not skip and getgenv().IgnoreRebirthButtons then
                                for _, rbName in pairs(RebirthButtons) do
                                    if model.Name == rbName then
                                        skip = true
                                        break
                                    end
                                end
                            end
                            
                            if not skip then
                                table.insert(availableButtons, part)
                            end
                        end
                    end
                end
                
                if #availableButtons > 0 then
                    local part = availableButtons[math.random(1, #availableButtons)]
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
                end
            end
            task.wait(getgenv().WaitAfterCollect)
        end
    end
end)



section5:Toggle("杀戮光环", "", false, function(state)
getgenv().nk = state
end)

section5:Textbox("杀戮范围", "", "请输入", function(s)
getgenv().max = tonumber(num) or 2000
end)

section5:Toggle("攻击盾牌", "", false, function(state)
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local ps = game:GetService("Players")
local lp = ps.LocalPlayer

getgenv().nukeShield = true
getgenv().shieldRadius = 1000

local function getLocalTycoon()
    local tycoonFolder = ws:FindFirstChild("Tycoon").Tycoons
    for _, tycoon in ipairs(tycoonFolder:GetChildren()) do
        local owner = tycoon:FindFirstChild("Owner")
        if owner and owner.Value == lp.Name then
            return tycoon
        end
    end
    return nil
end

local function getClosestShield()
    local closestShield = nil
    local shortestDistance = math.huge
    local localTycoon = getLocalTycoon()

    for _, tycoon in ipairs(ws.Tycoon.Tycoons:GetChildren()) do
        if tycoon ~= localTycoon then
            local shieldModel = tycoon.PurchasedObjects:FindFirstChild("Base Shield")
            if shieldModel and shieldModel:FindFirstChild("Shield") then
                for _, part in ipairs(shieldModel.Shield:GetChildren()) do
                    if part:IsA("BasePart") then
                        local distance = (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude
                        if distance <= getgenv().shieldRadius and distance < shortestDistance then
                            closestShield = part
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end

    return closestShield
end

local function fireAtShield(shieldPart)
    if shieldPart then
        local fireRocketArgs = {
            [1] = (shieldPart.Position - lp.Character.HumanoidRootPart.Position).Unit,
            [2] = lp.Character:FindFirstChild("RPG"),
            [3] = lp.Character:FindFirstChild("RPG"),
            [4] = shieldPart.Position
        }
        rs.RocketSystem.Events.FireRocket:InvokeServer(unpack(fireRocketArgs))

        local rocketHitArgs = {
            [1] = shieldPart.Position,
            [2] = (shieldPart.Position - lp.Character.HumanoidRootPart.Position).Unit,
            [3] = lp.Character:FindFirstChild("RPG"),
            [4] = lp.Character:FindFirstChild("RPG"),
            [5] = shieldPart,
            [7] = tostring(lp.Name) .. "Rocket1"
        }
        rs.RocketSystem.Events.RocketHit:FireServer(unpack(rocketHitArgs))
    end
end

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().nukeShield then
            local targetShield = getClosestShield()
            if targetShield then
                fireAtShield(targetShield)
            end
        end
    end
end)
end)

pcall(function()
local rs = game:GetService("ReplicatedStorage")
local ps = game:GetService("Players")
local lp = ps.LocalPlayer
local ws = game:GetService("Workspace")
local rk = rs.RocketSystem.Events.FireRocket
local eh = rs.RocketSystem.Events.RocketHit
local cam = ws.CurrentCamera

getgenv().nk = false
getgenv().wc = false
getgenv().max = 2000

local function isRPGEqipped()
    return lp.Character and lp.Character:FindFirstChild("RPG") ~= nil
end

local function getClosestPlayer()
    local closestPlayer, shortestDistance = nil, math.huge
    for _, player in ipairs(ps:GetPlayers()) do
        if player ~= lp and player.Character then
            local targetPart = player.Character:FindFirstChild("Torso") 
                or player.Character:FindFirstChild("Head") 
                or player.Character:FindFirstChild("UpperTorso") 
                or player.Character:FindFirstChild("LowerTorso")
            if targetPart then
                local screenPos = cam:WorldToViewportPoint(targetPart.Position)
                local distanceToCenter = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude
                local distanceToPlayer = (lp.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude

                if distanceToCenter < shortestDistance and distanceToPlayer <= getgenv().max then
                    if not getgenv().wc or not ws:FindPartOnRayWithIgnoreList(Ray.new(lp.Character.HumanoidRootPart.Position, (targetPart.Position - lp.Character.HumanoidRootPart.Position).Unit * getgenv().max), {lp.Character}) then
                        closestPlayer = player
                        shortestDistance = distanceToCenter
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function fireAtClosestPlayer()
    if not isRPGEqipped() then return end

    local rpg = lp.Character:FindFirstChild("RPG")
    local closestPlayer = getClosestPlayer()

    if closestPlayer and closestPlayer.Character then
        local targetPart = closestPlayer.Character:FindFirstChild("Torso") 
            or closestPlayer.Character:FindFirstChild("Head") 
            or closestPlayer.Character:FindFirstChild("UpperTorso") 
            or closestPlayer.Character:FindFirstChild("LowerTorso")
        if targetPart then
            local targetPosition = targetPart.Position

            local fireArgs = {
                [1] = (targetPosition - lp.Character.HumanoidRootPart.Position).Unit,
                [2] = rpg,
                [3] = rpg,
                [4] = targetPosition
            }
            rk:InvokeServer(unpack(fireArgs))

            local hitArgs = {
                [1] = targetPosition,
                [2] = (targetPosition - lp.Character.HumanoidRootPart.Position).Unit,
                [3] = rpg,
                [4] = rpg,
                [5] = targetPart,
                [7] = tostring(lp.Name) .. "Rocket1"
            }
            eh:FireServer(unpack(hitArgs))
        end
    end
end

task.spawn(function()
    while task.wait(0.01) do
        if getgenv().nk then
            fireAtClosestPlayer()
        end
    end
end)
end)

pcall(function()
getgenv().SilentAimEnabled = false
getgenv().FOVEnabled = false
getgenv().TracerESPEnabled = false
getgenv().Wallbang = true
getgenv().ignorefriends = false
getgenv().FOVSize = 80

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("BulletFireSystem"):WaitForChild("BulletHit")

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Transparency = 1
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.Radius = getgenv().FOVSize
FOVCircle.Color = Color3.fromRGB(255, 0, 0)

local function updateFOVCircle()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end

-- Tracer ESP
local Tracer = Drawing.new("Line")
Tracer.Thickness = 2
Tracer.Color = Color3.fromRGB(255, 255, 255)
Tracer.Transparency = 1
Tracer.Visible = false

local function updateTracer(target)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local headPos, onScreen = Camera:WorldToViewportPoint(target.Character.Head.Position)
        Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        Tracer.To = Vector2.new(headPos.X, headPos.Y)
        Tracer.Visible = onScreen
    else
        Tracer.Visible = false
    end
end

-- Verificare dacă un jucător este prieten
local function isFriend(player)
    local success, result = pcall(function()
        return LocalPlayer:IsFriendsWith(player.UserId)
    end)
    return success and result
end

-- Găsire jucător țintă
local function GetTargetPlayer()
    local closestPlayer, shortestDistance = nil, math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            if getgenv().ignorefriends and isFriend(player) then
                continue
            end

            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            local distance = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude

            if (not getgenv().FOVEnabled or distance <= getgenv().FOVSize) and distance < shortestDistance then
                closestPlayer = player
                shortestDistance = distance
            end
        end
    end

    return closestPlayer
end

-- Hook metamethod exact cum ai cerut
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if getgenv().SilentAimEnabled and method == "FireServer" and self == Remote then
        local target = GetTargetPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local targetHead = target.Character.Head
            args[2] = targetHead
            args[3] = targetHead.Position

            if getgenv().Wallbang then
                args[4].hitPart = targetHead
                args[4].normal = Vector3.new(0, 1, 0)
            elseif not getgenv().Wallbang and args[4].hitPart ~= targetHead then
                return oldNamecall(self, ...)
            end

            setnamecallmethod(method)
            return oldNamecall(self, unpack(args))
        end
    end

    return oldNamecall(self, ...)
end))

-- Actualizare și afișare FOV și Tracer ESP
RunService.RenderStepped:Connect(function()
    if getgenv().FOVEnabled then
        FOVCircle.Radius = getgenv().FOVSize
        updateFOVCircle()
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    if getgenv().TracerESPEnabled then
        updateTracer(GetTargetPlayer())
    else
        Tracer.Visible = false
    end
end)
end)

pcall(function()
getgenv().autoTeleport = false 
local function getDistance(objectPosition)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local playerPosition = player.Character.HumanoidRootPart.Position
        return (objectPosition - playerPosition).Magnitude
    end
    return math.huge
end

local function getClosestNeon()
    local player = game.Players.LocalPlayer
    local teamName = player.Team.Name
    local buttonsFolder = workspace.Tycoon.Tycoons:FindFirstChild(teamName).UnpurchasedButtons

    if buttonsFolder then
        local closestNeon = nil
        local closestDistance = math.huge 

        for _, button in pairs(buttonsFolder:GetChildren()) do
            if not button:FindFirstChild("Mission") then
                local neon = button:FindFirstChild("Neon")
                local price = button:FindFirstChild("Price")

                if neon and price and price.Value ~= 0 then
                    local distance = getDistance(neon.Position)
                    if distance < closestDistance then
                        closestNeon = neon
                        closestDistance = distance
                    end
                end
            end
        end

        return closestNeon
    end

    return nil
end

local function teleportToClosestNeon()
    local player = game.Players.LocalPlayer

    while getgenv().autoTeleport do
        wait(0.2) 

        local closestNeon = getClosestNeon()

        if closestNeon then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(closestNeon.Position)
            end
        else
            warn("no neon found")
        end
    end
end

local function checkTeleportToggle()
    while true do
        wait(0.5)
        if getgenv().autoTeleport then
            teleportToClosestNeon()
        end
    end
end

spawn(checkTeleportToggle)
end)

pcall(function()
local ps = game:GetService("Players")
local ws = game:GetService("Workspace")
local ts = game:GetService("TweenService")
local rs = game:GetService("ReplicatedStorage")

local lp = ps.LocalPlayer
local crateRemote = rs.TankCrates.WeldCrate
local hrp
getgenv().auto = false
local currentCrate -- Crate-ul curent urmărit

local function setupCharacter()
    if lp.Character then
        hrp = lp.Character:WaitForChild("HumanoidRootPart")
    end
end

setupCharacter()
lp.CharacterAdded:Connect(function()
    setupCharacter()
    if getgenv().auto then
        task.wait(1)
        task.spawn(autofarmLoop)
    end
end)

local function tp(target)
    if not getgenv().auto or not target then return end
    local cf = typeof(target) == "CFrame" and target or target.CFrame
    local success, result = pcall(function()
        local tw = ts:Create(hrp, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {CFrame = cf + Vector3.new(3, 0, 0)})
        tw:Play()
        tw.Completed:Wait()
    end)
    if not success then
        warn("Teleport failed: ", result)
    end
end

local function firePrompt(prompt, crate)
    if prompt then
        prompt.MaxActivationDistance = 10
        fireproximityprompt(prompt, 1)
        task.wait(0.2)
        if crate and crateRemote then
            pcall(function()
                crateRemote:InvokeServer(crate)
            end)
        end
    end
end

local function findCrate()
    local crates = ws["Game Systems"]["Crate Workspace"]:GetChildren()
    for _, c in ipairs(crates) do
        if c:GetAttribute("Owner") ~= lp.Name then
            return c
        end
    end
    return nil
end

local function holdingCrate()
    local crates = ws["Game Systems"]["Crate Workspace"]:GetChildren()
    for _, c in ipairs(crates) do
        if c:GetAttribute("Holding") == lp.Name then
            return c
        end
    end
    return nil
end

local function getTycoon()
    local leaderstats = lp:FindFirstChild("leaderstats")
    if leaderstats then
        local team = leaderstats:FindFirstChild("Team")
        if team and team.Value then
            return ws.Tycoon.Tycoons:FindFirstChild(team.Value)
        end
    end
    return nil
end

local function getFloorOrigin(tycoon)
    if tycoon and tycoon:FindFirstChild("Floor") and tycoon.Floor:FindFirstChild("FloorOrigin") then
        return tycoon.Floor.FloorOrigin.CFrame
    end
    return nil
end

local function sellCrate(tycoon)
    local cratePromptPart = tycoon and tycoon:FindFirstChild("Essentials") and tycoon.Essentials:FindFirstChild("Oil Collector") and tycoon.Essentials["Oil Collector"]:FindFirstChild("CratePromptPart")
    if cratePromptPart and cratePromptPart:IsDescendantOf(ws) then
        tp(cratePromptPart)
        task.wait(0.5)
        local sellPrompt = cratePromptPart:FindFirstChild("SellPrompt")
        if sellPrompt then
            firePrompt(sellPrompt)
            task.wait(0.5)
            return true
        end
    else
        local floorOrigin = getFloorOrigin(tycoon)
        if floorOrigin then
            tp(floorOrigin)
            task.wait(1)
            tp(cratePromptPart)
        end
    end
    return false
end

function autofarmLoop()
    while task.wait(0.1) do
        if getgenv().auto then
            local tycoon = getTycoon()
            if not tycoon then continue end

            if currentCrate and currentCrate.Parent == nil then
                currentCrate = nil -- Crate-ul a fost vândut
            end

            if not currentCrate then
                local nextCrate = findCrate()
                if nextCrate then
                    currentCrate = nextCrate
                    tp(nextCrate)
                    task.wait(0.3)
                    local prompt = nextCrate:FindFirstChild("StealPrompt")
                    if prompt then
                        firePrompt(prompt, nextCrate)
                    end
                else
                    local randomTycoon = ws.Tycoon.Tycoons:GetChildren()[math.random(1, #ws.Tycoon.Tycoons:GetChildren())]
                    local floorOrigin = getFloorOrigin(randomTycoon)
                    if floorOrigin then
                        tp(floorOrigin)
                        task.wait(2)
                    end
                end
            else
                local sold = sellCrate(tycoon)
                if sold then
                    currentCrate = nil -- Crate-ul a fost vândut
                end
            end
        end
    end
end

task.spawn(autofarmLoop)
end)