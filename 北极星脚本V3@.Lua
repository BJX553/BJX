local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/DesrtKnock/DesrtKnock-X/refs/heads/main/notification.lua'))()

library.prompt('北极星', '忍者传奇', 10)

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/AAAA/refs/heads/main/%E5%8C%97%E6%9E%81%E6%98%9F%E8%84%9A%E6%9C%ACV3.Lua",true))()
local win = ui:new("北极星忍者传奇")


local UITab1 = win:Tab("『忍者传奇』",'16060333448')

local about = UITab1:section("『传送』",false)
 
 about:Button("传送出生点",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)
end)

about:Button("传送附魔岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)
end)

about:Button("传送神秘岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171.97178649902344, 4047.380859375, 42.0699577331543)
	end)

about:Button("传送太空岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)
	end)

about:Button("传送冻土岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)
	end)

about:Button("传送雷暴岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)
end)

about:Button("传送沙暴岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)
	end)

about:Button("传送永恒岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)
	end)

about:Button("传送远古炼狱岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)
	end)

about:Button("传送午夜暗影岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.74267578125, 33206.98046875, 57.495574951171875)
	end)

about:Button("传送神秘灵魂岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)
	end)

about:Button("传送冬季奇迹岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)
	end)

about:Button("传送黄金大师岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)
	end)

about:Button("传送龙传奇岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)
	end)

about:Button("传送赛博传奇岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)
	end)

about:Button("传送天岗超能岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)
	end)

about:Button("传送混沌传奇岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)
	end)

about:Button("传送灵魂融合岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)
	end)

about:Button("传送黑暗元素岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.697265625, 83198.984375, 72.73107147216797)
	end)

about:Button("传送内心和平岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)
	end)

about:Button("传送炽烈漩涡岛",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)
	end)

about:Button("传送35倍金币区域",function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(86.2938232421875, 91245.765625, 120.54232788085938)
	end)

local about = UITab13:section("主要功能",false)

about:Button("解锁所有岛",function()
		for _, v in next, game.workspace.islandUnlockParts:GetChildren() do
			if v then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame
				wait(0.5)
			end
		end
	end)

about:Button("获取所有元素", function()
    if game:GetService("ReplicatedStorage") and game:GetService("ReplicatedStorage").Elements and game.ReplicatedStorage and game.ReplicatedStorage.rEvents and game.ReplicatedStorage.rEvents.elementMasteryEvent then
        for i, v in pairs(game:GetService("ReplicatedStorage").Elements:GetChildren()) do
            local allelement = v.Name
            game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(allelement)
        end
    end
end)

about:Button("传送",function()
loadstring(game:HttpGet("https://pastebin.com/raw/UzaUDSPK"))()
end)

about:Toggle("吸所有环", "Hoops", false, function(state)
    LS.hoops = state
    if LS.hoops then
        while LS.hoops do
            for i, v in ipairs(workspace.Hoops:GetChildren()) do
                if v.Name == "Hoop" then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            wait()
            for i, v in ipairs(workspace.Hoops.Hoop:GetChildren()) do
                if v.Name == "touchPart" then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end
end)

