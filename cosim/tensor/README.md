# Tensor Cosimulation

Tests de cosimulation pour les composants tensoriels Verilog avec des modèles CNN en C.

## Composants

### CNN (Convolutional Neural Network)
Implémentation d'un réseau de neurones convolutionnel en C pur pour la classification MNIST.

- **Répertoire** : `cnn/`
- **Usage** : Voir `cnn/README.md`

### Tests de cosimulation
Tests Boost pour valider les composants tensoriels Verilog contre les modèles C.

- **Composants testés** :
  - `Vtensor_9x9` : Tenseur 9x9
  - `Vtensor_28x28` : Tenseur 28x28 (taille MNIST)

## Build

```bash
# Build depuis le répertoire principal
~/project/logilib$ cmake -S. -Bbuild -GNinja && cmake --build build

# Run CNN
cmake --build build --target run_cnn

# Run tests cosim
./build/cosim/tensor/cosim_tensor
```

## Architecture

```
tensor/
├── cnn/              # CNN en C pur
│   ├── *.c          # Implémentation CNN
│   ├── *.h          # Headers
│   ├── download.py  # Dataset MNIST
│   └── CMakeLists.txt
├── *.cpp            # Tests cosimulation Boost
└── CMakeLists.txt   # Configuration build
```

Le système configure automatiquement le sous-projet CNN et copie l'exécutable vers `build/cosim/tensor/cnn/CNN`.