-- [yue]: ./init.yue
pcall(require, "luarocks.loader") -- 1
local gears = require("gears") -- 3
local awful = require("awful") -- 4
require("awful.autofocus") -- 5
local wibox = require("wibox") -- 6
local beautiful = require("beautiful") -- 7
local naughty = require("naughty") -- 8
local ruled = require("ruled") -- 9
local menubar = require("menubar") -- 10
local hotkeys_popup = require("awful.hotkeys_popup") -- 11
require("awful.hotkeys_popup.keys") -- 12
local lgi = require("lgi") -- 14
local cairo, GLib, Gio = lgi.cairo, lgi.GLib, lgi.Gio -- 15
local Gtk = lgi.require("Gtk", "3.0") -- 16
local Gdk = lgi.require("Gdk", "3.0") -- 17
local awesome, client, screen = _G.awesome, _G.client, _G.screen -- 19
local modules = require("modules") -- 21
local lookup_icon, scale -- 22
do -- 22
	local _obj_0 = modules.lib.theme -- 22
	lookup_icon, scale = _obj_0.lookup_icon, _obj_0.scale -- 22
end -- 22
naughty.connect_signal("request::display_error", function(message, startup) -- 24
	return naughty.notification({ -- 26
		urgency = "critical", -- 26
		title = "Oops, an error happened during " .. ((function() -- 27
			if startup then -- 27
				return "startup!" -- 27
			else -- 27
				return "runtime!" -- 27
			end -- 27
		end)()), -- 27
		message = message -- 28
	}) -- 29
end) -- 24
-- TODO: Offload this into a separate config.json file, which supports hot reload
local config = { -- 34
	terminal = "konsole", -- 34
	editor = "code-oss", -- 35
	modkey = "Mod4", -- 36
	theme = "dracula" -- 37
} -- 33
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. tostring(config.theme) .. "/theme.lua") -- 40
local edit_config = function() -- 42
	return awful.spawn({ -- 43
		config.editor, -- 43
		gears.filesystem.get_configuration_dir() -- 43
	}) -- 43
