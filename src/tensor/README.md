# Hardware 2D Convolution Accelerator

Parallel convolution engine with zero latency and 729 simultaneous operations.

## 🎯 What Does This Do?

## ⚡ ZERO LOGIC GENERATION - PURE WIRING ⚡
**This design uses NO control logic whatsoever.**
**Everything is preprocessed and handled by direct wiring connections.**
**The hardware is 100% combinational - zero latency, zero delays, just pure parallel multiplication and addition.**

```mermaid
graph LR
    A[9×9 Image] --> B[🔥 Convolution Engine]
    C[3×3 Filter] --> B
    B --> D[729 Results]

```

Takes a 9×9 image + 3×3 filter → produces all convolution results instantly

## How It Works

```mermaid
flowchart LR
    subgraph Input [" 📥 INPUT "]
        A["🖼️ 9×9 Image<br/>81 pixels"]
        B["🔢 3×3 Kernel<br/>9 weights"]
    end

    subgraph Processing [" ⚡ PROCESSING "]
        C["🔄 729 Multipliers<br/>ALL PARALLEL"]
        D["📡 Direct Wiring<br/>NO DELAYS"]
    end

    subgraph Output [" 📤 OUTPUT "]
        E["📊 81 Results<br/>INSTANT"]
    end

    A ===> C
    B ===> C
    C ===> D
    D ===> E

    classDef inputStyle fill:#e1f5fe,stroke:#01579b,stroke-width:3px,color:#000
    classDef processStyle fill:#f3e5f5,stroke:#4a148c,stroke-width:3px,color:#000
    classDef outputStyle fill:#e8f5e8,stroke:#1b5e20,stroke-width:3px,color:#000

    class A,B inputStyle
    class C,D processStyle
    class E outputStyle

```

## 🧠 The Smart Coordinate System

```mermaid
graph LR
    subgraph "Position Calculation"
        A[result_index] --> B[Where in output?]
        C[kernel_index] --> D[Which filter tap?]
        B --> E[Calculate source pixel]
        D --> E
        E --> F{Inside image?}
        F -->|Yes| G[Multiply & Store]
        F -->|No| H[Store z for dead logic elimination]
    end

```

## 📸 Visual Example

### Input Image Layout
```mermaid
graph TD
    subgraph "9×9 Image"
        A[0  1  2  3  4  5  6  7  8]
        B[9  10 11 12 13 14 15 16 17]
        C[18 19 20 21 22 23 24 25 26]
        D[27 28 29 30 31 32 33 34 35]
        E[36 37 38 39 40 41 42 43 44]
        F[45 46 47 48 49 50 51 52 53]
        G[54 55 56 57 58 59 60 61 62]
        H[63 64 65 66 67 68 69 70 71]
        I[72 73 74 75 76 77 78 79 80]
    end
```

### 3×3 Kernel
```mermaid
graph TD
    subgraph "Filter Weights"
        J[0 1 2]
        K[3 4 5]
        L[6 7 8]
    end
```

## 🏗️ Module Architecture

### Core Files
- **tensor.v** - **Recursive index module** that generates 81 instances (one per output pixel)
- **mult.v** - **Recursive multiplication stage** that generates 9 instances per pixel (one per kernel tap)
- **acc.v** - Accumulator module that routes to position-specific handlers
- **adder.v** - Tree-based adder for efficient parallel summation
- **on_center.v** - Handles 9-tap convolution for center pixels
- **on_border.v** - Handles 6-tap convolution for border pixels
- **on_coin.v** - Handles 4-tap convolution for corner pixels
- **test.v** - Test bench with comprehensive validation

### Recursive Architecture
```mermaid
graph TD
    A[test.v] --> B[tensor.v]
    B --> C[mult.v]
    B --> D[acc.v]
    B -.-> B[🔄 recursive]
    C -.-> C[🔄 recursive]
    C --> I[mmul.v]
    D --> E[on_center.v]
    D --> F[on_border.v]
    D --> G[on_coin.v]
    E --> H[adder.v]
    F --> H
    G --> H
    I --> H
```

## ⚡ Performance

```mermaid
graph LR
    A[🎯 Zero Latency] --> B[⚡ 729 Operations]
    B --> C[🔧 500 Multipliers]
    C --> D[🚀 Instant Results]

```

## 🛠️ Usage

### 1. Run Simulation
```bash
iverilog -o sim test.v tensor.v adder.v acc.v mult.v on_*.v && ./sim
```

### 2. Check Results
```
result[0] = 160   # Corner: 4 taps summed (skip border pixels)
result[1] = 300   # Border: 6 taps summed (skip one edge)
result[10] = 540  # Center: 9 taps summed (full kernel)
...
result[80] = 1520 # Bottom-right corner
```

### 3. Visual Convolution Examples

![Hand-drawn convolution schematic](tensor.jpeg)

#### Convolution Types Visualization
```mermaid
graph TD
    subgraph "CORNER Example (Position 0)"
        A1[0 1<br/>9 10] --> C1[Result = 160]
    end

    subgraph "BORDER Example (Position 1)"
        A2[1 2<br/>10 11<br/>19 20] --> C2[Result = 300]
    end

    subgraph "CENTER Example (Position 10)"
        A3[0 1 2<br/>9 10 11<br/>18 19 20] --> C3[Result = 540]
    end

    classDef cornerData fill:#ff9999,stroke:#ff6666,stroke-width:2px,color:#000
    classDef borderData fill:#99ccff,stroke:#6699ff,stroke-width:2px,color:#000
    classDef centerData fill:#99ff99,stroke:#66ff66,stroke-width:2px,color:#000

    classDef cornerResult fill:#ffdddd,stroke:#ffaaaa,stroke-width:3px,color:#000
    classDef borderResult fill:#ddeeff,stroke:#aaccff,stroke-width:3px,color:#000
    classDef centerResult fill:#ddffdd,stroke:#aaffaa,stroke-width:3px,color:#000

    class A1 cornerData
    class A2 borderData
    class A3 centerData

    class C1 cornerResult
    class C2 borderResult
    class C3 centerResult

```

