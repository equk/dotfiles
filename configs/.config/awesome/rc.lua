----
-- equilibriumuk awesomewm config
----
-- https://github.com/equk/dotfiles
----

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gears = require 'gears'
local awful = require 'awful'
require 'awful.autofocus'
-- Widget and layout library
local wibox = require 'wibox'
-- Theme handling library
local beautiful = require 'beautiful'
-- Notification library
local naughty = require 'naughty'
local menubar = require 'menubar'
-- local hotkeys_popup = require 'awful.hotkeys_popup'
-- Extra Widget library
local vicious = require 'vicious'
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require 'awful.hotkeys_popup.keys'

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify {
    preset = naughty.config.presets.critical,
    title = 'Oops, there were errors during startup!',
    text = awesome.startup_errors,
  }
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal('debug::error', function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = 'Oops, an error happened!',
      text = tostring(err),
    }
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

-- Use correct status icon size
awesome.set_preferred_icon_size(32)

-- Enable gaps
beautiful.useless_gap = 2
-- Unless single window
beautiful.gap_single_client = false

-- Fix window snapping
awful.mouse.snap.edge_enabled = false

-- define default apps (global variable so other components can access it)
local apps = {
  terminal = 'alacritty',
  launcher = 'rofi -show run -lines 3 -width 40 -columns 3 -bw 0 -font "monospace 12" -matching fuzzy -sort -theme "solarized_alternate"',
  lock = 'xscreensaver-command -lock',
  logout = 'logout_rs',
  screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
  filebrowser = 'thunar',
}

-- List of apps to run on start-up
local run_on_start_up = {
  '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1',
  'numlockx',
  'xscreensaver -no-splash',
  'thunar --daemon',
  'parcellite',
  'nitrogen --restore',
  'systembus-notify',
  'easyeffects --gapplication-service',
  'pnmixer',
  'pactl set-sink-volume 0 40%',
}

-- Default modkey.
local modkey = 'Mod4'

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.spiral,
  awful.layout.suit.max,
  awful.layout.suit.floating,
}
-- }}}

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
  local current_layout = awful.tag.getproperty(t, 'layout')
  if current_layout == awful.layout.suit.max then
    t.gap = 0
  else
    t.gap = beautiful.useless_gap
  end
end)

-- Run all the apps listed in run_on_start_up
for _, app in ipairs(run_on_start_up) do
  local findme = app
  local firstspace = app:find ' '
  if firstspace then
    findme = app:sub(0, firstspace - 1)
  end
  -- pipe commands to bash to allow command to be shell agnostic
  awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end

-- Menubar configuration
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Create a widget for Intel CPU temperature
local coretemp = wibox.widget.textbox()
vicious.register(
  coretemp,
  vicious.widgets.hwmontemp,
  ' <span foreground="#8655a8">CPU</span> $1°C ',
  5,
  { 'coretemp', 2 }
)

