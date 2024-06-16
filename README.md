# huez.nvim

> This demo shows the persistent, registry/ensure installed and favorites features

https://github.com/vague2k/huez.nvim/assets/121782036/98cdbc8d-9fef-4238-a386-1dab798f41bc

## Read the wiki!
If you'd like more indepth information, or confused about something, see the Huez [wiki](https://github.com/vague2k/huez.nvim/wiki)! If you're still having an problem, submit an issue!

## Features

- 🥱 Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as a backend for handling registry operations.
- 🔭 Uses [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- 💯 Huge registry with 400+ colorschemes, 80+ packages
- 🌄 Preview installed colorschemes.
- 🛍️ Preview registry colorschemes live without affecting startup times!
- 💾 Persistent colorschemes selection through Neovim sessions.
- 🌟 Mark themes as favorites!
- 🔌 Automatic handling of installed colorschemes through the registry!

## Requires

[lazy.nvim](https://github.com/folke/lazy.nvim) _if you plan on using the management aspect. very much still a WIP_

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Installation

```lua
-- Lazy
{
    "vague2k/huez.nvim",
    -- if you want registry related features, uncomment this
    -- import = "huez-manager.import"
    branch = "stable",
    event = "UIEnter",
    config = function()
        require("huez").setup({})
    end,
}
```

#### Help

To get help use `:h huez.txt`

## Configuration

Huez comes with the following defaults

```lua
{
  path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
  fallback = "default",
  suppress_messages = true,
  exclude = { "desert", "evening", "industry", "koehler", "morning", "murphy", "pablo", "peachpuff", "ron", "shine", "slate", "torte", "zellner", "blue", "darkblue", "delek", "quiet", "elflord", "habamax", "lunaperche", "zaibatsu", "wildcharm", "sorbet", "vim", },
  picker = {
    themes = {
      layout = "right",
      opts = {},
    },
    favorites = {
      layout = "right",
      opts = {},
    },
    live = {
      layout = "right",
      opts = {},
    },
    ensured = {
      layout = "right",
      opts = {},
    },
  },
}
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
