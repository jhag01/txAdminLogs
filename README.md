# 🛠️ txAdminLogs
A lightweight, standalone logging system for FiveM that automatically captures and routes **txAdmin** events to Discord. It bridges the gap between server-side administration and community transparency by providing real-time audit trails.

---

## ✨ Features
* **Zero Maintenance**: Automatically registers listeners for every event defined in your settings.
* **Dual-Routing**: Sends logs to specific category channels (e.g., Bans, Whitelist) while simultaneously maintaining a "Master Log" for full history.
* **Smart Tables**: Automatically flattens complex data, such as player identifiers, into clean, bulleted lists.
* **Dynamic Timestamps**: Converts Unix expiration codes into human-readable, localized Discord time.
* **Menu Logging**: Specifically tracks in-game menu actions like teleports, heals, and "Troll" effects.
* **Per-Event Toggles**: Silence any individual log line with `enabled = false` instead of deleting config rows.
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
* Deaths: Victim, killer (if any), and cause for every in-game death.

### Admin Menu Actions
Logs actions performed by staff via the in-game txAdmin menu:
* Self-Actions: Player mode changes, spawning/repairing vehicles, clearing areas.
* Interactions: Spectating, freezing, or summoning specific players.
* Troll Options: Drunk effects, setting players on fire, or wild animal attacks.

---

## 📜 Changelog

### 2.2.0 — 2026-07-20
**Fixed**
* Menu-event logs (teleports, vehicles, troll actions, etc.) were silently discarding the real event data due to a variable-shadowing bug — coordinates, target names, and radii now show up correctly.
* Discord rate-limit retries waited in milliseconds instead of seconds, hammering the API instead of backing off.
* Logs would silently fail or duplicate if the master webhook was left as the `'WEBHOOK'` placeholder while a category webhook was set.
* Default empty-string avatar/footer icon URLs could make Discord reject the entire embed.
* A crash on array-style event payloads (e.g. `adminsUpdated`).
* Menu heals no longer double-post — they were duplicating the system-level `playerHealed` log.

**Added**
* Per-event `enabled = false` toggle for `Settings.Events`, `Settings.menuEvents`, and `Settings.DeathLog`.
* Structured Discord embed fields instead of one long description block.
* Death logging: victim, killer (or "N/A"), and cause for every in-game death.