-- Scripted by Xander Tanner-Harrison && Jon P.--
RegisterServerEvent("chatMessage")
AddEventHandler("chatMessage", function(source, n, message)
	if message == "/hu" then
		CancelEvent()
		TriggerClientEvent("Handsup", source)
	end
end)