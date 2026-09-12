--// AERO
--// Roblox Studio LocalScript
--// Place inside StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------------------
-- CLEANUP
----------------------------------------------------------------

local OldGui = PlayerGui:FindFirstChild("Aero")

if OldGui then
	OldGui:Destroy()
end

----------------------------------------------------------------
-- COLORS
----------------------------------------------------------------

local C = {
	Background = Color3.fromRGB(25, 25, 25),
	Panel = Color3.fromRGB(30, 30, 30),
	Panel2 = Color3.fromRGB(36, 36, 36),
	Hover = Color3.fromRGB(45, 45, 45),

	Border = Color3.fromRGB(58, 58, 58),

	Text = Color3.fromRGB(200, 200, 200),
	SubText = Color3.fromRGB(145, 145, 145),

	Accent = Color3.fromRGB(200, 200, 200),
	Off = Color3.fromRGB(65, 65, 65)
}

----------------------------------------------------------------
-- HELPERS
----------------------------------------------------------------

local function New(Class, Properties, Parent)
	local Object = Instance.new(Class)

	for Property, Value in pairs(Properties or {}) do
		Object[Property] = Value
	end

	Object.Parent = Parent

	return Object
end

local function Corner(Object, Radius)
	local CornerObject = Instance.new("UICorner")
	CornerObject.CornerRadius = UDim.new(0, Radius)
	CornerObject.Parent = Object
	return CornerObject
end

local function Stroke(Object, Color, Thickness)
	local ObjectStroke = Instance.new("UIStroke")

	ObjectStroke.Color = Color or C.Border
	ObjectStroke.Thickness = Thickness or 1

	ObjectStroke.Parent = Object

	return ObjectStroke
end

