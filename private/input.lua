-----------------------mine start-----------------------------
-- ADD by Thomas
local function Chinese()
    hs.console.printStyledtext("chinese")
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
  end
  local function English()
    hs.console.printStyledtext(hs.keycodes.currentSourceID())
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
  end
  hs.console.printStyledtext("inputM:" + hs.keycodes.currentSourceID())

  local function set_app_input_method(app_name, set_input_method_function, event)
    event = event or hs.window.filter.windowFocused
    hs.window.filter.new(app_name)
      :subscribe(event, function() set_input_method_function() end)
  end
  set_app_input_method('Hammerspoon', English, hs.window.filter.windowCreated)
  set_app_input_method('Spotlight', English, hs.window.filter.windowCreated)
  set_app_input_method('Emacs', English)
  set_app_input_method('Slack', English)
  set_app_input_method('Terminal', English)
  set_app_input_method('iTerm2', English)
  set_app_input_method('Google Chrome', English)
  set_app_input_method('Sublime Text', English)
  -----------------------mine end-----------------------------