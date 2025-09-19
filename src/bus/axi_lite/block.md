# AXI4-Lite Signaux et Dépendances

## Signaux Globaux

+-----------------+---------+----------------------------------------+--------+-------------+
| Signal          | Type    | Description                            | Ordre  | Dépendances |
+-----------------+---------+----------------------------------------+--------+-------------+
| axi_aclk        | Input   | Horloge système AXI                    | 0      | -           |
| axi_aresetn     | Input   | Reset asynchrone actif bas             | 0      | -           |
+-----------------+---------+----------------------------------------+--------+-------------+

## Canal AW (Write Address) - Indépendant

+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| Signal          | Type    | Description                            | Ordre  | Dépendances                                                           |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| m_axi_awaddr    | Master  | Adresse d'écriture (32 bits)           | 0      | -                                                                     |
| m_axi_awvalid   | Master  | Validité de l'adresse d'écriture       | 0      | -                                                                     |
| s_axi_awready   | Slave   | Prêt à accepter l'adresse d'écriture   | 0      | m_axi_awvalid                                                         |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+

## Canal W (Write Data) - Indépendant

+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| Signal          | Type    | Description                            | Ordre  | Dépendances                                                           |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| m_axi_wdata     | Master  | Données à écrire (32 bits)             | 0      | -                                                                     |
| m_axi_wstrb     | Master  | Masque des octets valides (4 bits)     | 0      | -                                                                     |
| m_axi_wvalid    | Master  | Validité des données d'écriture        | 0      | -                                                                     |
| s_axi_wready    | Slave   | Prêt à accepter les données d'écriture | 0      | m_axi_wvalid                                                          |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+

## Canal B (Write Response) - Dépendant

+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| Signal          | Type    | Description                            | Ordre  | Dépendances                                                           |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| s_axi_bresp     | Slave   | Réponse d'écriture (2 bits)            | 1      | (m_axi_awvalid & s_axi_awready) & (m_axi_wvalid & s_axi_wready)       |
| s_axi_bvalid    | Slave   | Validité de la réponse d'écriture      | 1      | (m_axi_awvalid & s_axi_awready) & (m_axi_wvalid & s_axi_wready)       |
| m_axi_bready    | Master  | Prêt à accepter la réponse d'écriture  | 0      | -                                                                     |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+

## Canal AR (Read Address) - Indépendant

+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| Signal          | Type    | Description                            | Ordre  | Dépendances                                                           |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| m_axi_araddr    | Master  | Adresse de lecture (32 bits)           | 0      | -                                                                     |
| m_axi_arvalid   | Master  | Validité de l'adresse de lecture       | 0      | -                                                                     |
| m_axi_arprot    | Master  | Protection type (3 bits)               | 0      | -                                                                     |
| s_axi_arready   | Slave   | Prêt à accepter l'adresse de lecture   | 0      | m_axi_arvalid                                                         |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+

## Canal R (Read Data) - Dépendant

+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| Signal          | Type    | Description                            | Ordre  | Dépendances                                                           |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+
| s_axi_rdata     | Slave   | Données lues (32 bits)                 | 1      | (m_axi_arvalid & s_axi_arready)                                       |
| s_axi_rvalid    | Slave   | Validité des données lues              | 1      | (m_axi_arvalid & s_axi_arready)                                       |
| s_axi_rresp     | Slave   | Réponse de lecture (2 bits)            | 1      | (m_axi_arvalid & s_axi_arready)                                       |
| m_axi_rready    | Master  | Prêt à accepter les données lues       | 0      | -                                                                     |
+-----------------+---------+----------------------------------------+--------+-----------------------------------------------------------------------+

## Architecture Parallèle

### Blocs Indépendants (Niveau 0)
- **Canal AW** ←→ **Canal W** ←→ **Canal AR** (parallèles)

### Blocs Dépendants (Niveau 1)  
- **Canal B** : Nécessite AW ET W
- **Canal R** : Nécessite AR

### Parallélisme ARM AXI4-Lite
```
Écriture : AW ←→ W ←→ B
           ↕
Lecture  : AR ←→ R
```

## Schéma des Blocs et Dépendances

