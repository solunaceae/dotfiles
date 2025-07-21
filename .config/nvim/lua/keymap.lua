local M = {}

--[[
  Note that the following keymaps use the `keys` syntax from Lazy.nvim,
  meaning that they have an unnamed "opts" parameter.

  Additionally, all these parameters are wrapped within a table. Their
  structure is therefore as follows:
  ```
  M.CONSTANT = {
    { inner table },
  }
  ```

  where the inner table syntax is defined as:
  ```
  { <keys>, <function_to_be_called>, <misc opts> }
  ```
]]

M.TELESCOPE = {
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Open file finder" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Open live grep" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Open buffer search" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Open help tags" },
}

M.NVIM_TREE = {
  { "<C-1>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NVimTree" },
}

M.LSP_GLOBALS = {
  { "<space>e",  vim.diagnostic.open_float, desc = "LSP: Open floating panel" },
  { "[d",        vim.diagnostic.goto_prev,  desc = "LSP: Go to previous diagnostic" },
  { "]d",        vim.diagnostic.goto_next,  desc = "LSP: Go to next diagnostic" },
  { "<leader>q", vim.diagnostic.setloclist, desc = "LSP: Set loc list" },
}

M.MASON = {
  { "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason UI" }
}

--[[
  The following keymaps are meant to be more generic, and therefore have the named
  `opts` parameter instead of omitting it.
]]

local list_workspace_folders = function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local format = function()
  vim.lsp.buf.format { async = true }
end

M.LSP_POST_BUFFER_ATTACH = {
  { "K",          vim.lsp.buf.hover,                   opts = { desc = "LSP: Open hover panel" } },
  { "gD",         vim.lsp.buf.declaration,             opts = { desc = "LSP: Go to declaration" } },
  { "gd",         vim.lsp.buf.declaration,             opts = { desc = "LSP: Go to definition" } },
  { "gr",         vim.lsp.buf.references,              opts = { desc = "LSP: Show references" } },
-- { "<C-k>",      vim.lsp.buf.signature_help,          opts = { desc = "LSP: Open signature help" } },
-- TODO: figure out now keybind for this lmao
  { "<leader>f",  format,                              opts = { desc = "LSP: Format buffer" } },
  { "<leader>D",  vim.lsp.buf.type_definition,         opts = { desc = "LSP: Show type definition" } },
  { "<leader>wa", vim.lsp.buf.add_workspace_folder,    opts = { desc = "LSP: Add workspace folder" } },
  { "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts = { desc = "LSP: Delete workspace fodler" } },
  { "<leader>wl", list_workspace_folders,              opts = { desc = "LSP: List workspace folders" } },
  { "<leader>rn", vim.lsp.buf.rename,                  opts = { desc = "LSP: Rename symbol" } },
  { "<leader>ca", vim.lsp.buf.code_action,             opts = { desc = "LSP: Code action" },            mode = { "n", "v" } },
}

M.LAZY = { "<leader>cl", "<cmd>Lazy<cr>", opts = { desc = "Open Lazy UI", noremap = true } }

local set_leader = function()
  vim.api.nvim_set_keymap(
    "n",
    "<SPACE>",
    "<Nop>",
    { noremap = true }
  )

  vim.g.mapleader = ' '
end

local set_split_controls = function()
  local pane_keys = {
    "H",
    "J",
    "K",
    "L",
  }

  for _, key in ipairs(pane_keys) do
    vim.api.nvim_set_keymap(
      "n",
      "<C-" .. key .. ">",
      "<C-W><C-" .. key .. ">",
      { noremap = true }
    )
  end
end

M.set_generic_keymap = function(mapping)
  vim.keymap.set(
    mapping["mode"] or "n",
    mapping[1],
    mapping[2],
    mapping["opts"]
  )
end


M.init = function()
  set_leader()
  set_split_controls()
  M.set_generic_keymap(M.LAZY)
end

return M
