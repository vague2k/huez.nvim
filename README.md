
# 🎨 huez.nvim *(hue ez, hues)*

Color picker using [Telescope](https://github.com/nvim-telescope/telescope.nvim) as a backend.


## ⭐️ Features
- 🔭 Uses [Telescope](https://github.com/nvim-telescope/telescope.nvim) picking and selecting colorschemes.
- 🌄 Preview colorschemes.
- 💾 Persistent colorscheme selection through Neovim session.


## 💥 Installation

Install with your preferred package manager

```lua
-- Lazy
{
    "vague2k/huez.nvim",
    dependencies = {
        -- you probably already have this installed
        "nvim-telescope/telescope.nvim",
    },
},

```
    
## 🛠 Setup
Reccommended setup. Without the colorscheme command, the plugin WILL use fallback theme.
```lua
require("huez").setup({})

local colorscheme = require("huez.actions").get_colorscheme()
vim.cmd("colorscheme " .. colorscheme)

vim.keymap.set("n", "<leader>co", "<cmd>Huez<CR>", {})

```
## ⚙️ Configuration
Huez comes with the following defaults.

```lua
-- fallback theme incase the plugin stops working
fallback = "default",

-- a list of ugly themes that come with neovim, 
-- that are omitted from showing up in the telescope selection
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
picker_opts = require("telescope.themes").get_dropdown({}),

```
## 💭 FAQ

#### How is the selected colorscheme saved and be able to persist through nvim sessions?

At setup time, a function is called to check if the file ".nvim.huez.lua" exists in your home directory. If it exists, nothing happens. If it does not exist, it will be created.

This file will only contain 1 line worth of content, being the colorscheme name (I.E gruvbox <EOF>). Setup is shown above. 

To see home directory run the following scripts in your terminal.

Mac: `echo $HOME`

Windows (powershell): `echo $Env:USERPROFILE`
#### Can I change the directory where the colorscheme file is created?

No.


## ❤️ Acknowledgements
Plugin and it's code is highly inspired from the following.
 - [colorscheme-persist](https://github.com/propet/colorscheme-persist.nvim) on how to persist colorscheme.
 - [NvChad](https://github.com/NvChad/NvChad) for previewing theme before selection.
 - Reddit for the help on how to make a plugin :)


## 📋 Contributing

Issues and PR's are always welcome and highly encouraged! as this is my first plugin. I would love to learn more.


## License

[MIT](https://choosealicense.com/licenses/mit/)


## ⚙️ Configuration
Huez comes with the following defaults.

```lua
-- fallback theme incase the plugin stops working
fallback = "default",

-- a list of ugly themes that come with neovim, 
-- that are omitted from showing up in the telescope selection
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
picker_opts = require("telescope.themes").get_dropdown({}),

```