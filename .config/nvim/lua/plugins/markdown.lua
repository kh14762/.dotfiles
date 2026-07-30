return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
  },

  -- vim-table-mode
  -- Enter the first line, delimiting columns by the | symbol. The plugin reacts by inserting spaces between the text and the separator if you omit them
  -- In the second line (without leaving Insert mode), enter | twice. The plugin will write a properly formatted horizontal line
  -- When you enter the subsequent lines, the plugin will automatically adjust the formatting to match the text you’re entering every time you press |
  -- Then you can return to the first line and above it enter ||
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
  },
}
