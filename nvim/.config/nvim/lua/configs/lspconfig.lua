require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "rust_analyzer", "gopls" }

vim.lsp.enable(servers)
