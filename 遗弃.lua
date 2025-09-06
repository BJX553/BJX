local KeySystem
local Frame
local TextBox
local UICorner
local UIPadding
local UICorner_2
local TextLabel
local CheckKeyButton
local UICorner_3
local GetKey
local UICorner_4

local function FartHubLoad()
	local Players = game:GetService("Players")
	local SoundService = game:GetService("SoundService")
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local VIM = game:GetService("VirtualInputManager")
	local BlockRemote = game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")
	local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

	local DebugNotifications = getgenv and getgenv().DebugNotifications or false
	local SigmaData, JoinedSigmaServer = {}, false
	local pizzaConnections = {}
	local PlayerTab, VisualsTab, GeneratorTab, BlatantTab, MiscTab = nil, nil, nil, nil, nil
	local BabyShark, KillerFartPart, HRP = nil, nil, nil
	local SkibidiDistance, BlockEnabled, AimLockTimer = 6, false, 2

	local executorname = (pcall(getexecutorname) and getexecutorname())
		or (pcall(identifyexecutor) and identifyexecutor())
		or "Unknown"
	local supportedExecutors = { AWP = true, Wave = true, Nihon = true, ["Synapse Z"] = true, Swift = true }

	local SoundList = {
		"rbxassetid://112809109188560",
		"rbxassetid://101199185291628",
		"rbxassetid://102228729296384",
		"rbxassetid://140242176732868",
	}

	local CurrentFartsActive, NameProtectNames, aimbotActive = {}, {}, false
	local WowWhatTheZestIsThis

	local fart = {
		aimbot = {},
		abilities = {},
		characterChange = nil,
	}

	local SkibidiPomniOhioList = {
		Killers = {
			Jason = { Duration1 = 0.5 },
			["1x1x1x1"] = { Duration1 = 0.5, Duration2 = 2.5, Duration3 = 1 },
			JohnDoe = { Duration1 = 0.5, Duration2 = 5 },
			C00lkidd = { Duration1 = 0.5 },
		},
		Survivors = {
			Guest1337 = { Duration2 = 2 },
			Chance = { Duration2 = 2 },
		},
	}

	local GUI = Mercury:Create({
		Name = "FartSaken",
		Size = UDim2.fromOffset(600, 400),
		Theme = Mercury.Themes.Dark,
		Link = "https://github.com/ivannetta/ShitScripts/Forsaken",
	})

	local function GetCharAndFold()
		local Me = game.Players.LocalPlayer
		if not Me or not Me.Character then
			return nil, nil
		end
		return Me.Character.Name, Me.Character.Parent.Name
	end

	local function JanitorModeEnabled(oklolloolloololololol)
		for _, connection in pairs(oklolloolloololololol) do
			if connection and connection.Connected then
				connection:Disconnect()
			end
		end
		table.clear(oklolloolloololololol)
	end

	local function Aimbot(Dur)
		if not Dur then
			return
		end
		local Char, CharacterGender = GetCharAndFold()
		if not Char or not CharacterGender then
			return
		end

		local Me = game.Players.LocalPlayer
		local MeButCharacter = Me.Character
		if not MeButCharacter or not MeButCharacter:FindFirstChild("HumanoidRootPart") then
			return
		end

		local HornyFolder = workspace:FindFirstChild("Players")
			and workspace.Players:FindFirstChild(CharacterGender == "Killers" and "Survivors" or "Killers")
		if not HornyFolder then
			return
		end

		local function FindClosestPerson()
			local ClosestTarget, ClosestDistance = nil, math.huge
			local MyPosition = MeButCharacter.HumanoidRootPart.Position

			for _, v in pairs(HornyFolder:GetChildren()) do
				if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
					local distance = (v.HumanoidRootPart.Position - MyPosition).Magnitude
					if distance < ClosestDistance then
						ClosestDistance = distance
						ClosestTarget = v
					end
				end
			end
			return ClosestTarget
		end

		task.spawn(function()
			local startTime = tick()
			while tick() - startTime < Dur do
				local target = FindClosestPerson()
				if target and target:FindFirstChild("HumanoidRootPart") then
					local wawa = MeButCharacter.HumanoidRootPart
					local wawaza = target.HumanoidRootPart.Position
					local MathematicalCalculations = (wawaza - wawa.Position).unit
					wawa.CFrame = CFrame.new(
						wawa.Position,
						wawa.Position + Vector3.new(MathematicalCalculations.X, 0, MathematicalCalculations.Z)
					)
					--local Cumera = game.Workspace.CurrentCamera
					--Cumera.CFrame = CFrame.lookAt(Cumera.CFrame.Position, Cumera.CFrame.Position + Vector3.new(MathematicalCalculations.X, MathematicalCalculations.Y, MathematicalCalculations.Z))
				end
				task.wait()
			end
		end)
	end

	local function WatchForPizza(state)
		if not state then
			for _, connection in ipairs(pizzaConnections) do
				connection:Disconnect()
			end
			table.clear(pizzaConnections)
			return
		end

		local function onChildAdded(child)
			if child.Name == "Pizza" then
				local player = game.Players.LocalPlayer
				local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					child.CFrame = hrp.CFrame
				end
			end
		end

		local function watchFolder()
			local ingameFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
			if ingameFolder then
				table.insert(pizzaConnections, ingameFolder.ChildAdded:Connect(onChildAdded))
			else
				table.insert(
					pizzaConnections,
					workspace.ChildAdded:Connect(function(child)
						if child.Name == "Map" then
							table.insert(
								pizzaConnections,
								child.ChildAdded:Connect(function(subChild)
									if subChild.Name == "Ingame" then
										table.insert(pizzaConnections, subChild.ChildAdded:Connect(onChildAdded))
									end
								end)
							)
						end
					end)
				)
			end
		end

		watchFolder()
	end

	local function HandleFartContainer(LKFVJNWEFLKJWNEFLKJWNEF)
		local Me = game.Players.LocalPlayer
		local LastSkibidi, LastSkebede = GetCharAndFold()

		if fart.characterChange then
			fart.characterChange:Disconnect()
		end

		fart.characterChange = Me:GetPropertyChangedSignal("Character"):Connect(function()
			task.wait(0.1)
			local newCharacter, newTeam = GetCharAndFold()

			if newCharacter ~= LastSkibidi or newTeam ~= LastSkebede then
				LastSkibidi, LastSkebede = newCharacter, newTeam
				JanitorModeEnabled(fart.abilities)
				HandleFartContainer(true)
			end
		end)

		if not LKFVJNWEFLKJWNEFLKJWNEF then
			JanitorModeEnabled(fart.abilities)
			return
		end

		local AbilityContainer =
			game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI"):WaitForChild("AbilityContainer")

		local function EvilEmoji(lol)
			local CharacterGender, Wowzaer = GetCharAndFold()
			if not SkibidiPomniOhioList[Wowzaer] or not SkibidiPomniOhioList[Wowzaer][CharacterGender] then
				return
			end

			local sigmaboy = lol.LayoutOrder
			local DDDDDDDurationm = "Duration" .. sigmaboy
			local VeryLongDuration = SkibidiPomniOhioList[Wowzaer][CharacterGender][DDDDDDDurationm]

			if VeryLongDuration then
				local IsSkibidiToiletMode = false
				local CONNECTOR
				if CharacterGender ~= "Chance" then
					CONNECTOR = lol.CooldownTime:GetPropertyChangedSignal("Text"):Connect(function()
						if not IsSkibidiToiletMode and lol.CooldownTime.Text ~= "" then
							IsSkibidiToiletMode = true
							task.spawn(Aimbot, VeryLongDuration)

							task.spawn(function()
								repeat
									task.wait()
								until lol.CooldownTime.Text == ""
								task.wait(0.1)
								IsSkibidiToiletMode = false
							end)
						end
					end)
					table.insert(fart.abilities, CONNECTOR)
				end
			end

			local function onFlintlockTransparencyChange()
				local Flintlock = Players.LocalPlayer.Character:FindFirstChild("FlintlockGun")
					or Players.LocalPlayer.Character:FindFirstChild("Flintlock")
				if Flintlock then
					local function checkTransparency()
						if Flintlock.Transparency == 0 then
							task.spawn(Aimbot, VeryLongDuration)
						end
					end
					table.insert(
						fart.abilities,
						Flintlock:GetPropertyChangedSignal("Transparency"):Connect(checkTransparency)
					)
					checkTransparency()
				end
			end

			onFlintlockTransparencyChange()
		end

		for _, blahblahblah in ipairs(AbilityContainer:GetChildren()) do
			if blahblahblah:IsA("Frame") and blahblahblah:FindFirstChild("CooldownTime") then
				EvilEmoji(blahblahblah)
			end
		end

		for _, grrrrrr in pairs(AbilityContainer:GetChildren()) do
			if (grrrrrr:IsA("TextButton") or grrrrrr:IsA("ImageButton")) and grrrrrr:FindFirstChild("CooldownTime") then
				EvilEmoji(grrrrrr)
			end
		end

		table.insert(
			fart.abilities,
			AbilityContainer.ChildAdded:Connect(function(child)
				if (child:IsA("TextButton") or child:IsA("ImageButton")) and child:FindFirstChild("CooldownTime") then
					EvilEmoji(child)
				end
			end)
		)
	end

	local function GetAssetList()
		local url = "https://api.github.com/repos/ivannetta/ShitScripts/git/trees/main?recursive=1"
		local assetList = {}

		local success, errorMessage = pcall(function()
			local Request = http_request or syn.request or request
			if Request then
				local response = Request({
					Url = url,
					Method = "GET",
					Headers = { ["Content-Type"] = "application/json" },
				})

				if response and response.Body then
					local data = game:GetService("HttpService"):JSONDecode(response.Body)
					for _, item in ipairs(data.tree) do
						if item.path:match("^Assets/.+%.png$") or item.path:match("^Assets/.+%.mp4$") then
							local rawUrl = "https://raw.githubusercontent.com/ivannetta/ShitScripts/main/" .. item.path
							table.insert(assetList, rawUrl)

							local name = item.path:match("Assets/(.+)%.png$") or item.path:match("Assets/(.+)%.mp4$")
							if name then
								table.insert(NameProtectNames, name)
							end
						end
					end
				end
			end
		end)

		if not success then
			GUI:Notification({ Title = "An error occurred", Text = errorMessage, Duration = 5 })
		end
		return assetList
	end

	local function DownloadBallers(url, path)
		if not isfile(path) then
			local suc, res = pcall(function()
				return game:HttpGet(url, true)
			end)
			if not suc or res == "404: Not Found" then
				GUI:Notification({ Title = "Error", Text = res, Duration = 5 })
			end
			writefile(path, res)
		end
	end

	local function CheckIfFartsDownloaded()
		local assetList = GetAssetList()
		local basePath = "FartHub/Assets/"

		if not isfolder("FartHub") then
			makefolder("FartHub")
		end

		if not isfolder(basePath) then
			makefolder(basePath)
		end

		for _, url in ipairs(assetList) do
			local filePath = basePath .. url:match("Assets/(.+)")
			local newFilePath = filePath:gsub("%.png$", ".png.Fart"):gsub("%.mp4$", ".mp4.Fart4")

			if not isfile(newFilePath) then
				DownloadBallers(url, newFilePath)
				task.wait(0.1)
				GUI:Notification({ Title = "Downloaded", Text = newFilePath, Duration = 3 })
			end
		end
	end

	local function LoadAsset(assetName)
		local basePath = "FartHub/Assets/"
		local assetPath = basePath .. assetName

		if isfile(assetPath) then
			return getcustomasset(assetPath)
		else
			return nil
		end
	end

	local function ToggleFatMan(state)
		if state then
			WowWhatTheZestIsThis = Instance.new("ScreenGui", game:GetService("CoreGui"))
			WowWhatTheZestIsThis.Name = "FatMan"
			WowWhatTheZestIsThis.ResetOnSpawn = false
			WowWhatTheZestIsThis.DisplayOrder = 999999999

			local Frame = Instance.new("Frame", WowWhatTheZestIsThis)
			Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame.BackgroundTransparency = 1.000
			Frame.AnchorPoint = Vector2.new(1, 0.5)
			Frame.Name = "YAPPING"
			Frame.Position = UDim2.new(1, 0, 0.5, 0)
			Frame.Size = UDim2.new(0, 150, 0, 150)

			local VideoFrame = Instance.new("VideoFrame", Frame)
			VideoFrame.Size = UDim2.new(1, 0, 1, 0)
			VideoFrame.Video = LoadAsset("FatMan.mp4.Fart4")
			VideoFrame.Looped = true
			VideoFrame.Playing = true
		else
			WowWhatTheZestIsThis:Destroy()
		end
	end

	local function NameProtect(state)
		local function updateNames()
			local CurrentSurvivors = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
				and game:GetService("Players").LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("PlayerInfo")
				and game:GetService("Players").LocalPlayer.PlayerGui.TemporaryUI.PlayerInfo
					:FindFirstChild("CurrentSurvivors")
			if CurrentSurvivors then
				local indices = {}
				for index in pairs(NameProtectNames) do
					table.insert(indices, index)
				end
				for i = #indices, 2, -1 do
					local j = math.random(i)
					indices[i], indices[j] = indices[j], indices[i]
				end
				for _, People in pairs(CurrentSurvivors:GetChildren()) do
					if People:IsA("Frame") then
						local name
						local success = false
						repeat
							name = NameProtectNames[indices[math.random(#indices)]]
							local asset = LoadAsset(name .. ".png.Fart")
							if asset then
								People.Icon.Image = asset
								success = true
							end
						until success
						People.Username.Text = name
					end
				end
			end
		end

		if state then
			local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
			local function setupConnections()
				local TemporaryUI = PlayerGui:WaitForChild("TemporaryUI", math.huge)
				local PlayerInfo = TemporaryUI:WaitForChild("PlayerInfo", math.huge)

				PlayerGui.ChildAdded:Connect(function(child)
					if child.Name == "TemporaryUI" then
						updateNames()
					end
				end)
				TemporaryUI.ChildAdded:Connect(function(child)
					if child.Name == "PlayerInfo" then
						updateNames()
					end
				end)
				PlayerInfo.ChildAdded:Connect(function(child)
					if child.Name == "CurrentSurvivors" then
						updateNames()
					end
				end)
			end

			setupConnections()
			updateNames()

			if PlayerGui.MainUI.PlayerListHolder then
				PlayerGui.MainUI.PlayerListHolder:Destroy()
			end
			if PlayerGui.MainUI.Spectate.Username then
				PlayerGui.MainUI.Spectate.Username.Visible = false
			end
		end
	end

	GUI:Notification({
		Title = supportedExecutors[executorname] and "Executor Supported" or "Executor Not Supported",
		Text = supportedExecutors[executorname] and "No Errors Expected" or "Errors Expected",
		Duration = 5,
	})

	local highlightingEnabled, SkibidiStaminaLoop, running, ItemFartsEnabled, Do1x1PopupsLoop, SkibidiWait, LopticaWaitTime =
		false, false, false, false, false, 0.1, 0.5
	local generatorHighlightColor, survivorHighlightColor, killerHighlightColor, itemHighlightColor =
		Color3.fromRGB(173, 162, 236),
		Color3.fromRGB(0, 255, 255),
		Color3.fromRGB(255, 100, 100),
		Color3.fromRGB(255, 255, 0)

	local Items = { "Medkit", "BloxyCola" }

	local function LoadSigmaData()
		pcall(function()
			local HttpService = game:GetService("HttpService")
			local data = HttpService:JSONDecode(readfile("FartHub.json"))
			generatorHighlightColor = data.ColorOptions.Generator and Color3.fromHex(data.ColorOptions.Generator)
				or Color3.fromRGB(255, 0, 0)
			survivorHighlightColor = data.ColorOptions.Survivor and Color3.fromHex(data.ColorOptions.Survivor)
				or Color3.fromRGB(0, 255, 0)
			killerHighlightColor = data.ColorOptions.Killer and Color3.fromHex(data.ColorOptions.Killer)
				or Color3.fromRGB(0, 0, 255)
			itemHighlightColor = data.ColorOptions.Item and Color3.fromHex(data.ColorOptions.Item)
				or Color3.fromRGB(255, 255, 0)
			JoinedSigmaServer = data.Info.JoinedSigmaServer or false
			SigmaData = data
		end)
	end

	local function WriteSigmaData()
		local HttpService = game:GetService("HttpService")
		SigmaData.ColorOptions = {
			Generator = generatorHighlightColor:ToHex(),
			Survivor = survivorHighlightColor:ToHex(),
			Killer = killerHighlightColor:ToHex(),
			Item = itemHighlightColor:ToHex(),
		}
		SigmaData.Info = SigmaData.Info or {}
		SigmaData.Info.JoinedSigmaServer = JoinedSigmaServer

		writefile("FartHub.json", HttpService:JSONEncode(SigmaData))
	end

	LoadSigmaData()

	-- Toggle ESP
	local function ToggleFarts(state)
		highlightingEnabled = state
		local localPlayer = game.Players.LocalPlayer
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Highlight") or obj:IsA("BillboardGui") then
				if DebugNotifications then
					GUI:Notification({
						Title = "Highlight deleted",
						Text = (pcall(function()
							return obj:GetFullName()
						end) and obj:GetFullName() or "Deleted"),
						Duration = 3,
					})
				else
				end
				obj:Destroy()
			end
		end
		if not state then
			return
		end
		local function AddFart(object, color)
			if
				object:IsA("Model")
				and object ~= localPlayer.Character
				and not object:FindFirstChildOfClass("Highlight")
			then
				local h = Instance.new("Highlight", object)
				if DebugNotifications then
					GUI:Notification({
						Title = "Highlight added",
						Text = (pcall(function()
							return h:GetFullName()
						end) and h:GetFullName() or "Deleted"),
						Duration = 3,
					})
				else
				end
				h.FillColor, h.FillTransparency, h.OutlineTransparency = color, 0.7, 0.6
			end
		end
		for _, folder in ipairs({ workspace.Players.Survivors, workspace.Players.Killers }) do
			for _, obj in ipairs(folder:GetChildren()) do
				AddFart(obj, folder.Name == "Survivors" and survivorHighlightColor or killerHighlightColor)
				local billboard = Instance.new("BillboardGui", obj:WaitForChild("Head"))
				billboard.Name = "FartHubBillboard"
				billboard.Size = UDim2.new(0, 100, 0, 50)
				billboard.StudsOffset = Vector3.new(0, 2, 0)
				local textLabel = Instance.new("TextLabel", billboard)
				textLabel.Size = UDim2.new(1, 0, 1, 0)
				textLabel.Text = obj:GetAttribute("Username") and obj.Name
				textLabel.TextColor3 = Color3.new(1, 1, 1)
				textLabel.TextStrokeTransparency = 0
				textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
				billboard.AlwaysOnTop = true
				textLabel.BackgroundTransparency = 1
			end
			folder.ChildAdded:Connect(function(child)
				if highlightingEnabled then
					AddFart(child, folder.Name == "Survivors" and survivorHighlightColor or killerHighlightColor)
					local billboard = Instance.new("BillboardGui", child:WaitForChild("Head"))
					billboard.Name = "FartHubBillboard"
					billboard.Size = UDim2.new(0, 100, 0, 50)
					billboard.StudsOffset = Vector3.new(0, 2, 0)
					local textLabel = Instance.new("TextLabel", billboard)
					textLabel.TextColor3 = Color3.new(1, 1, 1)
					textLabel.TextStrokeTransparency = 0
					textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
					textLabel.Size = UDim2.new(1, 0, 1, 0)
					textLabel.Text = child:GetAttribute("Username") and child.Name
					billboard.AlwaysOnTop = true
					textLabel.BackgroundTransparency = 1
				end
			end)
		end
		local function SetupSigmaListener()
			local ingameFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
			if not ingameFolder then
				return
			end
			local mapFolder = ingameFolder:FindFirstChild("Map")
			if not mapFolder then
				return
			end
			for _, g in ipairs(mapFolder:GetChildren()) do
				if g.Name == "Generator" then
					AddFart(g, generatorHighlightColor)
				end
			end
			mapFolder.ChildAdded:Connect(function(child)
				if highlightingEnabled and child.Name == "Generator" then
					AddFart(child, generatorHighlightColor)
				end
			end)
		end
		SetupSigmaListener()
		workspace.Map.ChildAdded:Connect(function(child)
			if highlightingEnabled then
				SetupSigmaListener()
			end
		end)
		workspace.Map.Ingame.ChildAdded:Connect(function(child)
			if highlightingEnabled then
				SetupSigmaListener()
			end
		end)
	end

	local function Do1x1x1x1Popups()
		while true do
			if Do1x1PopupsLoop then
				local player = game:GetService("Players").LocalPlayer
				local popups = player.PlayerGui.TemporaryUI:GetChildren()

				for _, i in ipairs(popups) do
					if i.Name == "1x1x1x1Popup" then
						local centerX = i.AbsolutePosition.X + (i.AbsoluteSize.X / 2)
						local centerY = i.AbsolutePosition.Y + (i.AbsoluteSize.Y / 2)
						if DebugNotifications then
							GUI:Notification({
								Title = "1x1x1x1 Popup Closed",
								Text = (pcall(function()
									return i:GetFullName()
								end) and i:GetFullName() or "Closed"),
								Duration = 3,
							})
						else
						end
						VIM:SendMouseButtonEvent(
							centerX,
							centerY,
							Enum.UserInputType.MouseButton1.Value,
							true,
							player.PlayerGui,
							1
						)
						VIM:SendMouseButtonEvent(
							centerX,
							centerY,
							Enum.UserInputType.MouseButton1.Value,
							false,
							player.PlayerGui,
							1
						)
					end
				end
			end
			task.wait(0.1)
		end
	end

	local function SetupSurfers(PuzzlesUi)
		local Container = PuzzlesUi:WaitForChild("Container")
		local GridHolder = Container:WaitForChild("GridHolder")
		local Surfers = Instance.new("VideoFrame", GridHolder)
		Surfers.Size = UDim2.new(1, -20, 1, -20)
		Surfers.AnchorPoint = Vector2.new(0.5, 0.5)
		Surfers.Position = UDim2.new(0.5, 0, 0.5, 0)

		Surfers.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Surfers.Video = LoadAsset("SubwaySurfers.mp4.Fart4")
		Surfers.Looped = true
		Surfers.Playing = true

		for _, silly in ipairs(GridHolder.Grid:GetChildren()) do
			if silly:IsA("Frame") then
				silly.Transparency = 0.6
				silly.Button.BackgroundTransparency = 0.6
			end
		end
	end

	local function SkibidiGenerator(shouldLoop)
		repeat
			if not running then
				break
			end
			local FartIngameFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
			local FartNapFolder = FartIngameFolder and FartIngameFolder:FindFirstChild("Map")
			if FartNapFolder then
				for _, g in ipairs(FartNapFolder:GetChildren()) do
					if g.Name == "Generator" and g.Progress.Value < 100 then
						g.Remotes.RE:FireServer()
						if DebugNotifications then
							GUI:Notification({
								Title = "Generator Done",
								Text = (pcall(function()
									return g:GetFullName()
								end) and g:GetFullName() or "Generator Done"),
								Duration = 3,
							})
						end
					end
				end
			end
			if shouldLoop then
				task.wait(SkibidiWait)
			end
		until not shouldLoop
	end

	local function GeneratorOnce()
		local FartIngameFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
		local FartNapFolder = FartIngameFolder and FartIngameFolder:FindFirstChild("Map")
		if FartNapFolder then
			for _, g in ipairs(FartNapFolder:GetChildren()) do
				if g.Name == "Generator" and g.Progress.Value < 100 then
					g.Remotes.RE:FireServer()
					if DebugNotifications then
						GUI:Notification({
							Title = "Generator Done",
							Text = (pcall(function()
								return g:GetFullName()
							end) and g:GetFullName() or "Generator Done"),
							Duration = 3,
						})
					end
				end
			end
		end
	end

	local function TpDoGenerator()
		local Geneators = workspace:WaitForChild("Map")
			and workspace.Map:WaitForChild("Ingame")
			and workspace.Map.Ingame:WaitForChild("Map")
		local lastPosition = Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local function findGenerators()
			local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
			local map = folder and folder:FindFirstChild("Map")
			local generators = {}
			if map then
				for _, g in ipairs(map:GetChildren()) do
					if g.Name == "Generator" and g.Progress.Value < 100 then
						table.insert(generators, g)
					end
				end
			end
			return generators
		end

		while true do
			local generators = findGenerators()
			if #generators == 0 then
				break
			end
			for _, g in ipairs(generators) do
				local player = game.Players.LocalPlayer
				local generatorPosition = g.Instances.Generator.Progress.CFrame.Position
				local generatorDirection = (g.Instances.Generator.Cube.CFrame.Position - generatorPosition).Unit
				player.Character.HumanoidRootPart.CFrame = CFrame.new(
					generatorPosition + Vector3.new(0, 0.5, 0),
					generatorPosition + Vector3.new(generatorDirection.X, 0, generatorDirection.Z)
				)
				task.wait(LopticaWaitTime / 2)
				fireproximityprompt(g.Main:WaitForChild("Prompt", 1))
				task.wait(LopticaWaitTime / 2)
				if DebugNotifications then
					GUI:Notification({
						Title = "Teleported to Generator",
						Text = (pcall(function()
							return g:GetFullName()
						end) and g:GetFullName() or "Teleported"),
						Duration = 3,
					})
				end
				for _ = 1, 6 do
					task.wait(LopticaWaitTime / 5)
					g.Remotes.RE:FireServer()
				end
				task.wait(LopticaWaitTime / 5)
				g.Remotes.RF:InvokeServer("leave")
			end
		end

		if lastPosition then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastPosition
		end
	end

	local function InjectRobux(sound)
		while sound.Parent and BlockEnabled do
			local success, err = pcall(function()
				HRP = game.Players.LocalPlayer.Character
					and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if HRP and KillerFartPart and KillerFartPart.Parent then
					local killerHRP = KillerFartPart.Parent:FindFirstChild("HumanoidRootPart")
					if killerHRP then
						local directionToPlayer = (HRP.Position - killerHRP.Position).Unit
						local killerLookVector = killerHRP.CFrame.LookVector
						local dotProduct = directionToPlayer:Dot(killerLookVector)
						if dotProduct > 0.5 then
							local distance = (KillerFartPart.Position - HRP.Position).Magnitude
							if distance < SkibidiDistance then
								BlockRemote:FireServer("UseActorAbility", "Block")
								return
							end
						end
					end
				end
			end)
			if not success then
				GUI:Notification({ Title = "An error occurred!", Text = err, Duration = 10 })
			end
			task.wait(0.1)
		end
		CurrentFartsActive[sound] = nil
	end

	local function HawkTuah()
		if not BlockEnabled then
			return
		end
		local success, err = pcall(function()
			BabyShark = workspace:WaitForChild("Players"):FindFirstChild("Killers")
			BabyShark = BabyShark and BabyShark:GetChildren()[1] or nil
			KillerFartPart = BabyShark and BabyShark:FindFirstChild("HumanoidRootPart") or nil
		end)
		if not success then
			GUI:Notification({ Title = "An error occured!", Text = err, Duration = 10 })
		end

		if KillerFartPart then
			KillerFartPart.ChildAdded:Connect(function(descendant)
				if not BlockEnabled then
					return
				end
				local success, err = pcall(function()
					if descendant:IsA("Sound") and table.find(SoundList, descendant.SoundId) then
						if not CurrentFartsActive[descendant] then
							CurrentFartsActive[descendant] = true
							task.spawn(InjectRobux, descendant)
						end
					end
				end)
				if not success then
					GUI:Notification({ Title = "An error occured!", Text = err, Duration = 10 })
				end
			end)
		end
	end

	game:GetService("Players").ChildAdded:Connect(function(child)
		if not BlockEnabled then
			return
		end
		local success, err = pcall(function()
			if child.Name == "Killers" then
				HawkTuah()
			end
		end)
		if not success then
			GUI:Notification({ Title = "An error occured!", Text = err, Duration = 10 })
		end
	end)

	game:GetService("Players").ChildRemoved:Connect(function(child)
		if not BlockEnabled then
			return
		end
		local success, err = pcall(function()
			if child.Name == "Killers" then
				HawkTuah()
			end
		end)
		if not success then
			GUI:Notification({ Title = "An error occured!", Text = err, Duration = 10 })
		end
	end)

	local function ToggleFart(state)
		SkibidiStaminaLoop = state
		local success, SkibidiSprinting = pcall(function()
			return require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
		end)

		if not success then
			if DebugNotifications then
				GUI:Notification({
					Title = "Error",
					Text = "Your executor doesn't support this.",
					Duration = 5,
				})
			end
			return
		end

		while SkibidiStaminaLoop do
			SkibidiSprinting.StaminaLossDisabled = function() end
			task.wait(1)
		end

		SkibidiSprinting.StaminaLossDisabled = nil
	end

	local function SetProximity()
		local success, err = pcall(function()
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("ProximityPrompt") then
					obj.HoldDuration = 0
				end
			end
		end)
		if not success and DebugNotifications then
			GUI:Notification({ Title = "Error", Text = err, Duration = 5 })
		end
	end

	local function ToggleSigmaItemsHighlights(state)
		ItemFartsEnabled = state
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Highlight") and table.find(Items, obj.Parent.Name) then
				if DebugNotifications then
					GUI:Notification({
						Title = "Highlight deleted",
						Text = (pcall(function()
							return obj:GetFullName()
						end) and obj:GetFullName() or "Deleted"),
						Duration = 3,
					})
				else
				end
				task.wait(0.1)
				obj:Destroy()
			end
		end
		if not state then
			return
		end
		local function AddLopticaHighlight(object, color)
			if
				object:IsA("BasePart")
				and object.Parent:IsA("Model")
				and not object:FindFirstChildOfClass("Highlight")
			then
				local h = Instance.new("Highlight", object)
				h.FillColor, h.FillTransparency, h.OutlineTransparency = color, 0.7, 0.6
				if DebugNotifications then
					GUI:Notification({
						Title = "Highlight added",
						Text = (pcall(function()
							return h:GetFullName()
						end) and h:GetFullName() or "Added"),
						Duration = 3,
					})
				else
				end
			end
		end
		for _, item in ipairs(Items) do
			for _, obj in ipairs(workspace.Map.Ingame:GetDescendants()) do
				if obj:IsA("Model") and obj.Name == item then
					for _, child in ipairs(obj:GetChildren()) do
						if child:IsA("BasePart") then
							AddLopticaHighlight(child, itemHighlightColor)
						end
					end
				end
			end
		end
		workspace.Map.Ingame.DescendantAdded:Connect(function(descendant)
			if ItemFartsEnabled and descendant:IsA("Model") and table.find(Items, descendant.Name) then
				for _, child in ipairs(descendant:GetChildren()) do
					if child:IsA("BasePart") then
						AddLopticaHighlight(child, itemHighlightColor)
					end
				end
			end
		end)
	end

	local function UpdateFarts()
		ToggleFarts(false)
		ToggleFarts(true)
		ToggleSigmaItemsHighlights(false)
		ToggleSigmaItemsHighlights(true)
		WriteSigmaData()
	end

	local function InitializeButtonGUI()
		local visible = true
		local sausageHolder = game:GetService("CoreGui").TopBarApp.UnibarLeftFrame.UnibarMenu["2"]
		local originalSize = sausageHolder.Size.X.Offset

		sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)

		local buttonFrame = Instance.new("Frame", sausageHolder)
		buttonFrame.Size = UDim2.new(0, 44, 0, 44)
		buttonFrame.BackgroundTransparency = 1
		buttonFrame.BorderSizePixel = 0
		buttonFrame.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)

		local imageButton = Instance.new("ImageButton", buttonFrame)
		imageButton.BackgroundTransparency = 1
		imageButton.BorderSizePixel = 0
		imageButton.Size = UDim2.new(0, 36, 0, 36)
		imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
		imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		imageButton.Image = "http://www.roblox.com/asset/?id=131523679474566"

		local function toggleGUI()
			visible = not visible
			GUI:show(visible)
			sausageHolder.Size = UDim2.new(0, originalSize + (visible and 48 or 0), 0, sausageHolder.Size.Y.Offset)
		end

		imageButton.Activated:Connect(toggleGUI)

		sausageHolder:GetPropertyChangedSignal("Size"):Connect(function()
			if sausageHolder.Size.X.Offset == originalSize then
				sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
			end
		end)
	end

	local function CreateSigmaFrame()
		local visible = true
		local topBarApp = game:GetService("CoreGui"):WaitForChild("TopBarApp")
		local leftFrame = topBarApp:WaitForChild("TopBarFrame"):WaitForChild("LeftFrame")

		local sigmaFrame = Instance.new("Frame", leftFrame)
		sigmaFrame.Name = "SigmaFrame"
		sigmaFrame.Size = UDim2.new(0, 32, 0, 32)
		sigmaFrame.Position = UDim2.new(0, 0, 1, 0)
		sigmaFrame.BackgroundTransparency = 1
		sigmaFrame.LayoutOrder = 5

		local background = Instance.new("ImageLabel", sigmaFrame)
		background.Name = "Background"
		background.Size = UDim2.new(0, 32, 0, 32)
		background.Position = UDim2.new(0, 0, 0, 0)
		background.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
		background.BackgroundTransparency = 1

		local icon = Instance.new("ImageButton", background)
		icon.Name = "Icon"
		icon.Size = UDim2.new(0, 36, 0, 36)
		icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Image = "http://www.roblox.com/asset/?id=131523679474566"
		icon.BackgroundTransparency = 1

		local function toggleGUI()
			visible = not visible
			GUI:show(visible)
		end
		icon.Activated:Connect(toggleGUI)
	end

	local function MakeButton()
		if game:GetService("CoreGui"):FindFirstChild("TopBarApp"):FindFirstChild("UnibarLeftFrame") then
			InitializeButtonGUI()
		else
			CreateSigmaFrame()
		end
	end

	local function InitializeGUI()
		GeneratorTab = GUI:Tab({ Name = "Generators", Icon = "rbxassetid://12549056837" })
		VisualsTab = GUI:Tab({ Name = "视觉效果", Icon = "rbxassetid://129972183138590" })
		PlayerTab = GUI:Tab({ Name = "玩家", Icon = "rbxassetid://86412006218107" })
		BlatantTab = GUI:Tab({ Name = "高亮显示", Icon = "rbxassetid://17183582911" })
		MiscTab = GUI:Tab({ Name = "杂项", Icon = "rbxassetid://17106470268" })
		RNGTab = GUI:Tab({ Name = "RNG自制", Icon = "rbxassetid://17106470268" })
		XRNTab = GUI:Tab({ Name = "动作/RNG自制", Icon = "rbxassetid://17106470268" })

		GUI:Credit({ Name = "ivannetta", Description = "meowzer", Discord = "ivannetta" })
		GUI:Notification({
			Title = "注意：亮点不工作修复.",
			Text = "重置您的Bloxtrap设置.",
			Duration = 10,
		})
		GUI:Notification({ Title = "注：由ivannetta制作", Text = "请加入DC服务器 😼", Duration = 20 })
		GUI:Notification({
			Title = "注：一些问题",
			Text = "你好",
			Duration = 3,
		})

		VisualsTab:ColorPicker({
			Style = Mercury.ColorPickerStyles.Legacy,
			Callback = function(color)
				generatorHighlightColor = color
				UpdateFarts()
			end,
			Name = "发电机高亮颜色",
			Default = generatorHighlightColor,
		})

		VisualsTab:ColorPicker({
			Style = Mercury.ColorPickerStyles.Legacy,
			Callback = function(color)
				survivorHighlightColor = color
				UpdateFarts()
			end,
			Name = "幸存者高亮颜色",
			Default = survivorHighlightColor,
		})

		VisualsTab:ColorPicker({
			Style = Mercury.ColorPickerStyles.Legacy,
			Callback = function(color)
				killerHighlightColor = color
				UpdateFarts()
			end,
			Name = "杀手高亮颜色",
			Default = killerHighlightColor,
		})

		VisualsTab:ColorPicker({
			Style = Mercury.ColorPickerStyles.Legacy,
			Callback = function(color)
				itemHighlightColor = color
				UpdateFarts()
			end,
			Name = "物品高亮颜色",
			Default = itemHighlightColor,
		})

		VisualsTab:Toggle({
			Name = "高亮显示物体",
			Description = "切换游戏中物体的高亮显示",
			StartingState = false,
			Callback = function(state)
				ToggleFarts(state)
				ToggleSigmaItemsHighlights(state)
			end,
		})

		PlayerTab:Button({
			Name = "快速接近提示",
			Description = "使接近提示立即完成.",
			Callback = function()
				SetProximity()
			end,
		})

		PlayerTab:Toggle({
			Name = "C00lkid 自瞄",
			Description = "告诉游戏你是在手机上玩，这样你就能免费获得自动瞄准功能",
			StartingState = false,
			Callback = function(state)
				running = state
				game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent
					:FireServer("SetDevice", state and "Mobile" or "PC")
			end,
		})

		PlayerTab:Toggle({
			Name = "给我来点披萨",
			Description = "将披萨传送给你",
			StartingState = false,
			Callback = function(state)
				task.spawn(function()
					WatchForPizza(state)
				end)
			end,
		})

		GeneratorTab:Toggle({
			Name = "快速发电机",
			Description = "以专业速度运行发电机",
			StartingState = false,
			Callback = function(state)
				running = state
				if state then
					task.spawn(function()
						SkibidiGenerator(true)
					end)
				end
			end,
		})

		GeneratorTab:Keybind({
			Name = "执行当前发电机任务",
			Keybind = Enum.KeyCode.K,
			Callback = function()
				GeneratorOnce()
			end,
		})

		PlayerTab:Toggle({
			Name = "禁用耐力消耗",
			Description = "禁用冲刺的耐力消耗",
			StartingState = false,
			Callback = function(state)
				task.spawn(function()
					ToggleFart(state)
				end)
			end,
		})

		PlayerTab:Toggle({
			Name = "从1x1x1x1弹出窗口",
			Description = "自行弹出",
			StartingState = false,
			Callback = function(state)
				Do1x1PopupsLoop = state
				if state then
					task.spawn(Do1x1x1x1Popups)
				end
			end,
		})

		GeneratorTab:Slider({
			Name = "修发电机速度",
			Description = "改变修发电机的速度",
			Default = 0.5,
			Min = 0.1,
			Max = 10,
			Value = 0.5,
			Callback = function(value)
				SkibidiWait = value
			end,
		})

		BlatantTab:Toggle({ -- ty loptica r3mii for amongus
			Name = "自瞄",
			Description = "一些角色的自瞄",
			StartingState = false,
			Callback = function(state)
				HandleFartContainer(state)
			end,
		})

		BlatantTab:Toggle({
			Name = "自动格挡",
			Description = "自动对Guest 1337使用格挡（技能），目前仅在M1（设备或模式）上有效",
			StartingState = false,
			Callback = function(state)
				BlockEnabled = state
				local success, err = pcall(function()
					if BlockEnabled then
						HawkTuah()
					end
				end)
				if not success then
					GUI:Notification({ Title = "An error occured!", Text = err, Duration = 10 })
				end
			end,
		})

		MiscTab:Toggle({
			Name = "切换胖子",
			Description = "切换胖子，非常明目张胆的功能，使用风险自负",
			StartingState = false,
			Callback = function(state)
				ToggleFatMan(state)
			end,
		})

		BlatantTab:Button({
			Name = "自动刷发电机任务",
			Description = "不断更换服务器并一直做发电机任务",
			Callback = function()
				GUI:Notification({ Title = "等待", Text = "请等一下，臭男孩", Duration = 20 })
				loadstring(
					game:HttpGet(
						"https://raw.githubusercontent.com/ivannetta/ShitScripts/refs/heads/main/AutoSigma.lua",
						true
					)
				)()
			end,
		})

		BlatantTab:Button({
			Name = "执行所有发电机（任务）的速度",
			Description = "传送到所有发电机处并操作它们",
			Callback = function()
				TpDoGenerator()
			end,
		})

		BlatantTab:Slider({
			Name = "执行所有发电机任务的速度",
			Description = "改变传送到发电机处的速度",
			Default = 0.1,
			Min = 0.1,
			Max = 10,
			Callback = function(value)
				LopticaWaitTime = value
			end,
		})

		BlatantTab:Slider({
			Name = "自动格挡距离",
			Description = "更改阻挡杀手的距离阈值，如果你清楚自己在做什么就更改它.",
			Default = 6,
			Min = 1,
			Max = 20,
			Callback = function(value)
				SkibidiDistance = value
			end,
		})

		MiscTab:Button({
			Name = "名称保护",
			Description = "用pmoon替换每个人的名字和图像",
			Callback = function()
				NameProtect(true)
			end,
		})

		MiscTab:Button({
			Name = "低注意力模式",
			Description = "激活低注意力模式，其实lol",
			Callback = function()
				if not _G.LowAttentionSpanModeActivated then
					_G.LowAttentionSpanModeActivated = true
					PlayerGui.ChildAdded:Connect(function(child)
						if child.Name == "PuzzleUI" then
							SetupSurfers(child)
						end
					end)
				else
					GUI:Notification({
						Title = "已激活",
						Text = "低注意力模式已激活",
						Duration = 3,
					})
				end
			end,
		})

		RNGTab:Toggle({
			Name = "开启聊天框",
			Description = "监视",
			StartingState = false,
			Callback = function(state)
				if state then
				game:GetService("CoreGui").ExperienceChat.appLayout.chatWindow.Visible = true
				game:GetService("CoreGui").ExperienceChat.appLayout.chatInputBar.Visible = true
				else
				game:GetService("CoreGui").ExperienceChat.appLayout.chatWindow.Visible = false
				game:GetService("CoreGui").ExperienceChat.appLayout.chatInputBar.Visible = false
				end
			end,
		})
		RNGTab:Toggle({
			Name = "突然想起来跳跃",
			Description = "可以跳了",
			Callback = function(value)
			if value then
				game:GetService("Players").LocalPlayer.PlayerGui.TouchGui.TouchControlFrame.JumpButton.Visible = true
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
				else
				game:GetService("Players").LocalPlayer.PlayerGui.TouchGui.TouchControlFrame.JumpButton.Visible = false
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
				end
			end,
		})

RNGTab:Button({
			Name = "我操他妈这里是哪里",
			Description = "来到神秘的位置",
			Callback = function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3551.82764, 11.8806458, 273.904541, 0.992054343, 0, -0.125810176, 0, 1, 0, 0.125810176, 0, 0.992054343)
			end,
		})

