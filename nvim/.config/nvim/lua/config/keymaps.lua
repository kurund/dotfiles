-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Increment or decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
