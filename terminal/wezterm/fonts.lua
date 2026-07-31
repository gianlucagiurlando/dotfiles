-- ============ FONTS ============

local wezterm = require("wezterm")

local M = {}

M.config = {
	font = wezterm.font("MonoLisa Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("PragmataPro Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("OperatorMono Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("BerkeleyMono Nerd Font", { weight = "Regular" }),
	font_size = 19,
	--cursor's shape
	default_cursor_style = "SteadyBar",
}

return M

