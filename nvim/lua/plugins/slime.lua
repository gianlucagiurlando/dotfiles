return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_bracketed_paste = 1
    end,
  },
}
