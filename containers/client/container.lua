local ContainerID = 0 
local ConCoords = 0

RegisterCommand("PlaceCrate", function()
    TriggerEvent("PlaceCrates", `prop_drop_crate_01_set2`)
end)

RegisterNetEvent("PlaceCrate1")
AddEventHandler("PlaceCrate1", function(model, coords)
    RequestModel(model)
    CreatedObjects = CreateObject(model, coords)
    FreezeEntityPosition(CreatedObjects, true)
    TriggerServerEvent("containers:new", model, coords)
end)

function CrateTarget(distance)
    local Cam = GetGameplayCamCoord()
    local _, Hit, Coords, _, Entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4))
    return Coords
end

function GetCoordsFromCam(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

local hidden = false
scenes = {}
local SpawningCrate = false
local coords = {}

RegisterNetEvent("PlaceCrates")
AddEventHandler("PlaceCrates", function(model)
    TriggerEvent("DoLongHudText", "MiddleMouseButton to Confirm Placement")
    local placement = CrateTarget()
    coords = {}
    SpawningCrate = true

    while SpawningCrate do
        RequestModel(model)
        DisableControlAction(0, 200, true)
        placement = CrateTarget()
        if placement ~= nil then
            Object = model
            local objTypeKey = GetHashKey(Object)
            curObject = CreateObject(Object,placement,false,false,false)
            Citizen.Wait(0)
            DeleteObject(curObject)
            SetModelAsNoLongerNeeded(objTypeKey)
            SetEntityCollision(curObject, false)
            SetEntityCompletelyDisableCollision(curObject, false, false)
            SetEntityAlpha(Object, 0)
        end
        if IsControlJustReleased(0, 27) then
            TriggerEvent("PlaceCrate1", model, placement)
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
    TriggerServerEvent("ReceiveCoords")
    break
end
end)

local sentInfo = {}
local Crates = {}

RegisterNetEvent("SpawnCrates")
AddEventHandler("SpawnCrates", function(sentInfo)
    
    local hellYeah = {}

    Crates = hellYeah

    for i=1, #sentInfo do
        local justCuz = sentInfo[i]
        -- print(justCuz['model'])
        hellYeah[#hellYeah+1] = {
            ['coords'] = vector3(justCuz['x'], justCuz['y'], justCuz['z']),
           CreateObject(`prop_drop_crate_01_set2`, vector3(justCuz['x'], justCuz['y'], justCuz['z'])),
        }
end
    Crates = hellYeah
end)