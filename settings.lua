Settings = {}

Settings.Bot = {
    Username = 'txAdmin Logs',
    AvatarURL = '',
    FooterText = 'txAdmin Logs • ' .. os.date('%Y'),
    FooterIcon = '',
    IncludeTimestamp = true
}

Settings.MasterWebhook = {
    Enabled = true,
    URL = 'WEBHOOK'
}

Settings.Events = {
    -- Server-Related Events
    ['announcement']        = { color = 16776960, title = '📢 txAdmin: Announcement', webhook = 'WEBHOOK' },
    ['serverShuttingDown']  = { color = 15158332, title = '🛑 txAdmin: Server Shutting Down', webhook = 'WEBHOOK' },
    ['scheduledRestart']    = { color = 15105570, title = '⏲️ txAdmin: Scheduled Restart', webhook = 'WEBHOOK' },
    ['scheduledRestartSkipped'] = { color = 3447003, title = '⏭️ txAdmin: Restart Skipped', webhook = 'WEBHOOK' },

    -- Player-Related Events
    ['playerBanned']        = { color = 10038562, title = '🔨 txAdmin: Player Banned', webhook = 'WEBHOOK' },
    ['playerDirectMessage'] = { color = 16777215, title = '💬 txAdmin: Direct Message', webhook = 'WEBHOOK' },
    ['playerHealed']        = { color = 3066993,  title = '❤️ txAdmin: Player Healed', webhook = 'WEBHOOK' },
    ['playerKicked']        = { color = 15158332, title = '👢 txAdmin: Player Kicked', webhook = 'WEBHOOK' },
    ['playerWarned']        = { color = 15844367, title = '⚠️ txAdmin: Player Warned', webhook = 'WEBHOOK' },

    -- Whitelist-Related Events
    ['whitelistPlayer']      = { color = 3066993,  title = '📝 txAdmin: Player Whitelisted', webhook = 'WEBHOOK' },
    ['whitelistPreApproval'] = { color = 3447003,  title = '📋 txAdmin: Whitelist Pre-Approval', webhook = 'WEBHOOK' },
    ['whitelistRequest']     = { color = 1752220,  title = '📩 txAdmin: Whitelist Request', webhook = 'WEBHOOK' },

    -- Other Events
    ['actionRevoked']        = { color = 9807270,  title = '🔄 txAdmin: Action Revoked', webhook = 'WEBHOOK' },
    ['adminAuth']            = { color = 15105570, title = '🔐 txAdmin: Admin Authenticated', webhook = 'WEBHOOK' },
    ['adminsUpdated']        = { color = 3447003,  title = '👥 txAdmin: Admins Updated', webhook = 'WEBHOOK' },
    ['configChanged']        = { color = 15844367, title = '⚙️ txAdmin: Config Changed', webhook = 'WEBHOOK' },
    ['consoleCommand']       = { color = 0,        title = '💻 txAdmin: Console Command', webhook = 'WEBHOOK' },
}

Settings.menuEvents = {
    -- Self Menu Options
    ['playerModeChanged']   = { color = 3447003,  title = '👤 Menu: Player Mode Changed', description = 'changed mode to %s', webhook = 'WEBHOOK' },
    ['teleportWaypoint']    = { color = 10181046, title = '📍 Menu: Teleport to Waypoint', description = 'teleported to a waypoint', webhook = 'WEBHOOK' },
    ['teleportCoords']      = { color = 10181046, title = '🌐 Menu: Teleport to Coords', description = 'teleported to coordinates (x=%.3f, y=%.3f, z=%.3f)', webhook = 'WEBHOOK' },
    ['spawnVehicle']        = { color = 1752220,  title = '🚗 Menu: Spawned Vehicle', description = 'spawned a vehicle (model: %s)', webhook = 'WEBHOOK' },
    ['deleteVehicle']       = { color = 15158332, title = '🗑️ Menu: Deleted Vehicle', description = 'deleted a vehicle', webhook = 'WEBHOOK' },
    ['vehicleRepair']       = { color = 3066993,  title = '🔧 Menu: Repaired Vehicle', description = 'repaired their vehicle', webhook = 'WEBHOOK' },
    ['vehicleBoost']        = { color = 16776960, title = '🚀 Menu: Boosted Vehicle', description = 'boosted their vehicle', webhook = 'WEBHOOK' },
    ['healSelf']            = { color = 3066993,  title = '❤️ Menu: Healed Self', description = 'healed themself', webhook = 'WEBHOOK' },
    ['healAll']             = { color = 3066993,  title = '🏥 Menu: Healed Everyone', description = 'healed all players!', webhook = 'WEBHOOK' },
    ['announcement']        = { color = 16776960, title = '📢 Menu: Server Announcement', description = 'made a server-wide announcement: %s', webhook = 'WEBHOOK' },
    ['clearArea']           = { color = 9807270,  title = '🧹 Menu: Cleared Area', description = 'cleared an area with %dm radius', webhook = 'WEBHOOK' },

    -- Player Options
    ['spectatePlayer']      = { color = 3447003,  title = '👁️ Menu: Started Spectating', description = 'started spectating player %s', webhook = 'WEBHOOK' },
    ['freezePlayer']        = { color = 15105570, title = '🧊 Menu: Toggled Freeze', description = 'toggled freeze on player %s', webhook = 'WEBHOOK' },
    ['teleportPlayer']      = { color = 10181046, title = '🏃 Menu: Teleported to Player', description = 'teleported to player %s (x=%.3f, y=%.3f, z=%.3f)', webhook = 'WEBHOOK' },
    ['healPlayer']          = { color = 3066993,  title = '🩹 Menu: Healed Player', description = 'healed player %s', webhook = 'WEBHOOK' },
    ['summonPlayer']        = { color = 10181046, title = '🪄 Menu: Summoned Player', description = 'summoned player %s', webhook = 'WEBHOOK' },

    -- Troll Options
    ['drunkEffect']         = { color = 15548997, title = '🥴 Menu: Triggered Drunk Effect', description = 'triggered drunk effect on %s', webhook = 'WEBHOOK' },
    ['setOnFire']           = { color = 15158332, title = '🔥 Menu: Set Player on Fire', description = 'set %s on fire', webhook = 'WEBHOOK' },
    ['wildAttack']          = { color = 15158332, title = '🐾 Menu: Triggered Wild Attack', description = 'triggered wild attack on %s', webhook = 'WEBHOOK' },
    ['showPlayerIDs']       = { color = 9807270,  title = '🆔 Menu: Toggled Player IDs', description = 'turned show player IDs %s', webhook = 'WEBHOOK' },
}