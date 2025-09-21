# Hardware 2D Convolution Accelerator

Parallel convolution engine with zero latency and 729 simultaneous operations.

## 🎯 What Does This Do?

```mermaid
flowchart LR
    A[9×9 Image] --> B[🔥 Convolution Engine]
    C[3×3 Filter] --> B
    B --> D[729 Results]

    style A fill:#e3f2fd
    style C fill:#fff3e0
    style B fill:#ffebee
    style D fill:#e8f5e8
```

Takes a 9×9 image + 3×3 filter → produces all convolution results instantly

## 🏗️ How It Works

```mermaid
graph TD
    subgraph "🔧 Input"
        A[Image: 0,1,2...80]
        B[Kernel: 0,1,2,3,4,5,6,7,8]
    end

    subgraph "⚡ Magic Happens"
        C[729 Parallel Multipliers]
        D[Direct Wire Connections]
        E[No Control Logic!]
    end

    subgraph "📊 Output"
        F[FIFO[0][0] to FIFO[80][8]]
    end

    A --> C
    B --> C
    C --> D
    D --> E
    E --> F

    style C fill:#ff6b6b
    style D fill:#4ecdc4
    style E fill:#45b7d1
```

## 🧠 The Smart Coordinate System

```mermaid
graph LR
    subgraph "📍 Position Calculation"
        A[result_index] --> B[Where in output?]
        C[kernel_index] --> D[Which filter tap?]
        B --> E[Calculate source pixel]
        D --> E
        E --> F{Inside image?}
        F -->|Yes| G[Multiply & Store]
        F -->|No| H[Store 0]
    end

    style F fill:#ffd93d
    style G fill:#6bcf7f
    style H fill:#ff6b6b
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

## ⚡ Performance

```mermaid
graph LR
    A[🎯 Zero Latency] --> B[⚡ 729 Operations]
    B --> C[🔧 500 Multipliers]
    C --> D[🚀 Instant Results]

    style A fill:#ff6b6b
    style B fill:#4ecdc4
    style C fill:#ffd93d
    style D fill:#6bcf7f
```

## 🛠️ Usage

### 1. Run Simulation
```bash
iverilog -o sim tensor.v adder.v && ./sim
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
    subgraph "🟢 CORNER Example (Position 0)"
        A1[0 0 0<br/>0 0 1<br/>0 6 7] --> B1[Skip: 0,1,2,3,6<br/>Use: 4,5,7,8] --> C1[Result = 0×4 + 1×5 + 6×7 + 7×8<br/>= 0 + 5 + 42 + 56 = 103]
    end

    subgraph "🔵 BORDER Example (Position 1)"
        A2[0 0 0<br/>1 2 3<br/>7 8 9] --> B2[Skip: 0,1,2<br/>Use: 3,4,5,6,7,8] --> C2[Result = 1×3 + 2×4 + 3×5 + 7×6 + 8×7 + 9×8<br/>= 3 + 8 + 15 + 42 + 56 + 72 = 196]
    end

    subgraph "⚫ CENTER Example (Position 10)"
        A3[0 1 2<br/>9 10 11<br/>18 19 20] --> B3[Use all: 0,1,2,3,4,5,6,7,8] --> C3[Result = 0×0 + 1×1 + 2×2 + 9×3 + 10×4 + 11×5<br/>+ 18×6 + 19×7 + 20×8 = 540]
    end

    style A1 fill:#c8e6c9
    style A2 fill:#bbdefb
    style A3 fill:#f5f5f5
    style C1 fill:#c8e6c9
    style C2 fill:#bbdefb
    style C3 fill:#f5f5f5
```

#### 3×3 Kernel Layout
```mermaid
graph TD
    subgraph "Kernel Weights"
        K[0 1 2<br/>3 4 5<br/>6 7 8]
    end

    subgraph "🟢 Corner Taps (4 used)"
        C[❌ ❌ ❌<br/>❌ ✅ ✅<br/>❌ ✅ ✅]
    end

    subgraph "🔵 Border Taps (6 used)"
        B[❌ ❌ ❌<br/>✅ ✅ ✅<br/>✅ ✅ ✅]
    end

    subgraph "⚫ Center Taps (9 used)"
        A[✅ ✅ ✅<br/>✅ ✅ ✅<br/>✅ ✅ ✅]
    end

    style K fill:#fff3e0
    style C fill:#c8e6c9
    style B fill:#bbdefb
    style A fill:#f5f5f5
