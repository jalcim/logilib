# Fichier de configuration généré automatiquement
option(ENABLE_SRC "Activer src" ON)

option(ENABLE_SRC_TENSOR "Activer src/tensor" ON)

option(ENABLE_SRC_COMPTEUR "Activer src/compteur" ON)
option(ENABLE_SRC_PRIMITIVE "Activer src/primitive" ON)
option(ENABLE_SRC_PRIMITIVE_GATE "Activer src/primitive/gate" ON)
option(ENABLE_SRC_PRIMITIVE_GATE_SERIAL "Activer src/primitive/gate/serial" ON)
option(ENABLE_SRC_PRIMITIVE_GATE_PARALLEL "Activer src/primitive/gate/parallel" ON)
option(ENABLE_SRC_PRIMITIVE_GATE_MULTI "Activer src/primitive/gate/multi" ON)
option(ENABLE_SRC_PRIMITIVE_GATE_COMPLEX "Activer src/primitive/gate/complex" ON)

option(ENABLE_SRC_ALU "Activer src/alu" ON)
option(ENABLE_SRC_ALU_ARITHM "Activer src/alu/arithm" ON)
option(ENABLE_SRC_ALU_LOGIC "Activer src/alu/logic" ON)
option(ENABLE_SRC_ROUTING "Activer src/routing" ON)

option(ENABLE_SRC_MEMORY "Activer src/memory" ON)
option(ENABLE_SRC_MEMORY_DLATCH "Activer src/memory/dlatch" ON)
option(ENABLE_SRC_MEMORY_DLATCH_SERIAL "Activer src/memory/dlatch/serial" ON)
option(ENABLE_SRC_MEMORY_DLATCH_PARALLEL "Activer src/memory/dlatch/parallel" ON)
option(ENABLE_SRC_MEMORY_DFLIPFLOP "Activer src/memory/dflipflop" ON)
option(ENABLE_SRC_MEMORY_DFLIPFLOP_SERIAL "Activer src/memory/dflipflop/serial" ON)
option(ENABLE_SRC_MEMORY_DFLIPFLOP_PARALLEL "Activer src/memory/dflipflop/parallel" ON)
option(ENABLE_SRC_MEMORY_JKLATCH "Activer src/memory/jklatch" ON)

option(ENABLE_COSIM "Activer cosim" ON)
option(ENABLE_COSIM_UTILS "Activer cosim/utils" ON)
option(ENABLE_COSIM_PRIMITIVE "Activer cosim/primitive" ON)
option(ENABLE_COSIM_PRIMITIVE_GATE "Activer cosim/primitive/gate" ON)
option(ENABLE_COSIM_PRIMITIVE_GATE_PARALLEL "Activer cosim/primitive/gate/parallel" ON)

option(ENABLE_COSIM_ALU "Activer cosim/alu" ON)
option(ENABLE_COSIM_ALU_ARITHM "Activer cosim/alu/arithm" ON)
option(ENABLE_COSIM_ALU_ARITHM_ADDX "Activer cosim/alu/arithm/addx" ON)
option(ENABLE_COSIM_ALU_ARITHM_ADD_SUB "Activer cosim/alu/arithm/add_sub" ON)
option(ENABLE_COSIM_MEMORY "Activer cosim/memory" ON)
option(ENABLE_COSIM_MEMORY_DLATCH "Activer cosim/memory/Dlatch" ON)
option(ENABLE_COSIM_MEMORY_DFLIPFLOP "Activer cosim/memory/Dlatch" ON)

# Options globales
set(LOG_LEVEL "warning" CACHE STRING "Set the log level")
set(MAX_WAYS "8" CACHE STRING "Max number of cell ways generated")
set(MAX_WIRE "8" CACHE STRING "Max number of cell wire generated")
set(VERILATOR_TIME_STEP "1000" CACHE STRING "Time between each verilator evaluation")

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_DEBUG_LIBS OFF)
set(Boost_USE_RELEASE_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)

option(ENABLE_VCD "Enable VCD trace file generation" ON)
option(STATIC_BUILD "Compiles into one binary with no dynamic dependencies" OFF)
