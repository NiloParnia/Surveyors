local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Config = require(Shared:WaitForChild("Config"):WaitForChild("GameConfig"))
print(("[ClientBoot] ok | %s v%s"):format(Config.GAME_NAME, Config.VERSION))

-- Autoload client controllers
require(script.Parent:WaitForChild("ControllersLoader"))
