-- brew install --cask hammerspoon
-- ~/.hammerspoon/init.lua

local apps = {
  ["2"] = "Safari",
  ["3"] = "Zed",
  ["4"] = "Terminal"
}

for key, app in pairs(apps) do
  hs.hotkey.bind({"cmd"}, key, function()
    hs.application.launchOrFocus(app)
  end)
end
