function sendToDiscord(logType, message)
    local logData = Settings.Webhooks[logType]
    local color = logData and logData.color or 8421504
    local title = logData and logData.title or "Unknown Log Type"
    local targetWebhook = (logData and logData.webhook ~= 'WEBHOOK') and logData.webhook or Settings.MasterWebhook

    local formattedDescription = ""
    
    if type(message) == 'table' then
        for key, value in pairs(message) do
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
        formattedDescription = tostring(message)
    end

    local embedData = {
        {
            ['title'] = title,
            ['color'] = color,
            ['footer'] = {
                ['text'] = Settings.Bot.FooterText,
                ['icon_url'] = Settings.Bot.FooterIcon,
            },
            ['description'] = formattedDescription,
            ['timestamp'] = Settings.Misc.IncludeTimestamp and os.date('!%Y-%m-%dT%H:%M:%SZ') or nil,
        }
    }

    local payload = json.encode({ 
        username = Settings.Bot.Username, 
        avatar_url = Settings.Bot.AvatarURL,
        embeds = embedData 
    })

    PerformHttpRequest(targetWebhook, function(err, text, headers) end, 'POST', payload, { ['Content-Type'] = 'application/json' })

    if targetWebhook ~= Settings.MasterWebhook then 
        PerformHttpRequest(Settings.MasterWebhook, function(err, text, headers) end, 'POST', payload, { ['Content-Type'] = 'application/json' }) 
    end
end