local function Tween(Object, Properties, Time)
	TweenService:Create(
		Object,
		TweenInfo.new(
			Time or 0.15,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		Properties
	):Play()
end

----------------------------------------------------------------
-- SCREEN GUI
----------------------------------------------------------------

local Gui = New("ScreenGui", {
	Name = "Aero",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Global
}, PlayerGui)

----------------------------------------------------------------
-- MAIN WINDOW
----------------------------------------------------------------

local Main = New("Frame", {
	Name = "Main",

	Size = UDim2.fromOffset(700, 450),

	Position = UDim2.new(
		0.5,
		-350,
		0.5,
		-225
	),

	BackgroundColor3 = C.Background,

	BorderSizePixel = 0,

	ClipsDescendants = true
}, Gui)

Corner(Main, 8)
Stroke(Main)

----------------------------------------------------------------
-- TOP BAR
----------------------------------------------------------------

local Top = New("Frame", {
	Name = "Top",

	Size = UDim2.new(1, 0, 0, 46),

	BackgroundColor3 = C.Panel,

	BorderSizePixel = 0
}, Main)

Corner(Top, 8)

-- Square off the bottom corners of the top bar.
New("Frame", {
	Position = UDim2.new(0, 0, 1, -8),

	Size = UDim2.new(1, 0, 0, 8),

	BackgroundColor3 = C.Panel,

	BorderSizePixel = 0
}, Top)

----------------------------------------------------------------
-- TITLE
----------------------------------------------------------------

New("TextLabel", {
	Position = UDim2.fromOffset(14, 0),

	Size = UDim2.fromOffset(48, 46),

	BackgroundTransparency = 1,

	Text = "Aero",

	TextColor3 = C.Text,

	TextSize = 15,

	Font = Enum.Font.GothamMedium,

	TextXAlignment = Enum.TextXAlignment.Left
}, Top)

New("TextLabel", {
	Position = UDim2.fromOffset(58, 0),

	Size = UDim2.fromOffset(55, 46),

	BackgroundTransparency = 1,

	Text = "DEMO",

	TextColor3 = C.SubText,

	TextSize = 8,

	Font = Enum.Font.GothamBold,

	TextXAlignment = Enum.TextXAlignment.Left
}, Top)

----------------------------------------------------------------
-- SEARCH
----------------------------------------------------------------

local Search = New("TextBox", {
	Position = UDim2.new(1, -300, 0, 9),

	Size = UDim2.fromOffset(220, 28),

	BackgroundColor3 = C.Panel2,

	BorderSizePixel = 0,

	PlaceholderText = "Search modules...",

	PlaceholderColor3 = C.SubText,

	Text = "",

	TextColor3 = C.Text,

	TextSize = 10,

	Font = Enum.Font.Gotham,

	ClearTextOnFocus = false,

	TextXAlignment = Enum.TextXAlignment.Left
}, Top)

Corner(Search, 5)
Stroke(Search)

New("UIPadding", {
	PaddingLeft = UDim.new(0, 9),
	PaddingRight = UDim.new(0, 9)
}, Search)

----------------------------------------------------------------
-- CLOSE
----------------------------------------------------------------

local Close = New("TextButton", {
	Position = UDim2.new(1, -55, 0, 8),

	Size = UDim2.fromOffset(35, 30),

	BackgroundTransparency = 1,

	Text = "X",

	TextColor3 = C.SubText,

	TextSize = 12,

	Font = Enum.Font.GothamMedium,

	AutoButtonColor = false
}, Top)

Close.MouseEnter:Connect(function()
	Tween(Close, {
		TextColor3 = C.Text
	}, 0.12)
end)

Close.MouseLeave:Connect(function()
	Tween(Close, {
		TextColor3 = C.SubText
	}, 0.12)
end)

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

----------------------------------------------------------------
-- SIDEBAR
----------------------------------------------------------------

local Sidebar = New("Frame", {
	Name = "Sidebar",

	Position = UDim2.fromOffset(0, 46),

	Size = UDim2.new(0, 155, 1, -46),

	BackgroundColor3 = C.Panel,

	BorderSizePixel = 0
}, Main)

New("UIPadding", {
	PaddingTop = UDim.new(0, 12),
	PaddingLeft = UDim.new(0, 9),
	PaddingRight = UDim.new(0, 9)
}, Sidebar)

New("UIListLayout", {
	Padding = UDim.new(0, 4),
	SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

----------------------------------------------------------------
-- CONTENT
----------------------------------------------------------------

local Content = New("Frame", {
	Name = "Content",

	Position = UDim2.fromOffset(155, 46),

	Size = UDim2.new(1, -155, 1, -46),

	BackgroundColor3 = C.Background,

	BorderSizePixel = 0
}, Main)

----------------------------------------------------------------
-- NOTIFICATIONS
----------------------------------------------------------------

local Notifications = New("Frame", {
	Name = "Notifications",

	Position = UDim2.new(1, -285, 1, -10),

	Size = UDim2.fromOffset(275, 300),

	AnchorPoint = Vector2.new(0, 1),

	BackgroundTransparency = 1,

	ZIndex = 100
}, Gui)

New("UIListLayout", {
	VerticalAlignment = Enum.VerticalAlignment.Bottom,

	HorizontalAlignment = Enum.HorizontalAlignment.Right,

	Padding = UDim.new(0, 7)
}, Notifications)

local function Notify(Title, Message)
	task.spawn(function()

		local Box = New("Frame", {
			Size = UDim2.fromOffset(260, 58),

			BackgroundColor3 = C.Panel,

			BackgroundTransparency = 1,

			BorderSizePixel = 0,

			ZIndex = 100
		}, Notifications)

		Corner(Box, 5)
		Stroke(Box)

		local Bar = New("Frame", {
			Position = UDim2.fromOffset(0, 8),

			Size = UDim2.new(0, 3, 1, -16),

			BackgroundColor3 = C.Text,

			BackgroundTransparency = 1,

			BorderSizePixel = 0,

			ZIndex = 101
		}, Box)

		Corner(Bar, 3)

		local TitleLabel = New("TextLabel", {
			Position = UDim2.fromOffset(13, 7),

			Size = UDim2.new(1, -20, 0, 18),

			BackgroundTransparency = 1,

			Text = Title,

			TextColor3 = C.Text,

			TextTransparency = 1,

			TextSize = 11,

			Font = Enum.Font.GothamMedium,

			TextXAlignment = Enum.TextXAlignment.Left,

			ZIndex = 101
		}, Box)

		local MessageLabel = New("TextLabel", {
			Position = UDim2.fromOffset(13, 27),

			Size = UDim2.new(1, -20, 0, 20),

			BackgroundTransparency = 1,

			Text = Message,

			TextColor3 = C.SubText,

			TextTransparency = 1,

			TextSize = 9,

			Font = Enum.Font.Gotham,

			TextXAlignment = Enum.TextXAlignment.Left,

			ZIndex = 101
		}, Box)

		Box.Position = UDim2.new(1, 30, 0, 0)

		Tween(Box, {
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 0
		}, 0.3)

		Tween(Bar, {
			BackgroundTransparency = 0
		}, 0.2)

		Tween(TitleLabel, {
			TextTransparency = 0
		}, 0.2)

		Tween(MessageLabel, {
			TextTransparency = 0
		}, 0.2)

		task.wait(2.5)

		Tween(Box, {
			Position = UDim2.new(1, 30, 0, 0),
			BackgroundTransparency = 1
		}, 0.3)

		Tween(Bar, {
			BackgroundTransparency = 1
		}, 0.2)

		Tween(TitleLabel, {
			TextTransparency = 1
		}, 0.2)

		Tween(MessageLabel, {
			TextTransparency = 1
		}, 0.2)

		task.wait(0.35)

		if Box.Parent then
			Box:Destroy()
		end

	end)
end

----------------------------------------------------------------
-- FEATURE VARIABLES
----------------------------------------------------------------

local FOVEnabled = false
local FOVValue = 90
local DefaultFOV = 70

local BreadcrumbEnabled = false

local BreadcrumbColor =
	Color3.fromRGB(
		255,
		255,
		255
	)

local BreadcrumbSize = 0.1
local BreadcrumbLifetime = 3
local BreadcrumbSpacing = 0

local BreadcrumbConnection = nil
local LastBreadcrumbPosition = nil

local BreadcrumbFolder = New("Folder", {
	Name = "AeroBreadcrumbs"
}, workspace)

local CapeObject = nil

local FlyConnection = nil
local FlyEnabled = false
local FlySpeed = 50
local FlyYLevel = nil
local FlyAutoRotate = true
local FlyUp = false
local FlyDown = false
local FlyVerticalSpeed = 50
local FlyRunTrack = nil
local FlyFallTrack = nil
local FlyAnimation = nil

local SpeedValue = 30
local SpeedEnabled = false
local ESPEnabled = false
local TracersEnabled = false
local NameTagsEnabled = false
local ESPTeamColors = true
local ESPColor = Color3.fromRGB(255, 255, 255)
local NameTagColor = Color3.fromRGB(255, 255, 255)
local ESPConnection = nil
local ESPObjects = {}

local OriginalLighting = nil

local function GetFlyCharacter()
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	return Humanoid, Root
end

local function StopFlyAnimations()
	for _, Track in ipairs({FlyRunTrack, FlyFallTrack}) do
		if Track then
			Track:Stop(0.15)
			Track:Destroy()
		end
	end

	FlyRunTrack = nil
	FlyFallTrack = nil
	FlyAnimation = nil
end

local function LoadFlyAnimations(Character, Humanoid)
	StopFlyAnimations()

	local Animate = Character:FindFirstChild("Animate")
	local RunAnimation = Animate and Animate:FindFirstChild("run")
	local FallAnimation = Animate and Animate:FindFirstChild("fall")
	local RunAsset = RunAnimation and RunAnimation:FindFirstChild("RunAnim")
	local FallAsset = FallAnimation and FallAnimation:FindFirstChild("FallAnim")
	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		return
	end

	if RunAsset and RunAsset:IsA("Animation") then
		FlyRunTrack = Animator:LoadAnimation(RunAsset)
		FlyRunTrack.Looped = true
		FlyRunTrack.Priority = Enum.AnimationPriority.Movement
	end

	if FallAsset and FallAsset:IsA("Animation") then
		FlyFallTrack = Animator:LoadAnimation(FallAsset)
		FlyFallTrack.Looped = true
		FlyFallTrack.Priority = Enum.AnimationPriority.Movement
	end
end

local function PlayFlyAnimation(Track)
	if FlyAnimation == Track then
		return
	end

	if FlyAnimation then
		FlyAnimation:Stop(0.15)
	end

	FlyAnimation = Track
	if Track then
		Track:Play(0.15)
	end
end

local function SetFly(State)
	FlyEnabled = State

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end

	local Humanoid, Root = GetFlyCharacter()
	if not State then
		if Humanoid then
			Humanoid.PlatformStand = false
			Humanoid.AutoRotate = FlyAutoRotate
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
		if Root then
			Root.AssemblyLinearVelocity = Vector3.zero
			Root.AssemblyAngularVelocity = Vector3.zero
		end
		FlyYLevel = nil
		FlyUp = false
		FlyDown = false
		StopFlyAnimations()
		return
	end

	if not Humanoid or not Root then
		return
	end

	FlyYLevel = Root.Position.Y
	FlyAutoRotate = Humanoid.AutoRotate
	LoadFlyAnimations(LocalPlayer.Character, Humanoid)
	Humanoid.AutoRotate = false
	Humanoid.PlatformStand = false
	Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	FlyConnection = RunService.PreSimulation:Connect(function(DeltaTime)
		local CurrentHumanoid, CurrentRoot = GetFlyCharacter()
		if not CurrentHumanoid or not CurrentRoot then
			return
		end

		local Move = CurrentHumanoid.MoveDirection
		local Horizontal = Vector3.new(Move.X, 0, Move.Z)
		local Vertical = (FlyUp and 1 or 0) + (FlyDown and -1 or 0)
		local Smoothness = 1 - math.exp(-12 * DeltaTime)

		FlyYLevel = FlyYLevel + Vertical * FlyVerticalSpeed * DeltaTime

		if Horizontal.Magnitude > 0 then
			Horizontal = Horizontal.Unit * FlySpeed
		end

		CurrentHumanoid.AutoRotate = false
		CurrentHumanoid:ChangeState(Enum.HumanoidStateType.Physics)
		PlayFlyAnimation(
			Horizontal.Magnitude > 0
			and FlyRunTrack
			or FlyFallTrack
		)
		local TargetVelocity = Vector3.new(
			Horizontal.X,
			Vertical * FlyVerticalSpeed,
			Horizontal.Z
		)
		CurrentRoot.AssemblyLinearVelocity = CurrentRoot.AssemblyLinearVelocity:Lerp(
			TargetVelocity,
			Smoothness
		)
		CurrentRoot.AssemblyAngularVelocity = Vector3.zero
		if Horizontal.Magnitude > 0 then
			local TargetCFrame = CFrame.lookAlong(
				Vector3.new(CurrentRoot.Position.X, FlyYLevel, CurrentRoot.Position.Z),
				Horizontal,
				Vector3.yAxis
			)
			CurrentRoot.CFrame = CurrentRoot.CFrame:Lerp(TargetCFrame, Smoothness)
		else
			local Facing = Vector3.new(
				CurrentRoot.CFrame.LookVector.X,
				0,
				CurrentRoot.CFrame.LookVector.Z
			)
			if Facing.Magnitude == 0 then
				Facing = Vector3.new(0, 0, -1)
			end
			local TargetCFrame = CFrame.lookAlong(
				Vector3.new(CurrentRoot.Position.X, FlyYLevel, CurrentRoot.Position.Z),
				Facing.Unit,
				Vector3.yAxis
			)
			CurrentRoot.CFrame = CurrentRoot.CFrame:Lerp(TargetCFrame, Smoothness)
		end
	end)
end

UIS.InputBegan:Connect(function(Input, Processed)
	if Processed or not FlyEnabled then
		return
	end

	if Input.KeyCode == Enum.KeyCode.Space then
		FlyUp = true
	elseif Input.KeyCode == Enum.KeyCode.LeftShift then
		FlyDown = true
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.Space then
		FlyUp = false
	elseif Input.KeyCode == Enum.KeyCode.LeftShift then
		FlyDown = false
	end
end)

----------------------------------------------------------------
-- BREADCRUMBS
----------------------------------------------------------------

local function ClearBreadcrumbs()

	for _, Object in ipairs(
		BreadcrumbFolder:GetChildren()
		) do
		Object:Destroy()
	end

	LastBreadcrumbPosition = nil
end

local function CreateBreadcrumbSegment(A, B)

	local Difference = B - A
	local Length = Difference.Magnitude

	if Length <= 0.01 then
		return
	end

	local Midpoint = (A + B) / 2

	local Segment = New("Part", {
		Name = "Breadcrumb",

		Anchored = true,

		CanCollide = false,

		CanTouch = false,

		CanQuery = false,

		CastShadow = false,

		Material = Enum.Material.Neon,

		Color = BreadcrumbColor,

		Size = Vector3.new(
			BreadcrumbSize,
			BreadcrumbSize,
			Length
		),

		CFrame = CFrame.lookAt(
			Midpoint,
			B
		),

		Transparency = 0
	}, BreadcrumbFolder)

	Corner(
		Segment,
		math.max(
			1,
			BreadcrumbSize * 2
		)
	)

	task.delay(
		math.max(
			BreadcrumbLifetime - 0.3,
			0
		),
		function()

			if not Segment.Parent then
				return
			end

			Tween(
				Segment,
				{
					Transparency = 1
				},
				0.3
			)

			task.wait(0.35)

			if Segment.Parent then
				Segment:Destroy()
			end

		end
	)
end

local function AddBreadcrumb(Position)

	if not LastBreadcrumbPosition then
		LastBreadcrumbPosition = Position
		return
	end

	local Distance =
		(
			Position
			- LastBreadcrumbPosition
		).Magnitude

	if BreadcrumbSpacing > 0
		and Distance < BreadcrumbSpacing then

		return
	end

	CreateBreadcrumbSegment(
		LastBreadcrumbPosition,
		Position
	)

	LastBreadcrumbPosition = Position
end

local function SetBreadcrumbs(State)

	BreadcrumbEnabled = State

	if BreadcrumbConnection then
		BreadcrumbConnection:Disconnect()
		BreadcrumbConnection = nil
	end

	ClearBreadcrumbs()

	if not State then
		return
	end

	BreadcrumbConnection =
		RunService.Heartbeat:Connect(function()

			local Character =
			LocalPlayer.Character

			if not Character then
				return
			end

			local Root =
			Character:FindFirstChild(
				"HumanoidRootPart"
			)

			if not Root then
				return
			end

			local Position =
			Root.Position
			- Vector3.new(
				0,
				Root.Size.Y / 2 + 1.7,
				0
			)

			AddBreadcrumb(Position)

		end)
end

----------------------------------------------------------------
-- FOV
----------------------------------------------------------------

local function ApplyFOV()

	local Camera =
		workspace.CurrentCamera

	if not Camera then
		return
	end

	if FOVEnabled then
		Camera.FieldOfView = FOVValue
	else
		Camera.FieldOfView = DefaultFOV
	end
end

----------------------------------------------------------------
-- CAPE
----------------------------------------------------------------

local function RemoveCape()

	if CapeObject then
		CapeObject:Destroy()
		CapeObject = nil
	end

end

local function CreateCape()

	RemoveCape()

	local Character =
		LocalPlayer.Character

	if not Character then
		return
	end

	local Torso =
		Character:FindFirstChild("UpperTorso")
		or Character:FindFirstChild("Torso")

	if not Torso then
		return
	end

	local Cape = New("Part", {
		Name = "AeroCape",

		Size = Vector3.new(
			2.5,
			3,
			0.12
		),

		CanCollide = false,

		CanTouch = false,

		CanQuery = false,

		Massless = true,

		Anchored = false,

		Material =
			Enum.Material.SmoothPlastic,

		Color =
			Color3.fromRGB(
				200,
				200,
				200
			)
	}, Character)

	local Weld =
		Instance.new("Weld")

	Weld.Part0 = Torso
	Weld.Part1 = Cape

	Weld.C0 =
		CFrame.new(
			0,
			0.15,
			0.72
		)

	Weld.Parent = Cape

	CapeObject = Cape
end

----------------------------------------------------------------
----------------------------------------------------------------
-- DRAWING ESP
----------------------------------------------------------------

local function HideDrawing(Object)
	if Object then Object.Visible = false end
end

local function RemoveESP(Player)
	local Objects = ESPObjects[Player]
	if not Objects then return end
	for _, Object in pairs(Objects) do
		if Object then pcall(function() Object:Remove() end) end
	end
	ESPObjects[Player] = nil
end

local function CreateESP(Player)
	if ESPObjects[Player] then return ESPObjects[Player] end
	if not Drawing then return nil end

	local Objects = {
		Box = Drawing.new("Square"),
		Tracer = Drawing.new("Line"),
		Name = Drawing.new("Text")
	}

	Objects.Box.Thickness = 1
	Objects.Box.Filled = false
	Objects.Box.Color = ESPColor
	Objects.Tracer.Thickness = 1
	Objects.Tracer.Color = Color3.fromRGB(255, 255, 255)
	Objects.Name.Size = 13
	Objects.Name.Center = true
	Objects.Name.Outline = true
	Objects.Name.Color = NameTagColor

	ESPObjects[Player] = Objects
	return Objects
end

local function GetCharacterBounds(Character, Camera)
	local Root = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Root or not Humanoid or Humanoid.Health <= 0 then return nil end

	local BoxCFrame, BoxSize = Character:GetBoundingBox()
	local Half = BoxSize / 2
	local MinX, MinY = math.huge, math.huge
	local MaxX, MaxY = -math.huge, -math.huge
	local AnyVisible = false

	for X = -1, 1, 2 do
		for Y = -1, 1, 2 do
			for Z = -1, 1, 2 do
				local WorldPoint = BoxCFrame:PointToWorldSpace(Vector3.new(Half.X * X, Half.Y * Y, Half.Z * Z))
				local ScreenPoint, OnScreen = Camera:WorldToViewportPoint(WorldPoint)
				if ScreenPoint.Z > 0 then
					AnyVisible = AnyVisible or OnScreen
					MinX = math.min(MinX, ScreenPoint.X)
					MinY = math.min(MinY, ScreenPoint.Y)
					MaxX = math.max(MaxX, ScreenPoint.X)
					MaxY = math.max(MaxY, ScreenPoint.Y)
				end
			end
		end
	end

	if not AnyVisible or MinX == math.huge then return nil end
	return MinX, MinY, MaxX, MaxY, Root
end

local function StopESP()
	if ESPConnection then
		ESPConnection:Disconnect()
		ESPConnection = nil
	end
	for Player in pairs(ESPObjects) do RemoveESP(Player) end
end

local function UpdateESP()
	local Camera = workspace.CurrentCamera
	if not Camera then return end

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer then
			local Objects = CreateESP(Player)
			local Character = Player.Character
			if Objects and Character then
				local MinX, MinY, MaxX, MaxY, Root = GetCharacterBounds(Character, Camera)
				if MinX then
					local PlayerColor = ESPColor
					if ESPTeamColors and Player.Team then
						PlayerColor = Player.Team.TeamColor.Color
					end

					Objects.Box.Color = PlayerColor
					Objects.Tracer.Color = PlayerColor
					Objects.Name.Color = PlayerColor
					Objects.Box.Position = Vector2.new(MinX, MinY)
					Objects.Box.Size = Vector2.new(MaxX - MinX, MaxY - MinY)
					Objects.Box.Visible = ESPEnabled

					local RootPoint, RootOnScreen = Camera:WorldToViewportPoint(Root.Position)
					if TracersEnabled and RootOnScreen and RootPoint.Z > 0 then
						local Viewport = Camera.ViewportSize
						Objects.Tracer.From = Vector2.new(Viewport.X / 2, Viewport.Y)
						Objects.Tracer.To = Vector2.new(RootPoint.X, RootPoint.Y)
						Objects.Tracer.Visible = true
					else
						Objects.Tracer.Visible = false
					end

					local Head = Character:FindFirstChild("Head")
					local NamePoint, NameOnScreen = Camera:WorldToViewportPoint((Head and Head.Position or Root.Position) + Vector3.new(0, 0.75, 0))
					if NameTagsEnabled and NameOnScreen and NamePoint.Z > 0 then
						Objects.Name.Text = Player.DisplayName ~= Player.Name and Player.DisplayName .. " (" .. Player.Name .. ")" or Player.Name
						Objects.Name.Position = Vector2.new(NamePoint.X, NamePoint.Y)
						Objects.Name.Visible = true
					else
						Objects.Name.Visible = false
					end
				else
					HideDrawing(Objects.Box)
					HideDrawing(Objects.Tracer)
					HideDrawing(Objects.Name)
				end
			elseif Objects then
				HideDrawing(Objects.Box)
				HideDrawing(Objects.Tracer)
				HideDrawing(Objects.Name)
			end
		end
	end
end

local function StartESP()
	if ESPConnection or not Drawing then return end
	ESPConnection = RunService.RenderStepped:Connect(UpdateESP)
end

local function UpdateESPState()
	if ESPEnabled or TracersEnabled or NameTagsEnabled then
		if not Drawing then
			warn("[Aero] Drawing API is not available")
			return
		end
		StartESP()
	else
		StopESP()
	end
end

Players.PlayerRemoving:Connect(RemoveESP)

-- MODULE DATA
----------------------------------------------------------------

local Modules = {

	Combat = {

		{
			Name = "Aim Assist",
			Description =
				"Assists your aim towards nearby targets",
			Type = "Toggle"
		},

		{
			Name = "Velocity",
			Description =
				"Reduces horizontal knockback received",
			Type = "Toggle"
		},

		{
			Name = "Hitboxes",
			Description =
				"Displays expanded target hitboxes",
			Type = "Toggle"
		},

		{
			Name = "Reach",
			Description =
				"Adjusts attack distance",
			Type = "Toggle"
		}
	},

	Blatant = {

		{
			Name = "Fly",
			Description =
				"Allows the player to fly freely",
			Type = "Fly"
		},

		{
			Name = "Speed",
			Description =
				"Increases player movement speed",
			Type = "Toggle"
		},

		{
			Name = "High Jump",
			Description =
				"Increases jump height",
			Type = "Toggle"
		}
	},

	Render = {

		{
			Name = "ESP",
			Description =
				"Highlights players",
			Type = "Toggle"
		},

		{
			Name = "Tracers",
			Description =
				"Draws lines towards players",
			Type = "Toggle"
		},

		{
			Name = "Name Tags",
			Description =
				"Displays player names",
			Type = "Toggle"
		},

		{
			Name = "Fullbright",
			Description =
				"Removes darkness",
			Type = "Toggle"
		}
	},

	Utility = {

		{
			Name = "Auto Clicker",
			Description =
				"Automatically performs clicks",
			Type = "Toggle"
		},

		{
			Name = "Click Sounds",
			Description =
				"Plays click sounds",
			Type = "Toggle"
		},

		{
			Name = "CPS",
			Description =
				"Controls clicking rate",
			Type = "Toggle"
		},

		{
			Name = "GunMods",
			Description =
				"Weapon modifications",
			Type = "Container"
		}
	},

	World = {

		{
			Name = "Time Changer",
			Description =
				"Changes the local time",
			Type = "Toggle"
		},

		{
			Name = "Weather",
			Description =
				"Changes local weather visuals",
			Type = "Toggle"
		}
	},


	Legit = {

		{
			Name = "Morph",
			Description =
				"Apply another player's avatar appearance",
			Type = "Morph"
		},

		{
			Name = "Cape",
			Description =
				"Adds a visual cape to your character",
			Type = "Cape"
		},

		{
			Name = "FOV Changer",
			Description =
				"Changes the camera field of view",
			Type = "FOV"
		},

		{
			Name = "Breadcrumbs",
			Description =
				"Leaves a smooth line behind your feet",
			Type = "Breadcrumbs"
		}
	}
}

----------------------------------------------------------------
-- PAGES
----------------------------------------------------------------

local Pages = {}
local Navigation = {}
local ModuleObjects = {}
local Injected = true

local CategoryOrder = {
	"Combat",
	"Blatant",
	"Render",
	"Utility",
	"World",
	"Legit"
}

for _, Category in ipairs(CategoryOrder) do

	local Page = New("ScrollingFrame", {

		Name = Category,

		Size =
			UDim2.fromScale(
				1,
				1
			),

		BackgroundTransparency = 1,

		BorderSizePixel = 0,

		ScrollBarThickness = 3,

		ScrollBarImageColor3 =
			C.Text,

		CanvasSize =
			UDim2.new(
				0,
				0,
				0,
				0
			),

		Visible = false
	}, Content)

	New("UIPadding", {
		PaddingTop = UDim.new(0, 13),
		PaddingLeft = UDim.new(0, 13),
		PaddingRight = UDim.new(0, 13),
		PaddingBottom = UDim.new(0, 15)
	}, Page)

	local Layout = New("UIListLayout", {

		Padding =
			UDim.new(0, 7),

		SortOrder =
			Enum.SortOrder.LayoutOrder

	}, Page)

	Layout:GetPropertyChangedSignal(
		"AbsoluteContentSize"
	):Connect(function()

		Page.CanvasSize =
			UDim2.fromOffset(
				0,
				Layout.AbsoluteContentSize.Y + 30
			)

	end)

	Pages[Category] = Page
end

----------------------------------------------------------------
-- GENERIC SLIDER
----------------------------------------------------------------

local function CreateSlider(
	Parent,
	Name,
	Minimum,
	Maximum,
	Initial,
	Decimals,
	Callback
)

	local Container = New("Frame", {

		Size =
			UDim2.new(
				1,
				0,
				0,
				42
			),

		BackgroundTransparency = 1

	}, Parent)

	local Label = New("TextLabel", {

		Size =
			UDim2.new(
				1,
				0,
				0,
				18
			),

		BackgroundTransparency = 1,

		TextColor3 =
			C.Text,

		TextSize = 9,

		Font =
			Enum.Font.Gotham,

		TextXAlignment =
			Enum.TextXAlignment.Left

	}, Container)

	local Bar = New("Frame", {

		Position =
			UDim2.new(
				0,
				0,
				0,
				25
			),

		Size =
			UDim2.new(
				1,
				0,
				0,
				6
			),

		BackgroundColor3 =
			C.Off,

		BorderSizePixel = 0

	}, Container)

	Corner(Bar, 4)

	local Fill = New("Frame", {

		Size =
			UDim2.new(
				0,
				0,
				1,
				0
			),

		BackgroundColor3 =
			C.Accent,

		BorderSizePixel = 0

	}, Bar)

	Corner(Fill, 4)

	local Knob = New("Frame", {

		AnchorPoint =
			Vector2.new(
				0.5,
				0.5
			),

		Position =
			UDim2.new(
				0,
				0,
				0.5,
				0
			),

		Size =
			UDim2.fromOffset(
				10,
				10
			),

		BackgroundColor3 =
			C.Text,

		BorderSizePixel = 0

	}, Bar)

	Corner(Knob, 10)

	local function Format(Value)

		if Decimals == 0 then
			return tostring(
				math.round(Value)
			)
		end

		return string.format(
			"%." .. Decimals .. "f",
			Value
		)
	end

	local function SetValue(Value)

		Value =
			math.clamp(
				Value,
				Minimum,
				Maximum
			)

		local Percent =
			(Value - Minimum)
			/
			(Maximum - Minimum)

		Label.Text =
			Name
			.. ": "
			.. Format(Value)

		Fill.Size =
			UDim2.new(
				Percent,
				0,
				1,
				0
			)

		Knob.Position =
			UDim2.new(
				Percent,
				0,
				0.5,
				0
			)

		Callback(Value)
	end

	SetValue(Initial)

	local Dragging = false

	local function SetFromMouseX(X)

		local Percent =
			math.clamp(
				(
					X
					- Bar.AbsolutePosition.X
				)
				/
				Bar.AbsoluteSize.X,
				0,
				1
			)

		SetValue(
			Minimum
				+
				(
					Maximum - Minimum
				)
				* Percent
		)
	end

	Bar.InputBegan:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			Dragging = true

			SetFromMouseX(
				Input.Position.X
			)
		end
	end)

	UIS.InputChanged:Connect(function(Input)

		if not Dragging then
			return
		end

		if Input.UserInputType ~=
			Enum.UserInputType.MouseMovement then

			return
		end

		SetFromMouseX(
			Input.Position.X
		)
	end)

	UIS.InputEnded:Connect(function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			Dragging = false
		end
	end)

	return Container
end

----------------------------------------------------------------
-- CREATE MODULE
----------------------------------------------------------------

local function CreateModule(
	Parent,
	Data,
	Category
)

	local Expanded = false
	local Enabled = false
	local WaitingForKey = false
	local KeyConnection = nil
	local ChildToggles = {}
	local ChildConnections = {}

	Data.Keybind = nil

	local Holder = New("Frame", {

		Size =
			UDim2.new(
				1,
				0,
				0,
				58
			),

		BackgroundColor3 =
			C.Panel,

		BorderSizePixel = 0,

		ClipsDescendants = true

	}, Parent)

	Corner(Holder, 5)
	Stroke(Holder)

	--------------------------------------------------------
	-- NAME
	--------------------------------------------------------

	New("TextLabel", {

		Position =
			UDim2.fromOffset(
				12,
				7
			),

		Size =
			UDim2.new(
				1,
				-185,
				0,
				20
			),

		BackgroundTransparency = 1,

		Text = Data.Name,

		TextColor3 =
			C.Text,

		TextSize = 12,

		Font =
			Enum.Font.GothamMedium,

		TextXAlignment =
			Enum.TextXAlignment.Left

	}, Holder)

	--------------------------------------------------------
	-- DESCRIPTION
	--------------------------------------------------------

	New("TextLabel", {

		Position =
			UDim2.fromOffset(
				12,
				28
			),

		Size =
			UDim2.new(
				1,
				-185,
				0,
				18
			),

		BackgroundTransparency = 1,

		Text =
			Data.Description,

		TextColor3 =
			C.SubText,

		TextSize = 9,

		Font =
			Enum.Font.Gotham,

		TextXAlignment =
			Enum.TextXAlignment.Left

	}, Holder)

	--------------------------------------------------------
	-- ARROW BUTTON
	--------------------------------------------------------

	local Arrow = New("TextButton", {

		Position =
			UDim2.new(
				1,
				-36,
				0,
				14
			),

		Size =
			UDim2.fromOffset(
				26,
				28
			),

		BackgroundTransparency = 1,

		Text = ">",

		TextColor3 =
			C.SubText,

		TextSize = 18,

		Font =
			Enum.Font.GothamBold,

		AutoButtonColor = false,

		ZIndex = 30

	}, Holder)

	--------------------------------------------------------
	-- SETTINGS
	--------------------------------------------------------

	local Settings = New("Frame", {
		Position = UDim2.fromOffset(12, 60),
		Size = UDim2.new(1, -24, 0, 0),
		BackgroundTransparency = 1
	}, Holder)

	local SettingsLayout = New("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder
	}, Settings)

	local function ExpandedHeight()
		return 60 + SettingsLayout.AbsoluteContentSize.Y + 12
	end

	local function Expand()
		if Expanded then
			return
		end
		Expanded = true
		Tween(Arrow, {Rotation = 90}, 0.18)
		task.defer(function()
			Tween(Holder, {Size = UDim2.new(1, 0, 0, ExpandedHeight())}, 0.2)
		end)
	end

	local function Collapse()
		if not Expanded then
			return
		end
		Expanded = false
		Tween(Arrow, {Rotation = 0}, 0.18)
		Tween(Holder, {Size = UDim2.new(1, 0, 0, 58)}, 0.2)
	end

	local function ToggleExpanded()
		if Expanded then
			Collapse()
		else
			Expand()
		end
	end

	--------------------------------------------------------
	-- ARROW CLICK
	--------------------------------------------------------

	Arrow.MouseButton1Click:Connect(
		ToggleExpanded
	)

	--------------------------------------------------------
	-- RIGHT-CLICK MODULE
	--------------------------------------------------------

	Holder.InputBegan:Connect(
		function(Input)

			if Input.UserInputType ==
				Enum.UserInputType.MouseButton2 then

				if SettingsLayout.AbsoluteContentSize.Y > 0 then
					ToggleExpanded()
				end

			end

		end
	)

	--------------------------------------------------------
	-- AUTO HEIGHT
	--------------------------------------------------------

	SettingsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if Expanded then
			Tween(Holder, {Size = UDim2.new(1, 0, 0, ExpandedHeight())}, 0.1)
		end
	end)

	--------------------------------------------------------
	-- KEYBIND
	--------------------------------------------------------

	local KeyButton = New("TextButton", {

		Position =
			UDim2.new(
				1,
				-116,
				0,
				18
			),

		Size =
			UDim2.fromOffset(
				36,
				22
			),

		BackgroundColor3 =
			C.Panel2,

		BorderSizePixel = 0,

		Text = "-",

		TextColor3 =
			C.Text,

		TextSize = 9,

		Font =
			Enum.Font.GothamMedium,

		AutoButtonColor = false,

		ZIndex = 40

	}, Holder)

	Corner(KeyButton, 4)
	Stroke(KeyButton)

	local function StopCapture()

		WaitingForKey = false

		if KeyConnection then

			KeyConnection:Disconnect()

			KeyConnection = nil

		end

		KeyButton.Text =
			Data.Keybind or "-"

	end

	local function RemoveKeybind()

		Data.Keybind = nil

		StopCapture()

		print(
			"[Aero] "
				.. Data.Name
				.. " keybind removed"
		)

		Notify(
			Data.Name,
			"Keybind removed"
		)

	end

	KeyButton.MouseButton1Click:Connect(
		function()

			if WaitingForKey then

				RemoveKeybind()

				return
			end

			WaitingForKey = true
			KeyButton.Text = "..."

			KeyConnection =
				UIS.InputBegan:Connect(
					function(
						Input,
						Processed
					)

						if Processed then
							return
						end

						if Input.UserInputType ~=
							Enum.UserInputType.Keyboard then

							return
						end

						local Key =
						Input.KeyCode

						if Key ==
							Enum.KeyCode.Escape then

							StopCapture()
							return
						end

						if Key ==
							Enum.KeyCode.Backspace then

							RemoveKeybind()
							return
						end

						if Data.Keybind ==
							Key.Name then

							RemoveKeybind()
							return
						end

						Data.Keybind =
						Key.Name

						StopCapture()

						print(
							"[Aero] "
							.. Data.Name
							.. " = "
							.. Data.Keybind
						)

						Notify(
							Data.Name,
							"Keybind: "
							.. Data.Keybind
						)

					end
				)

		end
	)

	--------------------------------------------------------
	-- TOGGLE
	--------------------------------------------------------

	local ToggleButton = New(
		"TextButton",
		{

			Position =
				UDim2.new(
					1,
					-67,
					0,
					18
				),

			Size =
				UDim2.fromOffset(
					38,
					22
				),

			BackgroundColor3 =
				C.Off,

			BorderSizePixel = 0,

			Text = "",

			AutoButtonColor = false,

			ZIndex = 40
		},
		Holder
	)

	Corner(
		ToggleButton,
		11
	)

	local Knob = New(
		"Frame",
		{

			Position =
				UDim2.fromOffset(
					3,
					3
				),

			Size =
				UDim2.fromOffset(
					16,
					16
				),

			BackgroundColor3 =
				C.Text,

			BorderSizePixel = 0,

			ZIndex = 41

		},
		ToggleButton
	)

	Corner(
		Knob,
		10
	)

	--------------------------------------------------------
	-- FEATURE TOGGLE
	--------------------------------------------------------

	local function SetEnabled(State, Silent)

		if not Injected and State then
			return
		end

		Enabled = State

		Tween(
			ToggleButton,
			{
				BackgroundColor3 =
					State
					and C.Accent
					or C.Off
			},
			0.15
		)

		Tween(
			Knob,
			{
				Position =
					State
					and UDim2.new(
						1,
						-19,
						0,
						3
					)
					or UDim2.fromOffset(
						3,
						3
					)
			},
			0.15
		)

		----------------------------------------------------
		-- FOV
		----------------------------------------------------

		if Data.Name ==
			"FOV Changer" then

			FOVEnabled = State

			ApplyFOV()

			----------------------------------------------------
			-- CAPE
			----------------------------------------------------

		elseif Data.Name ==
			"Cape" then

			if State then
				CreateCape()
			else
				RemoveCape()
			end

			----------------------------------------------------
			-- BREADCRUMBS
			----------------------------------------------------

		elseif Data.Name ==
			"Breadcrumbs" then

			SetBreadcrumbs(State)

			----------------------------------------------------
			-- SPEED
			----------------------------------------------------

		elseif Data.Name ==
			"Speed" then

			SpeedEnabled = State

			local Character =
				LocalPlayer.Character

			local Humanoid =
				Character
				and Character:
				FindFirstChildOfClass(
					"Humanoid"
				)

			if Humanoid then

				Humanoid.WalkSpeed =
					State
					and SpeedValue
					or 16

			end

			----------------------------------------------------
			-- HIGH JUMP
			----------------------------------------------------

		elseif Data.Name ==
			"High Jump" then

			local Character =
				LocalPlayer.Character

			local Humanoid =
				Character
				and Character:
				FindFirstChildOfClass(
					"Humanoid"
				)

			if Humanoid then

				Humanoid.JumpPower =
					State
					and 85
					or 50

			end

			----------------------------------------------------
			-- FULLBRIGHT
			----------------------------------------------------

		elseif Data.Name ==
			"ESP" then

			ESPEnabled = State
			UpdateESPState()

		elseif Data.Name ==
			"Tracers" then

			TracersEnabled = State
			UpdateESPState()

		elseif Data.Name ==
			"Name Tags" then

			NameTagsEnabled = State
			UpdateESPState()

		elseif Data.Name ==
			"Fullbright" then

			if State then

				if not OriginalLighting then
					OriginalLighting = {
						Brightness = Lighting.Brightness,
						ClockTime = Lighting.ClockTime,
						FogStart = Lighting.FogStart,
						FogEnd = Lighting.FogEnd,
						GlobalShadows = Lighting.GlobalShadows,
						Ambient = Lighting.Ambient,
						OutdoorAmbient = Lighting.OutdoorAmbient,
						ColorShiftTop = Lighting.ColorShift_Top,
						ColorShiftBottom = Lighting.ColorShift_Bottom,
						ExposureCompensation = Lighting.ExposureCompensation
					}
				end

				Lighting.Brightness = 2
				Lighting.ClockTime = 14
				Lighting.FogStart = 0
				Lighting.FogEnd = 1000000
				Lighting.GlobalShadows = false
				Lighting.Ambient = Color3.new(1, 1, 1)
				Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
				Lighting.ColorShift_Top = Color3.new(0, 0, 0)
				Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
				Lighting.ExposureCompensation = 0.5

			else

				if OriginalLighting then
					Lighting.Brightness = OriginalLighting.Brightness
					Lighting.ClockTime = OriginalLighting.ClockTime
					Lighting.FogStart = OriginalLighting.FogStart
					Lighting.FogEnd = OriginalLighting.FogEnd
					Lighting.GlobalShadows = OriginalLighting.GlobalShadows
					Lighting.Ambient = OriginalLighting.Ambient
					Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
					Lighting.ColorShift_Top = OriginalLighting.ColorShiftTop
					Lighting.ColorShift_Bottom = OriginalLighting.ColorShiftBottom
					Lighting.ExposureCompensation = OriginalLighting.ExposureCompensation
					OriginalLighting = nil
				end

			end

			----------------------------------------------------
			-- TIME CHANGER
			----------------------------------------------------

		elseif Data.Name ==
			"Time Changer" then

			Lighting.ClockTime =
				State
				and 14
				or 12

		elseif Data.Name ==
			"Fly" then

			SetFly(State)

		end

		if not Silent then
			print(
				"[Aero] "
					.. Data.Name
					.. " "
					.. (
						State
						and "enabled"
						or "disabled"
					)
			)

			Notify(
				Data.Name,
				State
					and "Enabled"
					or "Disabled"
			)
		end

	end

	ToggleButton.MouseButton1Click:Connect(
		function()

			SetEnabled(
				not Enabled
			)

		end
	)

	--------------------------------------------------------
	-- KEYBIND ACTIVATION
	--------------------------------------------------------

	UIS.InputBegan:Connect(
		function(
			Input,
			Processed
		)

			if Processed
				or WaitingForKey then

				return
			end

			if not Data.Keybind then
				return
			end

			if Input.UserInputType ~=
				Enum.UserInputType.Keyboard then

				return
			end

			if Input.KeyCode.Name ==
				Data.Keybind then

				SetEnabled(
					not Enabled
				)

			end

		end
	)
	--------------------------------------------------------
	-- CHILD TOGGLE API
	--------------------------------------------------------

	local ModuleAPI = {}

	function ModuleAPI:CreateToggle(ToggleData)
		local ToggleName = ToggleData.Name or "Toggle"
		local ToggleState = ToggleData.Default == true

		local Container = New("Frame", {
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundTransparency = 1
		}, Settings)

		local Label = New("TextLabel", {
			Position = UDim2.fromOffset(8, 0),
			Size = UDim2.new(1, -58, 1, 0),
			BackgroundTransparency = 1,
			Text = ToggleName,
			TextColor3 = C.Text,
			TextSize = 10,
			Font = Enum.Font.GothamMedium,
			TextXAlignment = Enum.TextXAlignment.Left
		}, Container)

		local Button = New("TextButton", {
			Position = UDim2.new(1, -42, 0, 6),
			Size = UDim2.fromOffset(38, 22),
			BackgroundColor3 = C.Off,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 40
		}, Container)

		Corner(Button, 11)

		local Knob = New("Frame", {
			Position = UDim2.fromOffset(3, 3),
			Size = UDim2.fromOffset(16, 16),
			BackgroundColor3 = C.Text,
			BorderSizePixel = 0,
			ZIndex = 41
		}, Button)

		Corner(Knob, 10)

		local function SetToggle(State, Silent)
			State = State == true
			ToggleState = State

			Tween(Button, {
				BackgroundColor3 = State and C.Accent or C.Off
			}, 0.15)

			Tween(Knob, {
				Position = State
					and UDim2.new(1, -19, 0, 3)
					or UDim2.fromOffset(3, 3)
			}, 0.15)

			if ToggleData.Function then
				ToggleData.Function(State)
			end
		end

		Button.MouseButton1Click:Connect(function()
			SetToggle(not ToggleState)
		end)

		local Object = {
			Name = ToggleName,
			Frame = Container,
			Button = Button,
			Enabled = function()
				return ToggleState
			end,
			SetEnabled = SetToggle,
			SetValue = SetToggle
		}

		table.insert(ChildToggles, Object)
		return Object
	end

	--------------------------------------------------------
	-- COLOR SLIDER API
	--------------------------------------------------------

	function ModuleAPI:CreateColorSlider(ColorData)
		local ColorName = ColorData.Name or "Color"
		local Initial = ColorData.Initial or 0.6667

		local Container = New("Frame", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundTransparency = 1
		}, Settings)

		local Label = New("TextLabel", {
			Size = UDim2.new(1, 0, 0, 18),
			BackgroundTransparency = 1,
			TextColor3 = C.Text,
			TextSize = 9,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left
		}, Container)

		local Bar = New("Frame", {
			Position = UDim2.new(0, 0, 0, 25),
			Size = UDim2.new(1, 0, 0, 6),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0
		}, Container)

		Corner(Bar, 4)

		local Fill = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0
		}, Bar)

		Corner(Fill, 4)

		local Knob = New("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(Initial, 0, 0.5, 0),
			Size = UDim2.fromOffset(10, 10),
			BackgroundColor3 = C.Text,
			BorderSizePixel = 0
		}, Bar)

		Corner(Knob, 10)

		local function SetValue(Value)
			Value = math.clamp(Value, 0, 1)
			local Color = Color3.fromHSV(Value, 1, 1)
			Label.Text = ColorName .. ": " .. math.round(Value * 360) .. "°"
			Fill.BackgroundColor3 = Color
			Knob.Position = UDim2.new(Value, 0, 0.5, 0)
			if ColorData.Function then
				ColorData.Function(Color, Value)
			end
		end

		local Dragging = false
		local function SetFromMouseX(X)
			local Percent = math.clamp((X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
			SetValue(Percent)
		end

		Bar.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = true
				SetFromMouseX(Input.Position.X)
			end
		end)

		Bar.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = false
			end
		end)

		UIS.InputChanged:Connect(function(Input)
			if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
				SetFromMouseX(Input.Position.X)
			end
		end)

		SetValue(Initial)

		return {
			Frame = Container,
			SetValue = SetValue
		}
	end
	if Data.Name == "Speed" then

		CreateSlider(
			Settings,
			"Speed",
			0,
			150,
			SpeedValue,
			0,
			function(Value)
				SpeedValue = math.round(Value)
				if Enabled then
					local Character = LocalPlayer.Character
					local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
					if Humanoid then Humanoid.WalkSpeed = SpeedValue end
				end
			end
		)

	end


	if Data.Name == "ESP" then

		ModuleAPI:CreateToggle({
			Name = "Team Colors",
			Default = true,
			Function = function(State)
				ESPTeamColors = State
			end
		})

		ModuleAPI:CreateColorSlider({
			Name = "Color",
			Initial = 0.6667,
			Function = function(Color)
				ESPColor = Color
			end
		})

	end

	if Data.Name == "Name Tags" then

		ModuleAPI:CreateColorSlider({
			Name = "Color",
			Initial = 0.6667,
			Function = function(Color)
				NameTagColor = Color
			end
		})

	end

	--------------------------------------------------------
	-- MORPH
	--------------------------------------------------------

	if Data.Type == "Fly" then

		CreateSlider(
			Settings,
			"Speed",
			1,
			150,
			FlySpeed,
			0,
			function(Value)
				FlySpeed = math.round(Value)
			end
		)

	end

	if Data.Type ==
		"Morph" then

		local UserIdBox = New(
			"TextBox",
			{

				Size =
					UDim2.new(
						1,
						0,
						0,
						30
					),

				BackgroundColor3 =
					C.Panel2,

				BorderSizePixel = 0,

				PlaceholderText =
					"Roblox UserId...",

				PlaceholderColor3 =
					C.SubText,

				Text = "",

				TextColor3 =
					C.Text,

				TextSize = 10,

				Font =
					Enum.Font.Gotham,

				ClearTextOnFocus =
					false

			},
			Settings
		)

		Corner(
			UserIdBox,
			4
		)

		Stroke(
			UserIdBox
		)

		New(
			"UIPadding",
			{
				PaddingLeft =
					UDim.new(
						0,
						8
					)
			},
			UserIdBox
		)

		local ApplyButton = New(
			"TextButton",
			{

				Size =
					UDim2.new(
						1,
						0,
						0,
						30
					),

				BackgroundColor3 =
					C.Panel2,

				BorderSizePixel = 0,

				Text =
					"Apply Avatar",

				TextColor3 =
					C.Text,

				TextSize = 10,

				Font =
					Enum.Font.GothamMedium,

				AutoButtonColor = false

			},
			Settings
		)

		Corner(
			ApplyButton,
			4
		)

		Stroke(
			ApplyButton
		)

		ApplyButton.MouseButton1Click:Connect(
			function()

				local UserId =
					tonumber(
						UserIdBox.Text
					)

				if not UserId then

					Notify(
						"Morph",
						"Enter a valid UserId"
					)

					return
				end

				Notify(
					"Morph",
					"Loading avatar..."
				)

				local Success,
				Description =
					pcall(
						function()

							return Players:
							GetHumanoidDescriptionFromUserIdAsync(
								UserId
							)

						end
					)

				if not Success
					or not Description then

					Notify(
						"Morph",
						"Could not load avatar"
					)

					return
				end

				local Character =
					LocalPlayer.Character

				if not Character then

					Notify(
						"Morph",
						"Character not ready"
					)

					return
				end

				local Humanoid =
					Character:
					FindFirstChildOfClass(
						"Humanoid"
					)

				if not Humanoid then

					Notify(
						"Morph",
						"Humanoid not found"
					)

					return
				end

				local Applied,
				ErrorMessage =
					pcall(
						function()

							Humanoid:
							ApplyDescriptionResetAsync(
								Description
							)

						end
					)

				if Applied then

					Notify(
						"Morph",
						"Avatar applied"
					)

					print(
						"[Aero] Morph applied:",
						UserId
					)

				else

					Notify(
						"Morph",
						"Failed to apply avatar"
					)

					warn(
						"[Aero] Morph error:",
						ErrorMessage
					)

				end

			end
		)

	end

	--------------------------------------------------------
	-- FOV
	--------------------------------------------------------

	if Data.Type ==
		"FOV" then

		CreateSlider(
			Settings,
			"FOV",
			40,
			120,
			FOVValue,
			0,
			function(Value)

				FOVValue =
					math.round(Value)

				if FOVEnabled then
					ApplyFOV()
				end

			end
		)

	end

	--------------------------------------------------------
	-- CAPE SETTINGS
	--------------------------------------------------------

	if Data.Type ==
		"Cape" then

		New(
			"TextLabel",
			{

				Size =
					UDim2.new(
						1,
						0,
						0,
						32
					),

				BackgroundTransparency = 1,

				Text =
					"Visual cape • Studio demo",

				TextColor3 =
					C.SubText,

				TextSize = 9,

				Font =
					Enum.Font.Gotham,

				TextXAlignment =
					Enum.TextXAlignment.Left

			},
			Settings
		)

	end

	--------------------------------------------------------
	-- BREADCRUMB SETTINGS
	--------------------------------------------------------

	if Data.Type ==
		"Breadcrumbs" then

		----------------------------------------------------
		-- COLOR OPTIONS
		----------------------------------------------------

		local ColorOptions = {

			{
				Name = "Red",
				Color =
					Color3.fromRGB(
						255,
						60,
						60
					)
			},

			{
				Name = "Orange",
				Color =
					Color3.fromRGB(
						255,
						150,
						50
					)
			},

			{
				Name = "Yellow",
				Color =
					Color3.fromRGB(
						255,
						220,
						60
					)
			},

			{
				Name = "Green",
				Color =
					Color3.fromRGB(
						70,
						210,
						100
					)
			},

			{
				Name = "Blue",
				Color =
					Color3.fromRGB(
						70,
						140,
						255
					)
			},

			{
				Name = "Purple",
				Color =
					Color3.fromRGB(
						170,
						90,
						255
					)
			},

			{
				Name = "Pink",
				Color =
					Color3.fromRGB(
						255,
						100,
						190
					)
			},

			{
				Name = "White",
				Color =
					Color3.fromRGB(
						255,
						255,
						255
					)
			}

		}

		----------------------------------------------------
		-- COLOR BAR
		----------------------------------------------------

		local ColorContainer = New(
			"Frame",
			{

				Size =
					UDim2.new(
						1,
						0,
						0,
						48
					),

				BackgroundTransparency = 1

			},
			Settings
		)

		local ColorLabel = New(
			"TextLabel",
			{

				Size =
					UDim2.new(
						1,
						0,
						0,
						18
					),

				BackgroundTransparency = 1,

				Text =
					"Color: White",

				TextColor3 =
					C.Text,

				TextSize = 9,

				Font =
					Enum.Font.Gotham,

				TextXAlignment =
					Enum.TextXAlignment.Left

			},
			ColorContainer
		)

		local ColorBar = New(
			"Frame",
			{

				Position =
					UDim2.new(
						0,
						0,
						0,
						27
					),

				Size =
					UDim2.new(
						1,
						0,
						0,
						6
					),

				BackgroundColor3 =
					Color3.fromRGB(
						255,
						255,
						255
					),

				BorderSizePixel = 0

			},
			ColorContainer
		)

		Corner(
			ColorBar,
			5
		)

		local Gradient =
			Instance.new(
				"UIGradient"
			)

		Gradient.Color =
			ColorSequence.new({

				ColorSequenceKeypoint.new(
					0,
					Color3.fromRGB(
						255,
						60,
						60
					)
				),

				ColorSequenceKeypoint.new(
					1 / 7,
					Color3.fromRGB(
						255,
						150,
						50
					)
				),

				ColorSequenceKeypoint.new(
					2 / 7,
					Color3.fromRGB(
						255,
						220,
						60
					)
				),

				ColorSequenceKeypoint.new(
					3 / 7,
					Color3.fromRGB(
						70,
						210,
						100
					)
				),

				ColorSequenceKeypoint.new(
					4 / 7,
					Color3.fromRGB(
						70,
						140,
						255
					)
				),

				ColorSequenceKeypoint.new(
					5 / 7,
					Color3.fromRGB(
						170,
						90,
						255
					)
				),

				ColorSequenceKeypoint.new(
					6 / 7,
					Color3.fromRGB(
						255,
						100,
						190
					)
				),

				ColorSequenceKeypoint.new(
					1,
					Color3.fromRGB(
						255,
						255,
						255
					)
				)

			})

		Gradient.Parent =
			ColorBar

		----------------------------------------------------
		-- DOT
		----------------------------------------------------

		local ColorDot = New(
			"Frame",
			{

				AnchorPoint =
					Vector2.new(
						0.5,
						0.5
					),

				Position =
					UDim2.new(
						1,
						0,
						0.5,
						0
					),

				Size =
					UDim2.fromOffset(
						12,
						12
					),

				BackgroundColor3 =
					Color3.fromRGB(
						255,
						255,
						255
					),

				BorderSizePixel = 0,

				ZIndex = 5

			},
			ColorBar
		)

		Corner(
			ColorDot,
			20
		)

		Stroke(
			ColorDot,
			Color3.fromRGB(
				25,
				25,
				25
			),
			2
		)

		local DraggingColor = false

		local function SetColor(Index)

			Index =
				math.clamp(
					Index,
					1,
					#ColorOptions
				)

			local Data =
				ColorOptions[Index]

			BreadcrumbColor =
				Data.Color

			ColorLabel.Text =
				"Color: "
				.. Data.Name

			ColorDot.BackgroundColor3 =
				Data.Color

			local Percent =
				(Index - 1)
				/
				(
					#ColorOptions - 1
				)

			ColorDot.Position =
				UDim2.new(
					Percent,
					0,
					0.5,
					0
				)

		end

		local function UpdateColor(
			MouseX
		)

			local Percent =
				math.clamp(
					(
						MouseX
						- ColorBar.AbsolutePosition.X
					)
					/
					ColorBar.AbsoluteSize.X,
					0,
					1
				)

			local Index =
				math.floor(
					Percent
					* (
						#ColorOptions - 1
					)
					+ 0.5
				)
				+ 1

			SetColor(
				Index
			)

		end

		ColorBar.InputBegan:Connect(
			function(Input)

				if Input.UserInputType ==
					Enum.UserInputType.MouseButton1 then

					DraggingColor = true

					UpdateColor(
						Input.Position.X
					)

				end

			end
		)

		ColorDot.InputBegan:Connect(
			function(Input)

				if Input.UserInputType ==
					Enum.UserInputType.MouseButton1 then

					DraggingColor = true

				end

			end
		)

		UIS.InputChanged:Connect(
			function(Input)

				if not DraggingColor then
					return
				end

				if Input.UserInputType ~=
					Enum.UserInputType.MouseMovement then

					return
				end

				UpdateColor(
					Input.Position.X
				)

			end
		)

		UIS.InputEnded:Connect(
			function(Input)

				if Input.UserInputType ==
					Enum.UserInputType.MouseButton1 then

					DraggingColor = false

				end

			end
		)

		SetColor(
			#ColorOptions
		)

		----------------------------------------------------
		-- SIZE 0.01 - 1.00
		----------------------------------------------------

		CreateSlider(
			Settings,
			"Size",
			0.01,
			1,
			BreadcrumbSize,
			2,
			function(Value)

				BreadcrumbSize =
					Value

			end
		)

		----------------------------------------------------
		-- LIFETIME 1 - 60
		----------------------------------------------------

		CreateSlider(
			Settings,
			"Lifetime",
			1,
			60,
			BreadcrumbLifetime,
			0,
			function(Value)

				BreadcrumbLifetime =
					math.round(Value)

			end
		)

	end


	--------------------------------------------------------
	-- GUN MODS
	--------------------------------------------------------

	if Data.Name == "GunMods" then
		local OriginalValues = {
			Spread = {},
			Ammo = {},
			StoredAmmo = {},
			ReloadTime = {},
			RecoilControl = {}
		}

		local function GetWeapons()
			local Weapons = ReplicatedStorage:FindFirstChild("Weapons")
			if not Weapons then
				return {}
			end
			return Weapons:GetChildren()
		end

		local function GetValue(Weapon, Name)
			local Value = Weapon:FindFirstChild(Name, true)
			if Value and (Value:IsA("NumberValue") or Value:IsA("IntValue")) then
				return Value
			end
			return nil
		end

		local function GetAllValues(Name)
			local Values = {}
			local Weapons = ReplicatedStorage:FindFirstChild("Weapons")
			if not Weapons then
				return Values
			end

			for _, Object in ipairs(Weapons:GetDescendants()) do
				if Object.Name == Name and (Object:IsA("NumberValue") or Object:IsA("IntValue")) then
					table.insert(Values, Object)
				end
			end

			return Values
		end

		local function SaveOriginal(Name, ValueObject)
			if not OriginalValues[Name][ValueObject] then
				OriginalValues[Name][ValueObject] = ValueObject.Value
			end
		end

		local function SetWeaponValue(Name, Value)
			for _, Weapon in ipairs(GetWeapons()) do
				local ValueObject = GetValue(Weapon, Name)
				if ValueObject then
					SaveOriginal(Name, ValueObject)
					ValueObject.Value = Value
				end
			end
		end

		local function RestoreWeaponValue(Name)
			for ValueObject, OriginalValue in pairs(OriginalValues[Name]) do
				if ValueObject and ValueObject.Parent then
					ValueObject.Value = OriginalValue
				end
			end
			table.clear(OriginalValues[Name])
		end

		local function SetAmmoValues()
			for _, Ammo in ipairs(GetAllValues("Ammo")) do
				SaveOriginal("Ammo", Ammo)
				Ammo.Value = 999
			end

			for _, StoredAmmo in ipairs(GetAllValues("StoredAmmo")) do
				SaveOriginal("StoredAmmo", StoredAmmo)
				StoredAmmo.Value = 299
			end
		end

		local function StopWeaponMods()
			RestoreWeaponValue("Spread")
			RestoreWeaponValue("Ammo")
			RestoreWeaponValue("StoredAmmo")
			RestoreWeaponValue("ReloadTime")
			RestoreWeaponValue("RecoilControl")
		end

		ModuleAPI:CreateToggle({
			Name = "No Spread",
			Function = function(State)
				if State then
					SetWeaponValue("Spread", 0)
				else
					RestoreWeaponValue("Spread")
				end
			end
		})

		ModuleAPI:CreateToggle({
			Name = "Ammo",
			Function = function(State)
				if State then
					SetAmmoValues()
				else
					RestoreWeaponValue("Ammo")
					RestoreWeaponValue("StoredAmmo")
				end
			end
		})

		ModuleAPI:CreateToggle({
			Name = "Instant Reload",
			Function = function(State)
				if State then
					SetWeaponValue("ReloadTime", 0)
				else
					RestoreWeaponValue("ReloadTime")
				end
			end
		})

		ModuleAPI:CreateToggle({
			Name = "No Recoil",
			Function = function(State)
				if State then
					SetWeaponValue("RecoilControl", 0)
				else
					RestoreWeaponValue("RecoilControl")
				end
			end
		})

		-- Apply current settings to weapons added after the module is created.
		-- The individual toggles still control whether these changes are active.
		ChildConnections.GunModsCleanup = function()
			StopWeaponMods()
		end
	end

	--------------------------------------------------------
	-- MODULE REFERENCE
	--------------------------------------------------------

	table.insert(
		ModuleObjects,
		{
			Frame = Holder,
			Name = Data.Name,
			Category = Category,
			CreateToggle = function(_, ToggleData)
				return ModuleAPI:CreateToggle(ToggleData)
			end,
			Cleanup = function()
				StopCapture()
				SetEnabled(false, true)
				for _, Toggle in ipairs(ChildToggles) do
					Toggle.SetEnabled(false, true)
				end
				if ChildConnections.GunModsCleanup then
					ChildConnections.GunModsCleanup()
				end
			end
		}
	)

