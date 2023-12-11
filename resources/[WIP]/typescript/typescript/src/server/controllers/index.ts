export const Init = async (): Promise<void> => {};

on("onResourceStart", (name: string) => {
    if(name != GetCurrentResourceName()) return;

    console.log("Starting resource...");
});

RegisterCommand("jay", async (src: number, args: any[], raw: any) => {
    GlobalState.test = "fuck"
 
}, false)