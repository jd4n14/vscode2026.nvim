# dark2026.nvim

A Neovim port of the official VS Code **Dark 2026** and **Light 2026** themes.

Colors are resolved from `microsoft/vscode` with full JSON inheritance:

```
2026-dark.json  → dark_modern.json  → dark_plus.json  → dark_vs.json
2026-light.json → light_modern.json → light_plus.json → light_vs.json
```

This is not a GitHub-Dark recolor with a light variant. UI colors come from the 2026 theme files. Syntax and semantic tokens keep the 2026 GitHub-style rules **and** the more specific Dark+/Light+ / VS rules that still win in VS Code.

```vim
:colorscheme dark2026
:colorscheme light2026
```

## Install

### lazy.nvim

```lua
{
  'jd4n14/dark2026.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'dark2026'
    -- vim.cmd.colorscheme 'light2026'
  end,
}
```

Optional setup (all keys are optional):

```lua
require('dark2026').setup {
  transparent = false,
  italic_comments = false, -- VS Code 2026 comments are not italic
  plugins = true,
}
vim.cmd.colorscheme 'dark2026'
```

### packer.nvim

```lua
use 'jd4n14/dark2026.nvim'
```

Then `:colorscheme dark2026` or `:colorscheme light2026`.

## What this port maps

- Neovim UI: Normal, floats, pmenu, search, visual, tabs, statusline, winbar
- Treesitter captures (current + older aliases)
- LSP semantic tokens and modifiers
- Diagnostics, diff, gitsigns
- Terminal ANSI colors (VS Code defaults; 2026 does not override them)
- Markdown, HTML/JSX/TSX, JSON, CSS, TS/JS, Go, Rust, Python, Java, C/C++, Lua, SQL

Plugin groups (kept out of the core modules):

- blink.cmp, nvim-cmp
- telescope.nvim, snacks.nvim, fzf-lua
- bufferline.nvim, which-key.nvim, gitsigns.nvim
- nvim-tree, neo-tree, oil.nvim
- lazy.nvim, mason.nvim
- indent-blankline, nvim-notify, trouble.nvim
- flash.nvim, mini.nvim (stable subset), nvim-dap
- lualine themes: `dark2026` / `light2026`

```lua
require('lualine').setup {
  options = { theme = 'dark2026' }, -- or 'light2026'
}
```

## Syntax, as VS Code actually renders it

2026's `tokenColors` are GitHub-style, but they **include** Dark+ / Dark VS. More specific selectors from the parent still apply.

| Role | Dark | Light | Source |
|---|---|---|---|
| editor bg | `#121314` | `#FFFFFF` | 2026 `editor.background` |
| chrome | `#191A1B` | `#FAFAFD` | 2026 sidebar/status/panel |
| accent | `#3994BC` | `#0069CC` | 2026 |
| comment | `#8b949e` | `#6e7781` | 2026 |
| string | `#a5d6ff` | `#0a3069` | 2026 |
| keyword (`const`, `fn`, `class`) | `#ff7b72` | `#cf222e` | 2026 `storage` / `keyword` |
| control flow (`if`, `return`, `use`) | `#C586C0` | `#AF00DB` | Dark+/Light+ `keyword.control` |
| function | `#d2a8ff` | `#8250df` | 2026 `entity.name.function` |
| builtin function | `#DCDCAA` | `#795E26` | Dark+/Light+ `support.function` |
| type | `#4EC9B0` | `#267f99` | Dark+/Light+ `entity.name.type` |
| number | `#b5cea8` | `#098658` | Dark VS `constant.numeric` |
| parameter / decorator | `#ffa657` | `#953800` | 2026 `variable` / `entity.name` |
| tag | `#7ee787` | `#116329` | 2026 |

See [docs/MAPPING.md](docs/MAPPING.md) and [docs/FIDELITY.md](docs/FIDELITY.md).

## Layout

```
lua/dark2026/
  palette.lua          -- dark + light palettes
  groups/editor.lua
  groups/syntax.lua
  groups/treesitter.lua
  groups/lsp.lua
  groups/diagnostics.lua
  groups/git.lua
  groups/terminal.lua
  groups/languages.lua
  plugins.lua
colors/dark2026.lua
colors/light2026.lua
```

## License

MIT. Original Neovim port by [D0nw0r](https://github.com/D0nw0r/dark2026.nvim). Theme colors from [microsoft/vscode](https://github.com/microsoft/vscode) (MIT).
