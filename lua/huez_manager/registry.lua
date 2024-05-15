local R

-- TODO: create a readme describing what themes can added to the registry.

---@class ThemeRegistryEntry
---@field url string the repo's url
---@field opts table|nil if the colorscheme has |setup()|, opts will be an empty table
---@field pkgname string the repo/colorscheme's name
---@field dependencies? LazySpec[] deps. the colorscheme may have, like lush for example
---@field colorscheme? string the name of the arg to load colorscheme
---@field config? function|nil Any neccessary calls needed for the colorscheme to preview.

---@type table<string, ThemeRegistryEntry>
R = {
  ["tokyonight"] = {
    url = "https://github.com/folke/tokyonight.nvim",
    opts = {},
    pkgname = "tokyonight",
  },
  ["nightfox"] = {
    url = "https://github.com/EdenEast/nightfox.nvim",
    opts = {},
    pkgname = "nightfox",
  },
  ["rose-pine"] = {
    url = "https://github.com/rose-pine/neovim",
    opts = {},
    pkgname = "rose-pine",
  },
  ["witch"] = {
    url = "https://github.com/sontungexpt/witch",
    opts = {},
    pkgname = "witch",
  },
  ["abstract-cs"] = {
    url = "https://github.com/Abstract-IDE/Abstract-cs",
    opts = nil,
    pkgname = "abstract-cs",
    colorscheme = "abscs",
  },
  ["neon"] = {
    url = "https://github.com/rafamadriz/neon",
    opts = nil,
    pkgname = "neon",
  },
  ["vim-code-dark"] = {
    url = "https://github.com/tomasiser/vim-code-dark",
    opts = nil,
    pkgname = "vim-code-dark",
    colorscheme = "codedark",
  },
  ["vscode"] = {
    url = "https://github.com/Mofiqul/vscode.nvim",
    opts = {},
    pkgname = "vscode",
  },
  ["visual_studio_code"] = {
    url = "https://github.com/askfiy/visual_studio_code",
    opts = {},
    pkgname = "visual_studio_code",
  },
  ["material"] = {
    url = "https://github.com/marko-cerovac/material.nvim",
    opts = {},
    pkgname = "material",
  },
  ["nightfly"] = {
    url = "https://github.com/bluz71/vim-nightfly-colors",
    opts = nil,
    pkgname = "nightfly",
  },
  ["moonfly"] = {
    url = "https://github.com/bluz71/vim-moonfly-colors",
    opts = nil,
    pkgname = "moonfly",
  },
  ["nvcode"] = {
    url = "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim",
    opts = nil,
    pkgname = "nvcode",
  },
  ["evergarden"] = {
    url = "https://github.com/comfysage/evergarden",
    opts = {},
    pkgname = "evergarden",
  },
  ["sonokai"] = {
    url = "https://github.com/sainnhe/sonokai",
    opts = nil,
    pkgname = "sonokai",
  },
  ["oxocarbon"] = {
    url = "https://github.com/nyoom-engineering/oxocarbon.nvim",
    opts = nil,
    pkgname = "oxocarbon",
  },
  ["blue-moon"] = {
    url = "https://github.com/kyazdani42/blue-moon",
    opts = {},
    pkgname = "blue-moon",
  },
  ["oceanic-next"] = {
    url = "https://github.com/mhartington/oceanic-next",
    opts = nil,
    pkgname = "oceanic-next",
    colorscheme = "OceanicNext",
  },
  ["zephyr"] = {
    url = "https://github.com/nvimdev/zephyr-nvim",
    opts = nil,
    pkgname = "zephyr",
  },
  ["boo"] = {
    url = "https://github.com/rockerBOO/boo-colorscheme-nvim",
    opts = nil,
    pkgname = "boo",
  },
  ["ariake"] = {
    url = "https://github.com/jim-at-jibba/ariake.nvim",
    opts = {},
    pkgname = "ariake",
  },
  ["onebuddy"] = {
    url = "https://github.com/Th3Whit3Wolf/onebuddy",
    opts = nil,
    pkgname = "onebuddy",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("colorbuddy").colorscheme("onebuddy")
    end,
  },
  ["edge"] = {
    url = "https://github.com/sainnhe/edge",
    opts = nil,
    pkgname = "edge",
  },
  ["deus"] = {
    url = "https://github.com/theniceboy/nvim-deus",
    opts = nil,
    pkgname = "deus",
  },
  ["gloombuddy"] = {
    url = "https://github.com/bkegley/gloombuddy",
    opts = nil,
    pkgname = "gloombuddy",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("colorbuddy").colorscheme("gloombuddy")
    end,
  },
  ["one"] = {
    url = "https://github.com/Th3Whit3Wolf/one-nvim",
    opts = nil,
    pkgname = "one",
    colorscheme = "doom-one",
  },
  ["hybrid"] = {
    url = "https://github.com/PHSix/nvim-hybrid",
    opts = {},
    pkgname = "hybrid",
    colorscheme = "nvim-hybrid",
  },
  ["space"] = {
    url = "https://github.com/Th3Whit3Wolf/space-nvim",
    opts = nil,
    pkgname = "space",
    colorscheme = "space-nvim",
  },
  ["omni"] = {
    url = "https://github.com/yonlu/omni.vim",
    opts = {},
    pkgname = "omni",
  },
  ["aurora"] = {
    url = "https://github.com/ray-x/aurora",
    opts = nil,
    pkgname = "aurora",
  },
  ["starry"] = {
    url = "https://github.com/ray-x/starry.nvim",
    opts = {},
    pkgname = "starry",
  },
  ["monokai"] = {
    url = "https://github.com/tanvirtin/monokai.nvim",
    opts = {},
    pkgname = "monokai",
  },
  ["ofirkai"] = {
    url = "https://github.com/ofirgall/ofirkai.nvim",
    opts = {},
    pkgname = "ofirkai",
  },
  ["melange"] = {
    url = "https://github.com/savq/melange-nvim",
    opts = {},
    pkgname = "melange",
  },
  ["base16"] = {
    url = "https://github.com/RRethy/base16-nvim",
    opts = {},
    pkgname = "base16-colorscheme",
    colorscheme = "base16-default-dark",
  },
  ["falcon"] = {
    url = "https://github.com/fenetikm/falcon",
    opts = {},
    pkgname = "falcon",
  },
  ["nordic"] = {
    url = "https://github.com/AlexvZyl/nordic.nvim",
    opts = nil,
    pkgname = "nordic",
  },
  ["nord"] = {
    url = "https://github.com/shaunsingh/nord.nvim",
    opts = nil,
    pkgname = "nord",
  },
  ["neosolarized"] = {
    url = "https://github.com/svrana/neosolarized.nvim",
    opts = {},
    pkgname = "neosolarized",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("colorbuddy").colorscheme("neosolarized")
    end,
  },
  ["solarized"] = {
    url = "https://github.com/ishan9299/nvim-solarized-lua",
    opts = nil,
    pkgname = "solarized",
  },
  ["lavender"] = {
    url = "https://codeberg.org/jthvai/lavender.nvim",
    opts = nil,
    pkgname = "lavender",
  },
  ["github"] = {
    url = "https://github.com/projekt0n/github-nvim-theme",
    opts = nil,
    pkgname = "github",
    colorscheme = "github_dark_default",
  },
  ["gruvbox-material"] = {
    url = "https://github.com/sainnhe/gruvbox-material",
    opts = nil,
    pkgname = "gruvbox-material",
  },
  ["everforest"] = {
    url = "https://github.com/neanias/everforest-nvim",
    opts = {},
    pkgname = "everforest",
    colorscheme = "everforest",
  },
  ["doom-one"] = {
    url = "https://github.com/NTBBloodbath/doom-one.nvim",
    opts = nil,
    pkgname = "doom-one",
  },
  ["dracula"] = {
    url = "https://github.com/dracula/vim",
    opts = nil,
    pkgname = "dracula",
  },
  ["calvera-dark"] = {
    url = "https://github.com/niyabits/calvera-dark.nvim",
    opts = nil,
    pkgname = "calvera-dark",
    colorscheme = "calvera",
  },
  ["vn-night"] = {
    url = "https://github.com/nxvu699134/vn-night.nvim",
    opts = {},
    pkgname = "vn-night",
  },
  ["codeschool"] = {
    url = "https://github.com/adisen99/codeschool.nvim",
    opts = nil,
    pkgname = "codeschool",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["monochrome"] = {
    url = "https://github.com/kdheepak/monochrome.nvim",
    opts = nil,
    pkgname = "monochrome",
  },
  ["zenbones"] = {
    url = "https://github.com/mcchrish/zenbones.nvim",
    opts = nil,
    pkgname = "zenbones",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["catppuccin"] = {
    url = "https://github.com/catppuccin/nvim",
    opts = {},
    pkgname = "catppuccin",
  },
  ["aquarium"] = {
    url = "https://github.com/FrenzyExists/aquarium-vim",
    opts = nil,
    pkgname = "aquarium",
  },
  ["substrata"] = {
    url = "https://github.com/kvrohit/substrata.nvim",
    opts = nil,
    pkgname = "substrata",
  },
  ["vimdark"] = {
    url = "https://github.com/ldelossa/vimdark",
    opts = nil,
    pkgname = "vimdark",
  },
  ["everblush"] = {
    url = "https://github.com/Everblush/nvim",
    opts = {},
    pkgname = "everblush",
  },
  ["apprentice"] = {
    url = "https://github.com/adisen99/apprentice.nvim",
    opts = nil,
    pkgname = "apprentice",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["onedarkpro"] = {
    url = "https://github.com/olimorris/onedarkpro.nvim",
    opts = nil,
    pkgname = "onedarkpro",
    colorscheme = "onedark",
  },
  ["onenord"] = {
    url = "https://github.com/rmehri01/onenord.nvim",
    opts = {},
    pkgname = "onenord",
  },
  ["gruvy"] = {
    url = "https://github.com/RishabhRD/gruvy",
    opts = nil,
    pkgname = "gruvy",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["gruvbox-baby"] = {
    url = "https://github.com/luisiacc/gruvbox-baby",
    opts = nil,
    pkgname = "gruvbox-baby",
  },
  ["zephyrium"] = {
    url = "https://github.com/titanzero/zephyrium",
    opts = nil,
    pkgname = "zephyrium",
  },
  ["kanagawa"] = {
    url = "https://github.com/rebelot/kanagawa.nvim",
    opts = {},
    pkgname = "kanagawa",
  },
  ["kurayami"] = {
    url = "https://github.com/kevinm6/kurayami.nvim",
    opts = {},
    pkgname = "kurayami",
  },
  ["tokyodark"] = {
    url = "https://github.com/tiagovla/tokyodark.nvim",
    opts = {},
    pkgname = "tokyodark",
  },
  ["one_monokai"] = {
    url = "https://github.com/cpea2506/one_monokai.nvim",
    opts = {},
    pkgname = "one_monokai",
  },
  ["rasmus"] = {
    url = "https://github.com/kvrohit/rasmus.nvim",
    opts = nil,
    pkgname = "rasmus",
  },
  ["paramount-ng"] = {
    url = "https://github.com/chrsm/paramount-ng.nvim",
    opts = nil,
    pkgname = "paramount-ng",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["juliana"] = {
    url = "https://github.com/kaiuri/nvim-juliana",
    opts = {},
    pkgname = "juliana",
  },
  ["kimbox"] = {
    url = "https://github.com/lmburns/kimbox",
    opts = {},
    pkgname = "kimbox",
  },
  ["arctic"] = {
    url = "https://github.com/rockyzhang24/arctic.nvim",
    opts = nil,
    pkgname = "arctic",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["mellifluous"] = {
    url = "https://github.com/ramojus/mellifluous.nvim",
    opts = {},
    pkgname = "mellifluous",
  },
  ["minimal"] = {
    url = "https://github.com/Yazeed1s/minimal.nvim",
    opts = nil,
    pkgname = "minimal",
  },
  ["adwaita"] = {
    url = "https://github.com/Mofiqul/adwaita.nvim",
    opts = nil,
    pkgname = "adwaita",
  },
  ["poimandres"] = {
    url = "https://github.com/olivercederborg/poimandres.nvim",
    opts = {},
    pkgname = "poimandres",
  },
  ["mellow"] = {
    url = "https://github.com/mellow-theme/mellow.nvim",
    opts = {},
    pkgname = "mellow",
  },
  ["lucy"] = {
    url = "https://github.com/Yazeed1s/oh-lucy.nvim",
    opts = nil,
    pkgname = "lucy",
    colorscheme = "oh-lucy",
  },
  ["embark"] = {
    url = "https://github.com/embark-theme/vim",
    opts = nil,
    pkgname = "embark",
  },
  ["nvimgelion"] = {
    url = "https://github.com/nyngwang/nvimgelion",
    opts = nil,
    pkgname = "nvimgelion",
  },
  ["fluoromachine"] = {
    url = "https://github.com/maxmx03/fluoromachine.nvim",
    opts = {},
    pkgname = "fluoromachine",
  },
  ["midnight"] = {
    url = "https://github.com/dasupradyumna/midnight.nvim",
    opts = {},
    pkgname = "midnight",
  },
  ["yawnc"] = {
    url = "https://github.com/sonjiku/yawnc.nvim",
    opts = nil,
    pkgname = "yawnc",
  },
  ["dark_flat"] = {
    url = "https://github.com/uncleTen276/dark_flat.nvim",
    opts = nil,
    pkgname = "dark_flat",
  },
  ["citruszest"] = {
    url = "https://github.com/zootedb0t/citruszest.nvim",
    opts = {},
    pkgname = "citruszest",
  },
  ["vitesse"] = {
    url = "https://github.com/2nthony/vitesse.nvim",
    opts = {},
    pkgname = "vitesse",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("colorbuddy").colorscheme("vitesse")
    end,
  },
  ["miasma"] = {
    url = "https://github.com/xero/miasma.nvim",
    opts = nil,
    pkgname = "miasma",
  },
  ["deepwhite"] = {
    url = "https://github.com/Verf/deepwhite.nvim",
    opts = nil,
    pkgname = "deepwhite",
  },
  ["ronny"] = {
    url = "https://github.com/judaew/ronny.nvim",
    opts = {},
    pkgname = "ronny",
  },
  ["bamboo"] = {
    url = "https://github.com/ribru17/bamboo.nvim",
    opts = {},
    pkgname = "bamboo",
  },
  ["nightcity"] = {
    url = "https://github.com/cryptomilk/nightcity.nvim",
    opts = {},
    pkgname = "nightcity",
  },
  ["monokai-nightasty"] = {
    url = "https://github.com/polirritmico/monokai-nightasty.nvim",
    opts = nil,
    pkgname = "monokai-nightasty",
  },
  ["night-owl"] = {
    url = "https://github.com/oxfist/night-owl.nvim",
    opts = {},
    pkgname = "night-owl",
  },
  ["modus-theme"] = {
    url = "https://github.com/miikanissi/modus-themes.nvim",
    opts = {},
    pkgname = "modus-theme",
    colorscheme = "modus",
  },
  ["palenight"] = {
    url = "https://github.com/alexmozaidze/palenight.nvim",
    opts = nil,
    pkgname = "palenight",
  },
  ["cyberdream"] = {
    url = "https://github.com/scottmckendry/cyberdream.nvim",
    opts = {},
    pkgname = "cyberdream",
  },
  ["hybrid-dark"] = {
    url = "https://github.com/HoNamDuong/hybrid.nvim",
    opts = nil,
    pkgname = "hybrid-dark",
    colorscheme = "hybrid",
  },
  ["halfspace"] = {
    url = "https://gitlab.com/sxwpb/halfspace.nvim",
    opts = nil,
    pkgname = "halfspace",
  },
  ["distinct"] = {
    url = "https://gitlab.com/bartekjaszczak/distinct-nvim",
    opts = nil,
    pkgname = "distinct",
  },
  ["synthweave"] = {
    url = "https://github.com/samharju/synthweave.nvim",
    opts = {},
    pkgname = "synthweave",
  },
  ["darkearth"] = {
    url = "https://github.com/ptdewey/darkearth-nvim",
    opts = nil,
    pkgname = "darkearth",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["bluloco"] = {
    url = "https://github.com/uloco/bluloco.nvim",
    opts = {},
    pkgname = "bluloco",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["gruvbox"] = {
    url = "https://github.com/ellisonleao/gruvbox.nvim",
    opts = {},
    pkgname = "gruvbox",
  },
  ["jellybeans"] = {
    url = "https://github.com/metalelf0/jellybeans-nvim",
    opts = nil,
    pkgname = "jellybeans",
    dependencies = { "rktjmp/lush.nvim" },
    colorscheme = "jellybeans-nvim",
  },
  ["cobalt2"] = {
    url = "https://github.com/lalitmee/cobalt2.nvim",
    opts = nil,
    pkgname = "cobalt2",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("colorbuddy").colorscheme("cobalt2")
    end,
  },
  ["selenized"] = {
    url = "https://github.com/calind/selenized.nvim",
    opts = nil,
    pkgname = "selenized",
  },
}

return R
