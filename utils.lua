function getTargetName(id)
    if not id then return "Unknown" end
    local name = GetPlayerName(id)
    return name and ("%s [%s]"):format(name, id) or ("Offline Player [%s]"):format(id)
end

local function resolveWebhook(eventInfo)
    if eventInfo.webhook and eventInfo.webhook ~= 'WEBHOOK' then
        return eventInfo.webhook
    end
    return Settings.MasterWebhook.URL
end

function prepareEvents(event, parameters)
    local eventInfo = Settings.Events[event]
    if not eventInfo then return end

    local formattedDescription

    if parameters == nil then
        formattedDescription = "No additional details provided."
    elseif type(parameters) == 'table' then
        formattedDescription = ""
        for key, value in pairs(parameters) do
            local label
            if type(key) == 'string' then
                label = key:gsub("(%l)(%u)", "%1 %2"):gsub("^%l", string.upper)
            else
                label = "Entry " .. tostring(key)
            end

            if type(value) == 'table' then
                local subValues = ""
                for _, subVal in pairs(value) do
                    subValues = subValues .. "• " .. tostring(subVal) .. "\n"
                end
                formattedDescription = formattedDescription .. string.format("**%s**:\n%s", label, subValues)
            elseif type(key) == 'string' and key:lower() == "expiration" then
                if type(value) == "number" and value > 0 then
                    formattedDescription = formattedDescription .. string.format("**%s**: <t:%s:f> (<t:%s:R>)\n", label, value, value)
                elseif value == false or value == 0 then
                    formattedDescription = formattedDescription .. string.format("**%s**: Permanent\n", label)
                else
                    formattedDescription = formattedDescription .. string.format("**%s**: %s\n", label, tostring(value))
                end
            else
                local valStr = tostring(value)
                if valStr ~= "" then
                    formattedDescription = formattedDescription .. string.format("**%s**: %s\n", label, valStr)
                end
            end
        end
    else
        formattedDescription = tostring(parameters)
    end

    sendToDiscord({
        title = eventInfo.title or "Unknown Log Type",
        color = eventInfo.color or 8421504,
        description = formattedDescription,
        webhook = resolveWebhook(eventInfo)
    })
end

-- Formatters for menu actions whose description needs the real event data
-- filled in (coords, target names, etc). Anything not listed here either
-- needs no formatting (e.g. "healed themself") or is a plain %s of the
-- target's name (see targetedActions below).
local menuFormatters = {
    teleportCoords = function(data, description)
        return description:format(data.x or 0.0, data.y or 0.0, data.z or 0.0)
    end,
    teleportPlayer = function(data, description)
        return description:format(getTargetName(data.target), data.x or 0.0, data.y or 0.0, data.z or 0.0)
    end,
    clearArea = function(data, description)
        return description:format(data or 0)
    end,
    playerModeChanged = function(data, description)
        return description:format(tostring(data))
    end,
    spawnVehicle = function(data, description)
        return description:format(tostring(data))
    end,
    announcement = function(data, description)
        return description:format(tostring(data))
    end,
    showPlayerIDs = function(data, description)
        return description:format(data and "ON" or "OFF")
    end,
}

-- Actions whose data is just a player id/server id to resolve into a name
local targetedActions = {
    spectatePlayer = true,
    freezePlayer = true,
    summonPlayer = true,
    drunkEffect = true,
    setOnFire = true,
    wildAttack = true,
}

function prepareMenuEvent(source, action, data)
    local eventInfo = Settings.menuEvents[action]
    if not eventInfo then return end

    local description = eventInfo.description

    local actionDetail
    if menuFormatters[action] then
        actionDetail = menuFormatters[action](data, description)
    elseif targetedActions[action] then
        actionDetail = description:format(getTargetName(data))
    else
        -- No dynamic data to insert (deleteVehicle, vehicleRepair, vehicleBoost,
        -- healSelf, healAll, teleportWaypoint)
        actionDetail = description
    end

    local adminHeader = ("**Admin**: %s [%s]\n"):format(GetPlayerName(source) or "Unknown", source)

    sendToDiscord({
        title = eventInfo.title or "Unknown Menu Action",
        color = eventInfo.color or 8421504,
        description = adminHeader .. "**Action**: " .. actionDetail,
        webhook = resolveWebhook(eventInfo)
    })
end
