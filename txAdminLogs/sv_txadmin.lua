ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('txAdmin:events:playerKicked', function(eventData)

    local target = eventData.target
    local author = eventData.author
    local reason = eventData.reason

    sendToDiscord('Player Kicked', "Name: **" .. GetPlayerName(target) .. "** \nAuthor: **" .. author .. "** \nReason: **" .. reason .. "**", 65280)

end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)

    local target = eventData.target
    local author = eventData.author
    local reason = eventData.reason
    local id = eventData.actionId

    sendToDiscord('Player Warned', "Name: **" .. GetPlayerName(target) .. "** \nAuthor: **" .. author .. "** \nReason: **" .. reason .. "**\nID: **" .. id .. "**", 65280)

end)

AddEventHandler('txAdmin:events:playerBanned', function(eventData)

    local target = eventData.target
    local author = eventData.author
    local reason = eventData.reason
    local id = eventData.actionId
    local exp = eventData.expiration

    if not exp then
        exp = 'Never'
    else
        exp = os.date('%c', exp)
    end 

    if (type(target) == "table") then 
        playername = "`Offline Ban`"
    else 
        playername = GetPlayerName(target)
    end
    
    sendToDiscord('Player Banned', "Name: **" .. playername .. "** \nAuthor: **" .. author .. "** \nReason: **" .. reason .. "**\nID: **" .. id .. "**\nExpires: **" .. exp .. "**", 65280)

end)

AddEventHandler('txAdmin:events:playerWhitelisted', function(eventData)

    local target = eventData.target
    local author = eventData.author
    local id = eventData.actionId

    sendToDiscord('Player Whitelisted', "Identifier: **" .. target .. "** \nAuthor: **" .. author .. "**\nID: **" .. id .. "**", 65280)

end)

AddEventHandler('txAdmin:events:announcement', function(eventData)

    local author = eventData.author
    local msg = eventData.message

    if Config.FilterAnnouncements then
        if author ~= 'txAdmin' then
            sendToDiscord('Announcement', "Author: **" .. author .. "**\nBericht: **" .. msg .. "**", 65280)
        end
    else
        sendToDiscord('Announcement', "Author: **" .. author .. "**\nBericht: **" .. msg .. "**", 65280)
    end


end)

AddEventHandler('txAdmin:events:configChanged', function(eventData)

    sendToDiscord('Config Changed', "There have been made changes in the txAdmin settings, if this wasn't you then check it asap.", 65280)

end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)

    local target = eventData.id

    if target == -1 then
        playername = 'Everyone'
    else
        playername = GetPlayerName(target)
    end

    sendToDiscord('Player Healed', "Name: **" .. playername .. "**", 65280)

end)

function sendToDiscord(header, message)
    local webhook = Config.txAdminWebhook
    local name = Config.Username
    local connect = {
          {
              ["title"] = header,
              ["description"] = message
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end