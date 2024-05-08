local c = require("huez.api").colorscheme

local eq = assert.are.same

describe("HUEZ: colorscheme api", function()
  it("can read and write to a huez-theme file", function()
    local mock_path = vim.fs.normalize("~/.cache/nvim/huez-theme-test")

    local written = c.save("test", mock_path)
    local read = c.get(mock_path)

    eq(not nil, written)
    eq("test", read)

    os.remove(mock_path)
  end)

  it("can return default installed themes", function()
    local themes = c.installed({})

    eq(21, #themes)
  end)
end)
