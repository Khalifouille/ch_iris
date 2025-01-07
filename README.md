# Script FiveM : Personnage Interactif "IRIS"

Ce script ajoute un PNJ nommé "IRIS" dans votre serveur FiveM. IRIS interagit avec les joueurs et offre une récompense spéciale si elle est éliminée.

## Fonctionnalités

- **Apparition de IRIS :**
  - IRIS apparaît automatiquement à un emplacement défini sur la carte.
  - Le modèle utilisé est configurable.

- **Interaction :**
  - Les joueurs peuvent interagir avec IRIS en se rapprochant et en appuyant sur la touche `E`.
  - IRIS répond avec un message humoristique via le chat.

- **Récompense :**
  - Si un joueur tue IRIS, une récompense est ajoutée dans son inventaire (un objet nommé `tete_de_iris`).

## Installation

1. **Téléchargement :**
   - Clonez ou téléchargez ce dépôt sur votre machine.

2. **Ajout au serveur :**
   - Placez les fichiers `client.lua` et `server.lua` dans un dossier sous `resources/`.

3. **Activation :**
   - Ajoutez le dossier au fichier `server.cfg` :
     ```plaintext
     ensure NomDuDossier
     ```

4. **Vérification des dépendances :**
   - Assurez-vous que `ox_inventory` est installé pour la gestion des récompenses.

## Configuration

### Modifier le modèle de IRIS

- Dans `client.lua`, changez la variable `pedModel` à la ligne suivante :
  ```lua
  local pedModel = "u_f_o_carol" -- Modèle actuel
