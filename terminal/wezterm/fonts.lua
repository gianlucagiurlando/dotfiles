-- ============ FONTS ============

local wezterm = require("wezterm")

local M = {}

M.config = {
	--font = wezterm.font("MonoLisa Nerd Font", { weight = "Regular" }),
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("PragmataPro Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("OperatorMono Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("BerkeleyMono Nerd Font", { weight = "Regular" }),
	-- Per-machine override: export WEZTERM_FONT_SIZE in ~/.zshenv (untracked)
	-- to use a different size on a smaller screen, e.g. export WEZTERM_FONT_SIZE=14
	font_size = tonumber(os.getenv("WEZTERM_FONT_SIZE")) or 18,
	--cursor's shape
	default_cursor_style = "SteadyBar",
}

return M

