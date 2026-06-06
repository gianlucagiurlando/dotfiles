-- ============ KEYBINDINGS ============

local wezterm = require("wezterm")
local act     = wezterm.action

local M = {}

M.config = {
	-- UK keyboard: ensure # and ~ on the ISO key (between ' and Return) are passed through correctly
	send_composed_key_when_left_alt_is_pressed  = true,
	send_composed_key_when_right_alt_is_pressed = true,

	keys         = {},
	key_tables   = {},
	mouse_bindings = {},
}

return M