-- Create a widget for AMD GPU temperature
local amdtemp = wibox.widget.textbox()
vicious.register(amdtemp, vicious.widgets.hwmontemp, ' <span foreground="#8655a8">GPU</span> $1°C', 5, { 'amdgpu' })

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal('request::activate', 'tasklist', { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list { theme = { width = 250 } }
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

-- local function set_wallpaper(s)
--   -- Wallpaper
--   if beautiful.wallpaper then
--     local wallpaper = beautiful.wallpaper
--     -- If wallpaper is a function, call it with the screen
--     if type(wallpaper) == 'function' then
--       wallpaper = wallpaper(s)
--     end
--     gears.wallpaper.maximized(wallpaper, s, true)
--   end
-- end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal('property::geometry', set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  -- set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar { position = 'top', screen = s, height = 14 }

  -- Create systray
  s.systray = wibox.widget.systray()

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      amdtemp,
      coretemp,
      mytextclock,
      s.systray,
      s.mylayoutbox,
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(

  -- Spawn terminal
  awful.key({ modkey }, 'Return', function()
    awful.spawn(apps.terminal)
  end, { description = 'open a terminal', group = 'launcher' }),
  -- launch rofi
  awful.key({ modkey }, 'd', function()
    awful.spawn(apps.launcher)
  end, { description = 'application launcher', group = 'launcher' }),
  -- launch rofi
  awful.key({ 'Control' }, 'space', function()
    awful.spawn(apps.launcher)
  end, { description = 'application launcher', group = 'launcher' }),
  -- lock screen
  awful.key({ modkey }, 'l', function()
    awful.spawn(apps.lock)
  end, { description = 'lock screen', group = 'launcher' }),
  -- logout menu
  awful.key({ modkey, 'Shift' }, 'e', function()
    awful.spawn(apps.logout)
  end, { description = 'logout menu', group = 'launcher' }),

  -- Focus on tags
  awful.key({ modkey }, 'Right', awful.tag.viewnext, { description = 'view next', group = 'tag' }),
  awful.key({ modkey }, 'Left', awful.tag.viewprev, { description = 'view previous', group = 'tag' }),

  -- Master and column manipulation
  awful.key({ modkey }, 'm', function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = 'increase the number of master clients', group = 'layout' }),
  awful.key({ modkey, 'Shift' }, 'm', function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = 'decrease the number of master clients', group = 'layout' }),
  awful.key({ modkey }, 'n', function()
    awful.tag.incncol(1, nil, true)
  end, { description = 'increase the number of columns', group = 'layout' }),
  awful.key({ modkey, 'Shift' }, 'n', function()
    awful.tag.incncol(-1, nil, true)
  end, { description = 'decrease the number of columns', group = 'layout' }),

  -- Swap layout
  awful.key({ modkey }, 'space', function()
    awful.layout.inc(1)
  end, { description = 'select next', group = 'layout' }),
  awful.key({ modkey, 'Shift' }, 'space', function()
    awful.layout.inc(-1)
  end, { description = 'select previous', group = 'layout' }),

  -- Focus screen
  awful.key({ modkey }, 'Tab', function()
    awful.screen.focus_relative(1)
  end, { description = 'focus the next screen', group = 'screen' }),
  awful.key({ modkey, 'Shift' }, 'Tab', function()
    awful.screen.focus_relative(-1)
  end, { description = 'focus the previous screen', group = 'screen' }),

  -- Standard program
  awful.key({ modkey, 'Shift' }, 'w', awesome.restart, { description = 'reload awesome', group = 'awesome' }),
  awful.key({ modkey, 'Shift' }, 'Escape', awesome.quit, { description = 'quit awesome', group = 'awesome' }),
  awful.key({ modkey, 'Shift' }, 'p', function()
    awful.prompt.run {
      prompt = 'Run Lua code: ',
      textbox = awful.screen.focused().mypromptbox.widget,
      exe_callback = awful.util.eval,
      history_path = awful.util.get_cache_dir() .. '/history_eval',
    }
  end, { description = 'lua execute prompt', group = 'awesome' })
)

local clientkeys = gears.table.join(
  -- Handling window states
  awful.key({ modkey }, 'f', function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = 'toggle fullscreen', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'q', function(c)
    c:kill()
  end, { description = 'close', group = 'client' }),
  awful.key({ modkey }, 'o', awful.client.floating.toggle, { description = 'toggle floating', group = 'client' }),

  -- Layout control
  awful.key({ modkey, 'Shift' }, 'Return', function(c)
    c:swap(awful.client.getmaster())
  end, { description = 'move to master', group = 'client' }),
  awful.key({ modkey }, 's', function(c)
    c:move_to_screen()
  end, { description = 'move to screen', group = 'client' }),

  -- Moving window focus works between desktops
  awful.key({ modkey }, 'Down', function(c)
    awful.client.focus.global_bydirection 'down'
    c:lower()
  end, { description = 'focus next window up', group = 'client' }),
  awful.key({ modkey }, 'Up', function(c)
    awful.client.focus.global_bydirection 'up'
    c:lower()
  end, { description = 'focus next window down', group = 'client' }),
  awful.key({ modkey }, 'Right', function(c)
    awful.client.focus.global_bydirection 'right'
    c:lower()
  end, { description = 'focus next window right', group = 'client' }),
  awful.key({ modkey }, 'Left', function(c)
    awful.client.focus.global_bydirection 'left'
    c:lower()
  end, { description = 'focus next window left', group = 'client' }),

  -- Moving windows between positions works between desktops
  awful.key({ modkey, 'Shift' }, 'Left', function(c)
    awful.client.swap.global_bydirection 'left'
    c:raise()
  end, { description = 'swap with left client', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'Right', function(c)
    awful.client.swap.global_bydirection 'right'
    c:raise()
  end, { description = 'swap with right client', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'Down', function(c)
    awful.client.swap.global_bydirection 'down'
    c:raise()
  end, { description = 'swap with down client', group = 'client' }),
  awful.key({ modkey, 'Shift' }, 'Up', function(c)
    awful.client.swap.global_bydirection 'up'
    c:raise()
  end, { description = 'swap with up client', group = 'client' })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, '#' .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = 'view tag #' .. i, group = 'tag' }),
    -- Toggle tag display.
    awful.key({ modkey, 'Control' }, '#' .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = 'toggle tag #' .. i, group = 'tag' }),
    -- Move client to tag.
    awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = 'move focused client to tag #' .. i, group = 'tag' }),
    -- Toggle tag on focused client.
    awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = 'toggle focused client on tag #' .. i, group = 'tag' })
  )
end

-- Control floating windows with mouse
local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      title = {
        'logout_rs',
      },
    },
    properties = { floating = true },
  },

  -- Remove titlebars to normal clients and dialogs
  { rule_any = { type = { 'normal', 'dialog' } }, properties = { titlebars_enabled = false } },

  { rule = { class = 'Thunderbird' }, properties = { screen = 1, tag = '8' } },
  { rule = { class = 'discord' }, properties = { screen = 1, tag = '9' } },
  { rule = { class = 'mpv' }, properties = { screen = 1, fullscreen = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears
client.connect_signal('manage', function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes
    awful.placement.no_offscreen(c)
  end
end)

-- Functions

-- Add a titlebar if titlebars_enabled is set to true in the rules
client.connect_signal('request::titlebars', function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal('request::activate', 'titlebar', { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal('request::activate', 'titlebar', { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        align = 'center',
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    layout = wibox.layout.align.horizontal,
  }
end)

-- Set focus to follow mouse
client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

client.connect_signal('focus', function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}
