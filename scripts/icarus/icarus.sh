#!/bin/bash
set -e

# Fonction utilitaire : compile un test en créant le répertoire de destination si nécessaire.
compile_test() {
  local out="$1"
  shift
  mkdir -p "$(dirname "$out")"
  iverilog "$@" -o "$out"
}

# Nettoyage des anciens fichiers de compilation.
rm -rf bin

#############################
# Tests ALU
#############################
test_alu_arithm() {
  local TEST="test/alu/arithm"
  local BIN="bin/alu/arithm"
  compile_test "$BIN/test_add" "$TEST/test_add.v"
  compile_test "$BIN/test_addX" "$TEST/test_addX.v"
  compile_test "$BIN/test_add8" "$TEST/test_add8.v"
  compile_test "$BIN/test_divmod2" "$TEST/test_divmod2.v"
  compile_test "$BIN/test_multX" "$TEST/test_multX.v"
  compile_test "$BIN/test_cmp" "$TEST/test_cmp.v"
}

test_alu_logic() {
  local TEST="test/alu/logic"
  local BIN="bin/alu/logic"
  compile_test "$BIN/test_alu_logic" "$TEST/test_alu_logic.v"
}

test_alu() {
  test_alu_arithm
  test_alu_logic
}

#############################
# Tests BUS
#############################
test_bus_axi_lite() {
  local BIN="bin/bus/axi_lite"
  mkdir -p "$BIN"
  compile_test "$BIN/test_axi_lite_slave" test/bus/axi_lite/slave_bench.v src/bus/axi_lite/slave.v src/bus/axi_lite/regs.v
  compile_test "$BIN/test_axi_lite_master" test/bus/axi_lite/master_bench.v src/bus/axi_lite/master.v src/bus/axi_lite/slave.v src/bus/axi_lite/regs.v
}

#############################
# Tests Compteur
#############################
test_compteur() {
  local TEST="test/compteur"
  local BIN="bin/compteur"
  compile_test "$BIN/test_cpt_bin" "$TEST/test_cpt_bin.v"
  # Pour activer ce test, décommentez la ligne suivante :
  # compile_test "$BIN/test_bit_cpt3" "$TEST/test_bit_cpt3.v"
}

#############################
# Tests Exemple
#############################
test_exemple() {
  rm -rf bin/exemple
  mkdir -p bin/exemple

  echo "Compilation des tests d'exemple..."
  compile_test bin/exemple/test_bru -pRECURSIVE_MOD_LIMIT=100 exemple/alu/bru/test_bru.v
  compile_test bin/exemple/test_alu -pRECURSIVE_MOD_LIMIT=100 exemple/alu/test_alu.v
  compile_test bin/exemple/test_block_reg -pRECURSIVE_MOD_LIMIT=100 exemple/block_reg/test_block_reg.v
  compile_test bin/exemple/test_decodeur -pRECURSIVE_MOD_LIMIT=100 exemple/decodeur/test_decodeur.v
  compile_test bin/exemple/test_block_mem -pRECURSIVE_MOD_LIMIT=100 exemple/lsu/block_mem/test_block_mem.v
  compile_test bin/exemple/test_lsu -pRECURSIVE_MOD_LIMIT=10000 exemple/lsu/test_lsu.v
  compile_test bin/exemple/test_mux_load -pRECURSIVE_MOD_LIMIT=100 exemple/lsu/test_mux_load.v
  compile_test bin/exemple/test_mux_store -pRECURSIVE_MOD_LIMIT=100 exemple/lsu/test_mux_store.v
  compile_test bin/exemple/test_pc -pRECURSIVE_MOD_LIMIT=100 exemple/pc/test_pc.v
  compile_test bin/exemple/test_rom -pRECURSIVE_MOD_LIMIT=100 exemple/rom/test_rom.v
  compile_test bin/exemple/test_write_back -pRECURSIVE_MOD_LIMIT=100 exemple/write_back/test_write_back.v
  compile_test bin/exemple/test_lui -pRECURSIVE_MOD_LIMIT=100 exemple/auipc_lui/lui/test_lui.v
  compile_test bin/exemple/test_auipc -pRECURSIVE_MOD_LIMIT=100 exemple/auipc_lui/auipc/test_auipc.v
  compile_test bin/exemple/test_auipc_lui -pRECURSIVE_MOD_LIMIT=100 exemple/auipc_lui/test_auipc_lui.v
  compile_test bin/exemple/test_jal -pRECURSIVE_MOD_LIMIT=100 exemple/jal_jalr/jal/test_jal.v
  compile_test bin/exemple/test_jalr -pRECURSIVE_MOD_LIMIT=100 exemple/jal_jalr/jalr/test_jalr.v
  compile_test bin/exemple/test_jal_jalr -pRECURSIVE_MOD_LIMIT=100 exemple/jal_jalr/test_jal_jalr.v
  compile_test bin/exemple/test_datapath -pRECURSIVE_MOD_LIMIT=10000 exemple/test_datapath.v
}