RNGTab:Button({
			Name = "玩家死亡提醒",
			Description = "提示玩家是否死亡",
			Callback = function()
				local notification = loadstring(game:HttpGet('https://raw.githubusercontent.com/Loco-CTO/UI-Library/main/VisionLibV2/source.lua'))()

function notify(text)
    notification:ForceNotify({
        Name = "Qinyan",
        Text = text,
        Icon = "rbxassetid://11401835376",
        Duration = 4,
    })
end

local RagdollsFolder = workspace:WaitForChild("Ragdolls")

RagdollsFolder.ChildAdded:Connect(function(child)
    notify("玩家: " .. child.Name .. " gg")
end)

RagdollsFolder.ChildRemoved:Connect(function(child)
    notify("玩家: " .. child.Name .. " 尸体消失！")
end)
			end,
		})

		RNGTab:Toggle({
			Name = "提升速度",
			Description = "明目张胆的明目张胆",
			StartingState = false,
			Callback = function(Value)
				toggle = Value
while toggle do wait()
game.Players.LocalPlayer.Character.Humanoid.BaseSpeed = 50

    end
			end,
		})

			RNGTab:Toggle({
			Name = "提升速度",
			Description = "伪装版",
			StartingState = false,
			Callback = function(Value)
				toggle = Value
while toggle do wait()
game.Players.LocalPlayer.Character.Humanoid.BaseSpeed = 24

    end
			end,
		})
	
			RNGTab:Toggle({
			Name = "动作 (被遗弃无法使用)",
			Description = "帅",
			Callback = function(value)
			 error("傻逼我不是说了吗不能用")
			end,
		})
		
		if not JoinedSigmaServer then
			GUI:Prompt({
				Title = "加入Fart Hub不和谐服务器？",
				Text = "这将有很大帮助，您可以提前访问功能！！！",
				Buttons = {
					["Ya :3"] = function()
						setclipboard("https://discord.gg/AC4usvpwVY")
						GUI:Notification({ Title = "复制了Discord链接", Text = "我爱你！（草东）", Duration = 10 })
						JoinedSigmaServer = true
						WriteSigmaData()
					end,
					["不，我恨你"] = function()
						GUI:Notification({ Title = "好的 :(", Text = "我理解.", Duration = 10 })
						WriteSigmaData()
					end,
				},
			})
		end
	end

	CheckIfFartsDownloaded()
	InitializeGUI()
	MakeButton()
