vim.opt.number = true
vim.opt.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

vim.opt.list = true
vim.opt.listchars = {
    space = '·',
    tab = '> '
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
lazy.setup {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").setup {}
            require("nvim-treesitter").install { 'svelte', 'typescript', 'javascript', 'css', 'html' }

             vim.api.nvim_create_autocmd('FileType', {
                            callback = function()
                                local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
                                if lang then
                                    vim.treesitter.start()
                                end
                            end,
                        })
        end,
    }
}
