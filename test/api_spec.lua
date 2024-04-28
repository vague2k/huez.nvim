local api = require("huez.api")

local eq = assert.are.same

describe("api", function()
  it("can read and write to a huez-theme file", function()
    local mock_path = vim.fs.normalize("~/.cache/nvim/huez-theme-test")

    local written = api.save_colorscheme("test", mock_path)
    local read = api.get_colorscheme(mock_path)

    eq(not nil, written)
    eq("test", read)
  end)

  it("can return default installed themes", function()
    local themes = api.get_installed_themes({})

    eq(21, #themes)
  end)
end)