end

local function MakeKeySystem()
	KeySystem = Instance.new("ScreenGui")
	Frame = Instance.new("Frame")
	TextBox = Instance.new("TextBox")
	UICorner = Instance.new("UICorner")
	UIPadding = Instance.new("UIPadding")
	UICorner_2 = Instance.new("UICorner")
	TextLabel = Instance.new("TextLabel")
	CheckKeyButton = Instance.new("TextButton")
	UICorner_3 = Instance.new("UICorner")
	GetKey = Instance.new("TextButton")
	UICorner_4 = Instance.new("UICorner")

	KeySystem.Name = "KeySystem"
	KeySystem.Parent = game:GetService("CoreGui")
	KeySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	KeySystem.ResetOnSpawn = false

	Frame.Parent = KeySystem
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = UDim2.new(0, 300, 0, 120)
	Frame.ZIndex = 2

	TextBox.Parent = Frame
	TextBox.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Position = UDim2.new(0, 0, 0, 10)
	TextBox.Size = UDim2.new(1, 0, 0, 50)
	TextBox.ClearTextOnFocus = false
	TextBox.Font = Enum.Font.FredokaOne
	TextBox.PlaceholderColor3 = Color3.fromRGB(97, 97, 97)
	TextBox.PlaceholderText = "FartHub Key..."
	TextBox.Text = ""
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextSize = 22.000
	TextBox.TextWrapped = true

	UICorner.Parent = TextBox

	UIPadding.Parent = Frame
	UIPadding.PaddingBottom = UDim.new(0, 5)
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingRight = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)

	UICorner_2.Parent = Frame

	TextLabel.Parent = Frame
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0, 0, 0, -20)
	TextLabel.Size = UDim2.new(1, 0, 0, 30)
	TextLabel.ZIndex = 0
	TextLabel.Font = Enum.Font.FredokaOne
	TextLabel.Text = "Fart Hub | Key System"
	TextLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
	TextLabel.TextSize = 25.000
	TextLabel.TextStrokeTransparency = 0.000
	TextLabel.TextWrapped = true

	CheckKeyButton.Name = "CheckKey"
	CheckKeyButton.Parent = Frame
	CheckKeyButton.AnchorPoint = Vector2.new(0, 1)
	CheckKeyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CheckKeyButton.BackgroundTransparency = 1.000
	CheckKeyButton.BorderColor3 = Color3.fromRGB(45, 45, 45)
	CheckKeyButton.BorderSizePixel = 0
	CheckKeyButton.Position = UDim2.new(0, 3, 1, 0)
	CheckKeyButton.Size = UDim2.new(0.449999988, 0, 0, 40)
	CheckKeyButton.Font = Enum.Font.FredokaOne
	CheckKeyButton.Text = "Check Key"
	CheckKeyButton.TextColor3 = Color3.fromRGB(106, 255, 103)
	CheckKeyButton.TextSize = 22.000

	UICorner_3.Parent = CheckKeyButton

	GetKey.Name = "GetKey"
	GetKey.Parent = Frame
	GetKey.AnchorPoint = Vector2.new(1, 1)
	GetKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GetKey.BackgroundTransparency = 1.000
	GetKey.BorderColor3 = Color3.fromRGB(45, 45, 45)
	GetKey.BorderSizePixel = 0
	GetKey.Position = UDim2.new(1, -3, 1, 0)
	GetKey.Size = UDim2.new(0.449999988, 0, 0, 40)
	GetKey.Font = Enum.Font.FredokaOne
	GetKey.Text = "Get Key"
	GetKey.TextColor3 = Color3.fromRGB(255, 102, 125)
	GetKey.TextSize = 22.000

	UICorner_4.Parent = GetKey
