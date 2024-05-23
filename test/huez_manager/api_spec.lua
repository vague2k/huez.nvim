local c = require("huez-manager.api").colorscheme
local f = require("huez-manager.api").favorites

local eq = assert.are.same
local theme_test_file = vim.fs.normalize("/tmp/huez-theme-test")

describe("HUEZ-MANAGER | COLORSCHEME API:", function()
  it("can read and write to a huez-theme file", function()
    local written = c.save("test", theme_test_file)
    local read = c.get(theme_test_file)

    eq(not nil, written)
    eq("test", read)

    os.remove(theme_test_file)
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

local favorites_test_file = vim.fs.normalize("/tmp/huez-favorite-themes-test")

describe("HUEZ-MANAGER | FAVORITES API:", function()
  it("can read and write to a huez-favorite-themes file", function()
    local written = f.add("test", favorites_test_file)
    local read = f.list(favorites_test_file)

    eq(not nil, written)
    eq("test", read[1])

    os.remove(favorites_test_file)
  end)

  it("can return correct amount of lines from a huez-favorite-themes file", function()
    for _ = 1, 10 do
      f.add("test", favorites_test_file)
    end
    local read = f.list(favorites_test_file)

    eq(10, #read)

    os.remove(favorites_test_file)
  end)
end)
