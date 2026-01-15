-- Shared utility helpers (ModuleScript)
local Util = {}

function Util.clamp(x, a, b)
  if x < a then return a end
  if x > b then return b end
  return x
end

return Util
