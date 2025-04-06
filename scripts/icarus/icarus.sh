#!/usr/bin/env bash
set -e

# Fonction utilitaire : compile un fichier .v en binaire dans bin/
compile_test() {
  local src="$1"; shift
  local out="bin/${src#test/}"
  out="${out%.v}"
  mkdir -p "$(dirname "$out")"
  iverilog "$@" -o "$out" -pRECURSIVE_MOD_LIMIT=1000
  echo "  ✔ $src → $out"
}

# Nettoyage des anciens fichiers de compilation.
rm -rf bin

####################################
# Tests SRC uniquement
####################################
grep '^option(ENABLE_SRC_' build_config.cmake \
  | sed -E 's/^option\(ENABLE_SRC_([^ ]+).*/\1/' \
  | while read -r opt; do
    # PRIMITIVE_GATE_SERIAL_GATE → primitive/gate/serial_gate
    path=$(echo "$opt" \
           | tr '[:upper:]' '[:lower:]' \
           | sed 's/_/\//g')
    dir="test/$path"
    if [[ -d "$dir" ]]; then
      echo "==> Tests SRC : $dir"
      shopt -s nullglob
      for src in "$dir"/test_*.v; do
        compile_test "$src" "$src"
      done
      shopt -u nullglob
    else
      echo "ERREUR : répertoire '$dir' introuvable pour ENABLE_SRC_$opt"
    fi
  done

echo "==> Compilation des tests SRC terminée."
