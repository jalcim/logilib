# Accélérateur Hardware de Convolution 2D

Moteur de convolution parallèle avec latence zéro et 729 opérations simultanées.

## 🎯 Que fait ce module ?

```mermaid
graph LR
    A[Image 9×9] --> B[🔥 Moteur Convolution]
    C[Filtre 3×3] --> B
    B --> D[729 Résultats]

```

Prend une image 9×9 + filtre 3×3 → produit tous les résultats de convolution instantanément

## Comment ça marche

```mermaid
graph TD
    subgraph "Entrées"
        A[Image 0,1,2...80]
        B[Kernel 0,1,2,3,4,5,6,7,8]
    end

    subgraph "La magie opère"
        C[729 Multiplieurs Parallèles]
        D[Connexions Fil Direct]
        E[Aucune Logique de Contrôle]
    end

    subgraph "Sortie"
        F[FIFO 0,0 vers FIFO 80,8]
    end

    A --> C
    B --> C
    C --> D
    D --> E
    E --> F

```

## 🧠 Système de Coordonnées Intelligent

```mermaid
graph LR
    subgraph "Calcul de Position"
        A[result_index] --> B[Où dans la sortie ?]
        C[kernel_index] --> D[Quel tap du filtre ?]
        B --> E[Calculer pixel source]
        D --> E
        E --> F{Dans l'image ?}
        F -->|Oui| G[Multiplier & Stocker]
        F -->|Non| H[Stocker z pour élimination logique morte]
    end

```

## 📸 Exemple Visuel

### Disposition Image d'Entrée
```mermaid
graph TD
    subgraph "Image 9×9"
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

### Kernel 3×3
```mermaid
graph TD
    subgraph "Poids du Filtre"
        J[0 1 2]
        K[3 4 5]
        L[6 7 8]
    end
```

## ⚡ Performances

```mermaid
graph LR
    A[🎯 Latence Zéro] --> B[⚡ 729 Opérations]
    B --> C[🔧 500 Multiplieurs]
    C --> D[🚀 Résultats Instantanés]

```

## 🛠️ Utilisation

### 1. Lancer la Simulation
```bash
iverilog -o sim tensor.v adder.v && ./sim
```

### 2. Vérifier les Résultats
```
result[0] = 160   # Coin: 4 taps sommés (évite bordures)
result[1] = 300   # Bordure: 6 taps sommés (évite un côté)
result[10] = 540  # Centre: 9 taps sommés (kernel complet)
...
result[80] = 1520 # Coin bas-droite
```

### 3. Exemples Visuels de Convolution

![Schéma convolution dessiné à la main](tensor.jpeg)

#### Visualisation Types de Convolution
```mermaid
graph TD
    subgraph "COIN Exemple (Position 0)"
        A1[0 0 1<br/>6 7] --> C1[Résultat = 103]
    end

    subgraph "BORDURE Exemple (Position 1)"
        A2[1 2 3<br/>7 8 9] --> C2[Résultat = 196]
    end

    subgraph "CENTRE Exemple (Position 10)"
        A3[0 1 2<br/>9 10 11<br/>18 19 20] --> C3[Résultat = 540]
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

#### Disposition Kernel 3×3
```mermaid
graph TD
    subgraph "Poids Kernel"
        K[0 1 2<br/>3 4 5<br/>6 7 8]
    end

    subgraph "Taps Coin (4 utilisés)"
        C[❌ ❌ ❌<br/>❌ ✅ ✅<br/>❌ ✅ ✅]
    end

    subgraph "Taps Bordure (6 utilisés)"
        B[❌ ❌ ❌<br/>✅ ✅ ✅<br/>✅ ✅ ✅]
    end

    subgraph "Taps Centre (9 utilisés)"
        A[✅ ✅ ✅<br/>✅ ✅ ✅<br/>✅ ✅ ✅]
    end

```

### 4. Personnaliser la Taille
```verilog
parameter IMG_MAX_X = 16;   // Image plus grande
parameter CONV_MAX_X = 5;   // Filtre plus grand
```

## 🔍 Architecture Approfondie

### Propagation Doublement Récursive

```mermaid
graph TD
    subgraph "Génération d'Instance"
        A[Instance Courante<br/>result_index, kernel_index]
        A --> B{Dans l'Image?}
        B -->|Oui| C[Calculer: img pixel × kernel tap]
        B -->|Non| D[Ignorer multiplication]
        C --> E[Stocker dans tableau FIFO]
        D --> E
    end

    subgraph "Récursive1: Propagation FIFO"
        F{kernel_index < 9?}
        F -->|Oui| G[Générer recursive1<br/>kernel_index + 1]
        G --> H[Propager FIFO vers le haut]
        F -->|Non| I[FIFO complet pour result_index]
    end

    subgraph "Arbres Additionneurs: Sommation Position-Aware"
        J{kernel_index == 0?}
        J -->|Oui| K[Lancer adder_tree]
        K --> L{Type de Position?}
        L -->|Coin| M[Sommer 4 taps<br/>Ignorer taps bordure]
        L -->|Bordure| N[Sommer 6 taps<br/>Ignorer taps côté]
        L -->|Centre| O[Sommer tous les 9 taps]
        M --> P[Stocker dans tableau result]
        N --> P
        O --> P
    end

    subgraph "Récursive2: Propagation Result"
        Q{result_index < 81?}
        Q -->|Oui| R[Générer recursive2<br/>result_index + 1]
        R --> S[Propager result vers le haut]
        Q -->|Non| T[Toutes convolutions terminées]
    end

    E --> F
    I --> J
    P --> Q

```

### Adressage Intelligent & Transformation Coordonnées

```mermaid
graph LR
    subgraph "Mapping d'Entrée"
        A[result_index] --> B[result_y = idx ÷ 9<br/>result_x = idx mod 9]
        C[kernel_index] --> D[kernel_y = idx ÷ 3<br/>kernel_x = idx mod 3]
    end

    subgraph "Calcul Source"
        B --> E[img_y = result_y + kernel_y - 1]
        D --> E
        B --> F[img_x = result_x + kernel_x - 1]
        D --> F
        E --> G[img_index = img_y × 9 + img_x]
        F --> G
    end

    subgraph "Vérification Limites"
        G --> H{img_y ≥ 0 && img_y < 9<br/>&&<br/>img_x ≥ 0 && img_x < 9}
        H -->|Vrai| I[Extraire img pixel]
        H -->|Faux| J[Ignorer: Hors image]
    end

```

### Architecture Flux de Données

```mermaid
graph TD
    subgraph "Données Brutes"
        A[Image 9×9<br/>81 pixels]
        B[Kernel 3×3<br/>9 poids]
    end

    subgraph "Couche Traitement"
        C[729 Multiplications<br/>Parallèles]
        D[Stockage FIFO<br/>81×9 = 729 valeurs]
    end

    subgraph "Couche Agrégation"
        E[Détection Position<br/>Coin/Bordure/Centre]
        F[Sommation Sélective<br/>4/6/9 taps]
        G[81 Arbres Additionneurs]
    end

    subgraph "Sortie Finale"
        H[result 0..80<br/>81 résultats convolution]
    end

    A --> C
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    G --> H

```

## 🎯 Pourquoi c'est génial

| Fonctionnalité | Avantage |
|----------------|----------|
| 🚀 **Latence Zéro** | Résultats disponibles instantanément |
| ⚡ **Parallèle Massif** | 729 opérations à la fois |
| 🔧 **Pas de Logique de Contrôle** | Juste multiplieurs + fils |
| 📦 **Intégration Facile** | Intégrer dans n'importe quel design ASIC |
| 🎯 **Configurable** | Changer les tailles facilement |

## 🌟 Applications

```mermaid
graph TD
    A[Moteur Convolution] --> B[Apprentissage Profond]
    A --> C[Traitement Image]
    A --> D[Vision Ordinateur]
    A --> E[Traitement Signal]

    B --> F[Couches CNN]
    B --> G[Détection contours]
    B --> H[Cartes caractéristiques]

    C --> I[Filtres flou]
    C --> J[Accentuation]
    C --> K[Réduction bruit]

    D --> L[Détection objets]
    D --> M[Reconnaissance motifs]
    D --> N[Vidéo temps réel]

    E --> O[Filtrage 2D]
    E --> P[Analyse fréquence]
    E --> Q[Corrélation]

    classDef engine fill:#ff6b6b,stroke:#c92a2a,stroke-width:3px,color:#fff
    classDef domain fill:#4ecdc4,stroke:#26a69a,stroke-width:2px,color:#fff
    classDef app fill:#45b7d1,stroke:#2196f3,stroke-width:1px,color:#fff

    class A engine
    class B,C,D,E domain
    class F,G,H,I,J,K,L,M,N,O,P,Q app
```

## 🔬 Comment ça marche vraiment

### Le Secret : Récursion Paramétrique
```mermaid
graph TD
    A[Module 'index'] --> B[Génère instance pour chaque combinaison]
    B --> C[result_index=0, kernel_index=0]
    B --> D[result_index=0, kernel_index=1]
    B --> E[...]
    B --> F[result_index=80, kernel_index=8]

    C --> G[Calcule position image source]
    D --> H[Calcule position image source]
    F --> I[Calcule position image source]

    G --> J[Multiplie & stocke dans FIFO]
    H --> J
    I --> J

```

### Transformation Coordonnées Magique
```mermaid
graph LR
    A[result_index=10] --> B[Position sortie: ligne 1, col 1]
    C[kernel_index=4] --> D[Centre du kernel 3×3]
    B --> E[Pixel source: position 10 dans image]
    D --> E
    E --> F[img[10] × kernel[4] = 10 × 4 = 40]
    F --> G[Stocké dans FIFO[10][4]]

```

## Licence

AGPL v3