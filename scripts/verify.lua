-- nvim --headless -u NONE -c "set rtp+=." -c "luafile scripts/verify.lua"

local function fail(msg)
  io.stderr:write('FAIL: ' .. msg .. '\n')
  os.exit(1)
end

local root = vim.fn.getcwd()
vim.opt.runtimepath:prepend(root)

local function read_file(path)
  local f = io.open(path, 'r')
  if not f then
    fail('cannot read ' .. path)
  end
  local src = f:read '*a'
  f:close()
  return src
end

local function hex(n)
  return string.format('#%06x', n)
end

local function keys(tbl)
  local list = {}
  for k in pairs(tbl) do
    list[#list + 1] = k
  end
  table.sort(list)
  return list
end

local palmod = require 'vscode2026.palette'

-- Structural: every role exists in both styles; none is dark-only or light-only.
do
  for _, section in ipairs(palmod.sections) do
    local defs = palmod.roles[section]
    if not defs then
      fail('missing palette section ' .. section)
    end
    local names = palmod.role_names(section)
    if #names == 0 then
      fail('empty palette section ' .. section)
    end
    for _, name in ipairs(names) do
      local pair = defs[name]
      if type(pair) ~= 'table' then
        fail(section .. '.' .. name .. ' is not a dark/light pair')
      end
      if pair.dark == nil then
        fail(section .. '.' .. name .. ' exists only for light')
      end
      if pair.light == nil then
        fail(section .. '.' .. name .. ' exists only for dark')
      end
      if type(pair.dark) ~= 'string' or not pair.dark:match '^#%x+$' then
        fail(section .. '.' .. name .. '.dark is not a hex color')
      end
      if type(pair.light) ~= 'string' or not pair.light:match '^#%x+$' then
        fail(section .. '.' .. name .. '.light is not a hex color')
      end
    end

    local dark = palmod.get('dark')[section]
    local light = palmod.get('light')[section]
    local dk, lk = keys(dark), keys(light)
    if table.concat(dk, ',') ~= table.concat(lk, ',') then
      fail(section .. ' resolved keys differ between dark and light')
    end
    if table.concat(dk, ',') ~= table.concat(names, ',') then
      fail(section .. ' resolved keys do not match role definitions')
    end
  end
  io.stdout:write('OK semantic roles (same keys dark/light)\n')
end

-- Core syntax families must stay aligned (HEX may differ).
do
  local expected = {
    keyword_control = 'purple',
    keyword = 'red',
    string = 'blue',
    number = 'green',
    type = 'cyan',
    module = 'cyan',
    func = 'violet',
    variable = 'fg',
    property = 'fg',
    comment = 'gray',
    constant = 'blue',
    parameter = 'orange',
    decorator = 'orange',
    boolean = 'blue',
    tag = 'green',
    json_key = 'green',
  }
  for role, family in pairs(expected) do
    local pair = palmod.roles.syn[role]
    if not pair then
      fail('missing syn.' .. role)
    end
    if pair.family ~= family then
      fail('syn.' .. role .. ' family is ' .. tostring(pair.family) .. ', expected ' .. family)
    end
  end
  io.stdout:write('OK core chromatic families\n')
end

-- Mapping modules must use roles, not HEX and not style branches.
do
  local mapping_files = {
    'lua/vscode2026/groups/syntax.lua',
    'lua/vscode2026/groups/treesitter.lua',
    'lua/vscode2026/groups/lsp.lua',
    'lua/vscode2026/groups/languages.lua',
  }
  for _, rel in ipairs(mapping_files) do
    local src = read_file(root .. '/' .. rel)
    for line in src:gmatch '[^\n]+' do
      if not line:match '^%s*%-%-' then
        if line:match '#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]' then
          fail(rel .. ' hardcodes a color: ' .. line)
        end
        if line:match 'c%.style' or line:match "style%s*==%s*['\"]light['\"]" or line:match "style%s*==%s*['\"]dark['\"]" then
          fail(rel .. ' branches on style: ' .. line)
        end
      end
    end
  end
  io.stdout:write('OK mappings use roles, not HEX\n')
end

local function check(style, name, loader, via)
  loader(style)

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
    '@variable.sql',
    '@type.sql',
    '@function.sql',
  }

  for _, group in ipairs(required) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    if not ok or not hl or (not hl.fg and not hl.bg and not hl.link) then
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

  local pal = palmod.get(style)
  local function hl_hex(group, field)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    if not hl or not hl[field] then
      fail(name .. ' ' .. group .. '.' .. field .. ' missing')
    end
    return hex(hl[field])
  end

  if hl_hex('Normal', 'bg'):lower() ~= pal.ui.bg:lower() then
    fail(name .. ' Normal.bg expected ' .. pal.ui.bg)
  end
  if hl_hex('Normal', 'fg'):lower() ~= pal.ui.fg:lower() then
    fail(name .. ' Normal.fg expected ' .. pal.ui.fg)
  end
  if hl_hex('Keyword', 'fg'):lower() ~= pal.syn.keyword:lower() then
    fail(name .. ' Keyword.fg expected ' .. pal.syn.keyword)
  end
  if hl_hex('@keyword.conditional', 'fg'):lower() ~= pal.syn.keyword_control:lower() then
    fail(name .. ' @keyword.conditional expected ' .. pal.syn.keyword_control)
  end
  if hl_hex('@function.builtin', 'fg'):lower() ~= pal.syn.func_builtin:lower() then
    fail(name .. ' @function.builtin expected ' .. pal.syn.func_builtin)
  end

  -- SQL contract: control keywords purple, identifiers foreground, types cyan.
  if hl_hex('@keyword.sql', 'fg'):lower() ~= pal.syn.keyword_control:lower() then
    fail(name .. ' @keyword.sql expected keyword_control ' .. pal.syn.keyword_control)
  end
  if hl_hex('@variable.sql', 'fg'):lower() ~= pal.syn.variable:lower() then
    fail(name .. ' @variable.sql expected variable/fg ' .. pal.syn.variable)
  end
  if hl_hex('@type.sql', 'fg'):lower() ~= pal.syn.type:lower() then
    fail(name .. ' @type.sql expected type ' .. pal.syn.type)
  end
  if hl_hex('@function.sql', 'fg'):lower() ~= pal.syn.func_builtin:lower() then
    fail(name .. ' @function.sql expected func_builtin ' .. pal.syn.func_builtin)
  end
  if hl_hex('String', 'fg'):lower() ~= pal.syn.string:lower() then
    fail(name .. ' String expected string ' .. pal.syn.string)
  end
  if hl_hex('Number', 'fg'):lower() ~= pal.syn.number:lower() then
    fail(name .. ' Number expected number ' .. pal.syn.number)
  end

  io.stdout:write('OK ' .. name .. ' via ' .. via .. ' (' .. #required .. ' groups)\n')
end

check('dark', 'dark2026', function(style)
  require('vscode2026').load(style)
end, 'vscode2026')
check('light', 'light2026', function(style)
  require('vscode2026').load(style)
end, 'vscode2026')

check('dark', 'dark2026', function(style)
  require('dark2026').load(style)
end, 'dark2026 shim')
check('light', 'light2026', function(style)
  require('dark2026').load(style)
end, 'dark2026 shim')

io.stdout:write 'OK all checks\n'
os.exit(0)
