

-- CHAT ANNONCE (RP)
TriggerEvent('es:addCommand', 'ad', function(source, args, user)
    CancelEvent()
    local message = args[2]
    sendMessage(user,message,"AD")
end)

-- CHAT HRP
TriggerEvent('es:addCommand', '/', function(source, args, user)
    CancelEvent()
    local message = args[2]
    sendMessage(user,message,"HRP")
end)

-- CHAT ADMIN
TriggerEvent('es:addCommand', '//', function(source, args, user)
    CancelEvent()
    local message = args[2]
    sendMessage(user,message,"ADMIN")
end)

function sendMessage(user, message, canal)

    local msgCanal = ""
    local msgTarget = "-1"
    local msgCouleur = ""

    if canal == "AD" then
        msgCanal = "[ANNONCE RP]"
        msgCouleur = {89,35,255}
    elseif canal == "HRP" then
        msgCanal = "[HORS RP]"
        msgCouleur = {255,114,72}
    elseif canal == "ADMIN" then
        msgCanal = "[AUX ADMINS]"
        msgTarget = "steam:11000010346bab7"
        msgCouleur = {0,126,14}
    end

    msgCanal = msgCanal .. " " ..user.identifier

    print("Envoie du message "..msgCanal.. " : "..message)

    TriggerClientEvent("chatMessage", "", msgCanal, msgCouleur, message)
end