```
                    MASTER                    │                    SLAVE
                                              │
    ┌─────────────────────────────────────────┼─────────────────────────────────────────┐
    │  ┌─────────────────┐                    │                                         │
    │  │ Signaux Globaux │ axi_aclk ──────────┼────────────────────────────────────────→│
    │  │                 │ axi_aresetn ───────┼────────────────────────────────────────→│
    │  └─────────────────┘                    │                                         │
    │                                         │                                         │
    │  ┌─────────────────┐                    │                    ┌─────────────────┐  │
    │  │   Canal AW      │ m_axi_awaddr       │       s_axi_awready │   Canal AW      │  │
    │  │   (Niveau 0)    │ m_axi_awvalid ────→│ ────→               │   (Niveau 0)    │  │
    │  │   Indépendant   │ m_axi_awprot       │                    │   Indépendant   │  │
    │  └─────────────────┘                    │                    └─────────────────┘  │
    │                                         │                                         │
    │  ┌─────────────────┐                    │                    ┌─────────────────┐  │
    │  │   Canal W       │ m_axi_wdata        │        s_axi_wready │   Canal W       │  │
    │  │   (Niveau 0)    │ m_axi_wstrb  ─────→│ ────→               │   (Niveau 0)    │  │
    │  │   Indépendant   │ m_axi_wvalid       │                    │   Indépendant   │  │
    │  └─────────────────┘                    │                    └─────────────────┘  │
    │                                         │                                         │
    │                                         │                                         │
    │  ┌─────────────────┐                    │                    ┌─────────────────┐  │
    │  │   Canal B       │                    │  s_axi_bresp       │   Canal B       │  │
    │  │   (Niveau 0)    │ m_axi_bready ────→│←──── s_axi_bvalid   │   (Niveau 1)    │  │
    │  │   Indépendant   │                    │                    │   Dépendant     │  │
    │  └─────────────────┘                    │                    └─────────────────┘  │
    │                                         │                           ↑             │
    │                                         │                           │             │
    │                                         │              m_axi_awvalid & m_axi_wvalid│
    │                                         │                                         │
    │ ═══════════════════════════════════════════════════════════════════════════════ │
    │                     LECTURE (Indépendante de l'écriture)                       │
    │ ═══════════════════════════════════════════════════════════════════════════════ │
    │                                         │                                         │
    │  ┌─────────────────┐                    │                    ┌─────────────────┐  │
    │  │   Canal AR      │ m_axi_araddr       │       s_axi_arready │   Canal AR      │  │
    │  │   (Niveau 0)    │ m_axi_arvalid ────→│ ────→               │   (Niveau 0)    │  │
    │  │   Indépendant   │                    │                    │   Indépendant   │  │
    │  └─────────────────┘                    │                    └─────────────────┘  │
    │                                         │                                         │
    │                                         │                                         │
    │  ┌─────────────────┐                    │                    ┌─────────────────┐  │
    │  │   Canal R       │                    │  s_axi_rdata       │   Canal R       │  │
    │  │   (Niveau 0)    │ m_axi_rready ─────→│←──── s_axi_rvalid   │   (Niveau 1)    │  │
    │  │   Indépendant   │                    │      s_axi_rresp    │   Dépendant     │  │
    │  └─────────────────┘                    │                    └─────────────────┘  │
    │                                         │                           ↑             │
    │                                         │                           │             │
    │                                         │                    m_axi_arvalid       │
    │                                         │                                         │
    └─────────────────────────────────────────┼─────────────────────────────────────────┘

Légende:
────→  Signaux Master vers Slave
←────  Signaux Slave vers Master
   ↑   Dépendances internes (niveau 1 dépend du niveau 0)
═══    Séparation lecture/écriture (indépendantes)
```

### Résumé des Dépendances

**Niveau 0 (Indépendants)** :
- Tous les canaux AW, W, AR peuvent fonctionner simultanément
- Les signaux `*ready` sont toujours indépendants

**Niveau 1 (Dépendants)** :
- Canal B : `s_axi_bvalid` ne peut être asserté qu'après `(m_axi_awvalid & s_axi_awready) & (m_axi_wvalid & s_axi_wready)`
- Canal R : `s_axi_rvalid` ne peut être asserté qu'après `(m_axi_arvalid & s_axi_arready)`
- **Note** : Ordre 1 = au minimum 1 cycle après les dépendances

**Parallélisme total** :
- Lecture et écriture sont complètement indépendantes
- Plusieurs transactions peuvent être en cours simultanément