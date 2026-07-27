-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keep cursor centered.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })

-- Switch between tmux panes
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move to the left window", remap = true })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move to the bottom window", remap = true })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move to the top window", remap = true })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move to the right window", remap = true })

-- Indent while remaining in visual mode.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- make U opposite of u.
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })
