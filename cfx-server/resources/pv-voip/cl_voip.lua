local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local voip = {}
voip['default'] = {name = 'default', setting = 15.0}
voip['local'] = {name = 'local', setting = 10.0}
voip['whisper'] = {name = 'whisper', setting = 2.0}
voip['yell'] = {name = 'yell', setting = 25.0}

local radio = false

AddEventHandler('onClientMapStart', function()
	NetworkSetTalkerProximity(voip['default'].setting)
end)

function RadioTalk()
	if not radio then
		radio = true
		NotificationMessage("Vous parlez sur le canal Police")
		NetworkSetVoiceChannel(1)
		NetworkSetVoiceActive(true)
	elseif radio then
		radio = false
		NotificationMessage("Vous parlez normallement")
		--NetworkSetTalkerProximity(voip['default'].setting)
    	N_0xe036a705f989e049()
    	NetworkSetVoiceActive(true)
    end
end



Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 57) or IsDisabledControlJustPressed(1, 57) then --Trouver la touche "E" touche E trouvé
			RadioTalk()
        end
    end
end)

RegisterNetEvent('pv:voip')
AddEventHandler('pv:voip', function(voipDistance)

	if voip[voipDistance]then
		distanceName = voip[voipDistance].name
		distanceSetting = voip[voipDistance].setting
	else
		distanceName = voip['default'].name
		distanceSetting = voip['default'].setting
	end
	
	NotificationMessage("Your VOIP is now ~b~" .. distanceName ..".")
	NetworkSetTalkerProximity(distanceSetting)
		
end)

function NotificationMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end