-- [yue]: ./native/init.yue
local _module_0 = { } -- 1
local awful = require("awful") -- 1
local gears = require("gears") -- 2
local wibox = require("wibox") -- 3
local beautiful = require("beautiful") -- 4
local native = require("native.native") -- 6
local Gdk, cairo -- 8
do -- 8
	local _obj_0 = require("lgi") -- 8
	Gdk, cairo = _obj_0.Gdk, _obj_0.cairo -- 8
end -- 8
local assert_param_type -- 10
assert_param_type = function(func_name, position, wanted_type, value) -- 10
	local value_type = type(value) -- 11
	return assert((value_type == wanted_type), ("Wrong type of parameter #%d passed to '%s' (expected %s, got %s)"):format(position, func_name, wanted_type, value_type)) -- 13
end -- 10
local fill_context_with_surface -- 15
fill_context_with_surface = function(cr, surface) -- 15
	local original_source = cr:get_target() -- 16
	cr:set_source_surface(surface, 0, 0) -- 18
	cr:paint() -- 19
	return cr:set_source(original_source) -- 21
end -- 15
_module_0["fill_context_with_surface"] = fill_context_with_surface -- 21
local gen_property -- 23
gen_property = function(object, property) -- 23
	assert_param_type("gen_property", 1, "table", object) -- 24
	assert_param_type("gen_property", 2, "string", property) -- 25
	object["get_" .. tostring(property)] = function(self) -- 27
		return self._private[property] -- 28
	end -- 27
	object["set_" .. tostring(property)] = function(self, value) -- 30
		self._private[property] = value -- 31
		self:emit_signal("property::" .. tostring(property), value) -- 32
		self._private.force_redraw = true -- 33
		return self:emit_signal("widget::redraw_needed") -- 34
	end -- 30
end -- 23
_module_0["gen_property"] = gen_property -- 34
local copy -- 36
copy = function(tb) -- 36
	local copy_of_tb = (function() -- 37
		local _tbl_0 = { } -- 37
		for k, v in pairs(tb) do -- 37
			_tbl_0[k] = v -- 37
		end -- 37
		return _tbl_0 -- 37
	end)() -- 37
	setmetatable(copy_of_tb, getmetatable(tb)) -- 39
	return copy_of_tb -- 41
end -- 36
_module_0["copy"] = copy -- 41
local base = setmetatable({ -- 44
	get_widget = function(self) -- 44
		return self._private.widget -- 45
	end, -- 44
	set_widget = function(self, widget) -- 47
		if self._private.child_redraw_listener == nil then -- 48
			self._private.child_redraw_listener = function() -- 49
				self._private.force_redraw = true -- 50
				return self:emit_signal("widget::redraw_needed") -- 51
			end -- 49
		end -- 48
		local child_redraw_listener = self._private.child_redraw_listener -- 53
		if (self._private.widget ~= nil) then -- 55
			self._private.widget:disconnect_signal("widget::redraw_needed", child_redraw_listener) -- 56
		end -- 55
		widget:connect_signal("widget::redraw_needed", child_redraw_listener) -- 58
		return wibox.widget.base.set_widget_common(self, widget) -- 60
	end, -- 47
	get_children = function(self) -- 62
		return { -- 63
			self._private.widget -- 63
		} -- 63
	end, -- 62
	set_children = function(self, children) -- 65
		return self:set_widget(children[1]) -- 66
	end, -- 65
	draw = function(self, context, cr, width, height) -- 68
		local child = self:get_widget() -- 69
		if child == nil then -- 71
			return -- 72
		end -- 71
		if (not self._private.force_redraw) and ((self._private.cached_surface ~= nil)) then -- 74
			fill_context_with_surface(cr, self._private.cached_surface) -- 75
			return -- 76
		end -- 74
		local surface = (function() -- 78
			if (self.on_draw ~= nil) then -- 78
				return self:on_draw(cr, width, height, child) -- 79
			else -- 81
				return wibox.widget.draw_to_image_surface(child, width, height) -- 81
			end -- 78
		end)() -- 78
		self._private.force_redraw = false -- 83
		self._private.cached_surface = surface -- 84
		return fill_context_with_surface(cr, surface) -- 86
	end, -- 68
}, { -- 88
	__call = function(cls, kwargs) -- 88
		if kwargs == nil then -- 88
			kwargs = { } -- 88
		end -- 88
		local self = gears.table.crush(wibox.widget.base.make_widget(nil, "surface_filter", { -- 89
			enable_properties = true -- 89
		}), cls) -- 89
		if self._private == nil then -- 92
			self._private = { } -- 92
		end -- 92
		if (cls.parse_kwargs ~= nil) then -- 94
			cls.parse_kwargs(kwargs) -- 95
		end -- 94
		for k, v in pairs(kwargs) do -- 97
			self[k] = v -- 98
		end -- 98
		return self -- 100
	end -- 88
}) -- 43
_module_0["base"] = base -- 101
local blur -- 103
do -- 103
	blur = copy(base) -- 103
	gen_property(blur, "radius") -- 104
	blur.on_draw = function(self, cr, w, h, child) -- 106
		assert(self.radius) -- 107
		local surface = wibox.widget.draw_to_image_surface(child, w, h)._native -- 109
		local surface_processed = cairo.Surface((function() -- 111
			if (self.dual_pass ~= nil) then -- 111
				local half = self.radius / 2 -- 112
				return native.cairo_image_surface_apply_blur(native.cairo_image_surface_apply_blur(surface, math.ceil(half)), math.floor(half)) -- 113
			else -- 117
				return native.cairo_image_surface_apply_blur(surface, self.radius) -- 117
			end -- 111
		end)()) -- 111
		return fill_context_with_surface(cr, surface_processed) -- 120
	end -- 106
	blur.parse_kwargs = function(kwargs) -- 122
		if kwargs.radius == nil then -- 124
			kwargs.radius = 10 -- 124
		end -- 124
		if kwargs.opacity == nil then -- 125
			kwargs.opacity = 1.0 -- 125
		end -- 125
		if kwargs.dual_pass == nil then -- 126
			kwargs.dual_pass = false -- 126
		end -- 126
		return kwargs -- 123
	end -- 122
	blur = blur -- 103
end -- 103
_module_0["blur"] = blur -- 126
return _module_0 -- 126
