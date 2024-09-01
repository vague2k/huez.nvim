local c = require("huez-manager.api.colorscheme")

describe("HUEZ-MANAGER API", function()
  describe("COLORSCHEME:", function()
    local test_file_path = "/tmp/huez-colorscheme-test"
    after_each(function()
      os.remove(vim.fs.normalize(test_file_path))
    end)

    it("can write to a huez-colorscheme file with no errors", function()
      local test_file = test_file_path
      local written = c.save("default", test_file)
      assert(written == true)
    end)

    it("can error if colorscheme attempted to be written is not valid", function()
      local test_file = test_file_path
      local written = c.save("doesnt_exist", test_file)
      assert(written == false)
    end)

    it("can read from a huez-colorscheme file with no errors", function()
      -- test setup
      local test_file = test_file_path
      local written = c.save("default", test_file)
      assert(written == true)

      -- actual test case
      local read = c.get(test_file)
      assert(read == "default")
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
end)
