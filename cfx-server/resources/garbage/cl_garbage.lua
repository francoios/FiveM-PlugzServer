--client
local GUI = {}
local VEH = {}
RegisterNetEvent('rp:initialized')
AddEventHandler('rp:initialized', function()
	GUI = exports.rp_gui:Gui()
	VEH = exports.rp_vehicles:requireVeh()
end)
--GUI = exports.rp_gui:Gui()
--VEH = exports.rp_vehicles:requireVeh()
local deliverto = {
	{-552.6029, 306.585,83.2896,48.9564},
	{-1317.282,-1257.896,4.5835,295.6165},
    {-693.537,-2453.527,13.8833,253.068},
    {426.6629,-1552.788,29.2529,332.355}

}
local deliverfrom = {
	{vehpos = {-344.365,-1530.593,27.3034,270.916}, pos = {-322.057,  -1546.100,  30.0199}}
}
local vehicles = {'trash'}
local delivery_blips ={}
local inrangeofdpoint = false
local currentlocation = nil
local deliverto_point = nil
local inprogress = false
local delivered = false
local delivered_packages = 0
local income = 30

local function LocalPed()
return GetPlayerPed(-1)
end

function IsPlayerInRangeOfDeliveryPoint()
return inrangeofdpoint
end

function ShowDeliveryPointBlips(bool)
	if #delivery_blips > 0 then
		for i,b in ipairs(delivery_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		delivery_blips = {}
	end
		for i,pos in pairs(deliverfrom) do
			local pos = pos.pos
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,357)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Garbage')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipColour(blip,2)
			table.insert(delivery_blips, {blip = blip, pos = pos})
		end
end
local lock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local inrange = false
		for i,b in ipairs(deliverfrom) do
			if lock == false and inprogress == false and IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos[1],b.pos[2],b.pos[3],GetEntityCoords(LocalPed())) < 100 then
				DrawMarker(1,b.pos[1],b.pos[2],b.pos[3],0,0,0,0,0,0,2.001,2.0001,0.8001,252, 166, 7,150,0,0,0,0)
				
				
				if GetDistanceBetweenCoords(b.pos[1],b.pos[2],b.pos[3],GetEntityCoords(LocalPed())) < 2 then
					--drawTxt(text,font,centre,x,y,scale,r,g,b,a)
					GUI.drawOnWorld('Press ~y~[E] ~w~to start',0,1,b.pos[1],b.pos[2],b.pos[3] + 1.2,0.5,255, 255, 255,255)
					if IsControlJustPressed(1,51) then
						StartDelivery(b.vehpos)
						currentlocation = b.pos
					end
					inrange = true	
				elseif GetDistanceBetweenCoords(b.pos[1],b.pos[2],b.pos[3],GetEntityCoords(LocalPed())) < 30 then 
					GUI.drawOnWorld('~y~[JOB]~w~GARBAGE',0,1,b.pos[1],b.pos[2],b.pos[3] + 2.0,0.5,255, 255, 255,255)
				end
			end
		end
		inrangeofdpoint = inrange
	end
