# Surveyors

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