#############################
# Tests Mémoire
#############################
test_memory() {
  test_Dlatch() {
    local TEST="test/memory/Dlatch"
    local BIN="bin/memory/Dlatch"
    compile_test "$BIN/test_Dlatch" "$TEST/test_Dlatch.v"
    compile_test "$BIN/test_serial_Dlatch" "$TEST/test_serial_Dlatch.v"
    compile_test "$BIN/test_parallel_Dlatch" "$TEST/test_parallel_Dlatch.v"
    compile_test "$BIN/test_Dlatch_rst" "$TEST/test_Dlatch_rst.v"
    compile_test "$BIN/test_serial_Dlatch_rst" "$TEST/test_serial_Dlatch_rst.v"
    compile_test "$BIN/test_parallel_Dlatch_rst" "$TEST/test_parallel_Dlatch_rst.v"
    compile_test "$BIN/test_Dlatch_pre" "$TEST/test_Dlatch_pre.v"
    compile_test "$BIN/test_serial_Dlatch_pre" "$TEST/test_serial_Dlatch_pre.v"
    compile_test "$BIN/test_parallel_Dlatch_pre" "$TEST/test_parallel_Dlatch_pre.v"
    compile_test "$BIN/test_Dlatch_rst_pre" "$TEST/test_Dlatch_rst_pre.v"
    compile_test "$BIN/test_serial_Dlatch_rst_pre" "$TEST/test_serial_Dlatch_rst_pre.v"
    compile_test "$BIN/test_parallel_Dlatch_rst_pre" "$TEST/test_parallel_Dlatch_rst_pre.v"
  }
  test_Dflipflop() {
    local TEST="test/memory/Dflipflop"
    local BIN="bin/memory/Dflipflop"
    compile_test "$BIN/test_Dflipflop" "$TEST/test_Dflipflop.v"
    compile_test "$BIN/test_serial_Dflipflop" "$TEST/test_serial_Dflipflop.v"
    compile_test "$BIN/test_parallel_Dflipflop" "$TEST/test_parallel_Dflipflop.v"
    compile_test "$BIN/test_Dflipflop_rst" "$TEST/test_Dflipflop_rst.v"
    compile_test "$BIN/test_serial_Dflipflop_rst" "$TEST/test_serial_Dflipflop_rst.v"
    compile_test "$BIN/test_parallel_Dflipflop_rst" "$TEST/test_parallel_Dflipflop_rst.v"
    compile_test "$BIN/test_Dflipflop_pre" "$TEST/test_Dflipflop_pre.v"
    compile_test "$BIN/test_serial_Dflipflop_pre" "$TEST/test_serial_Dflipflop_pre.v"
    compile_test "$BIN/test_parallel_Dflipflop_pre" "$TEST/test_parallel_Dflipflop_pre.v"
    compile_test "$BIN/test_Dflipflop_rst_pre" "$TEST/test_Dflipflop_rst_pre.v"
    compile_test "$BIN/test_serial_Dflipflop_rst_pre" "$TEST/test_serial_Dflipflop_rst_pre.v"
    compile_test "$BIN/test_parallel_Dflipflop_rst_pre" "$TEST/test_parallel_Dflipflop_rst_pre.v"
  }
  test_JKlatch() {
    local TEST="test/memory/JKlatch"
    local BIN="bin/memory/JKlatch"
    compile_test "$BIN/test_JKlatchUP_rst" "$TEST/test_JKlatchUP_rst.v"
    compile_test "$BIN/test_serial_JKlatchUP_rst" "$TEST/test_serial_JKlatchUP_rst.v"
  }
  test_Dlatch
  test_Dflipflop
  test_JKlatch
}

#############################
# Tests Primitive
#############################
test_primitive() {
  test_gate() {
    local TEST="test/primitive/gate"
    local BIN="bin/primitive/gate"
    compile_test "$BIN/test_gate" "$TEST/test_gate.v"
    compile_test "$BIN/test_serial_gate" "$TEST/test_serial_gate.v"
    compile_test "$BIN/test_parallel_gate" "$TEST/test_parallel_gate.v"
  }
  test_complex_gate() {
    local TEST="test/primitive/complex_gate"
    local BIN="bin/primitive/complex_gate"
    compile_test "$BIN/test_complex_gate" "$TEST/test_complex_gate.v"
  }
  test_gate
  test_complex_gate
}

#############################
# Tests Routing
#############################
test_routing() {
  local TEST="test/routing"
  local BIN="bin/routing"
  mkdir -p "$BIN"
  # compile_test "$BIN/test_decalleur_LR" "$TEST/test_decalleur_LR.v"  # optionnel, comme dans l'original
  compile_test "$BIN/test_demux" "$TEST/test_demux.v"
  compile_test "$BIN/test_demux8" "$TEST/test_demux8.v"
  compile_test "$BIN/test_mux" "$TEST/test_mux.v"
  compile_test "$BIN/test_mux8" "$TEST/test_mux8.v"
  compile_test "$BIN/test_shuffle" "$TEST/test_shuffle.v"
  compile_test "$BIN/test_replicator" "$TEST/test_replicator.v"
}

#############################
# Exécution principale
#############################
# Décommentez les sections à exécuter selon vos besoins.
test_primitive
test_routing
# test_memory    # Décommentez pour inclure les tests de mémoire
test_compteur
test_alu
test_bus_axi_lite
# test_exemple   # Décommentez pour inclure les tests d'exemple

echo "Compilation de tous les tests réussie."
