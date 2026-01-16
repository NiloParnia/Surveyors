-- Server/Services/RunService.luau
-- Authoritative per-player run state (MVP)

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Shared = ReplicatedStorage:WaitForChild('Shared')
local Net = require(Shared:WaitForChild('Net'):WaitForChild('Net'))

local runStateEvent = Net.get('RunState')
local startRunFn = Net.get('RequestStartRun')
local cashoutFn = Net.get('RequestCashout')

type State = {
  inRun: boolean,
  danger: number,
  held: number,
  banked: number,
  streak: number,
}

local states: {[number]: State} = {}

local function getState(plr: Player): State
  local st = states[plr.UserId]
  if not st then
    st = { inRun=false, danger=0, held=0, banked=0, streak=0 }
    states[plr.UserId] = st
  end
  return st
end

local function send(plr: Player)
  local st = getState(plr)
  runStateEvent:FireClient(plr, {
    inRun = st.inRun,
    danger = st.danger,
    held = st.held,
    banked = st.banked,
    streak = st.streak,
  })
end

local function multiplier(danger: number, streak: number): number
  local m = 1 + (danger * 0.05) + (streak * 0.10)
  if m < 1 then m = 1 end
  if m > 50 then m = 50 end
  return m
end

local function startRun(plr: Player)
  local st = getState(plr)
  st.inRun = true
  st.danger = 0
  st.held = 0
  send(plr)
  return true
end

local function cashout(plr: Player)
  local st = getState(plr)
  if not st.inRun then return false, 'Not in run' end
  local m = multiplier(st.danger, st.streak)
  local gain = math.floor(st.held * m)
  st.banked += gain
  st.held = 0
  st.inRun = false
  st.danger = 0
  st.streak += 1
  send(plr)
  return true, gain, m
end

startRunFn.OnServerInvoke = function(plr: Player)
  return startRun(plr)
end

cashoutFn.OnServerInvoke = function(plr: Player)
  return cashout(plr)
end

-- MVP tick: danger climbs; held rises slowly (replace with pickups later)
RunService.Heartbeat:Connect(function(dt)
  for _, plr in ipairs(Players:GetPlayers()) do
    local st = getState(plr)
    if st.inRun then
      st.danger += dt
      st.held += dt * (1 + st.danger * 0.02)
      -- throttle updates ~4/sec
      if math.floor(os.clock()*4) ~= math.floor((os.clock()-dt)*4) then
        send(plr)
      end
    end
  end
end)

Players.PlayerAdded:Connect(function(plr)
  getState(plr)
  task.defer(function() send(plr) end)
end)

Players.PlayerRemoving:Connect(function(plr)
  states[plr.UserId] = nil
end)

return true
