-- [yue]: ./surface_filter/test.yue
local surface_filter = require("surface_filter.surface_filter") -- 1
local cairo -- 3
do -- 3
	local _obj_0 = require("lgi") -- 3
	cairo = _obj_0.cairo -- 3
end -- 3
cairo.ImageSurface.apply_blur = function(self, radius) -- 5
	return cairo.Surface(native.cairo_image_surface_apply_blur(self._native, radius)) -- 6
end -- 5
cairo.ImageSurface.apply_shadow = function(self, radius) -- 8
	return cairo.Surface(native.cairo_image_surface_apply_shadow(self._native, radius)) -- 9
end -- 8
local input_file = arg[1] or tostring(arg[0]:gsub('/.*$', '') or '.') .. "/test2.png" -- 11
local output_file = tostring(input_file:gsub('%.[^%.]+$', '')) .. "_blurred.png" -- 12
do -- 14
	local file = assert(io.open(output_file, "w")) -- 15
	file:write("") -- 16
	file:close() -- 17
end -- 17
do -- 19
	print("INFO: Applying blur filter to '" .. tostring(input_file) .. "'!") -- 20
	local surface = cairo.ImageSurface.create_from_png(input_file) -- 22
	local surface_processed = surface:apply_blur(10) -- 24
	print("INFO: Writing blurred file to '" .. tostring(output_file) .. "'!") -- 26
	return print(surface_processed:write_to_png(output_file)) -- 27
end -- 27
