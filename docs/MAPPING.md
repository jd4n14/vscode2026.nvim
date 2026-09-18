# VS Code → Neovim mapping

Source of truth: merged `tokenColors` from the 2026 theme include chain (snapshots in `vendor/vscode`), plus VS Code's default semantic-token probe scopes (`tokenClassificationRegistry.ts`).

Child theme `colors` replace parents. `tokenColors` are concatenated (parent first). The most specific TextMate selector wins; equal specificity uses the later rule.

## Semantic layer

`lua/vscode2026/palette.lua` defines each role once, with a dark HEX and a light HEX:

```lua
keyword_control = { dark = '#C586C0', light = '#AF00DB', family = 'purple' }
string          = { dark = '#a5d6ff', light = '#0a3069', family = 'blue' }
```

`palette.get(style)` resolves that into `c.syn.keyword_control`, `c.syn.string`, and so on.

Treesitter, LSP, Vim syntax, and language-specific groups **must not** choose Dark vs Light colors. They only pick roles:

```lua
['@keyword.conditional'] = { fg = s.keyword_control }
['@string']              = { fg = s.string }
['@number']              = { fg = s.number }
['@type']                = { fg = s.type }
['@function']            = { fg = s.func }
['@variable']            = { fg = s.variable }
```

Switching `:colorscheme dark2026` ↔ `:colorscheme light2026` therefore changes lighting, not meaning.

This is stricter than copying TextMate blindly. VS Code's SQL grammar often paints identifiers such as `data` as keywords. Tree-sitter parses that as `(field name: (identifier))`, so this port keeps it on `syn.variable` (foreground). `SELECT` / `FROM` / `WHERE` stay `keyword_control`.

## Semantic tokens

VS Code maps each semantic type to TextMate probe scopes when the theme has no `semanticTokenColors` entry. 2026 only inherits a handful of Dark+ literals (`newOperator`, `stringLiteral`, …), so almost everything is probe-based.

| Semantic type | Probe scopes | Role | Neovim |
|---|---|---|---|
| comment | `comment` | `comment` | `@lsp.type.comment`, `@comment` |
| string | `string` | `string` | `@lsp.type.string`, `@string` |
| keyword | `keyword.control` | `keyword_control` | `@lsp.type.keyword`, `@keyword.conditional` |
| number | `constant.numeric` | `number` | `@lsp.type.number`, `@number` |
| function / method | `entity.name.function` | `func` | `@lsp.type.function`, `@function` |
| function.defaultLibrary | `support.function` | `func_builtin` | `@lsp.typemod.function.defaultLibrary`, `@function.builtin` |
| type / class / interface / enum / namespace | `entity.name.type`, `support.type`, `entity.name.namespace` | `type` / `module` | `@lsp.type.type`, `@type`, `@module` |
| variable | `variable.other.readwrite` | `variable` | `@lsp.type.variable`, `@variable` |
| parameter | `variable.parameter` → 2026 `variable` | `parameter` | `@lsp.type.parameter`, `@variable.parameter` |
| property | `variable.other.property` | `property` | `@lsp.type.property`, `@variable.member` |
| enumMember / variable.readonly | `variable.other.enummember` / `variable.other.constant` | `constant` | `@lsp.type.enumMember`, `@constant` |
| macro | `entity.name.function.preprocessor` | `macro` | `@lsp.type.macro`, `@function.macro` |
| decorator | `entity.name.decorator` | `decorator` | `@lsp.type.decorator`, `@attribute` |
| operator | `keyword.operator` | `operator` | `@operator` |

HEX for each role is in `palette.lua` (dark and light together). Do not duplicate those values in mapping files.

## TextMate → Treesitter

| VS Code scope | Neovim | Role |
|---|---|---|
| `comment` | `@comment`, `Comment` | `comment` |
| `string` | `@string`, `String` | `string` |
| `constant.numeric` | `@number` | `number` |
| `constant.language` | `@boolean`, `@constant.builtin` | `boolean` |
| `keyword` / `storage` / `storage.type` | `@keyword`, `@keyword.function`, `@keyword.type` | `keyword` |
| `keyword.control` | `@keyword.conditional`, `@keyword.repeat`, `@keyword.return`, `@keyword.import`, `@keyword.exception` | `keyword_control` |
| `storage.modifier` | `@keyword.modifier` | `keyword_modifier` |
| `keyword.operator` | `@operator` | `operator` |
| `keyword.operator.wordlike` | `@keyword.operator` | `keyword_modifier` |
| `entity.name.function` | `@function`, `@function.method` | `func` |
| `support.function` | `@function.builtin` | `func_builtin` |
| `entity.name.type` / `support.type` / `support.class` | `@type`, `@type.builtin`, `@constructor` | `type` |
| `entity.name.tag` / `support.class.component` | `@tag` | `tag` |
| `entity.other.attribute-name` | `@tag.attribute` | `attribute` |
| `punctuation.definition.tag` | `@tag.delimiter` | `tag_delimiter` |
| `variable.other` | `@variable` | `variable` |
| `variable.language` | `@variable.builtin` | `constant` |
| `support.type.property-name.json` | `@property.json` | `json_key` |
| `support.type.property-name` (CSS) | `@property.css` | `css_property` |
| `entity.other.attribute-name.class.css` | `@type.css` | `css_class` |
| `markup.heading` | `@markup.heading` | `heading` |
| `markup.quote` | `@markup.quote` | `quote` |
| `markup.inline.raw` | `@markup.raw` | `raw` |
| `punctuation.definition.list.begin.markdown` | `@markup.list` | `list` |
| `punctuation.section.embedded` | `@punctuation.special` | `embedded` |
| `markup.inserted` / `deleted` / `changed` | `@diff.plus` / `@diff.minus` / `@diff.delta` | git add/del/change |

## UI

| VS Code color | Neovim |
|---|---|
| `editor.background` / `editor.foreground` | `Normal` |
| `editorWidget.background` | `NormalFloat`, `Pmenu` |
| `editor.selectionBackground` | `Visual` |
| `editor.findMatchBackground` | `IncSearch` / `CurSearch` (accent fg for the current match) |
| `editor.findMatchHighlightBackground` | `Search` |
| `editor.lineHighlightBackground` | `CursorLine` |
| `editorLineNumber.*` | `LineNr`, `CursorLineNr` |
| `editorSuggestWidget.selectedBackground` | `PmenuSel` (quick-open uses `quickInputList.focusBackground`) |
| `quickInputList.focusBackground` | `PmenuSel`, Telescope/Snacks selection |
| `tab.*` | `TabLine*` |
| `statusBar.*` | `StatusLine*` |
| `editorGutter.added/deleted/modifiedBackground` | `GitSigns*` |
| `diffEditor.inserted/removed*Background` | `DiffAdd`, `DiffDelete`, `DiffText` |
| `list.error/warningForeground` | `DiagnosticError` / `DiagnosticWarn` |
| `terminal.ansi*` (VS Code defaults) | `terminal_color_0`–`15` |
