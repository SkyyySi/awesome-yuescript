--------------------------------------------------------------------------------
--- Create context menus, optionally with sub-menus.
--
-- @author Damien Leone &lt;damien.leone@gmail.com&gt;
-- @author Julien Danjou &lt;julien@danjou.info&gt;
-- @author dodo
-- @copyright 2008, 2011 Damien Leone, Julien Danjou, dodo
-- @popupmod awful.menu
--------------------------------------------------------------------------------

local setmetatable = setmetatable
local tonumber     = tonumber
local string       = string
local ipairs       = ipairs
local pairs        = pairs
local print        = print
local table        = table
local type         = type
local math         = math
local require      = require

local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi

local awful_spawn      = require("awful.spawn")
local awful_screen     = require("awful.screen")
local awful_keygrabber = require("awful.keygrabber")
local awful_button     = require("awful.button")
local awful_tag        = require("awful.tag")
local awful_client     = require("awful.client")

local lgi   = require("lgi")
local cairo = lgi.cairo

local screen = screen
local mouse  = mouse
local client = client

local awful_menu = {
	mt = {}
}
awful_menu.mt.__index = awful_menu.mt
setmetatable(awful_menu, awful_menu.mt)

--- The icon used for sub-menus.
-- @beautiful beautiful.menu_submenu_icon
-- @tparam string|gears.surface menu_submenu_icon

--- The menu text font.
-- @beautiful beautiful.menu_font
-- @param string
-- @see string

--- The item height.
-- @beautiful beautiful.menu_height
-- @tparam[opt=16] number menu_height

--- The default menu width.
-- @beautiful beautiful.menu_width
-- @tparam[opt=100] number menu_width

--- The menu item border color.
-- @beautiful beautiful.menu_border_color
-- @tparam[opt=0] number menu_border_color

--- The menu item border width.
-- @beautiful beautiful.menu_border_width
-- @tparam[opt=0] number menu_border_width

--- The default focused item foreground (text) color.
-- @beautiful beautiful.menu_fg_focus
-- @param color
-- @see gears.color

--- The default focused item background color.
-- @beautiful beautiful.menu_bg_focus
-- @param color
-- @see gears.color

--- The default foreground (text) color.
-- @beautiful beautiful.menu_fg_normal
-- @param color
-- @see gears.color

--- The default background color.
-- @beautiful beautiful.menu_bg_normal
-- @param color
-- @see gears.color

--- The default sub-menu indicator if no `menu_submenu_icon` is provided.
-- @beautiful beautiful.menu_submenu
-- @tparam[opt="▶"] string menu_submenu The sub-menu text.
-- @see beautiful.menu_submenu_icon

--- Key bindings for menu navigation.
-- Keys are: up, down, exec, enter, back, close. Value are table with a list of valid
-- keys for the action, i.e. menu_keys.up =  { "j", "k" } will bind 'j' and 'k'
-- key to up action. This is common to all created menu.
-- @class table
-- @name menu_keys
awful_menu.menu_keys = {
	up    = { "Up",    "k" },
	down  = { "Down",  "j" },
	back  = { "Left",  "h" },
	exec  = { "Return"     },
	enter = { "Right", "l" },
	close = { "Escape"     },
}


