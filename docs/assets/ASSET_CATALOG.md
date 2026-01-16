# Asset Catalog (Studio-Owned)

Roblox Studio holds most Models/Assets for this project.
VS Code/Rojo code cannot "see" Studio-only models unless we define an asset contract here.

Rules:
- All Studio assets live under: ReplicatedStorage/Assets
- Recommended subfolders: Models, UI, Sounds, VFX, Rooms, Animations
- Code never hardcodes deep paths; it uses Shared/Assets (AssetDefs + Assets.get).

How to add a new required asset:
1) Create it in Studio under ReplicatedStorage/Assets/<Category>/<Name>
2) Add an entry to src/shared/Assets/AssetDefs.luau (key -> relative path)
3) Add a row in docs/assets/assets.json with description + status
4) Press Play and confirm AssetAudit reports "All assets present ✅"

Status meanings (assets.json): planned | stub | ready | deprecated
