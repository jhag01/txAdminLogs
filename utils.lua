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

local function truncate(str, maxLen)
    str = tostring(str)
    if #str > maxLen then
        return str:sub(1, maxLen - 1) .. "…"
    end
    return str
end

-- Discord caps embeds at 25 fields, and each field needs a non-empty name/value
local function addField(fields, name, value, inline)
    if #fields >= 25 then return end
    value = tostring(value)
    if value == "" then value = "—" end
    fields[#fields + 1] = {
        name = truncate(name, 256),
        value = truncate(value, 1024),
        inline = inline or false
    }
end

function prepareEvents(event, parameters)
    local eventInfo = Settings.Events[event]
    if not eventInfo or eventInfo.enabled == false then return end

    local fields = {}

    if type(parameters) == 'table' then
        for key, value in pairs(parameters) do
            local label
            if type(key) == 'string' then
                label = key:gsub("(%l)(%u)", "%1 %2"):gsub("^%l", string.upper)
            else
                label = "Entry " .. tostring(key)
            end

            if type(value) == 'table' then
                local subValues = {}
                for _, subVal in pairs(value) do
                    subValues[#subValues + 1] = "• " .. tostring(subVal)
                end
                addField(fields, label, table.concat(subValues, "\n"))
            elseif type(key) == 'string' and key:lower() == "expiration" then
                if type(value) == "number" and value > 0 then
                    addField(fields, label, ("<t:%s:f> (<t:%s:R>)"):format(value, value))
                elseif value == false or value == 0 then
                    addField(fields, label, "Permanent")
                else
                    addField(fields, label, tostring(value))
                end
            else
                addField(fields, label, tostring(value), true)
            end
        end
    elseif parameters ~= nil then
        addField(fields, "Details", tostring(parameters))
    end

    if #fields == 0 then
        addField(fields, "Details", "No additional details provided.")
    end

    sendToDiscord({
        title = eventInfo.title or "Unknown Log Type",
        color = eventInfo.color or 8421504,
        fields = fields,
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
    if not eventInfo or eventInfo.enabled == false then return end

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

    local fields = {}
    addField(fields, "Admin", ("%s [%s]"):format(GetPlayerName(source) or "Unknown", source), true)
    addField(fields, "Action", actionDetail, true)

    sendToDiscord({
        title = eventInfo.title or "Unknown Menu Action",
        color = eventInfo.color or 8421504,
        fields = fields,
        webhook = resolveWebhook(eventInfo)
    })
end

-- txAdmin's own client-side death detector fires this automatically for every
-- death (TriggerServerEvent('txsv:logger:deathEvent', killer, cause)); `source`
-- is the victim, `killer` is a server id or `false`/absent for suicide/NPC.
function prepareDeathEvent(victim, killer, cause)
    local eventInfo = Settings.DeathLog
    if not eventInfo or eventInfo.enabled == false then return end

    local fields = {}
    addField(fields, "Victim", getTargetName(victim), true)
    addField(fields, "Killer", killer and getTargetName(killer) or "N/A", true)
    addField(fields, "Cause", cause or "unknown", true)

    sendToDiscord({
        title = eventInfo.title or "💀 Player Death",
        color = eventInfo.color or 8421504,
        fields = fields,
        webhook = resolveWebhook(eventInfo)
    })
end
