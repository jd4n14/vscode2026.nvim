# Fidelity notes vs the original single-file port

The original `colors/dark2026.lua` was a hand-built Dark-only colorscheme. UI chrome was mostly taken from 2026 Dark. Syntax mixed GitHub Dark tokens with a few custom choices and did not apply VS Code include-chain specificity.

## Already faithful in the original (kept)

- Editor `#121314`, chrome `#191A1B`, menu `#202122`, accent `#3994BC`
- Selection base `#276782`
- Keyword red `#FF7B72`, function purple `#D2A8FF`, string `#A5D6FF`, comment `#8B949E`
- Types `#4EC9B0` — this is **not** invented; it is Dark+ `entity.name.type` / `support.type`, which still wins over 2026's generic `entity.name`
- HTML/JSX tags `#7EE787`
- blink.cmp / telescope / snacks / bufferline / which-key / gitsigns coverage (expanded here)

## Approximations or custom choices in the original (corrected)

| Original | Actual merged 2026 Dark | Why |
|---|---|---|
| All keywords red, including `if` / `return` / `use` | Control flow `#C586C0` (`keyword.control` from Dark+) | 2026 only sets generic `keyword`; Dark+ is more specific |
| Numbers `#79C0FF` | `#b5cea8` (`constant.numeric` from Dark VS) | Parent selector is more specific than 2026 `constant` |
| Booleans `#79C0FF` | `#569cd6` (`constant.language`) | Same specificity rule |
| Operators red | `#d4d4d4` (`keyword.operator`) | Dark VS keeps operators near the editor fg |
| Macros `#48a0c7` (UI accent) | `#569cd6` (`entity.name.function.preprocessor`) | No 2026 override |
| `@function.builtin` purple | `#DCDCAA` (`support.function`) | Dark+ builtin functions stay yellow |
| LineNr `#555555` | `#858889` | `editorLineNumber.foreground` |
| Diff backgrounds invented (`#1b3a1b`, `#2a2a4a`) | `#347d3926` / `#c93c3726` blended onto editor bg | `diffEditor.*` |
| Diagnostic error `#F44747` | `#f48771` | 2026 `errorForeground` / `list.errorForeground` |
| Markdown headings red | `#79c0ff` bold | 2026 `markup.heading` |
| Markdown italic red | syntax fg italic | 2026 `markup.italic` |
| Markdown quote = comment | `#7ee787` | 2026 `markup.quote` |
| Comments italic | not italic | 2026 does not set `fontStyle` on comments |
| Variables used editor fg `#BBBEBF` | `#c9d1d9` (`variable.other`) | GitHub syntax fg is slightly cooler than the editor fg |
| No Light 2026 | full light palette | 2026-light.json + Light+/Light VS inheritance |

## Inheritance quirks that look “wrong” but match VS Code

These are leftover Dark+/VS rules that 2026 did not override with an equally specific selector:

- `storage.modifier` (`static`, `public`, …) stays Dark+ blue (`#569cd6` / `#0000ff`)
- CSS class selectors stay Dark+ gold / maroon
- HTML attributes stay Dark+ `#9cdcfe` (dark) / `#e50000` (light)
- `new` / `delete` / word-like operators stay Dark+ blue/purple, not 2026 red
- Light 2026 HTML attributes are red because Light VS still owns `entity.other.attribute-name`

If Microsoft later adds matching 2026 rules, update `lua/dark2026/palette.lua` from the include chain rather than re-tinting by eye.

## Terminal colors

Neither 2026 JSON defines `terminal.ansi*`. Neovim terminal colors use VS Code's built-in dark/light ANSI defaults from `terminalColorRegistry.ts`.
