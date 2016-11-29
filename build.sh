#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pip install fonttools
mkdir -p $DIR/dist
for p in $DIR/source/*.*; do
  filename=$(basename "$p")
  title="${filename%.*}"
  if [ -f $DIR/dist/$title.woff ]; then
    echo -e "\e[1m\e[32m$title.woff\e[0m already exists."
  else
    printf "Making \e[1m\e[34m$title.woff\e[0m..."
    pyftsubset "$p" --output-file="$DIR/dist/${title}.woff" --text-file=$DIR/glyphs.txt --drop-tables= --layout-features='*' --desubroutinize --symbol-cmap --legacy-cmap --glyph-names --layout-features='' --hinting-tables='' --legacy-kern --passthrough-tables --name-IDs='*' --name-languages='*' --name-legacy
    if [ $? ]; then
      printf "done!\n"
    fi
  fi
done
