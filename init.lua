require("boover.core")
require("boover.lazy")

vim.g.python3_host_prog = "/usr/sbin/python"

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- Open Mason
map("<leader>cm", "<cmd>Mason<CR>", "Open Mason")
