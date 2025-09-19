# AXI Lite Bus Implementation

Implémentation complète d'un bus AXI4-Lite conforme à la spécification ARM AMBA.

## Vue d'ensemble

Ce module implémente l'interface AXI4-Lite avec ses 5 canaux indépendants :

- **AW** (Write Address) - Canal d'adresse d'écriture
- **W** (Write Data) - Canal de données d'écriture  
- **B** (Write Response) - Canal de réponse d'écriture
- **AR** (Read Address) - Canal d'adresse de lecture
- **R** (Read Data) - Canal de données de lecture

## Architecture

```
Master ←→ AXI Lite Bus ←→ Slave ←→ Registers
```

### Modules

- **`master.v`** - Maître AXI Lite
- **`slave.v`** - Esclave AXI Lite
- **`regs.v`** - Banque de registres (128 × 32 bits)

## Caractéristiques

- ✅ **Conforme ARM AXI4-Lite** - Respecte la spécification officielle
- ✅ **5 canaux indépendants** - Permet le parallélisme lecture/écriture
- ✅ **Handshake VALID/READY** - Prévention de deadlock
- ✅ **Masques d'écriture** - Support des écritures partielles (4 bits)
- ✅ **Protection mémoire** - Vérification des limites d'adresses

## Interface

### Signaux principaux

| Signal | Largeur | Description |
|--------|---------|-------------|
| `s_axi_awaddr` | 8 bits | Adresse d'écriture |
| `s_axi_wdata` | 32 bits | Données d'écriture |
| `s_axi_wstrb` | 4 bits | Masque d'octets valides |
| `s_axi_araddr` | 8 bits | Adresse de lecture |
| `s_axi_rdata` | 32 bits | Données de lecture |

### Horloges et reset

- `axi_aclk` - Horloge système
- `resetn` - Reset actif bas

## Utilisation

### Écriture

1. Asserter `s_axi_awvalid` avec l'adresse
2. Asserter `s_axi_wvalid` avec les données et masque
3. Attendre `s_axi_bvalid` pour la confirmation

### Lecture

1. Asserter `s_axi_arvalid` avec l'adresse
2. Attendre `s_axi_rvalid` pour les données

## Spécifications techniques

- **Espace d'adressage** : 128 registres (adresses 0x00 à 0x7F)
- **Largeur de données** : 32 bits
- **Protocole** : AXI4-Lite (bursts de longueur 1 uniquement)
- **Fréquence** : 125 MHz (configurable)

## Dépendances des canaux

Selon la spécification ARM AXI4-Lite et détaillé dans `block.md` :

### Canaux indépendants
- **AW Canal** : `awvalid` et `awready` indépendants
- **W Canal** : `wvalid` et `wready` indépendants  
- **AR Canal** : `arvalid` et `arready` indépendants
- **Master ready signals** : `bready` et `rready` indépendants

### Dépendances logiques
- **B Canal** : Dépend de `AW handshake & W handshake`
- **R Canal** : Dépend de `AR handshake`

## Règles de handshake ARM

- ✅ **VALID indépendant** : Source n'attend jamais READY pour asserter VALID
- ✅ **VALID sticky** : Une fois asserté, VALID reste haut jusqu'au handshake
- ✅ **READY flexible** : Destination peut attendre VALID avant READY
- ✅ **Prévention deadlock** : Respect des règles ARM

## Tests

Les modules peuvent être testés individuellement :
- Test du maître avec transactions d'écriture/lecture
- Test de l'esclave avec différents patterns de handshake
- Test de la banque de registres avec vérification des limites

## Conformité

Cette implémentation respecte :
- ARM AMBA AXI4-Lite Protocol Specification
- Règles de handshake VALID/READY
- Indépendance des 5 canaux
- Prévention de deadlock selon les guidelines ARM