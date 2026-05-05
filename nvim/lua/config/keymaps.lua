-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>cb", "<cmd>term cmake --build build<cr>", { desc = "C++ build" })
vim.keymap.set("n", "<leader>cr", "<cmd>term ./build/app<cr>", { desc = "C++ run" })
vim.keymap.set("n", "<leader>cx", "<cmd>term cmake --build build && ./build/app<cr>", { desc = "C++ build and run" })
