vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<ESC>", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- bringing back half-page scroll
keymap.set("n", "<C-F>", "<C-D>zz<cmd>Beacon<CR>", { desc = "Scroll down half a page" })
keymap.set("n", "<C-B>", "<C-U>zz<cmd>Beacon<CR>", { desc = "Scroll up half a page" })

-- Flash cursor on zz
keymap.set("n", "zz", "zz<cmd>Beacon<CR>")
