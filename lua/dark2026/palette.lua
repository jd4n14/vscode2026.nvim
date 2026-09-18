-- Palettes resolved from microsoft/vscode theme inheritance:
--   2026-dark.json  -> dark_modern.json  -> dark_plus.json  -> dark_vs.json
--   2026-light.json -> light_modern.json -> light_plus.json -> light_vs.json
-- Child `colors` override parents. `tokenColors` are concatenated; more specific
-- TextMate selectors win, otherwise the later (child) rule wins.

local U = require 'dark2026.util'

local function dark()
  local bg = '#121314'
  local chrome = '#191A1B'
  local menu = '#202122'

  return {
    style = 'dark',
    ui = {
      bg = bg,
      bg_chrome = chrome,
      bg_menu = menu,
      bg_hover = '#242526',
      bg_active = '#313233',
      bg_input = '#191A1B',
      fg = '#BBBEBF',
      fg_ui = '#bfbfbf',
      fg_bright = '#ededed',
      fg_dim = '#8C8C8C',
      fg_muted = '#555555',
      white = '#FFFFFF',
      border = '#2A2B2C',
      border_strong = '#333536',
      accent = '#3994BC',
      accent_btn = '#297AA0',
      accent_badge = '#307E9F',
      link = '#48A0C7',
      cursor = '#BBBEBF',
      linenr = '#858889',
      linenr_active = '#BBBEBF',
      selection = U.solid('#276782dd', bg),
      selection_inactive = U.solid('#27678260', bg),
      selection_word = U.solid('#27678250', bg),
      find = U.solid('#27678290', bg),
      find_other = U.solid('#27678280', bg),
      hover = U.solid('#FFFFFF13', bg),
      list_sel = U.solid('#FFFFFF22', chrome),
      list_hover = U.solid('#FFFFFF14', chrome),
      pmenu_sel = U.solid('#FFFFFF26', menu),
      picker_sel = '#297AA0',
      match_paren = U.solid('#3994BC55', bg),
      indent = U.solid('#8384854D', bg),
      indent_active = '#838485',
      whitespace = U.solid('#8C8C8C4D', bg),
      scroll = U.solid('#A8A9AA85', menu),
    },
    syn = {
      -- GitHub-style rules from 2026-dark.json, plus more-specific Dark+/Dark VS leftovers.
      fg = '#c9d1d9',
      comment = '#8b949e',
      string = '#a5d6ff',
      string_escape = '#d7ba7d', -- constant.character.escape (dark_plus)
      regexp = '#a5d6ff',
      regexp_escape = '#7ee787',
      number = '#b5cea8', -- constant.numeric (dark_vs, more specific than 2026 `constant`)
      boolean = '#569cd6', -- constant.language (dark_vs)
      constant = '#79c0ff',
      keyword = '#ff7b72', -- storage / generic keyword (2026)
      keyword_control = '#C586C0', -- keyword.control (dark_plus)
      keyword_modifier = '#569cd6', -- storage.modifier / wordlike operators (dark_vs)
      func = '#d2a8ff',
      func_builtin = '#DCDCAA', -- support.function (dark_plus)
      type = '#4EC9B0', -- entity.name.type / support.type (dark_plus)
      variable = '#c9d1d9', -- variable.other
      parameter = '#ffa657', -- semantic parameter -> variable.parameter -> `variable`
      property = '#c9d1d9', -- variable.other.property
      member = '#79c0ff', -- fields often colored as constants/properties in LSP
      tag = '#7ee787',
      tag_delimiter = '#808080',
      attribute = '#9cdcfe', -- entity.other.attribute-name (dark_vs)
      css_class = '#d7ba7d',
      css_property = '#9cdcfe',
      json_key = '#7ee787',
      module = '#4EC9B0', -- entity.name.namespace (dark_plus)
      macro = '#569cd6', -- entity.name.function.preprocessor (dark_vs)
      decorator = '#ffa657', -- entity.name / entity.name.decorator
      preprocessor = '#569cd6',
      operator = '#d4d4d4', -- keyword.operator (dark_vs)
      punctuation = '#c9d1d9',
      embedded = '#ff7b72', -- punctuation.section.embedded (2026)
      heading = '#79c0ff',
      quote = '#7ee787',
      list = '#ffa657',
      raw = '#79c0ff',
      link_text = '#a5d6ff',
      invalid = '#ffa198',
      deprecated = '#ffa198',
    },
    diag = {
      error = '#f48771',
      warn = '#e5ba7d',
      info = '#3a94bc',
      hint = '#48A0C7',
      debug = '#B267E6',
      ok = '#73c991',
      error_bg = '#3A1D1D',
      warn_bg = '#352A05',
      info_bg = '#1E3A47',
      warn_icon = '#CCA700',
    },
    git = {
      add = '#73c991',
      add_gutter = '#72C892',
      change = '#e5ba7d',
      change_gutter = '#0078D4', -- editorGutter.modifiedBackground (dark_modern, not overridden)
      delete = '#f48771',
      delete_gutter = '#F28772',
      ignore = '#8C8C8C',
      conflict = '#f48771',
      add_bg = U.solid('#347d3926', bg),
      add_text = U.solid('#57ab5a4d', bg),
      del_bg = U.solid('#c93c3726', bg),
      del_text = U.solid('#f470674d', bg),
      add_fg = '#7ee787',
      del_fg = '#ffa198',
      change_fg = '#ffa657',
    },
    term = {
      black = '#000000',
      red = '#cd3131',
      green = '#0DBC79',
      yellow = '#e5e510',
      blue = '#2472c8',
      magenta = '#bc3fbc',
      cyan = '#11a8cd',
      white = '#e5e5e5',
      bright_black = '#666666',
      bright_red = '#f14c4c',
      bright_green = '#23d18b',
      bright_yellow = '#f5f543',
      bright_blue = '#3b8eea',
      bright_magenta = '#d670d6',
      bright_cyan = '#29b8db',
      bright_white = '#e5e5e5',
    },
  }
