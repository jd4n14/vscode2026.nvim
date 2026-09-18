local function get(c, cfg)
  local s = c.syn
  return {
    Comment = { fg = s.comment, italic = cfg.italic_comments },
    SpecialComment = { fg = s.comment, italic = cfg.italic_comments },
    String = { fg = s.string },
    Character = { fg = s.string },
    Number = { fg = s.number },
    Float = { fg = s.number },
    Boolean = { fg = s.boolean },
    Constant = { fg = s.constant },

    Identifier = { fg = s.variable },
    Function = { fg = s.func },

    Statement = { fg = s.keyword_control },
    Conditional = { fg = s.keyword_control },
    Repeat = { fg = s.keyword_control },
    Label = { fg = s.keyword },
    Operator = { fg = s.operator },
    Keyword = { fg = s.keyword },
    Exception = { fg = s.keyword_control },

    PreProc = { fg = s.preprocessor },
    Include = { fg = s.keyword_control },
    Define = { fg = s.preprocessor },
    Macro = { fg = s.macro },
    PreCondit = { fg = s.preprocessor },

    Type = { fg = s.type },
    StorageClass = { fg = s.keyword },
    Structure = { fg = s.keyword },
    Typedef = { fg = s.type },

    Special = { fg = s.decorator },
    SpecialChar = { fg = s.string_escape },
    Tag = { fg = s.tag },
    Delimiter = { fg = s.punctuation },
    Debug = { fg = c.diag.debug },

    Underlined = { fg = c.ui.link, underline = true },
    Ignore = { fg = c.ui.fg_muted },
    Error = { fg = s.invalid },
    Todo = { fg = c.diag.warn, bold = true },

    Added = { fg = c.git.add_fg },
    Removed = { fg = c.git.del_fg },
    Changed = { fg = c.git.change_fg },
  }
end

return { get = get }
