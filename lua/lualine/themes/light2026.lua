local p = require('vscode2026.palette').get 'light'
local ui, g, s = p.ui, p.git, p.syn

return {
  normal = {
    a = { fg = ui.white, bg = ui.accent_btn, gui = 'bold' },
    b = { fg = ui.fg_ui, bg = ui.bg_hover },
    c = { fg = ui.fg_dim, bg = ui.bg_chrome },
  },
  insert = {
    a = { fg = ui.white, bg = g.add, gui = 'bold' },
    b = { fg = ui.fg_ui, bg = ui.bg_hover },
    c = { fg = ui.fg_dim, bg = ui.bg_chrome },
  },
  visual = {
    a = { fg = ui.white, bg = s.func, gui = 'bold' },
    b = { fg = ui.fg_ui, bg = ui.bg_hover },
    c = { fg = ui.fg_dim, bg = ui.bg_chrome },
  },
  replace = {
    a = { fg = ui.white, bg = s.keyword, gui = 'bold' },
    b = { fg = ui.fg_ui, bg = ui.bg_hover },
    c = { fg = ui.fg_dim, bg = ui.bg_chrome },
  },
  command = {
    a = { fg = ui.white, bg = s.decorator, gui = 'bold' },
    b = { fg = ui.fg_ui, bg = ui.bg_hover },
    c = { fg = ui.fg_dim, bg = ui.bg_chrome },
  },
  terminal = {
    a = { fg = ui.white, bg = ui.accent, gui = 'bold' },
    b = { fg = ui.fg_ui, bg = ui.bg_hover },
    c = { fg = ui.fg_dim, bg = ui.bg_chrome },
  },
  inactive = {
    a = { fg = ui.fg_dim, bg = ui.bg_chrome },
    b = { fg = ui.fg_muted, bg = ui.bg_chrome },
    c = { fg = ui.fg_muted, bg = ui.bg_chrome },
  },
}
