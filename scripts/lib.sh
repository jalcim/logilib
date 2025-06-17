#!/usr/bin/env bash
set -e

rm -f lib.v
echo "==> Recherche des fichiers src utilisés dans les tests"

grep -rh '^[[:space:]]*`include "' test/ | sed -E 's/^[[:space:]]*`include "(.*)"/\1/' | sort -u | \
  awk '
    function cat_file(f) {
      print "  ✔ ajouté : " f > "/dev/stderr"
      while ((getline line < f) > 0) print line
      print ""  # newline
      close(f)
    }
    BEGIN { vh_count=0; other_count=0 }
    /^[[:space:]]*$/ { next }
    {
      files[NR] = $0
      if ($0 ~ /\.vh$/) vh_order[++vh_count] = NR
      else other_order[++other_count] = NR
    }
    END {
      for (i = 1; i <= vh_count; i++) cat_file(files[vh_order[i]])
      for (i = 1; i <= other_count; i++) cat_file(files[other_order[i]])
    }
  ' > lib.v

# Filtrer les lignes `include` dans lib.v
sed -i '/^[[:space:]]*`include/d' lib.v

echo "==> lib.v généré"
