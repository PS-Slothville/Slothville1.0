// exports
export const exp = global.exports;
export const Wave = exp['wv-lib'];
export const Access = exp['ps-accessibility'];
export const UI = exp['wave-ui'];
export const Target = exp['ox_target'];
export const Inv = exp['ox_inventory'];


export function GetEntityVector3(ped: any) {
  const coords = GetEntityCoords(ped, false)
  const array = {
    x: coords[0],
    y: coords[1],
    z: coords[2],
  };
  return array;
}

export function CoordsToVector(coords: any[]) {
  const array = {
    x: coords[0],
    y: coords[1],
    z: coords[2],
  };
  return array;
}

export function vector2(x: number, y: number) {
  const array = {x,y};
  return array;
}

export function vector3(x: number, y: number, z: number) {
  const array = {x,y,z};
  return array;
}

export function vector4(x: number, y: number, z: number, w: number) {
  const array = {x,y,z,w};
  return array;
}


export function Random(length: number) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    let counter = 0;
    while (counter < length) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
      counter += 1;
    }
    return result;
}


// Delay | await Delay(0);
export const Delay = (ms: number): Promise<void> => new Promise(resolve => setTimeout(resolve, ms));