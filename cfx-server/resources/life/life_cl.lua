Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(10000)
		TriggerServerEvent('life:salary')
		print("salut")
		local pos = GetEntityCoords(GetPlayerPed(-1))
		print(pos)
		print("salut2")
		TriggerServerEvent('life:savepos')
		print("salut3")
	end
end)