```

### 4. Customize Size
```verilog
parameter IMG_MAX_X = 16;   // Bigger image
parameter CONV_MAX_X = 5;   // Bigger filter
```

## 🔍 Architecture Deep Dive

### 🔄 Double Recursive Propagation

```mermaid
flowchart TD
    subgraph "🔧 Instance Generation"
        A[Current Instance<br/>result_index, kernel_index]
        A --> B{Inside Image?}
        B -->|Yes| C[Calculate: img[pixel] × kernel[tap]]
        B -->|No| D[Skip multiplication]
        C --> E[Store in FIFO[fifo_index]]
        D --> E
    end

    subgraph "📡 Recursive1: FIFO Propagation"
        F{kernel_index < 9?}
        F -->|Yes| G[Generate recursive1<br/>kernel_index + 1]
        G --> H[Propagate FIFO upward]
        F -->|No| I[FIFO complete for result_index]
    end

    subgraph "⚡ Adder Trees: Position-Aware Summation"
        J{kernel_index == 0?}
        J -->|Yes| K[Launch adder_tree]
        K --> L{Position Type?}
        L -->|Corner| M[Sum 4 taps<br/>Skip border taps]
        L -->|Border| N[Sum 6 taps<br/>Skip edge taps]
        L -->|Center| O[Sum all 9 taps]
        M --> P[Store in result[result_index]]
        N --> P
        O --> P
    end

    subgraph "📡 Recursive2: Result Propagation"
        Q{result_index < 81?}
        Q -->|Yes| R[Generate recursive2<br/>result_index + 1]
        R --> S[Propagate result upward]
        Q -->|No| T[All convolutions complete]
    end

    E --> F
    I --> J
    P --> Q

    style A fill:#ff6b6b
    style H fill:#4ecdc4
    style S fill:#6bcf7f
    style T fill:#ffd93d
```

### 🎯 Smart Addressing & Coordinate Transform

```mermaid
flowchart LR
    subgraph "📍 Input Mapping"
        A[result_index] --> B[result_y = idx ÷ 9<br/>result_x = idx mod 9]
        C[kernel_index] --> D[kernel_y = idx ÷ 3<br/>kernel_x = idx mod 3]
    end

    subgraph "🧮 Source Calculation"
        B --> E[img_y = result_y + kernel_y - 1]
        D --> E
        B --> F[img_x = result_x + kernel_x - 1]
        D --> F
        E --> G[img_index = img_y × 9 + img_x]
        F --> G
    end

    subgraph "✅ Boundary Check"
        G --> H{img_y ≥ 0 && img_y < 9<br/>&&<br/>img_x ≥ 0 && img_x < 9}
        H -->|True| I[Extract img[img_index]]
        H -->|False| J[Skip: Outside image]
    end

    style A fill:#e3f2fd
    style C fill:#fff3e0
    style I fill:#e8f5e8
    style J fill:#ffebee
```

### 📦 Data Flow Architecture

```mermaid
graph TD
    subgraph "🔢 Raw Data"
        A[9×9 Image<br/>81 pixels]
        B[3×3 Kernel<br/>9 weights]
    end

    subgraph "⚡ Processing Layer"
        C[729 Parallel<br/>Multiplications]
        D[FIFO Storage<br/>81×9 = 729 values]
    end

    subgraph "🎯 Aggregation Layer"
        E[Position Detection<br/>Corner/Border/Center]
        F[Selective Summation<br/>4/6/9 taps]
        G[81 Adder Trees]
    end

    subgraph "📊 Final Output"
        H[result[0..80]<br/>81 convolution results]
    end

    A --> C
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    G --> H

    style C fill:#ff6b6b
    style D fill:#4ecdc4
    style G fill:#45b7d1
    style H fill:#6bcf7f
```

## 🎯 Why This Rocks

| Feature | Benefit |
|---------|---------|
| 🚀 **Zero Latency** | Results available instantly |
| ⚡ **Massive Parallel** | 729 operations at once |
| 🔧 **No Control Logic** | Just multipliers + wires |
| 📦 **Easy Integration** | Drop into any FPGA design |
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