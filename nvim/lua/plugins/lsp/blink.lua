return {
  "saghen/blink.cmp",
  opts = {
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },

    -- experimental signature help support
    -- signature = { enabled = true },

    sources = {
      min_keyword_length = function(ctx)
        return ctx.update_type == "manual" and 0 or 3
      end
    },

    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
