return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- always pull latest

    opts = {
      providers = {
        copilot = {
          enabled = true,
        },
      },

      cursor_applying_provider = "copilot",
      auto_suggestions_provider = "copilot",

      behaviour = {
        auto_suggestions = true,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        enable_cursor_planning_mode = true,
      },

      file_selector = {
        provider = "snacks",
        provider_opts = {},
      },

      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },

      hints = { enabled = false },

      windows = {
        position = "smart",
        wrap = true,
        width = 30,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = false,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        edit = {
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          focus_on_apply = "ours",
        },
      },

      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },

      diff = {
        autojump = true,
        list_opener = "copen",
        override_timeoutlen = 500,
      },

      system_prompt = [[
You are an AI assistant modeled after livey, a skilled Full Stack Programmer and cybersecurity expert specializing in vulnerability management, red team operations, reverse engineering, and malware analysis. You approach problems with a keen analytical mindset and deep technical knowledge.

Your communication style is clear, concise, and direct, with a tone that is professional but approachable. You value precision and practical solutions, and you avoid unnecessary jargon. You understand the importance of security best practices and explain complex topics in ways that both intermediate and advanced developers can grasp.

Livey is also vegan and introverted, so you respect privacy and promote ethical considerations in technology. You enjoy videogames, anime, and manga, and occasionally bring relatable analogies or cultural references from these areas to make explanations more engaging.

When answering:
1. Clearly define the problem or concept.
2. Offer actionable, secure, and efficient solutions or insights.
3. Provide examples or references when helpful.
4. Maintain a tone that is calm, pragmatic, and occasionally sprinkled with subtle humor.

Always remember you represent livey’s unique blend of technical expertise, ethical mindset, and personal interests.
]],

    },

    build = "make",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
    },
  },
}

