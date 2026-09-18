-- Semantic palettes for VS Code Dark 2026 and Light 2026.
--
-- Source of truth: microsoft/vscode theme inheritance
--   2026-dark.json  -> dark_modern.json  -> dark_plus.json  -> dark_vs.json
--   2026-light.json -> light_modern.json -> light_plus.json -> light_vs.json
-- Child `colors` override parents. `tokenColors` concatenate; more specific
-- TextMate selectors win, otherwise the later (child) rule wins.
--
-- HEX lives only here. Treesitter, LSP, syntax, and language groups pick
-- roles (`s.keyword_control`, `s.string`, …), never style-specific colors.
-- Dark and Light share the same roles; HEX differs so contrast stays correct
-- on each background. Switching `:colorscheme dark2026` ↔ `light2026` is a
-- lighting change of the same theme.

local U = require 'vscode2026.util'

-- A role is `{ dark = '#…', light = '#…' [, onto = '<role>' ] }`.
-- `onto` composites 8-digit HEX onto another resolved role in the same
-- section (or onto extras.bg for git overlays).
-- `family` documents the chromatic category that must stay aligned across
-- styles. `inherited` marks leftover Dark+/Light VS rules that 2026 did not
-- override — those HEX pairs can diverge because they match VS Code.

local UI = {
  bg = { dark = '#121314', light = '#FFFFFF' },
  bg_chrome = { dark = '#191A1B', light = '#FAFAFD' },
  bg_menu = { dark = '#202122', light = '#FAFAFD' },
  bg_hover = { dark = '#242526', light = '#EAEAEA40', onto = 'bg' },
  bg_active = { dark = '#313233', light = '#D6D6D6' },
  bg_input = { dark = '#191A1B', light = '#FFFFFF' },
  fg = { dark = '#BBBEBF', light = '#202020' },
  fg_ui = { dark = '#bfbfbf', light = '#202020' },
  fg_bright = { dark = '#ededed', light = '#202020' },
  fg_dim = { dark = '#8C8C8C', light = '#606060' },
  fg_muted = { dark = '#555555', light = '#BBBBBB' },
  white = { dark = '#FFFFFF', light = '#FFFFFF' },
  border = { dark = '#2A2B2C', light = '#F0F1F2' },
  border_strong = { dark = '#333536', light = '#E4E5E6' },
  accent = { dark = '#3994BC', light = '#0069CC' },
  accent_btn = { dark = '#297AA0', light = '#0069CC' },
  accent_badge = { dark = '#307E9F', light = '#0069CC' },
  link = { dark = '#48A0C7', light = '#0069CC' },
  cursor = { dark = '#BBBEBF', light = '#202020' },
  linenr = { dark = '#858889', light = '#606060' },
  linenr_active = { dark = '#BBBEBF', light = '#202020' },
  selection = { dark = '#276782dd', light = '#0069CC40', onto = 'bg' },
  selection_inactive = { dark = '#27678260', light = '#0069CC1A', onto = 'bg' },
  selection_word = { dark = '#27678250', light = '#0069CC26', onto = 'bg' },
  find = { dark = '#27678290', light = '#0069CC40', onto = 'bg' },
  find_other = { dark = '#27678280', light = '#0069CC1A', onto = 'bg' },
  hover = { dark = '#FFFFFF13', light = '#00000015', onto = 'bg' },
  list_sel = { dark = '#FFFFFF22', light = '#00000025', onto = 'bg_chrome' },
  list_hover = { dark = '#FFFFFF14', light = '#00000014', onto = 'bg_chrome' },
  pmenu_sel = { dark = '#FFFFFF26', light = '#00000025', onto = 'bg_menu' },
  picker_sel = { dark = '#297AA0', light = '#0069CC' },
  match_paren = { dark = '#3994BC55', light = '#0069CC40', onto = 'bg' },
  indent = { dark = '#8384854D', light = '#F7F7F740', onto = 'bg' },
  indent_active = { dark = '#838485', light = '#EEEEEE' },
  whitespace = { dark = '#8C8C8C4D', light = '#60606040', onto = 'bg' },
  scroll = { dark = '#A8A9AA85', light = '#646464C0', onto = 'bg_menu' },
}

