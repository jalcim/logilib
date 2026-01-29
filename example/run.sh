#!/bin/bash
set -e

cd "$(dirname "$0")"

# En production: fusesoc library add logilib https://github.com/music/logilib
echo "==> Ajout de logilib"
fusesoc library add logilib ..

echo "==> Ajout du projet"
fusesoc library add mon_projet .

echo "==> Simulation"
fusesoc run --target=sim music:music:mon_projet
