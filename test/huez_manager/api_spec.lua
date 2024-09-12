local c = require("huez-manager.api").colorscheme
local f = require("huez-manager.api").favorites

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
      local test_file = test_file_path
      local written = c.save("default", test_file)
      assert(written == true)

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
  describe("FAVORITES:", function()
    local test_file_path = "/tmp/huez-favorite-test"
    after_each(function()
      os.remove(vim.fs.normalize(test_file_path))
    end)

    it("can write to a huez-favorite file with no errors", function()
      local test_file = test_file_path
      local written = f.add("default", test_file)
      assert(written == true)
    end)

    it("can error if colorscheme attempted to be written is not valid", function()
      local test_file = test_file_path
      local written = f.add("doesnt_exist", test_file)
      assert(written == false)
    end)

    it("can read from a huez-favorite file with no errors", function()
      local test_file = test_file_path
      local written = f.add("default", test_file)
      assert(written == true)

      local read = f.list(test_file)
      assert(read[1] == "default")
    end)

    it("can return correct amount of lines from a huez-favorite-themes file", function()
      local test_file = test_file_path
      for _ = 1, 10 do
        f.add("default", test_file)
      end
      local read = f.list(test_file)

      assert(10 == #read)
    end)
  end)
end)
