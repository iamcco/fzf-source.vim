let s:source = [
      \  'Files',
      \  'GitFiles',
      \  'GFiles',
      \  'Buffers',
      \  'Lines',
      \  'BLines',
      \  'Colors',
      \  'Locate',
      \  'Ag',
      \  'Rg',
      \  'Tags',
      \  'BTags',
      \  'Snippets',
      \  'Commands',
      \  'Marks',
      \  'Helptags',
      \  'Windows',
      \  'Commits',
      \  'BCommits',
      \  'Maps',
      \  'Filetypes',
      \  'History'
      \]

function! fzfsource#get_fzf_commands() abort
  if get(g:, 'fzf_command_prefix', '') ==# ''
    return s:source
  endif
  redir => l:commands
  silent command
  redir END
  let l:reg = '\v.{4}' . g:fzf_command_prefix . '([^ ]+\s+[^ ]).*$'
  let l:fzf_commands = map(
        \  filter(
        \    split(l:commands, '\n'),
        \    'v:val =~# l:reg'
        \  ),
        \  'substitute(v:val, l:reg, "\\1", "")'
        \)
  return l:fzf_commands
endfunction

function! fzfsource#do_action(...) abort
  let l:command = get(g:, 'fzf_command_prefix', '') . get(split(get(a:000, '0', ''), ' '), '0', '')
  let l:args = get(a:000, '1', [])
  if l:command !=# ''
    execute l:command . ' ' . join(l:args, ' ')
  endif
endfunction
