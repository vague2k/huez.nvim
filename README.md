> huez.actions will be deprecated in 0.2.1 or next semi-major version. Whichever comes first.
>
> **PLEASE** use require("huez.api").get_colorscheme() in your Huez configuration in your neovim config instead.
>
> See updated Setup section.

# 🎨 huez.nvim _(hue ez, hues)_

Color picker using [Telescope](https://github.com/nvim-telescope/telescope.nvim) as a backend.

## ⭐️ Features

- 🔭 Optionally uses [Telescope](https://github.com/nvim-telescope/telescope.nvim) picking and selecting colorschemes. by default uses vim.ui!
- 🌄 Preview colorschemes. _if telescope is installed_
- 💾 Persistent colorscheme selection through Neovim session.

In this demo I'm using telescope.

https://github.com/vague2k/huez.nvim/assets/121782036/6f720919-6eef-479d-bc82-7450d8c51bdc

## 💥 Installation

Install with your preferred package manager

```lua
-- Lazy
{
    "vague2k/huez.nvim",
    dependencies = {
        -- You probably already have this installed.
        -- reccomended, but optional dependency.
        -- Will use vim.ui as a default unless specified otherwise, or a fallback.
        -- Preview does not currently work in vim.ui.
        "nvim-telescope/telescope.nvim",
    },
},
```

## 🛠 Setup

Reccommended setup. Without the colorscheme command, the plugin WILL use fallback theme.

```lua
require("huez").setup({})

local colorscheme = require("huez.api").get_colorscheme()
vim.cmd("colorscheme " .. colorscheme)

vim.keymap.set("n", "<leader>co", "<cmd>Huez<CR>", {})

```

## ⚙️ Configuration

Huez comes with the following defaults.

```lua
{
  -- the filepath where your theme will be saved
  file_path = vim.fs.normalize(vim.fn.stdpath("config")) .. "/.nvim.huez.lua",
  -- the fallback theme in case Huez fails or bugs out for some reason
  fallback = "default",
  -- a list of ugly theme that come with neovim that you probably don't want to choose from in the picker
  omit = {
    "default",
    "desert",
    "evening",
    "industry",
    "koehler",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "ron",
    "shine",
    "slate",
    "torte",
    "zellner",
    "blue",
    "darkblue",
    "delek",
    "quiet",
    "elflord",
    "habamax",
    "lunaperche",
  },
  -- optional: by default, picker will be vim.ui.select, you can also choose "telescope"
  picker = "vim",
  -- optional: only applies if using telescope, picker_opts controls the dropdown style
  picker_opts = require("telescope.themes").get_dropdown({}),
}

```

## 💭 FAQ

#### How is the selected colorscheme saved and be able to persist through nvim sessions?

At setup time, a function is called to check if the file ".nvim.huez.lua" exists in your `vim.fn.stdpath("config")` directory. If it exists, nothing happens. If it does not exist, it will be created with the default fallback as it's colorscheme.

This file will only contain 1 line worth of content, being the colorscheme name (I.E gruvbox <EOF>). Setup is shown above.

To see config directory run the following command in neovim.

`:lua print(vim.inspect(vim.fn.stdpath("config")))`

#### Can I change the directory where the colorscheme file is created?

Yes. But I reccommend leaving the file_path and the dotfile's name as their default values, but if you end up changing it and find a bug, please file an issue!

## ❤️ Acknowledgements

Plugin and it's code is highly inspired from the following.

- [colorscheme-persist](https://github.com/propet/colorscheme-persist.nvim) on how to persist colorscheme.
- [NvChad](https://github.com/NvChad/NvChad) for previewing theme before selection.
- [cd-project](https://github.com/LintaoAmons/cd-project.nvim) for being used as a great model for a refactor _(as of 0.2.0)_
- Reddit for the help on how to make a plugin as this is my first :)

## 📋 Contributing

Issues and PR's are always welcome and highly encouraged! as this is my first plugin. I would love to learn more.

## License

[MIT](https://choosealicense.com/licenses/mit/)
