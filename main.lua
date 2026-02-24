-- // CONFIGURATION
local CorrectKey = "DVRK_2026_FREE" -- Change this to your desired key
local DiscordLink = "https://discord.gg/Eu5YnfC82q"

local function loadMainScript()
    -- // YOUR ORIGINAL SCRIPT STARTS HERE //
    local Player = game:GetService("Players").LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local MarketplaceService = game:GetService("MarketplaceService")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "dvrkPrisonbreak"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local function makeUICorner(parent, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = parent
    end

    local crosshair = Instance.new("ImageLabel", ScreenGui)
    crosshair.Size = UDim2.new(0, 150, 0, 150)
    crosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
    crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
    crosshair.Image = "rbxassetid://15963047755"
    crosshair.BackgroundTransparency = 1
    crosshair.BorderSizePixel = 0
    crosshair.Visible = false
    local aspectRatio = Instance.new("UIAspectRatioConstraint", crosshair)
    aspectRatio.AspectRatio = 1

    local AimlockEnabled = false

    local function tp(pos)
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end
    end

    local function CreateMiniGui(name, placeholder, property)
        local MiniFrame = Instance.new("Frame")
        MiniFrame.Name = name.."Gui"
        MiniFrame.Size = UDim2.new(0, 200, 0, 50)
        MiniFrame.Position = UDim2.new(0.5, -100, 0, 20)
        MiniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        MiniFrame.Visible = false
        MiniFrame.Parent = ScreenGui
        makeUICorner(MiniFrame, 8)

        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(0, 130, 0, 30)
        TextBox.Position = UDim2.new(0, 10, 0, 10)
        TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TextBox.TextColor3 = Color3.new(1, 1, 1)
        TextBox.PlaceholderText = placeholder
        TextBox.Text = ""
        TextBox.Parent = MiniFrame
        makeUICorner(TextBox, 5)

        local ApplyBtn = Instance.new("TextButton")
        ApplyBtn.Size = UDim2.new(0, 40, 0, 30)
        ApplyBtn.Position = UDim2.new(0, 150, 0, 10)
        ApplyBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
        ApplyBtn.Text = "Set"
        ApplyBtn.TextColor3 = Color3.new(1, 1, 1)
        ApplyBtn.Parent = MiniFrame
        makeUICorner(ApplyBtn, 5)

        ApplyBtn.MouseButton1Click:Connect(function()
            local val = tonumber(TextBox.Text)
            if val and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid[property] = val
            end
        end)
        return MiniFrame
    end

    local SpeedGui = CreateMiniGui("WalkSpeed", "Speed...", "WalkSpeed")
    local JumpGui = CreateMiniGui("JumpPower", "Power...", "JumpPower")

    local ReopenBtn = Instance.new("TextButton")
    ReopenBtn.Size = UDim2.new(0, 40, 0, 40)
    ReopenBtn.Position = UDim2.new(1, -50, 0, 10)
    ReopenBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    ReopenBtn.Text = "R"
    ReopenBtn.TextColor3 = Color3.new(1,1,1)
    ReopenBtn.Font = Enum.Font.GothamBold
    ReopenBtn.Visible = false
    ReopenBtn.Parent = ScreenGui
    makeUICorner(ReopenBtn, 8)

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 800, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    makeUICorner(MainFrame, 15)

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 30, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))})
    UIGradient.Rotation = 90
    UIGradient.Parent = MainFrame

    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Size = UDim2.new(1, 0, 0, 100)
    HeaderFrame.BackgroundTransparency = 1
    HeaderFrame.Parent = MainFrame

    local HeaderImage = Instance.new("ImageLabel")
    HeaderImage.Size = UDim2.new(1, 0, 1, 0)
    HeaderImage.BackgroundTransparency = 1
    HeaderImage.Image = "rbxassetid://125995267119449"
    HeaderImage.ScaleType = Enum.ScaleType.Fit
    HeaderImage.Parent = HeaderFrame
    makeUICorner(HeaderImage, 15)

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Text = "X"
    CloseBtn.Size = UDim2.new(0, 50, 0, 50)
    CloseBtn.Position = UDim2.new(1, -60, 0, 10)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 35
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = MainFrame
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local MinBtn = Instance.new("TextButton")
    MinBtn.Text = "-"
    MinBtn.Size = UDim2.new(0, 50, 0, 50)
    MinBtn.Position = UDim2.new(1, -110, 0, 5)
    MinBtn.BackgroundTransparency = 1
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.TextSize = 55
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.Parent = MainFrame

    local TabSidebar = Instance.new("ScrollingFrame")
    TabSidebar.Size = UDim2.new(0, 180, 1, -130)
    TabSidebar.Position = UDim2.new(1, -195, 0, 115)
    TabSidebar.BackgroundTransparency = 1
    TabSidebar.ScrollBarThickness = 2
    TabSidebar.Parent = MainFrame
    Instance.new("UIListLayout", TabSidebar).Padding = UDim.new(0, 10)

    local PageContainer = Instance.new("Frame")
    PageContainer.Size = UDim2.new(1, -220, 1, -130)
    PageContainer.Position = UDim2.new(0, 20, 0, 115)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Parent = MainFrame

    local Pages = {}
    local function CreatePage(name)
        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 4
        Page.Visible = false
        Page.Parent = PageContainer
        Pages[name] = Page
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 170, 0, 55)
        TabBtn.BackgroundTransparency = 0.9
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 20
        TabBtn.Parent = TabSidebar
        makeUICorner(TabBtn, 8)
        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages) do p.Visible = false end
            Page.Visible = true
        end)
    end

    CreatePage("Home"); CreatePage("Combat"); CreatePage("ESP"); CreatePage("Misc"); CreatePage("Players"); CreatePage("Settings")
    Pages["Home"].Visible = true

    local Home = Pages["Home"]
    local AvatarImg = Instance.new("ImageLabel", Home)
    AvatarImg.Size = UDim2.new(0, 130, 0, 130)
    AvatarImg.Position = UDim2.new(0, 20, 0, 10)
    AvatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..Player.UserId.."&width=420&height=420&format=png"
    makeUICorner(AvatarImg, 130)

    local UserInfo = Instance.new("TextLabel", Home)
    UserInfo.Size = UDim2.new(0, 250, 0, 120)
    UserInfo.Position = UDim2.new(0, 20, 0, 145)
    UserInfo.BackgroundTransparency = 1
    UserInfo.TextColor3 = Color3.new(1,1,1)
    UserInfo.Font = Enum.Font.GothamBold
    UserInfo.TextSize = 22
    UserInfo.TextXAlignment = Enum.TextXAlignment.Left

    local GameImg = Instance.new("ImageLabel", Home)
    GameImg.Size = UDim2.new(0, 230, 0, 130)
    GameImg.Position = UDim2.new(1, -250, 0, 10)
    makeUICorner(GameImg, 10)

    local GameInfo = Instance.new("TextLabel", Home)
    GameInfo.Size = UDim2.new(0, 250, 0, 150)
    GameInfo.Position = UDim2.new(1, -250, 0, 145)
    GameInfo.BackgroundTransparency = 1
    GameInfo.TextColor3 = Color3.new(1,1,1)
    GameInfo.Font = Enum.Font.GothamBold
    GameInfo.TextSize = 20
    GameInfo.TextXAlignment = Enum.TextXAlignment.Left
    GameInfo.TextWrapped = true

    task.spawn(function()
        local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
        if success then
            GameImg.Image = "rbxassetid://"..info.IconImageAssetId
            GameInfo.Text = "Game: "..info.Name.."\nCreator: "..info.Creator.Name.."\nPlayers: "..#game.Players:GetPlayers()
        end
    end)

    RunService.RenderStepped:Connect(function(dt)
        UserInfo.Text = "User: "..Player.Name.."\nDisplay: "..Player.DisplayName.."\nFPS: "..math.floor(1/dt)
    end)

    local function AddButton(parent, text, desc, func)
        local BtnFrame = Instance.new("Frame", parent)
        BtnFrame.Size = UDim2.new(1, -20, 0, 100)
        BtnFrame.BackgroundTransparency = 0.9
        BtnFrame.BackgroundColor3 = Color3.new(1,1,1)
        makeUICorner(BtnFrame, 10)
        local MainBtn = Instance.new("TextButton", BtnFrame)
        MainBtn.Size = UDim2.new(1, 0, 0, 60)
        MainBtn.BackgroundTransparency = 1
        MainBtn.Text = text
        MainBtn.TextColor3 = Color3.new(1,1,1)
        MainBtn.Font = Enum.Font.GothamBold
        MainBtn.TextSize = 24
        local SubText = Instance.new("TextLabel", BtnFrame)
        SubText.Size = UDim2.new(1, -10, 0, 40)
        SubText.Position = UDim2.new(0, 5, 0, 55)
        SubText.BackgroundTransparency = 1
        SubText.Text = desc
        SubText.TextColor3 = Color3.fromRGB(220,220,220)
        SubText.Font = Enum.Font.GothamMedium
        SubText.TextSize = 16
        SubText.TextWrapped = true
        MainBtn.MouseButton1Click:Connect(func)
        
        if parent:IsA("ScrollingFrame") then
            parent.CanvasSize = UDim2.new(0, 0, 0, parent:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y + 20)
        end
        return BtnFrame
    end

    local function AddDropdown(parent, colors, callback)
        local Drop = Instance.new("TextButton", parent)
        Drop.Size = UDim2.new(0, 90, 0, 30)
        Drop.Position = UDim2.new(1, -100, 0, 10)
        Drop.BackgroundColor3 = Color3.fromRGB(40,40,40)
        Drop.Text = "Color"
        Drop.TextColor3 = Color3.new(1,1,1)
        makeUICorner(Drop, 5)
        local index = 1
        Drop.MouseButton1Click:Connect(function()
            index = index + 1
            if index > #colors then index = 1 end
            Drop.Text = colors[index].Name
            callback(colors[index].Value)
        end)
    end

    local colorOptions = {{Name="Red", Value=Color3.new(1,0,0)}, {Name="Blue", Value=Color3.new(0,0,1)}, {Name="Green", Value=Color3.new(0,1,0)}, {Name="Yellow", Value=Color3.new(1,1,0)}, {Name="Black", Value=Color3.new(0,0,0)}, {Name="White", Value=Color3.new(1,1,1)}}

    local Combat = Pages["Combat"]
    Instance.new("UIListLayout", Combat).Padding = UDim.new(0, 12)

    AddButton(Combat, "Hitbox", "Head hitbox shoot near player", function()
        _G.HeadSize = 9
        _G.Disabled = true
        game:GetService('RunService').RenderStepped:connect(function()
            if _G.Disabled then
                for i,v in next, game:GetService('Players'):GetPlayers() do
                    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                        pcall(function()
                            v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
                            v.Character.Head.Transparency = 1
                            v.Character.Head.BrickColor = BrickColor.new("Red")
                            v.Character.Head.Material = "Neon"
                            v.Character.Head.CanCollide = false
                            v.Character.Head.Massless = true
                        end)
                    end
                end
            end
        end)
    end)

    AddButton(Combat, "Aim Lock", "Lock onto heads inside the red crosshair", function()
        AimlockEnabled = not AimlockEnabled
        crosshair.Visible = AimlockEnabled
    end)

    RunService.RenderStepped:Connect(function()
        if AimlockEnabled then
            local ScreenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
            local Closest = nil
            local MaxDist = crosshair.Size.X.Offset / 2
            local Camera = workspace.CurrentCamera

            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then
                    local ScreenPoint, OnScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
                    if OnScreen then
                        local Distance = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - ScreenCenter).Magnitude
                        if Distance < MaxDist then
                            Closest = v.Character.Head
                            MaxDist = Distance
                        end
                    end
                end
            end

            if Closest then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, Closest.Position)
            end
        end
    end)

    local islandBackup = nil
    AddButton(Combat, "wallbang", "removes prison walls and the ground", function()
        local target = workspace.Map:FindFirstChild("Prison_Island")
        if target then
            islandBackup = target
            target.Parent = nil
        elseif islandBackup then
            islandBackup.Parent = workspace.Map
        end
    end)

    local ESPPage = Pages["ESP"]
    Instance.new("UIListLayout", ESPPage).Padding = UDim.new(0, 12)
    local bodyColor, nameColor, healthColor = Color3.new(1,0,0), Color3.new(1,1,1), Color3.new(0,1,0)
    local bT, nT, hT = false, false, false

    local function ApplyESP(v)
        if v == Player or not v.Character then return end
        local hl = v.Character:FindFirstChild("dvrkHighlight") or Instance.new("Highlight", v.Character)
        hl.Name = "dvrkHighlight"
        hl.FillColor = bodyColor
        hl.Enabled = bT
        local head = v.Character:FindFirstChild("Head")
        if head then
            local bb = head:FindFirstChild("dvrkEsp") or Instance.new("BillboardGui", head)
            bb.Name = "dvrkEsp"
            bb.AlwaysOnTop = true
            bb.Size = UDim2.new(0,150,0,70)
            bb.Enabled = (nT or hT)
            local lbl = bb:FindFirstChild("Name") or Instance.new("TextLabel", bb)
            lbl.Name = "Name"
            lbl.Size = UDim2.new(1,0,0,30)
            lbl.Text = v.Name
            lbl.TextColor3 = nameColor
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 24
            lbl.Visible = nT
            local hlbl = bb:FindFirstChild("Health") or Instance.new("TextLabel", bb)
            hlbl.Name = "Health"
            hlbl.Size = UDim2.new(1,0,0,30)
            hlbl.Position = UDim2.new(0,0,0,30)
            hlbl.TextColor3 = healthColor
            hlbl.BackgroundTransparency = 1
            hlbl.TextSize = 20
            hlbl.Visible = hT
        end
    end

    RunService.RenderStepped:Connect(function()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Character then
                ApplyESP(v)
                if hT and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("dvrkEsp") then
                    local hlbl = v.Character.Head.dvrkEsp:FindFirstChild("Health")
                    local hum = v.Character:FindFirstChild("Humanoid")
                    if hlbl and hum then
                        hlbl.Text = math.floor(hum.Health).." HP"
                    end
                end
            end
        end
    end)

    local bB = AddButton(ESPPage, "body esp", "see everyone thru walls", function() bT = not bT end)
    AddDropdown(bB, colorOptions, function(c) bodyColor = c end)
    local nB = AddButton(ESPPage, "Name esp", "See names", function() nT = not nT end)
    AddDropdown(nB, colorOptions, function(c) nameColor = c end)
    local hB = AddButton(ESPPage, "health esp", "see health", function() hT = not hT end)
    AddDropdown(hB, colorOptions, function(c) healthColor = c end)

    local function kill(target)
        if not target or not target.Character then return end
        local hum = target.Character:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then return end
        local melee = Player.Character and (Player.Character:FindFirstChild("Police_Melee_5") or Player.Backpack:FindFirstChild("Police_Melee_5"))
        if melee then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"PlayerDidMeleeAttack"})
            local mod = require(game:GetService("ReplicatedStorage").ClientModuleStorage.FunctionStorage_Module)
            local val = 0
            for i, y in pairs(debug.getupvalues(mod.MeleeAttack)) do if i == 7 then val = string.reverse(y) * 4761 * 255 end end
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer({"MeleeAttack", melee:FindFirstChild("Hitbox") or melee.Hitbox, hum, val, nil, 0.5, 5})
        end
    end

    local Misc = Pages["Misc"]
    Instance.new("UIListLayout", Misc).Padding = UDim.new(0, 12)

    AddButton(Misc, "kill cop", "kill all police", function() 
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Team and v.Team.Name == "Police" then
                kill(v)
                task.wait(1)
            end
        end
    end)

    AddButton(Misc, "kill prisoners", "kill all prisoners", function() 
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Team and v.Team.Name == "Prisoner" then
                kill(v)
                task.wait(1)
            end
        end
    end)

    AddButton(Misc, "kill criminals", "kill all criminals", function() 
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Team and v.Team.Name == "Criminal" then
                kill(v)
                task.wait(1)
            end
        end
    end)

    AddButton(Misc, "kill all", "kill everyone in the server", function() 
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player then
                kill(v)
                task.wait(1)
            end
        end
    end)

    AddButton(Misc, "auto escape", "escape prison instantly", function()
        tp(Vector3.new(14, 10000, -14))
        repeat task.wait(0.01) until Player.Team == game.Teams.Criminal
        game.ReplicatedStorage.RemoteEvent:FireServer({"RequestResetCharacter"})
    end)

    local Settings = Pages["Settings"]
    Instance.new("UIListLayout", Settings).Padding = UDim.new(0, 12)
    AddButton(Settings, "Walk Speed", "control speed", function() SpeedGui.Visible = not SpeedGui.Visible end)
    AddButton(Settings, "Jump Power", "control jump", function() JumpGui.Visible = not JumpGui.Visible end)
    AddButton(Settings, "Anti Kick", "bypass kicks", function()
        task.wait(10)
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
        if not remote then return end
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local m = getnamecallmethod()
            local a = {...}
            if self == remote and m == "FireServer" and typeof(a[1]) == "table" and a[1][1] == "KickPlayer" then
                warn("bypassed luh fn")
                return nil
            end
            return old(self, ...)
        end)
        setreadonly(mt, true)
        warn("bypassed by hero luh fn")
    end)

    local PlayersPage = Pages["Players"]
    local SelectedPlayer = nil
    local viewing = false

    local PlayerListFrame = Instance.new("ScrollingFrame")
    PlayerListFrame.Size = UDim2.new(0.5, -10, 1, 0)
    PlayerListFrame.BackgroundTransparency = 1
    PlayerListFrame.ScrollBarThickness = 6
    PlayerListFrame.ScrollBarImageColor3 = Color3.new(1,0,0)
    PlayerListFrame.Parent = PlayersPage
    local PL_Layout = Instance.new("UIListLayout", PlayerListFrame)
    PL_Layout.Padding = UDim.new(0, 8)

    local ActionFrame = Instance.new("Frame")
    ActionFrame.Size = UDim2.new(0.5, -10, 1, 0)
    ActionFrame.Position = UDim2.new(0.5, 10, 0, 0)
    ActionFrame.BackgroundTransparency = 1
    ActionFrame.Parent = PlayersPage
    local ActionLayout = Instance.new("UIListLayout", ActionFrame)
    ActionLayout.Padding = UDim.new(0, 15)

    local function CreateActionBtn(text, func)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 65)
        b.BackgroundTransparency = 0.9
        b.Text = text
        b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 22
        b.Parent = ActionFrame
        makeUICorner(b, 8)
        b.MouseButton1Click:Connect(function() func(b) end)
    end

    CreateActionBtn("teleport to", function() if SelectedPlayer then Player.Character:SetPrimaryPartCFrame(SelectedPlayer.Character.HumanoidRootPart.CFrame) end end)
    CreateActionBtn("view", function(btn)
        if not SelectedPlayer then return end
        viewing = not viewing
        workspace.CurrentCamera.CameraSubject = viewing and SelectedPlayer.Character.Humanoid or Player.Character.Humanoid
        btn.BackgroundTransparency = viewing and 0 or 0.9
        btn.BackgroundColor3 = viewing and Color3.new(0,1,0) or Color3.new(1,1,1)
    end)
    CreateActionBtn("kill", function() if SelectedPlayer then kill(SelectedPlayer) end end)
    CreateActionBtn("loopkill", function(btn)
        if not SelectedPlayer then return end
        _G.LoopK = not _G.LoopK
        btn.BackgroundTransparency = _G.LoopK and 0 or 0.9
        btn.BackgroundColor3 = _G.LoopK and Color3.new(0,1,0) or Color3.new(1,1,1)
        task.spawn(function() while _G.LoopK and SelectedPlayer do kill(SelectedPlayer) task.wait(0.5) end end)
    end)

    local function UpdatePlayerList()
        for _, v in pairs(PlayerListFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for _, p in pairs(game.Players:GetPlayers()) do
            local pBtn = Instance.new("TextButton", PlayerListFrame)
            pBtn.Size = UDim2.new(1, 0, 0, 75)
            pBtn.Text = "              " .. p.Name 
            pBtn.TextColor3 = Color3.new(1,1,1)
            pBtn.TextSize = 20
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            pBtn.BackgroundTransparency = (SelectedPlayer == p) and 0 or 0.9
            pBtn.BackgroundColor3 = (SelectedPlayer == p) and Color3.new(0,1,0) or Color3.new(1,1,1)
            makeUICorner(pBtn, 10)
            local pImg = Instance.new("ImageLabel", pBtn)
            pImg.Size = UDim2.new(0, 60, 0, 60)
            pImg.Position = UDim2.new(0, 10, 0, 7.5)
            pImg.BackgroundTransparency = 1
            pImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..p.UserId.."&width=420&height=420&format=png"
            makeUICorner(pImg, 60)
            pBtn.MouseButton1Click:Connect(function()
                if SelectedPlayer == p then SelectedPlayer = nil else SelectedPlayer = p end
                UpdatePlayerList()
            end)
        end
        PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, PL_Layout.AbsoluteContentSize.Y + 50)
    end

    UpdatePlayerList()
    game.Players.PlayerAdded:Connect(UpdatePlayerList); game.Players.PlayerRemoving:Connect(UpdatePlayerList)
    MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; ReopenBtn.Visible = true end)
    ReopenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; ReopenBtn.Visible = false end)
    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = input.Position; startPos = MainFrame.Position end end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    -- // YOUR ORIGINAL SCRIPT ENDS HERE //
