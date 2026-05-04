-- =======================================================
-- WezTerm entry point — modular config
--
-- Modules live alongside this file:
--   colors.lua      → color palette (shared source of truth with p10k)
--   fonts.lua       → font family, size, fallbacks
--   keybindings.lua → keys, key_tables, mouse_bindings
--   appearance.lua  → decorations, tab bar, padding, opacity
-- =======================================================

local wezterm = require("wezterm")

-- Resolve the real directory of this config by following the symlink.
-- wezterm.config_file is the symlink (~/.wezterm.lua); readlink -f gives the target.
local handle = io.popen("readlink -f " .. wezterm.config_file)
local real_path = handle:read("*l")
handle:close()
local config_dir = real_path:match("^(.-)[^/]+$")

local colors = dofile(config_dir .. "colors.lua")
local fonts = dofile(config_dir .. "fonts.lua")
local keybindings = dofile(config_dir .. "keybindings.lua")
local appearance = dofile(config_dir .. "appearance.lua")

local config = wezterm.config_builder()

-- Merge each module's config table into the root config.
local function merge(dst, src)
	for k, v in pairs(src) do
		dst[k] = v
	end
end

--merge(config, colors.config)
merge(config, fonts.config)
merge(config, keybindings.config)
merge(config, appearance.config)

return config
