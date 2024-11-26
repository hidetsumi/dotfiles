return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "pyright",
        "tailwindcss",
        automatic_installation = true,
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd",
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "eslint_d",
        "markdown-toc"
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
