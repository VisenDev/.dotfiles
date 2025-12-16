local vim = vim

-- Disable bottom bar
vim.opt.laststatus = 0
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true


vim.cmd("let g:slime_target = \"wezterm\"")

-- Enable syntax highlighting
vim.cmd("syntax enable")

--note: :ToHtml command

vim.cmd("nnoremap K yyddpkJ")

-- Use better autocomplete
vim.opt.wildmode = { "list", "longest" }

-- Allow swapping between buffers
vim.opt.hidden = true

-- Fix tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Disable parenthesis matching
--vim.g.loaded_matchparen = 1

-- Better escape
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })

-- Better way to swap buffers
vim.keymap.set("n", "<Tab>", ":buffer ", { noremap = true })
-- vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { noremap = true })
-- vim.keymap.set("n", "<Space>", ":buffer", { noremap = true })

-- Fix copy pasting
vim.keymap.set("n", "p", '"+p', { noremap = true })
vim.keymap.set("n", "y", '"+y', { noremap = true })
vim.keymap.set("v", "y", '"+y', { noremap = true })
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("v", "x", '"_x', { noremap = true })

-- Easier way to open new files
vim.keymap.set("n", "<C-n>", ":Vex<CR>", { noremap = true })
vim.keymap.set("n", "<C-p>", ":e ", { noremap = true })

-- Quick access to config
vim.api.nvim_create_user_command("Config", "e ~/.config/nvim/init.lua", {})

vim.api.nvim_create_user_command("LspStop",  "lua vim.lsp.stop_client(vim.lsp.get_active_clients())", {})

-- Goto definition with LSP
vim.keymap.set("n", "gd", "<C-]>", { noremap = true })

-- Better colorscheme
-- vim.cmd("colorscheme slate")
vim.cmd("colorscheme habamax")

-- Remove unwanted format options
vim.opt.formatoptions:remove("cro")

-- Disable brackets inside parentheses showing an error in C
-----vim.api.nvim_create_autocmd("FileType", {
-----  pattern = "c",
-----  command = "highlight clear Error"
-----})

-- Syntax for *.cake files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*cake",
  command = "set syntax=lisp"
})


vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.blok",
  command = "set syntax=blok"
})

-- Set tab width for Lisp files
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lisp", "scm","fennel"},
  command = "set tabstop=2 shiftwidth=2"
})

-- Disable parenthesis matching highlight
-- vim.cmd("hi MatchParen cterm=none ctermbg=green ctermfg=blue")

-- Autocmd for custom syntax highlighting
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = "*",
--   command = "syn match parens /[(){}]/ | hi parens ctermfg=red"
-- })

-- Warn on column 80
--if vim.fn.exists("+colorcolumn") == 1 then
--  vim.opt.colorcolumn = "80"
--else
--  vim.api.nvim_create_autocmd("BufWinEnter", {
--    pattern = "*",
--    command = "let w:m2=matchadd('ErrorMsg', '\\%>80v.\\+', -1)"
--  })
--end

vim.api.nvim_set_keymap('n', '<Space>', ':bn<Cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<S-Space>', ':bp<Cr>', {noremap=true})


--Autocomplete code
local function lsp_is_loaded()
    local clients = vim.lsp.get_active_clients()
    return next(clients) ~= nil
end

local function is_whitespace_only()
    local line = vim.api.nvim_get_current_line()
    return line:match("^%s*$") ~= nil
end

local function is_whitespace_before_cursor()
    local col = vim.fn.col('.') - 1
    local line = vim.api.nvim_get_current_line()
    local before_cursor = line:sub(1, col)
    return before_cursor:match("^%s*$") ~= nil
end

local function tab_autocomplete(shift_pressed)
    if is_whitespace_before_cursor() then
        return '\t'
    end

    if not lsp_is_loaded() or vim.fn.pumvisible() == 1 then
        if shift_pressed then
            return "<C-p>"
        else
            return "<C-n>"
        end
    else
        return "<C-x><C-o>"
    end
end

function Tab()
    return vim.api.nvim_replace_termcodes(tab_autocomplete(false), true, true, true)
end

function ShiftTab()
    return vim.api.nvim_replace_termcodes(tab_autocomplete(true), true, true, true)
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.Tab()', {expr=true, noremap=true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.ShiftTab()', {expr=true, noremap=true})

--Lsp integration
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'zig',
    callback = function(ev)
        vim.lsp.start({
            name = 'zls',
            cmd = {'zls'},
            root_dir = vim.fs.dirname(vim.fs.find({'build.zig'}, { upward = true })[1]),
        })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c',
    callback = function(ev)
        vim.lsp.start({
            name = 'clangd',
            cmd = {'clangd'},
            --root_dir = vim.fs.dirname(vim.fs.find({'build.zig'}, { upward = true })[1]),
        })
    end,
})



--require'lspconfig'.lua_ls.setup{}

--vim.api.nvim_create_autocmd('FileType', {
--    pattern = 'lua',
--    callback = function(ev)
--        --show_floating_notification("lua ls started")
--        vim.lsp.start({
--            name = 'luals',
--            cmd = {'lua-language-server'},
--            --root_dir = vim.fs.dirname(vim.fs.find({'.luarc.json'}, { upward = true })[1]),
--        })
--    end,
--})


--vim.api.nvim_create_autocmd('BufReadPost', {
--    pattern = '*.lua',
--    callback = function(ev)
--        vim.cmd[[set filetype]]
--        vim.cmd[[LspStart]]
--    end,
--})


vim.api.nvim_create_autocmd('BufRead', {
    pattern = '*.lua',
    callback = function(ev)
        vim.lsp.start({
            name = 'luals',
            cmd = {'lua-language-server'},
        })
    end,
})


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    callback = function(ev)
        vim.lsp.start({
            name = 'luals',
            cmd = {'lua-language-server'},
        })
    end,
})

vim.api.nvim_create_autocmd('BufRead', {
    pattern = '*.fs',
    callback = function(ev)
        vim.cmd[[set filetype=glsl]]
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'glsl',
    callback = function(ev)
        vim.cmd[[set syntax=c]]
    end,
})


vim.api.nvim_create_autocmd('FileType', {
    pattern = '*.scm',
    callback = function(ev)
        vim.lsp.start({
            name = 'gambit-lsp-server',
            cmd = {'gambit-lsp-server'},
        })
    end,
})



vim.api.nvim_create_autocmd('BufRead', {
    pattern = '*.blok',
    command = 'set syntax=blok'
})

-- Fix red highlighting of brackets in C
vim.cmd("highlight clear cErrInParen");
vim.cmd("highlight cErrInParen cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE");
vim.cmd("highlight clear cParenError");
vim.cmd("highlight cParenError cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE");

