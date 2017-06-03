#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p $DIR/dist/names
for p in $DIR/name-glyphs/*.*; do
  glyph_filename=$(basename "$p")
  font_filename=`echo $glyph_filename | perl -pe 's|(.+?)\.txt|\1|'`
  title="${font_filename%.*}"
  output_filename="${title}-name"
  if [ -f $DIR/dist/$output_filename.woff ]; then
    echo -e "\e[1m\e[32m$title.woff\e[0m already exists."
  else
    printf "Making \e[1m\e[34m$title.woff\e[0m..."
    pyftsubset "$DIR/source/$font_filename" --output-file="$DIR/dist/names/$output_filename.woff" --text-file=$DIR/name-glyphs/$glyph_filename --drop-tables= --layout-features='*' --desubroutinize --symbol-cmap --legacy-cmap --glyph-names --layout-features='' --hinting-tables='' --legacy-kern --passthrough-tables --name-IDs='*' --name-languages='*' --name-legacy
    if [ $? ]; then
      printf "done!\n"
    fi
  fi
done
