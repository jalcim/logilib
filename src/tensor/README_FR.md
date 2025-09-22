# Accélérateur Hardware de Convolution 2D

Moteur de convolution parallèle avec latence zéro et 729 opérations simultanées.

## 🎯 Que fait ce module ?

## ⚡ ZÉRO GÉNÉRATION DE LOGIQUE - CÂBLAGE PUR ⚡
**Ce design n'utilise AUCUNE logique de contrôle.**
**Tout est préprocessé et géré par des connexions de câblage direct.**
**Le hardware est 100% combinatoire - zéro latence, zéro délai, juste de la multiplication et addition parallèle pure.**

```mermaid
graph LR
    A[Image 9×9] --> B[🔥 Moteur Convolution]
    C[Filtre 3×3] --> B
    B --> D[729 Résultats]

```

Prend une image 9×9 + filtre 3×3 → produit tous les résultats de convolution instantanément

## Comment ça marche

```mermaid
flowchart LR
    subgraph Input [" 📥 ENTRÉES "]
        A["🖼️ Image 9×9<br/>81 pixels"]
        B["🔢 Kernel 3×3<br/>9 poids"]
    end

    subgraph Processing [" ⚡ TRAITEMENT "]
        C["🔄 729 Multiplieurs<br/>TOUT PARALLÈLE"]
        D["📡 Câblage Direct<br/>AUCUN DÉLAI"]
    end

    subgraph Output [" 📤 SORTIE "]
        E["📊 81 Résultats<br/>INSTANTANÉ"]
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
iverilog -o sim test.v tensor.v adder.v acc.v mult.v on_*.v && ./sim
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
        A1[0 1<br/>9 10] --> C1[Résultat = 160]
    end

    subgraph "BORDURE Exemple (Position 1)"
        A2[1 2<br/>10 11<br/>19 20] --> C2[Résultat = 300]
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

## 🏗️ Architecture des Modules

### Fichiers Principaux
- **tensor.v** - **Module index récursif** qui génère 81 instances (une par pixel de sortie)
- **mult.v** - **Étape de multiplication récursive** qui génère 9 instances par pixel (une par tap du kernel)
- **acc.v** - Module accumulateur qui route vers les gestionnaires spécifiques à la position
- **adder.v** - Additionneur arborescent pour sommation parallèle efficace
- **on_center.v** - Gère la convolution 9-tap pour les pixels centraux
- **on_border.v** - Gère la convolution 6-tap pour les pixels de bordure
- **on_coin.v** - Gère la convolution 4-tap pour les pixels de coin
- **test.v** - Banc de test avec validation complète

### Architecture Récursive
```mermaid
graph TD
    A[test.v] --> B[tensor.v]
    B --> C[mult.v]
    B --> D[acc.v]
    B -.-> B[🔄 récursif]
    C -.-> C[🔄 récursif]
    C --> I[mmul.v]
    D --> E[on_center.v]
    D --> F[on_border.v]
    D --> G[on_coin.v]
    E --> H[adder.v]
    F --> H
    G --> H
    I --> H
```

### 4. Personnaliser la Taille
```verilog
parameter IMG_MAX_X = 16;   // Image plus grande
parameter CONV_MAX_X = 5;   // Filtre plus grand
```

## 🔍 Architecture Approfondie

### Architecture Doublement Récursive Expliquée

Le système utilise **deux niveaux de récursion** pour générer toutes les 729 opérations :

#### 1. Récursion Index (tensor.v) - Fait avancer result_index
**Objectif**: Traiter la convolution pour TOUTES les cellules de l'image (0 à 80)
**Récursion**: Incrémente `result_index` pour couvrir chaque pixel de sortie
```verilog
if (result_index < IMG_SIZE)
    index #(.result_index(result_index + 1)) genblk_index (img, kernel, FIFO, result);
```

#### 2. Récursion Mult (mult.v) - Fait avancer kernel_index
**Objectif**: Traiter TOUTES les multiplications du kernel (0 à 8) pour chaque cellule d'image
**Récursion**: Incrémente `kernel_index` pour couvrir chaque tap du kernel
```verilog
if (kernel_index < CONV_SIZE - 1)
    mult #(.kernel_index(kernel_index+1)) mult_stage(img, kernel, FIFO, result);
```

**Point Clé**:
- Récursion `index` → couvre toutes les **positions image** (result_index 0→80)
- Récursion `mult` → couvre tous les **taps kernel** (kernel_index 0→8) pour chaque position
- Résultat: 81 × 9 = **729 multiplications parallèles**

```mermaid
graph TD
    subgraph "Niveau 1: Récursion Index (81 instances)"
        A[index result_index=0]
        A1[index result_index=1]
        A2[index result_index=2]
        A3[... 81 instances total ...]
        A80[index result_index=80]
    end

    subgraph "Niveau 2: Récursion Mult (9 par index = 729 total)"
        B[mult kernel_index=0]
        B1[mult kernel_index=1]
        B2[mult kernel_index=2]
        B8[mult kernel_index=8]
    end

    subgraph "Résultat: 729 Opérations Parallèles"
        C[Chaque combinaison pixel×kernel<br/>calculée simultanément]
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
mindmap
  root((Moteur Convolution))
    Apprentissage Profond
      Couches CNN
      Détection contours
      Cartes caractéristiques
    Traitement Image
      Filtres flou
      Accentuation
      Réduction bruit
    Vision Ordinateur
      Détection objets
      Reconnaissance motifs
      Vidéo temps réel
    Traitement Signal
      Filtrage 2D
      Analyse fréquence
      Corrélation
```

### Transformation Coordonnées Magique
```mermaid
graph LR
    A["result_index=10"] --> B["Position sortie: ligne 1, col 1"]
    C["kernel_index=4"] --> D["Centre du kernel 3×3"]
    B --> E["Pixel source: position 10 dans image"]
    D --> E
    E --> F["img[10] × kernel[4] = 10 × 4 = 40"]
    F --> G["Stocké dans FIFO[10][4]"]

```

## Licence

AGPL v3