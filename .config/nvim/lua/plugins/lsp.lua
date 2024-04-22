local keymap = require("keymap")
local util = require("util")

return {
  {
    "ms-jpq/coq_nvim",
    dependencies = {
      { "ms-jpq/coq.artifacts" }
    },
    config = function()
      vim.g.coq_settings = {
        ["auto_start"] = "shut-up",
        ["keymap.jump_to_mark"] = '',
        ["keymap.pre_select"] = false,
      }

      require("coq")

      vim.cmd([[COQnow -s]])
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = keymap.MASON,
    build = ":MasonUpdate",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "ms-jpq/coq_nvim" },
    },
    keys = keymap.LSP_GLOBALS,
    config = function()
      local coq = require("coq")
      local mason = require("mason")
      local masonlsp = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          local keys = keymap.LSP_POST_BUFFER_ATTACH

          for _, keymapping in ipairs(keys) do
            keymapping["opts"] = util.merge_tables(keymapping["opts"], opts)

            keymap.set_generic_keymap(keymapping)
          end
        end,
      })

      mason.setup()
      masonlsp.setup()

      -- Magic mason auto-setup for installed LSPs
      masonlsp.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup {
            coq.lsp_ensure_capabilities {}
          }
        end,

        -- gets the lua LS to shut the fuck up about `vim` being undefined
        ['lua_ls'] = function()
          lspconfig.lua_ls.setup {
            coq.lsp_ensure_capabilities {},
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                }
              }
            }
          }
        end,

      }
    end,
  },
}
