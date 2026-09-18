local function get(c)
  local g = c.git
  return {
    DiffAdd = { bg = g.add_bg },
    DiffChange = { bg = c.ui.hover },
    DiffDelete = { fg = g.del_fg, bg = g.del_bg },
    DiffText = { bg = g.add_text },
    DiffTextAdd = { bg = g.add_text },

    GitSignsAdd = { fg = g.add_gutter },
    GitSignsChange = { fg = g.change_gutter },
    GitSignsDelete = { fg = g.delete_gutter },
    GitSignsTopdelete = { fg = g.delete_gutter },
    GitSignsChangedelete = { fg = g.change },
    GitSignsUntracked = { fg = g.add },
    GitSignsAddNr = { fg = g.add },
    GitSignsChangeNr = { fg = g.change },
    GitSignsDeleteNr = { fg = g.delete },
    GitSignsAddLn = { bg = g.add_bg },
    GitSignsChangeLn = { bg = c.ui.hover },
    GitSignsDeleteLn = { bg = g.del_bg },
    GitSignsStagedAdd = { fg = g.add },
    GitSignsStagedChange = { fg = g.change },
    GitSignsStagedDelete = { fg = g.delete },

    GitGutterAdd = { fg = g.add_gutter },
    GitGutterChange = { fg = g.change_gutter },
    GitGutterDelete = { fg = g.delete_gutter },

    diffAdded = { fg = g.add_fg },
    diffRemoved = { fg = g.del_fg },
    diffChanged = { fg = g.change_fg },
    diffOldFile = { fg = g.del_fg },
    diffNewFile = { fg = g.add_fg },
    diffFile = { fg = c.syn.constant },
    diffLine = { fg = c.syn.func, bold = true },
    diffIndexLine = { fg = c.syn.constant },
  }
end

return { get = get }
