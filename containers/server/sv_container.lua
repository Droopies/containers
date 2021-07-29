local Close
local closest

RegisterNetEvent('containers:new')
AddEventHandler('containers:new', function(model, sentCoords)
    local source = source
    exports.ghmattimysql:execute("INSERT INTO containers (model, x, y, z) VALUES (@model, @x, @y, @z)", { 
        ['model'] = model,
        ['x'] = sentCoords.x, 
        ['y'] = sentCoords.y,
        ['z'] = sentCoords.z,
    }, function()
end)
end) 

RegisterServerEvent('ReceiveCoords')
AddEventHandler('ReceiveCoords', function()
    exports.ghmattimysql:execute('SELECT model,x,y,z FROM containers', function(data)
        YourMom = data
        TriggerClientEvent("SpawnCrates", -1, YourMom)
    end)
end)