local function load_theme(a, b)
	a = a or {}
	b = b or {}

	local theme = {}
	local fallback = beautiful.get()

	if a.reset then
		b = fallback
	end

	if a == "reset" then
		a = fallback
	end

	theme.border       = a.border_color or b.menu_border_color or b.border_color_normal or fallback.menu_border_color or fallback.border_color_normal
	theme.border_width = a.border_width or b.menu_border_width or b.border_width        or fallback.menu_border_width or fallback.border_width or dpi(0)
	theme.fg_focus     = a.fg_focus     or b.menu_fg_focus     or b.fg_focus            or fallback.menu_fg_focus     or fallback.fg_focus
	theme.bg_focus     = a.bg_focus     or b.menu_bg_focus     or b.bg_focus            or fallback.menu_bg_focus     or fallback.bg_focus
	theme.fg_normal    = a.fg_normal    or b.menu_fg_normal    or b.fg_normal           or fallback.menu_fg_normal    or fallback.fg_normal
	theme.bg_normal    = a.bg_normal    or b.menu_bg_normal    or b.bg_normal           or fallback.menu_bg_normal    or fallback.bg_normal
	theme.submenu_icon = a.submenu_icon or b.menu_submenu_icon or b.submenu_icon        or fallback.menu_submenu_icon or fallback.submenu_icon
	theme.submenu      = a.submenu      or b.menu_submenu      or b.submenu             or fallback.menu_submenu      or fallback.submenu or "▶"
	theme.height       = a.height       or b.menu_height       or b.height              or fallback.menu_height       or dpi(16)
	theme.width        = a.width        or b.menu_width        or b.width               or fallback.menu_width        or dpi(100)
	theme.font         = a.font         or b.font              or fallback.menu_font    or fallback.font

	for _, property in ipairs({"width", "height", "menu_width"}) do
		if type(theme[property]) ~= "number" then
			theme[property] = tonumber(theme[property])
		end
	end

	return theme
end


local function item_position(self, child)
	local main_orientation, cross_orientation = "height", "width"
	local direction = self.layout.dir or "y"

	if direction == "x" then
		main_orientation, cross_orientation = cross_orientation, main_orientation
	end

	local in_dir, other = 0, self[cross_orientation]
	local num = gears.table.hasitem(self.child, child)

	if num then
		for i = 0, num - 1 do
			local item = self.items[i]

			if item then
				other = math.max(other, item[cross_orientation])
				in_dir = in_dir + item[main_orientation]
			end
		end
	end

	local w, h = other, in_dir

	if direction == "x" then
		w, h = h, w
	end

	return w, h
end


local function set_coords(self, s, m_coords)
	local s_geometry = s.workarea
	local screen_w = s_geometry.x + s_geometry.width
	local screen_h = s_geometry.y + s_geometry.height

	self.width  = self.wibox.width
	self.height = self.wibox.height

	self.x = self.wibox.x
	self.y = self.wibox.y

	if self.parent then
		local w, h = item_position(self.parent, self)

		w = w + self.parent.theme.border_width

		self.y = ((self.parent.y + h + self.height) > screen_h) and (screen_h      - self.height) or (self.parent.y + h)
		self.x = ((self.parent.x + w + self.width)  > screen_w) and (self.parent.x - self.width)  or (self.parent.x + w)
	else
		if m_coords == nil then
			m_coords = mouse.coords()
			m_coords.x = m_coords.x + 1
			m_coords.y = m_coords.y + 1
		end

		self.y = m_coords.y < s_geometry.y and s_geometry.y or m_coords.y
		self.x = m_coords.x < s_geometry.x and s_geometry.x or m_coords.x

		self.y = (self.y + self.height > screen_h) and (screen_h - self.height) or self.y
		self.x = (self.x + self.width  > screen_w) and (screen_w - self.width)  or self.x
	end

	self.wibox.x = self.x
	self.wibox.y = self.y
end


local function set_size(self)
	-- TODO: Rename `in_dir` and `other` to something with actual meaning
	local in_dir, other, main_orientation, cross_orientation = 0, 0, "height", "width"
	local direction = self.layout.dir or "y"

	if direction == "x" then
		main_orientation, cross_orientation = cross_orientation, main_orientation
	end

	for _, item in ipairs(self.items) do
		other  = math.max(other, item[cross_orientation])
		in_dir = in_dir + item[main_orientation]
	end

	self[main_orientation], self[cross_orientation] = in_dir, other

	if (in_dir > 0) and (other > 0) then
		self.wibox[main_orientation]  = in_dir
		self.wibox[cross_orientation] = other
		return true
	end

	return false
end


