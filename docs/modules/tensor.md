# Tensor Convolution Accelerator

Zero-latency 2D convolution accelerator for CNN/ML applications.

## Features

- **Zero latency** - 100% combinational logic, no clock cycles
- **Massive parallelism** - 729 simultaneous multiplications (9×9 × 3×3)
- **Smart edge handling** - Automatic corner/border/center detection
- **Pure structural** - No control logic

## Architecture

```
Input: 9×9 image (81 pixels) + 3×3 kernel (9 taps)
       ↓
   mult.v (729 multipliers)
       ↓
   acc.v (routes to position handlers)
       ↓
   on_coin.v (corners: 4 taps)
   on_border.v (edges: 6 taps)
   on_center.v (interior: 9 taps)
       ↓
   adder_tree.v (logarithmic sum)
       ↓
Output: 81 convolution results
```

---

## tensor

### NAME
tensor - 2D convolution accelerator

### SYNOPSIS
```verilog
tensor #(.DATA_WIDTH(w), .IMG_MAX_X(x), .IMG_MAX_Y(y), .CONV_MAX_X(cx), .CONV_MAX_Y(cy))
    instance_name (.img(image), .kernel(kernel), .FIFO(fifo), .result(output));
```

### DESCRIPTION
Top-level convolution module. Performs 2D convolution of an image with a kernel in pure combinational logic. Handles edge cases automatically (corners, borders, center pixels).

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width per pixel |
| IMG_MAX_X | 9 | Image width |
| IMG_MAX_Y | 9 | Image height |
| CONV_MAX_X | 3 | Kernel width |
| CONV_MAX_Y | 3 | Kernel height |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| img | input | IMG_SIZE × DATA_WIDTH | Input image (flattened) |
| kernel | input | CONV_SIZE × DATA_WIDTH | Convolution kernel |
| FIFO | output | IMG_SIZE × CONV_SIZE × DATA_WIDTH | Intermediate products |
| result | output | IMG_SIZE × DATA_WIDTH | Convolution result |

### EXAMPLE
```verilog
// 9×9 image, 3×3 kernel, 32-bit pixels
wire [81*32-1:0] image;
wire [9*32-1:0] kernel;
wire [81*32-1:0] result;
wire [81*9*32-1:0] fifo;

tensor #(.DATA_WIDTH(32), .IMG_MAX_X(9), .IMG_MAX_Y(9))
    conv (.img(image), .kernel(kernel), .FIFO(fifo), .result(result));
```

---

## mult

### NAME
mult - Parallel multiplication engine

### SYNOPSIS
```verilog
mult #(.DATA_WIDTH(w), .IMG_SIZE(is), .CONV_SIZE(cs))
    instance_name (.img(image), .kernel(kernel), .FIFO(products));
```

### DESCRIPTION
Computes all pixel×kernel products in parallel. For a 9×9 image with 3×3 kernel, instantiates 729 multipliers.

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width per element |
| IMG_SIZE | 81 | Number of image pixels |
| CONV_SIZE | 9 | Number of kernel taps |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| img | input | IMG_SIZE × DATA_WIDTH | Input image |
| kernel | input | CONV_SIZE × DATA_WIDTH | Kernel weights |
| FIFO | output | IMG_SIZE × CONV_SIZE × DATA_WIDTH | All products |

---

## acc

### NAME
acc - Accumulator router

### SYNOPSIS
```verilog
acc #(.DATA_WIDTH(w), .IMG_MAX_X(x), .IMG_MAX_Y(y), .CONV_MAX_X(cx), .CONV_MAX_Y(cy))
    instance_name (.FIFO(products), .result(output));
```

