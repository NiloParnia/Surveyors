-- Shared: declare your remotes in one place.
-- Value is Roblox class name: "RemoteEvent" or "RemoteFunction"
return {
  -- Gameplay requests
  RequestCashout = "RemoteFunction",
  RequestStartRun = "RemoteFunction",

  -- Server -> client updates
  RunState = "RemoteEvent"
}
