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
      \ ]

function s:rollback(...) abort
  set noinsertmode
endfunction

function s:do_action(source) abort
  execute get(g:, 'fzf_command_prefix', '') . a:source
  set insertmode
  call timer_start(100, function('s:rollback'))
endfunction

function fzfsource#list() abort
  call fzf#run({
        \ 'source': s:source,
        \ 'sink': function('s:do_action'),
        \ 'down': '30%',
        \})
endfunction