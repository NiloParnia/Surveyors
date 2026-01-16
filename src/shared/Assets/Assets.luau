local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Assets = {}
local defs = require(script.Parent:WaitForChild("AssetDefs"))

local function getRoot()
  return ReplicatedStorage:WaitForChild("Assets")
end

local function walk(root: Instance, relPath: string, mustExist: boolean)
  local node: Instance? = root
  for part in string.gmatch(relPath, "[^/]+") do
    node = node and (mustExist and node:WaitForChild(part) or node:FindFirstChild(part)) or nil
    if not node then return nil end
  end
  return node
end

function Assets.get(key: string): Instance
  local rel = defs[key]
  if not rel then error(("Assets.get: unknown key '%s'"):format(key)) end
  local inst = walk(getRoot(), rel, true)
  if not inst then error(("Assets.get: missing '%s' at Assets/%s"):format(key, rel)) end
  return inst
end

function Assets.tryGet(key: string): Instance?
  local rel = defs[key]
  if not rel then return nil end
  return walk(getRoot(), rel, false)
end

return Assets
