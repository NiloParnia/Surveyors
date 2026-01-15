-- Shared: safe-ish remote accessor (client/server)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = {}
local defs = require(script.Parent:WaitForChild("RemoteDefs"))

local function getFolder()
  return ReplicatedStorage:WaitForChild("Remotes")
end

function Net.get(name: string)
  if defs[name] == nil then
    error(("Net.get: unknown remote '%s'"):format(name))
  end
  return getFolder():WaitForChild(name)
end

return Net
