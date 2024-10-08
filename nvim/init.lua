local vim = vim

vim.cmd([[
    "line numbers
	set number
	set relativenumber

    "use syntax
	syntax enable

    "use better autocomplete
	set wildmode

    "allow swapping between buffers
	set hidden

    "fix tabs
	set tabstop=4
	set shiftwidth=4
	set expandtab

    "disable parenthesis matching
    let g:loaded_matchparen=1

    "better escape
    imap jk <Esc>

    "better way to swap buffers
    nmap <Tab> :buffer 
    "nmap <S-Tab> :bp<Cr>
    "nmap <Space> :buffer

    "fix copy pasting
    nnoremap p "+p

    nnoremap y "+y
    vnoremap y "+y

    nnoremap d "_d
    nnoremap x "_x

    vnoremap d "_d
    vnoremap x "_x

    "easier way to open new files
    nmap <C-n> :Vex <CR>
    nmap <C-p> :e 

    "quick access to config
    :command Config :e ~/.config/nvim/init.lua

    "goto definition with lsp
    nmap gd <c-]>

    "beter colorscheme
    colorscheme slate

    set formatoptions-=cro
]])

local function show_floating_notification(message)
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
  local width = 30 
  local height = 1
  
  -- Set the buffer contents
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { message })
  
  -- Define floating window options
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = 1,--(vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    anchor = 'NW',
    border = 'rounded',
    style = 'minimal',
  }

  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Auto-close the floating window after 3 seconds
  vim.defer_fn(function()
    -- Check if the window is still open before attempting to close it
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 350)
end

--Quick buffer swap
--vim.api.nvim_create_autocmd('BufWinEnter', {
--    pattern = '',
--    callback = function()
--        local buf = vim.api.nvim_get_current_buf()  -- Get the current buffer ID
--        local buf_name = vim.api.nvim_buf_get_name(buf)  -- Get the buffer name
--        show_floating_notification(buf_name)
--    end,
--})

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

--vim.api.nvim_create_autocmd('BufWritePost', {
    --    pattern = '*',
    --    callback = function(ev)
        --        vim.cmd.lclose()
        --    end,
        --})
