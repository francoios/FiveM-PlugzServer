local foodload = false
Citizen.CreateThread(function()
	while true do
    Wait(0)
    if (foodload == false) then
      -- Load some model
      RequestModel(0xa96e2604)
      while not HasModelLoaded(0xa96e2604) do
        Wait(1)
      end

      -- Add a blip for the foodstore
      foodcorner = AddBlipForCoord(-1638.375, -1082.931, 13.081)
      SetBlipSprite(foodcorner, 97)
      SetBlipAsShortRange(foodcorner, false)

      Citizen.Trace("Food Blip added\n")
      foodshop = CreatePed(4, 0xa96e2604, -1638.375, -1082.931, 13.081, 233.611, false, false)
      SetPedCombatAttributes(foodshop, 46, true)
      foodload = true
    end

    local playerPed = GetPlayerPed(-1)
    local playerCoord = GetEntityCoords(playerPed, 0)
    -- Check if the player is near a food store
    if GetDistanceBetweenCoords(playerCoord, -1638.375, -1082.931, 13.081) < 2 then
      ShowNotification("Appuyez E pour acheter de la nourriture")
      if(IsControlPressed(1, 38)) then
        -- Reset players health
      end
    end

  end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
