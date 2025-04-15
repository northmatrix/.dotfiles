local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    asm = { "asmfmt"},
    c =   { "clang-format" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "black" }
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
