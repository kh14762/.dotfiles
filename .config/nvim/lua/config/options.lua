-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable mouse
vim.opt.mouse = ""

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Preview substitutions live as you type
vim.o.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Ignore web boilerplate in searches
vim.opt.wildignore:append({
  "node_modules/*",
  ".git/*",
  "*.o",
  "*.obj",
  "*.exe",
  "*.so",
  "*.dll",
  "*.dylib",
  ".DS_Store",
  "*.zip",
  "*.tar.gz",
  "*.jpg",
  "*.png",
  "*.gif",
  "*.pdf",
  "*.svg",
  "**/coverage/*",
  "**/dist/*",
  "**/build/*",
  "**/.next/*",
  "**/out/*",
  "**/target/*",
  "**/.nuxt/*",
  "**/.cache/*",
  "**/public/assets/*",
  "*.min.js",
  "*.min.css",
  "**/vendor/*",
})
