-- Server-only: ensures ReplicatedStorage.Remotes exists + contains all defined remotes
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local defs = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Net"):WaitForChild("RemoteDefs"))

local function getOrCreateFolder()
  local folder = ReplicatedStorage:FindFirstChild("Remotes")
  if not folder then
    folder = Instance.new("Folder")
    folder.Name = "Remotes"
    folder.Parent = ReplicatedStorage
  end
  return folder
end

local function ensureRemote(folder: Folder, name: string, className: string)
  local existing = folder:FindFirstChild(name)
  if existing then return existing end

  local inst = Instance.new(className)
  inst.Name = name
  inst.Parent = folder
  return inst
end

return function()
  local folder = getOrCreateFolder()
  for name, className in pairs(defs) do
    ensureRemote(folder, name, className)
  end
end
