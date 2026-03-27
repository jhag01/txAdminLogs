# 🛠️ txAdminLogs
A lightweight, standalone logging system for FiveM that automatically captures and routes **txAdmin** events to Discord. It bridges the gap between server-side administration and community transparency by providing real-time audit trails.

---

## ✨ Features
* **Zero Maintenance**: Automatically registers listeners for every event defined in your settings.
* **Dual-Routing**: Sends logs to specific category channels (e.g., Bans, Whitelist) while simultaneously maintaining a "Master Log" for full history.
* **Smart Tables**: Automatically flattens complex data, such as player identifiers, into clean, bulleted lists.
* **Dynamic Timestamps**: Converts Unix expiration codes into human-readable, localized Discord time.
* **Menu Logging**: Specifically tracks in-game menu actions like teleports, heals, and "Troll" effects.
* **Standalone**: No framework requirements (ESX/QB-Core not required); it works on any server.

---

## 🚀 Installation
1. Drop the `txAdminLogs` folder into your `resources` directory.
2. Open `settings.lua` and replace `'WEBHOOK'` with your actual Discord Webhook URLs.
3. Add `ensure txAdminLogs` to your `server.cfg`.

---

## 📋 Supported Logs
### System Events
These are triggered by the txAdmin panel or automated server tasks:
* Server: Announcements, Shutdowns, Scheduled Restarts.
* Moderation: Bans, Kicks, Warnings, Heals, Direct Messages.
* Whitelist: Player approvals and request tracking.
* Admin: Authentication logs, config changes, and console commands.

### Admin Menu Actions
Logs actions performed by staff via the in-game txAdmin menu:
* Self-Actions: Player mode changes, spawning/repairing vehicles, clearing areas.
* Interactions: Spectating, freezing, or summoning specific players.
* Troll Options: Drunk effects, setting players on fire, or wild animal attacks.