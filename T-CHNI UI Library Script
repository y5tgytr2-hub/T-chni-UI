--==================================================
-- T-CHNI UI LIBRARY | Rayfield / Orion Style
-- Mobile + PC | Single File
--==================================================

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

pcall(function()
    CoreGui:FindFirstChild("TchniHubUI"):Destroy()
end)

--================ LIBRARY =================
local Library = {}

Library.Theme = {
    Main   = Color3.fromRGB(25,25,25),
    Top    = Color3.fromRGB(35,35,35),
    Side   = Color3.fromRGB(30,30,30),
    Item   = Color3.fromRGB(45,45,45),
    Accent = Color3.fromRGB(0,170,255),
    Text   = Color3.new(1,1,1)
}

--================ UTILS =================
local function Tween(o,p,t)
    TweenService:Create(
        o,
        TweenInfo.new(t or 0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
        p
    ):Play()
end

local function Drag(main, drag)
    local d,s,sp
    drag.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            d=true s=i.Position sp=main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if d and (i.UserInputType==Enum.UserInputType.MouseMovement
        or i.UserInputType==Enum.UserInputType.Touch) then
            local delta=i.Position-s
            main.Position=UDim2.new(
                sp.X.Scale,sp.X.Offset+delta.X,
                sp.Y.Scale,sp.Y.Offset+delta.Y
            )
        end
    end)
    UIS.InputEnded:Connect(function() d=false end)
end

