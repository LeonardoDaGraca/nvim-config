return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<leader>tt]],
      direction = "horizontal",
      size = 15,
      -- Shows "id:name" above every terminal window so 1<leader>tt .. 9<leader>tt
      -- stay identifiable at a glance instead of blank numbered splits.
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return term.id .. ":" .. term:_display_name()
        end,
      },
    })

    local terminal = require("toggleterm.terminal")
    local ui = require("toggleterm.ui")
    local keymap = vim.keymap

    local function current_term()
      local id = vim.b.toggle_number
      if not id then return nil end
      return terminal.get(id)
    end

    -- <leader>tr: label the terminal under the cursor (e.g. "server", "tests").
    -- The label shows in the winbar so you can tell terminals apart later.
    keymap.set({ "n", "t" }, "<leader>tr", function()
      local term = current_term()
      if not term then return end
      vim.ui.input({ prompt = "Terminal " .. term.id .. " name: ", default = term.display_name or "" }, function(name)
        if name == nil then return end
        term.display_name = name ~= "" and name or nil
        ui.set_winbar(term)
      end)
    end, { desc = "Terminal: rename" })

    -- <leader>td{h,v,f}: re-open the terminal under the cursor in a different
    -- orientation (horizontal/vertical/float) without losing its process.
    local function set_direction(direction)
      return function()
        local term = current_term()
        if not term then return end
        term:close()
        term:open(nil, direction)
      end
    end

    keymap.set({ "n", "t" }, "<leader>tdh", set_direction("horizontal"), { desc = "Terminal: horizontal" })
    keymap.set({ "n", "t" }, "<leader>tdv", set_direction("vertical"), { desc = "Terminal: vertical" })
    keymap.set({ "n", "t" }, "<leader>tdf", set_direction("float"), { desc = "Terminal: float" })
  end,
}
