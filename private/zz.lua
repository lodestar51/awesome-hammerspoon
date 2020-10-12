-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--     hs.alert.show("Hello World!")
--   end)

--HS在MAC原生的弹窗测试
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
    -- hs.notify.new({title="HS的测试", informativeText="Hello World"}):send()
    hs.alert.show("this is a test");
  end)
-- 对于当前窗口进行左移动的操作
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    
    f.x = f.x - 10
    win:setFrame(f)
  end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.alert.show("Config loaded")

clipboard = hs.chooser.new(function (choice)
  print(choice)
end)

hs.hotkey.bind({ "cmd", "shift" }, "v", function ()
  clipboard:show()
end)

-- https://www.ahonn.me/blog/how-to-implement-clipboard-history-with-hammerspoon


-- zz = hs.menubar.new()
-- function setZzDisplay(state)
--  if state then
--  zz:setTitle("宗之")
--  else
--  zz:setTitle("zongzhi")
--  end
-- end

-- function zzClicked()
--   setZzDisplay(hs.zz.toggle("displayIdle"))
-- end

-- if zz then
--  zz:setClickCallback(zzClicked)
--  setZzDisplay(hs.zz.get("displayIdle"))
-- end

-- https://www.macdown.com/news/2028.html