end

----------------------------------------------------------------
-- BUILD MODULES
----------------------------------------------------------------

for Category, ModuleList in pairs(Modules) do

	for _, Data in ipairs(ModuleList) do

		CreateModule(
			Pages[Category],
			Data,
			Category
		)

	end

end

----------------------------------------------------------------
-- UNINJECT
----------------------------------------------------------------

local function Uninject()

	if not Injected then
		return
	end

	for _, Module in ipairs(ModuleObjects) do
		Module.Cleanup()
	end

	StopESP()

	Injected = false

	if BreadcrumbFolder then
		BreadcrumbFolder:Destroy()
	end

	if Gui then
		Gui:Destroy()
	end

end

----------------------------------------------------------------
-- CATEGORY SWITCHING
----------------------------------------------------------------

local CurrentCategory = "Combat"

local function SelectCategory(Category)

	CurrentCategory = Category

	for Name, Page in pairs(Pages) do
		Page.Visible = Name == Category
	end

	for Name, Button in pairs(Navigation) do

		if Name == Category then

			Tween(
				Button,
				{
					BackgroundColor3 =
						C.Accent,

					TextColor3 =
						C.Background
				},
				0.15
			)

		else

			Tween(
				Button,
				{
					BackgroundColor3 =
						C.Panel,

					TextColor3 =
						C.SubText
				},
				0.15
			)

		end

	end
