return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    -- "gbprod/none-ls-php.nvim",
  },

  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "html", "css", "javascript", "php" },
        }),
        null_ls.builtins.formatting.phpcsfixer.with({
          extra_args = { "--rules=@PSR12" },
        }),
        require("none-ls.diagnostics.eslint_d"),
        -- require("none-ls-php.diagnostics.php"),
      },
    })

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({
        filter = function(client)
          -- Usa apenas null-ls para formatação
          return client.name == "null-ls"
        end,
        timeout_ms = 2000,
      })
    end, { desc = "Format document" })
  end,
}
