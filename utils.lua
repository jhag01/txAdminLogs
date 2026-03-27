function getTargetName(id)
    if not id then return "Unknown" end
    local name = GetPlayerName(id)
    return name and ("%s [%s]"):format(name, id) or ("Offline Player [%s]"):format(id)
end

function prepareEvents(event, parameters)
    local data = Settings.Events[event]
    if not data then return end
    local color = data.color or 8421504
    local title = data.title or "Unknown Log Type"
    local webhook = (data.webhook and data.webhook ~= 'WEBHOOK') and data.webhook or Settings.MasterWebhook.URL

    local formattedDescription = ""
    
    if type(parameters) == 'table' then
        for key, value in pairs(parameters) do
            local label = key:gsub("(%l)(%A)", "%1 %2"):gsub("^%l", string.upper)
            
            if type(value) == 'table' then
                local subValues = ""
                for _, subVal in pairs(value) do
                    subValues = subValues .. "• " .. tostring(subVal) .. "\n"
                end
                formattedDescription = formattedDescription .. string.format("**%s**:\n%s", label, subValues)
            elseif key:lower() == "expiration" then
                if type(value) == "number" and value > 0 then
                    formattedDescription = formattedDescription .. string.format("**%s**: <t:%s:f> (<t:%s:R>)\n", label, value, value)
                elseif value == false or value == 0 then
                    formattedDescription = formattedDescription .. string.format("**%s**: Permanent\n", label)
                else
                    formattedDescription = formattedDescription .. string.format("**%s**: %s\n", label, tostring(value))
                end
            else
                local valStr = tostring(value)
                if valStr ~= "" and valStr ~= "table: 0x..." then 
                    formattedDescription = formattedDescription .. string.format("**%s**: %s\n", label, valStr)
                end
            end
        end
    else
        formattedDescription = tostring(parameters)
    end

    sendToDiscord({
        title = title,
        color = color,
        description = formattedDescription,
        webhook = webhook
    })
end

function prepareMenuEvent(source, action, data)
    local data = Settings.menuEvents[action]
    if not data then return end

    local color = data.color or 8421504
    local title = data.title or "Unknown Menu Action"
    local webhook = (data.webhook and data.webhook ~= 'WEBHOOK') and data.webhook or Settings.MasterWebhook.URL

    local adminName = GetPlayerName(source) or "Unknown"
    local adminHeader = ("**Admin**: %s [%s]\n"):format(adminName, source)

    local actionDetail = ""
    
    if action == 'teleportCoords' then
        actionDetail = data.description:format(data.x or 0.0, data.y or 0.0, data.z or 0.0)

    elseif action == 'teleportPlayer' then
        local targetName = getTargetName(data.target)
        actionDetail = data.description:format(targetName, data.x or 0.0, data.y or 0.0, data.z or 0.0)

    elseif action == 'clearArea' then
        actionDetail = data.description:format(data or 0)

    elseif action == 'playerModeChanged' or action == 'spawnVehicle' or action == 'announcement' then
        actionDetail = data.description:format(tostring(data))

    elseif action == 'showPlayerIDs' then
        actionDetail = data.description:format(data and "ON" or "OFF")

    elseif type(data) == 'number' or (type(data) == 'string' and action ~= 'spawnVehicle') then
        local targetName = getTargetName(data)
        actionDetail = data.description:format(targetName)

    else
        actionDetail = data.description
    end

    local finalDescription = adminHeader .. "**Action**: " .. actionDetail

    sendToDiscord({
        title = title,
        color = color,
        description = finalDescription,
        webhook = webhook
    })
end