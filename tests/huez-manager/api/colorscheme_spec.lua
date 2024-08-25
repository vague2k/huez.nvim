local c = require("huez-manager.api.colorscheme")

describe("COLORSCHEME API:", function()
  it("can write to a huez-colorscheme file with no errors", function()
    local test_file = vim.fs.normalize("/tmp/huez-colorscheme-test")
    local written = c.save("test", test_file)
    assert(written ~= nil)
    os.remove(test_file)
  end)

  it("can read from a huez-colorscheme file with no errors", function()
    -- test setup
    local test_file = vim.fs.normalize("/tmp/huez-colorscheme-test")
    local written = c.save("test", test_file)
    assert(written ~= nil)

    -- actual test case
    local read = c.get(test_file)
    assert(read == "test")
    os.remove(test_file)
  end)

  it("can return default installed colorscheme", function()
    local colorschemes = c.installed({})

    if vim.fn.has("nvim-0.10") == 1 then
      assert(#colorschemes == 26)
      return
    end

    -- <= nvim-0.9
    assert(#colorschemes == 21)
  end)

  it("can return colorschemes excluding Huez.Config.excluded", function()
    local colorschemes = c.installed({ "zellner", "morning" })

    if vim.fn.has("nvim-0.10") == 1 then
      assert(#colorschemes == 24)
      return
    end

    -- <= nvim-0.9
    assert(#colorschemes == 19)
  end)
end)
