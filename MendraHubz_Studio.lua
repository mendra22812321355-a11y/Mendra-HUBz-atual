-- MENDRA HUBZ - versão segura para Roblox Studio
-- Coloque como LocalScript em StarterPlayer > StarterPlayerScripts.
-- Não inclui auto-shoot, auto-knife, ESP ou automação de combate.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("MendraHubz")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "MendraHubz"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function make(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props or {}) do obj[key] = value end
    obj.Parent = parent
    return obj
end

local blue = Color3.fromRGB(25, 105, 185)
local dark = Color3.fromRGB(8, 23, 42)
local panelColor = Color3.fromRGB(15, 43, 73)
local white = Color3.fromRGB(235, 245, 255)

local window = make("Frame", {
    Name = "Window",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.92, 0, 0.62, 0),
    BackgroundColor3 = dark,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)
make("UISizeConstraint", {MinSize = Vector2.new(290, 300), MaxSize = Vector2.new(560, 440)}, window)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, window)
make("UIStroke", {Color = Color3.fromRGB(70, 160, 230), Thickness = 1.5}, window)

local top = make("Frame", {
    Size = UDim2.new(1, 0, 0, 54),
    BackgroundColor3 = blue,
    BorderSizePixel = 0,
}, window)
make("TextLabel", {
    Position = UDim2.fromOffset(14, 0),
    Size = UDim2.new(1, -65, 1, 0),
    BackgroundTransparency = 1,
    Text = "MENDRA HUBZ",
    TextColor3 = white,
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local close = make("TextButton", {
    Position = UDim2.new(1, -43, 0, 10),
    Size = UDim2.fromOffset(32, 32),
    BackgroundColor3 = Color3.fromRGB(165, 55, 65),
    Text = "X",
    TextColor3 = white,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    BorderSizePixel = 0,
}, top)
make("UICorner", {CornerRadius = UDim.new(0, 7)}, close)
close.Activated:Connect(function() gui:Destroy() end)

-- Arrastar com mouse ou toque
local dragging, dragInput, dragStart, startPosition
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

local nav = make("Frame", {
    Position = UDim2.fromOffset(9, 64),
    Size = UDim2.new(0, 112, 1, -73),
    BackgroundColor3 = panelColor,
    BorderSizePixel = 0,
}, window)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, nav)

local content = make("Frame", {
    Position = UDim2.fromOffset(129, 64),
    Size = UDim2.new(1, -138, 1, -73),
    BackgroundColor3 = panelColor,
    BorderSizePixel = 0,
}, window)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, content)

local pages = {}
local function createPage(name)
    local page = make("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        Visible = false,
    }, content)
    make("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
    }, page)
    make("UIListLayout", {Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder}, page)
    pages[name] = page
    return page
end

local function addLabel(parent, value, height)
    return make("TextLabel", {
        Size = UDim2.new(1, 0, 0, height or 36),
        BackgroundColor3 = Color3.fromRGB(22, 62, 100),
        BorderSizePixel = 0,
        Text = value,
        TextColor3 = white,
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextWrapped = true,
    }, parent)
end

local function addButton(parent, value, callback)
    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = blue,
        BorderSizePixel = 0,
        Text = value,
        TextColor3 = white,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
    }, parent)
    make("UICorner", {CornerRadius = UDim.new(0, 7)}, button)
    button.Activated:Connect(callback)
    return button
end

local home = createPage("Home")
addLabel(home, "MENU PRINCIPAL", 36)
addLabel(home, "Bem-vindo ao Mendra Hubz!", 38)
addLabel(home, "Interface azul, arrastável e adaptada para toque.", 48)
addLabel(home, "Este hub contém apenas ferramentas visuais e informativas permitidas.", 58)

local owners = createPage("Owners")
addLabel(owners, "OWNERS / DEVS", 36)
addLabel(owners, "mendra_fogo — OWNER SCRIPT")
addLabel(owners, "mendra_fogoo — ADMIN")
addLabel(owners, "wowoxi4 — ADMIN AJUDANTE")
addLabel(owners, "wowoxi_33 — ADMIN AJUDANTE")

local boombox = createPage("Boombox")
addLabel(boombox, "BOOMBOX — CATÁLOGO MANUAL", 36)
addLabel(boombox, "Adicione nomes e IDs de áudios autorizados no catálogo do seu próprio jogo.", 54)

local catalog = {
    -- {name = "Nome da música", id = "1234567890"},
}

local search = make("TextBox", {
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = dark,
    BorderSizePixel = 0,
    PlaceholderText = "Pesquisar música...",
    Text = "",
    TextColor3 = white,
    PlaceholderColor3 = Color3.fromRGB(160, 185, 205),
    Font = Enum.Font.Gotham,
    TextSize = 13,
    ClearTextOnFocus = false,
}, boombox)
make("UICorner", {CornerRadius = UDim.new(0, 7)}, search)

local selectedId = make("TextBox", {
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = dark,
    BorderSizePixel = 0,
    PlaceholderText = "ID selecionado aparecerá aqui",
    Text = "",
    TextColor3 = white,
    PlaceholderColor3 = Color3.fromRGB(160, 185, 205),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    ClearTextOnFocus = false,
}, boombox)
make("UICorner", {CornerRadius = UDim.new(0, 7)}, selectedId)

local resultFrame = make("Frame", {
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
}, boombox)
make("UIListLayout", {Padding = UDim.new(0, 6)}, resultFrame)

local function refreshCatalog()
    for _, child in ipairs(resultFrame:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") then child:Destroy() end
    end
    local term = string.lower(search.Text)
    local count = 0
    for _, item in ipairs(catalog) do
        if string.find(string.lower(item.name), term, 1, true) then
            count += 1
            addButton(resultFrame, item.name .. " | ID: " .. item.id, function()
                selectedId.Text = tostring(item.id)
            end)
        end
    end
    if count == 0 then
        addLabel(resultFrame, "Nenhum áudio encontrado no catálogo.", 40)
    end
end
search:GetPropertyChangedSignal("Text"):Connect(refreshCatalog)
refreshCatalog()

local tabButtons = {}
local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    for pageName, button in pairs(tabButtons) do
        button.BackgroundColor3 = pageName == name
            and Color3.fromRGB(40, 135, 210)
            or Color3.fromRGB(18, 65, 108)
    end
end

for _, info in ipairs({
    {"Home", "INÍCIO"},
    {"Owners", "OWNERS"},
    {"Boombox", "BOOMBOX"},
}) do
    local pageName, title = info[1], info[2]
    tabButtons[pageName] = addButton(nav, title, function()
        showPage(pageName)
    end)
end

showPage("Home")