end

local function setupKeySystem()
	MakeKeySystem()
	CheckKeyButton.Activated:Connect(function()
		if TextBox.Text:lower() == TextBox.Text then
			TextLabel.Text = "Key is valid!"
			if not isfolder("FartHub") then
				makefolder("FartHub")
			end
			writefile("FartHub/FartHubKey.json", "fart")
			KeySystem:Destroy()
			FartHubLoad()
		else
			TextLabel.Text = "Key is invalid!"
			task.wait(1)
			TextLabel.Text = "Fart Hub | Key System"
		end
	end)
	GetKey.Activated:Connect(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))():SendNotification(
			"Info",
			"Copied discord link.",
			5
		)
		TextLabel.Text = "https://discord.gg/AC4usvpwVY"
		setclipboard("https://discord.gg/AC4usvpwVY")
	end)
end

local success, err = pcall(function()
	if not isfile("FartHub/FartHubKey.json") or readfile("FartHub/FartHubKey.json") ~= "fart" then
		setupKeySystem()
	else
		FartHubLoad()
	end
end)

if not success then
	warn("An error occurred: " .. tostring(err))
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()


local isHighlightActive = false

local toolhighlightactive = false

local hawktuahactive = false

local isCorruptNatureEspActive = false

local isSurvivorUtilEspActive = false

