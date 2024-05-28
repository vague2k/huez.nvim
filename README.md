# huez.nvim

> This demo shows the persistent, registry/ensure installed and favorites features

https://github.com/vague2k/huez.nvim/assets/121782036/98cdbc8d-9fef-4238-a386-1dab798f41bc

## Table of Contents

- [Features](#features)
- [Requires](#requires)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Commands](#commands)
    - [Huez](#huez)
    - [HuezFavorites](#huezfavorites)
    - [HuezLive](#huezlive)
    - [HuezEnsured](#huezensured)

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
    config = function()
        require("huez").setup({})
    end,
}
```

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

## Usage

All of these commands currently use telescope and opens pickers to...

| Command          | Description                                  |
| ---------------- | -------------------------------------------- |
| `:Huez`          | Preview installed colorschemes               |
| `:HuezFavorites` | Preview colorschemes marked as favorites     |
| `:HuezLive`      | Preview and install themes from a registry   |
| `:HuezEnsured`   | Preview colorschemes ensured to be installed |

If you're using Lua:

```lua
local pickers = require("huez.pickers")

vim.keymap.set("n", "<leader>co", pickers.themes, {})
vim.keymap.set("n", "<leader>cof", pickers.favorites, {})
vim.keymap.set("n", "<leader>col", pickers.live, {})
vim.keymap.set("n", "<leader>coe", pickers.ensured, {})
```

Huez handles loading and dynamically installing/uninstalling colorschemes using file located (by default) in `~/.local/share/nvim/huez/` or
if you're using lua `vim.fn.stdpath("data") .. "/huez"`. If you changed the [configuration](#configuration) opt `path`, this path is different
for you.

On setup, Huez while read the `huez-theme` file in this directory, and loads that colorscheme. If for some reason that colorscheme can't be loaded,
Huez will fallback to using the very appropriately named [configuration](#configuration) opt `fallback`. In the case that your fallback colorscheme also cannot be loaded, huez will resort
to neovim's "default" colorscheme.

## Commands

##### Huez

`:Huez` will open a picker of colorschemes that are currently installed, omitting any colorschemes passed to [configuration](#configuration) opt `exclude`,
where `exclude` is usually a list of default themes that come with preinstalled with Neovim, that are not so appealing. If you prefer one of these themes,

you can always add or remove themes from this list to change what results are shown in the picker.

This single command has always been and always be Huez's main and most practical functionality

| Mapping        | Action                                                          |
| -------------- | --------------------------------------------------------------- |
| `<C-n>/<Down>` | Preview next colorscheme                                        |
| `<C-p>/<Up>`   | Preview previous colorscheme                                    |
| `<j>/<k>`      | Preview next/previous colorscheme respectively (in normal mode) |
| `<esc>`        | Close the picker and load the persisted colorscheme             |
| `<CR>`         | Select colorscheme and persist this through neovim sessions     |
| `<space>`      | Add the selected colorscheme to favorites                       |

##### HuezFavorites

Works exactly like [`:Huez`](#huez) except you're dealing with colorschemes marked as favorites.
The only thing that differs is what the action the `<space>` mapping performs

The file that contains a list of these themes can be found in `~/.local/share/nvim/huez/huez-favorite-themes`

| Mapping   | Action                                         |
| --------- | ---------------------------------------------- |
| `<space>` | Remove the selected colorscheme from favorites |

##### HuezLive

`:HuezLive` opens a picker of colorschemes plugins from the registry. The idea is you don't have to leave Neovim
to look for a new theme to try out.

To be able to use `:HuezLive` and `:HuezEnsured` without throwing errors,
you must add this line to the lazy config wherever you setup Huez.

```lua
{
-- ...
import = "huez-manager.import"
-- ...
}
```

A colorscheme plugin from the registry can include multiple colorschemes, a good example is cattpuccin.
cattpuccin is the plugin itself, but there are 4 colorschemes that come with cattpuccin.

While traversing the picker's results, if a colorscheme plugin only has 1 colorscheme, that will be the colorscheme
that will be loaded. If the plugin has more than 1 colorscheme, a predefined colorscheme from the plugin will be previewed, For example

```lua
-- base16, is the plugin that will be installed, but since it contains hundreds of colorschemes
-- I chose "base16-default-dark" to be an appropriate default to preview
["base16"] = {
    url = "https://github.com/RRethy/base16-nvim",
    pkgname = "base16",
    colorscheme = "base16-default-dark",
  },
```

Traversing the picker also writes the new colorscheme plugin to be previewed to `~/.local/share/nvim/huez/huez-live-themes`
When exiting the picker, this is file is wiped clean, effectively uninstalling all of these themes.

Note that lazy will not show that these plugins are ready to be cleaned until the next neovim reload

| Mapping        | Action                                                                      |
| -------------- | --------------------------------------------------------------------------- |
| `<C-n>/<Down>` | Install and preview next colorscheme                                        |
| `<C-p>/<Up>`   | Install and preview previous colorscheme                                    |
| `<j>/<k>`      | Install and preview next/previous colorscheme respectively (in normal mode) |
| `<esc>`        | Close the picker and unload all installed colorschemes                      |
| `<space>`      | Install the selected colorscheme plugin (ensure installed)                  |

##### HuezEnsured

`:HuezEnsured` opens a picker of colorschemes plugins that are ensured to be installed if they are found in the registry.

The mappings are similiar to [`:Huez`](#huez) with the same characteristics describe in [`:HuezLive`](#huezlive)

The file that contains the list of these themes can be found in `~/.local/share/nvim/huez/huez-ensured-themes`

| Mapping        | Action                                                          |
| -------------- | --------------------------------------------------------------- |
| `<C-n>/<Down>` | Preview next colorscheme                                        |
| `<C-p>/<Up>`   | Preview previous colorscheme                                    |
| `<j>/<k>`      | Preview next/previous colorscheme respectively (in normal mode) |
| `<esc>`        | Close the picker and load the persisted colorscheme             |
| `<CR>`         | Select colorscheme and persist this through neovim sessions     |
| `<space>`      | Uninstall the selected colorscheme plugin                       |

## License

[MIT](https://choosealicense.com/licenses/mit/)