### DESCRIPTION
Routes multiplication products to appropriate position handlers (corner, border, or center) and accumulates results.

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width per element |
| IMG_MAX_X | 9 | Image width |
| IMG_MAX_Y | 9 | Image height |
| CONV_MAX_X | 3 | Kernel width |
| CONV_MAX_Y | 3 | Kernel height |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| FIFO | input | IMG_SIZE × CONV_SIZE × DATA_WIDTH | Products from mult |
| result | output | IMG_SIZE × DATA_WIDTH | Accumulated results |

---

## adder_tree

### NAME
adder_tree - Logarithmic adder tree

### SYNOPSIS
```verilog
adder_tree #(.WAY(n), .WIRE(w)) instance_name (.datain(inputs), .dataout(sum));
```

### DESCRIPTION
Sums WAY values using a balanced binary tree of adders. Depth is log2(WAY), providing efficient parallel summation.

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| WAY | 4 | Number of inputs to sum |
| WIRE | 32 | Bit width per input |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| datain | input | WAY × WIRE | Concatenated inputs |
| dataout | output | WIRE | Sum of all inputs |

### EXAMPLE
```verilog
wire [31:0] a, b, c, d, sum;
adder_tree #(.WAY(4), .WIRE(32)) tree (.datain({a, b, c, d}), .dataout(sum));
// sum = a + b + c + d
```

---

## on_coin

### NAME
on_coin - Corner pixel handler

### SYNOPSIS
```verilog
on_coin #(.DATA_WIDTH(w)) instance_name (.in(products), .out(sum));
```

### DESCRIPTION
Handles convolution for corner pixels. Uses 4 kernel taps (2×2 region).

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| in | input | 4 × DATA_WIDTH | 4 products for corner |
| out | output | DATA_WIDTH | Summed result |

---

## on_border

### NAME
on_border - Border pixel handler

### SYNOPSIS
```verilog
on_border #(.DATA_WIDTH(w)) instance_name (.in(products), .out(sum));
```

### DESCRIPTION
Handles convolution for border pixels (non-corner edges). Uses 6 kernel taps (2×3 or 3×2 region).

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| in | input | 6 × DATA_WIDTH | 6 products for border |
| out | output | DATA_WIDTH | Summed result |

---

## on_center

### NAME
on_center - Center pixel handler

### SYNOPSIS
```verilog
on_center #(.DATA_WIDTH(w)) instance_name (.in(products), .out(sum));
```

### DESCRIPTION
Handles convolution for interior pixels. Uses all 9 kernel taps (full 3×3 region).

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| in | input | 9 × DATA_WIDTH | 9 products for center |
| out | output | DATA_WIDTH | Summed result |

---

## mmul

### NAME
mmul - Matrix multiplication

### SYNOPSIS
```verilog
mmul #(.DATA_WIDTH(w), .DIM_X(x), .DIM_Y(y), .DIM_Z(z))
    instance_name (.A(matrix_a), .B(matrix_b), .C(result));
```

### DESCRIPTION
Matrix multiplication C = A × B. A is DIM_X×DIM_Y, B is DIM_Y×DIM_Z, result C is DIM_X×DIM_Z.

### PARAMETERS
| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 32 | Bit width per element |
| DIM_X | 3 | Rows of A, rows of C |
| DIM_Y | 3 | Cols of A, rows of B |
| DIM_Z | 3 | Cols of B, cols of C |

### PORTS
| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| A | input | DIM_X × DIM_Y × DATA_WIDTH | Matrix A |
| B | input | DIM_Y × DIM_Z × DATA_WIDTH | Matrix B |
| C | output | DIM_X × DIM_Z × DATA_WIDTH | Result matrix |

### EXAMPLE
```verilog
// 3×3 matrix multiplication
wire [9*32-1:0] A, B, C;
mmul #(.DATA_WIDTH(32), .DIM_X(3), .DIM_Y(3), .DIM_Z(3))
    matmul (.A(A), .B(B), .C(C));
```

---

Location: `src/tensor/`

See also: [src/tensor/README.md](https://gitlab.com/jalcim/logilib/-/blob/master/src/tensor/README.md)
