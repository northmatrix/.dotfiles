require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "gopls", "rust_analyzer", "texlab" }

vim.lsp.enable(servers)
