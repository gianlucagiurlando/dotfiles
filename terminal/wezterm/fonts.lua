-- ============ FONTS ============

local wezterm = require("wezterm")

local M = {}

M.config = {
	--font = wezterm.font("MonoLisa Nerd Font", { weight = "Regular" }),
	--font = wezterm.font("OperatorMono Nerd Font", { weight = "Regular" }),
	font = wezterm.font("BerkeleyMono Nerd Font", { weight = "Regular" }),

	font_size = 18,
}

return M


--A LIST OF ALL NERD FONTS INSTALLED ON MY MAC
-- fc-list | grep "Nerd Font" | sed -E 's/.*:([^:]+):.*/\1/' | sort -u



--TO CHECK INSTALLED WEIGHTS OF A FONT
--find ~/Library/Fonts -iname '*Blex*' | sed 's|.*/||' | sort
-- 400 = Regular
-- 500 = Medium
-- 600 = DemiBold
-- 700 = Bold
-- 800 = ExtraBold
-- 900 = Black

-- Thin
-- ExtraLight
-- Light
-- Text
-- Regular
-- Medium
-- SemiBold
-- Bold
-- ExtraBold
-- Black