local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Config = require(Shared:WaitForChild("Config"):WaitForChild("GameConfig"))
local setupRemotes = require(script.Parent:WaitForChild("RemotesSetup"))

setupRemotes()

-- Autoload server services
require(script.Parent:WaitForChild("ServicesLoader"))

print(("[ServerBoot] ok | %s v%s"):format(Config.GAME_NAME, Config.VERSION))
