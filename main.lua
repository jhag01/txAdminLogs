for eventName, data in pairs(Settings.Events) do
    if data.enabled ~= false then
        AddEventHandler('txAdmin:events:' .. eventName, function(eventData)
            prepareEvents(eventName, eventData)
        end)
    end
end

AddEventHandler('txsv:logger:menuEvent', function(source, action, allowed, data)
    if not allowed then return end
    prepareMenuEvent(source, action, data)
end)

if Settings.DeathLog.enabled ~= false then
    AddEventHandler('txsv:logger:deathEvent', function(killer, cause)
        prepareDeathEvent(source, killer, cause)
    end)
end
