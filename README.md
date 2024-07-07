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
- 🔗 Customize theme configurations as per your liking!

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
  theme_config_module = nil,
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

### Extending theme configuration

Huez checks any theme configuration inside of the neovim config directory. To
add any theme configurations, you need to create a directory inside of `lua/` in
your base config directory.

In case of the themes being in a themes module, the directory structure will
look like `${HOME}/.config/nvim/lua/themes/tokyonight.lua`.

Then we register this directory with `huez`.

```lua
require("huez").setup({
    theme_config_module="themes"
})
```

Each of the theme files needs to be named after the theme(base theme name). You
can find the name of your theme by checking the `huez` scheme selector. The
theme file returns a table of type `Huez.ThemeConfig`. A sample is given below
for `tokyonight`.

```lua
---@type Huez.ThemeConfig
---@diagnostic disable-next-line: missing-fields
local M = {
    --- All the styles which the theme supports
	styles = { "moon", "day", "night", "storm" },
}

---@param theme string
M.set_theme = function(theme)
	---@type tokyonight.Config
	local base_conf = {
		styles = {
			functions = { bold = true, italic = true },
			variables = { italic = true },
			keywords = { bold = true, italic = true },
		},
		on_colors = function(colors) end,
		on_highlights = function(highlights, colors)
            --- The keys can be found by putting cursor to the word and
            --- typing :Inspect
			highlights["Type"] = { bold = true, italic = true }
			highlights["@string.javascript"] = { bold = true, italic = true, fg = colors.green }
		end,
	}

	require("tokyonight").setup(base_conf)
	vim.cmd("colorscheme " .. theme)
	return true
end

return M
```

We can also add conditional themes within a theme. For example:

```lua
--- rose-pine.lua
---@type Huez.ThemeConfig
---@diagnostic disable-next-line: missing-fields
local M = {
	styles = { "dawn", "main", "moon" },
}

M.set_theme = function(theme)
	local base_conf = {
		highlight_groups = {
			Comment = { italic = true },
			Keyword = { bold = true, italic = true },
			TelescopeSelectionCaret = { fg = "none", bg = "none" },
		},
		styles = {
			transparency = false,
		},
	}
	local additional_conf = {}

    -- Only add transaparency mode for darker themes
	if theme ~= "rose-pine-dawn" then
		additional_conf = vim.tbl_extend("force", additional_conf, {
			highlight_groups = {
				TelescopeBorder = { fg = "highlight_high", bg = "none" },
				TelescopeNormal = { bg = "none" },
				TelescopePromptNormal = { bg = "base" },
				TelescopeResultsNormal = { fg = "subtle", bg = "none" },
				TelescopeSelection = { fg = "text", bg = "base" },
				TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
			},
			styles = {
				transparency = true,
			},
		})
	end
	require("rose-pine").setup(vim.tbl_deep_extend("force", base_conf, additional_conf))
	vim.cmd("colorscheme " .. theme)
	return true
end

return M
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
