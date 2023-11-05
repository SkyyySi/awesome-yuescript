-- [yue]: ./surface_filter/init.yue
local _module_0 = { } -- 1
local awful = require("awful") -- 29
local gears = require("gears") -- 30
local wibox = require("wibox") -- 31
local beautiful = require("beautiful") -- 32
local surface_filter = require("surface_filter.surface_filter") -- 34
local Gdk, cairo -- 36
do -- 36
	local _obj_0 = require("lgi") -- 36
	Gdk, cairo = _obj_0.Gdk, _obj_0.cairo -- 36
end -- 36
---@generic T1
--- Verify the correctness of a function parameter, or provide a usefull error message if something there is a type missmatch
---@param func_name string string The name of the function the parameter belongs to
---@param position integer The integer position of the parameter
---@param wanted_type `T1` The type that the parameter should have
---@param value T1 The actual parameter itself
local assert_param_type -- 44
assert_param_type = function(func_name, position, wanted_type, value) -- 44
	local value_type = type(value) -- 45
	return assert((value_type == wanted_type), ("Wrong type of parameter #%d passed to '%s' (expected %s, got %s)"):format(position, func_name, wanted_type, value_type)) -- 47
end -- 44
_module_0["assert_param_type"] = assert_param_type -- 47
--- Create a blurred copy of a `cairo.ImageSurface`
---@param input_surface cairo.ImageSurface The surface you wish to create a blurred copy of
---@param radius integer The blur radius; must be positive (higher = more blurry)
---@return cairo.ImageSurface
local cairo_image_surface_create_blurred -- 59
cairo_image_surface_create_blurred = function(input_surface, radius) -- 59
	assert_param_type("cairo_image_surface_create_blurred", 1, "userdata", input_surface) -- 60
	assert_param_type("cairo_image_surface_create_blurred", 2, "number", radius) -- 61
	assert(radius > 0, "You must provide a blur radius greater than 0!") -- 63
	return cairo.Surface(surface_filter.cairo_image_surface_create_blurred(input_surface._native, radius)) -- 65
end -- 59
_module_0["cairo_image_surface_create_blurred"] = cairo_image_surface_create_blurred -- 65
--- Create a shadow copy of a `cairo.ImageSurface`
---@param input_surface cairo.ImageSurface The surface you wish to create a shadow copy of
---@param radius integer The shadow radius; must be positive (higher = more blurry)
---@return cairo.ImageSurface
local cairo_image_surface_create_shadow -- 71
cairo_image_surface_create_shadow = function(input_surface, radius) -- 71
	assert_param_type("cairo_image_surface_create_shadow", 1, "userdata", input_surface) -- 72
	assert_param_type("cairo_image_surface_create_shadow", 2, "number", radius) -- 73
	assert(radius > 0, "You must provide a shadow radius greater than 0!") -- 75
	return cairo.Surface(surface_filter.cairo_image_surface_create_shadow(input_surface._native, radius)) -- 77
end -- 71
_module_0["cairo_image_surface_create_shadow"] = cairo_image_surface_create_shadow -- 77
cairo.ImageSurface.create_blurred = cairo_image_surface_create_blurred -- 79
cairo.ImageSurface.create_shadow = cairo_image_surface_create_shadow -- 80
---@param cr cairo.Context
---@param surface cairo.Surface
local fill_context_with_surface -- 86
fill_context_with_surface = function(cr, surface) -- 86
	local original_source = cr:get_source() -- 87
	cr:set_source_surface(surface, 0, 0) -- 89
	cr:paint() -- 90
	cr:set_source(original_source) -- 92
	return surface -- 94
end -- 86
_module_0["fill_context_with_surface"] = fill_context_with_surface -- 94
---@param object table
---@param property_name string The name of the property
---@return table object
local gen_property -- 99
gen_property = function(object, property_name) -- 99
	assert_param_type("gen_property", 1, "table", object) -- 100
	assert_param_type("gen_property", 2, "string", property_name) -- 101
	object["get_" .. tostring(property_name)] = function(self) -- 103
		return self._private[property_name] -- 104
	end -- 103
	object["set_" .. tostring(property_name)] = function(self, value) -- 106
		self._private[property_name] = value -- 107
		self:emit_signal("property::" .. tostring(property_name), value) -- 108
		self._private.force_redraw = true -- 109
		return self:emit_signal("widget::redraw_needed") -- 110
	end -- 106
	return object -- 112
end -- 99
_module_0["gen_property"] = gen_property -- 112
---@generic T1 : table
---@param tb T1
---@return T1 copy_of_tb
local copy -- 117
copy = function(tb) -- 117
	local copy_of_tb = (function() -- 118
		local _tbl_0 = { } -- 118
		for k, v in pairs(tb) do -- 118
			_tbl_0[k] = v -- 118
		end -- 118
		return _tbl_0 -- 118
	end)() -- 118
	setmetatable(copy_of_tb, getmetatable(tb)) -- 120
	return copy_of_tb -- 122