end

----------------------------------------------------------------
-- NAV BUTTONS
----------------------------------------------------------------

for Index, Category in ipairs(CategoryOrder) do

	local Button = New("TextButton", {

		Size =
			UDim2.new(
				1,
				0,
				0,
				34
			),

		BackgroundColor3 =
			C.Panel,

		BorderSizePixel = 0,

		Text =
			"   "
			.. Category,

		TextColor3 =
			C.SubText,

		TextSize = 11,

		Font =
			Enum.Font.GothamMedium,

		TextXAlignment =
			Enum.TextXAlignment.Left,

		AutoButtonColor = false,

		LayoutOrder = Index

	}, Sidebar)

	Corner(
		Button,
		4
	)

	Navigation[Category] =
		Button

	Button.MouseEnter:Connect(
		function()

			if CurrentCategory ~=
				Category then

				Tween(
					Button,
					{
						BackgroundColor3 =
							C.Hover
					},
					0.12
				)

			end

		end
	)

	Button.MouseLeave:Connect(
		function()

			if CurrentCategory ~=
				Category then

				Tween(
					Button,
					{
						BackgroundColor3 =
							C.Panel
					},
					0.12
				)

			end

		end
	)

	Button.MouseButton1Click:Connect(
		function()

			SelectCategory(
				Category
			)

		end
	)

