local spawned = false
local ped

Citizen.CreateThread(function()
    local pedModel = "u_f_o_carol"
    local x, y, z = 80.597809, -441.784607, 37.536255

    RequestModel(GetHashKey(pedModel))
    while not HasModelLoaded(GetHashKey(pedModel)) do
        Citizen.Wait(1)
    end

    if not HasModelLoaded(GetHashKey(pedModel)) then
        return
    end

    if not spawned then
        ped = CreatePed(4, GetHashKey(pedModel), x, y, z - 1.0, 0.0, true, true)
        if DoesEntityExist(ped) then
        else
            return
        end

        FreezeEntityPosition(ped, true)
        if not NetworkGetEntityIsNetworked(ped) then
            NetworkRegisterEntityAsNetworked(ped)
        end
        spawned = true

        SetEntityAsMissionEntity(ped, true, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedCombatAttributes(ped, 46, 1)
        SetPedArmour(ped, 100)
        SetPedMaxHealth(ped, 200)
        SetPedRelationshipGroupHash(ped, GetHashKey("CIVMALE"))
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetPedCanRagdoll(ped, false)
        SetModelAsNoLongerNeeded(GetHashKey(pedModel))
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if spawned and DoesEntityExist(ped) then
            local pedCoords = GetEntityCoords(ped)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - pedCoords)

            if distance < 5.0 then
                DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.0, "IRIS")
            end

            if IsPedDeadOrDying(ped, true) then
                local killer = GetPedSourceOfDeath(ped)
                if killer and IsEntityAPed(killer) and IsPedAPlayer(killer) then
                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    TriggerServerEvent('ch_iris:pedKilled', GetPlayerServerId(killerId))
                end
                spawned = false
            end
        end
    end
end)