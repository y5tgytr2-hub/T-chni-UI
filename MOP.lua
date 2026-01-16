--// T-chni UI Library
local UI = {}
UI.__index = UI

-- ================= CONFIG =================
local Theme = {
    Background = Color3.fromRGB(25,25,25),
    Tab = Color3.fromRGB(30,30,30),
    Accent = Color3.fromRGB(0,170,255),
    Text = Color3.fromRGB(255,255,255)
}

-- ================= SERVICES =================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ================= UTILS =================
local function Create(class, props)
    local obj = Instance.new(class)
    for k,v in pairs(props) do
        obj[k] = v
    end
    return obj
end

-- ================= WINDOW =================
function UI:CreateWindow(cfg)
    local Window = {}

    local ScreenGui = Create("ScreenGui", {
        Name = "TchniUI",
        Parent = PlayerGui,
        ResetOnSpawn = false
    })

    local Main = Create("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Background,
        Size = UDim2.fromScale(0.6,0.6),
        Position = UDim2.fromScale(0.2,0.2),
        BorderSizePixel = 0
    })

    Create("UICorner",{CornerRadius=UDim.new(0,12),Parent=Main})

    local Title = Create("TextLabel",{
        Parent = Main,
        Text = cfg.Name or "T-chni Hub",
        Size = UDim2.new(1,0,0,40),
        BackgroundTransparency = 1,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 18
    })

    local TabHolder = Create("Frame",{
        Parent = Main,
        Size = UDim2.new(0.25,0,1,-40),
        Position = UDim2.new(0,0,0,40),
        BackgroundColor3 = Theme.Tab
    })

    local Pages = Create("Frame",{
        Parent = Main,
        Size = UDim2.new(0.75,0,1,-40),
        Position = UDim2.new(0.25,0,0,40),
        BackgroundTransparency = 1
    })

    local TabLayout = Instance.new("UIListLayout",TabHolder)
    TabLayout.Padding = UDim.new(0,5)

    -- ================= TAB =================
    function Window:CreateTab(name)
        local Tab = {}

        local TabButton = Create("TextButton",{
            Parent = TabHolder,
            Text = name,
            Size = UDim2.new(1,0,0,40),
            BackgroundColor3 = Theme.Background,
            TextColor3 = Theme.Text,
            Font = Enum.Font.Gotham,
            TextSize = 14
        })

        local Page = Create("ScrollingFrame",{
            Parent = Pages,
            Size = UDim2.new(1,0,1,0),
            CanvasSize = UDim2.new(0,0,0,0),
            ScrollBarImageTransparency = 1,
            Visible = false
        })

        local Layout = Instance.new("UIListLayout",Page)
        Layout.Padding = UDim.new(0,6)

        TabButton.MouseButton1Click:Connect(function()
            for _,v in pairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
        end)

        -- ================= ELEMENTS =================
        function Tab:CreateButton(text, callback)
            local Btn = Create("TextButton",{
                Parent = Page,
                Text = text,
                Size = UDim2.new(1,-10,0,40),
                BackgroundColor3 = Theme.Tab,
                TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 14
            })
            Btn.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        function Tab:CreateToggle(text, default, callback)
            local state = default or false
            local Btn = Create("TextButton",{
                Parent = Page,
                Text = text.." : "..(state and "ON" or "OFF"),
                Size = UDim2.new(1,-10,0,40),
                BackgroundColor3 = Theme.Tab,
                TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 14
            })
            Btn.MouseButton1Click:Connect(function()
                state = not state
                Btn.Text = text.." : "..(state and "ON" or "OFF")
                if callback then callback(state) end
            end)
        end

        function Tab:CreateSlider(text,min,max,callback)
            local val = min
            local Btn = Create("TextButton",{
                Parent = Page,
                Text = text.." : "..val,
                Size = UDim2.new(1,-10,0,40),
                BackgroundColor3 = Theme.Tab,
                TextColor3 = Theme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 14
            })
            Btn.MouseButton1Click:Connect(function()
                val = math.clamp(val+1,min,max)
                Btn.Text = text.." : "..val
                if callback then callback(val) end
            end)
        end

        function Tab:CreateDropdown(text,list,callback)
            for _,v in pairs(list) do
                Tab:CreateButton(text.." : "..v,function()
                    callback(v)
                end)
            end
        end

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y+10)
        end)

        return Tab
    end

    return Window
end

return UI