end)
local job_vehicle = { handle = nil, blip = nil}
function SetUpVehicle(model,pos)
	local carid = GetHashKey(model)
	if LocalPed() and LocalPed() ~= -1 then
		VEH.SpawnVehicle(carid,pos[1],pos[2],pos[3], pos[4], true, false,true,true,function(veh)
			job_vehicle.handle = veh
			local blip = AddBlipForEntity(job_vehicle.handle)
			SetBlipSprite(blip,1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('vehicle')
			EndTextCommandSetBlipName(blip)
			SetBlipColour(blip,3)
			job_vehicle.blip = blip
		end)
	end
end
local destination = { pos = {0,0,0}, blip = nil}
function SetUpDestination(pos)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3]+100.01,Citizen.PointerValueFloat(),0)
	local blip = AddBlipForCoord(pos[1],pos[2],g)
	SetBlipSprite(blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Destination')
	EndTextCommandSetBlipName(blip)
	SetBlipRoute(blip,true)
	pos[3] = g
	destination.pos = pos
	destination.blip = blip
end

function StartDelivery(pos)
	Citizen.CreateThread(function()
		lock = true
		DoScreenFadeOut(500)
		while IsScreenFadingOut() do
            Citizen.Wait(0)
        end
		delivered_packages = 0
		deliverto_point = deliverto[math.random(1,#deliverto)]
		local vmodel = vehicles[math.random(1,#vehicles)]
		SetUpVehicle(vmodel,pos)
		Citizen.Wait(500)
		SetUpDestination(deliverto_point)
		Citizen.Wait(500)
		while DoesEntityExist(job_vehicle.handle) == false do
			Citizen.Wait(0)
		end
		inprogress = true
		lock = false
		Citizen.Wait(500)
		ShutdownLoadingScreen()

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end
		GUI.drawTimedText('Pickup ~b~garbage~w~ from ~y~dumpster',0,1,0.5,0.9,0.6,255,255,255,255,10000)
	end)
end

function Delivered()
	Citizen.CreateThread(function()
		DoScreenFadeOut(500)
		while IsScreenFadingOut() do
            Citizen.Wait(0)
        end
		delivered_packages = delivered_packages +1
		if DoesBlipExist(destination.blip) then
			SetBlipAsMissionCreatorBlip(destination.blip,false)
			Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(destination.blip))
		end
		SetUpDestination(currentlocation)
		delivered = true
		Citizen.Wait(2000)
		ShutdownLoadingScreen()

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end
		GUI.drawTimedText('Take ~b~garbage~w~ back to ~y~the recycling center',0,1,0.5,0.9,0.6,255,255,255,255,10000)
	end)
end
function ClearVehicle(veh)
	Citizen.CreateThread(function()
		local h = GetHashKey("A_M_Y_StLat_01")
		while not HasModelLoaded(h) do
			Citizen.Wait(0)
			RequestModel(h)
		end
		local ped = CreatePed(4, h, -330.973,-1551.160,27.7188,276.445, true, false)
		TaskVehiclePark(ped, veh, 3578.206,3760.602,29.9226,174.918, 1, 20.011, false)
		SetPedKeepTask(ped, true)
		local s = 0
		while s < 120 do
			Citizen.Wait(1000)
			s = s + 1
		end
		if DoesEntityExist(ped) then
			Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(ped))
		end
		if DoesEntityExist(veh) then
			VEH.DisallowVehicle(veh)
			Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(veh))
		end
	end)
end
function FinishDelivery()
	--Clear up all the things
	inprogress = false
	currentlocation = nil
	deliverto_point = nil
	delivered = false
	
	if DoesBlipExist(job_vehicle.blip) then
		SetBlipAsMissionCreatorBlip(job_vehicle.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(job_vehicle.blip))
	end
	local vehdamage = 0
	if DoesEntityExist(job_vehicle.handle) then
		SetVehicleDoorsLockedForAllPlayers(job_vehicle.handle,1)
		if GetEntityHealth(job_vehicle.handle) < GetEntityMaxHealth(job_vehicle.handle) then
			vehdamage = ((GetEntityMaxHealth(job_vehicle.handle)-GetEntityHealth(job_vehicle.handle))/GetEntityMaxHealth(job_vehicle.handle))
		end
		ClearVehicle(job_vehicle.handle)
		--[[SetEntityCoords(job_vehicle.handle, -1932.0, -1299.0, -12.0)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))]]
	end
	if DoesBlipExist(destination.blip) then
		SetBlipAsMissionCreatorBlip(destination.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(destination.blip))
	end
	job_vehicle = { handle = nil, blip = nil}
	destination = { pos = {0,0,0}, blip = nil}
	--Pay the player
	local earned = math.random(250,400)
    local stats = 1
	earned = math.floor((earned - vehdamage - income))
	TriggerServerEvent('rp:addedMoney',earned)
    TriggerServerEvent('rp:addedGarbage',stats)
    TriggerServerEvent('rp:addedGarbageIncome',income)
	TriggerEvent('chatMessage','',{0,255,0},'You earned ^2'..earned..'$ ^0 for dropping off ^5garbage')
end
function BreakVehicle()
	inprogress = false
	currentlocation = nil
	deliverto_point = nil
	delivered = false
	if DoesBlipExist(job_vehicle.blip) then
		SetBlipAsMissionCreatorBlip(job_vehicle.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(job_vehicle.blip))
	end
	if DoesBlipExist(destination.blip) then
		SetBlipAsMissionCreatorBlip(destination.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(destination.blip))
	end
	job_vehicle = { handle = nil, blip = nil}
	destination = { pos = {0,0,0}, blip = nil}
	TriggerEvent('chatMessage','',{0,255,0},'^1You failed')
end
function DeliveryFailed()
	inprogress = false
	currentlocation = nil
	deliverto_point = nil
	delivered = false
	if DoesBlipExist(job_vehicle.blip) then
		SetBlipAsMissionCreatorBlip(job_vehicle.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(job_vehicle.blip))
	end
	if DoesEntityExist(job_vehicle.handle) then
		SetEntityCoords(job_vehicle.handle, -1932.0, -1299.0, -12.0)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
	end
	if DoesBlipExist(destination.blip) then
		SetBlipAsMissionCreatorBlip(destination.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(destination.blip))
	end
	job_vehicle = { handle = nil, blip = nil}
	destination = { pos = {0,0,0}, blip = nil}
	TriggerEvent('chatMessage','',{0,255,0},'^1You failed')
