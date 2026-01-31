# 🛠️ txAdminLogs
A lightweight, standalone logging system for FiveM that automatically captures and routes **txAdmin** events to Discord.

---

## ✨ Features
* **Zero Maintenance:** Automatically registers listeners for every event defined in your settings.
* **Dual-Routing:** Sends logs to specific category channels (e.g., Bans, Whitelist) while simultaneously maintaining a "Master Log" for full history.
* **Smart Tables:** Automatically flattens complex data (like Player Identifiers) into clean, bulleted lists.
* **Dynamic Timestamps:** Converts expiration Unix codes into human-readable, localized Discord time (e.g., "in 2 days").
* **Standalone:** No framework requirements. Works on any server.

---

## 🚀 Installation
1. Drop the `txAdminLogs` folder into your `resources` directory.
2. Open `settings.lua` and replace `'WEBHOOK'` with your actual Discord Webhook URLs.
3. Add `ensure txAdminLogs` to your `server.cfg`.

---

## ⚙️ Configuration
The system uses a simple table structure in `settings.lua`. 

* **MasterWebhook:** The catch-all channel.
* **Webhooks Table:**
  ```lua
  ['playerBanned'] = { 
      color = 10038562, 
      title = '🔨 txAdmin: Player Banned', 
      webhook = 'YOUR_SPECIFIC_URL' 
  }