local R

---@class ThemeRegistryEntry
---@field url string the repo's url
---@field pkgname string the repo/colorscheme's name
---@field colorscheme? string the name of the arg to load colorscheme

---@type table<string, ThemeRegistryEntry>
R = {
  ["tokyonight"] = {
    url = "https://github.com/folke/tokyonight.nvim",
    pkgname = "tokyonight",
  },
  ["nightfox"] = {
    url = "https://github.com/EdenEast/nightfox.nvim",
    pkgname = "nightfox",
  },
  ["rose-pine"] = {
    url = "https://github.com/rose-pine/neovim",
    pkgname = "rose-pine",
  },
  ["witch"] = {
    url = "https://github.com/sontungexpt/witch",
    pkgname = "witch",
  },
  ["abstract-cs"] = {
    url = "https://github.com/Abstract-IDE/Abstract-cs",
    pkgname = "abstract-cs",
    colorscheme = "abscs",
  },
  ["neon"] = {
    url = "https://github.com/rafamadriz/neon",
    pkgname = "neon",
  },
  ["vim-code-dark"] = {
    url = "https://github.com/tomasiser/vim-code-dark",
    pkgname = "vim-code-dark",
    colorscheme = "codedark",
  },
  ["vscode"] = {
    url = "https://github.com/Mofiqul/vscode.nvim",
    pkgname = "vscode",
  },
  ["visual_studio_code"] = {
    url = "https://github.com/askfiy/visual_studio_code",
    pkgname = "visual_studio_code",
  },
  ["material"] = {
    url = "https://github.com/marko-cerovac/material.nvim",
    pkgname = "material",
  },
  ["nightfly"] = {
    url = "https://github.com/bluz71/vim-nightfly-colors",
    pkgname = "nightfly",
  },
  ["moonfly"] = {
    url = "https://github.com/bluz71/vim-moonfly-colors",
    pkgname = "moonfly",
  },
  ["nvcode"] = {
    url = "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim",
    pkgname = "nvcode",
  },
  ["evergarden"] = {
    url = "https://github.com/comfysage/evergarden",
    pkgname = "evergarden",
  },
  ["sonokai"] = {
    url = "https://github.com/sainnhe/sonokai",
    pkgname = "sonokai",
  },
  ["oxocarbon"] = {
    url = "https://github.com/nyoom-engineering/oxocarbon.nvim",
    pkgname = "oxocarbon",
  },
  ["blue-moon"] = {
    url = "https://github.com/kyazdani42/blue-moon",
    pkgname = "blue-moon",
  },
  ["oceanic-next"] = {
    url = "https://github.com/mhartington/oceanic-next",
    pkgname = "oceanic-next",
    colorscheme = "OceanicNext",
  },
  ["zephyr"] = {
    url = "https://github.com/nvimdev/zephyr-nvim",
    pkgname = "zephyr",
  },
  ["boo"] = {
    url = "https://github.com/rockerBOO/boo-colorscheme-nvim",
    pkgname = "boo",
  },
  ["ariake"] = {
    url = "https://github.com/jim-at-jibba/ariake.nvim",
    pkgname = "ariake",
  },
  ["edge"] = {
    url = "https://github.com/sainnhe/edge",
    pkgname = "edge",
  },
  ["deus"] = {
    url = "https://github.com/theniceboy/nvim-deus",
    pkgname = "deus",
  },
  ["one"] = {
    url = "https://github.com/Th3Whit3Wolf/one-nvim",
    pkgname = "one",
    colorscheme = "doom-one",
  },
  ["hybrid"] = {
    url = "https://github.com/PHSix/nvim-hybrid",
    pkgname = "hybrid",
    colorscheme = "nvim-hybrid",
  },
  ["space"] = {
    url = "https://github.com/Th3Whit3Wolf/space-nvim",
    pkgname = "space",
    colorscheme = "space-nvim",
  },
  ["omni"] = {
    url = "https://github.com/yonlu/omni.vim",
    pkgname = "omni",
  },
  ["aurora"] = {
    url = "https://github.com/ray-x/aurora",
    pkgname = "aurora",
  },
  ["monokai"] = {
    url = "https://github.com/tanvirtin/monokai.nvim",
    pkgname = "monokai",
  },
  ["ofirkai"] = {
    url = "https://github.com/ofirgall/ofirkai.nvim",
    pkgname = "ofirkai",
  },
  ["melange"] = {
    url = "https://github.com/savq/melange-nvim",
    pkgname = "melange",
  },
  ["base16"] = {
    url = "https://github.com/RRethy/base16-nvim",
    pkgname = "base16",
    colorscheme = "base16-default-dark",
  },
  ["falcon"] = {
    url = "https://github.com/fenetikm/falcon",
    pkgname = "falcon",
  },
  ["nordic"] = {
    url = "https://github.com/AlexvZyl/nordic.nvim",
    pkgname = "nordic",
  },
  ["nord"] = {
    url = "https://github.com/shaunsingh/nord.nvim",
    pkgname = "nord",
  },
  ["solarized"] = {
    url = "https://github.com/ishan9299/nvim-solarized-lua",
    pkgname = "solarized",
  },
  ["lavender"] = {
    url = "https://codeberg.org/jthvai/lavender.nvim",
    pkgname = "lavender",
  },
  ["github"] = {
    url = "https://github.com/projekt0n/github-nvim-theme",
    pkgname = "github",
    colorscheme = "github_dark_default",
  },
  ["gruvbox-material"] = {
    url = "https://github.com/sainnhe/gruvbox-material",
    pkgname = "gruvbox-material",
  },
  ["everforest"] = {
    url = "https://github.com/sainnhe/everforest",
    pkgname = "everforest",
  },
  ["everforest-lua"] = {
    url = "https://github.com/neanias/everforest-nvim",
    pkgname = "everforest-lua",
    colorscheme = "everforest",
  },
  ["doom-one"] = {
    url = "https://github.com/NTBBloodbath/doom-one.nvim",
    pkgname = "doom-one",
  },
  ["dracula"] = {
    url = "https://github.com/dracula/vim",
    pkgname = "dracula",
  },
  ["dracula-lua"] = {
    url = "https://github.com/Mofiqul/dracula.nvim",
    pkgname = "dracula-lua",
    colorscheme = "dracula",
  },
  ["calvera-dark"] = {
    url = "https://github.com/niyabits/calvera-dark.nvim",
    pkgname = "calvera-dark",
    colorscheme = "calvera",
  },
  ["vn-night"] = {
    url = "https://github.com/nxvu699134/vn-night.nvim",
    pkgname = "vn-night",
  },
  ["monochrome"] = {
    url = "https://github.com/kdheepak/monochrome.nvim",
    pkgname = "monochrome",
  },
  ["catppuccin"] = {
    url = "https://github.com/catppuccin/nvim",
    pkgname = "catppuccin",
  },
  ["aquarium"] = {
    url = "https://github.com/FrenzyExists/aquarium-vim",
    pkgname = "aquarium",
  },
  ["substrata"] = {
    url = "https://github.com/kvrohit/substrata.nvim",
    pkgname = "substrata",
  },
  ["vimdark"] = {
    url = "https://github.com/ldelossa/vimdark",
    pkgname = "vimdark",
  },
  ["everblush"] = {
    url = "https://github.com/Everblush/nvim",
    pkgname = "everblush",
  },
  ["onedarkpro"] = {
    url = "https://github.com/olimorris/onedarkpro.nvim",
    pkgname = "onedarkpro",
    colorscheme = "onedark",
  },
  ["onenord"] = {
    url = "https://github.com/rmehri01/onenord.nvim",
    pkgname = "onenord",
  },
  ["gruvbox-baby"] = {
    url = "https://github.com/luisiacc/gruvbox-baby",
    pkgname = "gruvbox-baby",
  },
  ["zephyrium"] = {
    url = "https://github.com/titanzero/zephyrium",
    pkgname = "zephyrium",
  },
  ["kanagawa"] = {
    url = "https://github.com/rebelot/kanagawa.nvim",
    pkgname = "kanagawa",
  },
  ["kurayami"] = {
    url = "https://github.com/kevinm6/kurayami.nvim",
    pkgname = "kurayami",
  },
  ["tokyodark"] = {
    url = "https://github.com/tiagovla/tokyodark.nvim",
    pkgname = "tokyodark",
  },
  ["one_monokai"] = {
    url = "https://github.com/cpea2506/one_monokai.nvim",
    pkgname = "one_monokai",
  },
  ["rasmus"] = {
    url = "https://github.com/kvrohit/rasmus.nvim",
    pkgname = "rasmus",
  },
  ["juliana"] = {
    url = "https://github.com/kaiuri/nvim-juliana",
    pkgname = "juliana",
  },
  ["kimbox"] = {
    url = "https://github.com/lmburns/kimbox",
    pkgname = "kimbox",
  },
  ["mellifluous"] = {
    url = "https://github.com/ramojus/mellifluous.nvim",
    pkgname = "mellifluous",
  },
  ["minimal"] = {
    url = "https://github.com/Yazeed1s/minimal.nvim",
    pkgname = "minimal",
  },
  ["adwaita"] = {
    url = "https://github.com/Mofiqul/adwaita.nvim",
    pkgname = "adwaita",
  },
  ["poimandres"] = {
    url = "https://github.com/olivercederborg/poimandres.nvim",
    pkgname = "poimandres",
  },
  ["mellow"] = {
    url = "https://github.com/mellow-theme/mellow.nvim",
    pkgname = "mellow",
  },
  ["lucy"] = {
    url = "https://github.com/Yazeed1s/oh-lucy.nvim",
    pkgname = "lucy",
    colorscheme = "oh-lucy",
  },
  ["embark"] = {
    url = "https://github.com/embark-theme/vim",
    pkgname = "embark",
  },
  ["nvimgelion"] = {
    url = "https://github.com/nyngwang/nvimgelion",
    pkgname = "nvimgelion",
  },
  ["fluoromachine"] = {
    url = "https://github.com/maxmx03/fluoromachine.nvim",
    pkgname = "fluoromachine",
  },
  ["midnight"] = {
    url = "https://github.com/dasupradyumna/midnight.nvim",
    pkgname = "midnight",
  },
  ["dark_flat"] = {
    url = "https://github.com/uncleTen276/dark_flat.nvim",
    pkgname = "dark_flat",
  },
  ["citruszest"] = {
    url = "https://github.com/zootedb0t/citruszest.nvim",
    pkgname = "citruszest",
  },
  ["miasma"] = {
    url = "https://github.com/xero/miasma.nvim",
    pkgname = "miasma",
  },
  ["deepwhite"] = {
    url = "https://github.com/Verf/deepwhite.nvim",
    pkgname = "deepwhite",
  },
  ["bamboo"] = {
    url = "https://github.com/ribru17/bamboo.nvim",
    pkgname = "bamboo",
  },
  ["nightcity"] = {
    url = "https://github.com/cryptomilk/nightcity.nvim",
    pkgname = "nightcity",
  },
  ["monokai-nightasty"] = {
    url = "https://github.com/polirritmico/monokai-nightasty.nvim",
    pkgname = "monokai-nightasty",
  },
  ["night-owl"] = {
    url = "https://github.com/oxfist/night-owl.nvim",
    pkgname = "night-owl",
  },
  ["modus"] = {
    url = "https://github.com/miikanissi/modus-themes.nvim",
    pkgname = "modus",
  },
  ["cyberdream"] = {
    url = "https://github.com/scottmckendry/cyberdream.nvim",
    pkgname = "cyberdream",
  },
  ["hybrid-dark"] = {
    url = "https://github.com/HoNamDuong/hybrid.nvim",
    pkgname = "hybrid-dark",
    colorscheme = "hybrid",
  },
  ["halfspace"] = {
    url = "https://gitlab.com/sxwpb/halfspace.nvim",
    pkgname = "halfspace",
  },
  ["distinct"] = {
    url = "https://gitlab.com/bartekjaszczak/distinct-nvim",
    pkgname = "distinct",
  },
  ["synthweave"] = {
    url = "https://github.com/samharju/synthweave.nvim",
    pkgname = "synthweave",
  },
  ["gruvbox"] = {
    url = "https://github.com/ellisonleao/gruvbox.nvim",
    pkgname = "gruvbox",
  },
  ["selenized"] = {
    url = "https://github.com/calind/selenized.nvim",
    pkgname = "selenized",
  },
  ["neomodern"] = {
    url = "https://github.com/cdmill/neomodern.nvim",
    pkgname = "neomodern",
    colorscheme = "roseprime",
  },
  ["vague"] = {
    url = "https://github.com/vague2k/vague.nvim",
    pkgname = "vague",
    colorscheme = "vague",
  },
}

return R
