# vscode2026.nvim

Neovim port of VS Code's **Dark 2026** and **Light 2026** themes.

```vim
:colorscheme dark2026
:colorscheme light2026
```

Those colorscheme names match the VS Code theme names and **do not change**.
The Lua module is `vscode2026`:

```lua
require('vscode2026').setup {}
vim.cmd.colorscheme 'dark2026'
```

Colors are resolved from `microsoft/vscode` with full JSON inheritance:

```
2026-dark.json  → dark_modern.json  → dark_plus.json  → dark_vs.json
2026-light.json → light_modern.json → light_plus.json → light_vs.json
```

This is not a GitHub-Dark recolor with a light variant. UI colors come from the 2026 theme files. Syntax keeps the 2026 GitHub-style rules **and** the more specific Dark+/Light+ / VS rules that still win in VS Code.

Dark and Light share one semantic vocabulary (`keyword_control`, `string`, `number`, `type`, …). Only the palette chooses a HEX per style, so switching themes feels like changing the lighting, not installing a different colorscheme.

## Install

### lazy.nvim

```lua
{
  'jd4n14/vscode2026.nvim',
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
require('vscode2026').setup {
  transparent = false,
  italic_comments = false, -- VS Code 2026 comments are not italic
  plugins = true,
}
vim.cmd.colorscheme 'dark2026'
```

`require('dark2026')` still works as a compatibility shim.

### packer.nvim

```lua
use 'jd4n14/vscode2026.nvim'
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

Dark and Light use the same roles. HEX values differ so contrast stays correct:

| Role | Dark | Light | Family |
|---|---|---|---|
| editor bg | `#121314` | `#FFFFFF` | canvas |
| chrome | `#191A1B` | `#FAFAFD` | chrome |
| accent | `#3994BC` | `#0069CC` | accent |
| comment | `#8b949e` | `#6e7781` | gray |
| string | `#a5d6ff` | `#0a3069` | blue |
| keyword (`const`, `fn`, `class`) | `#ff7b72` | `#cf222e` | red |
| control flow (`if`, `return`, `SELECT`) | `#C586C0` | `#AF00DB` | purple |
| function | `#d2a8ff` | `#8250df` | violet |
| builtin function | `#DCDCAA` | `#795E26` | gold |
| type / module | `#4EC9B0` | `#267f99` | cyan |
| number | `#b5cea8` | `#098658` | green |
| identifier | `#c9d1d9` | `#1f2328` | foreground |
| parameter / decorator | `#ffa657` | `#953800` | orange |
| tag | `#7ee787` | `#116329` | green |

Tree-sitter identifiers stay foreground even when VS Code's TextMate grammar would paint a word like `data` as a keyword. SQL is the clearest example: `SELECT` / `FROM` / `WHERE` are `keyword_control`; table names are `type` when captured as types; columns stay identifiers.

See [docs/MAPPING.md](docs/MAPPING.md) and [docs/FIDELITY.md](docs/FIDELITY.md).

## Layout

```
lua/vscode2026/
  palette.lua          -- semantic roles with dark/light HEX pairs
  groups/editor.lua
  groups/syntax.lua
  groups/treesitter.lua
  groups/lsp.lua
  groups/diagnostics.lua
  groups/git.lua
  groups/terminal.lua
  groups/languages.lua
  plugins.lua
lua/dark2026/          -- require('dark2026') compatibility shims
colors/dark2026.lua    -- :colorscheme dark2026
colors/light2026.lua   -- :colorscheme light2026
vendor/vscode/         -- official JSON snapshots
```

## Verify

From the repo root:

```sh
nvim --headless -u NONE -c "set rtp+=." -c "luafile scripts/verify.lua"
```

Checks that Dark/Light share the same semantic roles, that mapping modules do not hardcode HEX, that both colorschemes load, and that SQL keeps control keywords vs identifiers.

## License

MIT. Original Neovim port by [D0nw0r](https://github.com/D0nw0r/dark2026.nvim). Theme colors from [microsoft/vscode](https://github.com/microsoft/vscode) (MIT).
