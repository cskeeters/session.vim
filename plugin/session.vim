if exists("loaded_session")
    finish
endif
let loaded_session = 1

function! s:MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let name = input("Session Name? ")
  if name == ""
      name = 'unnamed'
  endif
  let b:filename = b:sessiondir . '/' . name
  exe "mksession! " . b:filename
endfunction

function! s:LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions"
  let name = input("Session Name? ")
  if name == ""
      name = 'unnamed'
  endif
  let b:sessionfile = b:sessiondir . "/" . name
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

noremap <SID>MakeSession :call <SID>MakeSession()<cr>
noremap <SID>LoadSession :call <SID>LoadSession()<cr>
noremap <unique> <script> <Plug>MakeSession <SID>MakeSession
noremap <unique> <script> <Plug>LoadSession <SID>LoadSession

noremenu <script> Plugin.MakeSession <SID>MakeSession
noremenu <script> Plugin.LoadSession <SID>LoadSession

if !hasmapto('<Plug>MakeSession')
    map <leader>ms <Plug>MakeSession
endif
if !hasmapto('<Plug>LoadSession')
    map <leader>rs <Plug>LoadSession
endif
