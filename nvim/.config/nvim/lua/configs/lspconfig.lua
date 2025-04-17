require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "pyright", "clangd" }
vim.lsp.enable(servers)
