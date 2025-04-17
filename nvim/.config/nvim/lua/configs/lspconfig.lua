require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "gopls", "rust_analyzer" }

vim.lsp.enable(servers)
