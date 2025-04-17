require("nvchad.configs.lspconfig").defaults()
local servers = { "html", "cssls", "pyright", "clangd" } -- "rust_analyzer",
vim.lsp.enable(servers)

local lspconfig = require "lspconfig"

lspconfig.rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = "all",
                allFeatures = true,
                buildScripts = { enable = true },
            },
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true },
            diagnostics = {
                enable = true,
                enableExperimental = true,
                disabled = { "unresolved-proc-macro" },
            },
            inlayHints = {
                typeHints = true,
                parameterHints = true,
                chainingHints = true,
            },
            lens = { enable = true },
            completion = {
                addCallArgumentSnippets = true,
                addCallParenthesis = true,
            },
            hover = {
                actions = {
                    references = { enable = true },
                },
            },
        },
    },
}