local function check_access_key(self, key)
	for k, item in ipairs(self.items) do
		if item.akey == key then
			self:item_enter(k)
			self:exec(k, { exec = true })
			return
		end
	end

	if self.parent then
		check_access_key(self.parent, key)
	end
end


local function grabber(self, _, key, event)
	if event ~= "press" then
		return
	end

	local sel = self.sel or 0

	if gears.table.hasitem(awful_menu.menu_keys.up, key) then
		local sel_new = sel-1 < 1 and #self.items or sel-1
		self:item_enter(sel_new)
	elseif gears.table.hasitem(awful_menu.menu_keys.down, key) then
		local sel_new = sel+1 > #self.items and 1 or sel+1
		self:item_enter(sel_new)
	elseif sel > 0 and gears.table.hasitem(awful_menu.menu_keys.enter, key) then
		self:exec(sel)
	elseif sel > 0 and gears.table.hasitem(awful_menu.menu_keys.exec, key) then
		self:exec(sel, { exec = true })
	elseif gears.table.hasitem(awful_menu.menu_keys.back, key) then
		self:hide()
	elseif gears.table.hasitem(awful_menu.menu_keys.close, key) then
		awful_menu.get_root(self):hide()
	else
		check_access_key(self, key)
	end
end


function awful_menu:exec(num, args)
	args = args or {}

	local item = self.items[num]

	if not item then
		return
	end

	local cmd = item.cmd

	if type(cmd) == "table" then
		local action = cmd.cmd

		if #cmd == 0 then
			if args.exec and action and type(action) == "function" then
				action()
			end

			return
		end

		if not self.child[num] then
			self.child[num] = awful_menu.new(cmd, self)
		end

		local can_invoke_action = args.exec and
			action and
			type(action) == "function" and
			((not args.mouse) or (args.mouse and (self.auto_expand or ((self.active_child == self.child[num]) and self.active_child.wibox.visible))))

		if can_invoke_action then
			local visible = action(self.child[num], item)

			if not visible then
				awful_menu.get_root(self):hide()

				return
			else
				self.child[num]:update()
			end
		end

		if self.active_child and (self.active_child ~= self.child[num]) then
			self.active_child:hide()
		end

		self.active_child = self.child[num]

		if not self.active_child.wibox.visible then
			self.active_child:show()
		end
	elseif type(cmd) == "string" then
		awful_menu.get_root(self):hide()
		awful_spawn(cmd)
	elseif type(cmd) == "function" then
		local visible, action = cmd(item, self)

		if not visible then
			awful_menu.get_root(self):hide()
		else
			self:update()

			if self.items[num] then
				self:item_enter(num, args)
			end
		end

		if action and type(action) == "function" then
			action()
		end
	end
end

function awful_menu:item_enter(num, args)
	args = args or {}

	local item = self.items[num]

	if num == nil or self.sel == num or not item then
		return
	elseif self.sel then
		self:item_leave(self.sel)
	end

	item._background.fg = item.theme.fg_focus
	item._background.bg = item.theme.bg_focus
	self.sel = num

	if self.auto_expand and args.hover then
		if self.active_child then
			self.active_child:hide()
			self.active_child = nil
		end

		if type(item.cmd) == "table" then
			self:exec(num, args)
		end
	end
end


function awful_menu:item_leave(num)
	local item = self.items[num]

	if item then
		item._background.fg = item.theme.fg_normal
		item._background.bg = item.theme.bg_normal
	end
end


--- Show a menu.
-- @tparam[opt={}] table args The arguments
-- @tparam[opt=mouse.coords] table args.coords The menu position. A table with
--  `x` and `y` as keys and position (in pixels) as values.
-- @noreturn
-- @method show
function awful_menu:show(args)
	args = args or {}
	local coords = args.coords or nil

	local s = screen[awful_screen.focused()]

	if not set_size(self) then
		return
	end

	set_coords(self, s, coords)

	awful_keygrabber.run(self._keygrabber)
	self.wibox.visible = true
end

