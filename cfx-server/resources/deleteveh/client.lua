-- Register a network event 
RegisterNetEvent( 'deleteVehicle' )

deletingVehicle = false 

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
AddEventHandler( 'deleteVehicle', function()
    deletingVehicle = true 
end )

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )
        
        if ( deletingVehicle ) then 
            -- Get the ped of the player who typed /dv
            ped = GetPlayerPed( -1 )
            
            -- If the ped is valid 
            if ( ped ) then 
            
                -- Check to see if the player is in a car 
                --inVehicle = IsPedInAnyVehicle( ped, false )
                inVehicle = IsPedSittingInAnyVehicle( ped )
                
                -- If the player is in a car 
                if ( inVehicle ) then 
                
                    -- Get the car they're in 
                    car = GetVehiclePedIsIn( ped, false )
                    
                    -- Set the vehicle as a mission entity, this means that 
                    -- we can delete it if it's non-player spawned.
                    SetEntityAsMissionEntity( car, true, true )

                    -- Delete it 
                    deleteCar( car )
                end 
            end 
            
            deletingVehicle = false 
        end 
    end 
end )

-- Delete car function borrowed frtom Mr.Scammer's model blacklist, thanks to him!
function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
	--Citizen.InvokeNative( 0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized( entity ) )
end