end

----------------------------------------------------------------
-- SIDEBAR FOOTER
----------------------------------------------------------------

local Footer = New("Frame", {
	Size = UDim2.new(1, 0, 0, 58),
	BackgroundTransparency = 1,
	LayoutOrder = 100
}, Sidebar)


local UninjectButton = New("TextButton", {
	Position = UDim2.new(1, -115, 2.1, 0),
	Size = UDim2.fromOffset(98, 34),
	BackgroundColor3 = C.Panel,
	BorderSizePixel = 0,
	Text = "Uninject",
	TextColor3 = C.SubText,
	TextSize = 10,
	Font = Enum.Font.GothamMedium,
	AutoButtonColor = false
	
}, Footer)

Corner(UninjectButton, 4)
Stroke(UninjectButton)

for _, FooterButton in ipairs({UninjectButton}) do
	FooterButton.MouseEnter:Connect(function()
		Tween(FooterButton, {
			BackgroundColor3 = C.Hover,
			TextColor3 = C.Text
		}, 0.12)
	end)

	FooterButton.MouseLeave:Connect(function()
		Tween(FooterButton, {
			BackgroundColor3 = C.Panel,
			TextColor3 = C.SubText
		}, 0.12)
	end)
end

local ModalUninject = New("TextButton", {
	Position = UDim2.fromOffset(16, 125),
	Size = UDim2.new(1, -32, 0, 34),
	BackgroundColor3 = C.Panel2,
	BorderSizePixel = 0,
	Text = "Uninject and remove Aero",
	TextColor3 = C.Text,
	TextSize = 10,
	Font = Enum.Font.GothamMedium,
	AutoButtonColor = false,
	ZIndex = 81
}, SettingsWindow)

