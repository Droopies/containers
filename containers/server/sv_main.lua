local Close
local closest

RegisterNetEvent('containers:new')
AddEventHandler('containers:new', function(model, sentCoords)
    local source = source
    
        if Config.ghmattimysql then
            exports.ghmattimysql:execute("INSERT INTO containers (model, x, y, z) VALUES (@model, @x, @y, @z)", { 
                ['model'] = model,
                ['x'] = sentCoords.x, 
                ['y'] = sentCoords.y,
                ['z'] = sentCoords.z,
            }, function()
        end)
    else
        MySQL.Async.execute("INSERT INTO containers (model, x, y, z) VALUES (@model, @x, @y, @z)",
        {
            ['model'] = model,
            ['x'] = sentCoords.x, 
            ['y'] = sentCoords.y,
            ['z'] = sentCoords.z,
        }, function()
        end)
    end
end) 

RegisterServerEvent('ReceiveCoords')
AddEventHandler('ReceiveCoords', function()
    if Config.ghmattimysql then
        exports.ghmattimysql:execute('SELECT model,x,y,z FROM containers', function(data)
            YourMom = data
            TriggerClientEvent("SpawnCrates", -1, YourMom)
        end)
    else
        MySQL.Async.execute('SELECT model,x,y,z FROM containers', function(data)
            YourMom = data
            TriggerClientEvent("SpawnCrates", -1, YourMom)
        end)
    end
end)
