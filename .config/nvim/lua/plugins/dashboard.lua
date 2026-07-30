return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      table.insert(opts.dashboard.preset.keys, {
        icon = "󰈞 ",
        key = "d",
        desc = "Dotfiles",
        action = ":e ~/.config",
      })
    end,
  },
}