#### 3×3 Kernel Layout
```mermaid
graph TD
    subgraph "Kernel Weights"
        K[0 1 2<br/>3 4 5<br/>6 7 8]
    end

    subgraph "Corner Taps (4 used)"
        C[❌ ❌ ❌<br/>❌ ✅ ✅<br/>❌ ✅ ✅]
    end

    subgraph "Border Taps (6 used)"
        B[❌ ❌ ❌<br/>✅ ✅ ✅<br/>✅ ✅ ✅]
    end

    subgraph "Center Taps (9 used)"
        A[✅ ✅ ✅<br/>✅ ✅ ✅<br/>✅ ✅ ✅]
    end

```

### 4. Customize Size
```verilog
parameter IMG_MAX_X = 16;   // Bigger image
parameter CONV_MAX_X = 5;   // Bigger filter
```

## 🔍 Architecture Deep Dive

### Double Recursive Architecture Explained

The system uses **two levels of recursion** to generate all 729 operations:

#### 1. Index Recursion (tensor.v) - Advances result_index
**Purpose**: Process convolution for ALL image cells (0 to 80)
**Recursion**: Increments `result_index` to cover every output pixel
```verilog
if (result_index < IMG_SIZE)
    index #(.result_index(result_index + 1)) genblk_index (img, kernel, FIFO, result);
```

#### 2. Mult Recursion (mult.v) - Advances kernel_index
**Purpose**: Process ALL kernel multiplications (0 to 8) for each image cell
**Recursion**: Increments `kernel_index` to cover every kernel tap
```verilog
if (kernel_index < CONV_SIZE - 1)
    mult #(.kernel_index(kernel_index+1)) mult_stage(img, kernel, FIFO, result);
```

**Key Insight**:
- `index` recursion → covers all **image positions** (result_index 0→80)
- `mult` recursion → covers all **kernel taps** (kernel_index 0→8) for each position
- Result: 81 × 9 = **729 parallel multiplications**

```mermaid
graph TD
    subgraph "Level 1: Index Recursion (81 instances)"
        A[index result_index=0]
        A1[index result_index=1]
        A2[index result_index=2]
        A3[... 81 total instances ...]
        A80[index result_index=80]
    end

    subgraph "Level 2: Mult Recursion (9 per index = 729 total)"
        B[mult kernel_index=0]
        B1[mult kernel_index=1]
        B2[mult kernel_index=2]
        B8[mult kernel_index=8]
    end

    subgraph "Result: 729 Parallel Operations"
        C[Every pixel×kernel combination<br/>computed simultaneously]
    end

    A --> B
    A --> B1
    A --> B2
    A --> B8
    A1 --> B
    A2 --> B
    B --> C
    B1 --> C
    B2 --> C
    B8 --> C
```

### Smart Addressing & Coordinate Transform

```mermaid
graph LR
    subgraph "Input Mapping"
        A[result_index] --> B[result_y = idx ÷ 9<br/>result_x = idx mod 9]
        C[kernel_index] --> D[kernel_y = idx ÷ 3<br/>kernel_x = idx mod 3]
    end

    subgraph "Source Calculation"
        B --> E[img_y = result_y + kernel_y - 1]
        D --> E
        B --> F[img_x = result_x + kernel_x - 1]
        D --> F
        E --> G[img_index = img_y × 9 + img_x]
        F --> G
    end

    subgraph "Boundary Check"
        G --> H{img_y ≥ 0 && img_y < 9<br/>&&<br/>img_x ≥ 0 && img_x < 9}
        H -->|True| I[Extract img pixel]
        H -->|False| J[Skip: Outside image]
    end

```

### Data Flow Architecture

```mermaid
graph TD
    subgraph "Raw Data"
        A[9×9 Image<br/>81 pixels]
        B[3×3 Kernel<br/>9 weights]
    end

    subgraph "Processing Layer"
        C[729 Parallel<br/>Multiplications]
        D[FIFO Storage<br/>81×9 = 729 values]
    end

    subgraph "Aggregation Layer"
        E[Position Detection<br/>Corner/Border/Center]
        F[Selective Summation<br/>4/6/9 taps]
        G[81 Adder Trees]
    end

    subgraph "Final Output"
        H[result 0..80<br/>81 convolution results]
    end

    A --> C
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    G --> H

```

## 🎯 Why This Rocks

| Feature | Benefit |
|---------|---------|
| 🚀 **Zero Latency** | Results available instantly |
| ⚡ **Massive Parallel** | 729 operations at once |
| 🔧 **No Control Logic** | Just multipliers + wires |
| 📦 **Easy Integration** | Drop into any ASIC design |
| 🎯 **Configurable** | Change sizes easily |

## 🌟 Applications

```mermaid
mindmap
  root((Convolution Engine))
    Deep Learning
      CNN layers
      Edge detection
      Feature maps
    Image Processing
      Blur filters
      Sharpening
      Noise reduction
    Computer Vision
      Object detection
      Pattern matching
      Real-time video
    Signal Processing
      2D filtering
      Frequency analysis
      Correlation
```

## License

AGPL v3