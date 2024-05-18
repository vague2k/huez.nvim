# 🎨 huez.nvim _(hue ez, hues)_

https://github.com/vague2k/huez.nvim/assets/121782036/c4837430-781b-46c9-8b3d-946c883bbb7f

## ⭐️ Features

- 🔭 Uses telescope for customization and fuzzy finding of themes!
- 🌄 Preview colorschemes.
- 💾 Persistent colorscheme selection through Neovim session.

## 💥 Installation

Install with your preferred package manager

```lua
-- Lazy
{
    "vague2k/huez.nvim",
    config = function()
        require("huez").setup({})
    end,
}
```

## ⚙️ Configuration

Huez comes with the following defaults. You can find different predefined layouts [here](#premade-layouts)

```lua
{
  -- the directory where huez place it's files to save the theme, or get current theme, things like that
  -- not reccommended that you change this directory, but the option is there.
  -- if you change it and find a bug please submit an issue.
  path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
  -- the fallback theme which will be written to a new "huez-theme" file in case the "huez-theme" file does not exist
  fallback = "default",
  -- a list of ugly theme that come with neovim that you probably don't want to choose from in the picker
  exclude = {
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
    "zaibatsu",
    "wildcharm",
    "sorbet",
    "vim",
  },

  -- configures how you want a certain picker to look.
  picker = {
    -- all pickers use telescope values, by default picker is anchored to the right.
    -- you can use an out of the box layout. Options are "left", "top", "right", or "bottom" or nil
    -- by default, the standalone layout used is "right"
    layout = "right",
    -- if you are using a predefined layout, any options you pass into the picker will be deep merged.
    themes = {},
  },
}
```

### Premade layouts

<details>
  <summary>anchor top</summary>
  <img src="https://github.com/vague2k/huez.nvim/assets/121782036/36e72653-b3d7-44c8-83e7-c0e983f06b7a" alt="anchor top"/>
</details>

<details>
  <summary>anchor right</summary>
  <img src="https://github.com/vague2k/huez.nvim/assets/121782036/3a343940-b857-43d9-96b2-719127a6b509" alt="anchor right"/>
</details>

<details>
  <summary>anchor left</summary>
  <img src="https://github.com/vague2k/huez.nvim/assets/121782036/0d076bc2-13b4-4423-ae41-c0e74b8cc54d" alt="anchor left"/>
</details>

<details>
  <summary>anchor bottom</summary>
  <img src="https://github.com/vague2k/huez.nvim/assets/121782036/e5ee0c02-9e52-4d09-9890-08d757beaa4e" alt="anchor bottom"/>
</details>

## License

[MIT](https://choosealicense.com/licenses/mit/)
