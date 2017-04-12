RegisterNetEvent("CGC:lockdoors")

local lastCar = nil

AddEventHandler("CGC:lockdoors", function()
    Citizen.CreateThread(function()
        car = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        
        if not car and lastCar == nil then
            TriggerEvent("chatMessage", "ERROR", {255, 0, 0}, "You have to sit in a vehicle to set it as yours.")
            return
        elseif car then
            lastCar = car
        end
        
        lockStatus = GetVehicleDoorLockStatus(lastCar)
        if lockStatus == 0 or lockStatus == 1 then
            SetVehicleDoorsLocked(lastCar, 2)
            SetVehicleDoorsLockedForPlayer(lastCar, PlayerId(), false)
            TriggerEvent("chatMessage", "INFO", {255, 255, 0}, "Door is now ^1locked^0.")
        else
            SetVehicleDoorsLocked(lastCar, 1)
            TriggerEvent("chatMessage", "INFO", {255, 255, 0}, "Door is now ^2unlocked^0.")
        end
    end)
end)