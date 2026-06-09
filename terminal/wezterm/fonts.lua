-- ============ FONTS ============

local wezterm = require("wezterm")

local M = {}

M.config = {
	font = wezterm.font("MonoLisa Nerd Font", { weight = "Regular" }),
	font_size = 18,
}

return M

--INSTALLED FONTS:
-- RecMonoSmCasual Nerd Font Mono
-- JetBrainsMono Nerd Font
-- CaskaydiaMono Nerd Font
-- Blexmono Nerd Font
-- Hack Nerd Font Mono
-- MesloLGS Nerd Font Mono
-- MonoLisa Nerd Font
--OperatorMono Nerd Font

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