Settings = {}

Settings.Bot = {
    Username = 'txAdmin Logs',
    AvatarURL = '',
    FooterText = 'txAdmin Logs • ' .. os.date('%Y'),
    FooterIcon = '',
}

Settings.Misc = {
    IncludeTimestamp = true,
}

Settings.MasterWebhook = 'WEBHOOK'

Settings.Webhooks = {
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
    ['whitelistPlayer']     = { color = 3066993,  title = '📝 txAdmin: Player Whitelisted', webhook = 'WEBHOOK' },
    ['whitelistPreApproval'] = { color = 3447003,  title = '📋 txAdmin: Whitelist Pre-Approval', webhook = 'WEBHOOK' },
    ['whitelistRequest']    = { color = 1752220,  title = '📩 txAdmin: Whitelist Request', webhook = 'WEBHOOK' },

    -- Other Events
    ['actionRevoked']       = { color = 9807270,  title = '🔄 txAdmin: Action Revoked', webhook = 'WEBHOOK' },
    ['adminAuth']           = { color = 15105570, title = '🔐 txAdmin: Admin Authenticated', webhook = 'WEBHOOK' },
    ['adminsUpdated']       = { color = 3447003,  title = '👥 txAdmin: Admins Updated', webhook = 'WEBHOOK' },
    ['configChanged']       = { color = 15844367, title = '⚙️ txAdmin: Config Changed', webhook = 'WEBHOOK' },
    ['consoleCommand']      = { color = 0,        title = '💻 txAdmin: Console Command', webhook = 'WEBHOOK' },
}