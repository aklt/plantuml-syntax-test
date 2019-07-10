#!/bin/sh

#
# Configure colorscheme and where to source plantuml-syntax/syntax/plantuml.vim
# from 
#
colors="$HOMEDIR/vim/akltvim/pack/themes/opt/seoul256.vim/colors/seoul256-light.vim"

# colors="\$VIMRUNTIME/"
# colors="\$VIMRUNTIME/colors/default.vim"
# colors="${HOME}/.vim/bundle/gruvbox/colors/gruvbox.vim"
# colors="${HOME}/.vim/bundle/papercolor-theme/colors/PaperColor.vim"
plantumlSyntax="./plantuml-syntax/syntax/plantuml.vim"

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: vimtohtml.sh <inputFile> <out>"
  echo "  produces out.pre.html and out.css"
  exit 1
fi

ft=$(echo "$1" | sed -e 's/^.\+\.\(\w\+\)$/\1/')

case "${ft}" in
  uml)
    ft='plantuml'
    ;;
esac

echo "ft ${ft}"

tmpFile=$(mktemp /tmp/tohtml-sh.XXXX)

vim --noplugin -u NONE \
  -c ":set nocp" \
  -c ":syntax on" \
  -c ":r $1" \
  -c ":set ft=${ft}" \
  -c ":set bg=light" \
  -c ":source ${colors} | :source ${plantumlSyntax}" \
  -c ":let g:loaded_2html_plugin = 0" \
  -c ":source /usr/share/vim/vim80/syntax/2html.vim" \
  -c ":w! ${tmpFile}" \
  -c "qa!"

sed -rn '/^<pre/, /^<\/pre/ p' "${tmpFile}" > "${2}.pre.html"
sed -rn '/^\./ p' "${tmpFile}" > "${2}.syntax.css"

rm -fv "${tmpFile}"
