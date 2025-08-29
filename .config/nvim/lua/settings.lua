vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'

vim.filetype.add({
	extension = {
		lc2k = "lc2k",
		as = "as",
	},
})

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

vim.opt.rtp:prepend(os.getenv("HOME") .. "/.opam/default/share/ocp-indent/vim")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ml,*.mli",
  callback = function()
    vim.cmd("%!ocp-indent")
  end,
})
