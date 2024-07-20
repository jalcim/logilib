#!/bin/sh

rm -rf bin
sh scripts/icarus/primitive.sh
sh scripts/icarus/routing.sh 
#sh scripts/icarus/memory.sh
sh scripts/icarus/compteur.sh
sh scripts/icarus/alu.sh
sh scripts/icarus/bus.sh
#sh scripts/icarus/exemple.sh
