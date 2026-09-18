# VS Code → Neovim mapping

Source of truth: merged `tokenColors` from the 2026 theme include chain, plus VS Code's default semantic-token probe scopes (`tokenClassificationRegistry.ts`).

Child theme `colors` replace parents. `tokenColors` are concatenated (parent first). The most specific TextMate selector wins; equal specificity uses the later rule.

## Semantic tokens

VS Code maps each semantic type to TextMate probe scopes when the theme has no `semanticTokenColors` entry. 2026 only inherits a handful of Dark+ literals (`newOperator`, `stringLiteral`, …), so almost everything is probe-based.

| Semantic type | Probe scopes | Dark | Light | Neovim |
|---|---|---|---|---|
| comment | `comment` | `#8b949e` | `#6e7781` | `@lsp.type.comment`, `@comment` |
| string | `string` | `#a5d6ff` | `#0a3069` | `@lsp.type.string`, `@string` |
| keyword | `keyword.control` | `#C586C0` | `#AF00DB` | `@lsp.type.keyword` (control), `@keyword.conditional` |
| number | `constant.numeric` | `#b5cea8` | `#098658` | `@lsp.type.number`, `@number` |
| function / method | `entity.name.function` | `#d2a8ff` | `#8250df` | `@lsp.type.function`, `@function` |
| function.defaultLibrary | `support.function` | `#DCDCAA` | `#795E26` | `@lsp.typemod.function.defaultLibrary`, `@function.builtin` |
| type / class / interface / enum / namespace | `entity.name.type`, `support.type`, `entity.name.namespace` | `#4EC9B0` | `#267f99` | `@lsp.type.type`, `@type`, `@module` |
| variable | `variable.other.readwrite` | `#c9d1d9` | `#1f2328` | `@lsp.type.variable`, `@variable` |
| parameter | `variable.parameter` → 2026 `variable` | `#ffa657` | `#953800` | `@lsp.type.parameter`, `@variable.parameter` |
| property | `variable.other.property` | `#c9d1d9` | `#1f2328` | `@lsp.type.property`, `@variable.member` |
| enumMember / variable.readonly | `variable.other.enummember` / `variable.other.constant` | `#79c0ff` | `#0550ae` | `@lsp.type.enumMember`, `@constant` |
| macro | `entity.name.function.preprocessor` | `#569cd6` | `#0000ff` | `@lsp.type.macro`, `@function.macro` |
| decorator | `entity.name.decorator` | `#ffa657` | `#953800` | `@lsp.type.decorator`, `@attribute` |
| operator | `keyword.operator` | `#d4d4d4` | `#000000` | `@operator` |

## TextMate → Treesitter

| VS Code scope | Neovim |
|---|---|
| `comment` | `@comment`, `Comment` |
| `string` | `@string`, `String` |
| `constant.numeric` | `@number` |
| `constant.language` | `@boolean`, `@constant.builtin` |
| `keyword` / `storage` / `storage.type` | `@keyword`, `@keyword.function`, `@keyword.type` |
| `keyword.control` | `@keyword.conditional`, `@keyword.repeat`, `@keyword.return`, `@keyword.import`, `@keyword.exception` |
| `storage.modifier` | `@keyword.modifier` |
| `keyword.operator` | `@operator` |
| `keyword.operator.wordlike` | `@keyword.operator` |
| `entity.name.function` | `@function`, `@function.method` |
| `support.function` | `@function.builtin` |
| `entity.name.type` / `support.type` / `support.class` | `@type`, `@type.builtin`, `@constructor` |
| `entity.name.tag` / `support.class.component` | `@tag` |
| `entity.other.attribute-name` | `@tag.attribute` |
| `punctuation.definition.tag` | `@tag.delimiter` |
| `variable.other` | `@variable` |
| `variable.language` | `@variable.builtin` |
| `support.type.property-name.json` | `@property.json` |
| `support.type.property-name` (CSS) | `@property.css` |
| `entity.other.attribute-name.class.css` | `@type.css` |
| `markup.heading` | `@markup.heading` |
| `markup.quote` | `@markup.quote` |
| `markup.inline.raw` | `@markup.raw` |
| `punctuation.definition.list.begin.markdown` | `@markup.list` |
| `punctuation.section.embedded` | `@punctuation.special` |
| `markup.inserted` / `deleted` / `changed` | `@diff.plus` / `@diff.minus` / `@diff.delta` |

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
