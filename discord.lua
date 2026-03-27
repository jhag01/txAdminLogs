local queue = {}
local isProcessing = false

function sendToDiscord(data)
    if not data or not data.webhook or data.webhook == 'WEBHOOK' then return end

    local payload = { 
        username = Settings.Bot.Username, 
        avatar_url = Settings.Bot.AvatarURL,
        embeds = {
            {
                ['title'] = data.title,
                ['color'] = data.color,
                ['footer'] = {
                    ['text'] = Settings.Bot.FooterText,
                    ['icon_url'] = Settings.Bot.FooterIcon,
                },
                ['description'] = data.description,
                ['timestamp'] = Settings.Bot.IncludeTimestamp and os.date('!%Y-%m-%dT%H:%M:%SZ') or nil,
            }
        }
    }

    table.insert(queue, { url = data.webhook, body = json.encode(payload) })

    if data.webhook ~= Settings.MasterWebhook.URL and Settings.MasterWebhook.Enabled then 
        table.insert(queue, { url = Settings.MasterWebhook.URL, body = json.encode(payload) })
    end

    if not isProcessing then
        processQueue()
    end
end

function processQueue()
    CreateThread(function()
        isProcessing = true

        while #queue > 0 do
            local current = queue[1]
            local responseData = nil

            PerformHttpRequest(current.url, function(err, text, headers)
                responseData = { status = err, headers = headers }
            end, 'POST', current.body, { ['Content-Type'] = 'application/json' })

            while not responseData do Wait(10) end

            if responseData.status == 204 or responseData.status == 200 then
                table.remove(queue, 1)
                Wait(100)
            elseif responseData.status == 429 then
                local retryAfter = tonumber(responseData.headers['Retry-After']) or 5000                
                Wait(retryAfter) 
            else
                table.remove(queue, 1)
            end
        end

        isProcessing = false
    end)
end