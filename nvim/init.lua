--
-- ######################################################
-- #                    VIM OPTIONS                     #
-- ######################################################
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ######################################################
-- #                     KEY BINDINGS                   #
-- ######################################################

vim.g.mapleader = ' '
vim.keymap.set({'n', 'x'}, 'cp', '"+y') -- copy to system clipboard with cp
vim.keymap.set({'n', 'x'}, 'cv', '"+p') -- paste from system clipboard with cv
vim.keymap.set({'n', 'x'}, 'x', '"_x')  -- modify x to not store in register

-- ######################################################
-- #                       PLUGINS                      #
-- ######################################################
local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end


lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  {'EdenEast/nightfox.nvim'},
  {'nvim-lualine/lualine.nvim'},
  {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
})

-- ######################################################
-- #                      APPEARANCE                    #
-- ######################################################
vim.opt.termguicolors = true
vim.cmd.colorscheme('terafox')

-- ######################################################
-- #                 CUSTOM PLUGIN CONFIGS              #
-- ######################################################

-- lualine
require('lualine').setup()

-- treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
