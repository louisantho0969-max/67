local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

------------------------------------------------
-- 🎬 LOADING
------------------------------------------------
local loadingGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

local loadFrame = Instance.new("Frame", loadingGui)
loadFrame.Size = UDim2.new(1,0,1,0)
loadFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)

local txt = Instance.new("TextLabel", loadFrame)
txt.Size = UDim2.new(1,0,1,0)
txt.Text = "LOADING..."
txt.TextColor3 = Color3.fromRGB(0,255,255)
txt.Font = Enum.Font.GothamBlack
txt.TextSize = 28
txt.BackgroundTransparency = 1

task.wait(2)
loadingGui:Destroy()

------------------------------------------------
-- 🎮 STATES
------------------------------------------------
local noclip = false
local invisible = false
local infiniteJump = false

------------------------------------------------
-- 🎨 GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "Menu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,270)
frame.Position = UDim2.new(0,20,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 3

task.spawn(function()
	while true do
		for i=0,1,0.01 do
			stroke.Color = Color3.fromHSV(i,1,1)
			task.wait(0.02)
		end
	end
end)

local function btn(t,y)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1,-10,0,35)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = t
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

------------------------------------------------
-- 🔘 BUTTONS
------------------------------------------------
local noclipBtn = btn("Noclip: OFF",10)
local invisBtn = btn("Invisible: OFF",50)
local jumpBtn = btn("Infinite Jump: OFF",90)

------------------------------------------------
-- ⚡ SPEED BOX
------------------------------------------------
local speedBox = Instance.new("TextBox", frame)
speedBox.Size = UDim2.new(1,-10,0,35)
speedBox.Position = UDim2.new(0,5,0,130)
speedBox.Text = "16"
speedBox.PlaceholderText = "Speed (ex: 50)"
speedBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.Font = Enum.Font.GothamBold
speedBox.TextSize = 14
speedBox.ClearTextOnFocus = false
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,8)

------------------------------------------------
-- 🔴 CLOSE BUTTON
------------------------------------------------
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBlack
close.TextSize = 16
Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)

------------------------------------------------
-- ❓ POPUP
------------------------------------------------
local pop = Instance.new("Frame", gui)
pop.Size = UDim2.new(0,220,0,120)
pop.Position = UDim2.new(0.5,-110,0.5,-60)
pop.BackgroundColor3 = Color3.fromRGB(20,20,20)
pop.Visible = false
Instance.new("UICorner", pop).CornerRadius = UDim.new(0,10)

local msg = Instance.new("TextLabel", pop)
msg.Size = UDim2.new(1,0,0.5,0)
msg.Text = "RESET ALL ?"
msg.BackgroundTransparency = 1
msg.TextColor3 = Color3.new(1,1,1)
msg.Font = Enum.Font.GothamBold
msg.TextSize = 16

local yes = Instance.new("TextButton", pop)
yes.Size = UDim2.new(0.45,0,0.35,0)
yes.Position = UDim2.new(0.05,0,0.55,0)
yes.Text = "YES"
yes.BackgroundColor3 = Color3.fromRGB(0,255,0)
Instance.new("UICorner", yes).CornerRadius = UDim.new(0,6)

local no = Instance.new("TextButton", pop)
no.Size = UDim2.new(0.45,0,0.35,0)
no.Position = UDim2.new(0.5,0,0.55,0)
no.Text = "NO"
no.BackgroundColor3 = Color3.fromRGB(255,0,0)
Instance.new("UICorner", no).CornerRadius = UDim.new(0,6)

------------------------------------------------
-- 🧱 NOCLIP
------------------------------------------------
RunService.Stepped:Connect(function()
	if noclip then
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

------------------------------------------------
-- 👻 INVISIBLE
------------------------------------------------
local saved = {}

local function invis(state)
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			if state then
				saved[v] = v.Transparency
				v.Transparency = 1
			else
				v.Transparency = 0
			end
		elseif v:IsA("Decal") then
			v.Transparency = state and 1 or 0
		end
	end
end

------------------------------------------------
-- 🦘 JUMP
------------------------------------------------
UIS.JumpRequest:Connect(function()
	if infiniteJump then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

------------------------------------------------
-- ⚡ SPEED
------------------------------------------------
speedBox.FocusLost:Connect(function()
	local v = tonumber(speedBox.Text)
	if v then
		hum.WalkSpeed = math.clamp(v,0,300)
	end
end)

------------------------------------------------
-- 🔘 BUTTON LOGIC
------------------------------------------------
noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = "Noclip: "..(noclip and "ON" or "OFF")
end)

invisBtn.MouseButton1Click:Connect(function()
	invisible = not invisible
	invisBtn.Text = "Invisible: "..(invisible and "ON" or "OFF")
	invis(invisible)
end)

jumpBtn.MouseButton1Click:Connect(function()
	infiniteJump = not infiniteJump
	jumpBtn.Text = "Infinite Jump: "..(infiniteJump and "ON" or "OFF")
end)

------------------------------------------------
-- ❌ RESET FIX (YES)
------------------------------------------------
yes.MouseButton1Click:Connect(function()
	noclip = false
	invisible = false
	infiniteJump = false

	noclipBtn.Text = "Noclip: OFF"
	invisBtn.Text = "Invisible: OFF"
	jumpBtn.Text = "Infinite Jump: OFF"

	if char then
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
				v.Transparency = 0
			elseif v:IsA("Decal") then
				v.Transparency = 0
			end
		end
	end

	hum.WalkSpeed = 16
	speedBox.Text = "16"

	pop.Visible = false
end)

no.MouseButton1Click:Connect(function()
	pop.Visible = false
end)

close.MouseButton1Click:Connect(function()
	pop.Visible = true
end)
