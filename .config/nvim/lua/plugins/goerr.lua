return {
  -- Go error folding using simple vim folding
  {
    name = "go-error-folding",
    dir = vim.fn.stdpath("config"),
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          -- Use manual folding for Go files
          vim.opt_local.foldmethod = "manual"
          vim.opt_local.foldenable = true
          vim.opt_local.foldlevel = 99
          
          -- Function to fold Go error handling blocks
          local function fold_go_errors()
            local buf = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            
            -- Clear existing folds
            vim.cmd("normal! zE")
            
            local i = 1
            while i <= #lines do
              local line = lines[i]
              -- Look for "if err != nil" patterns
              if line:match("%s*if%s+err%s*!=%s*nil%s*{") then
                local start_line = i
                local brace_count = 1
                local j = i + 1
                
                -- Find the matching closing brace
                while j <= #lines and brace_count > 0 do
                  local current_line = lines[j]
                  -- Count braces (simple approach)
                  for char in current_line:gmatch(".") do
                    if char == "{" then
                      brace_count = brace_count + 1
                    elseif char == "}" then
                      brace_count = brace_count - 1
                    end
                  end
                  j = j + 1
                end
                
                -- Create fold if we found a complete block
                if brace_count == 0 and j > start_line + 1 then
                  vim.cmd(string.format("%d,%dfold", start_line, j - 1))
                end
                
                i = j
              else
                i = i + 1
              end
            end
          end
          
          -- Key mappings for Go error folding
          vim.keymap.set("n", "<leader>fe", fold_go_errors, { 
            buffer = true, 
            desc = "Fold Go error blocks" 
          })
          
          vim.keymap.set("n", "<leader>fu", function()
            vim.cmd("normal! zR")
          end, { 
            buffer = true, 
            desc = "Unfold all" 
          })
          
          -- Auto-fold errors when opening Go files
          vim.defer_fn(fold_go_errors, 100)
        end,
      })
    end,
  },
}