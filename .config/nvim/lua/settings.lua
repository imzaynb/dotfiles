vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'

-- Add LC2K as a filetype recgnized by Neovim
vim.filetype.add({
	extension = {
		lc2k = "lc2k",
		as = "as",
	},
})

-- Custom settings for certain filetypes.
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"c", "cpp"},
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"lc2k", "as"},
	callback = function()
		vim.opt_local.shiftwidth = 8
		vim.opt_local.tabstop = 8
		vim.opt_local.expandtab = false
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "text",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		vim.opt_local.spell = true
	end
})

vim.opt.rtp:prepend(os.getenv("HOME") .. "/.opam/default/share/ocp-indent/vim")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ml,*.mli",
  callback = function()
    vim.cmd("%!ocp-indent")
  end,
})


-- Save folds and cursor position after opening up a file.
local save_fold = vim.api.nvim_create_augroup("Persistent Folds", { clear = true })

-- Save folds on buffer leave
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = save_fold,
  pattern = "?*",
  command = "silent! mkview",
})

-- Load folds on buffer enter
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = save_fold,
  pattern = "?*",
  command = "silent! loadview",
})

vim.opt.viewoptions:remove("options") -- Don't save local settings. Just folds/cursor pos.