local run = false

local delay

local isSurvivorHighlightActive = false

local givepizza = false

local connections = {}

local isKillerHighlightActive = false

local hideplayerbar = false

local VirtualBallsManager = game:GetService('VirtualInputManager')

local jumppowerenabled = false

local survivorutil = {
    "007n7",
    "BuildermanSentry",
    "BuildermanDispenser",
    "Pizza",
    "BuildermanSentryEffectRange"
}





local aimbot1x1sounds = {
    "rbxassetid://79782181585087",
    "rbxassetid://128711903717226"
}

local chanceaimbotsounds = {
    "rbxassetid://201858045",
    "rbxassetid://139012439429121"
}

local johnaimbotsounds = {
    "rbxassetid://109525294317144"
}

local jasonaimbotsounds = {
    "rbxassetid://112809109188560",
    "rbxassetid://102228729296384"
}

local shedaimbotsounds = {
    "rbxassetid://12222225",
    "rbxassetid://83851356262523"
}

local guestsounds = {
    "rbxassetid://609342351"
}

local hawktuahactivatesound = {
    "rbxassetid://110759725172567"
}

local hakariactive = false

local quietactive = false

local stam = false

local connection

local chanceaim = false

local chanceaimbotLoop

local jasonaimbotloop

local genshouldloop = false

local genactive = false

local aimbot1x1loop

local johnloop

local guestloop

local shedloop

local player = game.Players.LocalPlayer

local aimbot1x1 = false

local johnaim = false

local connection

local jasonaim = false

local shedaim = false

local guestaim = false




