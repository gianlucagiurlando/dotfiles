-- ============ COLOR PALETTE ============
-- Single source of truth for terminal colors, shared with p10k later.

local M = {}

M.config = {
	colors = {
		foreground    = "#CBE0F0",
		background    = "#011423",
		cursor_bg     = "#47FF9C",
		cursor_border = "#47FF9C",
		cursor_fg     = "#011423",
		selection_bg  = "#033259",
		selection_fg  = "#CBE0F0",
		ansi = {
			"#214969", -- black
			"#E52E2E", -- red
			"#44FFB1", -- green
			"#FFE073", -- yellow
			"#0FC5ED", -- blue
			"#A277FF", -- magenta
			"#24EAF7", -- cyan
			"#24EAF7", -- white
		},
		brights = {
			"#214969", -- bright black
			"#E52E2E", -- bright red
			"#44FFB1", -- bright green
			"#FFE073", -- bright yellow
			"#A277FF", -- bright blue
			"#a277ff", -- bright magenta
			"#24EAF7", -- bright cyan
			"#24EAF7", -- bright white
		},
	},
}

return M
