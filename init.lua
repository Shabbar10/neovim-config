require("boover.core")
require("boover.lazy")

vim.g.python3_host_prog = "/usr/sbin/python"

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- Open Mason
map("<leader>cm", "<cmd>Mason<CR>", "Open Mason")

-- gd in a new split
map("<leader>sd", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, "Goto definition in a new vertical split")

map("<leader>ss", function ()
  vim.cmd("split")
  vim.lsp.buf.definition()
end, "Goto definition in a new horizontal split")

vim.opt.colorcolumn = "80"

-- Enable autoread
vim.o.autoread = true

-- Reload file when it changes outside of Neovim
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  command = "checktime"
})

-- Notify when file changes
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

vim.o.updatetime = 300
