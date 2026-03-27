for eventName, data in pairs(Settings.Events) do
    AddEventHandler('txAdmin:events:' .. eventName, function(eventData)
        prepareEvents(eventName, eventData)
    end)
end

AddEventHandler('txsv:logger:menuEvent', function(source, action, allowed, data)
    if not allowed then return end
    prepareMenuEvent(source, action, data)
end)