end -- 42
menubar.utils.terminal = config.terminal -- 45
local main_menu -- 47
local awesome_menu = (function() -- 49
	local wrap = function(fn) -- 50
		return function() -- 51
			fn() -- 52
			return main_menu:hide() -- 53
		end -- 53
	end -- 50
	return { -- 56
		{ -- 56
			"Hotkeys", -- 56
			wrap(function() -- 56
				return hotkeys_popup.show_help(nil, awful.screen.focused()) -- 56
			end), -- 56
			lookup_icon("input-keyboard-symbolic") -- 56
		}, -- 56
		{ -- 57
			"Manual", -- 57
			wrap(function() -- 57
				return Gio.DesktopAppInfo.launch_default_for_uri("https://awesomewm.org/apidoc") -- 57
			end), -- 57
			lookup_icon("help-info-symbolic") -- 57
		}, -- 57
		{ -- 58
			"Edit config", -- 58
			edit_config, -- 58
			lookup_icon("edit-symbolic") -- 58
		}, -- 58
		{ -- 59
			"Restart", -- 59
			wrap(awesome.restart), -- 59
			lookup_icon("system-restart-symbolic") -- 59
		}, -- 59
		{ -- 60
			"Quit", -- 60
			wrap(awesome.quit), -- 60
			lookup_icon("exit") -- 60
		} -- 60
	} -- 61
end)() -- 49
main_menu = awful.menu({ -- 64
	items = { -- 65
		{ -- 65
			"awesome", -- 65
			awesome_menu, -- 65
			beautiful.awesome_icon -- 65
		}, -- 65
		{ -- 66
			"Terminal", -- 66
			config.terminal, -- 66
			lookup_icon("terminal") -- 66
		}, -- 66
		{ -- 67
			"Browser", -- 67
			(function() -- 67
				return Gio.DesktopAppInfo.launch_default_for_uri("https://") -- 67
			end), -- 67
			lookup_icon("browser") -- 67
		} -- 67
	} -- 64
}) -- 63
local launcher_button = awful.widget.launcher({ -- 72
	image = beautiful.awesome_icon, -- 72
	menu = main_menu -- 73
}) -- 71
tag.connect_signal("request::default_layouts", function() -- 76
	local s = awful.layout.suit -- 77
	return awful.layout.append_default_layouts({ -- 80
		s.tile, -- 80
		s.floating -- 81
	}) -- 98
end) -- 76
screen.connect_signal("request::wallpaper", function(s) -- 101
	return awful.wallpaper({ -- 103
		screen = s, -- 103
		widget = { -- 105
			{ -- 106
				{ -- 107
					image = beautiful.wallpaper, -- 107
					upscale = true, -- 108
					downscale = true, -- 109
					widget = wibox.widget.imagebox -- 110
				}, -- 106
				valign = "center", -- 112
				halign = "center", -- 113
				tiled = false, -- 114
				widget = wibox.container.tile -- 115
			}, -- 105
			bg = beautiful.bg_normal, -- 117
			widget = wibox.container.background -- 118
		} -- 104
	}) -- 120
end) -- 101
local keyboard_layout = awful.widget.keyboardlayout() -- 123
local clock = wibox.widget.textclock() -- 125
screen.connect_signal("request::desktop_decoration", function(s) -- 127
	awful.tag((function() -- 128
		local _accum_0 = { } -- 128
		local _len_0 = 1 -- 128
		for i = 1, 9 do -- 128
			_accum_0[_len_0] = tostring(i) -- 128
			_len_0 = _len_0 + 1 -- 128
		end -- 128
		return _accum_0 -- 128
	end)(), s, awful.layout.layouts[1]) -- 128
	s.prompt_box = awful.widget.prompt() -- 130
	s.layoutbox = awful.widget.layoutbox({ -- 133
		screen = s, -- 133
		buttons = { -- 135
			awful.button({ }, 1, (function() -- 135
				return awful.layout.inc(1) -- 135
			end)), -- 135
			awful.button({ }, 3, (function() -- 136
				return awful.layout.inc(-1) -- 136
			end)), -- 136
			awful.button({ }, 4, (function() -- 137
				return awful.layout.inc(-1) -- 137
			end)), -- 137
			awful.button({ }, 5, (function() -- 138
				return awful.layout.inc(1) -- 138
			end)) -- 138
		} -- 134
	}) -- 132
	s.taglist = awful.widget.taglist({ -- 143
		screen = s, -- 143
		filter = awful.widget.taglist.filter.all, -- 144
		widget_template = { -- 146
			{ -- 147
				{ -- 148
					{ -- 149
						id = "icon_role", -- 149
						widget = wibox.widget.imagebox -- 150
					}, -- 148
					{ -- 153
						id = "index_role", -- 153
						widget = wibox.widget.textbox -- 154
					}, -- 152
					{ -- 157
						id = "text_role", -- 157
						widget = wibox.widget.textbox -- 158
					}, -- 156
					layout = wibox.layout.fixed.horizontal -- 160
				}, -- 147
				left = scale(12), -- 162
				right = scale(12), -- 163
				widget = wibox.container.margin -- 164
			}, -- 146
			id = "background_role", -- 166
			widget = wibox.container.background -- 167
		}, -- 145
		buttons = { -- 170
			awful.button({ }, 1, (function(t) -- 170
				return t:view_only() -- 170
			end)), -- 170
			awful.button({ -- 171
				config.modkey -- 171
			}, 1, (function(t) -- 171
				do -- 171
					local c = client.focus -- 171
					if c then -- 171
						return c:move_to_tag(t) -- 171
					end -- 171
				end -- 171
			end)), -- 171
			awful.button({ }, 3, (function() -- 172
				return awful.tag.viewtoggle() -- 172
			end)), -- 172
			awful.button({ -- 173
				config.modkey -- 173
			}, 3, (function(t) -- 173
				do -- 173
					local c = client.focus -- 173
					if c then -- 173
						return c:toggle_tag(t) -- 173
					end -- 173
				end -- 173
			end)), -- 173
			awful.button({ }, 4, (function(t) -- 174
				return awful.tag.viewprev(t.screen) -- 174
			end)), -- 174
			awful.button({ }, 5, (function(t) -- 175
				return awful.tag.viewnext(t.screen) -- 175
			end)) -- 175
		} -- 169
	}) -- 142
	s.tasklist = awful.widget.tasklist({ -- 180
		screen = s, -- 180
		filter = awful.widget.tasklist.filter.currenttags, -- 181
		buttons = { -- 183
			awful.button({ }, 1, (function(c) -- 183
				return c:activate({ -- 183
					context = "tasklist", -- 183
					action = "toggle_minimization" -- 183
				}) -- 183
			end)), -- 183
			awful.button({ }, 3, (function() -- 184
				return awful.menu.client_list({ -- 184
					theme = { -- 184
						width = 250 -- 184
					} -- 184
				}) -- 184
			end)), -- 184
			awful.button({ }, 4, (function() -- 185
				return awful.client.focus.byidx(-1) -- 185
			end)), -- 185
			awful.button({ }, 5, (function() -- 186
				return awful.client.focus.byidx(1) -- 186
			end)) -- 186
		} -- 182
	}) -- 179
	s.panel = awful.wibar({ -- 191
		position = "top", -- 191
		screen = s, -- 192
		widget = { -- 194
			{ -- 195
				launcher_button, -- 195
				s.taglist, -- 196
				s.prompt_box, -- 197
				layout = wibox.layout.fixed.horizontal -- 198
			}, -- 194
			{ -- 201
				s.tasklist, -- 201
				layout = wibox.layout.fixed.horizontal -- 202
			}, -- 200
			{ -- 205
				keyboard_layout, -- 205
				wibox.widget.systray(), -- 206
				clock, -- 207
				s.layoutbox, -- 208
				layout = wibox.layout.fixed.horizontal -- 209
			}, -- 204
			layout = wibox.layout.align.horizontal -- 211
		} -- 193
	}) -- 190
end) -- 127
do -- 219
	local key, button = awful.key, awful.button -- 220
	awful.mouse.append_global_mousebindings({ -- 223
		button({ }, 3, (function() -- 223
			return main_menu:toggle() -- 223
		end)), -- 223
		button({ }, 4, awful.tag.viewprev), -- 224
		button({ }, 5, awful.tag.viewnext) -- 225
	}) -- 222
	awful.keyboard.append_global_keybindings({ -- 229
		key({ -- 229
			config.modkey -- 229
		}, "s", (function() -- 229
			return hotkeys_popup.show_help() -- 229
		end), { -- 229
			description = "show help", -- 229
			group = "awesome" -- 229
		}), -- 229
		key({ -- 230
			config.modkey -- 230
		}, "w", (function() -- 230
			return main_menu:show() -- 230
		end), { -- 230
			description = "show main menu", -- 230
			group = "awesome" -- 230
		}), -- 230
		key({ -- 231
			config.modkey, -- 231
			"Control" -- 231
		}, "r", (function() -- 231
			return awesome.restart() -- 231
		end), { -- 231
			description = "reload awesome", -- 231
			group = "awesome" -- 231
		}), -- 231
		key({ -- 232
			config.modkey, -- 232
			"Shift" -- 232
		}, "q", (function() -- 232
			return awesome.quit() -- 232
		end), { -- 232
			description = "quit awesome", -- 232
			group = "awesome" -- 232
		}), -- 232
		key({ -- 233
			config.modkey -- 233
		}, "x", (function() -- 233
			return awful.prompt.run({ -- 235
				prompt = "Run Lua code: ", -- 235
				textbox = awful.screen.focused().prompt_box.widget, -- 236
				exe_callback = awful.util.eval, -- 237
				history_path = awful.util.get_cache_dir() .. "/history_eval" -- 238
			}) -- 239
		end), { -- 240
			description = "lua execute prompt", -- 240
			group = "awesome" -- 240
		}), -- 233
		key({ -- 241
			config.modkey -- 241
		}, "Return", (function() -- 241
			return awful.spawn(config.terminal) -- 241
		end), { -- 241
			description = "open a terminal", -- 241
			group = "launcher" -- 241
		}), -- 241
		key({ -- 242
			config.modkey -- 242
		}, "r", (function() -- 242
			return awful.screen.focused().prompt_box:run() -- 242
		end), { -- 242
			description = "run prompt", -- 242
			group = "launcher" -- 242
		}), -- 242
		key({ -- 243
			config.modkey -- 243
		}, "p", (function() -- 243
			return menubar.show() -- 243
		end), { -- 243
			description = "show the menubar", -- 243
			group = "launcher" -- 243
		}) -- 243
	}) -- 228
	awful.keyboard.append_global_keybindings({ -- 247
		key({ -- 247
			config.modkey -- 247
		}, "Left", (function() -- 247
			return awful.tag.viewprev() -- 247
		end), { -- 247
			description = "view previous", -- 247
			group = "tag" -- 247
		}), -- 247
		key({ -- 248
			config.modkey -- 248
		}, "Right", (function() -- 248
			return awful.tag.viewnext() -- 248
		end), { -- 248
			description = "view next", -- 248
			group = "tag" -- 248
		}), -- 248
		key({ -- 249
			config.modkey -- 249
		}, "Escape", (function() -- 249
			return awful.tag.history.restore() -- 249
		end), { -- 249
			description = "go back", -- 249
			group = "tag" -- 249
		}) -- 249
	}) -- 246
	awful.keyboard.append_global_keybindings({ -- 253
		key({ -- 253
			config.modkey -- 253
		}, "j", (function() -- 253
			return awful.client.focus.byidx(1) -- 253
		end), { -- 253
			description = "focus next by index", -- 253
			group = "client" -- 253
		}), -- 253
		key({ -- 254
			config.modkey -- 254
		}, "k", (function() -- 254
			return awful.client.focus.byidx(-1) -- 254
		end), { -- 254
			description = "focus previous by index", -- 254
			group = "client" -- 254
		}), -- 254
		key({ -- 255
			config.modkey -- 255
		}, "Tab", (function() -- 255
			awful.client.focus.history.previous() -- 256
			if client.focus then -- 257
				return client.focus:raise() -- 258
			end -- 257
		end), { -- 259
			description = "go back", -- 259
			group = "client" -- 259
		}), -- 255
		key({ -- 260
			config.modkey, -- 260
			"Control" -- 260
		}, "j", (function() -- 260
			return awful.screen.focus_relative(1) -- 260
		end), { -- 260
			description = "focus the next screen", -- 260
			group = "screen" -- 260
		}), -- 260
		key({ -- 261
			config.modkey, -- 261
			"Control" -- 261
		}, "k", (function() -- 261
			return awful.screen.focus_relative(-1) -- 261
		end), { -- 261
			description = "focus the previous screen", -- 261
			group = "screen" -- 261
		}), -- 261
		key({ -- 262
			config.modkey, -- 262
			"Control" -- 262
		}, "n", (function() -- 262
			do -- 263
				local c = awful.client.restore() -- 263
				if c then -- 263
					return c:activate({ -- 264
						raise = true, -- 264
						context = "key.unminimize" -- 264
					}) -- 264
				end -- 263
			end -- 263
		end), { -- 265
			description = "restore minimized", -- 265
			group = "client" -- 265
		}) -- 262
	}) -- 252
	awful.keyboard.append_global_keybindings({ -- 269
		key({ -- 269
			config.modkey, -- 269
			"Shift" -- 269
		}, "j", (function() -- 269
			return awful.client.swap.byidx(1) -- 269
		end), { -- 269
			description = "swap with next client by index", -- 269
			group = "client" -- 269
		}), -- 269
		key({ -- 270
			config.modkey, -- 270
			"Shift" -- 270
		}, "k", (function() -- 270
			return awful.client.swap.byidx(-1) -- 270
		end), { -- 270
			description = "swap with previous client by index", -- 270
			group = "client" -- 270
		}), -- 270
		key({ -- 271
			config.modkey -- 271
		}, "u", (function() -- 271
			return awful.client.urgent.jumpto() -- 271
		end), { -- 271
			description = "jump to urgent client", -- 271
			group = "client" -- 271
		}), -- 271
		key({ -- 272
			config.modkey -- 272
		}, "l", (function() -- 272
			return awful.tag.incmwfact(0.05) -- 272
		end), { -- 272
			description = "increase master width factor", -- 272
			group = "layout" -- 272
		}), -- 272
		key({ -- 273
			config.modkey -- 273
		}, "h", (function() -- 273
			return awful.tag.incmwfact(-0.05) -- 273
		end), { -- 273
			description = "decrease master width factor", -- 273
			group = "layout" -- 273
		}), -- 273
		key({ -- 274
			config.modkey, -- 274
			"Shift" -- 274
		}, "h", (function() -- 274
			return awful.tag.incnmaster(1, nil, true) -- 274
		end), { -- 274
			description = "increase the number of master clients", -- 274
			group = "layout" -- 274
		}), -- 274
		key({ -- 275
			config.modkey, -- 275
			"Shift" -- 275
		}, "l", (function() -- 275
			return awful.tag.incnmaster(-1, nil, true) -- 275
		end), { -- 275
			description = "decrease the number of master clients", -- 275
			group = "layout" -- 275
		}), -- 275
		key({ -- 276
			config.modkey, -- 276
			"Control" -- 276
		}, "h", (function() -- 276
			return awful.tag.incncol(1, nil, true) -- 276
		end), { -- 276
			description = "increase the number of columns", -- 276
			group = "layout" -- 276
		}), -- 276
		key({ -- 277
			config.modkey, -- 277
			"Control" -- 277
		}, "l", (function() -- 277
			return awful.tag.incncol(-1, nil, true) -- 277
		end), { -- 277
			description = "decrease the number of columns", -- 277
			group = "layout" -- 277
		}), -- 277
		key({ -- 278
			config.modkey -- 278
		}, "space", (function() -- 278
			return awful.layout.inc(1) -- 278
		end), { -- 278
			description = "select next", -- 278
			group = "layout" -- 278
		}), -- 278
		key({ -- 279
			config.modkey, -- 279
			"Shift" -- 279
		}, "space", (function() -- 279
			return awful.layout.inc(-1) -- 279
		end), { -- 279
			description = "select previous", -- 279
			group = "layout" -- 279
		}) -- 279
	}) -- 268
	local numrow_key = function(modifiers, description, on_press) -- 282
		return key({ -- 284
			keygroup = "numrow", -- 284
			group = "tag", -- 285
			modifiers = modifiers, -- 286
			description = description, -- 287
			on_press = on_press -- 288
		}) -- 289
	end -- 282
	awful.keyboard.append_global_keybindings({ -- 292
		numrow_key({ -- 292
			config.modkey -- 292
		}, "only view tag", function(index) -- 292
			local s = awful.screen.focused() -- 293
			do -- 295
				local tag = s.tags[index] -- 295
				if tag then -- 295
					return tag:view_only() -- 296
				end -- 295
			end -- 295
		end), -- 292
		numrow_key({ -- 298
			config.modkey, -- 298
			"Control" -- 298
		}, "toggle tag", function(index) -- 298
			local s = awful.screen.focused() -- 299
			do -- 301
				local tag = screen.tags[index] -- 301
				if tag then -- 301
					return awful.tag.viewtoggle(tag) -- 302
				end -- 301
			end -- 301
		end), -- 298
		numrow_key({ -- 304
			config.modkey, -- 304
			"Shift" -- 304
		}, "move focused client to tag", function(index) -- 304
			if not client.focus then -- 305
				return -- 306
			end -- 305
			do -- 308
				local tag = client.focus.screen.tags[index] -- 308
				if tag then -- 308
					return client.focus:move_to_tag(tag) -- 309
				end -- 308
			end -- 308
		end), -- 304
		numrow_key({ -- 311
			config.modkey, -- 311
			"Control", -- 311
			"Shift" -- 311
		}, "toggle focused client on tag", (function(index) -- 311
			if not client.focus then -- 312
				return -- 313
			end -- 312
			do -- 315
				local tag = client.focus.screen.tags[index] -- 315
				if tag then -- 315
					return client.focus:toggle_tag(tag) -- 316
				end -- 315
			end -- 315
		end)), -- 311
		key({ -- 319
			modifiers = { -- 319
				config.modkey -- 319
			}, -- 319
			keygroup = "numpad", -- 320
			description = "select layout directly", -- 321
			group = "layout", -- 322
			on_press = (function(index) -- 323
				do -- 324
					local t = awful.screen.focused().selected_tag -- 324
					if t then -- 324
						t.layout = t.layouts[index] or t.layout -- 325
					end -- 324
				end -- 324
			end) -- 323
		}) -- 318
	}) -- 291
	client.connect_signal("request::default_mousebindings", function() -- 330
		return awful.mouse.append_client_mousebindings({ -- 332
			awful.button({ }, 1, (function(c) -- 332
				return c:activate({ -- 332
					context = "mouse_click" -- 332
				}) -- 332
			end)), -- 332
			awful.button({ -- 333
				config.modkey -- 333
			}, 1, (function(c) -- 333
				return c:activate({ -- 333
					context = "mouse_click", -- 333
					action = "mouse_move" -- 333
				}) -- 333
			end)), -- 333
			awful.button({ -- 334
				config.modkey -- 334
			}, 3, (function(c) -- 334
				return c:activate({ -- 334
					context = "mouse_click", -- 334
					action = "mouse_resize" -- 334
				}) -- 334
			end)) -- 334
		}) -- 335
	end) -- 330
	client.connect_signal("request::default_keybindings", function() -- 338
		return awful.keyboard.append_client_keybindings({ -- 340
			key({ -- 340
				config.modkey -- 340
			}, "f", (function(c) -- 340
				c.fullscreen = not c.fullscreen -- 341
				return c:raise() -- 342
			end), { -- 343
				description = "toggle fullscreen", -- 343
				group = "client" -- 343
			}), -- 340
			key({ -- 344
				config.modkey, -- 344
				"Shift" -- 344
			}, "c", (function(c) -- 344
				return c:kill() -- 344
			end), { -- 344
				description = "close", -- 344
				group = "client" -- 344
			}), -- 344
			key({ -- 345
				config.modkey, -- 345
				"Control" -- 345
			}, "space", awful.client.floating.toggle, { -- 345
				description = "toggle floating", -- 345
				group = "client" -- 345
			}), -- 345
			key({ -- 346
				config.modkey, -- 346
				"Control" -- 346
			}, "Return", (function(c) -- 346
				return c:swap(awful.client.getmaster()) -- 346
			end), { -- 346
				description = "move to master", -- 346
				group = "client" -- 346
			}), -- 346
			key({ -- 347
				config.modkey -- 347
			}, "o", (function(c) -- 347
				return c:move_to_screen() -- 347
			end), { -- 347
				description = "move to screen", -- 347
				group = "client" -- 347
			}), -- 347
			key({ -- 348
				config.modkey -- 348
			}, "t", (function(c) -- 348
				c.ontop = not c.ontop -- 348
			end), { -- 348
				description = "toggle keep on top", -- 348
				group = "client" -- 348
			}), -- 348
			key({ -- 349
				config.modkey -- 349
			}, "n", (function(c) -- 349
				c.minimized = true -- 349
			end), { -- 349
				description = "minimize", -- 349
				group = "client" -- 349
			}), -- 349
			key({ -- 350
				config.modkey -- 350
			}, "m", (function(c) -- 350
				c.maximized = not c.maximized -- 351
				return c:raise() -- 352
			end), { -- 353
				description = "(un)maximize", -- 353
				group = "client" -- 353
			}), -- 350
			key({ -- 354
				config.modkey, -- 354
				"Control" -- 354
			}, "m", (function(c) -- 354
				c.maximized_vertical = not c.maximized_vertical -- 355
				return c:raise() -- 356
			end), { -- 357
				description = "(un)maximize vertically", -- 357
				group = "client" -- 357
			}), -- 354
			key({ -- 358
				config.modkey, -- 358
				"Shift" -- 358
			}, "m", (function(c) -- 358
				c.maximized_horizontal = not c.maximized_horizontal -- 359
				return c:raise() -- 360
			end), { -- 361
				description = "(un)maximize horizontally", -- 361
				group = "client" -- 361
			}) -- 358
		}) -- 362
	end) -- 338
