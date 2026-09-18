local M = {}

local function parse_hex(hex)
  hex = hex:gsub('#', '')
  if #hex == 3 then
    hex = hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
  end
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  local a = 255
  if #hex >= 8 then
    a = tonumber(hex:sub(7, 8), 16)
  end
  return r, g, b, a
end

local function to_hex(r, g, b)
  return string.format('#%02x%02x%02x', math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

--- Blend `fg` over `bg`. `alpha` is 0..1, or omitted when `fg` has an #RRGGBBAA suffix.
function M.blend(fg, bg, alpha)
  local fr, fg_, fb, fa = parse_hex(fg)
  local br, bg_, bb = parse_hex(bg)
  local a = alpha
  if a == nil then
    a = fa / 255
  elseif a > 1 then
    a = a / 255
  end
  return to_hex(fr * a + br * (1 - a), fg_ * a + bg_ * (1 - a), fb * a + bb * (1 - a))
end

--- Turn #RRGGBBAA into a solid #RRGGBB composited over `bg`.
function M.solid(color, bg)
  if not color then
    return nil
  end
  local hex = color:gsub('#', '')
  if #hex <= 6 then
    return color:sub(1, 1) == '#' and color or ('#' .. color)
  end
  return M.blend(color, bg)
end

function M.highlight(groups)
  for name, opts in pairs(groups) do
    if type(opts) == 'string' then
      vim.api.nvim_set_hl(0, name, { link = opts })
    else
      vim.api.nvim_set_hl(0, name, opts)
    end
  end
end

return M
