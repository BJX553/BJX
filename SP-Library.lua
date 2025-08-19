-- the library docs: https://github.com/as6cd0/splibv2/blob/main/splibDocumentation.md
-- 备用库接口: https://raw.githubusercontent.com/as6cd0/SP_Hub/refs/heads/main/splibv2
local L = loadstring or load
local Lib = "https://raw.githubusercontent.com/OAO-Kamu/UI-Library-Interface/refs/heads/main/SP%20LibraryMain.lua"
local splib = L(game:HttpGet(Lib))()

local Window = splib:MakeWindow({
 Name = "SP Hub Library v2",
 HidePremium = false,
 SaveConfig = true,
 Setting = true,
 ToggleIcon = "rbxassetid://82795327169782",
 ConfigFolder = "SPHubConfigs",
 CloseCallback = true
})

Tab = Window:MakeTab({
  IsMobile = false,
  Name = "Tab",
  Icon = "rbxassetid://4483345998"
})

Tab:AddSection({
  Name = "Section"  
})

Tab:AddLabel("Label")

Tab:AddButton({
    Name = "Button",
    Desc = "What is this button do?",
    Callback = function()
    print("button pressed")
     end
})

local printing = false

Tab:AddToggle({
    Name = "Toggle",
    Desc = "What is this toggle do?",
    Default = false,
    IsMobile = false,
	Flag = "ToggleTest",
	Save = true,
    Callback = function(Value)
        if Value == true then
            if not printing then
                printing = true
                task.spawn(function()
                    while printing do
                        print("Its Work")
                        wait(1)
                    end
                end)
            end
        else
            printing = false
        end
    end
})

Tab:AddParagraph("Paragraph","Paragraph Content")

Tab:AddTextbox({
  Name = "Textbox",
  Desc = "What is this textbox do?",
  Default = "default box input",
  TextDisappear = true,
  Flag = "textbox",
  Callback = function(Value)
    print(Value)
  end    
})


Tab:AddButton({
    Name = "Notification",
    Callback = function()

splib:MakeNotification{
    Name    = "OH HELL NAH",
    Content = "Notifiction Test",
    Image   = "rbxassetid://6026568198",
    Time    = 5,
}

    end    
})


Tab:AddBind({
  Name = "Bind",
  Desc = "What is this bind do?",
  Default = Enum.KeyCode.E,
  Hold = false,
  Flag = "binds",
  Save = true,
  Callback = function()
    print("pressWORLRLRLLL")
  end    
})

Tab:AddSlider({
  Name = "Slider",
  Min = 0,
  Max = 20,
  Default = 10,
  Increment = 1,
  ValueName = "bananas",
  Flag = "Sliders",
  Callback = function(Value)
    print(Value)
  end    
})


Tab:AddDropdown({
    Name = "Dropdown",
    Desc = "What is this dropdown do?",
    Default = "1",
    Options = {"1", "2", "3"},
    Callback = function(value)
        print(value)
    end    
})

Tab:AddColorpicker({
  Name = "Colorpicker ",
   Desc = "What is this colorpoicker do?",
  Default = Color3.fromRGB(255, 0, 0),
  Flag = "ColorPickerSaveTest",
  Callback = function()
  end    
})