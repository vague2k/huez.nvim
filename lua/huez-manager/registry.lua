local R

-- TODO: create a readme describing what themes can added to the registry.

---@class ThemeRegistryEntry
---@field url string the repo's url
---@field opts table (WIP) pending
---@field pkgname string the repo/colorscheme's name
---@field dependencies? string[] deps. the colorscheme may have, like lush for example
---@field colorscheme? string the name of the arg to load colorscheme

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
    opts = {},
    pkgname = "abstract-cs",
    colorscheme = "abscs",
  },
  ["neon"] = {
    url = "https://github.com/rafamadriz/neon",
    opts = {},
    pkgname = "neon",
  },
  ["vim-code-dark"] = {
    url = "https://github.com/tomasiser/vim-code-dark",
    opts = {},
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
    opts = {},
    pkgname = "nightfly",
  },
  ["moonfly"] = {
    url = "https://github.com/bluz71/vim-moonfly-colors",
    opts = {},
    pkgname = "moonfly",
  },
  ["nvcode"] = {
    url = "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim",
    opts = {},
    pkgname = "nvcode",
  },
  ["evergarden"] = {
    url = "https://github.com/comfysage/evergarden",
    opts = {},
    pkgname = "evergarden",
  },
  ["sonokai"] = {
    url = "https://github.com/sainnhe/sonokai",
    opts = {},
    pkgname = "sonokai",
  },
  ["oxocarbon"] = {
    url = "https://github.com/nyoom-engineering/oxocarbon.nvim",
    opts = {},
    pkgname = "oxocarbon",
  },
  ["blue-moon"] = {
    url = "https://github.com/kyazdani42/blue-moon",
    opts = {},
    pkgname = "blue-moon",
  },
  ["oceanic-next"] = {
    url = "https://github.com/mhartington/oceanic-next",
    opts = {},
    pkgname = "oceanic-next",
    colorscheme = "OceanicNext",
  },
  ["zephyr"] = {
    url = "https://github.com/nvimdev/zephyr-nvim",
    opts = {},
    pkgname = "zephyr",
  },
  ["boo"] = {
    url = "https://github.com/rockerBOO/boo-colorscheme-nvim",
    opts = {},
    pkgname = "boo",
  },
  ["ariake"] = {
    url = "https://github.com/jim-at-jibba/ariake.nvim",
    opts = {},
    pkgname = "ariake",
  },
  ["onebuddy"] = {
    url = "https://github.com/Th3Whit3Wolf/onebuddy",
    opts = {},
    pkgname = "onebuddy",
    dependencies = { "tjdevries/colorbuddy.vim" },
  },
  ["edge"] = {
    url = "https://github.com/sainnhe/edge",
    opts = {},
    pkgname = "edge",
  },
  ["deus"] = {
    url = "https://github.com/theniceboy/nvim-deus",
    opts = {},
    pkgname = "deus",
  },
  ["gloombuddy"] = {
    url = "https://github.com/bkegley/gloombuddy",
    opts = {},
    pkgname = "gloombuddy",
    dependencies = { "tjdevries/colorbuddy.vim" },
  },
  ["one"] = {
    url = "https://github.com/Th3Whit3Wolf/one-nvim",
    opts = {},
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
    opts = {},
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
    opts = {},
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
    pkgname = "base16",
    colorscheme = "base16-default-dark",
  },
  ["falcon"] = {
    url = "https://github.com/fenetikm/falcon",
    opts = {},
    pkgname = "falcon",
  },
  ["nordic"] = {
    url = "https://github.com/AlexvZyl/nordic.nvim",
    opts = {},
    pkgname = "nordic",
  },
  ["nord"] = {
    url = "https://github.com/shaunsingh/nord.nvim",
    opts = {},
    pkgname = "nord",
  },
  ["neosolarized"] = {
    url = "https://github.com/svrana/neosolarized.nvim",
    opts = {},
    pkgname = "neosolarized",
    dependencies = { "tjdevries/colorbuddy.vim" },
  },
  ["solarized"] = {
    url = "https://github.com/ishan9299/nvim-solarized-lua",
    opts = {},
    pkgname = "solarized",
  },
  ["lavender"] = {
    url = "https://codeberg.org/jthvai/lavender.nvim",
    opts = {},
    pkgname = "lavender",
  },
  ["github"] = {
    url = "https://github.com/projekt0n/github-nvim-theme",
    opts = {},
    pkgname = "github",
    colorscheme = "github_dark_default",
  },
  ["gruvbox-material"] = {
    url = "https://github.com/sainnhe/gruvbox-material",
    opts = {},
    pkgname = "gruvbox-material",
  },
  ["everforest"] = {
    url = "https://github.com/sainnhe/everforest",
    opts = {},
    pkgname = "everforest",
  },
  ["everforest-lua"] = {
    url = "https://github.com/neanias/everforest-nvim",
    opts = {},
    pkgname = "everforest-lua",
    colorscheme = "everforest",
  },
  ["doom-one"] = {
    url = "https://github.com/NTBBloodbath/doom-one.nvim",
    opts = {},
    pkgname = "doom-one",
  },
  ["dracula"] = {
    url = "https://github.com/dracula/vim",
    opts = {},
    pkgname = "dracula",
  },
  ["dracula-lua"] = {
    url = "https://github.com/Mofiqul/dracula.nvim",
    opts = {},
    pkgname = "dracula-lua",
    colorscheme = "dracula",
  },
  ["calvera-dark"] = {
    url = "https://github.com/niyabits/calvera-dark.nvim",
    opts = {},
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
    opts = {},
    pkgname = "codeschool",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["monochrome"] = {
    url = "https://github.com/kdheepak/monochrome.nvim",
    opts = {},
    pkgname = "monochrome",
  },
  ["zenbones"] = {
    url = "https://github.com/mcchrish/zenbones.nvim",
    opts = {},
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
    opts = {},
    pkgname = "aquarium",
  },
  ["substrata"] = {
    url = "https://github.com/kvrohit/substrata.nvim",
    opts = {},
    pkgname = "substrata",
  },
  ["vimdark"] = {
    url = "https://github.com/ldelossa/vimdark",
    opts = {},
    pkgname = "vimdark",
  },
  ["everblush"] = {
    url = "https://github.com/Everblush/nvim",
    opts = {},
    pkgname = "everblush",
  },
  ["apprentice"] = {
    url = "https://github.com/adisen99/apprentice.nvim",
    opts = {},
    pkgname = "apprentice",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["onedarkpro"] = {
    url = "https://github.com/olimorris/onedarkpro.nvim",
    opts = {},
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
    opts = {},
    pkgname = "gruvy",
    dependencies = { "rktjmp/lush.nvim" },
  },
  ["gruvbox-baby"] = {
    url = "https://github.com/luisiacc/gruvbox-baby",
    opts = {},
    pkgname = "gruvbox-baby",
  },
  ["zephyrium"] = {
    url = "https://github.com/titanzero/zephyrium",
    opts = {},
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
    opts = {},
    pkgname = "rasmus",
  },
  ["paramount-ng"] = {
    url = "https://github.com/chrsm/paramount-ng.nvim",
    opts = {},
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
    opts = {},
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
    opts = {},
    pkgname = "minimal",
  },
  ["adwaita"] = {
    url = "https://github.com/Mofiqul/adwaita.nvim",
    opts = {},
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
    opts = {},
    pkgname = "lucy",
    colorscheme = "oh-lucy",
  },
  ["embark"] = {
    url = "https://github.com/embark-theme/vim",
    opts = {},
    pkgname = "embark",
  },
  ["nvimgelion"] = {
    url = "https://github.com/nyngwang/nvimgelion",
    opts = {},
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
    opts = {},
    pkgname = "yawnc",
  },
  ["dark_flat"] = {
    url = "https://github.com/uncleTen276/dark_flat.nvim",
    opts = {},
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
    dependencies = { "tjdevries/colorbuddy.vim" },
  },
  ["miasma"] = {
    url = "https://github.com/xero/miasma.nvim",
    opts = {},
    pkgname = "miasma",
  },
  ["deepwhite"] = {
    url = "https://github.com/Verf/deepwhite.nvim",
    opts = {},
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
    opts = {},
    pkgname = "monokai-nightasty",
  },
  ["night-owl"] = {
    url = "https://github.com/oxfist/night-owl.nvim",
    opts = {},
    pkgname = "night-owl",
  },
  ["modus"] = {
    url = "https://github.com/miikanissi/modus-themes.nvim",
    opts = {},
    pkgname = "modus",
  },
  ["palenight"] = {
    url = "https://github.com/alexmozaidze/palenight.nvim",
    opts = {},
    pkgname = "palenight",
  },
  ["cyberdream"] = {
    url = "https://github.com/scottmckendry/cyberdream.nvim",
    opts = {},
    pkgname = "cyberdream",
  },
  ["hybrid-dark"] = {
    url = "https://github.com/HoNamDuong/hybrid.nvim",
    opts = {},
    pkgname = "hybrid-dark",
    colorscheme = "hybrid",
  },
  ["halfspace"] = {
    url = "https://gitlab.com/sxwpb/halfspace.nvim",
    opts = {},
    pkgname = "halfspace",
  },
  ["distinct"] = {
    url = "https://gitlab.com/bartekjaszczak/distinct-nvim",
    opts = {},
    pkgname = "distinct",
  },
  ["synthweave"] = {
    url = "https://github.com/samharju/synthweave.nvim",
    opts = {},
    pkgname = "synthweave",
  },
  ["darkearth"] = {
    url = "https://github.com/ptdewey/darkearth-nvim",
    opts = {},
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
    opts = {},
    pkgname = "jellybeans",
    dependencies = { "rktjmp/lush.nvim" },
    colorscheme = "jellybeans-nvim",
  },
  ["cobalt2"] = {
    url = "https://github.com/lalitmee/cobalt2.nvim",
    opts = {},
    pkgname = "cobalt2",
    dependencies = { "tjdevries/colorbuddy.vim" },
  },
  ["selenized"] = {
    url = "https://github.com/calind/selenized.nvim",
    opts = {},
    pkgname = "selenized",
  },
  ["sunburn"] = {
    url = "https://github.com/loganswartz/sunburn.nvim",
    opts = {},
    pkgname = "sunburn",
    dependencies = { "loganswartz/polychrome.nvim" },
  },
  ["neomodern"] = {
    url = "https://github.com/cdmill/neomodern.nvim",
    opts = {},
    pkgname = "neomodern",
    colorscheme = "roseprime",
  },
}

return R