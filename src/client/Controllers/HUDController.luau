-- Client/Controllers/HUDController.luau
-- Minimal HUD for run state testing

local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local player = Players.LocalPlayer
local Shared = ReplicatedStorage:WaitForChild('Shared')
local Net = require(Shared:WaitForChild('Net'):WaitForChild('Net'))

local runStateEvent = Net.get('RunState')
local startRunFn = Net.get('RequestStartRun')
local cashoutFn = Net.get('RequestCashout')

local gui = Instance.new('ScreenGui')
gui.Name = 'HUD'
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild('PlayerGui')

local label = Instance.new('TextLabel')
label.Size = UDim2.new(0, 420, 0, 120)
label.Position = UDim2.new(0, 14, 0, 14)
label.BackgroundTransparency = 0.35
label.TextSize = 18
label.TextWrapped = true
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.Parent = gui

local startBtn = Instance.new('TextButton')
startBtn.Size = UDim2.new(0, 140, 0, 40)
startBtn.Position = UDim2.new(0, 14, 0, 140)
startBtn.Text = 'Start Run'
startBtn.Parent = gui

local cashBtn = Instance.new('TextButton')
cashBtn.Size = UDim2.new(0, 140, 0, 40)
cashBtn.Position = UDim2.new(0, 164, 0, 140)
cashBtn.Text = 'Cashout'
cashBtn.Parent = gui

local function render(st)
  label.Text = ('IN RUN: %s\\nDANGER: %.1f\\nHELD: %d\\nBANKED: %d\\nSTREAK: %d'):format(
    st.inRun and 'YES' or 'no',
    st.danger or 0,
    math.floor(st.held or 0),
    math.floor(st.banked or 0),
    st.streak or 0
  )
end

runStateEvent.OnClientEvent:Connect(render)

startBtn.MouseButton1Click:Connect(function()
  local ok, res = pcall(function() return startRunFn:InvokeServer() end)
  if not ok then warn('StartRun failed', res) end
end)

cashBtn.MouseButton1Click:Connect(function()
  local ok, a, b, c = pcall(function() return cashoutFn:InvokeServer() end)
  if not ok then warn('Cashout failed', a) end
end)

return true
