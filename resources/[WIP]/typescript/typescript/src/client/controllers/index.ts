import { Delay, Access, Wave, vector3, UI, Inv } from "./utils";

export const Init = async (): Promise<void> => {};

let inZone = false

RegisterCommand("+tsTest", async () => {
    if (inZone) {
        console.log("keypressed")
        const count = Inv.Search('count', 'vpn')
        if (count > 0) {
            UI.Circle((s) => {
                if (s) {
                    emit('ox_lib:notify', {
                        type: 'success',
                        description: 'Successfully did something'
                    })
                } else {
                    ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false, false);
                }
            }, 2, 20)
        } else {
            emit('ox_lib:notify', {
                type: 'error',
                description: 'You don\'t have a vpn'
            })
        }
    }
}, false)
RegisterCommand("-tsTest", async () => {

}, false)
Access.AddKeyMapping("Typescript", "+tsTest", "-tsTest", "Testing", "keyboard", 'E')

on('wv-lib:onEnter', async (self: any) => {
    if (self.name === "test") {
        inZone = true
        console.log("entered");
        Wave.showTextUI(`[${Access.GetKeyMapping("+tsTest")}] Use`);
    }
    // Code that gets executed once the event is triggered goes here.
});

on('wv-lib:onExit', async (self: any) => {
    if (self.name === "test") {
        inZone = false
       Wave.hideTextUI();
    }
    // Code that gets executed once the event is triggered goes here.
});

Wave.CreateSphereZone({
    coords: vector3(-74.46841, -818.9703, 326.17083),
    radius: 0.8,
    debug: true,
    name: "test"
})

// setTick(async () => {
//     const coords = GetEntityCoords(PlayerPedId(), false);
//     console.log(coords)
//     console.log(vector3(1335.2233, 4388.77, 44.342498))
//     await Delay(5000);
// })

AddStateBagChangeHandler("test", null, async (bagName:any, key: any, value: any) => {
    console.log(bagName, key, value)
})