-- Syntax / semantic token roles. Groups must use these names, not HEX.
local SYN = {
  fg = { dark = '#c9d1d9', light = '#1f2328', family = 'fg' },
  comment = { dark = '#8b949e', light = '#6e7781', family = 'gray' },
  string = { dark = '#a5d6ff', light = '#0a3069', family = 'blue' },
  -- constant.character.escape (Dark+/Light+)
  string_escape = { dark = '#d7ba7d', light = '#EE0000', family = 'inherited' },
  regexp = { dark = '#a5d6ff', light = '#0a3069', family = 'blue' },
  regexp_escape = { dark = '#7ee787', light = '#116329', family = 'green' },
  -- constant.numeric (Dark/Light VS, more specific than 2026 `constant`)
  number = { dark = '#b5cea8', light = '#098658', family = 'green' },
  -- constant.language
  boolean = { dark = '#569cd6', light = '#0000ff', family = 'blue' },
  constant = { dark = '#79c0ff', light = '#0550ae', family = 'blue' },
  -- storage / generic keyword (2026)
  keyword = { dark = '#ff7b72', light = '#cf222e', family = 'red' },
  -- keyword.control (Dark+/Light+)
  keyword_control = { dark = '#C586C0', light = '#AF00DB', family = 'purple' },
  -- storage.modifier / wordlike operators
  keyword_modifier = { dark = '#569cd6', light = '#0000ff', family = 'blue' },
  func = { dark = '#d2a8ff', light = '#8250df', family = 'violet' },
  -- support.function (Dark+/Light+)
  func_builtin = { dark = '#DCDCAA', light = '#795E26', family = 'gold' },
  -- entity.name.type / support.type
  type = { dark = '#4EC9B0', light = '#267f99', family = 'cyan' },
  -- variable.other
  variable = { dark = '#c9d1d9', light = '#1f2328', family = 'fg' },
  -- semantic parameter -> variable.parameter -> 2026 `variable`
  parameter = { dark = '#ffa657', light = '#953800', family = 'orange' },
  -- variable.other.property
  property = { dark = '#c9d1d9', light = '#1f2328', family = 'fg' },
  member = { dark = '#79c0ff', light = '#0550ae', family = 'blue' },
  tag = { dark = '#7ee787', light = '#116329', family = 'green' },
  tag_delimiter = { dark = '#808080', light = '#800000', family = 'inherited' },
  -- entity.other.attribute-name (Dark/Light VS leftover)
  attribute = { dark = '#9cdcfe', light = '#e50000', family = 'inherited' },
  css_class = { dark = '#d7ba7d', light = '#800000', family = 'inherited' },
  css_property = { dark = '#9cdcfe', light = '#e50000', family = 'inherited' },
  json_key = { dark = '#7ee787', light = '#116329', family = 'green' },
  -- entity.name.namespace
  module = { dark = '#4EC9B0', light = '#267f99', family = 'cyan' },
  -- entity.name.function.preprocessor
  macro = { dark = '#569cd6', light = '#0000ff', family = 'blue' },
  -- entity.name / entity.name.decorator
  decorator = { dark = '#ffa657', light = '#953800', family = 'orange' },
  preprocessor = { dark = '#569cd6', light = '#0000ff', family = 'blue' },
  -- keyword.operator
  operator = { dark = '#d4d4d4', light = '#000000', family = 'fg' },
  punctuation = { dark = '#c9d1d9', light = '#1f2328', family = 'fg' },
  -- punctuation.section.embedded (2026)
  embedded = { dark = '#ff7b72', light = '#cf222e', family = 'red' },
  heading = { dark = '#79c0ff', light = '#0550ae', family = 'blue' },
  quote = { dark = '#7ee787', light = '#116329', family = 'green' },
  list = { dark = '#ffa657', light = '#953800', family = 'orange' },
  raw = { dark = '#79c0ff', light = '#0550ae', family = 'blue' },
  link_text = { dark = '#a5d6ff', light = '#0a3069', family = 'blue' },
  invalid = { dark = '#ffa198', light = '#82071e', family = 'red' },
  deprecated = { dark = '#ffa198', light = '#82071e', family = 'red' },
}

local DIAG = {
  error = { dark = '#f48771', light = '#ad0707' },
  warn = { dark = '#e5ba7d', light = '#667309' },
  info = { dark = '#3a94bc', light = '#0069CC' },
  hint = { dark = '#48A0C7', light = '#0069CC' },
  debug = { dark = '#B267E6', light = '#652D90' },
  ok = { dark = '#73c991', light = '#587c0c' },
  error_bg = { dark = '#3A1D1D', light = '#FDEDED' },
  warn_bg = { dark = '#352A05', light = '#FDF6E3' },
  info_bg = { dark = '#1E3A47', light = '#E6F2FA' },
  warn_icon = { dark = '#CCA700', light = '#B69500' },
}

