> BREAKING CHANGES SOON:
>
> Huez v1.0.0 is currently being written, as you can see this will be a breaking change.
> I'm redesigning the plugin's current implementation as I see fit and planning new features.
>
> I will focus on maintainability, stability, and UI/UX in that order.
> When v1.0.0 is ready to be officially released and you would like to stay on v0.2.4, You can pin the 0.2.4 tag in your preferred Plugin manager
>
> You can check out development in the "manager" branch

# 🎨 huez.nvim _(hue ez, hues)_

> This demo shows the persistent, registry/ensure installed and favorites features

https://github.com/vague2k/huez.nvim/assets/121782036/98cdbc8d-9fef-4238-a386-1dab798f41bc


## ⭐️ Features

- 🥱 Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as a backend for handling registry operations.
- 🔭 Uses [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- 💯 Huge registry with 400+ colorschemes, 80+ packages
- 🌄 Preview installed colorschemes.
- 🛍️ Preview registry colorschemes live without affecting startup times!
- 💾 Persistent colorschemes selection through Neovim sessions.
- 🌟 Mark themes as favorites!
- 🔌 Automatic handling of installed colorschemes through the registry!

## 💭 Requires

[lazy.nvim](https://github.com/folke/lazy.nvim) _if you plan on using the management aspect. very much still a WIP_

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## 💥 Installation

```lua
-- Lazy
{
    "vague2k/huez.nvim",
    -- if you want registry related features, uncomment this
    -- import = "huez-manager.import"
    config = function()
        require("huez").setup({})
    end,
}
```

## ⚙️ Configuration

Huez comes with the following defaults. You can find different predefined layouts [here](#premade-layouts)

```lua
{
  -- the default plugin directory
  path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
  -- the colorscheme Huez will fallback to incase something goes wrong
  fallback = "default",
  -- a list of ugly theme that come with neovim that you probably don't want to choose from in the theme picker
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
    -- if you are using a predefined layout, any options you pass into the picker will be deep merged.
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
