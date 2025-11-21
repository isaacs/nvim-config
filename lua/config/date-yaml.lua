vim.cmd([[
  command! -range DY call DateYaml()
  function DateYaml ()
    read !echo "date: $(node -p 'new Date().toISOString()')"
  endfunction
  function YamlDate ()
    call DateYaml()
  endfunction
  map <Leader>dy :DY<CR>
]])