Corner(ModalUninject, 4)
Stroke(ModalUninject)

UninjectButton.MouseButton1Click:Connect(Uninject)
ModalUninject.MouseButton1Click:Connect(Uninject)

SelectCategory("Combat")

----------------------------------------------------------------
-- GLOBAL SEARCH
----------------------------------------------------------------

Search:GetPropertyChangedSignal(
	"Text"
):Connect(
	function()

		local Query =
			string.lower(
				Search.Text
			)

		if Query == "" then

			for _, Module in ipairs(
				ModuleObjects
				) do

				Module.Frame.Visible =
					true

			end

			SelectCategory(
				CurrentCategory
			)

			return
		end

		local FirstMatch = nil

		for _, Module in ipairs(
			ModuleObjects
			) do

			local ModuleName =
				string.lower(
					Module.Name
				)

			local Match =
				string.find(
					ModuleName,
					Query,
					1,
					true
				) ~= nil

			Module.Frame.Visible =
				Match

			if Match
				and not FirstMatch then

				FirstMatch =
					Module

			end

		end

		if FirstMatch then

			SelectCategory(
				FirstMatch.Category
			)

		end

	end
)

----------------------------------------------------------------
-- WINDOW DRAGGING
----------------------------------------------------------------

local DraggingWindow = false
local DragStart
local StartPosition

