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
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  -- Quality of Life Plugins
  {'numToStr/Comment.nvim'},

  -- Color Schemes
  {'Mofiqul/dracula.nvim'},
  {'NTBBloodbath/doom-one.nvim'},
  {'rebelot/kanagawa.nvim'},
  {
    "ViViDboarder/wombat.nvim",
    dependencies = { { "rktjmp/lush.nvim" } },
    opts = {
        -- You can optionally specify the name of the ansi colors you wish to use
        -- This defaults to nil and will use the default ansi colors for the theme
        ansi_colors_name = nil,
    },
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "pro", 
      })
    end,
  },
  -- Treesitter: A fancier way of parcing code, needed for some syntax highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.install({ "elixir", "eex", "heex", "lua" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "elixir", "eex", "heex" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
  },
})
