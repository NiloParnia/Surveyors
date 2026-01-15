-- Client Controllers loader
local ControllersFolder = script.Parent:WaitForChild("Controllers")

local function isModuleScript(inst)
  return inst:IsA("ModuleScript")
end

for _, child in ipairs(ControllersFolder:GetChildren()) do
  if isModuleScript(child) then
    local ok, result = pcall(require, child)
    if not ok then
      warn(("[Controllers] Failed to load %s: %s"):format(child.Name, result))
    else
      print(("[Controllers] Loaded %s"):format(child.Name))
    end
  end
end
