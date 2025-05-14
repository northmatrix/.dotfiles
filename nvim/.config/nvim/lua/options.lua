require "nvchad.options"

-- add yours here!

local o = vim.o
o.relativenumber = true
--o.cursorlineopt = "both" -- to enable cursorline!

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_forward_search_on_start = 1
