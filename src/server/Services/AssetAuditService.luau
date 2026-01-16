local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local defs = require(Shared:WaitForChild("Assets"):WaitForChild("AssetDefs"))

local function ensureAssetsRoot()
  local root = ReplicatedStorage:FindFirstChild("Assets")
  if not root then
    root = Instance.new("Folder")
    root.Name = "Assets"
    root.Parent = ReplicatedStorage
  end
  return root
end

local function exists(root: Instance, relPath: string): boolean
  local node: Instance? = root
  for part in string.gmatch(relPath, "[^/]+") do
    node = node and node:FindFirstChild(part) or nil
    if not node then return false end
  end
  return true
end

local function audit()
  local root = ensureAssetsRoot()
  local missing = {}
  for key, rel in pairs(defs) do
    if not exists(root, rel) then
      table.insert(missing, ("%s -> Assets/%s"):format(key, rel))
    end
  end
  if #missing > 0 then
    warn("[AssetAudit] Missing assets:\n  - " .. table.concat(missing, "\n  - "))
  else
    print("[AssetAudit] All assets present ✅")
  end
end

audit()
return true
