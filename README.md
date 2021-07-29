# containers
 Placable containers for fivem, can be used for extra storage in houses

https://streamable.com/hmk0hk

# Example of how to use it with your inventory

```
let Containers = [
    { objectID: 758360035, Description: 'Parcel' },
];

function ScanExtraStashes() {
    let player = PlayerPedId();
    let startPosition = GetOffsetFromEntityInWorldCoords(player, 0, 0.1, 0);
    let endPosition = GetOffsetFromEntityInWorldCoords(player, 0, 1.8, -0.4);

    let rayhandle = StartShapeTestRay(
        startPosition[0],
        startPosition[1],
        startPosition[2],
        endPosition[0],
        endPosition[1],
        endPosition[2],
        16,
        player,
        0,
    );

    let vehicleInfo = GetShapeTestResult(rayhandle);

    let hitData = vehicleInfo[4];

    let model = 0;
    let entity = 0;
    if (hitData) {
        model = GetEntityModel(hitData);
    }
    if (model !== 0) {
        for (let x in Containers ) {
            if (x) {
                if (Containers[x].objectID == model) {
                    return GetEntityCoords(hitData);
                }
            }
        }
    }
    
}


Add this to your inventory-open event

    let ContainerFound = ScanExtraStashes();

 if (ContainerFound) {
        let x = parseInt(ContainerFound[0]);
        let y = parseInt(ContainerFound[1]);
        let container = "barrel|" + x + "|" + y;
        emitNet("server-inventory-open", startPosition, cid, "1", "Container-" + container);
 }
```
