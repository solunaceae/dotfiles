return {
  {
    "ms-jpq/coq_nvim",
    dependencies = {
      { "ms-jpq/coq.artifacts" }
    },
    config = function()
      vim.cmd([[
        let g:coq_settings = { "auto_start": "shut-up",
                             \ "keymap.jump_to_mark": "null",
                             \ "keymap.pre_select": v:false }
      ]])

      require("coq")

      vim.cmd([[COQnow -s]])
    end
  },

  {
    "williamboman/mason.nvim" ,
    cmd = "Mason",
    keys = { 
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } 
    },
    build = ":MasonUpdate",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "ms-jpq/coq_nvim" },
    },
    -- this is really gross and i'll refactor this at some point
    -- when i have the time to give a fuck
    config = function()
      local coq = require("coq")
      local mason = require("mason")
      local masonlsp = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      mason.setup()
      masonlsp.setup()

      -- Magic mason auto-setup for installed LSPs
      masonlsp.setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
              lspconfig[server_name].setup {
                on_attach = on_attach,
                coq.lsp_ensure_capabilities{}
              }
        end,

        -- gets the lua LS to shut the fuck up about `vim` being undefined
        ['lua_ls'] = function ()
          lspconfig.lua_ls.setup {
            on_attach = on_attach,
            coq.lsp_ensure_capabilities{},
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                }
              }
            }
          }
        end
      }

    end
  },
}
