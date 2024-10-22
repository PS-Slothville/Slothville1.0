Config = Config or {}

Config.HoldTime = 5 -- in seconds

Config.RespawnTime = 120
Config.PoliceRespawnTime = 60

Config.DefaultHospital = "Pillbox Hospital"
Config.Hospitals = {
    ['Pillbox Hospital'] = vector3(357.43, -593.36, 28.79),
    -- ['Debug Hospital'] = vector3(0.0, 0.0, 0.0),
}

Config.DeadAnim = {
    dict = "dead",
    anim = "dead_c",
}

Config.MinorAnim = {
    dict = "dead",
    anim = "dead_a",
}

Config.CarAnim = {
    dict = "random@crash_rescue@car_death@std_car",
    anim = "loop",
}

Config.InjuryList = {
    [-1569615261] = { "WEAPON_UNARMED", "Fist Marks", minor = true },
    [-100946242] = { "WEAPON_ANIMAL", "Animal Bites and Claws", minor = true },
    [148160082] = { "WEAPON_COUGAR", "Animal Bites and Claws" },
    [-1716189206] = { "WEAPON_KNIFE", "Knife Wounds", violent = true },
    [1737195953] = { "WEAPON_NIGHTSTICK", "Blunt Object (Metal)", minor = true, violent = true },
    [1317494643] = { "WEAPON_HAMMER", "Small Blunt Object (Metal)", minor = true, violent = true },
    [-1024456158] = { "WEAPON_BAT", "Large Blunt Object" },
    [1141786504] = { "WEAPON_GOLFCLUB", "Long Thing Blunt Object", minor = true, violent = true },
    [-2067956739] = { "WEAPON_CROWBAR", "Medium Size Jagged Metal Object", minor = true, violent = true },
    [453432689] = { "WEAPON_PISTOL", "Pistol Bullets", violent = true },
    [1593441988] = { "WEAPON_COMBATPISTOL", "Combat Pistol Bullets", violent = true },
    [584646201] = { "WEAPON_APPISTOL", "AP Pistol Bullets", violent = true },
    [-1716589765] = { "WEAPON_PISTOL50", "50 Cal Pistol Bullets", violent = true },
    [324215364] = { "WEAPON_MICROSMG", "Micro SMG Bullets", violent = true },
    [736523883] = { "WEAPON_SMG", "SMG Bullets", violent = true },
    [-270015777] = { "WEAPON_ASSAULTSMG", "Assault SMG Bullets", violent = true },
    [-1074790547] = { "WEAPON_ASSAULTRIFLE", "Assault Rifle Bullets", violent = true },
    [-2084633992] = { "WEAPON_CARBINERIFLE", "Carbine Rifle Bullets", violent = true },
    [-1357824103] = { "WEAPON_ADVANCEDRIFLE", "Advanced Rifle bullets", violent = true },
    [-1660422300] = { "WEAPON_MG", "Machine Gun Bullets", violent = true },
    [2144741730] = { "WEAPON_COMBATMG", "Combat MG Bullets", violent = true },
    [487013001] = { "WEAPON_PUMPSHOTGUN", "Pump Shotgun Bullets", violent = true },
    [2017895192] = { "WEAPON_SAWNOFFSHOTGUN", "Sawn Off Bullets", violent = true },
    [-494615257] = { "WEAPON_ASSAULTSHOTGUN", "Assault Shotgun Bullets", violent = true },
    [-1654528753] = { "WEAPON_BULLPUPSHOTGUN", "Bullpup Shotgun Bullets", violent = true },
    [911657153] = { "WEAPON_STUNGUN", "Stun Gun Damage", minor = true, violent = true },
    [100416529] = { "WEAPON_SNIPERRIFLE", "Sniper Rifle Wounds", violent = true },
    [205991906] = { "WEAPON_HEAVYSNIPER", "Sniper Rifle Wounds", violent = true },
    [856002082] = { "WEAPON_REMOTESNIPER", "Sniper Rifle Wounds", violent = true },
    [-1568386805] = { "WEAPON_GRENADELAUNCHER", "Explosive Damage (Grenades)", violent = true },
    [1305664598] = { "WEAPON_GRENADELAUNCHER_SMOKE", "Smoke Damage", minor = true, violent = true },
    [-1312131151] = { "WEAPON_RPG", "RPG damage", violent = true },
    [1752584910] = { "WEAPON_STINGER", "RPG damage", violent = true },
    [1119849093] = { "WEAPON_MINIGUN", "Minigun Wounds", violent = true },
    [-1813897027] = { "WEAPON_GRENADE", "Grenade Wounds", violent = true },
    [741814745] = { "WEAPON_STICKYBOMB", "Sticky Bomb Wounds", violent = true },
    [-37975472] = { "WEAPON_SMOKEGRENADE", "Smoke Damage", violent = true },
    [-1600701090] = { "WEAPON_BZGAS", "Gas Damage", violent = true },
    [615608432] = { "WEAPON_MOLOTOV", "Molotov/Accelerant Burns", violent = true },
    [101631238] = { "WEAPON_FIREEXTINGUISHER", "Fire Extenguisher Damage", minor = true },
    [883325847] = { "WEAPON_PETROLCAN", "Petrol Can Damage" },
    [1233104067] = { "WEAPON_FLARE", "Flare Damage" },
    [1223143800] = { "WEAPON_BARBED_WIRE", "Barbed Wire Damage" },
    [-10959621] = { "WEAPON_DROWNING", "Drowning" },
    [1936677264] = { "WEAPON_DROWNING_IN_VEHICLE", "Drowned in Vehicle" },
    [-1955384325] = { "WEAPON_BLEEDING", "Died to Blood Loss" },
    [-1833087301] = { "WEAPON_ELECTRIC_FENCE", "Electric Fence Wounds", minor = true },
    [539292904] = { "WEAPON_EXPLOSION", "Explosion Damage" },
    [-842959696] = { "WEAPON_FALL", "Fall / Impact Damage" },
    [910830060] = { "WEAPON_EXHAUSTION", "Died of Exhaustion", minor = true },
    [-868994466] = { "WEAPON_HIT_BY_WATER_CANNON", "Water Cannon Pelts", violent = true },
    [133987706] = { "WEAPON_RAMMED_BY_CAR", "Vehicular Accident", minor = true },
    [-1553120962] = { "WEAPON_RUN_OVER_BY_CAR", "Runover by Vehicle" },
    [341774354] = { "WEAPON_HELI_CRASH", "Heli Crash" },
    [-544306709] = { "WEAPON_FIRE", "Fire Victim" },
    [4024951519] = { "WEAPON_ASSAULTSMG", "Assault SMG", violent = true },
    [1627465347] = { "WEAPON_GUSENBERG", "Gusenberg", violent = true },
    [171789620] = { "WEAPON_COMBATPDW", "Combat PDW", violent = true },
    [984333226] = { "WEAPON_HEAVYSHOTGUN", "Heavy Shotgun", violent = true },
    [317205821] = { "WEAPON_AUTOSHOTGUN", "Autoshotgun", violent = true },
    [2640438543] = { "WEAPON_BULLPUPSHOTGUN", "Bullpup Shotgun", violent = true },
    [3800352039] = { "WEAPON_ASSAULTSHOTGUN", "Assault Shotgun", violent = true },
    [2132975508] = { "WEAPON_BULLPUPRIFLE", "Bullpup Rifle", violent = true },
    [3220176749] = { "WEAPON_ASSAULTRIFLE", "Assault Rifle", violent = true },
    [3219281620] = { "WEAPON_PISTOL_MK2", "PD Pistol", violent = true },
    [`WEAPON_BRICK`] = { "WEAPON_BRICK", "Brick", minor = true, violent = true },
    [`WEAPON_SHOE`] = { "WEAPON_SHOE", "Shoe", minor = true },
    [`WEAPON_CASH`] = { "WEAPON_CASH", "Cash", minor = true },
    [`WEAPON_PAINTBALL`] = { "WEAPON_PAINTBALL", "PaintBall Gun", minor = true },
}
