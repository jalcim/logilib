#!/bin/bash

max_threads=8
binary="./build/cosim/Vgate-tests"
validators=$( $binary --list_content 2>&1| grep Vgate_not )

running=0
pids=()

for test in $validators; do
  # Wait if max_threads reached
  while [ ${#pids[@]} -ge $max_threads ]; do
    for i in "${!pids[@]}"; do
      if ! kill -0 "${pids[i]}" 2>/dev/null; then
        unset 'pids[i]'
      fi
    done
    # Remove empty indices and compact array
    pids=("${pids[@]}")
    sleep 0.1
  done

  # Launch test in background
  $binary --run_test=$test &
  pids+=($!)
done

# Wait all remaining
wait
