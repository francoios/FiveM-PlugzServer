-- Loading MySQL Class
require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "fatoumata4")

--RegisterServerEvent('life:savpos')
--AddEventHandler('life:savpos', function(pos)
--    print('Save Position: '..player)
--    local player = user.identifier
--    TriggerEvent('es:getPlayerFromId', source, function(user)
      -- Save this shit to the database
--      MySQL:executeQuery("UPDATE users SET lastpos = '@pos' WHERE identifier = '@username'",
--      {['@username'] = player, ['@pos'] = pos})

      -- Trigger some client stuff
--      TriggerClientEvent("es_freeroam:notify", source, "CHAR_DEFAULT", 1, ""..player, false, "Position sauvegardé!\n")
--  end)
--end)

RegisterServerEvent('life:salary')
AddEventHandler('life:salary', function()
  	print("Player ID " ..source)
  	local salary = 100
	-- Get the players money amount
	TriggerEvent('es:getPlayerFromId', source, function(user)

  	-- update player money amount
  	user:addMoney((salary + 0.0))
 	--TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Salaire de base de ~g~"..salary.."$")
 	end)
end)