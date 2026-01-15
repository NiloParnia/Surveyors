# MIRA_CONTEXT (paste this into future chats)

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
