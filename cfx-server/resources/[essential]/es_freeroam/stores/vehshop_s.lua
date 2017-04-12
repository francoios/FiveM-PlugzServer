require "resources/essentialmode/lib/MySQL"
MySQL:open(database.host, database.name, database.username, database.password)

RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(vehicle, price)
	TriggerEvent('es:getPlayerFromId', source, function(user)

	if (tonumber(user.money) >= tonumber(price)) then
    local player = user.identifier
    print(player)
			-- Pay the shop (price)
			user:removeMoney((price))
      -- Save this shit to the database
      MySQL:executeQuery("UPDATE users SET personalvehicle='@vehicle' WHERE identifier = '@username'",
      {['@username'] = player, ['@vehicle'] = vehicle})
      -- Trigger some client stuff
      TriggerClientEvent('FinishMoneyCheckForVeh',source)
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "Drive safe with this new car, this is not Carmageddon!\n")
    else
      -- Inform the player that he needs more money
    TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "You dont have enough cash to buy this car!\n")
	end
end)
end)

-- Spawn the personal vehicle
TriggerEvent('es:addCommand', 'pv', function(source, user)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local executed_query = MySQL:executeQuery("SELECT * FROM users WHERE identifier = '@username'",{['@username'] = player})
  	local result = MySQL:getResults(executed_query, {'personalvehicle'})

    if(result)then
		for k,v in ipairs(result)do
      print(v.personalvehicle)
      vehicle = v.personalvehicle
    end
  end

  	TriggerClientEvent('vehshop:spawnVehicle', source, vehicle)
  end)
end)