local function initialize()
    local GUI = Rayfield:CreateWindow({
		Name = "Applesaken",
		Theme = "Default",
		LoadingTitle = "Apple Ware",
		LoadingSubtitle = "can fart hub please collab already",
		Icon = "apple",
		Link = "https://github.com/SilkScripts/AppleStuff/get out of here",

		DisableBuildWarnings = true,
		DisableRayfieldPrompts = true,

		KeySystem = false,
		KeySettings = {
			Title = "Appleware Key or sum",
			Subtitle = "FART HUB PLEASE COLLABBB",
			Note = "Join Discord Server To Get Key | https://discord.gg/fGFV3r9yKC",
			FileName = "Applewarething",
			SaveKey = true,
			GrabKeyFromSite = false,
			Key = {"Apple"}, 
		},
	})
    

    

    local function button1() -- creds to ivan
		local visible = true
		local sausageHolder = game:GetService("CoreGui").TopBarApp.UnibarLeftFrame.UnibarMenu["2"]
		local originalSize = sausageHolder.Size.X.Offset

		sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)

		local buttonFrame = Instance.new("Frame", sausageHolder)
		buttonFrame.Size = UDim2.new(0, 44, 0, 44)
		buttonFrame.BackgroundTransparency = 1
		buttonFrame.BorderSizePixel = 0
		buttonFrame.Position = UDim2.new(0, sausageHolder.Size.X.Offset - 48, 0, 0)

		local imageButton = Instance.new("ImageButton", buttonFrame)
		imageButton.BackgroundTransparency = 1
		imageButton.BorderSizePixel = 0
		imageButton.Size = UDim2.new(0, 36, 0, 36)
		imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
		imageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		imageButton.Image = "http://www.roblox.com/asset/?id=99937635381008"

		local function toggleGUI()
			visible = not visible
			Rayfield:SetVisibility(visible, false)
			sausageHolder.Size = UDim2.new(0, originalSize + (visible and 48 or 0), 0, sausageHolder.Size.Y.Offset)
		end

		imageButton.Activated:Connect(toggleGUI)

		sausageHolder:GetPropertyChangedSignal("Size"):Connect(function()
			if sausageHolder.Size.X.Offset == originalSize then
				sausageHolder.Size = UDim2.new(0, originalSize + 48, 0, sausageHolder.Size.Y.Offset)
			end
		end)
	end

	local function button2() -- creds to ivan
		local visible = true
		local topBarApp = game:GetService("CoreGui"):WaitForChild("TopBarApp")
		local leftFrame = topBarApp:WaitForChild("TopBarFrame"):WaitForChild("LeftFrame")

		local sigmaFrame = Instance.new("Frame", leftFrame)
		sigmaFrame.Name = "SigmaFrame"
		sigmaFrame.Size = UDim2.new(0, 32, 0, 32)
		sigmaFrame.Position = UDim2.new(0, 0, 1, 0)
		sigmaFrame.BackgroundTransparency = 1
		sigmaFrame.LayoutOrder = 5

		local background = Instance.new("ImageLabel", sigmaFrame)
		background.Name = "Background"
		background.Size = UDim2.new(0, 32, 0, 32)
		background.Position = UDim2.new(0, 0, 0, 0)
		background.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
		background.BackgroundTransparency = 1

		local icon = Instance.new("ImageButton", background)
		icon.Name = "Icon"
		icon.Size = UDim2.new(0, 36, 0, 36)
		icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.Image = "http://www.roblox.com/asset/?id=99937635381008"
		icon.BackgroundTransparency = 1

		local function toggleGUI()
			visible = not visible
			Rayfield:SetVisibility(visible, false)
		end
		icon.Activated:Connect(toggleGUI)
	end

	local function init() -- creds to ivan
		if game:GetService("CoreGui"):FindFirstChild("TopBarApp"):FindFirstChild("UnibarLeftFrame") then
			button1()
		else
			button2()
		end
	end

    init()




    local function toggleHighlightGen(state)
        isHighlightActive = state 
    
        local function applyGeneratorHighlight(generator)
            if generator.Name == "Generator" then
                local existingHighlight = generator:FindFirstChild("GeneratorHighlight")
                local progress = generator:FindFirstChild("Progress")
                
                if isHighlightActive then
                    if not existingHighlight then
                        local genhighlight = Instance.new("Highlight")
                        genhighlight.Parent = generator
                        genhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        genhighlight.Name = "GeneratorHighlight"
                    end
                else
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                    return
                end
    
                if progress then
                    if progress.Value == 100 then
                        local highlight = generator:FindFirstChild("GeneratorHighlight")
                        if highlight then
                            highlight:Destroy()
                        end
                        return
                    end
    
                    progress:GetPropertyChangedSignal("Value"):Connect(function()
                        if progress.Value == 100 then
                            local highlight = generator:FindFirstChild("GeneratorHighlight")
                            if highlight then
                                highlight:Destroy()
                            end
                        elseif isHighlightActive and not generator:FindFirstChild("GeneratorHighlight") then
                            local genhighlight = Instance.new("Highlight")
                            genhighlight.Parent = generator
                            genhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            genhighlight.Name = "GeneratorHighlight"
                        end
                    end)
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            applyGeneratorHighlight(v)
        end
    
        game.Workspace.Map.Ingame.Map.ChildAdded:Connect(function(child)
            applyGeneratorHighlight(child)
        end)
    end
    
    
    
    local function togglehidebar(state)
        hideplayerbar = state 
        local playergui = player.PlayerGui
        local playerinfo = playergui.TemporaryUI.PlayerInfo
    
        if hideplayerbar then
            playerinfo.CurrentSurvivors.Visible = false
            playerinfo.PlayerIcon.Image = "rbxassetid://12549056837"
        else
            playerinfo.CurrentSurvivors.Visible = true
        end
    end
    
    
    local function hawktuahmode(state)
        if player.Character.Name ~= "c00lkidd" then
            Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't COolkid, this POSSIBLY can bug out, so untoggle unless you're on Coolkidd!", Duration = 5}
            return end
        local TS = game:GetService("TweenService")
        hawktuahactive = state
    if state then
        Rayfield:Notify{Title = "DM", Content = "hawk tuah mode", Duration = 10}
    end
        
        game.DescendantAdded:Connect(function(descendant)
            for _, v in pairs(hawktuahactivatesound) do
            if descendant.Name == v then
                if hawktuahactive then
                    local propout = {
                        ImageTransparency = 1
                    }
    
                    local propin = {
                        ImageTransparency = 0
                    }
    
                    local screengui = Instance.new("ScreenGui")
                    local frame = Instance.new("Frame")
                    local image = Instance.new("ImageLabel")
                    local sound = Instance.new("Sound")
                    sound.Parent = game.Workspace
                    sound.SoundId = "rbxassetid://17787027130"
                    sound:Play()
    
                    screengui.Parent = game.Players.LocalPlayer.PlayerGui
                    screengui.IgnoreGuiInset = true
                    frame.Parent = screengui
                    image.Parent = frame
    
                    frame.Size = UDim2.new(1,0,1,0)
                    frame.Position = UDim2.new(0, 0, 0, 0)
                    frame.BackgroundTransparency = 1
    
                    image.Size = UDim2.new(1,0,1,0)
                    image.Position = UDim2.new(0, 0, 0, 0)
                    image.BackgroundTransparency = 1
    
                    image.Image = "http://www.roblox.com/asset/?id=100505038126957"
    
                    local tweeninfoI = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
                    local tween = TS:Create(image,tweeninfoI, propout)
                    tween:play()
    
                   
                    wait(1)
    
                    local tweeninfoII = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    local tweenI = TS:Create(image,tweeninfoII, propin)
                    tweenI:play()
                    screengui:Destroy()
                end
            end
        end
        end)
    end
    
    
    
    local function Do1x1x1x1Popups() -- creds to ivan
        while true do
            if Do1x1PopupsLoop then
                local player = game:GetService("Players").LocalPlayer
                local popups = player.PlayerGui.TemporaryUI:GetChildren()
    
                for _, i in ipairs(popups) do
                    if i.Name == "1x1x1x1Popup" then
                        local centerX = i.AbsolutePosition.X + (i.AbsoluteSize.X / 2)
                        local centerY = i.AbsolutePosition.Y + (i.AbsoluteSize.Y / 2)
        
                        VirtualBallsManager:SendMouseButtonEvent(centerX, centerY, Enum.UserInputType.MouseButton1.Value, true, player.PlayerGui, 1)
                        VirtualBallsManager:SendMouseButtonEvent(centerX, centerY, Enum.UserInputType.MouseButton1.Value, false, player.PlayerGui, 1)
                    end
                end
            end
            task.wait(0.1)
        end
    end
    
    
    local function instantsolvegen()
        for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            if v.name == "Generator" then
                local num = 0
                repeat
                num += 1
                v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                until num == 4
            end
        end
    end
    
    local function solvegen()
        for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
            if v.name == "Generator" then
                v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
            end
        end
    end
    
    
    local function instantsolvegenhell()
        for i, v in pairs(game.Workspace.Map.Ingame.Map.Generators:GetChildren()) do
            if v:IsA("Model") then
                local num = 0
                repeat
                num += 1
                v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                until num == 4
            end
        end
    end
    
    local function highlighttools(state)
        toolhighlightActive = state
        
        local function applyHighlight(tool)
            if toolhighlightActive then
                local existinghighlight = tool:FindFirstChild("ToolHighlight")
                if not existinghighlight then
                    local toolhighlight = Instance.new("Highlight")
                    toolhighlight.Name = "ToolHighlight"
                    toolhighlight.Parent = tool
                    toolhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
                    if tool.Name == "Medkit" then
                        toolhighlight.FillColor = Color3.fromRGB(0, 255, 0)
                    elseif tool.Name == "BloxyCola" then
                        toolhighlight.FillColor = Color3.fromRGB(88, 57, 39)
                    end
                end
            else
                local existinghighlight = tool:FindFirstChild("ToolHighlight")
                if existinghighlight then
                    existinghighlight:Destroy()
                end
            end
        end
        
        for _, v in pairs(game.Workspace.Map.Ingame:GetChildren()) do
            if v:IsA("Tool") then
                applyHighlight(v)
            end
        end
        
        game.Workspace.Map.Ingame.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                applyHighlight(child)
            end
        end)
    end
    



    local function givemesomepizza(state)
        if not state then
            
            for _, v in pairs(connections) do
                v:Disconnect()
            end
            table.clear(connections)
            return
        end
    
        
        local function tp(child)
            if child:IsA("BasePart") and child.Name == "Pizza" then
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        child.CFrame = hrp.CFrame
                    end
                end
            end
        end
    
        
        local function watchtower()
            local map = workspace:FindFirstChild("Map")
            local insession = map and map:FindFirstChild("Ingame")
    
            if insession then
                
                for _, child in pairs(insession:GetChildren()) do
                    tp(child)
                end
                
                table.insert(connections, insession.ChildAdded:Connect(tp))
            end
        end
    
        
        watchtower()
    end

    local function setdelay(value)
        delay = value
        
    end

        
    
    local function autogen(state)
        run = state
        
        local debounce = {}
        


        while run do
            task.wait()
            for _, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" then
                    
                    if not debounce[v] then
                        debounce[v] = true
                        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                        task.delay(delay, function() debounce[v] = nil end)
                    end
                end
            end
        end
    end
    





    
    local function corruptnatureesp(state)
        isCorruptNatureEspActive = state
        for i, v in pairs(game.Workspace.Map.Ingame:GetChildren()) do
            if v:IsA("Model") then
                local existingHighlight = v:FindFirstChild("CorruptNatureHighlight")
                if isCorruptNatureEspActive then
                    if not existingHighlight then
                        if v.Name == "HumanoidRootProjectile" or v.Name == "PizzaDeliveryRig" or v.Name == "Bunny" or v.Name == "Mafiaso1" or v.Name == "Mafiaso2" or v.Name == "Mafiaso3" then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "CorruptNatureHighlight"
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            highlight.Parent = v
                        end
                    end
                else
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    end
    
    
    local function survivorutilesp(state)
        isSurvivorUtilEspActive = state
        
        local function applySurvivorUtilHighlight(model)
            local existingHighlight = model:FindFirstChild("SurvivorUtilHighlight")
            if isSurvivorUtilEspActive then
                if not existingHighlight then
                    for _, util in pairs(survivorutil) do
                        if model.Name == util then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "SurvivorUtilHighlight"
                            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            highlight.FillColor = Color3.fromRGB(255,255,255)
                            highlight.FillTransparency = 0.5
                            highlight.Parent = model
                        end
                    end
                end
            else
                if existingHighlight then
                    existingHighlight:Destroy()
                end
            end
        end
        
        for _, v in pairs(game.Workspace.Map.Ingame:GetChildren()) do
            if v:IsA("Model") or v:IsA("Part") then
                applySurvivorUtilHighlight(v)
            end
        end
        
        game.Workspace.Map.Ingame.ChildAdded:Connect(function(child)
            if child:IsA("Model") or child:IsA("Part") then
                applySurvivorUtilHighlight(child)
            end
        end)
    end
    
    
    local function activatethehakari(state)
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        hakariactive = state
    
        if hakariactive then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://138019937280193"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://87166578676888"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = true
            sound:Play()
    
            local effect = game.ReplicatedStorage.Assets.Emotes.HakariDance.HakariBeamEffect:Clone()
            effect.Name = "PlayerEmoteVFX"
            effect.CFrame = char.PrimaryPart.CFrame * CFrame.new(0, -1, -0.3)
            effect.WeldConstraint.Part0 = char.PrimaryPart
            effect.WeldConstraint.Part1 = effect
            effect.Parent = char
            effect.CanCollide = false
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "HakariDance"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0 
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            local effect = char:FindFirstChild("PlayerEmoteVFX")
            if effect then
                effect:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://138019937280193" then
                    track:Stop()
                end
            end
        end
    end
    
    
    local function activatethesilly(state)
    
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        sillyactive = state
    
        if sillyactive then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
        
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
        
           
            local emoteScript = require(game:GetService("ReplicatedStorage").Assets.Emotes.Shucks)
            emoteScript.Created({Character = char})
        
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://74238051754912"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
        
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123236721947419"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
        
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Shucks"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
        
                
                local saw = char:FindFirstChild("Saw")
                if saw then saw:Destroy() end
        
                local playerHand = char:FindFirstChild("PlayerEmoteHand")
                if playerHand then playerHand:Destroy() end
            end)
        else
    
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
    
            local saw = char:FindFirstChild("Saw")
            if saw then saw:Destroy() end
    
            local playerHand = char:FindFirstChild("PlayerEmoteHand")
            if playerHand then playerHand:Destroy() end
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://74238051754912" then
                    track:Stop()
                end
            end
        end
    end
    
    
    local function activatethequiet(state)
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
        sillyactive = state
    
        if sillyactive then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
        
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
        
            local emoteScript = require(game:GetService("ReplicatedStorage").Assets.Emotes.MissTheQuiet)
            emoteScript.Created({Character = char})
        
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://100986631322204"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
        
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://131936418953291"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
        
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "MissTheQuiet"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
        
                local assetsToDestroy = {"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}
                for _, assetName in ipairs(assetsToDestroy) do
                    local asset = char:FindFirstChild(assetName)
                    if asset then asset:Destroy() end
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
        
            local assetsToDestroy = {"EmoteHatAsset", "EmoteLighting", "PlayerEmoteHand"}
            for _, assetName in ipairs(assetsToDestroy) do
                local asset = char:FindFirstChild(assetName)
                if asset then asset:Destroy() end
            end
        
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
        
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://100986631322204" then
                    track:Stop()
                end
            end
        end
    end
    
    
    local function activatethesilly2(state)
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local rootPart = char:WaitForChild("HumanoidRootPart")
    
        sillyactive = state
    
        if sillyactive then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
    
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = rootPart
    
    
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://74238051754912"
            local animationTrack = humanoid:LoadAnimation(animation)
            animationTrack:Play()
    
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://123236721947419"
            sound.Parent = rootPart
            sound.Volume = 0.5
            sound.Looped = false
            sound:Play()
    
            local args = {
                [1] = "PlayEmote",
                [2] = "Animations",
                [3] = "Shucks"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
    
            animationTrack.Stopped:Connect(function()
                humanoid.PlatformStand = false
                if bodyVelocity and bodyVelocity.Parent then
                    bodyVelocity:Destroy()
                end
            end)
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 0
    
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
    
            local sound = rootPart:FindFirstChildOfClass("Sound")
            if sound then
                sound:Stop()
                sound:Destroy()
            end
    
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation.AnimationId == "rbxassetid://74238051754912" then
                    track:Stop()
                end
            end
        end
    end
    
    
    
    
    local function survivorHighlighter(state)
        isSurvivorHighlightActive = state
    
        local function applySurvivorHighlight(model)
            if model:IsA("Model") and model:FindFirstChild("Head") then
                local existingBillboard = model.Head:FindFirstChild("billboard")
                local existingHighlight = model:FindFirstChild("HiThere")
                
                if isSurvivorHighlightActive then
                    if not existingBillboard then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "billboard"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.Head
                        
                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = model.Name
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        textLabel.BackgroundTransparency = 1
                    end
    
                    if not existingHighlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HiThere"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(0, 255, 0)
                        highlight.Parent = model
                    end
                else
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Players.Survivors:GetChildren()) do
            applySurvivorHighlight(v)
        end
    
        game.Workspace.Players.Survivors.ChildAdded:Connect(function(child)
            applySurvivorHighlight(child)
        end)
    end
    
    
    
    local function killerHighlighter(state)
        isKillerHighlightActive = state
    
        local function applyKillerHighlight(model)
            if model:IsA("Model") and model:FindFirstChild("Head") then
                local existingBillboard = model.Head:FindFirstChild("billboard")
                local existingHighlight = model:FindFirstChild("HiThere")
                
                if isKillerHighlightActive then
                    if not existingBillboard then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "billboard"
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.Head
                        
                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = model.Name
                        textLabel.TextColor3 = Color3.new(1, 0, 0)
                        textLabel.TextStrokeTransparency = 0
                        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        textLabel.BackgroundTransparency = 1
                    end
    
                    if not existingHighlight then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HiThere"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.Parent = model
                    end
                else
                    if existingBillboard then
                        existingBillboard:Destroy()
                    end
                    if existingHighlight then
                        existingHighlight:Destroy()
                    end
                end
            end
        end
    
        for _, v in pairs(game.Workspace.Players.Killers:GetChildren()) do
            applyKillerHighlight(v)
        end
    
        game.Workspace.Players.Killers.ChildAdded:Connect(function(child)
            applyKillerHighlight(child)
        end)
    end
    
    local function bringbackjumppower(state)
        jumppowerenabled = state
    
        if jumppowerenabled then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
        end
       
    end
    
    local function speedmulti(value)
        game.Players.LocalPlayer.Character.SpeedMultipliers.Sprinting.Value = value
    end

    local function bringbackjumppowerslider(value)
    
        if jumppowerenabled then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        else
           return
        end
       
    end
    
    local function FOVmulti(value)
        game.Players.LocalPlayer.Character.FOVMultipliers.FOVSetting.Value = value
    end
    
    local function kaiguyskin()      
        if player.Character.Name ~= "Guest1337" then
                    Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't Guest, this POSSIBLY can bug out, so untoggle unless you're on Guest!", Duration = 5}
                    return end
            for _, v in pairs(player.Character:GetChildren()) do
                if v:IsA("Shirt") then
                    v:Destroy()
                end
    
                if v:IsA("Pants") then
                    v:Destroy()
                end
    
                local headband = Instance.new("Accessory")
                local scarf = Instance.new("Accessory")
                local shirt = Instance.new("Shirt")
                local pants = Instance.new("Pants")
                --
                local headbandhandle = Instance.new("Part")
                local scarfhandle = Instance.new("Part")
                local headbandhandleattach = Instance.new("Attachment")
                local scarfhandleattach = Instance.new("Attachment")
                local headbandweld = Instance.new("Weld")
                local scarfweld = Instance.new("Weld")
                scarfhandle.Name = "Handle"
                headbandhandle.Name = "Handle"
                scarfhandle.CanCollide = false
                headbandhandle.CanCollide = false
                --
                local headbandmesh = Instance.new("SpecialMesh")
                local scarfmesh = Instance.new("SpecialMesh")
                --
                shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=836903658"
                pants.PantsTemplate = "http://www.roblox.com/asset/?id=731578592"
                shirt.Parent = player.Character
                pants.Parent = player.Character
                 --
                headband.Parent = player.Character
                scarf.Parent = player.Character
                scarfhandle.Parent = scarf
                headbandhandle.Parent = headband
                headbandhandleattach.Parent = headbandhandle
                scarfhandleattach.Parent = scarfhandle
                headbandmesh.Parent = headbandhandle
                scarfmesh.Parent = scarfhandle
                headbandhandle.Color = Color3.fromRGB(27, 42, 53)
                scarfhandle.Color = Color3.fromRGB(27, 42, 53)
                --
                headbandweld.Parent = headbandhandle
                headbandweld.Name = "AccessoryWeld"
                headbandweld.Part0 = headbandhandle
                headbandweld.Part1 = player.Character.Head
                headbandweld.C0 = CFrame.new(0, 0, 0)
                headbandweld.C1 = CFrame.new(0, 0, 0)
                --
                scarfweld.Parent = scarfhandle
                scarfweld.Name = "AccessoryWeld"
                scarfweld.Part0 = scarfhandle
                scarfweld.Part1 = player.Character.Torso
                scarfweld.C0 = CFrame.new(0, -0.4, 0)
                scarfweld.C1 = CFrame.new(0, 0, 0)
                --
                headbandmesh.MeshId = "http://www.roblox.com/asset/?id=20407184"
                headbandmesh.Scale = Vector3.new(1.103, 1.071, 1.103)
                scarfmesh.MeshId = "http://www.roblox.com/asset/?id=99856331"
                scarfmesh.Scale = Vector3.new(1.071, 1.071, 1.071)
                scarfmesh.VertexColor = Vector3.new(1, 2, 1)
                --
                headbandhandleattach.Name = "HatAttachment"
                headbandhandleattach.CFrame = CFrame.new(0, 0.557, 0)
                scarfhandleattach.Name = "NeckAttachment"
                scarfhandleattach.CFrame = CFrame.new(0, 0.519, 0)
    
                local playergui = player.PlayerGui
                local playerinfo = playergui.TemporaryUI.PlayerInfo
    
        
            playerinfo.PlayerIcon.Image = "http://www.roblox.com/asset/?id=97047410245118"
     
    
            end
    end
    
    local function doomskin()      
        if player.Character.Name ~= "Shedletsky" then
                    Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't Shedletsky, this POSSIBLY can bug out, so untoggle unless you're on Shedletsky!", Duration = 5}
                    return end
            for _, v in pairs(player.Character:GetChildren()) do
                if v:IsA("Shirt") then
                    v:Destroy()
                end
    
                if v:IsA("Pants") then
                    v:Destroy()
                end
    
                local headband = Instance.new("Accessory")
             
                local shirt = Instance.new("Shirt")
                local pants = Instance.new("Pants")
                local tshirt = Instance.new("ShirtGraphic")
                --
                local headbandhandle = Instance.new("Part")
             
                local headbandhandleattach = Instance.new("Attachment")
              
                local headbandweld = Instance.new("Weld")
               
               
                headbandhandle.Name = "Handle"
              
                headbandhandle.CanCollide = false
                --
                local headbandmesh = Instance.new("SpecialMesh")
              
                --
                shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=1808496"
                pants.PantsTemplate = "http://www.roblox.com/asset/?id=1809861"
                tshirt.Graphic = "http://www.roblox.com/asset/?id=2426992"
                shirt.Parent = player.Character
                pants.Parent = player.Character
                tshirt.Parent = player.Character
                 --
                headband.Parent = player.Character
        
                headbandhandle.Parent = headband
                headbandhandleattach.Parent = headbandhandle
                
                headbandmesh.Parent = headbandhandle
               
                headbandhandle.Color = Color3.fromRGB(27, 42, 53)
                
                --
                headbandweld.Parent = headbandhandle
                headbandweld.Name = "AccessoryWeld"
                headbandweld.Part0 = headbandhandle
                headbandweld.Part1 = player.Character.Head
                headbandweld.C0 = CFrame.new(0, -0.5, 0)
                headbandweld.C1 = CFrame.new(0, 0, 0)
                --
                --
                headbandmesh.MeshId = "http://www.roblox.com/asset/?id=1286103"
                headbandmesh.TextureId = "rbxassetid://6858319251"
                headbandmesh.Scale = Vector3.new(0.992, 0.994, 0.992)
               if player.Character:FindFirstChild("ShedHair") then
                player.Character:FindFirstChild("ShedHair"):Destroy()
               end
                --
                headbandhandleattach.Name = "HatAttachment"
                headbandhandleattach.CFrame = CFrame.new(0, 0.557, 0)
    
                local playergui = player.PlayerGui
                local playerinfo = playergui.TemporaryUI.PlayerInfo
    
        
            playerinfo.PlayerIcon.Image = "http://www.roblox.com/asset/?id=118308385507069"
     
    
            end
    end


    
    local function chanceaimbot(state)
        chanceaim = state
        if game.Players.LocalPlayer.Character.Name ~= "Chance" and state then
            Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't Chance, this POSSIBLY can bug out, so untoggle unless you're on Chance!", Duration = 5}
            return 
        end
        if state then
            chanceaimbotLoop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                if not chanceaim then return end
                for _, v in pairs(chanceaimbotsounds) do
                    if child.Name == v  then
                        local killer = game.Workspace.Players:FindFirstChild("Killers"):FindFirstChildOfClass("Model")
                        if killer and killer:FindFirstChild("HumanoidRootPart") then
                            local killerHRP = killer.HumanoidRootPart
                            local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if playerHRP then
                                local direction = (killerHRP.Position - playerHRP.Position).Unit
                                local num = 1
                                local maxIterations = 100
                            
                                
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(killerHRP.Position.X, killerHRP.Position.Y, killerHRP.Position.Z))
                                    end
                                
                            
                            end
                        end
                    end
                end
            end)
        else
            if chanceaimbotLoop then
                chanceaimbotLoop:Disconnect()
                chanceaimbotLoop = nil
            end
        end
    end
    
    local function shedaimbot(state)
        shedaim = state
        if game.Players.LocalPlayer.Character.Name ~= "Shedletsky" and state then
            Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't Shedletsky, this POSSIBLY can bug out, so untoggle unless you're on Shedletsky!", Duration = 5}
            return
        end
        if state then
            shedloop = game.Players.LocalPlayer.Character.Sword.ChildAdded:Connect(function(child)
                if not shedaim then return end
                for _, v in pairs(shedaimbotsounds) do
                    if child.Name == v then
                        local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                        if killersFolder then
                            local killer = killersFolder:FindFirstChildOfClass("Model")
                            if killer and killer:FindFirstChild("HumanoidRootPart") then
                                local killerHRP = killer.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if playerHRP then
                                    local num = 1
                                    local maxIterations = 100
    
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if shedloop then
                shedloop:Disconnect()
                shedloop = nil
            end
        end
    end
    
    local function guestaimbot(state)
        shedaim = state
        if game.Players.LocalPlayer.Character.Name ~= "Guest1337" and state then
            Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't Guest, this POSSIBLY can bug out, so untoggle unless you're on Guest!", Duration = 5}
            return
        end
        if state then
            shedloop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                if not shedaim then return end
                for _, v in pairs(guestsounds) do
                    if child.Name == v then
                        local killersFolder = game.Workspace.Players:FindFirstChild("Killers")
                        if killersFolder then
                            local killer = killersFolder:FindFirstChildOfClass("Model")
                            if killer and killer:FindFirstChild("HumanoidRootPart") then
                                local killerHRP = killer.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if playerHRP then
                                    local num = 1
                                    local maxIterations = 100
    
                                    while num <= maxIterations do
                                        task.wait(0.01)
                                        num = num + 1
                                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, killerHRP.Position)
                                        playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if guestloop then
                guestloop:Disconnect()
                guestloop = nil
            end
        end
    end
        
    local function aimbot1x1x1x1(state)
        aimbot1x1 = state
    
        if game.Players.LocalPlayer.Character.Name ~= "1x1x1x1" and state then
            Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't  1x, this POSSIBLY can bug out, so untoggle unless you're on 1x!", Duration = 5}
            return 
        end
    
        if state then
            aimbot1x1loop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                if not aimbot1x1 then return end
                for _, v in pairs(aimbot1x1sounds) do
                    if child.Name == v then
                        local survivors = {}
                        for _, player in pairs(game.Players:GetPlayers()) do
                            if player ~= game.Players.LocalPlayer then
                                local character = player.Character
                                if character and character:FindFirstChild("HumanoidRootPart") then
                                    table.insert(survivors, character)
                                end
                            end
                        end
    
                        local nearestSurvivor = nil
                        local shortestDistance = math.huge  
                        
                        for _, survivor in pairs(survivors) do
                            local survivorHRP = survivor.HumanoidRootPart
                            local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if playerHRP then
                                local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                                if distance < shortestDistance then
                                    shortestDistance = distance
                                    nearestSurvivor = survivor
                                end
                            end
                        end
                        
                        if nearestSurvivor then
                            local nearestHRP = nearestSurvivor.HumanoidRootPart
                            local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            
                            if playerHRP then
                                local direction = (nearestHRP.Position - playerHRP.Position).Unit
                                local num = 1
                                local maxIterations = 100 
    
                                
                                    if child.Name == "rbxassetid://79782181585087" then
                                        maxIterations = 220  
                                    end
    
                                while num <= maxIterations do
                                    task.wait(0.01)
                                    num = num + 1
                                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                    playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                                end
                            
                            end
                        end
                    end
                end
            end)
        else
            if aimbot1x1loop then
                aimbot1x1loop:Disconnect()
                aimbot1x1loop = nil
            end
        end
    end
    
    local function johnaimbot(state)
        johnaim = state
        if game.Players.LocalPlayer.Character.Name ~= "JohnDoe" and state then
            Rayfield:Notify{Title = "Wrong Character", Content = "Oops, your current character isn't John Doe, this POSSIBLY can bug out, so untoggle unless you're on John!", Duration = 5}
            return 
        end
            if state then
                johnloop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                    if not johnaim then return end
                    for _, v in pairs(johnaimbotsounds) do
                        if child.Name == v then
                           
                            local survivors = {}
                            for _, player in pairs(game.Players:GetPlayers()) do
                                if player ~= game.Players.LocalPlayer then
                                    local character = player.Character
                                    if character and character:FindFirstChild("HumanoidRootPart") then
                                        table.insert(survivors, character)
                                    end
                                end
                            end
        
                           
                            local nearestSurvivor = nil
                            local shortestDistance = math.huge  
                            
                            for _, survivor in pairs(survivors) do
                                local survivorHRP = survivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                
                                if playerHRP then
                                    local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                                    if distance < shortestDistance then
                                        shortestDistance = distance
                                        nearestSurvivor = survivor
                                    end
                                end
                            end
                            
                          
                            if nearestSurvivor then
                                local nearestHRP = nearestSurvivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local maxIterations = 330
                                if playerHRP then
                                    local direction = (nearestHRP.Position - playerHRP.Position).Unit
                                    local num = 1
                                   
                                        
                                        while num <= maxIterations do
                                            task.wait(0.01)
                                            num = num + 1
                                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearestHRP.Position)
                                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                    
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                if johnloop then
                    johnloop:Disconnect()
                    johnloop = nil
                end
            end
    end
    
    local function jasonaimbot(state)
        jasonaim = state
        if game.Players.LocalPlayer.Character.Name ~= "Jason" and state then
            Rayfield:Notify{Title = "Wrong Character", Text = "Oops, your current character isn't Jason, this POSSIBLY can bug out, so untoggle unless you're on Jason. Also this is buggy asf lmao", Duration = 5}
            return 
        end
            if state then
                jasonaimbotloop = game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(child)
                    if not jasonaim then return end
                    for _, v in pairs(jasonaimbotsounds) do
                        if child.Name == v then
                           
                            local survivors = {}
                            for _, player in pairs(game.Players:GetPlayers()) do
                                if player ~= game.Players.LocalPlayer then
                                    local character = player.Character
                                    if character and character:FindFirstChild("HumanoidRootPart") then
                                        table.insert(survivors, character)
                                    end
                                end
                            end
        
                           
                            local nearestSurvivor = nil
                            local shortestDistance = math.huge  
                            
                            for _, survivor in pairs(survivors) do
                                local survivorHRP = survivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                
                                if playerHRP then
                                    local distance = (survivorHRP.Position - playerHRP.Position).Magnitude
                                    if distance < shortestDistance then
                                        shortestDistance = distance
                                        nearestSurvivor = survivor
                                    end
                                end
                            end
                            
                          
                            if nearestSurvivor then
                                local nearestHRP = nearestSurvivor.HumanoidRootPart
                                local playerHRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local maxIterations = 70
                                if playerHRP then
                                    local direction = (nearestHRP.Position - playerHRP.Position).Unit
                                    local num = 1
                                   
                                        
                                        while num <= maxIterations do
                                            task.wait(0.01)
                                            num = num + 1
                                            
                                            playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, Vector3.new(nearestHRP.Position.X, nearestHRP.Position.Y, nearestHRP.Position.Z))
                    
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                if jasonaimbotloop then
                    jasonaimbotloop:Disconnect()
                    jasonaimbotloop = nil
                end
            end
    end
    
    
    local function staminadrainono(state)
        stam = state
        local stamscript = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
        
        while stam do
            stamscript.StaminaLossDisabled = true
            task.wait(1)
        end
        
        
            stamscript.StaminaLossDisabled = nil
    end
    
    
    
    local function unlockclientcharacters()
        local clone = game.Players.LocalPlayer.PlayerData.Equipped.Skins:Clone()
        clone.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Killers
        for i, v in pairs(clone:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Killers
            end
        local clone2 = game.Players.LocalPlayer.PlayerData.Equipped.Skins:Clone()
        clone2.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Survivors
        
            for i, v in pairs(clone2:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.PlayerData.Purchased.Survivors
            end
    end
    
    
    
    
    
    Rayfield:Notify{Title = "JOIN THE DISCORD", Content = "plz https://discord.gg/fGFV3r9yKC", Duration = 5, Image = "clipboard"}
    Rayfield:Notify{Title = "Welcome to Apple Ware", Content = "Feel free to post any bugs or suggestions in the server :)", Duration = 10, Image = "Apple"}
   
    
    
    local VisualTab = GUI:CreateTab("绘制", "eye")
        
    local gentab = GUI:CreateTab("发电机", "archive")
   
    local chartab = GUI:CreateTab("杀手", "axe")
    
    local survivortab = GUI:CreateTab("幸存者", "key")
    
    local blatanttab = GUI:CreateTab("通用的功能", "laugh")
    
    local misctab = GUI:CreateTab("杂物 (动作就在这里面)", "meh")
    
    
    
    
    local InstantSolveButton = gentab:CreateButton({
        Name = "完成一次",
        Callback = function()
        instantsolvegen()
        end,
     })
    
     local InstantSolveButtonGenHell = gentab:CreateButton({
        Name = "Gen Hell 2 Two.结算器",
        Callback = function()
        instantsolvegenhell()
        end,
     })
    
    
     local OnePuzzle = gentab:CreateButton({
        Name = "一个解谜按钮",
        Callback = function()
        solvegen()
        end,
     })
    

     gentab:CreateDivider() 


    
     local Toggle1 = gentab:CreateToggle({
        Name = "自动发电机",
        CurrentValue = false,
      
        Callback = function(state)
        autogen(state)
        end,
     })


     local Toggle2 = gentab:CreateToggle({
        Name = "发电机绘制",
        CurrentValue = false,
     
        Callback = function(state)
        toggleHighlightGen(state)
        end,
     })
    
     gentab:CreateDivider() 

     local Keybind = gentab:CreateKeybind({
        Name = "电脑快速解决",
        CurrentKeybind = "H",
        HoldToInteract = false,
       
        Callback = function(Keybind)
        solvegen()
        end,
     })

     local Slider1 = gentab:CreateSlider({
        Name = "自动解决速度",
        Range = {0.1, 10},
        Increment = 0.1,
        Suffix = "seconds",
        CurrentValue = 0.1,
         
        Callback = function(value)
        setdelay(value)
        end,
     })

    --
    local Toggle3 = VisualTab:CreateToggle({
        Name = "道具绘制",
        CurrentValue = false,
    
        Callback = function(state)
        highlighttools(state)
        end,
     })
    
     local Toggle4 = VisualTab:CreateToggle({
        Name = "幸存者绘制",
        CurrentValue = false,
     
        Callback = function(state)
        survivorHighlighter(state)
        end,
     })
    
     local Toggle5 = VisualTab:CreateToggle({
        Name = "杀手绘制",
        CurrentValue = false,
       
        Callback = function(state)
        killerHighlighter(state)
        end,
     })
    
     local Toggle6 = VisualTab:CreateToggle({
        Name = "C00lkidd 绘制",
        CurrentValue = false,
       
        Callback = function(state)
        corruptnatureesp(state)
        end,
     })
    
     local Toggle7 = VisualTab:CreateToggle({
        Name = "幸存者绘制?",
        CurrentValue = false,
      
        Callback = function(state)
        survivorutilesp(state)
        end,
     })
    --
    
    local UnlockChars  = misctab:CreateButton({
        Name = "解锁全部成就 假的",
        Callback = function()
        unlockclientcharacters()
        end,
     })
    
     misctab:CreateDivider() 
    
     local Toggle8 = misctab:CreateToggle({
        Name = "机会100级送的成就 (开赌吧)",
        CurrentValue = false,
        
        Callback = function(state)
        activatethehakari(state)
        end,
     })
    
     local Toggle9 = misctab:CreateToggle({
        Name = "呃，呸 [有电锯]",
        CurrentValue = false,
        
        Callback = function(state)
        activatethesilly(state)
        end,
     })
    
     local Toggle10 = misctab:CreateToggle({
        Name = "Aw Shucks [没电锯]",
        CurrentValue = false,
        
        Callback = function(state)
        activatethesilly2(state)
        end,
     })
    
     local Toggle11 = misctab:CreateToggle({
        Name = "上个版本的动作",
        CurrentValue = false,
       
        Callback = function(state)
        activatethequiet(state)
        end,
     })
    
     misctab:CreateDivider() 
    
     local Toggle12 = misctab:CreateToggle({
        Name = "关闭玩家栏",
        CurrentValue = false,
         
        Callback = function(state)
            togglehidebar(state)
        end,
     })
    
     misctab:CreateDivider() 

     local Slider2 = misctab:CreateSlider({
        Name = "视角",
        Range = {1, 2},
        Increment = 1,
        Suffix = ";",
        CurrentValue = 1,
      
        Callback = function(value)
        FOVmulti(value)
        end,
     })
    
    --
    
    -- 
    
    local kaiguy = survivortab:CreateButton({
        Name = "访客 1337 皮肤",
        Callback = function()
        kaiguyskin()
        end,
     })

     local doom = survivortab:CreateButton({
        Name = "Doombringer Shed 皮肤",
        Callback = function()
        doomskin()
        end,
     })
    
     survivortab:CreateDivider() 

     local Toggle13 = survivortab:CreateToggle({
        Name = "Chance(机会) 自瞄",
        CurrentValue = false,
        
        Callback = function(state)
            chanceaimbot(state)
        end,
     })
    
     local Toggle14 = survivortab:CreateToggle({
        Name = "Shed 自瞄",
        CurrentValue = false,
        
        Callback = function(state)
            shedaimbot(state)
        end,
     })
    
     local Toggle15 = survivortab:CreateToggle({
        Name = "Guest1337 自动瞄准",
        CurrentValue = false,
        
        Callback = function(state)
            guestaimbot(state)
        end,
     })

     local Toggle16 = survivortab:CreateToggle({
        Name = "Pizza 传送",
        CurrentValue = false,
        
        Callback = function(state)
            givemesomepizza(state)
        end,
     })
    --
    local CoolKidAimbotToggle = chartab:CreateToggle({ -- creds to ivan.. ivan if ur seeing this i accidentally deleted mine and lost it and its 2 lines so xd.
        Name = "C00lkid 自瞄",
        CurrentValue = false,
        Callback = function(state)
            game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent:FireServer("SetDevice", state and "Mobile" or "PC")
        end,
    })
    

    local aimbot1x1x1aimbot = chartab:CreateToggle({
        Name = "1x1x1x1 自瞄",
        CurrentValue = false,
        Callback = function(state)
           aimbot1x1x1x1(state)
        end,
    })


    chartab:CreateDivider() 

    local popupsolver = chartab:CreateToggle({
        Name = "及时弹出求解器",
        CurrentValue = false,
        Callback = function(state)
            Do1x1PopupsLoop = state and task.spawn(Do1x1x1x1Popups)
        end,
    })

    
    --
    
    
    
    
    
    
    local JohnAimbot = blatanttab:CreateToggle({ 
        Name = "通用的自瞄",
        CurrentValue = false,
        Callback = function(state)
            johnaimbot(state)
        end,
    })
    
    local JasonAimbot = blatanttab:CreateToggle({ 
        Name = "Jason 自瞄 [BUGGY. ONLY KILL WITH ABILITIES]",
        CurrentValue = false,
        Callback = function(state)
            jasonaimbot(state)
        end,
    })
    
    blatanttab:CreateDivider() 


    local nostaminaloss = blatanttab:CreateToggle({ 
        Name = "杀死体力",
        CurrentValue = false,
        Callback = function(state)
            staminadrainono(state)
        end,
    })
    
    
    local jump = blatanttab:CreateToggle({ 
        Name = "启用跳跃",
        CurrentValue = false,
        Callback = function(state)
            bringbackjumppower(state)
        end,
    })
    
    local hawktuah = blatanttab:CreateToggle({ 
        Name = "奇怪的功能",
        CurrentValue = false,
        Callback = function(state)
            hawktuahmode(state)
        end,
    })
    
    blatanttab:CreateDivider() 

    local WalkspeedSlider = blatanttab:CreateSlider({
        Name = "速度",
        Range = {1, 1000},
        Increment = 1,
        Suffix = ";",
        CurrentValue = 1,
        Callback = function(value)
        speedmulti(value)
        end,
     })

     local JumpspeedSlider = blatanttab:CreateSlider({
        Name = "跳跃",
        Range = {1, 1000},
        Increment = 1,
        Suffix = ";",
        CurrentValue = 50,
        Callback = function(value)
        bringbackjumppowerslider(value)
        end,
     })
end

initialize()