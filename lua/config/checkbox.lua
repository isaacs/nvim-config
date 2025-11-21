local textCheckboxLangs = {
  "text",
  "markdown",
  "markdown.mdx",
}
local jsCheckboxLangs = {
  "javascript",
  "typescript",
  "mdx",
  "tdx",
  "jsx",
}

local getline = vim.fn.getline
local setline = vim.fn.setline
local substitute = vim.fn.substitute
local match = vim.fn.match
local col = vim.fn.col

function CheckBox()
  local line = getline('.')
  if (match(line, '^\\s*[*-]') ~= -1) then
    if (match(line, '^\\s*[*-] \\[[x ]\\]') == -1) then
      if (match(line, '^\\s*-') ~= -1) then
        setline('.', substitute(line, '-\\s*', '- [ ] ', ''))
      else
        setline('.', substitute(line, '*\\s*', '* [ ] ', ''))
      end
      vim.cmd('normal 4l')
    else
      -- is a checkbox, check open/closed
      if (match(line, '^\\s*[*-] \\[ \\]') ~= -1) then
        -- open, close it
        setline('.', substitute(line, '\\[ \\] ', '[x] ', ''))
      else
        -- closed, remove it
        local s = col('.')
        setline('.', substitute(line, '\\[x\\] ', '', ''))
        local t = col('.')
        while (s - t < 4) do
          vim.cmd('normal h')
          s = s + 1
        end
      end
    end
  end
end

function CheckBoxJS()
  local line = getline('.')
  -- call setline('.', substitute(line, '$', ' -- eol', ''))
  if (match(line, '^\\s*// \\s*[*-]') ~= -1) then
    -- is a li
    if (match(line, '^\\s*// \\s*[*-] \\[[x ]\\]') == -1) then
      -- not a checkbox
      if (match(line, '^\\s*// \\s*-') ~= -1) then
        setline('.', substitute(line, '-\\s*', '- [ ] ', ''))
      else
        setline('.', substitute(line, '*\\s*', '* [ ] ', ''))
      end
      vim.cmd('normal 4l')
    else
      -- is a checkbox, check open/closed
      if (match(line, '^\\s*// \\s*[*-] \\[ \\]') ~= -1) then
        -- open, close it
        setline('.', substitute(line, '\\[ \\] ', '[x] ', ''))
      else
        -- closed, remove it
        local s = col('.')
        setline('.', substitute(line, '\\[x\\] ', '', ''))
        local t = col('.')
        while (s - t < 4) do
          vim.cmd('normal h')
          s = s + 1
        end
      end
    end
  end
end

local map = vim.keymap.set
vim.api.nvim_create_augroup("CheckBox", { clear = true })

local au = vim.api.nvim_create_autocmd

for _, lang in ipairs(textCheckboxLangs) do
  au("FileType", {
    group = "CheckBox",
    pattern = lang,
    callback = function()
      map({"n", "v"}, '<space>', CheckBox, {
        buffer = true,
        silent = true,
      })
    end,
  })
end

for _, lang in ipairs(jsCheckboxLangs) do
  au("FileType", {
    group = "CheckBox",
    pattern = lang,
    callback = function()
      map({"n", "v"}, '<space>', CheckBoxJS, {
        buffer = true,
        silent = true,
      })
    end,
  })
end
