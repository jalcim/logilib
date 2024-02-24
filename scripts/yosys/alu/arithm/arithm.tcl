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

puts $outpath
puts $modules
puts $wires

run_arithm_synth $outpath $modules $wires
