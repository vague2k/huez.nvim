describe("HUEZ", function()
  describe("CONFIG:", function()
    it("validates user opts with no errors", function()
      local config = require("huez.config")
      ---@diagnostic disable-next-line
      local mock_user_conf = {
        path = "somepath",
        fallback = "some fallback",
        exclude = { "this", "that", "third" },
      }
      local err = config.validate_user_config(mock_user_conf)
      assert(err == "")
    end)

    it("validates empty user opts with no errors", function()
      local config = require("huez.config")
      local mock_user_conf = {} ---@diagnostic disable-line
      local err = config.validate_user_config(mock_user_conf)
      assert(err == "")
    end)

    it("errors if validatation fails", function()
      local config = require("huez.config")
      local mock_user_conf = { ---@diagnostic disable-line
        path = 1,
        fallback = "default",
        exclude = { "this", "that", "third" },
      }
      local err = config.validate_user_config(mock_user_conf)
      assert(err == "Huez.Config.path: expected string, got number")
    end)
  end)

  describe("SETUP:", function()
    local test_path = vim.fs.normalize("~/testdir")
    local test_file_name = "/huez_colorscheme_test"
    after_each(function()
      os.remove(vim.fs.normalize(test_path .. test_file_name))
    end)

    it("can fall back if the file doesn't exist", function()
      local config = require("huez.config")
      -- test setup
      config.set_user_opts({ path = test_path, fallback = "ron", exclude = {} })
      config.user.huez_colorscheme_file = test_path .. test_file_name

      -- actual test
      config.handle_huez_colorscheme()
      assert(vim.g.colors_name == "ron")
    end)

    it("can fall back if the read contents the from file is nil", function()
      local config = require("huez.config")
      -- test setup
      config.set_user_opts({ path = test_path, fallback = "ron", exclude = {} })
      config.user.huez_colorscheme_file = test_path .. test_file_name
      local file = io.open(config.user.huez_colorscheme_file, "w")
      if not file then
        error("Error: opening file for writing")
        return
      end
      file:write("")
      file:close()

      file = io.open(config.user.huez_colorscheme_file, "r")
      if not file then
        return error("Error: opening file for writing")
      end
      local content = file:read("*l")
      file:close()

      -- actual test
      assert(content == nil)
      config.handle_huez_colorscheme()
      assert(vim.g.colors_name == "ron")
    end)

    it("can fall back if colorscheme on file can't be loaded", function()
      local config = require("huez.config")
      -- test setup
      config.set_user_opts({ path = test_path, fallback = "ron", exclude = {} })
      config.user.huez_colorscheme_file = test_path .. test_file_name
      local file = io.open(config.user.huez_colorscheme_file, "w")
      if not file then
        return error("Error: opening file for writing")
      end
      file:write("does_not_exist")
      file:close()

      file = io.open(config.user.huez_colorscheme_file, "r")
      if not file then
        return error("Error: opening file for writing")
      end
      local content = file:read("*l")
      file:close()

      -- actual test
      assert(content == "does_not_exist")
      config.handle_huez_colorscheme()
      assert(vim.g.colors_name == "ron")
    end)

    it("can properly load persistent colorscheme if it's valid/found, and the file exists", function()
      local config = require("huez.config")
      config.set_user_opts({ path = test_path, exclude = {} })
      config.user.huez_colorscheme_file = test_path .. test_file_name
      local file = io.open(config.user.huez_colorscheme_file, "w")
      if not file then
        return error("Error: opening file for writing")
      end
      file:write("ron")
      file:close()

      -- actual test
      config.handle_huez_colorscheme()
      assert(vim.g.colors_name == "ron")
    end)
  end)
end)
