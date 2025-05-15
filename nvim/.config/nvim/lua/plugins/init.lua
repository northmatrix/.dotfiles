return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex" },
    config = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
  {
    "KeitaNakamura/tex-conceal.vim",
    ft = { "tex", "latex" },
    config = function()
      vim.opt.conceallevel = 1
      vim.g.tex_conceal = "abdmg"
      vim.cmd("hi Conceal ctermbg=none")
    end,
  },
  {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "flake8" },
                lua = { "luacheck" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        ft = "rust",
        config = function()
            local function setup_dap()
                local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = extension_path .. "lldb/lib/liblldb"
                local this_os = vim.uv.os_uname().sysname

                if this_os:find "Windows" then
                    codelldb_path = extension_path .. "adapter\\codelldb.exe"
                    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
                else
                    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
                end

                local cfg = require "rustaceanvim.config"
                vim.g.rustaceanvim = {
                    dap = {
                        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                    },
                }
            end

            setup_dap()
        end,
    },
    -- {
    --     "mrcjkb/rustaceanvim",
    --     version = "^5", -- Recommended
    --     lazy = false, -- This plugin is already lazy
    --     ft = "rust",
    --     config = function()
    --         local mason_registry = require "mason-registry"
    --         local codelldb = mason_registry.get_package "codelldb"
    --         local extension_path = codelldb:get_install_path() .. "/extension/"
    --         local codelldb_path = extension_path .. "adapter/codelldb"
    --         -- local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    --         -- If you are on Linux, replace the line above with the line below:
    --         local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    --         local cfg = require "rustaceanvim.config"
    --
    --         vim.g.rustaceanvim = {
    --             dap = {
    --                 adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    --             },
    --         }
    --     end,
    -- },
    --
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },

    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap, dapui = require "dap", require "dapui"
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
        end,
    },

    {
        "saecki/crates.nvim",
        ft = { "toml" },
        config = function()
            require("crates").setup {
                completion = {
                    cmp = {
                        enabled = true,
                    },
                },
            }
            require("cmp").setup.buffer {
                sources = { { name = "crates" } },
            }
        end,
    },
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_view_forward_search_on_start = 1
        end,
    },
    {
        "lervag/vimtex",
        ft = { "tex", "latex" },
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_view_forward_search_on_start = 1
            vim.opt.conceallevel = 2
            vim.opt.concealcursor = "nc"
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
    },
    --  WARNING: Intefers with cmp
    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "rust",
                "python",
                "c",
                "asm",
                "nasm",
                "go",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
    },
}
