local vim = vim

vim.cmd([[
	set number
	set relativenumber
	syntax enable
	set wildmode

	imap jk <Esc>

	nmap <Space> :bn<CR>

	nnoremap p "+p

	nnoremap y "+y
	vnoremap y "+y

	nnoremap d "_d
	nnoremap x "_x

	vnoremap d "_d
	vnoremap x "_x

	nmap <C-n> :Vex <CR>
	nmap <C-p> :e 

	:command Config :e ~/.config/nvim/init.lua

	nmap gd <c-]>

	set hidden

	set tabstop=4
	set shiftwidth=4
	set expandtab

    colorscheme slate

    hi MatchParen cterm=none ctermbg=black ctermfg=white

    set formatoptions-=cro
]])

local function lsp_is_loaded()
    local clients = vim.lsp.get_active_clients()
    return next(clients) ~= nil
end

local function is_whitespace_only()
    local line = vim.api.nvim_get_current_line()
    return line:match("^%s*$") ~= nil
end

local function tab_autocomplete(shift_pressed)
    if is_whitespace_only() then
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
    pattern = 'lua',
    callback = function(ev)
        vim.lsp.start({
            name = 'luals',
            cmd = {'/home/robertb/.local/bin/lua-language-server/bin/lua-language-server'},
            root_dir = vim.fs.dirname(vim.fs.find({'.luarc.json'}, { upward = true })[1]),
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

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*',
    callback = function(ev)
        vim.cmd.lclose()
    end,
})
