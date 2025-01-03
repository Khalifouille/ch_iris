AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        local pedModel = 'a_m_y_hipster_01'
        local x, y, z = 84.870331, -448.483521, 37.536255
        TriggerClientEvent('ch_iris:createPed', -1, pedModel, x, y, z)
    end
end)

RegisterNetEvent('ch_iris:pedKilled')
AddEventHandler('ch_iris:pedKilled', function(killerId)
    exports.ox_inventory:AddItem(killerId, 'tete_de_iris', 1)
end)