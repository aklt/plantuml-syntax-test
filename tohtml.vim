
function! IndentPlantUML(filePath)
  set nocp
  syntax on
  filetype plugin indent on
  let &packpath=&packpath . ',' . './vim'
  packadd plantuml-syntax
  set shiftwidth=2
  set tabstop=2
  execute ":edit " . a:filePath
  execute ":set ft=plantuml"
  normal gg=G
  write!
endfun
