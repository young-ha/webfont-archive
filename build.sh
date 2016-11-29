#!/bin/bash
pip install fonttools
mkdir -p dist
for p in ./source/*.*; do
  filename=$(basename "$p")
  title="${filename%.*}"
  if [ -f ./dist/$title.woff ]; then
    echo "$title.woff already exists."
  else
    pyftsubset "$p" --output-file="./dist/${title}.woff" --text-file=glyphs.txt --verbose --drop-tables= --layout-features='*' --desubroutinize --symbol-cmap --legacy-cmap --glyph-names --layout-features='' --hinting-tables='' --legacy-kern --passthrough-tables --name-IDs='*' --name-languages='*' --name-legacy
  fi
done