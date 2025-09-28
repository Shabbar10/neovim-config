return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        java = false,
      },
    })

    -- import nvim-autopairs conpletion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- import nvim-cmp plugin
    local cmp = require("cmp")

    -- make both work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
