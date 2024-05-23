local r = require("huez-manager.registry")

local eq = assert.are.same

describe("HUEZ-MANAGER | REGISTRY:", function()
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

  it("key names are the same as the pkgname field they represent", function()
    for k, v in pairs(r) do
      local are_same
      if k == v.pkgname then
        are_same = true
      else
        are_same = false
      end
      eq(true, are_same, k .. " does not match " .. v.pkgname)
    end
  end)
end)
