-- Server Services loader
local ServicesFolder = script.Parent:WaitForChild("Services")

local function isModuleScript(inst)
  return inst:IsA("ModuleScript")
end

for _, child in ipairs(ServicesFolder:GetChildren()) do
  if isModuleScript(child) then
    local ok, result = pcall(require, child)
    if not ok then
      warn(("[Services] Failed to load %s: %s"):format(child.Name, result))
    else
      print(("[Services] Loaded %s"):format(child.Name))
    end
  end
end
