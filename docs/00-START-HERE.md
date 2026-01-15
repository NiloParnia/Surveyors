# Start Here (Dev Notes)

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