end

function Continue()
	local vehdamage = 0
	if DoesEntityExist(job_vehicle.handle) then
		if GetEntityHealth(job_vehicle.handle) < GetEntityMaxHealth(job_vehicle.handle) then
			vehdamage = ((GetEntityMaxHealth(job_vehicle.handle)-GetEntityHealth(job_vehicle.handle))/GetEntityMaxHealth(job_vehicle.handle))
		end
	end
	if DoesBlipExist(destination.blip) then
		SetBlipAsMissionCreatorBlip(destination.blip,false)
		Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(destination.blip))
	end
	local earned = math.random(250,400)
	earned = math.floor((earned - vehdamage - income))
	TriggerServerEvent('rp:addedMoney',earned)
    TriggerServerEvent('rp:addedGarbage',stats)
    TriggerServerEvent('rp:addedGarbageIncome',income)
	TriggerEvent('chatMessage','',{0,255,0},'You earned ^2'..earned..'$ ^0 for dropping off ^5garbage')
	delivered = false
	deliverto_point = deliverto[math.random(1,#deliverto)]
	SetUpDestination(deliverto_point)
	GUI.drawTimedText('Pickup ~b~garbage~w~ from ~y~dumpster',0,1,0.5,0.9,0.6,255,255,255,255,10000)
end
--Main job thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if inprogress then
			if DoesEntityExist(job_vehicle.handle) then
				if IsVehicleDriveable(job_vehicle.handle, 0) then
					if delivered == false then
						if GetDistanceBetweenCoords(deliverto_point[1],deliverto_point[2],deliverto_point[3],GetEntityCoords(job_vehicle.handle)) < 5 then
							if IsVehicleStopped(job_vehicle.handle) then
								if IsPedSittingInVehicle(LocalPed(), job_vehicle.handle) then
									Delivered()
								else
									GUI.drawText('~r~Get back in vehicle',0,1,0.5,0.9,0.6,255,255,255,255)
								end
							end
						else
							if IsPedSittingInVehicle(LocalPed(), job_vehicle.handle) then
								if GetDistanceBetweenCoords(deliverto_point[1],deliverto_point[2],deliverto_point[3],GetEntityCoords(LocalPed())) < 50 then
									DrawMarker(1,deliverto_point[1],deliverto_point[2],deliverto_point[3] ,0,0,0,0,0,0,5.001,5.0001,1.2001,0,155,255,200,0,0,0,0)
								end
							elseif GetDistanceBetweenCoords(GetEntityCoords(job_vehicle.handle),GetEntityCoords(LocalPed())) > 100 then
								DeliveryFailed()
							else
								GUI.drawText('Get in ~b~vehicle',0,1,0.5,0.9,0.6,255,255,255,255)
							end
						end
					else
						if GetDistanceBetweenCoords(currentlocation[1],currentlocation[2],currentlocation[3],GetEntityCoords(job_vehicle.handle)) < 15 and IsVehicleStopped(job_vehicle.handle) then
							if IsPedSittingInVehicle(LocalPed(), job_vehicle.handle) then
									--GUI.drawText('Leave ~b~vehicle ~w~to finish or press [E] to continue',0,1,0.5,0.9,0.6,255,255,255,255)
									GUI.drawOnWorld('Leave ~b~vehicle ~w~to finish or press ~y~[E] ~w~to continue',0,1,currentlocation[1],currentlocation[2],currentlocation[3] + 1.0,0.5,255, 255, 255,255)
									if IsControlJustPressed(1,51) then
										Continue()
									end
							else
								FinishDelivery()
							end
						else
							if IsPedSittingInVehicle(LocalPed(), job_vehicle.handle) then
								if GetDistanceBetweenCoords(currentlocation[1],currentlocation[2],currentlocation[3],GetEntityCoords(LocalPed())) < 50 then
									
									DrawMarker(1,currentlocation[1],currentlocation[2],currentlocation[3],0,0,0,0,0,0,15.001,15.0001,1.4001,0,155,255,200,0,0,0,0)
								end
								
							elseif GetDistanceBetweenCoords(GetEntityCoords(job_vehicle.handle),GetEntityCoords(LocalPed())) > 100 then
								DeliveryFailed()
							else
								GUI.drawText('Get in ~b~vehicle',0,1,0.5,0.9,0.6,255,255,255,255)
							end
						end
					end
				else
					BreakVehicle()
				end
			else
				DeliveryFailed()
			end
		end
	end
end)


ShowDeliveryPointBlips(true)
RegisterNetEvent("rp:initialized")
AddEventHandler('rp:initialized', function(spawn)
	ShowDeliveryPointBlips(true)
end)