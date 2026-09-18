local function get(c)
  local t = c.term
  return {
    colors = {
      t.black,
      t.red,
      t.green,
      t.yellow,
      t.blue,
      t.magenta,
      t.cyan,
      t.white,
      t.bright_black,
      t.bright_red,
      t.bright_green,
      t.bright_yellow,
      t.bright_blue,
      t.bright_magenta,
      t.bright_cyan,
      t.bright_white,
    },
    highlights = {
      Terminal = { fg = c.ui.fg_ui, bg = c.ui.bg_chrome },
    },
  }
end

return { get = get }
