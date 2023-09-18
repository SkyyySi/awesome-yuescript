-- [yue]: ./themes/dracula/theme.yue
local naughty = require("naughty") -- 1
local try_or_warn = function(fn) -- 3
	local success, theme = xpcall(fn, function(err) -- 5
		return naughty.notification({ -- 8
			timeout = 0, -- 8
			message = "Could not load theme: " .. tostring(err) .. "\nNote: This error will <i>not</i> stop awesome from continuing to load the rest of your configuration." -- 9
		}) -- 10
	end) -- 4
	if success then -- 12
		return theme -- 13
	end -- 12
end -- 3
return try_or_warn(function() -- 15
	local theme_assets = require("beautiful.theme_assets") -- 17
	local rnotification = require("ruled.notification") -- 18
	local dpi = require("beautiful.xresources").apply_dpi -- 19
	local filesystem = require("gears.filesystem") -- 21
	local theme_path = filesystem.get_configuration_dir() .. "themes/dracula/" -- 22
	local t = { } -- 24
	t.font = "sans " .. tostring(math.floor(dpi(12) + 0.5)) -- 26
	t.bg_normal = "#282a36" -- 28
	t.bg_focus = "#44475a" -- 29
	t.bg_urgent = "#ff5555" -- 30
	t.bg_minimize = "#bd93f9" -- 31
	t.fg_normal = "#f8f8f2" -- 33
	t.fg_focus = "#f8f8f2" -- 34
	t.fg_urgent = "#282a36" -- 35
	t.fg_minimize = "#282a36" -- 36
	t.bg_systray = t.bg_normal -- 38
	t.useless_gap = dpi(5) -- 40
	t.border_width = dpi(1) -- 41
	t.border_color_normal = "#44475a" -- 42
	t.border_color_active = "#44475a" -- 43
	t.border_color_marked = "#44475a" -- 44
	local taglist_square_size = dpi(128) -- 54
	t.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, t.fg_normal) -- 55
	t.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, t.fg_normal) -- 56
	-- Variables set for theming the menu:
	-- menu_[bg|fg]_[normal|focus]
	-- menu_[border_color|border_width]
	--t.menu_submenu_icon = theme_path .. "submenu.png"
	t.menu_height = dpi(30) -- 68
	t.menu_width = dpi(200) -- 69
	t.titlebar_close_button_normal = theme_path .. "titlebar/close_normal.png" -- 71
	t.titlebar_close_button_focus = theme_path .. "titlebar/close_focus.png" -- 72
	t.titlebar_minimize_button_normal = theme_path .. "titlebar/minimize_normal.png" -- 74
	t.titlebar_minimize_button_focus = theme_path .. "titlebar/minimize_focus.png" -- 75
	t.titlebar_ontop_button_normal_inactive = theme_path .. "titlebar/ontop_normal_inactive.png" -- 77
	t.titlebar_ontop_button_focus_inactive = theme_path .. "titlebar/ontop_focus_inactive.png" -- 78
	t.titlebar_ontop_button_normal_active = theme_path .. "titlebar/ontop_normal_active.png" -- 79
	t.titlebar_ontop_button_focus_active = theme_path .. "titlebar/ontop_focus_active.png" -- 80
	t.titlebar_sticky_button_normal_inactive = theme_path .. "titlebar/sticky_normal_inactive.png" -- 82
	t.titlebar_sticky_button_focus_inactive = theme_path .. "titlebar/sticky_focus_inactive.png" -- 83
	t.titlebar_sticky_button_normal_active = theme_path .. "titlebar/sticky_normal_active.png" -- 84
	t.titlebar_sticky_button_focus_active = theme_path .. "titlebar/sticky_focus_active.png" -- 85
	t.titlebar_floating_button_normal_inactive = theme_path .. "titlebar/floating_normal_inactive.png" -- 87
	t.titlebar_floating_button_focus_inactive = theme_path .. "titlebar/floating_focus_inactive.png" -- 88
	t.titlebar_floating_button_normal_active = theme_path .. "titlebar/floating_normal_active.png" -- 89
	t.titlebar_floating_button_focus_active = theme_path .. "titlebar/floating_focus_active.png" -- 90
	t.titlebar_maximized_button_normal_inactive = theme_path .. "titlebar/maximized_normal_inactive.png" -- 92
	t.titlebar_maximized_button_focus_inactive = theme_path .. "titlebar/maximized_focus_inactive.png" -- 93
	t.titlebar_maximized_button_normal_active = theme_path .. "titlebar/maximized_normal_active.png" -- 94
	t.titlebar_maximized_button_focus_active = theme_path .. "titlebar/maximized_focus_active.png" -- 95
	t.wallpaper = theme_path .. "background_transparent.png" -- 97
	t.layout_fairh = theme_path .. "layouts/fairhw.png" -- 99
	t.layout_fairv = theme_path .. "layouts/fairvw.png" -- 100
	t.layout_floating = theme_path .. "layouts/floatingw.png" -- 101
	t.layout_magnifier = theme_path .. "layouts/magnifierw.png" -- 102
	t.layout_max = theme_path .. "layouts/maxw.png" -- 103
	t.layout_fullscreen = theme_path .. "layouts/fullscreenw.png" -- 104
	t.layout_tilebottom = theme_path .. "layouts/tilebottomw.png" -- 105
	t.layout_tileleft = theme_path .. "layouts/tileleftw.png" -- 106
	t.layout_tile = theme_path .. "layouts/tilew.png" -- 107
	t.layout_tiletop = theme_path .. "layouts/tiletopw.png" -- 108
	t.layout_spiral = theme_path .. "layouts/spiralw.png" -- 109
	t.layout_dwindle = theme_path .. "layouts/dwindlew.png" -- 110
	t.layout_cornernw = theme_path .. "layouts/cornernww.png" -- 111
	t.layout_cornerne = theme_path .. "layouts/cornernew.png" -- 112
	t.layout_cornersw = theme_path .. "layouts/cornersww.png" -- 113
	t.layout_cornerse = theme_path .. "layouts/cornersew.png" -- 114
	t.awesome_icon = theme_assets.awesome_icon(t.menu_height, t.bg_focus, t.fg_focus) -- 116
	t.icon_theme = "Papirus-dark" -- 118
	rnotification.connect_signal("request::rules", function() -- 120
		return rnotification.append_rule({ -- 122
			rule = { -- 122
				urgency = "critical" -- 122
			}, -- 122
			properties = { -- 123
				bg = t.bg_urgent, -- 123
				fg = t.fg_urgent -- 123
			} -- 123
		}) -- 124
	end) -- 120
	return t -- 127
end) -- 15
