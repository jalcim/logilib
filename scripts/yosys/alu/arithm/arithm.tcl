source scripts/yosys/utils.tcl

proc run_arithm_synth {outpath module wire} {
  make_dir $outpath

  puts $outpath
  puts $module
  puts $wire

  build_synth_wire $outpath $module $wire
}

yosys -import

set outpath [lindex $argv 0]
append outpath "/arithm"

set modules [lindex $argv 1]
set wires [lindex $argv 2]

foreach module [split $modules " "] {
  if {$module == "add"} {
    run_arithm_synth $outpath $module 1
  } else {
    foreach wire [split $wires " "] {
      run_arithm_synth $outpath $module $wire
    }
  }
}
