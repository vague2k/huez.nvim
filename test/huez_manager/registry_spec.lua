local r = require("huez_manager.manage.registry")

describe("HUEZ-MANAGER: registry", function()
  it("entry follows the lazy plugin spec", function()
    local function validate_spec(url, opts, pkgname)
      vim.validate({
        url = { url, "string" },
        opts = { opts, "table" },
        pkgname = { pkgname, "string" },
      })
    end

    for _, entry in pairs(r) do
      validate_spec(entry.url, entry.opts, entry.pkgname)
    end
  end)
end)