end

-- // KEY SYSTEM UI //
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "DVRK_KeySystem"
KeyGui.Parent = game:GetService("CoreGui") 

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui
local UICorner = Instance.new("UICorner", KeyFrame)

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "DVRK PRISONBREAK | KEY SYSTEM"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", KeyFrame)
Desc.Size = UDim2.new(1, -40, 0, 40)
Desc.Position = UDim2.new(0, 20, 0, 50)
Desc.Text = "Join the Discord to get the key:"
Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 14
Desc.BackgroundTransparency = 1

local LinkBox = Instance.new("TextBox", KeyFrame)
LinkBox.Size = UDim2.new(1, -40, 0, 30)
LinkBox.Position = UDim2.new(0, 20, 0, 90)
LinkBox.Text = DiscordLink
LinkBox.ClearTextOnFocus = false
LinkBox.ReadOnly = true
LinkBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LinkBox.TextColor3 = Color3.fromRGB(220, 30, 30)
Instance.new("UICorner", LinkBox)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -40, 0, 40)
KeyInput.Position = UDim2.new(0, 20, 0, 140)
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(1, -40, 0, 40)
SubmitBtn.Position = UDim2.new(0, 20, 0, 195)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
SubmitBtn.Text = "Verify Key"
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn)

-- // KEY SYSTEM LOGIC //
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        SubmitBtn.Text = "Access Granted!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        task.wait(1)
        KeyGui:Destroy()
        loadMainScript() 
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "INVALID KEY"
        KeyInput.PlaceholderColor3 = Color3.new(1, 0, 0)
        task.wait(1)
        KeyInput.PlaceholderText = "Enter Key Here..."
        KeyInput.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
    end
end)
