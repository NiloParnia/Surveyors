# Surveyors ChatGPT Snapshot\n\nGenerated: 2026-01-16 13:17:49 UTC\nBranch: main\nHEAD: ae7c99e3f63d1704911a50b661dd60ea5dc6015f\nLast commit: ae7c99e chore: fix snapshot workflow (track file + stage-before-diff)\n\n## Changed files (last commit)\n```\n.github/workflows/chatgpt_snapshot.yml
docs/CHATGPT_SNAPSHOT.md\n```\n\n## Git tracked files\n```\n.gitattributes
.github/workflows/chatgpt_snapshot.yml
.gitignore
README.md
aftman.toml
default.project.json
docs/00-START-HERE.md
docs/01-ARCHITECTURE.md
docs/02-ROADMAP-90D.md
docs/03-NEXT-STEPS.md
docs/04-TROUBLESHOOTING.md
docs/CHATGPT_SNAPSHOT.md
docs/MIRA_CONTEXT.md
src/client/ClientBoot.luau
src/client/ControllersLoader.luau
src/client/init.client.luau
src/server/RemotesSetup.luau
src/server/ServerBoot.luau
src/server/ServicesLoader.luau
src/server/init.server.luau
src/shared/Config/GameConfig.lua
src/shared/Hello.luau
src/shared/Net/Net.luau
src/shared/Net/RemoteDefs.luau
src/shared/Util/Util.lua
tools/make_chatgpt_snapshot.py\n```\n\n## default.project.json\n```\n{
  "name": "Game",
  "tree": {
    "$className": "DataModel",
    "ReplicatedStorage": {
      "$className": "ReplicatedStorage",
      "Shared": { "$path": "src/shared" },
      "Assets": { "$path": "src/Assets" }
    },
    "ServerScriptService": {
      "$className": "ServerScriptService",
      "Server": { "$path": "src/server" }
    },
    "StarterPlayer": {
      "$className": "StarterPlayer",
      "StarterPlayerScripts": {
        "$className": "StarterPlayerScripts",
        "Client": { "$path": "src/client" }
      }
    }
  }
}
\n```\n\n## README.md\n```\n﻿# Surveyors

High-ROI Roblox extraction/roguelite prototype built with Rojo.

## Quick start
1) Run: `rojo serve default.project.json`
2) In Roblox Studio, connect via the Rojo plugin (use the port Rojo prints).
3) Press Play; check Output for boot prints.

## Docs (read these first)
- Start here: docs/00-START-HERE.md
- Architecture: docs/01-ARCHITECTURE.md
- 90-day roadmap: docs/02-ROADMAP-90D.md
- Next steps: docs/03-NEXT-STEPS.md
- Troubleshooting: docs/04-TROUBLESHOOTING.md
- Session resume context: docs/MIRA_CONTEXT.md (paste into a future chat to resume instantly)

## Repo layout (Rojo mapping)
- src/shared -> ReplicatedStorage/Shared
- src/Assets -> ReplicatedStorage/Assets
- src/server -> ServerScriptService/Server
- src/client -> StarterPlayerScripts/Client

