return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "goimports" },
				c = {}, -- explicitly set no formatters for C files
				h = {}, -- explicitly set no formatters for header files
			},
			format_on_save = {
				-- Disable LSP fallback for C files
				lsp_fallback = function(bufnr)
					local filetype = vim.bo[bufnr].filetype
					return filetype ~= "c" and filetype ~= "h"
				end,
				async = false,
				timeout_ms = 1000,
			},
		})

		-- Modify the format keybinding to respect the same rules
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local filetype = vim.bo[bufnr].filetype
			if filetype == "c" or filetype == "h" then
				return -- do nothing for C files
			end
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
