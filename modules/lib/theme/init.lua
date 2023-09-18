-- [yue]: ./modules/lib/theme/init.yue
local _module_0 = { } -- 1
local lgi = require("lgi") -- 1
local cairo, GLib, Gio = lgi.cairo, lgi.GLib, lgi.Gio -- 2
local Gtk = lgi.require("Gtk", "3.0") -- 3
local Gdk = lgi.require("Gdk", "3.0") -- 4
local lookup_icon -- 6
lookup_icon = function(icon_name) -- 6
	if not icon_name then -- 7
		return -- 8
	end -- 7
	local icon_theme = Gtk.IconTheme.get_default() -- 10
	if not icon_theme then -- 12
		return -- 13
	end -- 12
	local icon = icon_theme:lookup_icon(icon_name, 48, 0) -- 15
	if not icon then -- 17
		return -- 18
	end -- 17
	return icon:get_filename() -- 20
end -- 6
_module_0["lookup_icon"] = lookup_icon -- 20
local lookup_gicon -- 22
lookup_gicon = function(gicon) -- 22
	if not gicon then -- 23
		return -- 24
	end -- 23
	if type(gicon) == "string" then -- 26
		return gicon -- 27
	end -- 26
	local icon_theme = Gtk.IconTheme.get_default() -- 29
	if not icon_theme then -- 31
		return -- 32
	end -- 31
	local icon = icon_theme:lookup_by_gicon(gicon, 48, 0) -- 34
	if not icon then -- 36
		return -- 37
	end -- 36
	return icon:get_filename() -- 39
end -- 22
_module_0["lookup_gicon"] = lookup_gicon -- 39
local dpi = require("beautiful.xresources").apply_dpi(1) -- 41
local scale -- 42
scale = function(value, s) -- 42
	if s == nil then -- 42
		s = screen.primary -- 42
	end -- 42
	local screen_scale = (function() -- 43
		local _exp_0 = s.scaling_factor -- 43
		if _exp_0 ~= nil then -- 43
			return _exp_0 -- 43
		else -- 43
			return 1 -- 43
		end -- 43
	end)() -- 43
	return value * screen_scale * dpi -- 44
end -- 42
_module_0["scale"] = scale -- 44
return _module_0 -- 44
