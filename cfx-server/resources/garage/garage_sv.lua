RegisterServerEvent('garage:askmoney')
AddEventHandler('garage:askmoney', function(total)
  	print("Player ID " ..source)

	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.money) >= tonumber(total)) then
			TriggerClientEvent('garage:FixingCar',source)
	  	-- update player money amount
			user:removeMoney((total + 0.0))
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Vous avez payé ".. tonumber(total).." ~g~$ de réparation")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Vous êtes trop pauvre pour effectuer ces réparations!\n")
		end
 	end)
end)