vim.g.mapleader = ','
vim.keymap.set({ 'n' }, '<Leader>ev', ':50vsplit $MYVIMRC<CR>')
vim.keymap.set({ 'n' }, '<Leader>sv', ':source $MYVIMRC<CR>')

vim.o.backupdir = vim.fn.stdpath("state") .. "/backup,."
vim.o.directory = vim.fn.stdpath("state") .. "/swap,."

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.wrap = true
vim.o.linebreak = true

vim.cmd('syntax enable')

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.keymap.set({ 'n' }, '<Leader><Leader>', ':nohlsearch<CR>')

vim.o.number = true
vim.o.relativenumber = true
vim.o.textwidth = 0
vim.o.colorcolumn = '+1'

vim.o.laststatus = 2
vim.o.visualbell = true

vim.o.endofline = false
vim.o.fixendofline = false

vim.o.cursorline = true
vim.o.scrolloff = 10

vim.o.list = false
vim.o.listchars = 'eol:$,tab:>-'
vim.keymap.set({ 'n' }, '<Leader>.', ':set list!<CR>')

-- vim.o.regexpengine = 0

-- Status line
-- %-0{minwid}.{maxwid}{item}
vim.o.statusline = '%<%f %h%w%q%m%r%=%-15.([%l:%c/%L][%p%%]%)%y'
vim.o.showcmd = true

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})


-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- Buffer navigation
vim.keymap.set({ 'n' }, '<Leader>]', ':bnext<CR>')
vim.keymap.set({ 'n' }, '<Leader>[', ':bprevious<CR>')

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`


-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

---- Uncomment if not using nix home-manager:
---- local package_hooks = function(event)
----   local name, kind = event.data.spec.name, event.data.kind
----
----   if name == 'telescope-fzf-native' and (kind == 'install' or kind == 'update') then
----     vim.system({ 'make' }, { cwd = event.data.path })
----   end
---- end
----
---- vim.api.nvim_create_autocmd('PackChanged', { callback = package_hooks })
----
---- vim.pack.add({
----   { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
----   { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
----   { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native" },
----   { src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope" },
----   { src = "https://github.com/neovim/nvim-lspconfig" },
----   { src = "https://codeberg.org/mfussenegger/nvim-jdtls", name = "nvim-jdtls" }
---- })

local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    path_display = { "smart" }
  },
  pickers = {
    find_files = {
      theme = "dropdown"
    }
  }
})

telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })


-- Color Scheme
vim.cmd.colorscheme "catppuccin-nvim"

vim.o.autocomplete = true
vim.diagnostic.enable()
vim.diagnostic.config({ underline = true, signs = true, float = true })
vim.o.winborder = "single"
vim.o.pumborder = "single"

vim.keymap.set('n', '<leader>di', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', '<leader>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end
  end
})