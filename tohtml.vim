
function! IndentPlantUML(filePath, fileType)
  set nocp
  syntax on
  filetype plugin indent on
  let &packpath=&packpath . ',' . './vim'
  packadd plantuml-syntax
  execute ":read " . a:filePath
  execute ":set ft=" . a:fileType
  set shiftwidth=2
  set tabstop=2
  normal gg
  normal /^@start\(gantt\|latex\|math\|mindmap\|uml\|wbs\)
  normal =/^@end
endfun
