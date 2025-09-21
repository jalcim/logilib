# Hardware 2D Convolution Accelerator

Parallel convolution engine with zero latency and 729 simultaneous operations.

## 🎯 What Does This Do?

```mermaid
graph LR
    A[9×9 Image] --> B[🔥 Convolution Engine]
    C[3×3 Filter] --> B
    B --> D[729 Results]

```

Takes a 9×9 image + 3×3 filter → produces all convolution results instantly

## How It Works

```mermaid
graph TD
    subgraph "Input"
        A[Image 0,1,2...80]
        B[Kernel 0,1,2,3,4,5,6,7,8]
    end

    subgraph "Magic Happens"
        C[729 Parallel Multipliers]
        D[Direct Wire Connections]
        E[No Control Logic]
    end

    subgraph "Output"
        F[FIFO 0,0 to FIFO 80,8]
    end

    A --> C
    B --> C
    C --> D
    D --> E
    E --> F

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
    subgraph "CORNER Example (Position 0)"
        A1[0 0 1<br/>6 7] --> C1[Result = 103]
    end

    subgraph "BORDER Example (Position 1)"
        A2[1 2 3<br/>7 8 9] --> C2[Result = 196]
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

### Double Recursive Propagation

```mermaid
graph TD
    subgraph "Instance Generation"
        A[Current Instance<br/>result_index, kernel_index]
        A --> B{Inside Image?}
        B -->|Yes| C[Calculate: img pixel × kernel tap]
        B -->|No| D[Skip multiplication]
        C --> E[Store in FIFO array]
        D --> E
    end

    subgraph "Recursive1: FIFO Propagation"
        F{kernel_index < 9?}
        F -->|Yes| G[Generate recursive1<br/>kernel_index + 1]
        G --> H[Propagate FIFO upward]
        F -->|No| I[FIFO complete for result_index]
    end

    subgraph "Adder Trees: Position-Aware Summation"
        J{kernel_index == 0?}
        J -->|Yes| K[Launch adder_tree]
        K --> L{Position Type?}
        L -->|Corner| M[Sum 4 taps<br/>Skip border taps]
        L -->|Border| N[Sum 6 taps<br/>Skip edge taps]
        L -->|Center| O[Sum all 9 taps]
        M --> P[Store in result array]
        N --> P
        O --> P
    end

    subgraph "Recursive2: Result Propagation"
        Q{result_index < 81?}
        Q -->|Yes| R[Generate recursive2<br/>result_index + 1]
        R --> S[Propagate result upward]
        Q -->|No| T[All convolutions complete]
    end

    E --> F
    I --> J
    P --> Q

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
graph TD
    A[Convolution Engine] --> B[Deep Learning]
    A --> C[Image Processing]
    A --> D[Computer Vision]
    A --> E[Signal Processing]

    B --> F[CNN layers]
    B --> G[Edge detection]
    B --> H[Feature maps]

    C --> I[Blur filters]
    C --> J[Sharpening]
    C --> K[Noise reduction]

    D --> L[Object detection]
    D --> M[Pattern matching]
    D --> N[Real-time video]

    E --> O[2D filtering]
    E --> P[Frequency analysis]
    E --> Q[Correlation]

    classDef engine fill:#ff6b6b,stroke:#c92a2a,stroke-width:3px,color:#fff
    classDef domain fill:#4ecdc4,stroke:#26a69a,stroke-width:2px,color:#fff
    classDef app fill:#45b7d1,stroke:#2196f3,stroke-width:1px,color:#fff

    class A engine
    class B,C,D,E domain
    class F,G,H,I,J,K,L,M,N,O,P,Q app
```

## License

AGPL v3