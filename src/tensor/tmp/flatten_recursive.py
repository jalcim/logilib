#!/usr/bin/env python3
"""
Script to flatten recursive Verilog module instantiations.
Converts tensor.v recursive design into explicit instantiations.
"""

import re
import sys
from typing import List, Tuple, Dict

def parse_parameters(verilog_content: str) -> Dict[str, int]:
    """Extract parameter values from Verilog module."""
    params = {}

    # Find parameter declarations
    param_pattern = r'parameter\s+(\w+)\s*=\s*(\d+)'
    for match in re.finditer(param_pattern, verilog_content):
        name, value = match.groups()
        params[name] = int(value)

    # Calculate derived parameters
    if 'IMG_MAX_X' in params and 'IMG_MAX_Y' in params:
        params['IMG_SIZE'] = params['IMG_MAX_X'] * params['IMG_MAX_Y']
    if 'CONV_MAX_X' in params and 'CONV_MAX_Y' in params:
        params['CONV_SIZE'] = params['CONV_MAX_X'] * params['CONV_MAX_Y']

    return params

def generate_coordinate_logic(result_index: int, kernel_index: int, params: Dict[str, int]) -> str:
    """Generate coordinate calculation logic for specific indices."""
    IMG_MAX_X = params['IMG_MAX_X']
    IMG_MAX_Y = params['IMG_MAX_Y']
    CONV_MAX_X = params['CONV_MAX_X']
    CONV_MAX_Y = params['CONV_MAX_Y']

    result_y = result_index // IMG_MAX_X
    result_x = result_index % IMG_MAX_X
    kernel_y = kernel_index // CONV_MAX_X
    kernel_x = kernel_index % CONV_MAX_X
    img_y = result_y + kernel_y - 1
    img_x = result_x + kernel_x - 1
    img_index = img_y * IMG_MAX_X + img_x

    is_inside = (img_y >= 0 and img_y < IMG_MAX_Y and
                 img_x >= 0 and img_x < IMG_MAX_X)

    is_left = (result_x == 0)
    is_right = (result_x == IMG_MAX_X - 1)
    is_top = (result_y == 0)
    is_bot = (result_y == IMG_MAX_Y - 1)

    is_in_top_left = is_top and is_left
    is_in_top_right = is_top and is_right
    is_in_bot_left = is_bot and is_left
    is_in_bot_right = is_bot and is_right
    is_in_coin = is_in_top_left or is_in_top_right or is_in_bot_left or is_in_bot_right

    is_in_border_left = is_left and (not is_top and not is_bot)
    is_in_border_right = is_right and (not is_top and not is_bot)
    is_in_border_top = is_top and (not is_left and not is_right)
    is_in_border_bot = is_bot and (not is_left and not is_right)
    is_in_border = is_in_border_left or is_in_border_right or is_in_border_top or is_in_border_bot

    return {
        'result_y': result_y, 'result_x': result_x,
        'kernel_y': kernel_y, 'kernel_x': kernel_x,
        'img_y': img_y, 'img_x': img_x, 'img_index': img_index,
        'is_inside': is_inside, 'is_in_coin': is_in_coin, 'is_in_border': is_in_border,
        'is_in_top_left': is_in_top_left, 'is_in_top_right': is_in_top_right,
        'is_in_bot_left': is_in_bot_left, 'is_in_bot_right': is_in_bot_right,
        'is_in_border_left': is_in_border_left, 'is_in_border_right': is_in_border_right,
        'is_in_border_top': is_in_border_top, 'is_in_border_bot': is_in_border_bot
    }

def generate_fifo_logic(result_index: int, kernel_index: int, coords: Dict, params: Dict[str, int]) -> str:
    """Generate FIFO assignment logic for specific instance."""
    if not coords['is_inside']:
        return ""

    DATA_WIDTH = params['DATA_WIDTH']
    fifo_index = result_index * params['CONV_SIZE'] + kernel_index
    pixel_start = coords['img_index'] * DATA_WIDTH
    kernel_start = kernel_index * DATA_WIDTH
    fifo_start = fifo_index * DATA_WIDTH

    return f"""
  // Instance r{result_index}_k{kernel_index}: FIFO logic
  assign p_img_{result_index}_{kernel_index} = img[{pixel_start} +: {DATA_WIDTH}];
  assign p_kernel_{result_index}_{kernel_index} = kernel[{kernel_start} +: {DATA_WIDTH}];
  assign w_fifo_{result_index}_{kernel_index} = p_img_{result_index}_{kernel_index} * p_kernel_{result_index}_{kernel_index};
  assign FIFO[{fifo_start} +: {DATA_WIDTH}] = w_fifo_{result_index}_{kernel_index};
"""

