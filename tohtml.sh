#!/bin/sh

#
# Configure colorscheme and where to source plantuml-syntax/syntax/plantuml.vim
# from
#
# colors="\$VIMRUNTIME/colors/default.vim"
# colors="${HOME}/.vim/bundle/gruvbox/colors/gruvbox.vim"

tools="tohtml.vim"

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: vimtohtml.sh <inputFile> <out>"
  echo "  produces out.pre.html and out.css"
  exit 1
fi

toHtml="$VIM_TO_HTML"
if ! [ -e "$toHtml" ]; then
  toHtml="$HOME/install/share/vim/vim90/syntax/2html.vim"
fi
if ! [ -e "$toHtml" ]; then
  toHtml="/usr/share/vim/vim90/syntax/2html.vim"
fi
if ! [ -e "$toHtml" ]; then
  toHtml="$HOME/install/share/vim/vim82/syntax/2html.vim"
fi
if ! [ -e "$toHtml" ]; then
  toHtml="/usr/share/vim/vim82/syntax/2html.vim"
fi
if ! [ -e "$toHtml" ]; then
  echo "Cannot find 2html.vim script, set VIM_TO_HTML variable"
  exit 1
fi

tmpFile=$(mktemp /tmp/tohtml-sh.XXXX)

PACKPATH="`pwd`/vim"

vim --noplugin -u NONE \
  -c ":syntax on" \
  -c ":set nocp" \
  -c ":source ${tools}" \
  -c ":set bg=light" \
  -c ":colorscheme default" \
  -c ":call IndentPlantUML('$1')" \
  -c ":let g:loaded_2html_plugin = 0" \
  -c ":source $toHtml" \
  -c ":w! ${tmpFile}" \
  -c "qa!"

sed -rn '/^<pre/, /^<\/pre/ p' "${tmpFile}" > "${2}.pre.html"
sed -rn '/^\.[A-Z]+[a-zA-Z0-9]+ +\{/ p' "${tmpFile}" > "${2}.syntax.css"

echo tmp
cat "${tmpFile}"
