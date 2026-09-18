local function get(c, cfg)
  local ui = c.ui
  local bg = cfg.transparent and 'NONE' or ui.bg
  local chrome = cfg.transparent and 'NONE' or ui.bg_chrome
  local menu = ui.bg_menu

  return {
    Normal = { fg = ui.fg, bg = bg },
    NormalNC = { fg = ui.fg, bg = bg },
    NormalFloat = { fg = ui.fg_ui, bg = menu },
    FloatBorder = { fg = ui.border_strong, bg = menu },
    FloatTitle = { fg = ui.fg_ui, bg = menu, bold = true },
    FloatFooter = { fg = ui.fg_dim, bg = menu },
    FloatShadow = { bg = '#000000', blend = 80 },
    FloatShadowThrough = { bg = '#000000', blend = 100 },

    NonText = { fg = ui.fg_muted },
    EndOfBuffer = { fg = bg },
    Whitespace = { fg = ui.whitespace },
    SpecialKey = { fg = ui.fg_muted },
    Conceal = { fg = ui.fg_dim },

    Cursor = { fg = ui.bg, bg = ui.cursor },
    lCursor = { fg = ui.bg, bg = ui.cursor },
    CursorIM = { fg = ui.bg, bg = ui.cursor },
    TermCursor = { fg = ui.bg, bg = ui.cursor },
    CursorLine = { bg = ui.bg_hover },
    CursorColumn = { bg = ui.bg_hover },
    ColorColumn = { bg = ui.bg_hover },
    LineNr = { fg = ui.linenr },
    LineNrAbove = { fg = ui.linenr },
    LineNrBelow = { fg = ui.linenr },
    CursorLineNr = { fg = ui.linenr_active, bold = true },
    CursorLineSign = { bg = ui.bg_hover },
    CursorLineFold = { fg = ui.fg_dim, bg = ui.bg_hover },
    SignColumn = { fg = ui.linenr, bg = bg },
    FoldColumn = { fg = ui.fg_muted, bg = bg },
    Folded = { fg = ui.fg_dim, bg = ui.bg_hover },

    Visual = { bg = ui.selection },
    VisualNOS = { bg = ui.selection_inactive },
    Search = { bg = ui.find_other },
    IncSearch = { fg = ui.white, bg = ui.accent },
    CurSearch = { fg = ui.white, bg = ui.accent },
    Substitute = { fg = ui.white, bg = ui.accent },
    MatchParen = { bg = ui.match_paren, bold = true },

    StatusLine = { fg = ui.fg_dim, bg = chrome },
    StatusLineNC = { fg = ui.fg_muted, bg = chrome },
    StatusLineTerm = { fg = ui.fg_dim, bg = chrome },
    StatusLineTermNC = { fg = ui.fg_muted, bg = chrome },
    WinBar = { fg = ui.fg_dim, bg = bg },
    WinBarNC = { fg = ui.fg_muted, bg = bg },
    WinSeparator = { fg = ui.border, bg = bg },
    VertSplit = { fg = ui.border, bg = bg },
    TabLine = { fg = ui.fg_dim, bg = chrome },
    TabLineFill = { bg = chrome },
    TabLineSel = { fg = ui.fg_ui, bg = bg, sp = ui.accent, underline = true },

    Pmenu = { fg = ui.fg_ui, bg = menu },
    PmenuSel = { fg = ui.white, bg = ui.picker_sel },
    PmenuSbar = { bg = ui.bg_hover },
    PmenuThumb = { bg = ui.scroll },
    PmenuKind = { fg = c.syn.func, bg = menu },
    PmenuKindSel = { fg = ui.white, bg = ui.picker_sel },
    PmenuExtra = { fg = ui.fg_dim, bg = menu },
    PmenuExtraSel = { fg = ui.white, bg = ui.picker_sel },
    PmenuMatch = { fg = ui.link, bold = true },
    PmenuMatchSel = { fg = ui.white, bg = ui.picker_sel, bold = true },
    PmenuBorder = { fg = ui.border_strong, bg = menu },
    WildMenu = { fg = ui.white, bg = ui.picker_sel },
    QuickFixLine = { bg = ui.list_sel },

    ErrorMsg = { fg = c.diag.error },
    WarningMsg = { fg = c.diag.warn },
    ModeMsg = { fg = ui.fg_ui, bold = true },
    MsgArea = { fg = ui.fg },
    MsgSeparator = { fg = ui.border, bg = chrome },
    MoreMsg = { fg = ui.accent },
    Question = { fg = ui.accent },
    Title = { fg = c.syn.heading, bold = true },
    Directory = { fg = ui.link },

    SpellBad = { sp = c.diag.error, undercurl = true },
    SpellCap = { sp = c.diag.warn, undercurl = true },
    SpellLocal = { sp = c.diag.info, undercurl = true },
    SpellRare = { sp = c.diag.hint, undercurl = true },

    ToolbarLine = { bg = chrome },
    ToolbarButton = { fg = ui.white, bg = ui.accent_btn },

    -- nvim 0.10+
    NormalFloatNC = { fg = ui.fg_ui, bg = menu },
    FloatBorderNC = { fg = ui.border, bg = menu },
    SnippetTabstop = { bg = ui.selection_word },
    ComplMatchIns = { fg = ui.link },
  }
end

return { get = get }