def generate_adder_logic(result_index: int, coords: Dict, params: Dict[str, int]) -> str:
    """Generate adder tree logic for specific result pixel."""
    DATA_WIDTH = params['DATA_WIDTH']
    CONV_SIZE = params['CONV_SIZE']

    if coords['is_in_coin']:
        # Select 4 taps based on corner position
        if coords['is_in_top_left']:
            taps = [8, 7, 5, 4]
        elif coords['is_in_top_right']:
            taps = [7, 6, 4, 3]
        elif coords['is_in_bot_left']:
            taps = [5, 4, 2, 1]
        else:  # bot_right
            taps = [4, 3, 1, 0]
        way = 4
    elif coords['is_in_border']:
        # Select 6 taps based on border position
        if coords['is_in_border_left']:
            taps = [8, 7, 5, 4, 2, 1]
        elif coords['is_in_border_right']:
            taps = [7, 6, 4, 3, 1, 0]
        elif coords['is_in_border_top']:
            taps = [8, 7, 6, 5, 4, 3]
        else:  # border_bot
            taps = [5, 4, 3, 2, 1, 0]
        way = 6
    else:
        # Center: use all 9 taps
        taps = [8, 7, 6, 5, 4, 3, 2, 1, 0]
        way = 9

    # Generate FIFO connections
    fifo_connections = []
    for tap in taps:
        fifo_idx = result_index * CONV_SIZE + tap
        fifo_connections.append(f"FIFO[{fifo_idx * DATA_WIDTH} +: {DATA_WIDTH}]")

    fifo_concat = "{" + ", ".join(fifo_connections) + "}"

    return f"""
  // Instance r{result_index}: Adder tree (WAY={way})
  adder_tree #(.WAY({way}), .WIRE({DATA_WIDTH}))
    adder_r{result_index} ({fifo_concat}, result[{result_index * DATA_WIDTH} +: {DATA_WIDTH}]);
"""

def flatten_recursive_module(input_file: str, output_file: str):
    """Main function to flatten recursive Verilog module."""

    # Read input file
    with open(input_file, 'r') as f:
        content = f.read()

    # Parse parameters
    params = parse_parameters(content)
    print(f"Parsed parameters: {params}")

    IMG_SIZE = params['IMG_SIZE']
    CONV_SIZE = params['CONV_SIZE']
    DATA_WIDTH = params['DATA_WIDTH']

    # Generate flattened module
    output_lines = []

    # Module header
    output_lines.append(f"""module index_flat(
  input [{IMG_SIZE * DATA_WIDTH - 1} : 0] img,
  input [{CONV_SIZE * DATA_WIDTH - 1} : 0] kernel,
  output [{(IMG_SIZE * CONV_SIZE) * DATA_WIDTH - 1}: 0] FIFO,
  output [{IMG_SIZE * DATA_WIDTH - 1}:0] result
);

  parameter DATA_WIDTH = {DATA_WIDTH};
  parameter IMG_MAX_X = {params['IMG_MAX_X']};
  parameter IMG_MAX_Y = {params['IMG_MAX_Y']};
  parameter CONV_MAX_X = {params['CONV_MAX_X']};
  parameter CONV_MAX_Y = {params['CONV_MAX_Y']};
  localparam IMG_SIZE = {IMG_SIZE};
  localparam CONV_SIZE = {CONV_SIZE};
""")

    # Generate wire declarations
    output_lines.append("\n  // Wire declarations")
    for result_index in range(IMG_SIZE):
        for kernel_index in range(CONV_SIZE):
            coords = generate_coordinate_logic(result_index, kernel_index, params)
            if coords['is_inside']:
                output_lines.append(f"  wire [{DATA_WIDTH-1}:0] p_img_{result_index}_{kernel_index};")
                output_lines.append(f"  wire [{DATA_WIDTH-1}:0] p_kernel_{result_index}_{kernel_index};")
                output_lines.append(f"  wire [{DATA_WIDTH-1}:0] w_fifo_{result_index}_{kernel_index};")

    # Generate FIFO logic for all instances
    output_lines.append("\n  // FIFO assignments")
    for result_index in range(IMG_SIZE):
        for kernel_index in range(CONV_SIZE):
            coords = generate_coordinate_logic(result_index, kernel_index, params)
            if coords['is_inside']:
                output_lines.append(generate_fifo_logic(result_index, kernel_index, coords, params))

    # Generate adder trees for result calculation
    output_lines.append("\n  // Result calculations")
    for result_index in range(IMG_SIZE):
        coords = generate_coordinate_logic(result_index, 0, params)  # kernel_index=0 for position calc
        output_lines.append(generate_adder_logic(result_index, coords, params))

    output_lines.append("\nendmodule")

    # Write output file
    with open(output_file, 'w') as f:
        f.write('\n'.join(output_lines))

    print(f"Generated flattened module: {output_file}")
    print(f"Total instances: {IMG_SIZE * CONV_SIZE}")
    print(f"Active instances: {sum(1 for r in range(IMG_SIZE) for k in range(CONV_SIZE) if generate_coordinate_logic(r, k, params)['is_inside'])}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python flatten_recursive.py input.v output.v")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    flatten_recursive_module(input_file, output_file)