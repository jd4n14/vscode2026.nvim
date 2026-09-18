local M = {}

M.config = {
  transparent = false,
  italic_comments = false,
  plugins = true,
}

local function merge(dst, src)
  for k, v in pairs(src) do
    dst[k] = v
  end
  return dst
end

function M.setup(opts)
  if not opts then
    return
  end
  for k, v in pairs(opts) do
    M.config[k] = v
  end
end

function M.palette(style)
  return require('vscode2026.palette').get(style)
end

function M.load(style)
  style = style or 'dark'

  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd 'syntax reset'
  end

  vim.o.termguicolors = true
  vim.o.background = style == 'light' and 'light' or 'dark'
  -- Colorscheme names stay dark2026 / light2026 (VS Code theme names).
  vim.g.colors_name = style == 'light' and 'light2026' or 'dark2026'

  local cfg = M.config
  local pal = require('vscode2026.palette').get(style)
  local U = require 'vscode2026.util'

  local groups = {}
  merge(groups, require('vscode2026.groups.editor').get(pal, cfg))
  merge(groups, require('vscode2026.groups.syntax').get(pal, cfg))
  merge(groups, require('vscode2026.groups.treesitter').get(pal, cfg))
  merge(groups, require('vscode2026.groups.lsp').get(pal, cfg))
  merge(groups, require('vscode2026.groups.diagnostics').get(pal, cfg))
  merge(groups, require('vscode2026.groups.git').get(pal, cfg))
  merge(groups, require('vscode2026.groups.languages').get(pal, cfg))

  local term = require('vscode2026.groups.terminal').get(pal, cfg)
  merge(groups, term.highlights)
  for i, color in ipairs(term.colors) do
    vim.g['terminal_color_' .. (i - 1)] = color
  end

  if cfg.plugins ~= false then
    merge(groups, require('vscode2026.plugins').get(pal, cfg))
  end

  U.highlight(groups)
end

return M
