describe("CONFIG: ", function()
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

  it("errors if validatation fails and falls back to default value", function()
    local config = require("huez.config")
    local mock_user_conf = { ---@diagnostic disable-line
      path = "somepath",
      fallback = 1,
      exclude = { "this", "that", "third" },
    }
    local err = config.validate_user_config(mock_user_conf)
    config.set_user_opts(mock_user_conf)
    assert(err == "Huez.Config.fallback: expected string, got number")
    assert(config.user.fallback == "default")
  end)
end)
