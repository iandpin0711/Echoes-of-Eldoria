# 🗡️ Echoes of Eldoria

## 1. Game Overview

**Title:** Echoes of Eldoria  
**Genre:** 2D Action-Adventure
**Platform:** PC  
**Graphics Style:** Pixel Art

**Description:**  
Echoes of Eldoria is a 2D action-adventure game set in a large open world. The player controls a young hero exploring a forgotten land filled with ruins, forests, and hidden secrets. By exploring, solving simple puzzles, and interacting with the environment, the player gradually uncovers ancient relics needed to restore balance to the world.

---

## 2. Gameplay

### 2.1 Player

#### Controls

| Key         | Action          |
|-------------|-----------------|
| W           | Move Up         |
| A           | Move Left       |
| S           | Move Down       |
| D           | Move Right      |
| Left Click  | Attack          |
| E           | Interact        |
| Q           | Use Item        |
| Tab         | Open Inventory  |

#### Abilities

- **Sword Attack:** Basic melee attack using left click.
- **Shield Block (optional/future):** Reduce damage from the front.
- **Item Use:** Use simple tools (e.g., bombs, keys, special items).

#### Actions

- Explore the open world.
- Fight basic enemies.
- Find hidden objects and relics.
- Interact with NPCs and environment.
- Discover secrets and shortcuts.

---

### 2.2 Objects

#### Collectibles

- **Relics:** Main objective items required to complete the game.
- **Coins / Currency:** Optional collectible for future use (shops, upgrades).
- **Hearts:** Restore health.

#### Environment

- Trees, rocks, ruins, bushes, chests.
- Decorative and interactive elements (e.g., breakable objects, simple switches).

#### Obstacles

- Blocked paths (rocks, bushes).
- Locked doors or barriers.
- Simple environmental puzzles (move object, find key, activate switch).

---

### 2.3 Enemies

- Basic enemies that act as obstacles during exploration.

**General Behavior:**

- Move within a limited area.
- Approach the player when nearby.
- Deal damage on contact or simple attack.

*(Enemy variety and complexity can be expanded later.)*

---

### 2.4 World / Progression

- One **large interconnected open world**.
- No traditional levels.

**Progression Style:**

- Exploration-driven.
- Player finds relics in different areas.
- Some areas may be harder to access or require simple interactions.

**Example Flow:**

- Start in a safe area (village or spawn point).
- Explore nearby zones.
- Discover relic locations (hidden, guarded, or puzzle-based).
- Collect all relics to unlock the final objective.

---

### 2.5 Interaction Elements

#### NPCs

- Provide hints or simple dialogue.
- Can guide the player toward objectives.

#### Chests

- Contain relics, health, or optional rewards.

#### Signs

- Provide basic instructions or world hints.

#### Interactive Objects

- Switches, movable blocks, breakable elements.

---

## 3. Game Mechanics

- **Movement:** Free 4-directional movement.
- **Combat System:** Simple real-time melee combat.
- **Exploration System:** Open-world discovery with hidden elements.
- **Collection System:** Gather relics to progress.
- **Interaction System:** Context-based interaction (E key).
- **Health System:** Basic health (hearts or bar).
- **Collision System:** For combat, environment, and pickups.
- **Simple Puzzle System:** Light logic (switches, keys, positioning).

---

## 4. Technical Details

**Engine:** Godot  

### Architecture

- Scene-based structure:
  - Player
  - Enemies
  - World
  - UI

- Autoload systems:
  - Game Manager
  - Signal Manager (optional)
  - Inventory System (simple)

- Group usage:
  - Enemies
  - Collectibles
  - Interactables

### Physics

- **CharacterBody2D** for player.
- **Area2D** for:
  - Attacks
  - Pickups
  - Interaction zones
- **StaticBody2D** for environment.

### UI

- HUD:
  - Health
  - Relic counter (e.g., 2/5 relics)
- Simple inventory menu.
- Dialogue text box.
