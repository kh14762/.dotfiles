return {
  -- "ellisonleao/gruvbox.nvim",
  -- config = function()
  --   require("gruvbox").setup({
  --     contrast = "hard", -- Set contrast variant to hard
  --     -- Additional options can be added here
  --   })
  --   vim.opt.background = "dark"
  --   vim.cmd.colorscheme("gruvbox")
  -- end,

  "sainnhe/gruvbox-material",
  lazy = false,
  config = function()
    -- Configuration options must be set before loading the colorscheme

    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 1

    -- Apply the dark background and theme
    vim.opt.background = "dark"
    vim.cmd.colorscheme("gruvbox-material")
  end,
}
