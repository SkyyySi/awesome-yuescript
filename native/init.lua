-- [yue]: ./native/init.yue
local _module_0 = { } -- 1
local awful = require("awful") -- 51
local gears = require("gears") -- 52
local wibox = require("wibox") -- 53
local beautiful = require("beautiful") -- 54
local native = require("native.native") -- 56
local Gdk, cairo -- 58
do -- 58
	local _obj_0 = require("lgi") -- 58
	Gdk, cairo = _obj_0.Gdk, _obj_0.cairo -- 58
end -- 58
local assert_param_type -- 60
assert_param_type = function(func_name, position, wanted_type, value) -- 60
	local value_type = type(value) -- 61
	return assert((value_type == wanted_type), ("Wrong type of parameter #%d passed to '%s' (expected %s, got %s)"):format(position, func_name, wanted_type, value_type)) -- 63
end -- 60
local fill_context_with_surface -- 65
fill_context_with_surface = function(cr, surface) -- 65
	local original_source = cr:get_target() -- 66
	cr:set_source_surface(surface, 0, 0) -- 68
	cr:paint() -- 69
	return cr:set_source(original_source) -- 71
end -- 65
_module_0["fill_context_with_surface"] = fill_context_with_surface -- 71
local gen_property -- 73
gen_property = function(object, property) -- 73
	assert_param_type("gen_property", 1, "table", object) -- 74
	assert_param_type("gen_property", 2, "string", property) -- 75
	object["get_" .. tostring(property)] = function(self) -- 77
		return self._private[property] -- 78
	end -- 77
	object["set_" .. tostring(property)] = function(self, value) -- 80
		self._private[property] = value -- 81
		self:emit_signal("property::" .. tostring(property), value) -- 82
		self._private.force_redraw = true -- 83
		return self:emit_signal("widget::redraw_needed") -- 84
	end -- 80
end -- 73
_module_0["gen_property"] = gen_property -- 84
local copy -- 86
copy = function(tb) -- 86
	local copy_of_tb = (function() -- 87
		local _tbl_0 = { } -- 87
		for k, v in pairs(tb) do -- 87
			_tbl_0[k] = v -- 87
		end -- 87
		return _tbl_0 -- 87
	end)() -- 87
	setmetatable(copy_of_tb, getmetatable(tb)) -- 89
	return copy_of_tb -- 91
end -- 86
_module_0["copy"] = copy -- 91
local base = setmetatable({ -- 94
	get_widget = function(self) -- 94
		return self._private.widget -- 95
	end, -- 94
	set_widget = function(self, widget) -- 97
		if self._private.child_redraw_listener == nil then -- 98
			self._private.child_redraw_listener = function() -- 99
				self._private.force_redraw = true -- 100
				return self:emit_signal("widget::redraw_needed") -- 101
			end -- 99
		end -- 98
		local child_redraw_listener = self._private.child_redraw_listener -- 103
		if (self._private.widget ~= nil) then -- 105
			self._private.widget:disconnect_signal("widget::redraw_needed", child_redraw_listener) -- 106
		end -- 105
		widget:connect_signal("widget::redraw_needed", child_redraw_listener) -- 108
		return wibox.widget.base.set_widget_common(self, widget) -- 110
	end, -- 97
	get_children = function(self) -- 112
		return { -- 113
			self._private.widget -- 113
		} -- 113
	end, -- 112
	set_children = function(self, children) -- 115
		return self:set_widget(children[1]) -- 116
	end, -- 115
	draw = function(self, context, cr, width, height) -- 118
		local child = self:get_widget() -- 119
		if child == nil then -- 121
			return -- 122
		end -- 121
		if (not self._private.force_redraw) and ((self._private.cached_surface ~= nil)) then -- 124
			fill_context_with_surface(cr, self._private.cached_surface) -- 125
			return -- 126
		end -- 124
		local surface = (function() -- 128
			if (self.on_draw ~= nil) then -- 128
				return self:on_draw(cr, width, height, child) -- 129
			else -- 131
				return wibox.widget.draw_to_image_surface(child, width, height) -- 131
			end -- 128
		end)() -- 128
		self._private.force_redraw = false -- 133
		self._private.cached_surface = surface -- 134
		return fill_context_with_surface(cr, surface) -- 136
	end, -- 118
}, { -- 138
	__call = function(cls, kwargs) -- 138
		if kwargs == nil then -- 138
			kwargs = { } -- 138
		end -- 138
		local self = gears.table.crush(wibox.widget.base.make_widget(nil, "surface_filter", { -- 139
			enable_properties = true -- 139
		}), cls) -- 139
		if self._private == nil then -- 142
			self._private = { } -- 142
		end -- 142
		if (cls.parse_kwargs ~= nil) then -- 144
			cls.parse_kwargs(kwargs) -- 145
		end -- 144
		for k, v in pairs(kwargs) do -- 147
			self[k] = v -- 148
		end -- 148
		return self -- 150
	end -- 138
}) -- 93
_module_0["base"] = base -- 151
local blur -- 153
do -- 153
	blur = copy(base) -- 153
	gen_property(blur, "radius") -- 154
	blur.on_draw = function(self, cr, w, h, child) -- 156
		assert(self.radius) -- 157
		local surface = wibox.widget.draw_to_image_surface(child, w, h)._native -- 159
		local surface_processed = cairo.Surface((function() -- 161
			if (self.dual_pass ~= nil) then -- 161
				local half = self.radius / 2 -- 162
				return native.cairo_image_surface_apply_blur(native.cairo_image_surface_apply_blur(surface, math.ceil(half)), math.floor(half)) -- 163
			else -- 167
				return native.cairo_image_surface_apply_blur(surface, self.radius) -- 167
			end -- 161
		end)()) -- 161
		return fill_context_with_surface(cr, surface_processed) -- 170
	end -- 156
	blur.parse_kwargs = function(kwargs) -- 172
		if kwargs.radius == nil then -- 174
			kwargs.radius = 10 -- 174
		end -- 174
		if kwargs.opacity == nil then -- 175
			kwargs.opacity = 1.0 -- 175
		end -- 175
		if kwargs.dual_pass == nil then -- 176
			kwargs.dual_pass = false -- 176
		end -- 176
		return kwargs -- 173
	end -- 172
	blur = blur -- 153
end -- 153
_module_0["blur"] = blur -- 176
return _module_0 -- 176
