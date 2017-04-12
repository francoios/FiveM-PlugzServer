-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "fatoumata4")

RegisterServerEvent('life:savepos')
AddEventHandler('life:savepos', function()
  print('salut1')
  TriggerEvent('es:getPlayerFromId', source, function(user)
    print('salut')
    local player = user.identifier
    print('Save Position: '..player)
    local pos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(user))))      -- Save this shit to the database
      MySQL:executeQuery("UPDATE users SET lastpos='@pos' WHERE identifier = '@username'",
      {['@username'] = player, ['@pos'] = pos})

      -- Trigger some client stuff
      --TriggerClientEvent("es_freeroam:notify", source, "CHAR_DEFAULT", 1, ""..player, false, "Position sauvegardé!\n")
  end)
end)

RegisterServerEvent('life:salary')
AddEventHandler('life:salary', function()
  	print("Player ID " ..source)
  	local salary = 100
    print("bonjour 1")
	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(user)
      print("bonjour 2")

  	-- update player money amount
  	user:addMoney((salary + 0.0))
    print("bonjour 3")
 	--TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Salaire de base de "..salary.." ~g~$ de reparation")
 	end)
  print("bonjour 4")
end)
