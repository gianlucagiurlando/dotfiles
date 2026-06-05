return {
  -- 1. Install the Dracula plugin
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
  },
  -- 2. Tell LazyVim to set it as the default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}





