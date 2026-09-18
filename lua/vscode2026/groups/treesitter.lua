-- Treesitter captures mapped from VS Code TextMate scopes + default semantic probes.
-- Colors come from palette roles (`c.syn.*`); this file must not pick HEX or style.
-- See docs/MAPPING.md.

local function get(c, cfg)
  local s = c.syn
  local ui = c.ui

  return {
    ['@comment'] = { fg = s.comment, italic = cfg.italic_comments },
    ['@comment.documentation'] = { fg = s.comment, italic = cfg.italic_comments },
    ['@comment.error'] = { fg = c.diag.error, bold = true },
    ['@comment.warning'] = { fg = c.diag.warn, bold = true },
    ['@comment.todo'] = { fg = c.diag.warn, bold = true },
    ['@comment.note'] = { fg = c.diag.info, bold = true },

    ['@string'] = { fg = s.string },
    ['@string.documentation'] = { fg = s.string },
    ['@string.escape'] = { fg = s.string_escape },
    ['@string.regexp'] = { fg = s.regexp },
    ['@string.special'] = { fg = s.decorator },
    ['@string.special.symbol'] = { fg = s.constant },
    ['@string.special.url'] = { fg = s.link_text, underline = true },
    ['@string.special.path'] = { fg = s.string },
    ['@character'] = { fg = s.string },
    ['@character.special'] = { fg = s.embedded },

    ['@number'] = { fg = s.number },
    ['@number.float'] = { fg = s.number },
    ['@boolean'] = { fg = s.boolean },

    ['@constant'] = { fg = s.constant },
    ['@constant.builtin'] = { fg = s.boolean },
    ['@constant.macro'] = { fg = s.macro },

    -- variable.other -> syntax fg; semantic `variable` without .other stays orange via parameter/entity.name
    ['@variable'] = { fg = s.variable },
    ['@variable.builtin'] = { fg = s.constant }, -- variable.language (this/self)
    ['@variable.parameter'] = { fg = s.parameter },
    ['@variable.parameter.builtin'] = { fg = s.parameter },
    ['@variable.member'] = { fg = s.property },

    ['@property'] = { fg = s.property },
    ['@field'] = { fg = s.property }, -- pre-0.10
    ['@parameter'] = { fg = s.parameter }, -- pre-0.10

    ['@function'] = { fg = s.func },
    ['@function.builtin'] = { fg = s.func_builtin },
    ['@function.call'] = { fg = s.func },
    ['@function.macro'] = { fg = s.macro },
    ['@function.method'] = { fg = s.func },
    ['@function.method.call'] = { fg = s.func },
    ['@method'] = { fg = s.func }, -- pre-0.10
    ['@method.call'] = { fg = s.func },
    ['@constructor'] = { fg = s.type },

    ['@keyword'] = { fg = s.keyword },
    ['@keyword.coroutine'] = { fg = s.keyword_control },
    ['@keyword.function'] = { fg = s.keyword }, -- storage.type (`fn`, `def`, `function`)
    ['@keyword.operator'] = { fg = s.keyword_modifier }, -- keyword.operator.wordlike
    ['@keyword.import'] = { fg = s.keyword_control },
    ['@keyword.type'] = { fg = s.keyword }, -- `class`/`struct`/`enum` keywords
    ['@keyword.modifier'] = { fg = s.keyword_modifier }, -- storage.modifier
    ['@keyword.repeat'] = { fg = s.keyword_control },
    ['@keyword.return'] = { fg = s.keyword_control },
    ['@keyword.exception'] = { fg = s.keyword_control },
    ['@keyword.conditional'] = { fg = s.keyword_control },
    ['@keyword.conditional.ternary'] = { fg = s.keyword_control },
    ['@keyword.debug'] = { fg = c.diag.debug },
    ['@keyword.directive'] = { fg = s.preprocessor },
    ['@keyword.directive.define'] = { fg = s.preprocessor },
    ['@repeat'] = { fg = s.keyword_control },
    ['@conditional'] = { fg = s.keyword_control },
    ['@include'] = { fg = s.keyword_control },
    ['@exception'] = { fg = s.keyword_control },
    ['@storageclass'] = { fg = s.keyword },

    ['@operator'] = { fg = s.operator },

    ['@type'] = { fg = s.type },
    ['@type.builtin'] = { fg = s.type }, -- support.type / entity.name.type
    ['@type.definition'] = { fg = s.type },
    ['@type.qualifier'] = { fg = s.keyword_modifier },

    ['@attribute'] = { fg = s.decorator },
    ['@attribute.builtin'] = { fg = s.decorator },
    ['@module'] = { fg = s.module },
    ['@module.builtin'] = { fg = s.module },
    ['@namespace'] = { fg = s.module },
    ['@label'] = { fg = s.keyword },

    ['@punctuation'] = { fg = s.punctuation },
    ['@punctuation.bracket'] = { fg = s.punctuation },
    ['@punctuation.delimiter'] = { fg = s.punctuation },
    ['@punctuation.special'] = { fg = s.embedded },

    ['@tag'] = { fg = s.tag },
    ['@tag.builtin'] = { fg = s.tag },
    ['@tag.attribute'] = { fg = s.attribute },
    ['@tag.delimiter'] = { fg = s.tag_delimiter },

    ['@markup.heading'] = { fg = s.heading, bold = true },
    ['@markup.heading.1'] = { fg = s.heading, bold = true },
    ['@markup.heading.2'] = { fg = s.heading, bold = true },
    ['@markup.heading.3'] = { fg = s.heading, bold = true },
    ['@markup.heading.4'] = { fg = s.heading, bold = true },
    ['@markup.heading.5'] = { fg = s.heading, bold = true },
    ['@markup.heading.6'] = { fg = s.heading, bold = true },
    ['@markup.strong'] = { fg = s.fg, bold = true },
    ['@markup.italic'] = { fg = s.fg, italic = true },
    ['@markup.strikethrough'] = { strikethrough = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.quote'] = { fg = s.quote },
    ['@markup.math'] = { fg = s.constant },
    ['@markup.link'] = { fg = s.link_text, underline = true },
    ['@markup.link.label'] = { fg = s.link_text },
    ['@markup.link.url'] = { fg = c.ui.link, underline = true },
    ['@markup.raw'] = { fg = s.raw },
    ['@markup.raw.block'] = { fg = s.fg, bg = ui.bg_hover },
    ['@markup.list'] = { fg = s.list },
    ['@markup.list.checked'] = { fg = s.quote },
    ['@markup.list.unchecked'] = { fg = s.list },

    -- older @text.* captures
    ['@text.title'] = { fg = s.heading, bold = true },
    ['@text.literal'] = { fg = s.raw },
    ['@text.uri'] = { fg = c.ui.link, underline = true },
    ['@text.emphasis'] = { fg = s.fg, italic = true },
    ['@text.strong'] = { fg = s.fg, bold = true },
    ['@text.strike'] = { strikethrough = true },
    ['@text.todo'] = { fg = c.diag.warn, bold = true },
    ['@text.note'] = { fg = c.diag.info, bold = true },
    ['@text.warning'] = { fg = c.diag.warn, bold = true },
    ['@text.danger'] = { fg = c.diag.error, bold = true },
    ['@text.diff.add'] = { fg = c.git.add_fg },
    ['@text.diff.delete'] = { fg = c.git.del_fg },

    ['@diff.plus'] = { fg = c.git.add_fg },
    ['@diff.minus'] = { fg = c.git.del_fg },
    ['@diff.delta'] = { fg = c.git.change_fg },

    ['@error'] = { fg = s.invalid },
    ['@none'] = {},
    ['@conceal'] = { fg = ui.fg_dim },
  }
end

return { get = get }