end

local function light()
  local bg = '#FFFFFF'
  local chrome = '#FAFAFD'
  local menu = '#FAFAFD'

  return {
    style = 'light',
    ui = {
      bg = bg,
      bg_chrome = chrome,
      bg_menu = menu,
      bg_hover = U.solid('#EAEAEA40', bg),
      bg_active = '#D6D6D6',
      bg_input = '#FFFFFF',
      fg = '#202020',
      fg_ui = '#202020',
      fg_bright = '#202020',
      fg_dim = '#606060',
      fg_muted = '#BBBBBB',
      white = '#FFFFFF',
      border = '#F0F1F2',
      border_strong = '#E4E5E6',
      accent = '#0069CC',
      accent_btn = '#0069CC',
      accent_badge = '#0069CC',
      link = '#0069CC',
      cursor = '#202020',
      linenr = '#606060',
      linenr_active = '#202020',
      selection = U.solid('#0069CC40', bg),
      selection_inactive = U.solid('#0069CC1A', bg),
      selection_word = U.solid('#0069CC26', bg),
      find = U.solid('#0069CC40', bg),
      find_other = U.solid('#0069CC1A', bg),
      hover = U.solid('#00000015', bg),
      list_sel = U.solid('#00000025', chrome),
      list_hover = U.solid('#00000014', chrome),
      pmenu_sel = U.solid('#00000025', menu),
      picker_sel = '#0069CC',
      match_paren = U.solid('#0069CC40', bg),
      indent = U.solid('#F7F7F740', bg),
      indent_active = '#EEEEEE',
      whitespace = U.solid('#60606040', bg),
      scroll = U.solid('#646464C0', menu),
    },
    syn = {
      fg = '#1f2328',
      comment = '#6e7781',
      string = '#0a3069',
      string_escape = '#EE0000',
      regexp = '#0a3069',
      regexp_escape = '#116329',
      number = '#098658',
      boolean = '#0000ff',
      constant = '#0550ae',
      keyword = '#cf222e',
      keyword_control = '#AF00DB',
      keyword_modifier = '#0000ff',
      func = '#8250df',
      func_builtin = '#795E26',
      type = '#267f99',
      variable = '#1f2328',
      parameter = '#953800',
      property = '#1f2328',
      member = '#0550ae',
      tag = '#116329',
      tag_delimiter = '#800000',
      attribute = '#e50000',
      css_class = '#800000',
      css_property = '#e50000',
      json_key = '#116329',
      module = '#267f99',
      macro = '#0000ff',
      decorator = '#953800',
      preprocessor = '#0000ff',
      operator = '#000000',
      punctuation = '#1f2328',
      embedded = '#cf222e',
      heading = '#0550ae',
      quote = '#116329',
      list = '#953800',
      raw = '#0550ae',
      link_text = '#0a3069',
      invalid = '#82071e',
      deprecated = '#82071e',
    },
    diag = {
      error = '#ad0707',
      warn = '#667309',
      info = '#0069CC',
      hint = '#0069CC',
      debug = '#652D90',
      ok = '#587c0c',
      error_bg = '#FDEDED',
      warn_bg = '#FDF6E3',
      info_bg = '#E6F2FA',
      warn_icon = '#B69500',
    },
    git = {
      add = '#587c0c',
      add_gutter = '#587c0c',
      change = '#667309',
      change_gutter = '#005FB8',
      delete = '#ad0707',
      delete_gutter = '#ad0707',
      ignore = '#8E8E90',
      conflict = '#ad0707',
      add_bg = U.solid('#587c0c26', bg),
      add_text = U.solid('#587c0c26', bg),
      del_bg = U.solid('#ad070726', bg),
      del_text = U.solid('#ad070726', bg),
      add_fg = '#116329',
      del_fg = '#82071e',
      change_fg = '#953800',
    },
    term = {
      black = '#000000',
      red = '#cd3131',
      green = '#107C10',
      yellow = '#949800',
      blue = '#0451a5',
      magenta = '#bc05bc',
      cyan = '#0598bc',
      white = '#555555',
      bright_black = '#666666',
      bright_red = '#f14c4c',
      bright_green = '#14CE14',
      bright_yellow = '#b5ba00',
      bright_blue = '#3b8eea',
      bright_magenta = '#d670d6',
      bright_cyan = '#29b8db',
      bright_white = '#a5a5a5',
    },
  }
end

local M = {}

function M.get(style)
  if style == 'light' then
    return light()
  end
  return dark()
end

return M
