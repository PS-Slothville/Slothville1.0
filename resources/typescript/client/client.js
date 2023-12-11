/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ 883:
/***/ (function(__unused_webpack_module, exports, __webpack_require__) {


var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", ({ value: true }));
const Controllers = __importStar(__webpack_require__(50));
(async () => {
    await Controllers.Init();
})();


/***/ }),

/***/ 50:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.Init = void 0;
const utils_1 = __webpack_require__(221);
const Init = async () => { };
exports.Init = Init;
let inZone = false;
RegisterCommand("+tsTest", async () => {
    if (inZone) {
        console.log("keypressed");
        const count = utils_1.Inv.Search('count', 'vpn');
        if (count > 0) {
            utils_1.UI.Circle((s) => {
                if (s) {
                    emit('ox_lib:notify', {
                        type: 'success',
                        description: 'Successfully did something'
                    });
                }
                else {
                    ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false, false);
                }
            }, 2, 20);
        }
        else {
            emit('ox_lib:notify', {
                type: 'error',
                description: 'You don\'t have a vpn'
            });
        }
    }
}, false);
RegisterCommand("-tsTest", async () => {
}, false);
utils_1.Access.AddKeyMapping("Typescript", "+tsTest", "-tsTest", "Testing", "keyboard", 'E');
on('wv-lib:onEnter', async (self) => {
    if (self.name === "test") {
        inZone = true;
        console.log("entered");
        utils_1.Wave.showTextUI(`[${utils_1.Access.GetKeyMapping("+tsTest")}] Use`);
    }
    // Code that gets executed once the event is triggered goes here.
});
on('wv-lib:onExit', async (self) => {
    if (self.name === "test") {
        inZone = false;
        utils_1.Wave.hideTextUI();
    }
    // Code that gets executed once the event is triggered goes here.
});
utils_1.Wave.CreateSphereZone({
    coords: (0, utils_1.vector3)(-74.46841, -818.9703, 326.17083),
    radius: 0.8,
    debug: true,
    name: "test"
});
// setTick(async () => {
//     const coords = GetEntityCoords(PlayerPedId(), false);
//     console.log(coords)
//     console.log(vector3(1335.2233, 4388.77, 44.342498))
//     await Delay(5000);
// })
AddStateBagChangeHandler("test", null, async (bagName, key, value) => {
    console.log(bagName, key, value);
});


/***/ }),

/***/ 221:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.Delay = exports.Random = exports.vector4 = exports.vector3 = exports.vector2 = exports.CoordsToVector = exports.Inv = exports.Target = exports.UI = exports.Access = exports.Wave = exports.exp = void 0;
// exports
exports.exp = __webpack_require__.g.exports;
exports.Wave = exports.exp['wv-lib'];
exports.Access = exports.exp['ps-accessibility'];
exports.UI = exports.exp['wave-ui'];
exports.Target = exports.exp['ox_target'];
exports.Inv = exports.exp['ox_inventory'];
function CoordsToVector(coords) {
    const array = {
        x: coords[0],
        y: coords[1],
        z: coords[2],
    };
    return array;
}
exports.CoordsToVector = CoordsToVector;
function vector2(x, y) {
    const array = { x, y };
    return array;
}
exports.vector2 = vector2;
function vector3(x, y, z) {
    const array = { x, y, z };
    return array;
}
exports.vector3 = vector3;
function vector4(x, y, z, w) {
    const array = { x, y, z, w };
    return array;
}
exports.vector4 = vector4;
function Random(length) {
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
exports.Random = Random;
// Delay | await Delay(0);
const Delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));
exports.Delay = Delay;


/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/global */
/******/ 	(() => {
/******/ 		__webpack_require__.g = (function() {
/******/ 			if (typeof globalThis === 'object') return globalThis;
/******/ 			try {
/******/ 				return this || new Function('return this')();
/******/ 			} catch (e) {
/******/ 				if (typeof window === 'object') return window;
/******/ 			}
/******/ 		})();
/******/ 	})();
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module is referenced by other modules so it can't be inlined
/******/ 	var __webpack_exports__ = __webpack_require__(883);
/******/ 	
/******/ })()
;
//# sourceMappingURL=client.js.map