--================ WINDOW =================
function Library:CreateWindow(cfg)
    local Window = {}
    cfg = cfg or {}

    local Gui = Instance.new("ScreenGui",CoreGui)
    Gui.Name = "TchniHubUI"

    local Main = Instance.new("Frame",Gui)
    Main.Size = UDim2.fromScale(0.7,0.85)
    Main.Position = UDim2.fromScale(0.15,0.05)
    Main.BackgroundColor3 = self.Theme.Main
    Main.BorderSizePixel = 0
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)

    local Top = Instance.new("Frame",Main)
    Top.Size = UDim2.new(1,0,0,45)
    Top.BackgroundColor3 = self.Theme.Top
    Top.BorderSizePixel = 0
    Instance.new("UICorner",Top).CornerRadius = UDim.new(0,14)

    local Title = Instance.new("TextLabel",Top)
    Title.Size = UDim2.new(1,0,1,0)
    Title.BackgroundTransparency = 1
    Title.Text = cfg.Name or "T-chni Hub"
    Title.TextColor3 = self.Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    Drag(Main,Top)

    local Side = Instance.new("Frame",Main)
    Side.Size = UDim2.new(0,150,1,-45)
    Side.Position = UDim2.new(0,0,0,45)
    Side.BackgroundColor3 = self.Theme.Side
    Side.BorderSizePixel = 0

    local TabLayout = Instance.new("UIListLayout",Side)
    TabLayout.Padding = UDim.new(0,8)

    local Pages = Instance.new("Frame",Main)
    Pages.Size = UDim2.new(1,-160,1,-55)
    Pages.Position = UDim2.new(0,155,0,50)
    Pages.BackgroundTransparency = 1

    --=========== TAB ===========
    function Window:CreateTab(tabcfg)
        local Tab = {}
        tabcfg = tabcfg or {}

        local Btn = Instance.new("TextButton",Side)
        Btn.Size = UDim2.new(1,-10,0,40)
        Btn.Text = tabcfg.Name or "Tab"
        Btn.BackgroundColor3 = Library.Theme.Item
        Btn.TextColor3 = Library.Theme.Text
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.BorderSizePixel = 0
        Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,8)

        local Page = Instance.new("ScrollingFrame",Pages)
        Page.Size = UDim2.new(1,0,1,0)
        Page.CanvasSize = UDim2.new()
        Page.ScrollBarImageTransparency = 1
        Page.Visible = false

        local Layout = Instance.new("UIListLayout",Page)
        Layout.Padding = UDim.new(0,8)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y+10)
        end)

        Btn.MouseButton1Click:Connect(function()
            for _,v in pairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible=false end
            end
            Page.Visible=true
        end)

        --========== SECTION ==========
        function Tab:CreateSection(o)
            local L = Instance.new("TextLabel",Page)
            L.Size = UDim2.new(1,-10,0,30)
            L.BackgroundTransparency = 1
            L.Text = o.Name or ""
            L.TextXAlignment = Left
            L.TextColor3 = Color3.fromRGB(200,200,200)
            L.Font = Enum.Font.GothamBold
            L.TextSize = 14
        end

        --========== BUTTON ==========
        function Tab:CreateButton(o)
            local B = Instance.new("TextButton",Page)
            B.Size = UDim2.new(1,-10,0,40)
            B.Text = o.Name
            B.BackgroundColor3 = Library.Theme.Item
            B.TextColor3 = Library.Theme.Text
            B.Font = Enum.Font.Gotham
            B.TextSize = 14
            Instance.new("UICorner",B).CornerRadius = UDim.new(0,8)

            B.MouseButton1Click:Connect(function()
                Tween(B,{BackgroundColor3=Library.Theme.Accent},0.15)
                task.wait(0.1)
                Tween(B,{BackgroundColor3=Library.Theme.Item},0.15)
                if o.Callback then o.Callback() end
            end)
        end

        --========== TOGGLE ==========
        function Tab:CreateToggle(o)
            local state = o.Default or false
            local T = Instance.new("TextButton",Page)
            T.Size = UDim2.new(1,-10,0,40)
            T.Text = o.Name
            T.BackgroundColor3 = state and Library.Theme.Accent or Library.Theme.Item
            T.TextColor3 = Library.Theme.Text
            T.Font = Enum.Font.Gotham
            T.TextSize = 14
            Instance.new("UICorner",T).CornerRadius = UDim.new(0,8)

            T.MouseButton1Click:Connect(function()
                state = not state
                Tween(T,{BackgroundColor3=state and Library.Theme.Accent or Library.Theme.Item},0.2)
                if o.Callback then o.Callback(state) end
            end)
        end

        --========== SLIDER ==========
        function Tab:CreateSlider(o)
            local min,max = o.Range[1],o.Range[2]
            local val = o.Default or min

            local H = Instance.new("Frame",Page)
            H.Size = UDim2.new(1,-10,0,55)
            H.BackgroundColor3 = Library.Theme.Item
            Instance.new("UICorner",H).CornerRadius = UDim.new(0,8)

            local L = Instance.new("TextLabel",H)
            L.Size = UDim2.new(1,0,0,20)
            L.BackgroundTransparency = 1
            L.Text = o.Name.." : "..val
            L.TextColor3 = Library.Theme.Text
            L.Font = Enum.Font.Gotham
            L.TextSize = 13

            local Bar = Instance.new("Frame",H)
            Bar.Size = UDim2.new(1,-20,0,6)
            Bar.Position = UDim2.new(0,10,0,35)
            Bar.BackgroundColor3 = Color3.fromRGB(60,60,60)
            Instance.new("UICorner",Bar).CornerRadius = UDim.new(1,0)

            local Fill = Instance.new("Frame",Bar)
            Fill.Size = UDim2.new((val-min)/(max-min),0,1,0)
            Fill.BackgroundColor3 = Library.Theme.Accent
            Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

            local drag=false
            Bar.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1
                or i.UserInputType==Enum.UserInputType.Touch then drag=true end
            end)

            UIS.InputChanged:Connect(function(i)
                if drag then
                    local p = math.clamp(
                        (i.Position.X-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
                    Tween(Fill,{Size=UDim2.new(p,0,1,0)},0.08)
                    val = math.floor(min+(max-min)*p)
                    L.Text = o.Name.." : "..val
                    if o.Callback then o.Callback(val) end
                end
            end)

            UIS.InputEnded:Connect(function() drag=false end)
        end

        --========== DROPDOWN SINGLE ==========
        function Tab:CreateDropdownSingle(o)
            local open=false sel=nil

            local H=Instance.new("Frame",Page)
            H.Size=UDim2.new(1,-10,0,40)
            H.BackgroundTransparency=1
            H.ClipsDescendants=true

            local M=Instance.new("TextButton",H)
            M.Size=UDim2.new(1,0,0,40)
            M.Text=o.Name.." ▼"
            M.BackgroundColor3=Library.Theme.Item
            M.TextColor3=Library.Theme.Text
            M.Font=Enum.Font.Gotham
            M.TextSize=14
            Instance.new("UICorner",M).CornerRadius=UDim.new(0,8)

            local I=Instance.new("Frame",H)
            I.Position=UDim2.new(0,0,0,45)
            I.Size=UDim2.new(1,0,0,0)
            I.ClipsDescendants=true

            local L=Instance.new("UIListLayout",I)
            L.Padding=UDim.new(0,4)

            local function ref()
                local h=L.AbsoluteContentSize.Y
                Tween(I,{Size=UDim2.new(1,0,0,open and h or 0)},0.25)
                Tween(H,{Size=UDim2.new(1,-10,0,open and (45+h) or 40)},0.25)
                M.Text=(sel and (o.Name.." : "..sel) or o.Name)..(open and " ▲" or " ▼")
            end

            M.MouseButton1Click:Connect(function() open=not open ref() end)

            for _,v in ipairs(o.Options) do
                local B=Instance.new("TextButton",I)
                B.Size=UDim2.new(1,0,0,30)
                B.Text=v
                B.BackgroundColor3=Library.Theme.Item
                B.TextColor3=Library.Theme.Text
                B.Font=Enum.Font.Gotham
                B.TextSize=13
                Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)

                B.MouseButton1Click:Connect(function()
                    sel=v open=false ref()
                    if o.Callback then o.Callback(v) end
                end)
            end
        end

        --========== DROPDOWN MULTI ==========
        function Tab:CreateDropdownMulti(o)
            local open=false sel={}

            local function text()
                return #sel==0 and o.Name or o.Name.." : "..table.concat(sel,", ")
            end

            local H=Instance.new("Frame",Page)
            H.Size=UDim2.new(1,-10,0,40)
            H.BackgroundTransparency=1
            H.ClipsDescendants=true

            local M=Instance.new("TextButton",H)
            M.Size=UDim2.new(1,0,0,40)
            M.Text=o.Name.." ▼"
            M.BackgroundColor3=Library.Theme.Item
            M.TextColor3=Library.Theme.Text
            M.Font=Enum.Font.Gotham
            M.TextSize=14
            Instance.new("UICorner",M).CornerRadius=UDim.new(0,8)

            local I=Instance.new("Frame",H)
            I.Position=UDim2.new(0,0,0,45)
            I.Size=UDim2.new(1,0,0,0)
            I.ClipsDescendants=true

            local L=Instance.new("UIListLayout",I)
            L.Padding=UDim.new(0,4)

            local function ref()
                local h=L.AbsoluteContentSize.Y
                Tween(I,{Size=UDim2.new(1,0,0,open and h or 0)},0.25)
                Tween(H,{Size=UDim2.new(1,-10,0,open and (45+h) or 40)},0.25)
                M.Text=text()..(open and " ▲" or " ▼")
            end

            M.MouseButton1Click:Connect(function() open=not open ref() end)

            for _,v in ipairs(o.Options) do
                local B=Instance.new("TextButton",I)
                B.Size=UDim2.new(1,0,0,30)
                B.Text="☐ "..v
                B.BackgroundColor3=Library.Theme.Item
                B.TextColor3=Library.Theme.Text
                B.Font=Enum.Font.Gotham
                B.TextSize=13
                Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)

                B.MouseButton1Click:Connect(function()
                    local f=false
                    for i,x in ipairs(sel) do
                        if x==v then table.remove(sel,i) f=true break end
                    end
                    if not f then table.insert(sel,v) end
                    B.Text=(f and "☐ " or "☑ ")..v
                    Tween(B,{BackgroundColor3=f and Library.Theme.Item or Library.Theme.Accent},0.15)
                    ref()
                    if o.Callback then o.Callback(sel) end
                end)
            end
        end

        Page.Visible=true
        return Tab
    end

    -- FLOAT BUTTON
    if cfg.MobileButton ~= false then
        local show=true
        local F=Instance.new("TextButton",Gui)
        F.Size=UDim2.new(0,55,0,55)
        F.Position=UDim2.new(0,20,0.5,-25)
        F.Text="UI"
        F.Font=Enum.Font.GothamBold
        F.TextSize=14
        F.BackgroundColor3=Library.Theme.Accent
        F.TextColor3=Color3.new(1,1,1)
        Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)

        F.MouseButton1Click:Connect(function()
            show=not show
            Tween(Main,{Position=show and UDim2.fromScale(0.15,0.05)
            or UDim2.fromScale(0.15,1.3)},0.35)
        end)
    end

    return Window
end

return Library