end -- 363
ruled.client.connect_signal("request::rules", function() -- 365
	ruled.client.append_rule({ -- 367
		id = "global", -- 367
		rule = { }, -- 368
		properties = { -- 370
			focus = awful.client.focus.filter, -- 370
			raise = true, -- 371
			screen = awful.screen.preferred, -- 372
			placement = awful.placement.no_overlap + awful.placement.no_offscreen -- 373
		} -- 369
	}) -- 366
	ruled.client.append_rule({ -- 378
		id = "floating", -- 378
		rule_any = { -- 380
			instance = { -- 381
				"copyq", -- 381
				"pinentry" -- 382
			}, -- 380
			class = { -- 385
				"Arandr", -- 385
				"Blueman-manager", -- 386
				"Gpick", -- 387
				"Kruler", -- 388
				"Sxiv", -- 389
				"Tor Browser", -- 390
				"Wpa_gui", -- 391
				"veromix", -- 392
				"xtightvncviewer" -- 393
			}, -- 384
			name = { -- 396
				"Event Tester" -- 396
			}, -- 395
			role = { -- 399
				"AlarmWindow", -- 399
				"ConfigManager", -- 400
				"pop-up" -- 401
			} -- 398
		}, -- 379
		properties = { -- 405
			floating = true -- 405
		} -- 404
	}) -- 377
	return ruled.client.append_rule({ -- 410
		id = "titlebars", -- 410
		rule_any = { -- 412
			type = { -- 413
				"normal", -- 413
				"dialog" -- 414
			} -- 412
		}, -- 411
		properties = { -- 418
			titlebars_enabled = true -- 418
		} -- 417
	}) -- 420
end) -- 365
client.connect_signal("request::titlebars", function(c) -- 423
	if c.requests_no_titlebar then -- 424
		return -- 425
	end -- 424
	-- buttons for the titlebar
	local buttons = { -- 429
		awful.button({ }, 1, function() -- 429
			return c:activate({ -- 429
				context = "titlebar", -- 429
				action = "mouse_move" -- 429
			}) -- 429
		end), -- 429
		awful.button({ }, 3, function() -- 430
			return c:activate({ -- 430
				context = "titlebar", -- 430
				action = "mouse_resize" -- 430
			}) -- 430
		end) -- 430
	} -- 428
	awful.titlebar(c).widget = { -- 434
		{ -- 435
			awful.titlebar.widget.iconwidget(c), -- 435
			buttons = buttons, -- 436
			layout = wibox.layout.fixed.horizontal -- 437
		}, -- 434
		{ -- 440
			{ -- 441
				halign = "center", -- 441
				widget = awful.titlebar.widget.titlewidget(c) -- 442
			}, -- 440
			buttons = buttons, -- 444
			layout = wibox.layout.flex.horizontal -- 445
		}, -- 439
		{ -- 448
			awful.titlebar.widget.floatingbutton(c), -- 448
			awful.titlebar.widget.maximizedbutton(c), -- 449
			awful.titlebar.widget.stickybutton(c), -- 450
			awful.titlebar.widget.ontopbutton(c), -- 451
			awful.titlebar.widget.closebutton(c), -- 452
			layout = wibox.layout.fixed.horizontal() -- 453
		}, -- 447
		layout = wibox.layout.align.horizontal -- 455
	} -- 433
end) -- 423
ruled.notification.connect_signal("request::rules", function() -- 459
	return ruled.notification.append_rule({ -- 461
		rule = { }, -- 461
		properties = { -- 463
			screen = awful.screen.preferred, -- 463
			implicit_timeout = 5 -- 464
		} -- 462
	}) -- 466
end) -- 459
naughty.connect_signal("request::display", function(n) -- 469
	return naughty.layout.box({ -- 470
		notification = n -- 470
	}) -- 470
end) -- 469
return client.connect_signal("mouse::enter", function(c) -- 473
	return c:activate({ -- 474
		context = "mouse_enter", -- 474
		raise = false -- 474
	}) -- 474
end) -- 475
