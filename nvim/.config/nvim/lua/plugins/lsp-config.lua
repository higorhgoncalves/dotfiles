return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "intelephense",
          "ts_ls",
          "html",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local configs = require 'lspconfig.configs'

      if not configs.intelephense then
      configs.intelephense = {
        default_config = {
          cmd = { 'intelephense', '--stdio' };
          filetypes = { 'php' };
          root_dir = function()
            return vim.loop.cwd()
          end;
          settings = {
            intelephense = {
              files = {
                maxSize = 1000000;
              };
            }
          }
        }
      }
    end
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.intelephense.setup({
        on_attach = function(client, bufnr)
          -- Enable (omnifunc) completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
          vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
          -- Here we should add additional keymaps and configuration options.
        end,
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
