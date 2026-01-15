# Architecture & Conventions

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