local GIT = {
  add = { dark = '#73c991', light = '#587c0c' },
  add_gutter = { dark = '#72C892', light = '#587c0c' },
  change = { dark = '#e5ba7d', light = '#667309' },
  -- editorGutter.modifiedBackground (dark_modern leftover / light_modern)
  change_gutter = { dark = '#0078D4', light = '#005FB8' },
  delete = { dark = '#f48771', light = '#ad0707' },
  delete_gutter = { dark = '#F28772', light = '#ad0707' },
  ignore = { dark = '#8C8C8C', light = '#8E8E90' },
  conflict = { dark = '#f48771', light = '#ad0707' },
  add_bg = { dark = '#347d3926', light = '#587c0c26', onto = 'bg' },
  add_text = { dark = '#57ab5a4d', light = '#587c0c26', onto = 'bg' },
  del_bg = { dark = '#c93c3726', light = '#ad070726', onto = 'bg' },
  del_text = { dark = '#f470674d', light = '#ad070726', onto = 'bg' },
  add_fg = { dark = '#7ee787', light = '#116329' },
  del_fg = { dark = '#ffa198', light = '#82071e' },
  change_fg = { dark = '#ffa657', light = '#953800' },
}

-- VS Code terminalColorRegistry.ts defaults (2026 does not set terminal.ansi*).
local TERM = {
  black = { dark = '#000000', light = '#000000' },
  red = { dark = '#cd3131', light = '#cd3131' },
  green = { dark = '#0DBC79', light = '#107C10' },
  yellow = { dark = '#e5e510', light = '#949800' },
  blue = { dark = '#2472c8', light = '#0451a5' },
  magenta = { dark = '#bc3fbc', light = '#bc05bc' },
  cyan = { dark = '#11a8cd', light = '#0598bc' },
  white = { dark = '#e5e5e5', light = '#555555' },
  bright_black = { dark = '#666666', light = '#666666' },
  bright_red = { dark = '#f14c4c', light = '#f14c4c' },
  bright_green = { dark = '#23d18b', light = '#14CE14' },
  bright_yellow = { dark = '#f5f543', light = '#b5ba00' },
  bright_blue = { dark = '#3b8eea', light = '#3b8eea' },
  bright_magenta = { dark = '#d670d6', light = '#d670d6' },
  bright_cyan = { dark = '#29b8db', light = '#29b8db' },
  bright_white = { dark = '#e5e5e5', light = '#a5a5a5' },
}

local function sorted_keys(tbl)
  local keys = {}
  for k in pairs(tbl) do
    keys[#keys + 1] = k
  end
  table.sort(keys)
  return keys
end

local function resolve(defs, style, extras)
  if style ~= 'dark' and style ~= 'light' then
    error("palette style must be 'dark' or 'light', got " .. tostring(style))
  end

  local out = {}
  local missing = {}
  for name, pair in pairs(defs) do
    if type(pair) ~= 'table' or pair[style] == nil then
      missing[#missing + 1] = name
    elseif not pair.onto then
      out[name] = pair[style]
    end
  end
  if #missing > 0 then
    table.sort(missing)
    error('palette roles missing ' .. style .. ': ' .. table.concat(missing, ', '))
  end

  for name, pair in pairs(defs) do
    if pair.onto then
      local base = out[pair.onto] or (extras and extras[pair.onto])
      if not base then
        error(('palette role %s: unknown blend target %s'):format(name, pair.onto))
      end
      out[name] = U.solid(pair[style], base)
    end
  end
  return out
end

local M = {}

-- Role definitions (dark/light pairs). Used by verify.lua.
M.roles = {
  ui = UI,
  syn = SYN,
  diag = DIAG,
  git = GIT,
  term = TERM,
}

M.sections = { 'ui', 'syn', 'diag', 'git', 'term' }

function M.role_names(section)
  local defs = M.roles[section]
  if not defs then
    error('unknown palette section ' .. tostring(section))
  end
  return sorted_keys(defs)
end

function M.get(style)
  style = style == 'light' and 'light' or 'dark'
  local ui = resolve(UI, style)
  return {
    style = style,
    ui = ui,
    syn = resolve(SYN, style),
    diag = resolve(DIAG, style),
    git = resolve(GIT, style, { bg = ui.bg }),
    term = resolve(TERM, style),
  }
end

return M
