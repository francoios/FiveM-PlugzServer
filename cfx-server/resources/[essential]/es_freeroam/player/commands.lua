--Help Commands
TriggerEvent('es:addCommand', 'help', function(source, args, user)
  TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "Player Commands ")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "-------------------------------------------------------")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/pv - Get teleported in your personal vehicle")
	TriggerClientEvent("chatMessage", source, "^3SYSTEM", {255, 255, 255}, "/rmwanted - Remove your wanted level")
end)

TriggerEvent('es:addCommand', 'rmwanted', function(source)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		if(user.money > 100) then
			user:removeMoney((100))
			TriggerClientEvent('es_freeroam:wanted', source)
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_LESTER", 1, "Lester", false, "Troubles in paradise are fixed")
		else
			TriggerClientEvent("es_freeroam:notify", source, "CHAR_LESTER", 1, "Lester", false, "Sorry but you need more cash before i can help you")
		end
	end)
end)
