local c = require("huez-manager.api").colorscheme

local eq = assert.are.same
local path = vim.fs.normalize("/tmp/huez-theme-test")

describe("HUEZ: colorscheme api", function()
  it("can read and write to a huez-theme file", function()
    local written = c.save("test", path)
    local read = c.get(path)

    eq(not nil, written)
    eq("test", read)

    os.remove(path)
  end)

  it("can return default installed themes", function()
    local themes = c.installed({})

    -- in workflows we also test on neovim nightly, this if statement handles that case
    if vim.fn.has("nvim-0.10") == 1 then
      eq(26, #themes)
      return
    end

    eq(21, #themes)
  end)
end)
