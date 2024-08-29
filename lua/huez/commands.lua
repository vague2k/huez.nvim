local colorscheme = require("huez-manager.api.colorscheme")
local config = require("huez.config")
local utils = require("huez-manager.utils")
local M = {}

---@class HuezSubcmd
---@field impl fun(args:string[], opts: table) The command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional) Command completions callback, taking the lead of the subcommand's arguments

---@type table<string, HuezSubcmd>
M.subcmds = {
  colorscheme = {
    impl = function(args, _)
      if #args == 0 then
        -- telescope picker impl here
        return
      end
      if #args > 1 then
        return utils.notify("Huez: colorscheme command only takes 1 argument", "warn")
      end
      local c = args[1]
      local ok, _ = pcall(vim.cmd.colorscheme, c)
      if not ok then
        return utils.notify("Huez: could not find the colorscheme " .. c, "error")
      end
      colorscheme.save(c)
    end,
    complete = function(subcmd_arg_lead)
      local args = colorscheme.installed(config.user.exclude)
      return vim
        .iter(args)
        :filter(function(arg)
          return arg:find(subcmd_arg_lead) ~= nil
        end)
        :totable()
    end,
  },
}

local function huez_cmd(opts)
  local fargs = opts.fargs
  local subcommand_key = fargs[1]
  -- Get the subcommand's arguments, if any
  local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
  local subcommand = M.subcmds[subcommand_key]
  if not subcommand then
    return utils.notify("Huez: Unknown command: " .. subcommand_key, "error")
  end
  -- Invoke the subcommand
  subcommand.impl(args, opts)
end

M.setup = function()
  vim.api.nvim_create_user_command("Huez", huez_cmd, {
    nargs = "+",
    complete = function(arg_lead, cmdline, _)
      -- Get the subcommand.
      local subcmd_key, subcmd_arg_lead = cmdline:match("^['<,'>]*Huez[!]*%s(%S+)%s(.*)$")
      if subcmd_key and subcmd_arg_lead and M.subcmds[subcmd_key] and M.subcmds[subcmd_key].complete then
        -- The subcommand has completions. Return them.
        return M.subcmds[subcmd_key].complete(subcmd_arg_lead)
      end
      -- Check if cmdline is a subcommand
      if cmdline:match("^['<,'>]*Huez[!]*%s+%w*$") then
        -- Filter subcommands that match
        local subcommand_keys = vim.tbl_keys(M.subcmds)
        return vim
          .iter(subcommand_keys)
          :filter(function(key)
            return key:find(arg_lead) ~= nil
          end)
          :totable()
      end
    end,
  })
end
return M