end -- 117
_module_0["copy"] = copy -- 122
---@class surface_filter.common : wibox.widget:base
---@operator call: surface_filter.common
local surface_filter_common = setmetatable({ -- 127
	get_widget = function(self) -- 127
		return self._private.widget -- 128
	end, -- 127
	set_widget = function(self, widget) -- 130
		local child_redraw_listener = self._private.child_redraw_listener -- 131
		do -- 133
			local old_widget = self._private.widget -- 133
			if old_widget then -- 133
				old_widget:disconnect_signal("widget::redraw_needed", child_redraw_listener) -- 134
				local _list_0 = old_widget.all_children -- 135
				for _index_0 = 1, #_list_0 do -- 135
					local child = _list_0[_index_0] -- 135
					child:disconnect_signal("widget::redraw_needed", child_redraw_listener) -- 136
				end -- 136
			end -- 133
		end -- 133
		widget:connect_signal("widget::redraw_needed", child_redraw_listener) -- 138
		local _list_0 = widget.all_children -- 139
		for _index_0 = 1, #_list_0 do -- 139
			local child = _list_0[_index_0] -- 139
			child:connect_signal("widget::redraw_needed", child_redraw_listener) -- 140
		end -- 140
		return wibox.widget.base.set_widget_common(self, widget) -- 142
	end, -- 130
	get_children = function(self) -- 144
		return { -- 145
			self._private.widget -- 145
		} -- 145
	end, -- 144
	set_children = function(self, children) -- 147
		return self:set_widget(children[1]) -- 148
	end, -- 147
	draw = function(self, context, cr, width, height) -- 150
		local child = self:get_widget() -- 151
		if child == nil then -- 153
			return -- 154
		end -- 153
		if (not self._private.force_redraw) and ((self._private.cached_surface ~= nil)) then -- 156
			fill_context_with_surface(cr, self._private.cached_surface) -- 157
			return -- 158
		end -- 156
		local surface = (function() -- 160
			if (self.on_draw ~= nil) then -- 160
				return self:on_draw(cr, width, height, child) -- 161
			else -- 163
				return wibox.widget.draw_to_image_surface(child, width, height) -- 163
			end -- 160
		end)() -- 160
		self._private.force_redraw = false -- 165
		self._private.cached_surface = surface -- 166
		return fill_context_with_surface(cr, surface) -- 168
	end, -- 150
	__name = "surface_filter.common", -- 170
}, { -- 172
	__call = function(cls, kwargs) -- 172
		if kwargs == nil then -- 172
			kwargs = { } -- 172
		end -- 172
		local self = gears.table.crush(wibox.widget.base.make_widget(nil, cls.__name, { -- 173
			enable_properties = true -- 173
		}), cls) -- 173
		if self._private == nil then -- 176
			self._private = { } -- 176
		end -- 176
		self._private.child_redraw_listener = function() -- 178
			self._private.force_redraw = true -- 179
			return self:emit_signal("widget::redraw_needed") -- 180
		end -- 178
		if (cls.parse_kwargs ~= nil) then -- 182
			cls.parse_kwargs(kwargs) -- 183
		end -- 182
		for k, v in pairs(kwargs) do -- 185
			self[k] = v -- 186
		end -- 186
		return self -- 188
	end -- 172
}) -- 126
_module_0["surface_filter_common"] = surface_filter_common -- 189
---@class surface_filter.blur : surface_filter.common
local blur -- 192
do -- 192
	blur = copy(surface_filter_common) -- 192
	gen_property(blur, "radius") -- 193
	blur.__name = "surface_filter.blur" -- 195
	blur.on_draw = function(self, cr, w, h, child) -- 197
		assert(self.radius) -- 198
		local surface = wibox.widget.draw_to_image_surface(child, w, h) -- 200
		local surface_processed = (function() -- 202
			if (self.dual_pass ~= nil) then -- 202
				local half = self.radius / 2 -- 203
				return cairo_image_surface_create_blurred(cairo_image_surface_create_blurred(surface, math.ceil(half)), math.floor(half)) -- 204
			else -- 208
				return cairo_image_surface_create_blurred(surface, self.radius) -- 208
			end -- 202
		end)() -- 202
		return fill_context_with_surface(cr, surface_processed) -- 210
	end -- 197
	blur.parse_kwargs = function(kwargs) -- 212
		if kwargs.radius == nil then -- 214
			kwargs.radius = 10 -- 214
		end -- 214
		if kwargs.opacity == nil then -- 215
			kwargs.opacity = 1.0 -- 215
		end -- 215
		if kwargs.dual_pass == nil then -- 216
			kwargs.dual_pass = false -- 216
		end -- 216
		return kwargs -- 213
	end -- 212
	blur = blur -- 192
end -- 192
_module_0["blur"] = blur -- 216
---@class surface_filter.shadow : surface_filter.common
local shadow -- 219
do -- 219
	shadow = copy(surface_filter_common) -- 219
	gen_property(shadow, "radius") -- 220
	shadow.__name = "surface_filter.shadow" -- 222
	shadow.on_draw = function(self, cr, w, h, child) -- 224
		assert(self.radius) -- 225
		local surface = wibox.widget.draw_to_image_surface(child, w, h) -- 227
		local surface_processed = (function() -- 229
			if (self.dual_pass ~= nil) then -- 229
				local half = self.radius / 2 -- 230
				return cairo_image_surface_create_shadow(cairo_image_surface_create_shadow(surface, math.ceil(half)), math.floor(half)) -- 231
			else -- 235
				return cairo_image_surface_create_shadow(surface, self.radius) -- 235
			end -- 229
		end)() -- 229
		return fill_context_with_surface(cr, surface_processed) -- 237
	end -- 224
	shadow.parse_kwargs = function(kwargs) -- 239
		if kwargs.radius == nil then -- 241
			kwargs.radius = 10 -- 241
		end -- 241
		if kwargs.opacity == nil then -- 242
			kwargs.opacity = 1.0 -- 242
		end -- 242
		if kwargs.dual_pass == nil then -- 243
			kwargs.dual_pass = false -- 243
		end -- 243
		return kwargs -- 240
	end -- 239
	shadow = shadow -- 219
end -- 219
_module_0["shadow"] = shadow -- 243
return _module_0 -- 243