Top.InputBegan:Connect(
	function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			DraggingWindow = true

			DragStart =
				Input.Position

			StartPosition =
				Main.Position

		end

	end
)

UIS.InputChanged:Connect(
	function(Input)

		if not DraggingWindow then
			return
		end

		if Input.UserInputType ~=
			Enum.UserInputType.MouseMovement then

			return

		end

		local Delta =
			Input.Position
		- DragStart

		Main.Position =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset
				+ Delta.X,

				StartPosition.Y.Scale,
				StartPosition.Y.Offset
				+ Delta.Y
			)

	end
)

UIS.InputEnded:Connect(
	function(Input)

		if Input.UserInputType ==
			Enum.UserInputType.MouseButton1 then

			DraggingWindow = false

		end

	end
)



local Button = Instance.new("TextButton")

Button.Size = UDim2.fromOffset(40, 40)
Button.Position = UDim2.new(1, -50, 0, 10)
Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Button.BorderSizePixel = 0
Button.Text = "💨"
Button.TextColor3 = Color3.fromRGB(200, 200, 200)
Button.TextSize = 20
Button.Parent = Main.Parent

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Button

Button.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

local Dragging = false
local DragStart
local StartPosition

Button.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = true
		DragStart = Input.Position
		StartPosition = Button.Position

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = Input.Position - DragStart

		Button.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputBegan:Connect(function(Input, Processed)
	if Processed then
		return
	end

	if Input.KeyCode == Enum.KeyCode.RightShift then
		Main.Visible = not Main.Visible
	end
end)


----------------------------------------------------------------
-- RIGHT SHIFT
----------------------------------------------------------------

UIS.InputBegan:Connect(
	function(Input, Processed)

		if Processed then
			return
		end

		if Input.KeyCode ==
			Enum.KeyCode.RightShift then

			Main.Visible =
				not Main.Visible

		end

	end
)

----------------------------------------------------------------
-- CHARACTER RESPAWN
----------------------------------------------------------------

LocalPlayer.CharacterAdded:Connect(
	function()

		task.wait(1)

		if FOVEnabled then
			ApplyFOV()
		end

		if CapeObject then
			CreateCape()
		end

		if BreadcrumbEnabled then
			SetBreadcrumbs(true)
		end

		if SpeedEnabled then
			local Character = LocalPlayer.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				Humanoid.WalkSpeed = SpeedValue
			end
		end

	end
)

----------------------------------------------------------------
-- STARTUP
----------------------------------------------------------------

task.wait(0.5)

Notify(
	"Aero",
	"Loaded successfully"
)
print("ar")
