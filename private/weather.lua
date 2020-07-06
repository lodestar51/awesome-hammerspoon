-- 编辑weather/weather.lua
-- 天气接口使用tianqiapi免费接口, 需要简单注册获取ID及密码
local urlApi = 'https://www.tianqiapi.com/api/?version=v1&appid=13554981&appsecret=rfl2IOfg'
local menubar = hs.menubar.new()
local menuData = {}

-- 天气图标
local weaEmoji = {
   lei = '⛈',
   qing = '☀️',
   shachen = '😷',
   wu = '🌫',
   xue = '❄️',
   yu = '🌧',
   yujiaxue = '🌨',
   yun = '☁️',
   zhenyu = '🌧',
   yin = '⛅️',
   default = ''
}

function updateMenubar()
	 menubar:setTooltip("天气预报")
    menubar:setMenu(menuData)
end

function getWeather()
   -- 请求API接口
   hs.http.doAsyncRequest(urlApi, "GET", nil,nil, function(code, body, htable)
      if code ~= 200 then
         print('get weather error:'..code)
         return
      end
      rawjson = hs.json.decode(body)
      city = rawjson.city
      menuData = {}
      -- 处理数据，更新到菜单栏里
      for k, v in pairs(rawjson.data) do
         if k == 1 then
            menubar:setTitle(weaEmoji[v.wea_img])
            titlestr = string.format("%s %s %s 🌡️%s 💧%s 💨%s 🌬 %s %s", city,weaEmoji[v.wea_img],v.day, v.tem, v.humidity, v.air, v.win_speed, v.wea)
            item = { title = titlestr }
            table.insert(menuData, item)
            table.insert(menuData, {title = '-'})
         else
            -- titlestr = string.format("%s %s %s %s", v.day, v.wea, v.tem, v.win_speed)
            titlestr = string.format("%s %s %s 🌡️%s 🌬%s %s", city, weaEmoji[v.wea_img],v.day, v.tem, v.win_speed, v.wea)
            item = { title = titlestr }
            table.insert(menuData, item)
         end
      end
      updateMenubar()
   end)
end

menubar:setTitle('⌛')
getWeather()
updateMenubar()
-- 定时任务
hs.timer.doEvery(3600, getWeather)

-- https://ushell.me/2019/09/08/hammerspoon%E6%8F%90%E9%AB%98%E7%94%9F%E4%BA%A7%E5%8A%9B/

-- local urlApi = 'https://www.tianqiapi.com/api/?version=v1'
-- local menubar = hs.menubar.new()
-- local menuData = {}

-- local weaEmoji = {
--    lei = '⛈',
--    qing = '☀️',
--    shachen = '😷',
--    wu = '🌫',
--    xue = '❄️',
--    yu = '🌧',
--    yujiaxue = '🌨',
--    yun = '☁️',
--    zhenyu = '🌧',
--    yin = '⛅️',
--    default = ''
-- }

-- function updateMenubar()
-- 	 menubar:setTooltip("Weather Info")
--     menubar:setMenu(menuData)
-- end

-- function getWeather()
--    hs.http.doAsyncRequest(urlApi, "GET", nil,nil, function(code, body, htable)
--       if code ~= 200 then
--          print('get weather error:'..code)
--          return
--       end
--       rawjson = hs.json.decode(body)
--       city = rawjson.city
--       menuData = {}
--       for k, v in pairs(rawjson.data) do
--          if k == 1 then
--             menubar:setTitle(weaEmoji[v.wea_img])
--             titlestr = string.format("%s %s %s 🌡️%s 💧%s 💨%s 🌬 %s %s", city,weaEmoji[v.wea_img],v.day, v.tem, v.humidity, v.air, v.win_speed, v.wea)
--             item = { title = titlestr }
--             table.insert(menuData, item)
--             table.insert(menuData, {title = '-'})
--          else
--             -- titlestr = string.format("%s %s %s %s", v.day, v.wea, v.tem, v.win_speed)
--             titlestr = string.format("%s %s %s 🌡️%s 🌬%s %s", city, weaEmoji[v.wea_img],v.day, v.tem, v.win_speed, v.wea)
--             item = { title = titlestr }
--             table.insert(menuData, item)
--          end
--       end
--       updateMenubar()
--    end)
-- end

-- menubar:setTitle('⌛')
-- getWeather()
-- updateMenubar()
-- hs.timer.doEvery(3600, getWeather)