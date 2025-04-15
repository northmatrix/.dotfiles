-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pyright", "clangd", "rust_analyzer" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }
end

lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
--spconfig.asm_lsp.setup {}

lspconfig.asm_lsp.setup {
    cmd = { "asm-lsp", "--stdio" }, -- Ensure correct command
    filetypes = { "asm", "s", "S" }, -- Supported filetype for assembly files
    root_dir = lspconfig.util.find_git_ancestor, -- Detect project root
    settings = {
        asm = {
            -- Add any custom settings for asm-lsp here
            -- For example, to set a specific architecture or format:
            architecture = "x86_64", -- Example, replace if needed
            assembler = "nasm",
        },
    },
}

-- Add clangd configuration
-- lspconfig.clangd.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   --cmd = {
--  "clangd",
--   "--target=i686-elf",
--   "--gcc-toolchain=/usr/bin/i686-elf-gcc",
--},
-- filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp"},
-- cmd = {
--   "clangd",
--   "--target=i686-elf",  -- Set the target architecture for cross-compiling
--   "--gcc-toolchain=/usr/bin/i686-elf-gcc",
--   "--header-search-path=/home/jamie/osdev/meaty-skeleton/kernel/include",  -- Kernel headers
--   "--header-search-path=/home/jamie/osdev/meaty-skeleton/libc/include",    -- libc headers
--   "--sysroot=/home/jamie/osdev/meaty-skeleton/sysroot",  -- Sysroot for the cross-compilation environment
--   "--clang-tidy",  -- Enable clang-tidy checks (optional)
--   "--completion-style=detailed",  -- Use detailed completion results
-- },  -- Adjust path if needed
-- filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto", "h", "hpp"},
--}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