--- Hide a menu popup.
-- @method hide
-- @noreturn
function awful_menu:hide()
	-- Remove items from screen
	for i = 1, #self.items do
		self:item_leave(i)
	end

	if self.active_child then
		self.active_child:hide()
		self.active_child = nil
	end

	self.sel = nil

	awful_keygrabber.stop(self._keygrabber)

	self.wibox.visible = false
end

--- Toggle menu visibility.
-- @tparam table args The arguments.
-- @tparam[opt=mouse.coords] table args.coords The menu position. A table with
--  `x` and `y` as keys and position (in pixels) as values.
-- @noreturn
-- @method toggle
function awful_menu:toggle(args)
	if self.wibox.visible then
		self:hide()
	else
		self:show(args)
	end
end

--- Update menu content.
-- @method update
-- @noreturn
function awful_menu:update()
	if self.wibox.visible then
		self:show({ coords = { x = self.x, y = self.y } })
	end
end


--- Get the elder parent so for example when you kill
-- it, it will destroy the whole family.
-- @method get_root
-- @treturn awful.menu The root menu.
function awful_menu:get_root()
	return self.parent and awful_menu.get_root(self.parent) or self
end

--- Add a new menu entry.
-- args.* params needed for the menu entry constructor.
-- @tparam table args The item params.
-- @tparam[opt=awful.menu.entry] function args.new The menu entry constructor.
-- @tparam[opt] table args.theme The menu entry theme.
-- @tparam[opt] number index The index where the new entry will inserted.
-- @treturn table|nil The new item.
-- @method add
function awful_menu:add(args, index)
	assert(args, "You need to provide an arguments table to awful.menu:add()")

	local theme = load_theme(args.theme or {}, self.theme)

	args.theme = theme
	args.new = args.new or awful_menu.entry

	local item = gears.protected_call(args.new, self, args)

	if (not item) or (not item.widget) then
		print("Error while checking menu entry: no property widget found.")
		return
	end

	item.parent = self
	item.theme = item.theme or theme
	item.width = item.width or theme.width
	item.height = item.height or theme.height
	wibox.widget.base.check_widget(item.widget)
	item._background = wibox.container.background()
	item._background:set_widget(item.widget)
	item._background:set_fg(item.theme.fg_normal)
	item._background:set_bg(item.theme.bg_normal)

	-- Create bindings
	item._background.buttons = {
		awful_button({}, 3, function() self:hide() end),
		awful_button({}, 1, function()
			local num = gears.table.hasitem(self.items, item)
			self:item_enter(num, { mouse = true })
			self:exec(num, { exec = true, mouse = true })
		end)
	}

	function item._mouse()
		local num = gears.table.hasitem(self.items, item)
		self:item_enter(num, { hover = true, mouse = true })
	end

	item.widget:connect_signal("mouse::enter", item._mouse)

	if index then
		self.layout:reset()

		table.insert(self.items, index, item)

		for _, i in ipairs(self.items) do
			self.layout:add(i._background)
		end
	else
		table.insert(self.items, item)
		self.layout:add(item._background)
	end

	if self.wibox then
		set_size(self)
	end

	return item
end

--- Delete menu entry at given position.
-- @tparam table|number num The index in the table of the menu entry to be deleted; can be also the menu entry itself.
-- @noreturn
-- @method delete
function awful_menu:delete(num)
	if type(num) == "table" then
		num = gears.table.hasitem(self.items, num)
	end

	local item = self.items[num]

	if not item then
		return
	end

	item.widget:disconnect_signal("mouse::enter", item._mouse)
	item.widget:set_visible(false)

	table.remove(self.items, num)

	if self.sel == num then
		self:item_leave(self.sel)
		self.sel = nil
	end

	self.layout:reset()

	for _, i in ipairs(self.items) do
		self.layout:add(i._background)
	end

	if self.child[num] then
		self.child[num]:hide()

		if self.active_child == self.child[num] then
			self.active_child = nil
		end

		table.remove(self.child, num)
	end

	if self.wibox then
		set_size(self)
	end
end

--------------------------------------------------------------------------------

