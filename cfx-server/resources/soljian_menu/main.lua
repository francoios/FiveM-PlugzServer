Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local showtrainer = false

Citizen.CreateThread(function()
    while true do
        Wait(1)

        if IsControlJustReleased(1, Keys['L']) and not blockinput then -- f6
            if not showtrainer then
                showtrainer = true
                SendNUIMessage({
                    showtrainer = true
                })
            else
                showtrainer = false
                SendNUIMessage({
                    hidetrainer = true
                })
            end
        end

        if showtrainer and not blockinput then
            if IsControlJustReleased(1, 176) then -- enter
                SendNUIMessage({
                    trainerenter = true
                })
            elseif IsControlJustReleased(1, 177) then -- back / right click
                SendNUIMessage({
                    trainerback = true
                })
            end

            if IsControlJustReleased(1, 172) then -- up
                SendNUIMessage({
                    trainerup = true
                })
            elseif IsControlJustReleased(1, 173) then -- down
                SendNUIMessage({
                    trainerdown = true
                })
            end

            if IsControlJustReleased(1, 174) then -- left
                SendNUIMessage({
                    trainerleft = true
                })
            elseif IsControlJustReleased(1, 175) then -- right
                SendNUIMessage({
                    trainerright = true
                })
            end
        end
    end
end)

RegisterNUICallback("playsound", function(data, cb)
    PlaySoundFrontend(-1, data.name, "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

    cb("ok")
end)

RegisterNUICallback("trainerclose", function(data, cb)
    showtrainer = false

    cb("ok")
end)

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}; i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end