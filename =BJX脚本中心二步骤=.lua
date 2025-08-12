local cieirbidi = Instance.new("ScreenGui", game:GetService("CoreGui"))
local vbnciuo = Instance.new("Frame", cieirbidi)
local ewroiucn = Instance.new("TextLabel", vbnciuo)
local ebrieubn = Instance.new("TextButton", vbnciuo)
local owierc = Instance.new("ScrollingFrame", vbnciuo)
local nbveiru = Instance.new("TextLabel", owierc)
local viuereb = Instance.new("TextButton", vbnciuo)
local poiuvnd = Instance.new("UICorner", viuereb)
local ciedniou = Instance.new("UICorner", ebrieubn)
local poiehrb = Instance.new("UICorner", vbnciuo)
local US = Instance.new("UIStroke", vbnciuo)
local US2 = Instance.new("UIStroke", ebrieubn)
local US3 = Instance.new("UIStroke", viuereb)
cieirbidi.ResetOnSpawn = false
cieirbidi.Name = "discordinvitepopupgui"

vbnciuo.Size = UDim2.new(0.5, 0, 0.6, 0)
vbnciuo.Position = UDim2.new(0.25, 0, 0.2, 0)
vbnciuo.BackgroundTransparency = 0.1
vbnciuo.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)

poiehrb.CornerRadius = UDim.new(0, 10)
US.Color = Color3.new(0.1, 0.1, 0.1)
US.Thickness = 5
US.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

ewroiucn.Size = UDim2.new(0.75, 0, 0.1, 0)
ewroiucn.Position = UDim2.new(0.03, 0, 0, 0)
ewroiucn.Text = "  北极星 | 公告预览"
ewroiucn.TextScaled = true
ewroiucn.Font = Enum.Font.SourceSansBold
ewroiucn.TextColor3 = Color3.new(1, 1, 1)
ewroiucn.BackgroundTransparency = 1
ewroiucn.TextXAlignment = Enum.TextXAlignment.Center
ewroiucn.TextYAlignment = Enum.TextYAlignment.Center

ebrieubn.Size = UDim2.new(0.1, 0, 0.1, 0)
ebrieubn.Position = UDim2.new(0.89, 0, 0.01, 0)
ebrieubn.Text = "X"
ebrieubn.TextScaled = true
ebrieubn.Font = Enum.Font.SourceSansBold
ebrieubn.TextColor3 = Color3.new(1, 1, 1)
ebrieubn.BackgroundColor3 = Color3.new(1, 0, 0)

ciedniou.CornerRadius = UDim.new(0, 8)
US2.Color = Color3.new(0.5, 0, 0)
US2.Thickness = 2
US2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

owierc.Size = UDim2.new(0.9, 0, 0.75, 0)
owierc.Position = UDim2.new(0.05, 0, 0.12, 0)
owierc.BackgroundTransparency = 1
owierc.CanvasSize = UDim2.new(0, 0, 2, 0)
owierc.ScrollBarThickness = 3
owierc.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)

nbveiru.Size = UDim2.new(1, -10, 2, 0)
nbveiru.Position = UDim2.new(0, 0, 0, 0)
nbveiru.Text = [[
————————————————}
我们北极星脚本标识:
————————————————}
     B       Z       X
    
  ╔═════╗  ╔═════╗╔════════╗
  ║█████║  ║█████║║  █B&Z-XHUB█║
  ║█░░░█║  ║░░░░█║║  ░█░░░█░║
  ║█░░░█║  ║░░░█░║║  ░░█░█░░║
  ║█████║  ║░░█░░║║  ░░░█░░░║
  ║█░░░█║  ║░█░░░║║  ░░█░█░░║
  ║█░░░█║  ║█░░░░║║  ░█░░░█░║
  ║█████║  ║█████║║  █B&Z-XHUB█║
  ╚═════╝  ╚═════╝╚════════╝
HH     HH   UU      UU   BBBBBBB
HH     HH   UU      UU   BB    BB
HHHHHHH   UU      UU   BBBBBBB
HH    HH   UU      UU   BB    BB
HH    HH   UUUUUUUU   BBBBBBB
'北极星脚本'标识(比我的还精细)
————————————————}
6.拥有原创,算个半缝合不是缝合.
会努力自制！努力创新！
————————————————}
我们作者:
————————————————}
脚本中心作者:北极星
公告作者:冻梨
恩师:
————————————————}
公告:冻梨是北极星的师傅哟~
————————————————}
我们联系:
————————————————}
邮箱：zilinskaslandon@gmail.com
————————————————}
我们团队信息:
————————————————}
QQ群:985228498 欢迎你的加入!
制作团队:NOOB-TEMA #1735.
无敌免费半缝合.
————————————————}
祝福语:
————————————————}
欢迎你的使用!
祝你:身体健康,工作顺利,心想事成,一切顺利!(*^-^)ﾉ🎉
]]
nbveiru.TextSize = 14
nbveiru.TextWrapped = true
nbveiru.Font = Enum.Font.Highway
nbveiru.TextColor3 = Color3.new(1, 1, 1)
nbveiru.BackgroundTransparency = 1
nbveiru.TextXAlignment = Enum.TextXAlignment.Left
nbveiru.TextYAlignment = Enum.TextYAlignment.Top

viuereb.Size = UDim2.new(0.4, 0, 0.1, 0)
viuereb.Position = UDim2.new(0.3, 0, 0.875, 0)
viuereb.Text = "确认"
viuereb.TextScaled = true
viuereb.Font = Enum.Font.SourceSansBold
viuereb.TextColor3 = Color3.new(1, 1, 1)
viuereb.BackgroundColor3 = Color3.new(0.26, 0.59, 0.98)

poiuvnd.CornerRadius = UDim.new(0, 8)
US3.Color = Color3.new(0.13, 0.29, 0.54)
US3.Thickness = 2
US3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

viuereb.MouseButton1Click:Connect(function()
    cieirbidi:Destroy()
     loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/-/refs/heads/main/%3DBJX%E8%84%9A%E6%9C%AC%E4%B8%AD%E5%BF%83%3D.lua="))()
    viuereb.Text = "加载中..."
    wait(5)
    viuereb.Text = "加载中..."
end)

ebrieubn.MouseButton1Click:Connect(function()
    cieirbidi:Destroy()
end)
