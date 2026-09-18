local function get(c)
  local d = c.diag
  return {
    DiagnosticError = { fg = d.error },
    DiagnosticWarn = { fg = d.warn },
    DiagnosticInfo = { fg = d.info },
    DiagnosticHint = { fg = d.hint },
    DiagnosticOk = { fg = d.ok },
    DiagnosticUnnecessary = { fg = c.ui.fg_muted },
    DiagnosticDeprecated = { fg = c.syn.deprecated, strikethrough = true },

    DiagnosticUnderlineError = { sp = d.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = d.warn, undercurl = true },
    DiagnosticUnderlineInfo = { sp = d.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = d.hint, undercurl = true },
    DiagnosticUnderlineOk = { sp = d.ok, undercurl = true },

    DiagnosticVirtualTextError = { fg = d.error, bg = d.error_bg },
    DiagnosticVirtualTextWarn = { fg = d.warn, bg = d.warn_bg },
    DiagnosticVirtualTextInfo = { fg = d.info, bg = d.info_bg },
    DiagnosticVirtualTextHint = { fg = d.hint },
    DiagnosticVirtualTextOk = { fg = d.ok },

    DiagnosticFloatingError = { fg = d.error },
    DiagnosticFloatingWarn = { fg = d.warn },
    DiagnosticFloatingInfo = { fg = d.info },
    DiagnosticFloatingHint = { fg = d.hint },
    DiagnosticFloatingOk = { fg = d.ok },

    DiagnosticSignError = { fg = d.error },
    DiagnosticSignWarn = { fg = d.warn },
    DiagnosticSignInfo = { fg = d.info },
    DiagnosticSignHint = { fg = d.hint },
    DiagnosticSignOk = { fg = d.ok },

    DiagnosticVirtualLinesError = { fg = d.error },
    DiagnosticVirtualLinesWarn = { fg = d.warn },
    DiagnosticVirtualLinesInfo = { fg = d.info },
    DiagnosticVirtualLinesHint = { fg = d.hint },
  }
end

return { get = get }