## Conventions
- Entrypoints: src/server/init.server.luau and src/client/init.client.luau only.
- Autoload: server loads src/server/Services/*, client loads src/client/Controllers/*.
- Networking: remotes defined in src/shared/Net/RemoteDefs.luau; created by server on boot.

## Gotchas
- If Rojo fails to parse default.project.json, ensure keys are "$className" and "$path" (no backslashes).
- Prefer ASCII or UTF-8 without BOM for JSON files on Windows.
\n```\n\n## docs/MIRA_CONTEXT.md\n```\n﻿# MIRA_CONTEXT (paste this into future chats)

Repo: Roblox game using Rojo (filesystem -> Studio sync).

Quick start:
1) rojo serve default.project.json
2) Connect via Rojo plugin in Roblox Studio (port printed in terminal)
3) Press Play; check output for boot prints

Rojo mapping (default.project.json):
- src/shared -> ReplicatedStorage/Shared
- src/Assets -> ReplicatedStorage/Assets
- src/server -> ServerScriptService/Server
- src/client -> StarterPlayerScripts/Client

Boot:
- src/server/init.server.luau -> requires ServerBoot.luau
- src/client/init.client.luau -> requires ClientBoot.luau

Autoload convention:
- src/server/ServicesLoader.luau loads every ModuleScript in src/server/Services
- src/client/ControllersLoader.luau loads every ModuleScript in src/client/Controllers

Networking convention:
- src/shared/Net/RemoteDefs.luau defines remotes
- src/server/RemotesSetup.luau creates ReplicatedStorage/Remotes + instances
- src/shared/Net/Net.luau provides Net.get("RemoteName")

Known pitfall we hit:
- default.project.json must contain "$className" (NOT "\$className")
- ASCII or UTF-8 without BOM avoids Rojo JSONC parse errors

---
## Autocontext system (keep ChatGPT synced)

This repo auto-generates **docs/CHATGPT_SNAPSHOT.md** on every push to main via a GitHub Action.

If you are ChatGPT (or using ChatGPT):
- Read docs/CHATGPT_SNAPSHOT.md first. It contains mapping, boots, remotes, and the latest important files in one place.
- If the snapshot seems stale, ask the user to run the snapshot generator and paste docs/CHATGPT_SNAPSHOT.md.

If the GitHub Action does not commit updates:
- In GitHub repo Settings -> Actions -> General -> Workflow permissions, set **Read and write permissions**.

\n```\n\n## docs/00-START-HERE.md\n```\n﻿# Start Here (Dev Notes)

Quick start:
1) rojo serve default.project.json
2) Connect in Roblox Studio via Rojo plugin (port printed in terminal).
3) Press Play; check output for boot prints.

Where to look:
- default.project.json (Rojo mapping)
- src/server/init.server.luau (server entry)
- src/client/init.client.luau (client entry)
- src/shared/Net (remotes defs + accessor)
- src/server/ServicesLoader.luau (autoload services)
- src/client/ControllersLoader.luau (autoload controllers)
\n```\n\n## docs/01-ARCHITECTURE.md\n```\n﻿# Architecture & Conventions

Rojo mapping (default.project.json):
- src/shared -> ReplicatedStorage/Shared
- src/Assets -> ReplicatedStorage/Assets
- src/server -> ServerScriptService/Server
- src/client -> StarterPlayerScripts/Client

Entrypoints:
- src/server/init.server.luau -> requires ServerBoot.luau
- src/client/init.client.luau -> requires ClientBoot.luau

Autoload:
- src/server/ServicesLoader.luau loads src/server/Services/* (ModuleScripts)
- src/client/ControllersLoader.luau loads src/client/Controllers/* (ModuleScripts)

Networking:
- src/shared/Net/RemoteDefs.luau defines remotes
- src/server/RemotesSetup.luau creates ReplicatedStorage/Remotes + instances
- src/shared/Net/Net.luau provides Net.get("RemoteName")

Rule: server authoritative; client requests only.
\n```\n\n## docs/02-ROADMAP-90D.md\n```\n﻿# 90-Day Plan

Month 1: MVP loop (run state, danger, held/banked, cashout) + basic rooms/pickups.
Month 2: Meta (DataStore, generators), cheap variety (room modifiers), social flex (titles/boards).
Month 3: Monetization (mostly convenience/cosmetics), exploit hardening, analytics + weekly tuning.
\n```\n\n## docs/03-NEXT-STEPS.md\n```\n﻿# Next Steps

1) Server RunService (authoritative run state)
2) Client HUDController (live state display)
3) Replace drip with pickups + corridor rooms
4) Death handling (loss %, streak reset, recap receipts)
\n```\n\n## docs/04-TROUBLESHOOTING.md\n```\n﻿# Troubleshooting

If Rojo fails to parse default.project.json:
- Ensure keys are "$className" and "$path" (no backslashes like "\$className").
- Prefer ASCII or UTF-8 without BOM.

If Studio will not sync:
- Confirm the Rojo plugin is enabled.
- Confirm the serve port printed by Rojo.
- Visit the localhost URL Rojo prints.
\n```\n\n## src/shared/Net/RemoteDefs.luau\n```\n﻿-- Shared: declare your remotes in one place.
-- Value is Roblox class name: "RemoteEvent" or "RemoteFunction"
return {
  -- Gameplay requests
  RequestCashout = "RemoteFunction",
  RequestStartRun = "RemoteFunction",

  -- Server -> client updates
  RunState = "RemoteEvent"
}
\n```\n\n## src/shared/Net/Net.luau\n```\n﻿-- Shared: safe-ish remote accessor (client/server)
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
\n```\n\n## src/server/RemotesSetup.luau\n```\n﻿-- Server-only: ensures ReplicatedStorage.Remotes exists + contains all defined remotes
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
\n```\n\n## src/server/ServerBoot.luau\n```\n﻿local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Config = require(Shared:WaitForChild("Config"):WaitForChild("GameConfig"))
local setupRemotes = require(script.Parent:WaitForChild("RemotesSetup"))

setupRemotes()

-- Autoload server services
require(script.Parent:WaitForChild("ServicesLoader"))

print(("[ServerBoot] ok | %s v%s"):format(Config.GAME_NAME, Config.VERSION))
\n```\n\n## src/server/ServicesLoader.luau\n```\n﻿-- Server Services loader
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
\n```\n\n## src/server/init.server.luau\n```\n﻿-- Entry Script (server)
require(script.Parent:WaitForChild("ServerBoot"))
\n```\n\n## src/client/ClientBoot.luau\n```\n﻿local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Config = require(Shared:WaitForChild("Config"):WaitForChild("GameConfig"))
print(("[ClientBoot] ok | %s v%s"):format(Config.GAME_NAME, Config.VERSION))

-- Autoload client controllers
require(script.Parent:WaitForChild("ControllersLoader"))
\n```\n\n## src/client/ControllersLoader.luau\n```\n﻿-- Client Controllers loader
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
\n```\n\n## src/client/init.client.luau\n```\n﻿-- Entry LocalScript (client)
require(script.Parent:WaitForChild("ClientBoot"))
\n```\n\n## src/shared/Config/GameConfig.lua\n```\n﻿-- Shared config (ModuleScript)
return {
  VERSION = "0.0.1",
  GAME_NAME = "Placeholder",
}
\n```\n\n## src/shared/Util/Util.lua\n```\n﻿-- Shared utility helpers (ModuleScript)
local Util = {}

function Util.clamp(x, a, b)
  if x < a then return a end
  if x > b then return b end
  return x
end

return Util
\n```\n