return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Configuración principal de conform
      formatters_by_ft = {
        css = { "prettierd" },
        graphql = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        lua = { "stylua" },
        markdown = { "markdown-toc" },
        python = { "isort", "black" },
        sql = { "sql-formatter" },
        svelte = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        yaml = { "prettierd" },
      },
    },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
        mode = {"n", "v"},
        desc = "Format buffer",
      },
    },
    init = function()
      -- Atajos para formatear el archivo y la selección
      local conform = require("conform")
      vim.keymap.set({ "n" }, "<leader>f", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file" })

      vim.keymap.set({ "v" }, "<leader>f", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format selection" })

      -- Comando para formatear con rango opcional
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end

        conform.format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },
}
