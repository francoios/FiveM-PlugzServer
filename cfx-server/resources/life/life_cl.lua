Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(60000)
		TriggerServerEvent('life:salary')
		--TriggerServerEvent('life:savpos')
	end
end)