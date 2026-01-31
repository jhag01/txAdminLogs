for eventName, data in pairs(Settings.Webhooks) do
    AddEventHandler('txAdmin:events:' .. eventName, function(eventData)
        sendToDiscord(eventName, eventData)
    end)
end