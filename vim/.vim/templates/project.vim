" ---------------PROJECT---------------------

let g:project#name = "myProject"
let g:project#defaultNamespace = g:project#name

" Override the Build functions
compiler msvc
set makeprg=cmake

function! Clean()
  :silent make --build build --target clean
endfunction

function! Build()
  :silent make --build build
endfunction

function! Rebuild()
  :silent call Clean()
  :silent call Build()
endfunction

function! Debug()
  :silent call jobstart('remedybg.exe -g -q myProject.rdbg')
endfunction

map <F6> :call Debug()<cr>

