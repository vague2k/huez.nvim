## Adding colorschemes to the registry (1.0.0)

As of right now, to submit a colorscheme to the regsitry, it must meet these criteria.

- No dependencies. Huez can't handle this yet
- Should be configurable! Meaning Lua based colorschemes are much preferred

### Registry entry template

When submitting a PR for a registry entry, refer to this template

```lua
  ["name_of_the_plugin"] = {
    url = "https://github.com/user/name_of_the_plugin",
    pkgname = "name_of_the_plugin",
    colorscheme = "colorscheme_arg",
  },
```

### Entry standards

Notice how the colorscheme's plugin name (i.e `pkgname`) and the `key` in the registry are the SAME.
There is some leeway with this, but for the most part this is a hard standard.

You might also notice that there is a colorscheme field. Sometimes a colorscheme plugins `pkgname`
don't match the arguement passed to `:colorscheme`. In this case you would need to populate the colorscheme field.
Here's a good example from the registry itself

```lua
  ["vim-code-dark"] = { -- notice the key...
    url = "https://github.com/tomasiser/vim-code-dark",
    pkgname = "vim-code-dark", -- matches the pkgname
    colorscheme = "codedark", -- "codedark" would be the argument passed to `:colorscheme`
  },
```

## Closing thoughts

The standards for this is bound to change sooner or later, but if you have an idea for how we can make the registry better
Please let me know!
