-- window management
local application = require "hs.application"
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local layout = require "hs.layout"
local grid = require "hs.grid"
local hints = require "hs.hints"
local screen = require "hs.screen"
local alert = require "hs.alert"
local fnutils = require "hs.fnutils"
local geometry = require "hs.geometry"
local mouse = require "hs.mouse"

-- default 0.2
window.animationDuration = 0

-- left half
hotkey.bind(hyper, "Left", function()
  if window.focusedWindow() then
    window.focusedWindow():moveToUnit(layout.left50)
  else
    alert.show("No active window")
  end
end)

-- right half
hotkey.bind(hyper, "Right", function()
  window.focusedWindow():moveToUnit(layout.right50)
end)

-- top half
hotkey.bind(hyper, "Up", function()
  window.focusedWindow():moveToUnit'[0,0,100,50]'
end)

-- bottom half
hotkey.bind(hyper, "Down", function()
  window.focusedWindow():moveToUnit'[0,50,100,100]'
end)

-- left top quarter
hotkey.bind(hyperAlt, "Left", function()
  window.focusedWindow():moveToUnit'[0,0,50,50]'
end)

-- right bottom quarter
hotkey.bind(hyperAlt, "Right", function()
  window.focusedWindow():moveToUnit'[50,50,100,100]'
end)

-- right top quarter
hotkey.bind(hyperAlt, "Up", function()
  window.focusedWindow():moveToUnit'[50,0,100,50]'
end)

-- left bottom quarter
hotkey.bind(hyperAlt, "Down", function()
  window.focusedWindow():moveToUnit'[0,50,50,100]'
end)

-- full screen
hotkey.bind(hyper, 'F', function() 
  window.focusedWindow():toggleFullScreen()
end)

-- center window
hotkey.bind(hyper, 'C', function()
  local cwin = hs.window.focusedWindow()
  cwin:centerOnScreen()
  window.focusedWindow():centerOnScreen()
end)

-- maximize window
hotkey.bind(hyper, 'M', function() toggle_maximize() end)

-- defines for window maximize toggler
local frameCache = {}
-- toggle a window between its normal size, and being maximized
function toggle_maximize()
    local win = window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

-- display a keyboard hint for switching focus to each window
hotkey.bind(hyperShift, '/', function()
    hints.windowHints()
    -- Display current application window
    -- hints.windowHints(hs.window.focusedWindow():application():allWindows())
end)

-- switch active window
hotkey.bind(hyperShift, "H", function()
  window.switcher.nextWindow()
end)

-- move active window to previous monitor 窗口SHIFT+ALT+<- 移动上个显示器
hotkey.bind(hyperShift, "Left", function()
  window.focusedWindow():moveOneScreenWest()
end)

-- move active window to next monitor 窗口SHIFT+ALT+-> 移动下个显示器
hotkey.bind(hyperShift, "Right", function()
  window.focusedWindow():moveOneScreenEast()
end)

-- move cursor to previous monitor CTRL+ALT+<- 鼠标移动上个显示器
hotkey.bind(hyperCtrl, "Left", function ()
  focusScreen(window.focusedWindow():screen():previous())
end)

-- move cursor to next monitor CTRL+ALT+<- 鼠标移动下个显示器
hotkey.bind(hyperCtrl, "Right", function ()
  focusScreen(window.focusedWindow():screen():next())
end)


--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = fnutils.filter(
      window.orderedWindows(),
      fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or window.desktop()
  windowToFocus:focus()

  -- move cursor to center of screen
  local pt = geometry.rectMidPoint(screen:fullFrame())
  mouse.setAbsolutePosition(pt)
end

-- maximized active window and move to selected monitor 移动到显示器上
moveto = function(win, n)
  local screens = screen.allScreens()
  if n > #screens then
    alert.show("Only " .. #screens .. " monitors ")
  else
    local toWin = screen.allScreens()[n]:name()
    alert.show("Move " .. win:application():name() .. " to " .. toWin)

    layout.apply({{nil, win:title(), toWin, layout.maximized, nil, nil}})
 
  end
end

-- move cursor to monitor 1 and maximize the window
hotkey.bind(hyperShift, "1", function()
  local win = window.focusedWindow()
  moveto(win, 1)
end)

hotkey.bind(hyperShift, "2", function()
  local win = window.focusedWindow()
  moveto(win, 2)
end)

hotkey.bind(hyperShift, "3", function()
  local win = window.focusedWindow()
  moveto(win, 3)
end)

-- https://github.com/007sair/hammerspoon/blob/master/modules/windows.lua
-- ⇧⌥ + ← 将当前活动窗口移动到上一个显示器
-- ⇧⌥ + → 将当前活动窗口移动到下一个显示器
-- ⇧⌥ + 1 将当前活动窗口移动到第一个显示器并窗口最大化
-- ⇧⌥ + 2 将当前活动窗口移动到第二个显示器并窗口最大化


-- 快捷键
-- 移动光标
-- ⌃⌥ + ← 把光标移动到下一个显示器
-- ⌃⌥ + → 把光标移动到上一个显示器
-- 移动窗口
-- ⇧⌥ + ← 将当前活动窗口移动到上一个显示器
-- ⇧⌥ + → 将当前活动窗口移动到下一个显示器
-- ⇧⌥ + 1 将当前活动窗口移动到第一个显示器并窗口最大化
-- ⇧⌥ + 2 将当前活动窗口移动到第二个显示器并窗口最大化
-- 其他快捷键

-- https://github.com/greyby/hammerspoon/blob/master/README_zh-CN.md