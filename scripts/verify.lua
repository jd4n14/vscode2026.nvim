-- nvim --headless -u NONE -c "set rtp+=." -c "luafile scripts/verify.lua"

local function fail(msg)
  io.stderr:write('FAIL: ' .. msg .. '\n')
  os.exit(1)
end

local function check(style, name)
  vim.opt.runtimepath:prepend(vim.fn.getcwd())
  require('dark2026').load(style)

  if vim.g.colors_name ~= name then
    fail('colors_name is ' .. tostring(vim.g.colors_name) .. ', expected ' .. name)
  end
  if vim.o.background ~= style then
    fail('background is ' .. vim.o.background .. ', expected ' .. style)
  end

  local required = {
    'Normal',
    'Comment',
    'Keyword',
    'Function',
    'Type',
    'String',
    'Number',
    '@keyword.conditional',
    '@function.builtin',
    '@variable.parameter',
    '@lsp.type.class',
    '@lsp.typemod.function.defaultLibrary',
    'DiagnosticError',
    'DiffAdd',
    'GitSignsAdd',
    'Pmenu',
    'Visual',
    'Search',
    'NormalFloat',
    'BlinkCmpMenu',
    'TelescopeNormal',
    'SnacksPickerMatch',
    'BufferLineBufferSelected',
    'WhichKey',
    '@markup.heading',
    '@tag',
    '@property.json',
    '@property.css',
    '@lsp.type.macro.rust',
    '@type.builtin.go',
    '@attribute.python',
    '@type.builtin.java',
    '@keyword.directive.c',
    '@variable.builtin.lua',
    '@keyword.sql',
  }

  for _, group in ipairs(required) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if not ok or not hl or (not hl.fg and not hl.bg and not hl.link) then
      -- linked groups: resolve
      local linked = vim.api.nvim_get_hl(0, { name = group })
      if not linked or (not linked.fg and not linked.bg and not linked.link) then
        fail(name .. ' missing highlight ' .. group)
      end
    end
  end

  for i = 0, 15 do
    if not vim.g['terminal_color_' .. i] then
      fail(name .. ' missing terminal_color_' .. i)
    end
  end

  local pal = require('dark2026.palette').get(style)
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
  local function hex(n)
    return string.format('#%06x', n)
  end
  if not normal.bg or hex(normal.bg):lower() ~= pal.ui.bg:lower() then
    fail(name .. ' Normal.bg expected ' .. pal.ui.bg .. ' got ' .. tostring(normal.bg and hex(normal.bg)))
  end
  if not normal.fg or hex(normal.fg):lower() ~= pal.ui.fg:lower() then
    fail(name .. ' Normal.fg expected ' .. pal.ui.fg .. ' got ' .. tostring(normal.fg and hex(normal.fg)))
  end

  local keyword = vim.api.nvim_get_hl(0, { name = 'Keyword', link = false })
  if hex(keyword.fg):lower() ~= pal.syn.keyword:lower() then
    fail(name .. ' Keyword.fg expected ' .. pal.syn.keyword)
  end
  local control = vim.api.nvim_get_hl(0, { name = '@keyword.conditional', link = false })
  if hex(control.fg):lower() ~= pal.syn.keyword_control:lower() then
    fail(name .. ' @keyword.conditional expected ' .. pal.syn.keyword_control)
  end
  local builtin = vim.api.nvim_get_hl(0, { name = '@function.builtin', link = false })
  if hex(builtin.fg):lower() ~= pal.syn.func_builtin:lower() then
    fail(name .. ' @function.builtin expected ' .. pal.syn.func_builtin)
  end

  io.stdout:write('OK ' .. name .. ' (' .. #required .. ' groups)\n')
end

check('dark', 'dark2026')
check('light', 'light2026')
os.exit(0)