--- Build a popup menu with running clients and show it.
-- @tparam[opt] table args Menu table, see `new()` for more information.
-- @tparam[opt] table item_args Table that will be merged into each item, see
--   `new()` for more information.
-- @tparam[opt] func filter A function taking a client as an argument and
--   returning `true` or `false` to indicate whether the client should be
--   included in the menu.
-- @return The menu.
-- @constructorfct awful.menu.clients
-- @request client activate menu.clients granted When clicking on a clients menu
--  element.
function awful_menu.clients(args, item_args, filter)
	args = args or {}
	args.items = args.items or {}

	local cls_t = {}

	for c in awful_client.iterate(filter or function() return true end) do
		cls_t[#cls_t + 1] = {
			c.name or "",
			function()
				if not c.valid then return end
				if not c:isvisible() then
					awful_tag.viewmore(c:tags(), c.screen)
				end
				c:emit_signal("request::activate", "menu.clients", {raise=true})
			end,
			c.icon,
		}

		if item_args then
			if type(item_args) == "function" then
				gears.table.merge(cls_t[#cls_t], item_args(c))
			else
				gears.table.merge(cls_t[#cls_t], item_args)
			end
		end
	end

	gears.table.merge(args.items, cls_t)

	local m = awful_menu.new(args)

	m:show(args)

	return m
end

local clients_menu

--- Use menu.clients to build and open the client menu if it isn't already open.
-- Close the client menu if it is already open.
-- See `awful.menu.clients` for more information.
-- @tparam[opt] table args Menu table, see `new()` for more information.
-- @tparam[opt] table item_args Table that will be merged into each item, see
--   `new()` for more information.
-- @tparam[opt] func filter A function taking a client as an argument and
--   returning `true` or `false` to indicate whether the client should be
--   included in the menu.
-- @return The menu.
-- @constructorfct awful.menu.client_list
function awful_menu.client_list(args, item_args, filter)
	if clients_menu and clients_menu.wibox.visible then
		clients_menu:hide()
		clients_menu = nil
	else
		clients_menu = awful_menu.clients(args, item_args, filter)
	end

	return clients_menu
end

--------------------------------------------------------------------------------

--- Default awful.menu.entry constructor.
-- @param parent The parent menu (TODO: This is apparently unused)
-- @param args The item params
-- @return table With 'widget', 'cmd', 'akey' and all the properties the user wants to change
-- @constructorfct awful.menu.entry
function awful_menu.entry(parent, args) -- luacheck: no unused args
	args = args or {}
	args.text = args[1] or args.text or ""
	args.cmd  = args[2] or args.cmd
	args.icon = args[3] or args.icon

	local ret = {}

	-- Create the item label widget
	local key = ""

	local label_widget = wibox.widget {
		font   = args.theme.font,
		markup = gears.string.xml_escape(args.text):gsub(
			"&amp;(%w)",
			function(l)
				key = string.lower(l)
				return "<u>" .. l .. "</u>"
			end,
			1
		),
		widget = wibox.widget.textbox,
	}

	--local icon
	local iconbox_widget = wibox.widget {
		image  = args.icon,
		widget = wibox.widget.imagebox,
	}

	local margin = wibox.widget {
		label_widget,
		widget = wibox.container.margin
	}

	if iconbox_widget:set_image(args.icon) then
		margin.left = dpi(2)
	end

	if not iconbox_widget then
		margin.left = args.theme.height + dpi(2)
	end

	local submenu_icon_widget
	if type(args.cmd) == "table" then
		if args.theme.submenu_icon then
			submenu_icon_widget = wibox.widget {
				image  = args.theme.submenu_icon,
				widget = wibox.widget.imagebox,
			}
		else
			submenu_icon_widget = wibox.widget {
				font   = args.theme.font,
				text   = args.theme.submenu,
				widget = wibox.widget.textbox,
			}
		end
	end

	local left_widget = wibox.widget {
		iconbox_widget,
		margin,
		layout = wibox.layout.fixed.horizontal,
	}

	local layout = wibox.widget {
		left_widget,
		nil,
		submenu_icon_widget,
		layout = wibox.layout.align.horizontal,
	}

	return gears.table.crush(ret, {
		label = label_widget,
		sep = submenu_icon_widget,
		icon = iconbox_widget,
		widget = layout,
		cmd = args.cmd,
		akey = key,
	})
end

--------------------------------------------------------------------------------

--- Create a menu popup.
--
-- @tparam table args Table containing the menu information.
-- @tparam[opt=true] boolean args.auto_expand Controls the submenu auto expand behaviour.
-- @tparam table args.items Table containing the displayed items. Each element is a
--   table by default (when element 'new' is awful.menu.entry) containing: item
--   name, triggered action (submenu table or function), item icon (optional).
-- @tparam table args.theme
-- @tparam[opt=beautiful.menu_fg_normal] color args.theme.fg_normal
-- @tparam[opt=beautiful.menu_bg_normal] color args.theme.bg_normal
-- @tparam[opt=beautiful.menu_fg_focus] color args.theme.fg_focus
-- @tparam[opt=beautiful.menu_bg_focus] color args.theme.bg_focus
-- @tparam[opt=beautiful.menu_border_color] color args.theme.border
-- @tparam[opt=beautiful.menu_border_width] integer args.theme.border_width
-- @tparam[opt=beautiful.menu_height] integer args.theme.height
-- @tparam[opt=beautiful.menu_width] integer args.theme.width
-- @tparam[opt=beautiful.menu_font] string args.theme.font
-- @tparam[opt=beautiful.menu_submenu_icon] gears.surface|string args.theme.submenu_icon
-- @tparam[opt=beautiful.menu_submenu] string args.theme.submenu
-- @param parent Specify the parent menu if we want to open a submenu, this value should never be set by the user.
-- @constructorfct awful.menu
-- @usage -- The following function builds and shows a menu of clients that match
-- -- a particular rule.
-- -- Bound to a key, it can be used to select from dozens of terminals open on
-- -- several tags.
-- -- When using @{ruled.client.match_any} instead of @{ruled.client.match},
-- -- a menu of clients with different classes could be build.
--
-- function terminal_menu ()
--   terms = {}
--   for i, c in pairs(client.get()) do
--     if ruled.client.match(c, {class = "URxvt"}) then
--       terms[i] =
--         {c.name,
--          function()
--            c.first_tag:view_only()
--            client.focus = c
--          end,
--          c.icon
--         }
--     end
--   end
--   awful.menu(terms):show()
-- end
function awful_menu.new(args, parent)
	args = args or {}
	args.layout = args.layout or wibox.layout.flex.vertical

	local instance = gears.object { enable_properties = true }
	gears.table.crush(instance, awful_menu)
	gears.table.crush(instance, {
		child = {},
		items = {},
		parent = parent,
		layout = args.layout(),
		theme = load_theme(args.theme or {}, parent and parent.theme),
	})

	if parent then
		instance.auto_expand = parent.auto_expand
	elseif args.auto_expand ~= nil then
		instance.auto_expand = args.auto_expand
	else
		instance.auto_expand = true
	end

	-- Create items
	for _, v in ipairs(args) do  instance:add(v)  end
	if args.items then
		for _, v in pairs(args.items) do  instance:add(v)  end
	end

	instance._keygrabber = function(...)
		grabber(instance, ...)
	end

	instance.wibox = wibox({
		ontop = true,
		fg = instance.theme.fg_normal,
		bg = instance.theme.bg_normal,
		border_color = instance.theme.border,
		border_width = instance.theme.border_width,
		type = "popup_menu" })
	instance.wibox.visible = false
	instance.wibox:set_widget(instance.layout)
	set_size(instance)

	instance.x = instance.wibox.x
	instance.y = instance.wibox.y
	return instance
end

function awful_menu.mt:__call(...)
	return awful_menu.new(...)
end

return awful_menu

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
